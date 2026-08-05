---
source: Central Inventory (SQL Server · 20.51.108.231 · Car Inventory Management)
title: CIM — Schema Documentation
type: db-schema
database: CIM
owner: Ron Mulder
researcher: Alicia Salazar
access: granted
status: complete
dump: dumps/cim.sql
erd: erd/cim.svg
updated: 2026-06-21
---

# CIM — Schema Documentation

> _Status: complete — discovered via live discovery probe 2026-06-14; no DDL dump available (column-level DDL blocked). Row counts, sizes, and date ranges sourced from `docs/etl/usage-analysis/data/cim/`. Inference flagged throughout._

> **Note:** The actual SQL Server database name is `Central Inventory` (not `CIM`). The `CIM` label is the product name — Car Inventory Management — used throughout MediaLogix documentation. `ClientInventory`, `DataOne`, and `Feedhub` exist on the same server but are inaccessible to the `ConflictAI` login (`HAS_DBACCESS = 0`).

## Overview

Central Inventory is the **operational vehicle inventory store for the MediaLogix CIM (Car Inventory Management) platform**. It holds the full lifecycle of automotive listings: incoming dealer feeds land in the `stage` schema via SSIS ETL, are promoted into the `FHD` (FeedHub Dealer) production schema, and are retained in `FHD.vehicles_removed` when delisted. ElasticSearch is layered on top for search indexing. Data flows from here into `DataStaging.MLdata` (Listing, ListingVehicle, FEEDADS tables) for CDP analytics.

The database is CPU-intensive (documented as peaking ~70% CPU 4–5×/day), driven by the high-write `vehicles_removed` table (40M rows, 401 GB). The `FHD` schema is the production surface; `stage` is the ETL landing zone.

## Access

- **Owner:** Ron Mulder · **Researcher:** Alicia Salazar · **Status:** granted · **Reach:** `20.51.108.231:1433` / `ConflictAI` login / SSMS or pyodbc
- `ClientInventory`, `DataOne`, `Feedhub` on the same server are blocked (`HAS_DBACCESS = 0`)
- DDL dump not yet extracted — column-level schema requires re-running `mssql-scripter` from a networked machine
- Cross-ref: [System Access Tracker](/analysis/artifacts/access-tracker/index.html)

## Schema dump

No DDL dump available. Column-level schema is not documented below — table names, row counts, sizes, and date ranges are from the live discovery probe (`docs/etl/usage-analysis/data/cim/01_tables.csv`, `03_table_date_ranges.csv`). To extract: `mssql-scripter -S 20.51.108.231 -d "Central Inventory" -U ConflictAI --schema-only -f dumps/cim.sql`

## Tables

_8 tables confirmed · 2 schemas (`FHD`, `stage`) · Data spans 2022-10-28 → 2026-06-14_

| Table | ~Rows | Size (MB) | Purpose | CDP-relevant |
|---|---|---|---|---|
| `FHD.vehicles_removed` | 40,111,876 | 401,037 | **Primary delisted-vehicle archive.** Stores every vehicle removed from active inventory since 2022-10-28. Has `created_at`, `updated_at`, `date_removed` timestamps — full deactivation audit trail. | ✓ |
| `FHD.vehicles_loc` | 2,342,115 | 30,869 | **Active vehicle location/inventory table.** Current live listings — VIN-linked vehicle records with `created_at`/`updated_at` timestamps. Feed source for `DataStaging.MLdata.ListingVehicle`. | ✓ |
| `stage.FHvehicles_new` | 2,342,115 | 24,586 | **ETL staging table for new/updated vehicle feeds.** SSIS landing zone before promotion to `FHD.vehicles_loc`. Mirrors `vehicles_loc` row count — likely the pending-promote buffer. | ✓ |
| `stage.FHvehicles_Test` | 2,239,173 | 15,462 | **Test/QA copy of vehicle staging data.** Row count and date range (2022-10–2024-08) suggest a frozen snapshot used for integration testing; no new rows since 2024-08-09. | — |
| `stage.incoming_dealer_feeds` | 16,972 | 4 | **Raw inbound dealer feed queue.** Receives dealer inventory submissions before SSIS processing. Has `created_at`/`updated_at`. Low row count suggests regular truncation after processing. | — |
| `stage.FHvehicle_price_updates` | 0 | 0 | **Price-delta staging table.** Zero rows — either cleared post-ETL or not yet in use. Has `updated_at` timestamp column. (inferred: tracks VIN-level price changes between feed cycles) | — |
| `stage.FHvehicles` | 0 | 0 | **Legacy/empty vehicle staging table.** Zero rows; predates `FHvehicles_new`. Likely superseded but not dropped. | — |
| `stage.FHvehicles_Extra` | 0 | 0 | **Extended attributes staging table.** Zero rows. (inferred: supplemental fields not in core FHvehicles schema) | — |

## Indexes

Not available — DDL dump not yet extracted. Re-run discovery with `mssql-scripter` to capture index definitions.

## Views

Not confirmed — no `CREATE VIEW` statements available without DDL dump. ElasticSearch indexing is documented as layered on top of this database; views may exist to support that integration.

## ERD

Pending DDL dump. Relationships inferred from table naming and DataStaging ETL patterns:

```
stage.incoming_dealer_feeds → stage.FHvehicles_new → FHD.vehicles_loc
                                                    ↘ FHD.vehicles_removed (on deactivation)
FHD.vehicles_loc → DataStaging.MLdata.ListingVehicle (via nightly SSIS ETL)
```

## CDP relevance

`FHD.vehicles_loc` is the canonical active-vehicle inventory feed — VIN-level records that resolve to `DataStaging.MLdata.ListingVehicle` and ultimately to the CDP vehicle graph. `FHD.vehicles_removed` (40M rows) is the richest vehicle-history source in the estate: it covers every deactivated listing since Oct 2022 with deactivation timestamps, enabling vehicle lifecycle tracking (listed → delisted → re-listed patterns) for the CDP equity/trade-in model.

Cross-ref:
- `DataStaging.MLdata.Listing` (7.4M rows) — downstream ETL copy
- `DataStaging.MLdata.ListingVehicle` (7.8M rows) — VIN-resolved downstream copy
- `DataStaging.MLdata.FEEDADS` (8M rows) — ad-level copy with dealer association
- [CDP Field Source Matrix](../cdp-field-source-matrix.md)

## Open questions

1. **Column-level schema:** No DDL dump exists. Run `mssql-scripter -S 20.51.108.231 -d "Central Inventory" -U ConflictAI --schema-only -f dumps/cim.sql` from a networked machine and commit the dump.
2. **`FHD` schema name:** Stands for "FeedHub Dealer" (inferred from Feedhub column prefix convention `fd`). Confirm with Ron Mulder.
3. **`stage.FHvehicles_Test` frozen since 2024-08-09:** Intentional snapshot or stale table? Safe to drop?
4. **`stage.incoming_dealer_feeds` row count (16,972):** Is this a live queue or a partially-truncated table? Clarify ETL cadence.
5. **ElasticSearch integration:** Which tables/columns are indexed? ES schema maps to which `FHD` columns?
6. **`ClientInventory` on same server:** `HAS_DBACCESS = 0` — what does it contain and is access grantable?
