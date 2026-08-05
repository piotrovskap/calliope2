---
title: "CRM consolidation (21+ providers)"
type: story
status: planned
priority: high
estimate: L
depends_on: [phase-1-build.ingest.dag-framework]
labels: [ssis, etl, migration, 1b]
date: ~
---

Reimplement the **CRM consolidation (21+ providers)** transform against the original sources as an Airflow DAG + Python — preserving the business logic (dedup / standardize / match / aggregate) the SSIS module performed, without carrying its truncate-and-rebuild fragility.

**Acceptance:** the reimplemented transform produces output reconciling to the legacy module within tolerance on a validation sample, runs on the Airflow framework, and is covered by tests.

**References:**
- Decided 2026-06-15 (ETL modernization plan): reimplement SSIS logic against originals — `memory/decisions.md#d-075`
- `docs/etl-data-inventory.md` — the source module this story rebuilds
