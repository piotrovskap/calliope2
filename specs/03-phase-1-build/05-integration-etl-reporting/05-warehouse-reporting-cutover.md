---
title: "Warehouse reporting cutover"
type: story
status: planned
priority: medium
estimate: XXL
depends_on: [phase-1-build.integration-etl-reporting.superset-deploy]
labels: [reporting, warehouse, analytics, 1a]
date: ~
---

Stand up the analytical warehouse (store-neutral: Redshift / Fabric-Synapse, or Postgres-only) as the analytics layer via zero-ETL/mirroring from managed Postgres, replacing the DWRPT/EDW reporting role. Migrate Superset datasets to read from the warehouse.

**Acceptance:** zero-ETL/mirroring replicates managed Postgres into the warehouse within target lag; migrated Superset datasets point at the warehouse and their results reconcile against the DWRPT/EDW source within tolerance; the DWRPT reporting role is removed for the migrated reports.

**References:**
- Decided 2026-06-13 (stack baseline): Redshift via zero-ETL from RDS-Postgres = analytics/reporting, replaces EDW's reporting role; reporting procs (Juicebox/DWRPT) replaced by the warehouse, NOT ported; no dbt — `memory/decisions.md`
- Decided 2026-06-17 (cloud bake-off, Leo): zero-ETL warehouse gap CLOSED — Fabric mirroring for PG Flex (GA) is the Azure analog; managed warehouse is store-neutral (Redshift / Fabric-Synapse / Postgres-native) and the single largest cloud-cost delta — `memory/decisions.md#d-093`
- Portability principle: Redshift+zero-ETL is the priciest swap-point (→ Synapse/Postgres-native), isolated behind interfaces; Postgres-native stays the portable default — `memory/decisions.md`
- DWRPT is reporting-parity reference only, never an ingestion source (may contain manipulated/summarized data) — `memory/decisions.md`
- `docs/cloud-aws-vs-azure-bakeoff.md` · `wiki/Tech-Stack.md` — managed-warehouse options/cost per cloud and the zero-ETL/mirroring analog
- `docs/cdp-architecture.md` · `docs/cdp-reference-topology.md` — Postgres-native analytics default, managed warehouse opt-in when scan load justifies it
