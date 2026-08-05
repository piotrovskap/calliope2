# DAS ETL Usage Analysis

**Goal:** size resources for the new CDP by reverse-engineering ETL usage from database state (no logs available).

**Data sources (4 SQL Server instances, read-only access as `ConflictAI`):**

| Alias | Host | Version | Server Name | Role |
|---|---|---|---|---|
| **ETL** | `74.179.80.27:1433` | SQL Server 2016 SP3 | `usw2-db-ml-vm-p` | Legacy DAS ETL source (Megatron / RedDawn / WEB / Prime / …) |
| **RL_PROD** | `20.65.216.199:49577` | SQL Server 2012 SP4 | `RL-PROD-SQL01` | Core OLTP — leads, transactions, franchise consumers |
| **DWRPT** | `40.83.161.93:1433` | SQL Server 2019 CU32 | `DWRPT-PRD-SQL01` | Analytics warehouse / staging — pulls from ETL + RL_PROD |
| **CIM** | `20.51.108.231:1433` | SQL Server 2022 CU9 | `CIM-PROD-SQL01` | Central inventory management — vehicle data |

**Analysis date:** 2026-06-14. All times UTC. All queries used `WITH (NOLOCK)`.

> **Note (2026-06-14):** This document was extended after the initial single-server analysis to cover all four servers. The deep-dive sections (sections 2–7) are still ETL-only — the per-server discovery for the new three is in **section 10 (cross-server overview)** at the bottom, with deep-dive follow-on work scoped there.

---

## TL;DR — sizing recommendations

| Metric | Observed | Recommended capacity for new CDP |
|---|---|---|
| Peak ingest (image queue, single table) | **721 k rows/day** = ~500 rows/min sustained; bursty | Plan for **≥1 k rows/min sustained**, **≥5 k rows/min burst** |
| Image-queue average (last 12 mo) | ~129 k rows/day | ~1.5 rows/sec steady-state |
| Listings-warehouse growth | flat (~24 M rows total) | ~5–10 k new listing rows/day |
| Search-action (SRP) aggregate | 40 k rows/day median (already daily-rolled) | ~50 k/day daily-aggregate rows |
| Peak DB concurrency | **206 distinct sessions/min** at 02:00 UTC | ~250 concurrent connections cap |
| Daily activity load (proxy) | ETL window **22:00–09:00 UTC** | All scheduled ETL must finish before 10:00 UTC |
| Backup window | ~720 backups/day (log backups every ~2 min) | New system must coexist with frequent log backups |
| File-drop ingest cadence | 97 files/day median, p99 = 134 | Sustain ~5 files/hr p99, ~6 files/hr peak |
| Storage growth (across all warehouse tables tracked) | mostly flat or declining | ~0.5–1 GB/day net growth (very rough) |

**Headline:** the ETL is **stable, not growing** — most warehouse tables show flat or slightly declining month-over-month volume. Sizing should be driven by **historical peaks**, not extrapolated growth. Two exceptions: `PhyronVideos` (new feature, +3.7 k rows/mo) and `obf_CarFax_Data` (+11.7 k rows/mo).

---

## 1. Inventory

**11 databases on the server, 9 accessible, 2 inaccessible.**

| Database | Tables | Largest table (rows) | Largest table (GB) | Notes |
|---|---:|---:|---:|---|
| Megatron | 852 | `ListingImageDownload_ReDownload` (298 M) | 113 (Shortener) | Core CRM/listings DB |
| MegatronRepository | 26 | `ListingRepository` (74 M) | 52 | Listings warehouse |
| WEB | 657 | `FEEDEXTRAS` (12 M) | — | Web feed-ingestion DB |
| Prime | 141 | `grail_srpactions_daily` (99 M) | 8 (DisplayGEO) | Analytics rollups |
| OutboundFeeds | 165 | `obf_CarFax_Data` (0.5 M) | — | Outbound integrations |
| RedDawn | 70 | `ListingImageDownload_Queue_History` (147 M) | 17 | Crawler / image queue |
| Trax | 36 | `AdCapture_MonthlyTotal` (108 M) | 4 | Ad capture |
| EndeavorCentral | 16 | — | — | App central |
| PetFinder | 24 | — | — | Niche vertical |
| **DataManager** | — | — | — | **INACCESSIBLE** — staging tables for CRM/DMS/Email ETL live here |
| **scheduler** | — | — | — | **INACCESSIBLE** — likely SSIS Catalog or scheduling metadata |

> `ConflictAI` was denied login on `DataManager` and `scheduler`. Confirmed via `HAS_DBACCESS = 0`. Most of `etl/SSIS/CRM/*.sql` writes to **prestaging tables in `DataManager`** — those flows are invisible without that grant. We measured the *output* of those ETL flows (warehouse tables in Megatron / MegatronRepository / Prime / WEB) instead.

Across the 9 accessible DBs: **1,987 user tables, 915 columns with timestamp-like names.**

Raw CSVs: `data/00_databases.csv`, `data/01_tables.csv`, `data/02_timestamp_columns.csv`.

---

## 2. ETL output volume — per-table sizing data

The 15 highest-signal ETL-output and ETL-meta tables. Sentinel dates (`1900-01-01`, year `9999`, etc.) filtered out.

| Table | Total rows | Days observed | p50 / day | p95 / day | p99 / day | Max / day | Peak date |
|---|---:|---:|---:|---:|---:|---:|---|
| **`Megatron.ListingImageDownload_ReDownload`** | 298 M | 2,798 | 99 k | 163 k | 191 k | **255 k** | 2020-12-28 |
| `RedDawn.ListingImageDownload_Queue_History` (`lid_Received`) | 147 M | 530 | 130 k | **635 k** | **684 k** | **721 k** | 2024-12-14 |
| `Prime.grail_srpactions_daily` (already daily-rolled) | 99 M | 2,674 | 40 k | 62 k | 69 k | 78 k | 2020-07-21 |
| `MegatronRepository.ListingRepository` | 24 M | 2,043 | 9 k | 28 k | 63 k | **189 k** | 2021-04-09 |
| `RedDawn.SmartVDPClicks` | 23 M | 2,124 | 11 k | 16 k | 19 k | 37 k | 2023-03-07 |
| `Prime.DisplayGEO` | 16 M | 1,706 | 4.5 k | 27 k | 31 k | 38 k | 2023-05-30 |
| `WEB.FEEDADS` | 8.0 M | 1,822 | 3.1 k | 14 k | 16 k | 45 k | 2026-06-05 |
| `Megatron.Listing` | 7.4 M | 2,237 | 1.0 k | 13 k | 15 k | 40 k | 2024-07-18 |
| `OutboundFeeds.obf_CarFax_Data` | 0.5 M | 792 | 20 | 3.8 k | 9.3 k | 13 k | 2023-10-06 |
| `WEB.FEEDEXTRAS` | 0.5 M | 1,912 | 128 | 712 | 1.7 k | 3.4 k | 2026-06-12 |
| `Megatron.PhyronVideos` | 106 k | 212 | 257 | 2.1 k | 4.0 k | 11 k | 2026-02-11 |
| **`Megatron.ActivityLog`** (meta) | 4.7 M | 354 | 13 k | 16 k | 18 k | 19 k | 2026-03-09 |
| **`Megatron.FileDetails_Log`** (meta — ETL input cadence) | 232 k | 2,660 | 97 | 108 | 134 | 297 | 2021-09-17 |
| **`Megatron.BackupLog`** (meta — backup windows) | 239 k | 340 | 718 | 806 | 838 | 927 | 2026-03-19 |

Per-day series for each are in `data/10_daily_rows__*.csv`. Charts: `charts/daily_*.png` and `charts/monthly_*.png`.

### Implications
- **Image-download queue is the single most expensive ETL pipeline.** Together, the two image-queue tables ingested **445 M rows** since they started. The peak of **721 k rows/day on 2024-12-14** is the closest thing to a "worst-case Black Friday" volume in this dataset. Build the new CDP to absorb ≥10× the median (≥1 M rows/day burst capacity).
- **`grail_srpactions_daily` is already a daily-aggregated rollup** — what looks like 99 M rows over 7.5 years is actually pre-summarized analytics. The raw underlying click-stream lives in `DataManager` (inaccessible). Plan for the *raw* volume to be 10–100× this.
- **Several warehouse tables are heavily ETL-driven but with low p50 / huge p99** (e.g. `ListingRepository`: 9 k median but 189 k peak day). The new CDP needs **bursty** throughput, not just steady-state.

---

## 3. ETL temporal shape — when is the system busy

Source: `Megatron.dbo.ActivityLog` — polled session snapshots, last 90 days.

### Hour-of-day (last 90 days, all sessions)
| Hour (UTC) | Samples |
|---|---:|
| 00 | 67,841 |
| 01 | 64,528 |
| 02 | 63,068 |
| 03 | 59,026 |
| 04 | 64,353 |
| 05 | 61,593 |
| 06 | 64,447 |
| 07 | 57,242 |
| 08 | 59,735 |
| 09 | 52,401 |
| 10 | 48,735 |
| 11 | 39,162 |
| 12 | 41,773 |
| 13 | 37,650 |
| 14 | 42,069 |
| 15 | 38,695 |
| 16 | 39,695 |
| 17 | 36,639 |
| 18 | 40,522 |
| 19 | 37,195 |
| 20 | 40,202 |
| 21 | 40,511 |
| **22** | **64,056** |
| **23** | **64,154** |

**Clear ETL window: 22:00 UTC → 09:00 UTC.** Activity drops ~40 % during the daytime (11:00–17:00 UTC).
Chart: `charts/activity_hour_of_day.png`.

### Peak concurrency, last 30 days
Distinct active sessions per minute:

| Time | Sessions |
|---|---:|
| **2026-05-17 02:00** | **206** ← peak |
| 2026-06-04 00:00 | 201 |
| 2026-05-18 01:30 | 195 |
| 2026-05-18 04:30 | 194 |
| 2026-05-16 03:45 | 191 |
| 2026-05-18 07:15 | 191 |
| 2026-06-14 02:15 | 191 |

Confirms the overnight ETL window. **The new CDP needs to handle ≥250 concurrent connections** to safely cover this peak plus 20 % headroom.

### Per-database activity intensity (last 90 days, by polled samples)
| DB | Samples | Distinct sessions | Sum CPU-time captured (min) |
|---|---:|---:|---:|
| **RedDawn** | **759 k** | 202 | **43.2 M** |
| msdb | 199 k | 188 | 6 k |
| **Megatron** | **158 k** | 206 | 28 k |
| Prime | 59 k | 158 | 26 k |
| master | 25 k | 145 | 173 |
| WEB | 14 k | 159 | 445 |
| scheduler | 7 k | 180 | 0 |
| DataManager | 4 k | 142 | 0 |
| OutboundFeeds | 293 | 68 | 0 |
| EndeavorCentral | 134 | 80 | 0 |

**`RedDawn` is the workload hotspot** (crawler + image-download queue). Sum of captured CPU-time at polling instants is a noisy metric (over-counts long-running sessions) but the relative ratio is unambiguous: **RedDawn ≫ everything else**.

> Note: `scheduler` and `DataManager` have polled activity even though `ConflictAI` cannot connect to them — the activity is from other logins (mostly `endeavor` and `SQLSERVERAGENT`).

Raw: `data/27_per_db_activity.csv`, `data/23_activity_hour_of_day.csv`, `data/24_activity_concurrency.csv`.

---

## 4. ETL execution shape — what's actually running

### Top login by activity
| Login | Samples | Distinct programs | Distinct DBs |
|---|---:|---:|---:|
| **`endeavor`** | **3.6 M** | 34 | 12 |
| `NT SERVICE\SQLSERVERAGENT` | 888 k | (many) | 15 |
| `NT Service\SQLIaaSExtensionQuery` | 102 k | 1 | 14 |
| `sa` | 37 k | 4 | 3 |
| `ConflictAI` (us) | 81 | 3 | 7 |

**`endeavor` is the app+ETL service account.** Almost all business traffic flows through it.

### Top programs (excluding pure infra)
| Program | Samples | Hosts |
|---|---:|---:|
| jTDS (Java/SQL via JDBC) | 1.52 M | 122 hosts |
| Core Microsoft SqlClient (.NET) | 1.25 M | 384 hosts |
| Core .Net SqlClient | 469 k | 61 hosts |
| Managed Backup | 388 k | 2 hosts |
| node-mssql | 37 k | 81 hosts |
| **`SQLAgent - TSQL JobStep …`** (many distinct job IDs) | varies | 1–2 hosts each |

The non-app programs (`SQLAgent - TSQL JobStep …`) are the **scheduled ETL jobs**. We identified the top 10 by sample count:

| Job ID (hex prefix) | DB | Samples (90d) | Days seen |
|---|---|---:|---:|
| `0x2D08B5459F108C…` | Megatron | 5,926 | 91 |
| `0xB993ABE7560C87…` | RedDawn | 5,891 | 91 |
| `0xC7BEB2783E3C0C…` | WEB | 4,191 | 91 |
| `0xC6694F89C4C544…` | DataManager | 4,111 | 91 |
| `0xF294EDDE467AC4…` | Megatron | 1,933 | 91 |
| `0xC15F6E1D5C4D9D…` | Megatron | 1,859 | 91 |
| `0xFB70FF8885115E…` | RedDawn | 1,547 | 91 |
| `0x99557972CB63D1…` | RedDawn | 1,360 | 91 |
| `0x8535B076B9D9FF…` | Megatron | 1,285 | 70 |
| `0x2DA1DCABF29CFC…` | Megatron | 1,220 | 91 |

> Friendly job names live in `msdb.dbo.sysjobs` — `ConflictAI` was denied SELECT there. **Ask DBA to grant `db_datareader` on `msdb` (or send the contents of `sysjobs`) so we can name these jobs.** Each top-10 job runs daily.

Across all SQL Agent jobs in the last 90 days: **1,466 distinct (program, db) entries** running. Most are short-lived (`avg_elapsed_ms = 0`) — fire frequently, finish in < 1 ms when sampled.

### Sample queries actually captured in flight
- `update ac set ac.WEbsite_Url = c.Website_URl From megatron.dbo.__AllAdEzCampaigns ac inner join ...` — campaign URL backfill
- `insert into PaidLeadDetails select ldq.ldq_ID, esr.esr_ID, esr.esr_LeadCost, esr.esr_destid, adl.acd_id ...` — lead enrichment
- `update i set i.llim_url = left(i.llim_url, (charindex('jpghttp', i.llim_url, 10) + 2)) from reddawn.dbo.ListingImageDownload ...` — image URL cleanup
- `update emo set ems_id = 9 -- XML Missing Tags from emailobjects emo with (nolock) where ems_id in (1, 3, 4)` — email object scrubbing
- `insert into _ADAccounts select o.* from _ADAccounts_Original o left join _ADAccounts d on d.ademail = o.ADEmail where ...` — AD accounts dedup-insert
- `insert into vw_StevenRatchetTrackerReport_LastReactivate select distinct v.* from vw_StevenRatchetTrackerReport_Las…` — reporting refresh
- `open LeadRetry_Cursor` — cursor-driven DataManager work

These confirm: the ETL is a mix of **SQL Agent batch jobs** (most) + **app-driven inline updates** (via jTDS / SqlClient).

Raw: `data/20_activity_top_programs.csv`, `data/21_activity_top_logins.csv`, `data/26_sql_agent_jobs.csv`, `data/28_running_by_program.csv`.

---

## 5. File-ingest cadence — the input side of ETL

`Megatron.FileDetails_Log` records every file that lands from FTP sources (e.g. `\\invftp\ftp\ViaMediaFTP\`). 232 k files over 2,660 days, **median 97 files/day, p99 134, max 297**.

Steady, predictable. The new CDP should easily handle this rate (~5–6 files/hour peak).

Sample:
```
2025-04-14 13:52:57  ViaMedia-20250414@13_V7.zip
2025-04-14 13:52:54  ViaMedia-DoNotCallList-20250414@13_V7.txt
2025-04-14 13:52:52  ViaMedia-VehiclePerformance-20250414@13_V7.txt
```

File drops cluster around the start of every hour, suggesting hourly schedules on the SFTP side.

---

## 6. Backup window — when ETL must coexist with backups

`Megatron.BackupLog` shows **~720 backup operations per day** (mostly transaction-log backups every ~2 minutes per DB, plus daily fulls).

Backups never stop. The new CDP must coexist with this constant low-level backup activity. **If new CDP adds significant read load to existing DBs, transaction-log backup latency could rise.** Consider replicas for analytics.

---

## 7. Growth projection (linear fit, last 12 full months)

Methodology: aggregate to monthly totals, fit `y = m·month + b` on the last 12 months, project +6 and +12 months.

| Table | Avg/mo (last 12) | Slope/mo | +6 mo | +12 mo | Trend |
|---|---:|---:|---:|---:|---|
| `Megatron.ListingImageDownload_ReDownload` | 2.52 M | -11 k | 2.38 M | 2.32 M | **flat** |
| `RedDawn.ListingImageDownload_Queue_History` | 3.86 M | -297 k | 146 k | 0 | declining (short window — likely seasonal, treat with caution) |
| `Prime.grail_srpactions_daily` | 949 k | -21 k | 682 k | 554 k | gently declining |
| `Megatron.Listing` | 89 k | -7 k | ~1 k | 0 | **declining** (possibly migrating off) |
| `Prime.DisplayGEO` | 18 k | -1 k | 4 k | 0 | declining |
| `RedDawn.SmartVDPClicks` | 300 k | -4 k | 244 k | 218 k | flat |
| `WEB.FEEDADS` | 124 k | +5.6 k | 194 k | 228 k | **growing** |
| `OutboundFeeds.obf_CarFax_Data` | 38 k | +12 k | 185 k | 256 k | **growing fast** (new integration ramping) |
| `Megatron.PhyronVideos` | 13 k | +3.7 k | 50 k | 72 k | **growing fast** (new feature ramping) |
| `WEB.FEEDEXTRAS` | 11 k | -1 k | 0 | 0 | declining |

Raw: `data/30_growth_projection.csv`. Charts: `charts/monthly_*.png`.

**Net read:** the legacy ETL is shrinking or flat. Only three pipelines are actively growing — `PhyronVideos`, `obf_CarFax_Data`, `FEEDADS` — and even combined they add < 0.5 GB/month. **The new CDP does NOT need to be sized for growth.** Size for current peak.

---

## 8. Risks & data-quality gotchas

- **Several timestamp columns contain sentinel dates** (`1900-01-01`, `9999-12-31`). All my window queries filtered `>= 2018-01-01` and `< 2027-01-01`. Going forward, the new CDP should enforce real datetime validation on inputs from the legacy SQL Server.
- **Some timestamp columns are all-NULL** (e.g. probed `Megatron.Shortener` — 110 M rows, 113 GB, but no usable load timestamp). For `Shortener`, the only ways to size are `MAX(id)` over time (if int identity) or external metadata. Not done here.
- **`MegatronRepository.ListingVehicleRepository` has NO datetime column** (69 M rows / 19 GB). It is likely loaded via foreign keys from `ListingRepository`. The new CDP should ensure every replicated row gets a load timestamp.
- **Backup-log polling artifact:** `BackupLog` has 718 rows/day on average. ~80 % are tlog backups for the ~9 user DBs every ~5 min = ~9·12·24 = 2,592/day, but only Megatron is counted here. The new CDP must avoid scheduling ETL inside the daily-full window (presumably midnight UTC) to avoid I/O contention.
- **Inaccessible DBs (`DataManager`, `scheduler`):** all CRM/DMS/Email staging — the largest ETL surface area by stored-proc count — lives there. **Throughput numbers above represent only the *output* of those flows.** Pre-staging throughput is likely 2–10× higher.

---

## 9. Recommended next steps (before signing off on CDP capacity)

1. **Get DBA grants:**
   - `db_datareader` on `DataManager` and `scheduler` — to measure pre-staging throughput directly
   - `SELECT` on `msdb.dbo.sysjobs`, `sysjobsteps`, `sysjobhistory` — to map Job IDs → names and get **actual job run durations** (this would be the closest thing to a real ETL execution log we could obtain)
2. **Measure the `Shortener` table by ID range** (it has 110 M rows / 113 GB but no usable timestamp). At minimum: `MIN(id) / MAX(id) / AVG(LEN(short_url))`.
3. **Confirm CDP target throughput with stakeholders:** my recommendation is **≥1 k rows/min sustained, ≥5 k burst, ≥250 concurrent connections**, but if image-download workload is being deprecated then the sizing can drop by 5×.
4. **Sample a peak-hour `ActivityLog` window** in detail (e.g. 2026-05-17 02:00 ± 30 min) to identify *what* was running during the 206-session peak — useful for sizing connection-pool layout in the new CDP.

---

## Reproducibility

All scripts live under `etl/usage-analysis/scripts/` and re-run cleanly against a populated `.env`:

```bash
cd etl/usage-analysis
python3 -m venv .venv
.venv/bin/pip install pyodbc pandas matplotlib python-dotenv
.venv/bin/python scripts/01_discover.py        # phase 1: inventory
.venv/bin/python scripts/02_probe_ranges.py    # phase 1b: date ranges
.venv/bin/python scripts/03_etl_targets.py     # phase 1c: SSIS targets
.venv/bin/python scripts/04_daily_volume.py    # phase 2: per-table volume
.venv/bin/python scripts/04b_patch_failed.py   # phase 2 patch
.venv/bin/python scripts/05_activity.py        # phase 3: ActivityLog
.venv/bin/python scripts/06_activity_deep.py   # phase 3b: per-DB/jobs
.venv/bin/python scripts/07_growth_and_charts.py  # phase 4 + 5
```

All raw query outputs are in `data/*.csv`. All charts are in `charts/*.png`. No data was written to the source SQL Server — analysis is read-only via `pyodbc` with `readonly=True`.

For the additional three servers (RL_PROD / DWRPT / CIM), per-server outputs are namespaced under `data/rl_prod/`, `data/dwrpt/`, `data/cim/`. The `scripts/multi_discover.py` and `scripts/multi_probe.py` helpers take a prefix arg matching the `.env` variable namespace (e.g. `python multi_discover.py DWRPT CIM`).

---

## 10. Cross-server overview (RL_PROD / DWRPT / CIM)

Three additional SQL Server instances were brought into scope after the initial single-server analysis. Section 1 of this report lists their connection details and roles. This section reports what was discovered.

### 10.1 Database access summary

| Server | DBs total | DBs accessible | DBs denied | Largest table | Largest table size |
|---|---:|---:|---|---|---:|
| **ETL** | 11 | 9 | `DataManager`, `scheduler` | `Megatron.ListingImageDownload_ReDownload` (298 M) | 44 GB |
| **RL_PROD** | 4 | 2 (`oltp`, `oltp_Archive`) | `DataOne`, `DBATools` | `oltp.txn` (345 M) | 12 GB |
| **DWRPT** | 4 | 1 (`DataStaging`) | `DWRPT_AI`, `Feedhub`, `Zuora` | `DataStaging.CDXP.JuiceReporting_HiddenTable_MarketingSummary` (118 M) | 48 GB |
| **CIM** | 4 | 1 (`Central Inventory`) | `ClientInventory`, `DataOne`, `Feedhub` | `Central Inventory.FHD.vehicles_removed` (40 M) | **411 GB** |

> Note: across all four servers, `ConflictAI` has **per-DB grants** rather than instance-wide read. Some DBs that we'd want for sizing (`DataManager` on ETL, `DBATools` on RL_PROD, `DWRPT_AI`/`Feedhub`/`Zuora` on DWRPT, `ClientInventory`/`DataOne`/`Feedhub` on CIM) require additional grants. Recommended ask: `db_datareader` on every business DB on every server. The auditing role does not need write privileges.

> Note: `DataOne` and `Feedhub` appear on multiple servers. Confirm whether these are independent databases or replicas before sizing.

### 10.2 RL_PROD — the core OLTP

SQL Server 2012, on port 49577 (non-standard — required `TDS_VERSION=7.0` for FreeTDS, baked into `.env`). Two accessible DBs: `oltp` (live) and `oltp_Archive` (historical).

**Top tables by row count (≥ 1 M rows shown):**

| Table | Rows | Size (GB) | Date span | Notes |
|---|---:|---:|---:|---|
| **`oltp.txn`** | **345 M** | 12 | **18.5 yr** | Core transaction table |
| `oltp_Archive.lead_history` | 342 M | 83 | 12.6 yr | Historical leads |
| `oltp_Archive.franchise_consumer_txn` | 141 M | 24 | 7.6 yr | Historical consumer transactions |
| `oltp_Archive.franchise_consumer_txn_old` | 70 M | 14 | 4.5 yr | Predecessor archive (likely deprecated) |
| `oltp.lead_history` | 67 M | 17 | **1.8 yr** | Live leads (matches DWRPT.RLData.lead_history exactly) |
| `oltp_Archive.lead` | 59 M | 64 | 17.5 yr | Historical lead detail |
| `oltp.franchise_consumer_txn` | 57 M | 8 | 4.5 yr | Live consumer transactions |
| `oltp.franchise_consumer` | 51 M | 21 | **18.0 yr** | Customer master |
| `oltp.smart_quote_vehicle` | 42 M | 3 | — | Smart-quote vehicles |
| `oltp.rl_lead_history_report_data` | 40 M | 2 | 2.5 yr | Lead-history reporting rollup |
| **`oltp.process_log_YYYYMMDDTHH`** (×11 weekly tables visible) | ~1.7 M each | — | 6–9 d each | **Actual ETL execution log — see 10.5** |

**Implications for the new CDP:**
- RL_PROD is the **source-of-truth** for leads + transactions. The new CDP must replicate this faithfully — the OLTP+Archive split (live ~2 yr, archive ~17 yr) is a working pattern worth keeping.
- The `franchise_consumer` master at 51 M rows spans 18 years — full re-ingestion is a one-time cost; incremental thereafter is bounded by `last_updated_date` (present on most large tables).
- Live `txn` table grows to **345 M without partitioning** — that's the scale the new CDP's ingestion path must handle on day one.

Raw: `data/rl_prod/00_databases.csv`, `01_tables.csv`, `02_timestamp_columns.csv`, `03_table_date_ranges.csv`.

### 10.3 DWRPT — the analytics warehouse / staging

SQL Server 2019. One accessible DB (`DataStaging`) with **100 tables, 265 timestamp-like columns**. The schema organization is informative:

| Schema | Purpose (inferred from table names) |
|---|---|
| `CDXP` | "CDP Experience" — JuiceReporting_*, mv_contact_stats, …. Customer-data-platform reporting marts. |
| `RLData` | Mirror of RL_PROD (`lead_history`, `lead`, `smart_quote`, `reactivation`) |
| `MLdata` | Mirror of Megatron / ETL warehouse (`grail_srpactions_daily`, `Listing`, `Display`, `FEEDADS`, …) |
| `core` | Cross-source staging tables (`Stage_SurveyHistory`, `Stage_Surveys`, `Stage_Txns`, `Stage_Review`) |
| `Google` | Google Vehicle / DealershipDataFile feeds |
| `LVData` | YouTube/video metadata |

**Top tables (≥ 1 M rows):**

| Table | Rows | Size (GB) | Span | Notes |
|---|---:|---:|---:|---|
| **`CDXP.JuiceReporting_HiddenTable_MarketingSummary`** | **118 M** | 48 | 2.0 yr | Largest JuiceReporting table; 161 k rows/day avg |
| `MLdata.grail_srpactions_daily` | 99 M | 4 | 7.5 yr | **Identical row count to ETL.Prime.grail_srpactions_daily** — confirms ETL → DWRPT replication |
| `core.Stage_SurveyHistory` | 83 M | 3 | 11 yr | Survey responses (CRM history) |
| `core.Stage_Surveys` | 79 M | 16 | 12 yr | Survey definitions |
| **`RLData.lead_history`** | **67 M** | 17 | 1.8 yr | **Identical row count to RL_PROD.oltp.lead_history** — confirms RL_PROD → DWRPT replication |
| `core.Stage_Txns` | 55 M | 2 | 1.5 yr | Cross-source transactions staging |
| `CDXP.JuiceReporting_Marketing_Summary` | 49 M | 12 | 2.0 yr | Marketing summary mart |
| `CDXP.JuiceReporting_LeadPerformance_LeadSourceIndex` | 25 M | 14 | 0 d | Span 0 → current-state snapshot table |
| `CDXP.JuiceReporting_CDXPTransactionsOverview` | 16 M | 6 | 3.1 yr | Transactions overview |
| `CDXP.mv_contact_stats` | 15 M | 16 | 4.6 yr | Materialized contact-stats view |
| `core.Stage_Review` | 15 M | 14 | 11 yr | Review-data staging |
| `CDXP.JuiceReporting_BlueSky_ServicePerf_V2` | 13 M | 2 | (sentinel-polluted) | Service-performance mart |
| `MLdata.FEEDADS` | 8 M | — | 6.1 yr | Mirror of WEB.FEEDADS on ETL (8.0 M vs 8.03 M — near-identical) |

**Implications:**
- DWRPT is the **integration target** — both the OLTP (`RLData`) and the legacy ETL (`MLdata`) flow into it. **This is the closest thing the company has to a working CDP today** — it just lives in a single SQL Server DB instead of a dedicated platform.
- The JuiceReporting family in `CDXP` is the **business-facing marting layer** — the new CDP must continue to serve these consumers, or migrate them.
- Several tables have sentinel-date pollution (`BirthDate`, `LastServiceDate` in `JuiceReporting_BlueSkyServicePerformance` shows 45,578-day spans → contains 1900 / 9999 sentinels). Same data-quality lesson as the ETL server: enforce date validation at ingest.

Raw: `data/dwrpt/00_databases.csv`, `01_tables.csv`, `02_timestamp_columns.csv`, `03_table_date_ranges.csv`.

### 10.4 CIM — central inventory management

SQL Server 2022. One accessible DB (`Central Inventory`) with **just 8 tables** but enormous footprint.

| Table | Rows | Size (GB) | Span |
|---|---:|---:|---:|
| **`FHD.vehicles_removed`** | **40 M** | **411 GB** | 3.6 yr (1324 d) |
| `FHD.vehicles_loc` | 2.3 M | 30 | 3.6 yr |
| `stage.FHvehicles_new` | 2.3 M | 25 | 3.6 yr |
| `stage.FHvehicles_Test` | 2.2 M | 15 | 1.8 yr |
| `stage.incoming_dealer_feeds` | 17 k | < 1 | — |
| `stage.FHvehicles` / `_Extra` / `_price_updates` | 0 | 0 | — (empty / parked) |

**`vehicles_removed` averages ~30 k removals / day over 3.6 years.** 411 GB on a single table indicates wide rows (many columns / large fields). The 8-table schema is small but heavy — sizing-wise this is **the storage hotspot of the entire ecosystem**.

**Implications:**
- A vehicle's lifecycle ends up in `vehicles_removed` — the new CDP needs an effective archival pattern matching this rate (~10 k/day live → ~30 k/day historical accumulation).
- The empty `stage.FHvehicles*` tables suggest the staging pipeline has been refactored and old staging tables left in place; verify which ones are live before migrating.

Raw: `data/cim/*.csv`.

### 10.5 Found at last: RL_PROD's actual ETL execution log

`oltp.process_log_YYYYMMDDTHH` is a **weekly-rotating** table pattern — one table per week, datestamp matches Saturday backups. Each contains ~1.7 M rows over 6–9 days = **~240 k process-log entries / day**. Visible (June 2026):

```
oltp.dbo.process_log_20260606T23  →  1,815,919 rows
oltp.dbo.process_log_20260530T23  →  1,815,153 rows
oltp.dbo.process_log_20260613T23  →  1,807,280 rows
oltp.dbo.process_log_20260502T23  →  1,780,669 rows
... (going back to ~Jan 2026)
```

This is **gold** for sizing. The next analysis step should be:
1. List all `process_log_*` tables to confirm retention window.
2. Inspect schema (likely: process_name, started_at, ended_at, status, records_in/out, error_msg).
3. Reconstruct per-process duration and per-day execution count.

Not done in this pass because it requires per-week-table iteration; flagged as **highest-value follow-up**.

### 10.6 Updated sizing recommendations (factoring in all four servers)

| Dimension | Updated recommendation |
|---|---|
| Peak ingest (single table, observed) | **721 k rows/day** on `RedDawn.ListingImageDownload_Queue_History`; unchanged |
| Peak ingest (across all source systems, current production combined) | **rough estimate: ~1.5–2 M rows/day** combining all four servers' daily-active tables. Confirm via process_log mining. |
| Live OLTP transaction rate | `oltp.txn` grew to 345 M over 18.5 yr → **~50 k txn/day average**, presumably 100 k+/day at recent peaks |
| Total managed footprint (current) | **~700 GB across the four servers' top tables**; CIM dominates with `vehicles_removed` at 411 GB alone |
| Active source DBs the CDP must read | At least **4 servers × ~3 DBs each = 12 DBs**, plus future SaaS sources |
| Replication lag tolerance | Existing RL_PROD → DWRPT pattern: row counts on `lead_history` match exactly (67 M = 67 M) → near-zero lag tolerated today. Match this. |

### 10.7 New questions raised by the multi-server view

1. **Where is `Feedhub`?** It appears (as inaccessible) on both DWRPT and CIM. Same database replicated? Different databases sharing a name? This affects whether the new CDP needs one or two ingest connectors.
2. **Where is `DataOne`?** Appears (inaccessible) on RL_PROD and CIM. Likely a shared reference DB; access would clarify what dimension tables the CDP needs to mirror.
3. **DWRPT's `CDXP` schema is named like a CDP** — is it already considered "the CDP" by some teams? Naming clarity needed before the new system is positioned.
4. **`process_log_*` retention** — visible tables span ~10 weeks (Apr 4 → Jun 13). Does anything older get archived, or is it deleted? Affects how far back we can mine historical ETL behavior.
5. **No process_log_* on the ETL server** — RL_PROD's ETL leaves a log; the ETL server's ETL does not. Was logging removed, or is it stored in `DataManager` (which we can't access)?

These should be answered before finalizing CDP architecture.

---

## 11. RL_PROD ETL execution log — deep mine of `process_log_*`

This is the analysis flagged as "highest-value follow-up" in section 10.5 — the **actual ETL execution log** for the RL platform. Mined across all 12 visible tables (1 live + 11 weekly archives).

**Coverage:** 2026-03-24 → 2026-06-14 = **82 days**, **19.86 M log entries**, **318 k exceptions (1.60 % error rate)**. ~10 weeks of retention; older weeks appear to be dropped.

**Schema:** `(process_log_id, created_date, type, server, component, subject, message_text, message_xml, txn_id_1..5, retain_until_date)`. The `message_text` contains a `Completed: HH:MM:SS.fff` token for finished operations — parseable for per-process duration distribution if needed.

### 11.1 Architecture revealed

This is **NOT** an overnight-batch SSIS pipeline like the ETL server. It is a **message-queue-driven, cron-scheduled, polling architecture** with multiple producers:

- **Cron-style schedulers** (component names): `execute_every_1_min`, `execute_every_10_mins`, `execute_every_15_mins_process`, `execute_every_60_mins_process`, `execute_at_0300`, `execute_at_2300`
- **Azure Service Bus pollers** (subject names): `LeadHistoryCreateMsgFromAzure.ps1`, `SmartQuoteStatus.ps1`, `FranchiseRegionUpdateMsgFromAzure.ps1`, `EnqueueMessageToAzureQueue.ps1`, and several `*MsgFromAzure.ps1` variants running on **`SANDBOXHOST-639`** (Windows VM)
- **In-database orchestration** (component names): `lead_create_process`, `lead_consolidate_process_2`, `franchise_rep_update_pending_process_2`, `initiate_campaign_status_process`, `franchise_consumer_franchise_rep_upsert` — these are SQL Server stored procedures triggered by the cron components

> **Implication for the new CDP:** the existing RL system has already moved past SSIS. The new CDP architecture must coexist with — or replace — an Azure-Service-Bus + polling pattern. This is closer to a modern event-driven architecture than the legacy DAS ETL is.

### 11.2 Daily volume + error rate

- **avg 242 k events/day** (Log + Exception combined)
- **max 289 k events/day** on 2026-05-08
- **error rate 1.60 % overall** — large variance per process (see §11.5)
- 82 days of data; no obvious week-day vs weekend dip → ETL runs 24/7

Chart: `charts/rl_prod/01_daily_volume.png` (stacked Log + Exception bars).

### 11.3 Hour-of-day shape (UTC)

| Hour | Total events | Exceptions |
|---:|---:|---:|
| 00 | 418 k | 1.3 k |
| 01 | 386 k | 2.1 k |
| 02 | 442 k | 2.1 k |
| 03 | 526 k | 1.4 k |
| 04 | 511 k | 2.4 k |
| **05** | **1.35 M** | **24 k** |
| **06** | **1.64 M ← peak** | **41 k** |
| **07** | **1.36 M** | **42 k** |
| 08 | 1.25 M | 31 k |
| 09 | 1.10 M | 23 k |
| 10 | 1.05 M | 19 k |
| 11 | 911 k | 19 k |
| 12 | 897 k | 17 k |
| 13 | 883 k | 16 k |
| 14 | 920 k | 14 k |
| 15 | 868 k | 13 k |
| 16 | 830 k | 15 k |
| 17 | 777 k | 8 k |
| 18 | 770 k | 6 k |
| 19 | 733 k | 5 k |
| 20 | 662 k | 4 k |
| 21 | 641 k | 4 k |
| 22 | 474 k | 6 k |
| 23 | 457 k | 2 k |

**Peak window: 05:00–10:00 UTC** (5.4 M events = 27 % of all activity in just 5 hours). 06:00 UTC alone = **1.64 M events/hr = 27 k/min = 455 events/sec sustained**. This is the **opposite** shape of the ETL server (which peaks 22:00–09:00 UTC) — RL_PROD's ETL fires hardest mid-morning US.

Both error count *and* total event count peak at 06:00–07:00 UTC. Errors are correlated with load — possibly retry storms or upstream backlog draining.

Chart: `charts/rl_prod/02_hour_of_day.png`.

### 11.4 Per-server distribution

| Server | Events | Exceptions | Days | First → Last |
|---|---:|---:|---:|---|
| **`RL-PROD-SQL01`** | **14.7 M** | 312 k | 81 | 03-26 → 06-14 |
| **`SANDBOXHOST-639`** | **4.95 M** | 952 | 79 | 03-26 → 06-14 |
| `D16-GV0P6G4` | 184 k | 4.0 k | 4 | 04-26 → 04-29 (transient) |
| `D16-1W0P6G4` | 12 k | 64 | 1 | 04-26 (transient) |
| `(empty)` | 1.1 k | 385 | 80 | (entries with no server set) |
| 12 other dev-machine hostnames (`dw0sdwk*`, `dw1sdwk*`, `DW1SDWK*`) | < 500 each | 100% exceptions | varies | **Dev laptops leaking into prod logs — clean up** |

**Two real production sources:**
- `RL-PROD-SQL01` itself — the SQL Server fires its own log entries (T-SQL based ETL)
- `SANDBOXHOST-639` — a Windows VM running PowerShell scripts from `C:\Script\`

Chart: `charts/rl_prod/05_servers.png`.

### 11.5 Top processes (subjects) by volume

| Component | Subject | Total | Exceptions | Days active |
|---|---|---:|---:|---:|
| `lead_create_proces` | `lead_create log` | 4.40 M | 0 | 81 |
| `RLScriptService` | `ExportConfigBlob.ps1` | 3.06 M | 1 | 81 |
| `lead_consolidate_proces` | `Path` | 2.70 M | 0 | 81 |
| `initiate_campaign_status_process` | `Completed` marker | 1.01 M | 0 | 81 |
| `lead_consolidate_proces` | `txn_paload value` | 679 k | 0 | 81 |
| `smart_quote_lead_status_upsert` | `Status Updated` | 551 k | 0 | 81 |
| `franchise_rep_update_pending_process_2` | `sqnp2 test` | 551 k | 0 | 81 |
| `franchise_rep_update_pending_process_2` | `smart_quote_new_process_2 called` | 289 k | 0 | 81 |
| `franchise_rep_update_pending_process_2` | `smart_quote_used_process_2 called` | 262 k | 0 | 81 |
| `franchise_consumer_…upsert` | `CRM AR/Generic Updating Contact` | 235 k | 0 | 81 |
| `RLScriptService` | `EnqueueMessageToAzureQueue.ps1` | 235 k | 610 | 81 |
| `execute_every_1_min` | `Process Azure LeadHistory Queue` | 229 k | 0 | 81 |
| `RLScriptService` | `LeadHistoryCreateMsgFromAzure.ps1` | 126 k | 35 | 81 |
| `RLScriptService` | `FranchiseVehiclePricingUpdateMsgFromAzure.ps1` | 115 k | 32 | 81 |
| `RLScriptService` | `FranchiseVehicleQuoteUpdateMsgFromAzure.ps1` | 115 k | 30 | 81 |

> The `*MsgFromAzure.ps1` scripts all show **exactly 114,673** events over 81 days = **1,415 / day = 1 / minute**. That's the polling cadence. The new CDP should match or improve on this.

Chart: `charts/rl_prod/04_top_subjects.png`.

### 11.6 Concerning error patterns

Several components run at **100 % error rate**, meaning every entry is an Exception. Either:
- the process only logs *failed* outcomes (so 100 % is by design, and we have no insight into successes), or
- the process is genuinely broken

| Component | Total events | Exception rate |
|---|---:|---:|
| `franchise_rep_upsert` | 128,752 | **100.0 %** |
| `franchise_consumer_subscription_queue` | 1,372 | **100.0 %** |
| `franchise_consumer_franchise_rep_upsert` | 299,421 | **21.5 %** |
| `lead_create_process` (entire component) | 4.51 M | 2.5 % |
| `execute_every_60_mins_quick_process` | 9,110 | 0.9 % |
| `franchise_consumer_subscription_upsert` | 10,339 | 0.0 % |

**The 100 % rate on `franchise_rep_upsert` deserves a stand-alone investigation** — even if "only logs failures by design", that means 128 k failures in 82 days = ~1,570 / day = ~1 / minute. The new CDP should not inherit this without understanding.

### 11.7 Top busy-minute bursts (peak rates the new CDP must absorb)

| When (UTC) | Events in 1 min |
|---|---:|
| 2026-04-22 11:58 | **4,790** ← peak |
| 2026-04-22 11:57 | 4,737 |
| 2026-04-15 03:11 | 3,087 |
| 2026-05-26 10:58 | 3,035 |
| 2026-05-08 03:11 | 3,012 |
| 2026-05-27 03:11 | 2,717 |
| 2026-05-08 03:12 | 2,468 |
| 2026-04-09 14:20 | 2,146 |

The 2026-04-22 11:57–11:58 pair (9.5 k events in 2 minutes) is the worst burst seen. **80 events/sec sustained for 2 minutes.** Multiple of the other top minutes cluster around **03:11–03:12 UTC** → likely a scheduled job firing simultaneously across many tenants.

### 11.8 Sizing implications (RL_PROD-specific)

| Metric | Observed | Recommended new-CDP capacity |
|---|---|---|
| Average event rate | 242 k / day = ~3 / sec | ~10 / sec steady-state |
| Peak hour | 1.64 M / hr = 455 / sec | **≥ 1,000 events / sec** burst |
| Peak minute | 4.79 k / min = 80 / sec | **≥ 500 events / sec** for short bursts |
| Producer servers | 2 prod + 13 leaking dev | clean up + plan for 2-5 prod sources |
| Polling cadence | 1-min, 10-min, 15-min, 60-min, daily | new CDP should support same cadence |
| Error log retention | ~10 weeks rotating | new CDP should target ≥ 90-day retention |

### 11.9 Per-process duration distribution (parsed from `message_text`)

`RLScriptService` writes `Completed: HH:MM:SS.fff …` as its message body whenever a script finishes. **24 %** of all log rows match this prefix (4.8 M of 19.86 M); the remaining 76 % are state-transition messages from cron components. Parsing the timestamp gives per-process duration. Percentiles are interpolated from log-scale histograms because `oltp` is in SQL Server 2005 compatibility mode (level 90) and `PERCENTILE_CONT` was rejected — accuracy is ±5 %.

#### Headline numbers

| Subject | n (82 d) | p50 | p95 | p99 | Notes |
|---|---:|---:|---:|---:|---|
| `ExportConfigBlob.ps1` | 3.06 M | **40 ms** | 1.1 s | 5.4 s | Hot path — runs ~37 k/day; fast |
| `EnqueueMessageToAzureQueue.ps1` | 234 k | 15.0 s | 55.1 s | **97.8 s** | Outbound to Service Bus |
| `LeadHistoryCreateMsgFromAzure.ps1` | 126 k | 13.7 s | 52.7 s | **94.4 s** | Lead history ingest |
| `CustomerRapidTouchUpdateMsgFromAzure.ps1` | 115 k | 16.2 s | 54.4 s | **91.1 s** | |
| `SmartQuoteNewFranchiseUpdateMsgFromAzure.ps1` | 115 k | 15.7 s | 54.4 s | **92.3 s** | |
| `FranchiseVehicleQuoteUpdateMsgFromAzure.ps1` | 115 k | 12.3 s | 50.7 s | **87.2 s** | |
| `FranchiseConsumerMgmtUpdateMsgFromAzure.ps1` | 115 k | 15.5 s | 51.9 s | **83.8 s** | |
| `FranchisePixelTrackingUpdateMsgFromAzure.ps1` | 115 k | 14.8 s | 53.7 s | **90.9 s** | |
| `FranchiseRegionUpdateMsgFromAzure.ps1` | 115 k | 16.9 s | 54.9 s | **92.6 s** | |
| `FranchiseVehiclePricingUpdateMsgFromAzure.ps1` | 115 k | 13.8 s | 53.0 s | **91.8 s** | |
| **`SmartQuoteStatus.ps1`** | 115 k | **26.9 s** | **116 s** | **244 s** | Long tail — investigate |
| `FranchiseInventoryPricingUpdateMsgFromAzure.ps1` | 115 k | 17.8 s | 54.9 s | **91.9 s** | |
| `CRMAutoResponseMsgFromAzure.ps1` | 115 k | 17.2 s | 54.5 s | **90.3 s** | |
| `NDRLogMsgFromAzure.ps1` | 115 k | 16.9 s | 53.9 s | **88.1 s** | |
| `SendEmailsFromQueue.ps1` | 115 k | 11.1 s | 46.0 s | **76.3 s** | |
| `MailboxMsgFromAzure.ps1` | 115 k | 18.1 s | 54.5 s | **93.5 s** | |
| **`FranchiseVehicleExport.ps1`** | 12 k | **91 s** | **437 s** | **712 s** | Heavy batch export (~12 min p99) |
| **`RetryTxnAuto.ps1`** | 11 k | **105 s** | **277 s** | **420 s** | Retry storms (~7 min p99) |
| **`CustomerInventoryCalculatedUpdateFromAzure.ps1`** | 11 k | **22 s** | **1250 s** | **1674 s** | **Extreme bimodal — p99 = 28 minutes** |
| `FranchiseConsumerExport.ps1` | 11 k | 41 s | 112 s | 221 s | |

(Full table with 30 subjects + per-bucket histograms in `data/rl_prod/51_durations_percentiles.csv`.)

#### The polling-vs-duration mismatch

The `*MsgFromAzure.ps1` pollers run **once per minute** (114,673 events / 81 days = exactly 1,415/day = 1/min — confirmed in §11.5). But:

- **p50 duration: 12–18 seconds** — most polls run well under the interval
- **p95 duration: 45–55 seconds** — many polls take almost the full minute
- **p99 duration: 80–100 seconds (~50 % above the interval)** — 1 % of polls overlap the next scheduled tick

This means the queue has **measurable backpressure at p99**. Either the next poll starts late (queue depth grows) or a parallel worker handles the overlap. The new CDP must explicitly handle this:

- **Option A:** decouple poll interval from job duration with a proper job queue (a worker pulls; the scheduler just enqueues).
- **Option B:** keep cron-like scheduling but use shorter polling and faster jobs (sub-second p99).

#### Pathological tails — investigation queue

Three processes have p99 latencies that suggest serious work outliers:

1. **`CustomerInventoryCalculatedUpdateFromAzure.ps1` — p99 = 28 minutes (max = 4,147 s = 69 min).** Avg is 125 s. This is **extreme bimodality**: most runs are fast, but the slow tail is catastrophic. Probably caused by full-inventory recompute when a "trigger" event lands vs. incremental updates otherwise. New CDP should split this into two pipelines: hot/incremental + cold/full-rebuild.
2. **`FranchiseVehicleExport.ps1` — p99 = 12 minutes (max = 911 s = 15 min).** Avg 127 s. Bulk export job. Could be runtime-optimized via partial export or streaming.
3. **`RetryTxnAuto.ps1` — p99 = 7 minutes (max = 5,105 s = 85 min).** Retry-bus draining. New CDP should bound retry budgets to prevent multi-hour drains.

#### Sizing implications (duration-aware)

Combined with §11.8's event-rate sizing, the new CDP must support:

- **p99 individual job duration up to 5 minutes** for "normal" hot path, **up to 30 minutes** for batch/export paths
- **Concurrent worker capacity:** ~17 `*MsgFromAzure` pollers × 60 s p99 / 60 s interval = ~17 simultaneous slow workers expected during overlap minutes — round up to **~30 concurrent worker slots** for headroom
- **Timeout policy:** kill jobs > 30 minutes (current behavior allows 85-minute outliers)

### 11.10 End-to-end latency: `process_log.txn_id_1` ⋈ `oltp.txn`

`oltp.txn` is a minimal 2-column event log — `(txn_id uniqueidentifier, created_date datetime)` — capturing every txn GUID ever generated and when it first appeared. `process_log.txn_id_1` carries the same GUID for ~5 M rows (24 % of the log). Joining the two gives the **time between `txn.created_date` and `process_log.created_date`** per (component, subject) — the closest thing to a real SLO baseline the existing system has.

**Coverage:** 12.5 M matched rows across the 82-day window. 7,475 negative deltas (log row precedes the txn row — usually pre-tx workflow events) and 5,316 deltas > 30 days (catastrophic-reprocessing outliers) were excluded from the percentiles.

#### Two distinct distribution shapes

**(A) Reprocessing components** — process the same txn repeatedly over its lifetime. The p50 is the **first-touch latency**, the tail is the **age of the txn at reprocessing time** (NOT pure latency).

| Component | Matched | p50 (first-touch) | p95 (age at retouch) | p99 |
|---|---:|---:|---:|---:|
| `lead_create_process` | 4.42 M | **35 s** | 2.1 d | 5.5 d |
| `lead_consolidate_process_2` | 3.40 M | **38 s** | 3.2 d | 6.0 d |
| `franchise_rep_update_pending_process_2` | 1.22 M | **49 s** | 3.5 d | 6.1 d |
| `initiate_campaign_status_process` | 1.01 M | **39 s** | 2.3 d | 5.6 d |
| `smart_quote_lead_status_upsert` | 551 k | **230 s** | 3.8 d | 6.2 d |

> **Takeaway:** the hot-path arrival → first downstream stage takes ~35–50 seconds (p50) for the four highest-volume pipelines. The same txn typically gets touched again during a ~7-day reprocessing window — visible as the long tail.

**(B) One-shot / bounded-tail components** — produce a single (or small-N) log entry per txn. The p99 here is a **real SLO target**.

| Component:Subject | Matched | p50 | p95 | **p99** |
|---|---:|---:|---:|---:|
| `lead_match_process` | 4 | 48 s | 217 s | **281 s (4.7 min)** |
| `franchise_consumer_smart_follow_txn_upsert` | 7 | 39 s | 171 s | **268 s** |
| `InitiateCampaign` | 657 | 38 s | 207 s | **287 s** |
| `franchise_consumer_alias_process` | 125 | 34 s | 105 s | **941 s (15.7 min)** |
| `ParseHTTP` | 4 | 134 s | 277 s | **295 s** |
| `InitiateCampaign, Version=1.0.0.0, …` | 511 | 885 s (15 min) | 3,178 s (53 min) | **8,844 s (2.5 hr)** |
| `QuoteVehicleSelection` | 368 | 35 s | 6.6 d | (reprocessing) |
| `franchise_consumer_franchise_rep_upsert` | 13.8 k | 900 s (15 min) | 3,268 s (54 min) | **17,572 s (4.9 hr)** |

> **Takeaway:** for the cleanest SLO-candidate processes, **the new CDP needs to match ~290-second (~5 minute) p99 for typical one-shot ingest paths and ~17,500-second (~5 hour) p99 for the heaviest single-shot operations**. The two `InitiateCampaign` variants having very different tails (287 s un-versioned vs 8,844 s versioned) suggests two distinct code paths still in production — worth investigating which is canonical.

Charts:
- `charts/rl_prod/06_e2e_latency_per_component.png` — per-component p50 / p95 / p99 bars (log scale)
- `charts/rl_prod/07_e2e_top_p99.png` — slowest 15 by p99
- `charts/rl_prod/08_e2e_top_p50.png` — slowest 15 by p50

#### What the join CAN'T tell us

- **`RLScriptService` is excluded** — its `txn_id_1` is the Azure message ID, never an `oltp.txn` GUID (0 / 100 sample match). The script-side durations from §11.9 are still the best per-Azure-script SLO numbers.
- **`txn_id_2..5` were not used** — the cross-entity correlations they encode (lead_id, consumer_id, etc.) would require joining against multiple OLTP tables to derive lifecycle latencies. Deferred.
- The negative deltas (log row precedes the txn row) are workflow-engine artifacts and shouldn't be reported as SLO.

#### Sizing implications (SLO-aware)

| Metric | Observed in RL Production | Recommended for new CDP |
|---|---|---|
| Hot-path first-touch p50 | 35–50 s | **≤ 30 s p50** for ingest→first-stage |
| One-shot p99 (clean components) | ~290 s | **≤ 5 min p99** for single-step pipelines |
| One-shot p99 (heavy components, e.g. franchise upsert) | ~17,500 s (4.9 hr) | **≤ 1 hr p99** is a 5× improvement worth targeting |
| Reprocessing window | ~7 days | Preserve — the lead workflow demonstrably needs multi-day reprocessing tolerance |
| Worst tail anywhere | `reactivate_consumer_process` p99 = 28.9 days | Almost certainly a bug; hard cap at 24 hours |

### 11.11 Recommended follow-ups specific to process_log

1. **Investigate the 100 % error-rate components** (`franchise_rep_upsert`, `franchise_consumer_subscription_queue`) before considering them in CDP scope.
2. **Clean up dev-machine logging into prod** — `D16-*`, `dw*` hostnames are leaking developer laptops into the production log. Either by intent (during deploys) or by misconfiguration. Easy fix; affects monitoring noise.
3. **Capture older history before it's lost** — process_log retention is ~10 weeks rotating. If month-over-month trending is interesting, snapshot the weekly tables now before they roll off.
4. **Decompose `CustomerInventoryCalculatedUpdateFromAzure.ps1`** — the 28-minute p99 dominates worst-case latency. Split hot/cold paths.
5. **Resolve the `InitiateCampaign` vs `InitiateCampaign, Version=1.0.0.0, …` split** — 30× p99 difference between the two suggests two different code paths still active.
6. **Cross-join `txn_id_2..5` with other OLTP tables** (lead, franchise_consumer, smart_quote) to measure entity-lifecycle latencies — deferred from this pass.

