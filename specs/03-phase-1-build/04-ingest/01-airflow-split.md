---
title: "Airflow split (managed/self-hosted)"
type: story
status: planned
priority: high
estimate: XL
labels: [ingest, airflow, 1a]
date: ~
---

Stand up managed Airflow (Azure Managed Airflow / MWAA, or self-hosted) as the dedicated ingestion plane and establish the boundary between ingest (Airflow) and the app layer (Temporal), with Temporal kept entirely off the ingest path. All extract/backfill/file+API pulls and DMS-task orchestration run under Airflow; the app layer never participates in ingestion.

Two environments: **non-prod** (per the decided delivery workflow — a PR spins out an isolated fork/demo deploy of its changed DAGs and runs their unit tests automatically) and **prod** (merged DAGs promote from non-prod via CD; no direct prod authoring). See `phase-1-architecture.platform-decisions.etl-modernization-plan`.

**Acceptance:** the managed-Airflow environment runs a sample extract DAG end-to-end; a PR auto-deploys its changed DAGs to non-prod and runs their unit tests as a CI gate; promotion to prod is CD-only; no ingest task invokes Temporal (verified by grep/CI guard); the ingest/app boundary is documented and Temporal is provably absent from the ingest path.

**References:**
- Decided 2026-06-15 (ETL delivery workflow — closes the ETL-modernization-plan item): two-environment DAG delivery — every PR spins out an isolated non-prod deploy of its changed DAGs and runs unit tests; merged DAGs promote to prod via CD, no direct prod authoring — `memory/decisions.md#d-101`
- Decided 2026-06-13 (Phase 0 arch recommendation, Leo): Airflow = ALL ingest (extract/backfill/file+API/DMS-task); Temporal = app/API layer only, OFF the ingest path — `memory/decisions.md#d-072`
- Refined 2026-06-17 (Dan Aston / Conflict, agnostic-core): self-hosted Airflow on the portable OSS core (Azure has no MWAA peer); supersedes the MWAA framing of the 2026-06-15 workflow — `memory/decisions.md`
- `docs/cdp-architecture.md` · `wiki/Architecture.md` · `wiki/Tech-Stack.md` — Airflow (self-hosted) = all ingest, Temporal = identity sagas/conflict queue/admin; the ingest/app boundary
- `docs/cdp-reference-topology.md` — Airflow scheduler/web/workers as the elastic ingest tier; Temporal as separate app-layer workflow pods
