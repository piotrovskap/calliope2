---
name: das-etl-repo-structure
description: Quick reference for DAS's (removed) etl/ submodule — where the SQL stored procedures lived; paths are historical, authoritative catalog is docs/etl-data-inventory.md
metadata:
  type: project
---

DAS's production ETL code lived at `das-tech/etl/` (git submodule, **removed 2026-06-11** after extraction). All SQL — stored procedures, last updated July 2025. The `etl/` paths below are historical (as they were in the submodule); the verified object catalog and the readable extraction now live in [`../docs/etl-data-inventory.md`](../docs/etl-data-inventory.md) and `bootstrap.md` §13 (231 objects / 20 modules), which are authoritative where counts differ.

## Module Map

| Module | Path | Purpose |
|---|---|---|
| **SSIS** | `etl/SSIS/` | 5 sub-modules (CRM, DMS, CVH, Email, BlueSky) — the AWS-side SSIS pipeline on ETL01 |
| **Juicebox Reporting** | `etl/Juicebox Reporting/` | 58 SPs that *populate* the `JuiceReporting_*` tables — Juicebox itself only renders them |
| **BlackBook** | `etl/BlackBook/` | 7 equity calculation SPs — equity SQL already exists; not pure Phase 2 |
| **Mautic** | `etl/Mautic/` | Company Sync (6 SPs) + Contact Sync (8 SPs) — CVH → Mautic bridge |
| **PostgreSQL (Analytics Mautic)** | `etl/PostgreSQL (Analytics Mautic)/` | 11 sub-modules on the RDS Postgres analytics tier (Archival, Sync, CDXP Watch Rule, Marketing Insights, Recall dashboard, SMS Replies, etc.) |

## SSIS Sub-modules

| Sub-module | SP count | Role |
|---|---|---|
| **CRM** | 68 | per-provider prestaging → staging → CRM; provider prefixes: VS=VinSolutions, EL=eLeads, RR/RR2/RR3=Reynolds, DS/DS2=DealerSocket, TK=Tekion, DC=DriveCentric, TC=TrueCar (others TBD: AD, DCH, ME, MO, MT, OL, OS, PM) |
| **CVH** | 17 | merges CRM+DMS into the unified Customer Vehicle History table (see CVH clarification in tech-stack.md) |
| **DMS** | 13 | DMS appointments / sales / service prestaging → staging → DMS_Fact |
| **Email** | 19 | sends / opens / clicks / bounces; includes `sp_insert_Analytics_MatchBacks_60.sql` (legacy matchback calc) |
| **BlueSky** | 10 | populates `Analytics_BlueSky_*` tables for BlueSky dashboards |

## MatchBack attribution chain (visible end-to-end)

1. **SSIS layer** — `etl/SSIS/Email/sp_insert_Analytics_MatchBacks_60.sql` — calculates matchbacks for the legacy platform.
2. **Juice surface** — `etl/Juicebox Reporting/sp_insert_JuiceReporting_Analytics_MatchBacks_60.sql` — populates the Juice-facing MatchBacks table.
3. **Driver Influence variant** — `etl/Juicebox Reporting/sp_JuiceReporting_extract_analytics_driver_matchbacks.sql` — feeds the Driver Influence dashboard specifically.

## Juice data sync orchestrators

Four master SPs that invoke all SSIS-backed procedures to refresh Juice tables:
- `sp_juice_data_sync_bluesky_ssis.sql`
- `sp_juice_data_sync_CVH_ssis.sql`
- `sp_juice_data_sync_DDE_ssis.sql`
- `sp_juice_data_sync_email_ssis.sql`

These are the entrypoints for understanding the SSIS → Juice flow per domain.

## Mautic identity bridge

`etl/Mautic/Contact Sync/sp_Extract_Mautic_Contact_CustomerHashKey.sql` uses `customer_hashkey` (the CVH hash) as the join key. This is the documented bridge: **CVH hash → Mautic contactID**.

## How to apply

- Need to know what an SSIS job *actually does*? Read the per-module README at `etl/SSIS/<MODULE>/README.md` — they have per-SP descriptions.
- Need to know how a `JuiceReporting_*` table is populated? Look in `etl/Juicebox Reporting/` for the matching `sp_insert_JuiceReporting_*` file.
- Re-implementing CVH for the CDP? The merge logic lives in `etl/SSIS/CVH/sp_insert_staging_CVH.sql` — that's the canonical CRM+DMS merge to study.
- Re-implementing equity for the CDP? `etl/BlackBook/sp_Calculate_Equity*.sql` — equity SQL already exists, reduces Phase 2 unknowns.
- Related: [[das-current-tech-stack]] for server topology and the 13-job SSIS catalog.
