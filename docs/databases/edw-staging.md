---
source: EDW_Staging (SQL Server · 10.254.210.32)
title: EDW_Staging — Schema Documentation
type: db-schema
database: EDW_Staging
owner: Rick Sorich
researcher: Alicia Salazar
access: na           # not required — CDP ingests original sources, not EDW (access-tracker 2026-06-15)
status: na
dump: dumps/edw-staging.sql
erd: erd/edw-staging.svg
updated: 2026-06-21
---

# EDW_Staging — Schema Documentation

> _Status: parked — not required by design (resolved 2026-06-15, access tracker). Direct EDW_Staging access is not pursued: the CDP ingests from original sources, and the granted source DBs (CIM/ML/RL) plus the SSIS stored procedures cover discovery. EDW_Staging remains the conceptual raw-ingestion shape but is not a separate grant. Owner is Rick Sorich (not Ron Mulder); server is on internal network (`10.254.210.32`)._

## Overview

SSIS ETL landing zone where raw `source_*` tables arrive from CRM, DMS, and other operational systems before being cleaned and promoted to `DataStaging`. Per the Confluence `.32` deep-dive, this server holds both `EDW_Staging` (~700 GB) and `EDW_Target` (~300 GB). It is the **primary raw source for CDP field mapping** — the field-source matrix references `source_dms_sales`, `source_dms_service`, `source_CRM_*` tables here.

The server (`10.254.210.32`) is an AWS SQL Server 2019 instance with 32 vCPU / 256 GB RAM running all SSIS packages. A single E: drive holds data, logs, and tempdb (flagged as a risk in the Confluence review).

## Access

- **Owner:** Rick Sorich · **Researcher:** Alicia Salazar · **Status:** not required (resolved 2026-06-15) — no direct grant pursued
- No `ConflictAI` credentials exist for this server; none are being requested
- **Rationale:** the CDP ingests from original sources, not EDW; the granted source DBs (CIM/ML/RL) + SSIS procs cover discovery. Reopen only if a Phase 1 deliverable proves it necessary.
- Cross-ref: [System Access Tracker](/analysis/artifacts/access-tracker/index.html)

## Schema dump

Not available — requires access. Once granted:

```bash
mssql-scripter -S 10.254.210.32 -d EDW_Staging -U ConflictAI --schema-only -f docs/databases/dumps/edw-staging.sql
```

## Tables

_Pending access. Known table patterns from ETL stored procedures in `etl/SSIS/`:_

- `source_dms_sales` — DMS sales transactions (CRM-sourced)
- `source_dms_service` — DMS service records
- `source_CRM_*` — CRM contact/lead data
- `source_*` prefix convention throughout (pre-stage landing)

## CDP relevance

EDW_Staging is the conceptual raw-ingestion shape — its `source_*` tables hold unfiltered CRM/DMS data before SSIS transformations that may drop or alias fields. But the CDP does not ingest from EDW; it reads the original sources directly, so a direct grant here is not required (resolved 2026-06-15). Cross-ref [CDP Field Source Matrix](../cdp-field-source-matrix.md) — several fields are marked "EDW_Staging source, unconfirmed" and are confirmed against the original source DBs instead.

## Open questions

1. **Access:** Not required by design (resolved 2026-06-15) — the CDP ingests from original sources, not EDW. Parked; reopen only if a Phase 1 deliverable proves it necessary.
2. **`EDW_Target` database:** Also on the same server — is this the same as `DataStaging` on the DWRPT server, or a separate database? Clarify with Rick Sorich.
3. **SSIS package inventory:** Which packages write to `EDW_Staging`? See `etl/SSIS/` — many procs reference `EDW_Staging` as target.
4. **Table count and size:** Confluence notes ~700 GB. Row counts unknown until access is granted.
