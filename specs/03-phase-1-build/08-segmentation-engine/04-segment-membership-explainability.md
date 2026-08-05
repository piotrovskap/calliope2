---
title: "Segment membership explainability"
type: story
status: planned
priority: medium
estimate: XL
depends_on: [phase-1-build.segmentation-engine.segment-evaluation-engine, phase-1-build.identity-resolution-engine.association-provenance-justification]
labels: [segmentation, provenance, explainability, 1a]
date: ~
---

Explain why an identity is (or is not) in a segment — which predicates and underlying signals/facts drove membership, tracing back through provenance. Parallels the association-justification model so segments are as defensible as the identities they group.

**Acceptance:** for any identity the API returns the per-predicate pass/fail outcome and the underlying signals/facts (traced through association provenance) that qualified a member or disqualified a near-miss, scoped to the caller's tenant.

**References:**
- Decided 2026-06-17 (Luis + Alicia): Option A locked — per-fact provenance (contributing signals, score, source, method, observed-at) plus human-readable justification on every association; explainability parallels this model so membership is as defensible as the identities it groups — `memory/decisions.md#d-104`
- Decided 2026-06-17 (Luis + Alicia): survivorship + source trust ladder with per-element provenance retained, no source permanently overridden — the facts explainability traces back to — `memory/decisions.md#d-107`
- Updated 2026-06-21 (Leo): RLS tenant isolation via `app.current_tenant` GUC; visibility computed from per-fact provenance — `memory/decisions.md` · `wiki/Privacy-by-Design.md`
- `wiki/Identity-Resolution.md` — §Survivorship & Source Trust: per-element provenance (source/when/method) that membership reasons trace through
- `wiki/Data-Model.md` — §Provenance & Bitemporality: append-only observation layer, provenance carried per fact
