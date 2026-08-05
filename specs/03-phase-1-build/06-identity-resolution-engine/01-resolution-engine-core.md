---
title: "Resolution engine core (automated / heuristic / moderated paths)"
type: story
status: planned
priority: high
estimate: XXL
depends_on: [phase-1-architecture.data-model.identity-resolution-strategy, phase-1-build.backend-data-model.data-model-foundation]
labels: [identity, resolution, engine, temporal, 1a]
date: ~
---

A configurable engine that runs a record through the resolution paths — automated deterministic matching, heuristic fuzzy scoring, and moderated handoff — driven by the strategy/rules supplied by the design (configuration, not hard-coded logic). Orchestrated as Temporal sagas. Extensible to additional modes (ML-assisted resolution is deferred to P3).

**Acceptance:** the engine takes a record and the configured strategy and emits a resolution decision — High/deterministic auto-merge, Medium/heuristic to the conflict queue, Low to a new consumer + orphan storage — with the path taken and a confidence band on every decision; the deterministic waterfall runs email → phone → VIN → per-dealer customer ID in that order; swapping rules/strategy (waterfall order, thresholds, confidence bands) is config-driven and needs no code change; the run is orchestrated as a Temporal workflow (durable, retryable, idempotent); Phase 1 paths are deterministic + heuristic + moderated — not ML (Tier 2/3 are extension points only).

**References:**
- Decided 2026-06-17 (Luis, Alicia concurs): Option A locked — deterministic-first waterfall (email → phone → VIN → per-dealer customer ID) with heuristic recovery (blocking + scoring + curation queue); ML Tiers 2/3 deferred to Phase 2 with Phase 1 schema stubs — `memory/decisions.md#d-104`
- Decided 2026-06-17: confidence bands — High = deterministic strong-identifier single candidate → auto-merge; Medium = heuristic above threshold/ambiguous → curation queue; Low = no candidate → new consumer + orphan storage; per-tenant configurable, bias to over-queue not over-merge — `memory/decisions.md#d-104`
- Decided 2026-06-19 (Alicia): Temporal workflow sagas as the app-layer orchestrator (durable, retryable, idempotent); Temporal is application/API layer only, off the ingest path — `memory/decisions.md#d-011`
- `wiki/Identity-Resolution.md` — full strategy: tiers, resolution flow, confidence thresholds, conflict review queue
- `docs/deliverables/identity-resolution-strategy.md` — Phase 0 client-facing strategy deliverable
