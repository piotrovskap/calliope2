---
name: das-data-sources
description: DAS data source landscape — 14 categories, 50+ sources, ingestion methods, identity keys
metadata:
  type: project
---

Full catalog: `wiki/Data-Source-Inventory.md`. Summary below.

**CRM (all batch CSV today — APIs exist but unused):**
VinSolutions, eLeads, Reynolds & Reynolds, Tekion, DriveCentric, DealerSocket
→ CSV exported manually → emailed to Analytics@3birdsmarketing.com → FTP → SSIS

**DMS (more reliable, more automated):**
CDK (3PA number → FTP, 48-72hr lag), Authenticom (FTP/SFTP), R&R DMS, DealerTrack API

**Lead providers (ADF/XML email format):**
TrueCar, Cars.com, AutoTrader, CarGurus, Edmunds, Capital One, RouteOne, GM (BAC 246435)
→ 2,500+ parsers today, being replaced by Workflow 2.0

**Advertising platforms:**
Meta/Facebook (lead forms with PII, Messenger, catalog), Google (GA4, Performance Max, GCLID), TikTok, Instagram

**Review sources (Radar product — mostly anonymous):**
Google My Business, DealerRater, Cars.com, CarGurus, Yelp, Women-Drivers.com

**Email/SMS engagement (best identity signal):**
MailGun webhook → PostgreSQL (events), Twilio (SMS), RocketChat/LiveJoin (ETS chat)
UTM convention: utm_term=c_hashkey links email clicks back to known Mautic contacts

**Internal DAS systems:**
CDXP/3Birds (marketing), Response Logix (lead response), Radar (reputation), MediaLogix (ads), LotVantage (social inventory), BestRide.com, Torpedo (SMS), LiveJoin/ETS (chat)

**App-level event sources (client direction 2026-06-12 — capture upstream of CDXP/SSIS):**
DAS Acceptor (lead response — receives CRM leads, publishes to the DAS Event Bus), Comms API (communication data), survey systems, Radar (reputation), inventory systems. DAS has an existing Event Bus (Event Grid); the CDP intake is deliberately bus-agnostic because the bus catalog/ownership is only partly known — resolved per-source at Phase-1 onboarding, not a Phase-0 blocker. CDP subscribes for raw events at the point of consumption rather than reading CDXP's already-manipulated data.

**Vehicle data:** HomeNet API, LotVantage, dealer website crawler (ElasticSearch), CDK inventory

**Valuation:** BlackBook API (equity), KBB (trade-in)

**Credit/financing (GLBA scope):** 700Credit, GreenFlagCredit, Capital One, RouteOne, DealerTrack

**How to apply:** Phase 0 Week 1-2 priority: CRM, DMS, CDXP, ADF leads, email engagement. Not just Field Catalog v1 (the initial 27) — the full source catalog is the Phase 0 deliverable.

---

## SQL Server DB sizing and growth (Phase 0, 2026-06-14)

Source: `msdb.dbo.backupset` type D, 2026-05-15 to 2026-06-14. Server: `20.51.108.231:1433`.

| Database | Size (GB) | Growth / month | Notes |
|---|---|---|---|
| Megatron | 438.57 | **+6.6 GB** | Fastest growing; `Shortener` = 257 GB (59%) |
| MegatronRepository | 91.26 | static | Read-only archive over 30-day window |
| WEB | 76.20 | static | FEEDADS/FEEDEXTRAS refreshed in-place |
| Prime | 67.48 | **+3.7 GB** | Spike 2026-05-27 (+1.6 GB bulk load) |
| RedDawn | 104.38 | **+1.9 GB** | Intraday oscillation (crawler truncate+reload) |
| Trax | 11.43 | static | `AdCapture_DailyTotal` = 0 rows — daily job not running |
| OutboundFeeds | 7.57 | static | `obf_Destination_Budgets` (15.5M rows) likely truncated/reloaded |
| petfinder | 0.04 | — | No backup history available |
| endeavorcentral | 0.04 | — | No backup history available |

**Total accessible estate:** ~896 GB. Active writers: Megatron, Prime, RedDawn.

---

## DWRPT Server (40.83.161.93) — discovered 2026-06-14

| Database | Description |
|---|---|
| DataStaging | Central read-heavy analytics and staging layer (13 schemas, 100 tables, ~335 GB) consolidating Juice/BlueSky CXP, MediaLogix, ReviewRocket/Radar, Response Logix, Dynamics 365, Zuora, Google My Business, and LotVantage; primary data source for the CDP platform and the AI assistant at ai.das-technology.com. |
| DWRPT_AI | Data warehouse / reporting replica on the same server as DataStaging (13 schemas, ~108 tables, ~335 GB, ~891 M rows); hosts the 42 AI-schema views that power the DAS BI tool and JuiceReporting analytics layer; `CDXP.JuiceReporting_BlueSkyOverview` is the richest single identity-resolution seed in the estate. |
| Feedhub | Automotive CIM (Car Inventory Management) transactional database — stores dealer inventory listings (`FeedAds`, 8 M rows) and dealer profiles (`FeedDealers`, 22.8 K rows); feeds via nightly ETL into `DataStaging.MLdata.FEEDADS/FEEDDEALERS`; direct schema access was blocked for the ConflictAI login. |
| Zuora | Subscription billing and accounts-receivable staging database (8.32 MB, ~11.6 K accounts in staging mirror); connects DAS dealer billing status to Salesforce/Dynamics 365 via `CrmId`; direct schema access blocked — documented from DataStaging ETL copies and backup metadata. |

**Permissions note:** `ConflictAI` does NOT have `VIEW SERVER STATE`. Cannot use `sys.dm_db_index_usage_stats` for activity classification. Archive heuristic: name patterns `_arch`, `_hist`, `_log`, `_bak`, `_old`, `Archive`, `History`, `Backup`, `_copy`.

---

## RL Production Server (20.65.216.199:49577) — discovered 2026-06-14

| Database | Size (GB) | Growth / month | Notes |
|---|---|---|---|
| oltp | 195.98 | **+5.8 GB** | 1.13B rows; `franchise_consumer` (51M) is the consumer identity master |
| oltp_Archive | 225.01 | +0.44 GB | 1.9B rows; historical leads/txns archived from oltp |
| DataOne | 1.26 | +0.14 GB | Access blocked; likely VIN reference data |

**Key identity tables in `oltp`:**
- `franchise_consumer` (51M) — consumer master with `crm_reference` back to dealer CRM
- `franchise_consumer_alias` (34M) — multi-email/multi-phone alias graph per consumer (most comprehensive identity expansion table in the estate)
- `franchise_consumer_vehicle` (29M) — VIN→consumer associations
- `lead` (11M) — full lead PII with lead-provider reference IDs

**Tenant linkage:** `franchise_id` (INT) is the RL tenant key. Link to DAS: `franchise → customer.AccountId` (63% populated, INT) and `customer.NewClientId` (51%, INT, range 1K–45K — possible CommonClientID). Confirmation pending with Ron Mulder.

**SQL Server 2012 Standard** — no STRING_AGG, no JSON support, no temporal tables.
