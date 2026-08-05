---
title: "Threshold-based positive grouping"
type: story
status: planned
priority: high
estimate: L
depends_on: [phase-1-build.identity-resolution-engine.resolution-engine-core]
labels: [identity, thresholds, grouping, 1a]
date: ~
---

A rules/threshold engine that turns scored candidates into grouping decisions: above the confirm threshold -> auto-confirm a positive identity grouping; within the ambiguous band -> route to moderation (the curation queue); below the floor -> reject. The threshold values and banding are policy owned by the identity-resolution design; this story builds the mechanism that applies them.

**Acceptance:** candidates above / within / below the configured thresholds route to confirm / moderation-queue / reject respectively; thresholds and bands are tunable as configuration without code change; every decision records the threshold context.

**References:**
- Decided 2026-06-17 (Luis, Alicia concurrence): Option A locked — deterministic-first matching with heuristic recovery; no-match falls to blocking + scoring + human curation queue — `memory/decisions.md#d-104`
- Decided 2026-06-17: confidence bands High (auto-merge) / Medium (curation queue) / Low (new consumer + orphan), per-tenant configurable, bias optimistic on strong identifiers / conservative on weak signals — `memory/decisions.md#d-104`
- Decided 2026-06-17 (Dan Aston, client): Phase 1 ships configurable thresholds; numeric bands tuned after 2-4 weeks of measurement — `memory/decisions.md`
- `wiki/Identity-Resolution.md` §Confidence Thresholds — the three-band table (auto-merge / curation queue / new+orphan) and per-tenant configurable thresholds this story applies
