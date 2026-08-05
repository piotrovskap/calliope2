---
name: das-open-questions
description: Unresolved questions for Phase 0/1 — reconciled 2026-06-21 (resolved + legacy-infra-out-of-scope items moved to Historical/Closed so open status no longer drifts)
metadata:
  type: project
---

Reconciled 2026-06-21. Items that were already answered (their text said CLOSED/ANSWERED but they still sat in an "Active" section) and questions about **legacy DAS infrastructure being replaced** (legacy ID mappings, oltp internals, legacy ETL ownership/access) have been moved to "Historical / Closed" below with an attributed closer. Rationale (Leo): the CDP is a ground-up build with its own deterministic Common Client ID (Option A, locked 2026-06-17); DAS's legacy IDs / ETL / oltp internals are at most migration-or-backfill signals, never the foundation — they resolve at migration time if ever, and do not block Phase-0 architecture. Further refined 2026-06-21: the external source-availability asks (CRM APIs, Authenticom, Comms API, etc.) are deferred to Phase 1 ingestion (per-source onboarding, not Phase-0 blockers), and the event-catalog / Event-Grid-ownership question is answered by the canonical-schema-and-transform stance (bus-agnostic intake defines its own message shape and normalizes any source into it). Q16 (Phase-1 readiness / success criteria) is now **ANSWERED** (2026-06-21, Leo) — the readiness criteria are detailed across the objectives and the locked decisions; see Active Design Questions below. No open Phase-0 items remain.

Earlier context: the broad access-request phase closed 2026-06-12 (see decisions.md "Decided 2026-06-12") — no blanket grants are being chased. The 2026-06-14 server discovery surfaced specific DB-level access blocks (Feedhub, Zuora, DataOne, EDW_Staging / CIM / ML Production / CommonClientID); these are parked as not-actionable (see "Parked" below), not active asks. One exception under review: whether Feedhub's CDP value justifies re-opening a targeted DBA grant.

## Active Asks

No open Phase-0 asks. The external source-availability questions — which CRM APIs vs CSV (VinSolutions / eLeads / Tekion), Authenticom direct-tap, Comms API contents, `Analytics@3birdsmarketing.com` reliability, app-repo read access, and the Feedhub re-open — are **deferred to Phase 1 ingestion** (per-source onboarding discovery, resolved as each source is integrated; not Phase-0 scoping blockers). See "Deferred — Phase 1 ingestion" under Parked below.

## Active Design Questions

Open questions we own (Conflict-side design / discovery), not asks to DAS.

No open design questions. (Q16 — Phase-1 readiness — answered; see Answered / Discovered below.)

## Answered / Discovered

- Q16 — Phase-1 readiness / what "good enough to proceed to Phase 1" looks like — ANSWERED 2026-06-21 (Leo): the readiness criteria are detailed. "Good enough" = (1) proof the golden record is achievable from DAS's real data — the golden-record v1.0 (architect-blessed by Alicia + Luis, 2026-06-21) on top of the locked identity strategy (Option A, deterministic-first, 2026-06-17); (2) field-catalog v1 locked (14 valuable-now fields, Alicia 2026-06-19) defining the Phase-1 build target; (3) the CDP document deliverables before July 4 (Scoping, Revised Architecture, Roadmap); (4) the system being "good for AI and for regular application lifecycle/agentic events" (Mike) — the dual REST+GraphQL surface, bus-agnostic intake, AI-context schema; (5) Phase-1 scope settled — tiered data-lifecycle (`specs/03-phase-1-build/03-backend-data-model/11-tiered-data-lifecycle.md`), privacy/erasure (PII vault, `08-pii-vault-erasure`), policy-config layer (`18-policy-config-layer`). Earlier: partially answered at the 2026-06-12 sync; the locks since close the remainder.
- Event catalog / Event Grid topic ownership — ANSWERED 2026-06-21 (Leo): not a dependency on DAS handing us their event catalog. The CDP defines its own canonical event message schema (the standard message shape) and ingests/transforms any source's events into it via the bus-agnostic adapter — already specced (CloudEvents contract: `specs/03-phase-1-build/04-ingest/10-cloudevents-contract.md` + `16-versioned-event-contract.md`). Residual is build-time: design a good canonical schema + per-source transforms. Which DAS apps publish today and topic ownership become per-source adapter config during Phase 1 ingestion (source registry), not an open Phase-0 question.
- Volume of ambiguous identity matches — ANSWERED 2026-06-17 (Alicia + Luis identity strategy, Option A): queue capacity sized after measurement, not upfront. Phase 1 ships with manual operator SLAs + configurable thresholds; 2-4 weeks of measurement (queue arrival rate, decision time per item, outcome distribution) sets thresholds and headcount. Pre-launch order-of-magnitude prior: extrapolate from Luis's table-growth stats + 2026-06-14 backup-history growth analysis (Megatron +6.62 GB/mo, Prime +3.7, RedDawn +1.9, etc.) — not the operational number. Phase 2 ML fills the queue with confidence-scored recommendations (operators confirm, not decide), projected 3-5× absorption at same headcount. See `wiki/Identity-Resolution.md` "Queue Volume & Operator Capacity" + `memory/decisions.md` "Identity strategy 2026-06-17".

**API usage walkthrough** — resolved 2026-06-18: walked through each API with DAS engineering. Business purpose and actively-used endpoints documented per API; CDP field coverage targets (launch vs. later) established. See individual API wiki pages.

**Juicebox replacement** — resolved 2026-06-14: Apache Superset (headless/embedded engine), Metabase Pro optional; alternatives documented. See `memory/decisions.md` and the Reporting Strategy artifact.

**Answered 2026-06-08/09:**
- Who manages JuiceReporting/DWRPT tables? — Ron Mulder (shown full DWRPT schema).
- SSIS → what's next? — AWS Glue evaluated and rejected; Airflow confirmed as replacement path.
- Does DAS have AI tooling? — Yes, live at ai.das-technology.com. Multiple agents querying DWRPT.
- Which SSIS jobs produce raw vs. manipulated data? — 5 of 13 mapped from etl/ stored procedures (CRM, CVH, DMS, Email, BlueSky); full ETL object catalog in docs/etl-data-inventory.md (231 objects / 20 modules). Remaining 8 jobs are in the closed Rick ask (Historical/Closed).
- Which 8 jobs lack code/descriptions? — identified by the SSIS job catalog (analysis/artifacts/ssis-job-catalog-v2/).

**Answered / discovered 2026-06-14 (Phase 0 DB discovery):**
- Can we calculate growth from `Tables_Sizes`? — No. The table in Megatron is a one-time catalog snapshot (724 rows, object create/modify dates 2011–2017), not a time series. The two date columns are `sys.objects.create_date` and `modify_date`, not snapshot timestamps.
- Is backup history available for growth analysis? — Yes. `msdb.dbo.backupset` has ~30 days of full-backup (type D) size history for all 7 accessible DBs. Results: Megatron +6.62 GB/month, Prime +3.7 GB/month, RedDawn +1.9 GB/month, WEB/Trax/OutboundFeeds/MegatronRepository flat. See Growth sections in each DB doc.
- Does ConflictAI have `VIEW SERVER STATE`? — No. `sys.dm_db_index_usage_stats` (active vs. archive classification) is unavailable. Activity classification must rely on name-pattern heuristics (`_arch`, `_hist`, `_log`, `_bak`, `Archive`, `History`, etc.).
- Is `AdCapture_DailyTotal` in Trax active? — No. 0 rows. The daily aggregation job is not running. `AdCapture_MonthlyTotal` (108M rows) is populated but daily granularity is missing — gap for CDP engagement metrics.
- Does RedDawn oscillate intraday? — Yes. Backup sizes vary ±0.5–1.5 GB within a single day, consistent with heavy truncate-and-reload on crawler tables. Net trend is +1.9 GB/month.
- Prime bulk-load spike — On 2026-05-27, Prime grew ~1.6 GB in a single day. Likely a one-time bulk import (partition switch or INSERT from staging). Steady-state growth rate is ~0.07 GB/day without the spike.

**Answered / discovered 2026-06-14 (DWRPT server full discovery):**
- DWRPT server (40.83.161.93) confirmed accessible via `ConflictAI` login (credentials in `.env` as `DWRPT_MSSQL_*`, port 1433).
- DWRPT contains 4 databases — not one: **DataStaging**, **DWRPT_AI**, **Feedhub**, **Zuora**.
- **DataStaging** (13 schemas, 100 tables, ~335 GB) and **DWRPT_AI** (13 schemas, ~108 tables, ~335 GB) are fully documented. Both are read-heavy analytics replicas with near-identical schema structures — likely staging vs. reporting environments fed by the same ETL pipelines.
- `CDXP.JuiceReporting_BlueSkyOverview` (13.3M rows) confirmed as best single-table identity resolution seed: `ContactID + EDW_DMS_Customer_ID + RecipientID + CRMID + email + phone` on one row.
- CommonClientID type mismatches confirmed in both databases: `radar.clientConfigurations` (TEXT), `MLdata.ML_Account_Info` (VARCHAR 50), `zuora.AccountStage.ClientID` (VARCHAR 50) — all require explicit CAST to INT.
- 43 SQL Agent jobs documented in `msdb` — full ETL schedule captured in each DB doc.
- AI schema (42 views in `DataStaging`) confirmed as the query layer for `ai.das-technology.com`.
- `DASID` → `CommonClientID` mapping table does NOT exist in DWRPT — gap for Google My Business data.
- No cross-schema FK constraints found in DWRPT; `CommonClientID` is the de-facto join key but not enforced.

**Answered / discovered 2026-06-14 (RL Production server discovery):**
- RL Production server (20.65.216.199:49577) accessible via `ConflictAI` (SQL Server 2012 Standard).
- `oltp` (240 tables, 1.13B rows, 196 GB) and `oltp_Archive` (9 tables, 1.9B rows, 225 GB) fully documented.
- `franchise_consumer` (51M rows) is the consumer identity master; `franchise_consumer_alias` (34M rows) is the email/phone multi-alias graph — richest identity expansion table in the estate.
- `franchise_consumer_vehicle` (29M rows) provides VIN→consumer linkage across 29M vehicle associations.
- `customer.AccountId` (63% populated, range 1–343,543) may be the link to DAS Account/CommonClientID — superseded by our own CCID (see Historical/Closed).
- `customer.NewClientId` (51% populated, range 1,066–44,545) may be the CommonClientID link — superseded by our own CCID (see Historical/Closed).
- `franchise.core_account_guid` only 24% populated — DAS account UUID migration in progress.
- No stored ETL procedures in `oltp` — application-layer writes via ADO.NET/JDBC.
- `DataOne` on same server is blocked (login fails) — 1.26 GB, likely VIN reference data.

## Historical / Closed

**Reconciled 2026-06-21 — resolved items previously mis-filed under "Active" (status now matches their own text):**
- Common Client ID schema/access (Dan + Ron Mulder) — CLOSED 2026-06-18. We are building our own Common Client ID from first principles (deterministic-first identity engine, Option A locked 2026-06-17). DAS's CCID is at most a migration/backfill signal, studied from the DWRPT access already granted — never the foundation (objective 7). No DAS deliverable needed; the ID-assignment-logic ask to Ron is dropped. Original context: relayed 2026-06-12, Dan personally arranging access, audit self-serve via DWRPT; the audit informed CCID's weight as one candidate signal, it never gated the design.
- 8 SSIS job descriptions from Rick — CLOSED 2026-06-18 (Alicia: not needed). The `etl/` inventory (231 objects / 20 modules in `docs/etl-data-inventory.md`) plus the field-source matrix cover CDP sourcing; the CDP ingests from original feeds, so per-job legacy descriptions are not on the critical path. Residual unknowns (Conquest_Mailing, dead Mileone_reward_member) are peripheral legacy ops DAS retires on its own schedule. Original ask: CustomerValue, DDE, LeadSource_LeadPerformance, SmartSuppression, Conquest_Mailing, MileOne Weekly Unsubscribe, JuiceReporting_CDXPCustomers, Mileone_reward_member; plus confirming the inferred CRM/DMS → CVH, Email → BlueSky DAG.
- Lucid architecture charts from Rick — CLOSED 2026-06-18 (unlikely to be received). Not a blocker: the ETL modernization plan is built from the `etl/` inventory + discovery, not DAS's legacy diagrams (objective 6, replace-don't-improve).
- Q11/Q14: Cloud position — ANSWERED 2026-06-17 (Dan Aston): DAS prefers consolidating on **Azure-primary** (org-primary cloud), unless a cost/technical blocker says otherwise. This reopened the 2026-06-13 AWS-primary recommendation; no flip — the call is now a client choice. Open work tracked as a deliverable: the AWS-vs-Azure **bake-off** (analysis + gaps + cost). Target = Azure AKS + Postgres, portable OSS core self-hosted. See `memory/decisions.md` "Client-confirmed 2026-06-17" and `docs/cloud-aws-vs-azure-bakeoff.md`.
- Q10: Legal/compliance stakeholder — ANSWERED/deprioritized 2026-06-17: Alex + DAS Legal own it; not a current priority or blocker.
- Event Bus tech — ANSWERED from material in hand: DAS's current bus is Azure Event Grid (VSS microservices spec shows DAS services publishing via Event Grid behind Kong). The CDP intake stays GENERIC/bus-agnostic (adapter over Event Grid / Service Bus / Kafka / EventBridge) — Event Grid is the likely first adapter, not a design dependency.
- Acceptor payloads — ANSWERED 2026-06-17: CDP ingests **raw** (raw-first, process close to source: raw ingest -> dehydration -> transform -> load -> process -> aggregate; store everything). Manipulation problem does not move up a layer. Scope stance (2026-06-17): all sources/channels in scope for max identity value; build extractors for anything DAS doesn't ship us, documented per source.
- Conflict commitments from the 2026-06-12 sync — LOCKED 2026-06-17 (Luis + Alicia): golden-record view in the portal (placeholders filled as identity design lands); portal chat-agent bubble; identity strategy options — Option A (deterministic-first with heuristic recovery) selected as Phase 1 design, Option B (ML-blended from Phase 1) on record as considered-and-rejected on cold-start training data. Ahead of the 2026-06-19 deadline. See `wiki/Identity-Resolution.md` + `analysis/artifacts/identity-strategies/strategies.json` + `memory/decisions.md` "Identity strategy LOCKED 2026-06-17".

**Out of scope — legacy DAS infrastructure being replaced (closed 2026-06-21, Leo):**
Ground-up build with its own deterministic Common Client ID (Option A, locked 2026-06-17). Legacy ID mappings, oltp internals, and legacy ETL ownership/access are at most migration-or-backfill signals, never the foundation — they resolve at migration time if ever, and do not block Phase-0 architecture.
- Dev/QA environment status — dev points to production databases. NOT a CDP blocker (clarified 2026-06-17): the CDP ingests from original sources, decoupled from DAS's dev/prod topology. DAS-internal hygiene item only.
- BlueSky "already an object" failure (DROP IF EXISTS or upsert needed) — a legacy DAS ETL bug in a pipeline the CDP replaces; not on the new-build path.
- DataStaging vs. DWRPT_AI — staging vs. prod of the same legacy analytics replica; refresh cadence / routing is legacy-ETL internal, not needed for the new build.
- `DASID` in `Google.DealershipDataFile` → `CommonClientID` — no mapping table in DWRPT; resolved by building our own CCID, a backfill detail if Google data is onboarded.
- `RPData.Company.clientId` — INT vs CommonClientID type question; legacy ID reconciliation, migration-time only.
- `LVData.dealership_id` — equal to CommonClientID or separate dealer numbering; legacy ID reconciliation, migration-time only.
- Who owns ETL scheduling into DWRPT / refresh frequency per schema? (Ron Mulder) — legacy ETL ownership; the new pipeline replaces it.
- `VIEW SERVER STATE` not granted for `ConflictAI` on DWRPT — blocks `sys.dm_db_index_usage_stats` activity classification on a legacy server; name-pattern heuristics suffice, not worth a grant.
- `customer.AccountId` = `Megatron.Account.acc_ID`? (Ron Mulder) — legacy ID map; superseded by our own CCID, migration-time only.
- `customer.NewClientId` = CommonClientID? (Ron Mulder) — legacy ID map; superseded by our own CCID, migration-time only.
- `franchise.core_account_guid` — what generates this GUID / migration in progress? Legacy account-UUID internals; not a new-build input.
- What writes to `oltp`? (no ETL stored procs found — application-layer?) — legacy app internals; the source is ingested raw, mechanism irrelevant to the CDP.
- What triggers `oltp` -> `oltp_Archive`? (weekly job / threshold?) — legacy archival internals; not a new-build input.
- Who is the DBA for the RL server? (for DataOne access) — legacy access logistics; DataOne stays Parked until/unless access lands.

**Answered at kickoff:**
- No hard deadline driving Phase 0 (Q4).
- No off-limits data sources (Q8).
- Zero cross-system identity resolution today — "We don't" (Q6).
- Families are the hardest identity case, then lead-to-sale gap, social IDs, junk form data (Q7).

**Closed 2026-06-12 (access close-out — see decisions.md):**
- DWRPT read access — original request withdrawn (legacy reporting layer being replaced, not studied). **Superseded:** DAS granted DWRPT access anyway; the 2026-06-14 server discovery used it (DataStaging / DWRPT_AI documented). The withdrawal stands only for the original blanket request.
- Juicebox read access — request withdrawn; sample from exported report definitions instead.
- EDW_Staging access — not pursued; etl/ code + granted source DBs (CIM, ML, RL) cover discovery.

---

See `wiki/Kickoff-Questions.md` for the full tracker.

**How to apply:** No open Phase-0 items remain — Q16 (Phase-1 readiness / success criteria) is answered/detailed (2026-06-21). Source-availability asks are deferred to Phase 1 ingestion; the event-catalog question is answered (canonical-schema + transform); legacy-infra questions are closed out-of-scope for the ground-up build. DWRPT DataStaging and DWRPT_AI are fully documented.

## Appendix — Parked / Not Actionable (off the delivery path)

Blocked pending DBA grants / provisioning, operationally parked, or deferred to Phase 1 ingestion. Resume when access lands or at the relevant build phase.

**Deferred to Phase 1 ingestion (not access-blocked — per-source onboarding discovery, resolved as each source is integrated):**
- Which CRM APIs exist vs. CSV-only? (VinSolutions, eLeads, Tekion all have APIs DAS hasn't used) — direct-from-source ingestion adapter input.
- Authenticom contract — can CDP tap it directly or is it locked to the current ETL? — DMS feed onboarding.
- Comms API — what is it, what communication data does it carry, docs? — new source onboarding.
- `Analytics@3birdsmarketing.com` reliability — missed emails = data gaps in a marketing source the CDP would ingest.
- Repo read access to app codebases (Acceptor, Comms API, Radar, Workflow 2.0) — would let us self-serve source/event discovery; only DAS repo we have is Database-Processes.
- Feedhub re-open — whether Feedhub's CDP value (automotive CIM / vehicle-inventory feed syndication) justifies re-opening a targeted DBA grant. Currently access-blocked; assess inventory/dealer-syndication signals it contributes and whether to escalate the DBA user-mapping grant.

**Access-blocked DBs:**
- EDW_Staging, Feedhub, Zuora, DataOne — access-blocked pending DBA grants / provisioning. Removed from active to-do 2026-06-14; resume when access lands. (CIM and ML Production are access-granted but unclaimed — available to pick up, not blocked. CommonClientID is in-progress with partial access — see "Common Client ID access/schema" under Historical/Closed below.)

**New blockers found 2026-06-14:**
- **Feedhub (CIM):** `ConflictAI` login has no user mapping in the Feedhub DB (owned by `AzureAdmin`). Schema recovered from ETL copies only. Fix: DBA must run `USE Feedhub; CREATE USER ConflictAI FOR LOGIN ConflictAI; EXEC sp_addrolemember 'db_datareader', 'ConflictAI';` (re-open decision tracked under Active Asks → Exception under review).
- **Zuora:** Same issue — `ConflictAI` has `HAS_DBACCESS = 0`. Schema recovered from `DataStaging.zuora` staging tables only. Same DBA fix needed.
- Both require Ron Mulder or a DAS DBA to grant access on the DWRPT server.
- **DataOne** on the RL server is blocked (login fails) — 1.26 GB, likely VIN reference data. Needs the RL DBA.

**Operationally parked:**
- `Mileone_reward_member` SSIS job — permanently failing (0% success, 20+ runs) — root cause unknown. Parked operationally; a legacy ETL job DAS retires on its own schedule.

