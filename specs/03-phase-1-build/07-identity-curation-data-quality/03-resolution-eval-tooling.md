---
title: "Resolution-quality eval tooling"
type: story
status: planned
priority: medium
estimate: XL
depends_on: [phase-1-build.identity-curation-data-quality.curation-queue]
labels: [identity, eval, quality, 1a]
date: ~
---

Tools to evaluate resolution decisions against gold and labeled sets: precision/recall sampling, confusion review of false merges and missed matches, and threshold/model evaluation. Curator decisions feed an active-learning loop that refines thresholds and heuristics over time.

**Acceptance:** precision/recall computed for resolution decisions against a labeled/gold set, with false merges and missed matches enumerable for confusion review; the tool reports how a candidate threshold/banding would shift those metrics so values can be tuned from evidence (the threshold values themselves remain design-owned); curator decisions are captured as labels feeding the active-learning loop.

**References:**
- Decided 2026-06-17 (Luis, Alicia concurring): Option A locked — deterministic-first matching with heuristic recovery; the curation queue produces the merge/unmerge labels a future ML matcher needs — `memory/decisions.md#d-104`
- Decided 2026-06-17 (Luis, Alicia): confidence bands ship qualitative in Phase 1, numeric thresholds tuned after measurement (values stay design-owned) — `memory/decisions.md#d-104`
- Decided 2026-06-17 (Luis, Alicia): queue capacity and thresholds sized after 2-4 weeks of measurement, not upfront; Phase 2 active-learning loop fills the queue with scored recommendations — `memory/decisions.md#d-104`
- `wiki/Identity-Resolution.md` — Confidence Thresholds + Queue Volume & Operator Capacity: bands, measurement-driven tuning, and false-merge audit this tooling measures against
