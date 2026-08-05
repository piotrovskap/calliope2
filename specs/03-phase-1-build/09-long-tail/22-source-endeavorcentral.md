---
title: "Onboard endeavorcentral"
type: story
status: planned
priority: medium
estimate: S
depends_on: [phase-1-build.long-tail.primitive-db]
labels: [long-tail, source, db, ingest, 1b]
date: ~
---

Onboard the **endeavorcentral** source through the database primitive: register the source, map its schema to core entities, validate tenant attribution, and land it through ingest to processed. No bespoke connector code — config + mapping against the db primitive.

**Acceptance:** endeavorcentral is registered in the source registry with schema mapped to core entities; an ingest run lands its records to bronze and through to processed via the db primitive (no bespoke connector code); every landed row carries correct tenant attribution; processed counts reconcile to source row counts.

**References:**
- Decided 2026-06-17 (Dan Aston): templated, convention-driven DAG ecosystem — per-source onboarding is config over the config-driven source registry, not bespoke code — `memory/decisions.md#d-100`
- Decided 2026-06-17 (Dan Aston): raw-first, store-everything pipeline (raw -> dehydrate -> transform -> load -> process) — `memory/decisions.md#d-098`
- `docs/source-onboarding-ledger.md` — places endeavorcentral as an app-db source onboarded via `primitive-db` (sub-phase 1b)
- `docs/databases/endeavorcentral.md` — the source schema (EndeavorCentral, SQL Server, DAS Finance) mapped to core entities
