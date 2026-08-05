---
title: "Data labeling and training data"
type: story
status: planned
priority: low
estimate: L
depends_on: [phase-1-build.backend-data-model.outcome-label-feature-capture, phase-1-build.identity-resolution-engine.identity-record-event-sourcing, phase-1-build.segmentation-engine.segment-membership-explainability, phase-3-ai-ml.ai-ml-enhancements.model-assisted-identity-and-agentic-apps]
labels: [ai, ml, labeling, training-data, phase-3, net-new, 3]
date: ~
---

Labeling and annotation tooling that turns operator decisions and application outcomes into labeled training data for the downstream ML models — the supervised-signal source built on clean Phase-2 data. The CDP already produces the right human and outcome signals; this captures them as labels rather than letting them stay implicit in the event history.

**Scope:** harvest labels from Phase-1 operator decisions (identity-curation queue resolutions, association/justification choices via the identity event sourcing, segment membership and explainability) and from Phase-2 app feedback (activation outcomes, conversions, review outcomes); provide annotation tooling to review, correct, and add labels; emit versioned, provenance-bearing labeled datasets that feed the Tier-2/Tier-3 model training (including the model-assisted identity work). Built on clean Phase-2 data — the labels reflect a live, resolved CDP, not raw sources.

**Acceptance:** operator decisions and application outcomes are captured as versioned labeled datasets through the annotation tooling, with provenance back to the originating decision/outcome, ready to train the downstream scoring and identity models.

**References:**
- Decided 2026-06-17 (Luis, Alicia concurring): Option A locked — deterministic-first matching with a human curation queue; the curation queue produces the training data the Tier-2/Tier-3 ML matcher (Option B) needs once labels exist — `memory/decisions.md#d-104`
- `wiki/Identity-Resolution.md` — Tier 2 pairwise classifier and Tier 3 GNN/embeddings (Phase 2) trained on confirmed merge/unmerge history
- `wiki/Data-Model.md` — bitemporal per-fact provenance (valid-time + system-time, observation layer); supports provenance-bearing labeled datasets traceable to the originating decision/outcome
