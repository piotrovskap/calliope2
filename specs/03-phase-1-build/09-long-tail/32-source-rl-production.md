---
title: "Onboard RL_Production"
type: story
status: planned
priority: medium
estimate: S
depends_on: [phase-1-build.long-tail.primitive-db]
labels: [long-tail, source, db, ingest, 1b]
date: ~
---

Onboard the **RL_Production** source through the database primitive: register the source, map its schema to core entities, validate tenant attribution, and land it through ingest to processed. No bespoke connector code — config + mapping against the db primitive.

**Acceptance:** RL_Production records land through ingest with correct tenant attribution and reconcile to source row counts.

**References:**
- Decided 2026-06-13 (Leo, Phase 0 arch recommendation): source onboarding = config-driven source registry (declarative per-source mapping + provenance tag) — `memory/decisions.md#d-076`
- Decided 2026-06-17 (Dan Aston): templated, convention-driven DAG ecosystem (DAG factories, templated per-source onboarding over the registry) — `memory/decisions.md#d-100`
- `specs/03-phase-1-build/09-long-tail/10-primitive-db.md` — the db source primitive this source adopts via config (no bespoke connector code)
- `specs/03-phase-1-build/04-ingest/06-source-registry.md` — the registry-entry contract (connection/auth, field mapping, identity keys, provenance, tenant attribution)
