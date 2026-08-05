---
title: "Onboard megatron-repository"
type: story
status: planned
priority: medium
estimate: S
depends_on: [phase-1-build.long-tail.primitive-db]
labels: [long-tail, source, db, ingest, 1b]
date: ~
---

Onboard the **megatron-repository** source through the database primitive: register the source, map its schema to core entities, validate tenant attribution, and land it through ingest to processed. No bespoke connector code — config + mapping against the db primitive.

**Acceptance:** megatron-repository records land through ingest with correct tenant attribution and reconcile to source row counts.

**References:**
- Decided 2026-06-13 (Leo, Phase 0 arch recommendation): source onboarding = config-driven source registry (declarative per-source mapping + provenance tag), new source = config not code — `memory/decisions.md#d-076`
- Decided 2026-06-17 (Dan Aston): templated, convention-driven DAG ecosystem (DAG factories, templated per-source onboarding over the registry) — `memory/decisions.md#d-100`
- `docs/cdp-architecture.md` · `wiki/Tech-Stack.md` — new source = adapter + field map + config landing into encrypted parquet bronze via Airflow
- `specs/03-phase-1-build/09-long-tail/10-primitive-db.md` — the db intake primitive this source adopts (auth, schema mapping, tenant attribution, DLQ)
