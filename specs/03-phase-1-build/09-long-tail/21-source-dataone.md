---
title: "Onboard DataOne"
type: story
status: planned
priority: medium
estimate: S
depends_on: [phase-1-build.long-tail.primitive-db]
labels: [long-tail, source, db, ingest, 1b]
date: ~
---

Onboard the **DataOne** source through the database primitive: register the source, map its schema to core entities, validate tenant attribution, and land it through ingest to processed. No bespoke connector code — config + mapping against the db primitive.

**Acceptance:** DataOne records land through ingest with correct tenant attribution and reconcile to source row counts.

**References:**
- Decided 2026-06-13 (Leo, Phase 0 arch): config-driven source registry — declarative per-source mapping + provenance tag, no bespoke connector code — `memory/decisions.md#d-076`
- Decided 2026-06-13 (Leo, Phase 0 arch): original sources only (not EDW), Airflow batch → S3 bronze → normalize → resolve — `memory/decisions.md`
- `docs/cdp-reference-topology.md` — the source → Airflow batch → bronze → resolution ingest pipeline this source lands through
