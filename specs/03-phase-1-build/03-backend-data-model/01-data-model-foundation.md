---
title: "Data model foundation"
type: story
status: planned
priority: high
estimate: XXL
depends_on: [phase-1-architecture.data-model.cdp-data-model-design]
labels: [backend, schema, django, migrations, 1a]
date: ~
---

Implement the canonical entity schema as Django models + migrations per the design package: bitemporal provenance (valid-time + system-time, enabling as-of Golden Record queries), per-fact provenance, EAV+JSONB attributes, and temporal edges for the cross-tenant identity graph. EAV+JSONB keeps the attribute surface extensible without schema churn.

**Acceptance:** schema migrated; every Field Catalog v1 field mapped (1–13 dedicated columns, 14–27 via `consumer_attribute` EAV+JSONB); bitemporal observation layer enforces non-overlapping valid-time via `tstzrange` + GiST exclusion at the DB level; a post-v1 field added with zero migrations via EAV+JSONB.

**References:**
- Decided 2026-06-18 (Alicia + Luis, A3 identity + schema design): Phase 1 build target = 15 tables (11 core + 4 AI/ML stubs); bitemporal/provenance shapes locked; schema DDL is the data-model story acceptance criterion — `memory/decisions.md#d-116`
- Data model invariants 2026-06-13 (Leo): bitemporal valid-time + system-time (`tstzrange` + GiST exclusion, observation-layer scope, append-only as-of = Golden Record view); EAV+JSONB for attributes — `memory/decisions.md`
- All-tables-from-day-1 + Field Catalog v1 lock 2026-06-19 (Alicia): full model deploys Stage 1, zero Phase-2 migrations; 14 valuable-now fields — `memory/decisions.md`
- `wiki/Data-Model.md` — field→column/attribute mapping, table set, provenance & bitemporality
- `specs/02-phase-1-architecture/01-data-model/01-cdp-data-model-design.md` — the canonical entity/edge model this story implements
