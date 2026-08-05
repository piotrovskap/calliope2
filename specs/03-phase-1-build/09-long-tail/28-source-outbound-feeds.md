---
title: "Onboard outbound-feeds"
type: story
status: planned
priority: medium
estimate: S
depends_on: [phase-1-build.long-tail.primitive-db]
labels: [long-tail, source, db, ingest, 1b]
date: ~
---

Onboard the **outbound-feeds** source through the database primitive: register the source, map its schema to core entities, validate tenant attribution, and land it through ingest to processed. No bespoke connector code — config + mapping against the db primitive.

**Acceptance:** outbound-feeds records land through ingest with correct tenant attribution and reconcile to source row counts.

**References:**
- Decided 2026-06-13 (Leo, Phase 0 arch recommendation): config-driven source registry (declarative per-source mapping + provenance tag); original-sources-not-EDW ingest flow (originals → Airflow → S3 bronze → normalize → resolve → CDP Postgres) — `memory/decisions.md`
- Decided 2026-06-17 (Dan Aston, ingestion scope): templated, convention-driven per-source onboarding over the source registry — bespoke extractor work only for the long tail — `memory/decisions.md#d-100`
- `docs/cdp-architecture.md` — ingestion/orchestration and source-onboarding architecture
- `wiki/Data-Model.md` — core entities the source schema maps to; provenance/tenant attribution
