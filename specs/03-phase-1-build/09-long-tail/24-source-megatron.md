---
title: "Onboard megatron"
type: story
status: planned
priority: medium
estimate: S
depends_on: [phase-1-build.long-tail.primitive-db]
labels: [long-tail, source, db, ingest, 1b]
date: ~
---

Onboard the **megatron** source through the database primitive: register the source, map its schema to core entities, validate tenant attribution, and land it through ingest to processed. No bespoke connector code — config + mapping against the db primitive.

**Acceptance:** megatron is registered in the source registry with schema mapped to core entities; an ingest run lands its records to bronze and through to processed via the db primitive (no bespoke connector code); every landed row carries correct tenant attribution; processed counts reconcile to source row counts.

**References:**
- Decided 2026-06-17 (Dan Aston): templated, convention-driven DAG ecosystem — per-source onboarding is config over the config-driven source registry, not bespoke code — `memory/decisions.md#d-100`
- Decided 2026-06-18 (Leo): raw-first pipeline — raw ingest lands in a parquet bronze buffer, dehydration/transform from there to processed — `memory/decisions.md#d-008`
- `docs/source-onboarding-ledger.md` — places megatron as an app-db source onboarded via `primitive-db` (sub-phase 1b)
- `docs/databases/megatron.md` — the source schema (Megatron, SQL Server, DAS Operations) mapped to core entities
