---
title: "Association provenance & justification"
type: story
status: planned
priority: high
estimate: XL
depends_on: [phase-1-build.identity-resolution-engine.resolution-engine-core]
labels: [identity, provenance, justification, audit, 1a]
date: ~
---

For every potential and actual association, capture the evidence behind it — contributing signals, score, source, and a human-readable justification — as provenance on the association. This is what makes fuzzy resolution defensible: a reviewer (or an audit) can see why two records were linked or proposed for linking, and a merge/split can be explained and reversed.

**Acceptance:** every association (auto-confirmed or candidate) persists per-fact provenance — contributing signals, score, source, method, observed-at — plus a human-readable justification string; given an association id, the recorded evidence reconstructs why the records were linked or proposed; the provenance feeds the curation queue display and the `merge_history` audit trail, and a merge/split records the same evidence so the action is explainable and reversible.

**References:**
- Decided 2026-06-17 (Luis with Alicia's concurrence): Option A locked — deterministic-first matching with heuristic recovery + human curation queue producing the labeled merge/reject corpus — `memory/decisions.md#d-104`
- Decided 2026-06-17: confidence bands (high → auto-merge, medium → curation queue, low → new consumer) and survivorship trust ladder with per-element provenance retained, no source permanently overridden — `memory/decisions.md#d-106`
- `wiki/Identity-Resolution.md` — §Survivorship & Source Trust (per-element provenance, source/when/method) and merge decisions captured in `merge_history` with full audit trail
- `wiki/Data-Model.md` — §Provenance & Bitemporality: append-only observation layer, corrections supersede prior rows; provenance carried per fact
- `docs/deliverables/identity-resolution-strategy.md` — conflict queue merge/reject/defer into `merge_history`; per-element provenance retained
