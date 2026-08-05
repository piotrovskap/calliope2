---
title: "SSIS Reimplementation"
type: feature
status: planned
priority: high
depends_on: [phase-1-build.ingest.dag-framework]
labels: [ssis, etl, migration, phase-1, 1b]
date: ~
---

Reimplement the transform logic of DAS's 13 SSIS jobs / 20 ETL modules against the original sources — as Airflow DAGs + Python, **not a 1:1 port**. This feature decomposes what was a single EPIC into per-module stories so the real surface is visible and individually tracked. Container only — its size is the roll-up of its children.

**References:**
- Decided 2026-06-15 (ETL modernization): SSIS retired; Airflow orchestration; logic rebuilt against originals — `memory/decisions.md#d-075`
- `docs/etl-data-inventory.md` — the 20 ETL modules; `specs/02-phase-1-architecture/02-platform-decisions/02-etl-modernization-plan.md`
