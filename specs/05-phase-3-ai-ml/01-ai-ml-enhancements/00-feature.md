---
title: "AI/ML Enhancements"
type: feature
status: planned
priority: low
labels: [ai, ml, phase-3]
date: ~
---

Advanced intelligence layer on top of a live CDP — **AI, ML, and RAG features built on the clean Phase-2 data.** Phase 1 builds the deterministic engine and stubs the ML extension points; Phase 2 produces clean, structured operating data (resolved records, activation outcomes, operator decisions); Phase 3 turns that into supervised signal and models.

Work:
- **Advanced identity** — Tier-2 ML pairwise classifier, Tier-3 embeddings + GNN matching, LLM-assisted conflict review (`01-model-assisted-identity-and-agentic-apps`).
- **Custom models & RAG** on the CDP corpus (`02-custom-models-rag-on-cdp`).
- **Data labeling & training data** (`03`) — turn Phase-1 operator decisions + Phase-2 app feedback into labeled training sets.
- **ML scoring & personalization** (`04`) — the models that enhance the Phase-2 apps (lead/intent scoring, lookalike, personalization, review sentiment, next-best-action), trained on clean Phase-2 data.
- **Agentic applications** on the CDP event backbone.

The ML angle of any Phase-2 app (scoring, sentiment, NBA, personalization, lookalike) lives here, not in Phase 2 — the Phase-2 apps ship deterministic cores and gain their ML enhancement in Phase 3.
