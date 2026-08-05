---
title: "Identity record event sourcing & replay"
type: story
status: planned
priority: high
estimate: XXL
depends_on: [phase-1-build.identity-resolution-engine.association-provenance-justification, phase-1-build.backend-data-model.data-model-foundation]
labels: [identity, event-sourcing, audit, replay, 1a]
date: ~
---

Event-source every change to an identity record — attribute facts, edges, resolution decisions, merges/splits — with full source attribution, so you can see how a record got to its current state, from which sources, and replay it to any point in time. The canonical bitemporal store is the live, queryable event log (every change is a recorded row); this story adds a durable change-stream as **compressed event-sourcing artifacts in S3** for cheap long-term retention and re-hydration/replay, with analytical/forensic access via **Glue tables** (access approach TBD). Feeds the Golden Record evolution view.

**Acceptance:** given a `person_id`, every change (attribute facts, edges, resolution decisions, merges/splits) is reconstructable in order with per-change source attribution; an "as-of `(valid_from, recorded_at)`" replay returns the record state at that point (the Golden Record evolution view); change-stream artifacts persist compressed in S3 and re-hydrate to a state byte-identical to the live bitemporal log; analytical/forensic query over the artifacts (Glue on AWS, Azure equivalent otherwise) returns the same history.

**References:**
- Decided 2026-06-18 (Leo): internal change feed IS the bitemporal observation table — every change is a recorded row, no Debezium; "as-of" time-travel = Golden Record evolution view — `memory/decisions.md`
- Decided 2026-06-17 (Dan) / refined 2026-06-18 (Leo): raw-first, store-everything, compress-then-tier; dehydration = time-partition rotate to cold object storage (S3/Blob), re-hydrate on demand — `memory/decisions.md#d-009`
- Decided 2026-06-18 (Leo): analytical processing runs over raw parquet via Glue (AWS-only; Azure equivalent if Azure) — `memory/decisions.md#d-008`
- `docs/cdp-architecture.md` / `wiki/Data-Model.md` — bitemporal append-only provenance (`valid_from/valid_to`, `recorded_at/superseded_at`, tstzrange + GiST), observation-layer scope, as-of time-travel as the golden-record evolution view, replayable S3 bronze
