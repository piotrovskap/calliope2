---
source: ML Production (MediaLogix · 74.179.80.27)
title: ML Production — Schema Documentation
type: db-schema
database: ML_Production
owner: Ron Mulder
researcher: Alicia Salazar
access: granted
status: pending
dump: dumps/ml-production.sql
erd: erd/ml-production.svg
updated: 2026-06-21
---

# ML Production — Schema Documentation

> _Status: pending — discovery caveat. Access is granted (`ConflictAI` credentials confirmed in `.env`) but the server (`74.179.80.27:1433`) is not reachable from the discovery sandbox. Schema dump must be extracted from a machine with network access (VPN or on-prem)._

## Overview

Operational OLTP database for the **MediaLogix advertising platform** — the system that powers dealer inventory ad distribution (listings, campaigns, VDP performance). Migrating from SQL Server 2008 to a C#/PostgreSQL stack. SSIS pulls raw data from here to `EDW_Staging` before it reaches `DataStaging` under the `MLdata` schema.

For CDP ingestion, prefer the already-documented downstream copies in `DataStaging.MLdata` over this source unless raw/unfiltered operational data is needed.

## Access

- **Owner:** Ron Mulder · **Researcher:** Alicia Salazar · **Status:** granted · **Reach:** `74.179.80.27:1433` / `ConflictAI` / `ConFlict@!PassWord2026`
- Server not reachable from the CI/discovery sandbox — requires VPN or on-prem connection
- Cross-ref: [System Access Tracker](/analysis/artifacts/access-tracker/index.html)

## Schema dump

Not yet extracted. To generate from a networked machine:

```bash
mssql-scripter -S 74.179.80.27 -d ML_Production -U ConflictAI -P "ConFlict@!PassWord2026" --schema-only -f docs/databases/dumps/ml-production.sql
```

Commit the dump, then re-run analysis to complete this doc.

## Tables

_Pending dump. Downstream ETL copies visible in `DataStaging.MLdata`:_ `Account`, `Listing`, `ListingVehicle`, `FEEDADS`, `FEEDDEALERS`, `Display`, `DisplayGEO`, `VDPPerformance`, `GVAVDPData`, `PlatformAuto_*`, `LeadQueue`, `ImportLog`, `MLCommonClientIdMapping`.

## CDP relevance

`DataStaging.MLdata` is the already-ingested ETL copy of this database's data and is fully documented. ML Production is the upstream write source; ETL lag is the primary concern for CDP real-time use cases.

## Open questions

1. **Network access:** Server `74.179.80.27` not reachable from sandbox. Is it on-prem or behind VPN? Run `mssql-scripter` from a connected machine to get the dump.
2. **Database name:** Confirm actual SQL Server database name (may not be `ML_Production`).
3. **Migration status:** How far along is the SQL Server → C#/PostgreSQL migration? Is the SQL Server instance still the system of record?
4. **EDW_Staging pipeline:** Which SSIS packages pull from ML_Production? See `etl/SSIS/` for references.
