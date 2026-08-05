---
title: "Segment evaluation & materialization"
type: story
status: planned
priority: high
estimate: XXL
depends_on: [phase-1-build.segmentation-engine.segment-definition-model]
labels: [segmentation, engine, query, 1a]
date: ~
---

Evaluate segment definitions against the data — Postgres serving for live predicates, the analytical warehouse for heavy aggregates, OpenSearch where fuzzy matching is needed — and materialize/refresh membership on a schedule or trigger, with performance for large swaths.

**Acceptance:** a definition evaluates to a materialized member set routed across Postgres / warehouse / OpenSearch per predicate type; a large segment completes within target latency; a scheduled or triggered refresh updates membership incrementally (only changed members re-evaluated) and remains tenant-scoped.

**References:**
- Decided 2026-06-13 (Leo, Phase 0 arch recommendation): polyglot store roles — PostgreSQL + RLS as canonical/serving store, Postgres-native analytics or managed warehouse for reporting/heavy aggregates, OpenSearch for fuzzy person search — `memory/decisions.md#d-004`
- Decided 2026-06-21 (Leo): PostgreSQL RLS is the confirmed multi-tenant isolation mechanism (resolver above RLS, all serving tenant-scoped) — `memory/decisions.md#d-004`
- Decided 2026-06-14 (Leo): Temporal = application/API-layer orchestrator only (sagas, queue/worker processing, admin-utility orchestration), off the ingest path — the basis for triggered/scheduled materialization refresh — `memory/decisions.md#d-073`
- `docs/cdp-architecture.md` — the serving/analytics/search store split (Postgres serving, warehouse analytics, OpenSearch fuzzy search) segment predicates route across
- `wiki/Multi-Tenancy.md` — database-level RLS isolation that keeps materialized membership tenant-scoped
