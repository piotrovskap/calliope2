---
title: "ML scoring and personalization"
type: story
status: planned
priority: low
estimate: XL
depends_on: [phase-3-ai-ml.ai-ml-enhancements.data-labeling-and-training-data, phase-3-ai-ml.ai-ml-enhancements.custom-models-rag-on-cdp]
labels: [ai, ml, scoring, personalization, phase-3, net-new, 3]
date: ~
---

The ML models that enhance the Phase-2 apps, trained on clean Phase-2 data: lead/intent/propensity scoring, lookalike, personalization/recommendations, review sentiment, and next-best-action. This is the Phase-3 intelligence layer the deterministic P2 apps were built to receive — each model plugs into its P2 app rather than replacing it.

**Scope:** train and serve models on the labeled training data and the CDP golden record — lead/intent/propensity scoring into the lead-handling app, lookalike and personalization/recommendations into the marketing-activation app, review sentiment into the reputation-management app, next-best-action into the service & support console; serve scores/recommendations back through the governed surfaces so each P2 app consumes them in place of (or alongside) its deterministic rules. Models depend on the labeled data source and the custom-models/RAG foundation on the CDP.

**Acceptance:** each model produces scores/recommendations from the labeled training data and golden record and is consumed by its target P2 app (lead-handling, marketing-activation, reputation-management, service & support console), enhancing the deterministic core without replacing the resolved record as source of truth.

**References:**
- Decided 2026-06-17 (Luis, Alicia concurring): ML-blended scoring (Option B) is the right answer once labels exist — deferred past Phase 1 cold-start to Phase 2/3, fed by the curation-queue labels — `memory/decisions.md#d-104`
- Decided 2026-06-15 (Phase 2 queue sizing): Phase 2 ML fills the conflict queue with confidence-scored recommendations (operators confirm rather than decide) — `memory/decisions.md#d-113`
- DAS AI-layer reuse 2026-06-13: CDP AI/ML features reuse the live `ai.das-technology.com` layer (lead response, review sentiment, dashboards), not a parallel build — `memory/decisions.md`
- `wiki/Roadmap.md` (Phase 3 — AI/ML + Advanced) · `docs/cdp-architecture.md` — ML tables stubbed in Phase 1; later-phase work is model work, not re-architecture; AI features build on the CDP event backbone + golden record
