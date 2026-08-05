---
title: "Model-assisted identity and agentic applications"
type: story
status: planned
priority: low
estimate: XXXL
labels: [ai, ml, identity-resolution, agentic, phase-3, net-new, 3]
date: ~
---

Use production CDP data to improve identity resolution and unlock AI/agentic application behavior. Likely scope includes pairwise match classifiers, embedding/GNN-assisted identity clustering, LLM-assisted conflict review, predictive scoring, and reuse of DAS's existing AI layer against the CDP golden record. Final scope and timing depend on Phase 1/2 outcomes and data volume.

**Acceptance:** at least one model-assisted capability runs against production CDP data and is observably better than the deterministic-only baseline: e.g. a pairwise classifier or GNN/embedding clusterer produces confidence-scored merge candidates into the existing curation queue (operators confirm rather than decide), with measured precision/recall against curated labels and `identity_link.link_type` recording the assisting method (`ml_confirmed`, `gnn_cluster`, or `llm_confirmed`). Scope is gated on Phase 1/2 outcomes; the schema stubs landed in Phase 1 are populated, not migrated.

**References:**
- Decided 2026-06-17 (Luis + Alicia, identity strategy Option A): deterministic-first matching; Tier 2 pairwise ML and Tier 3 GNN/embeddings deferred to a later phase with schema stubs landed in Phase 1 — `memory/decisions.md#d-104`
- Decided 2026-06-17/2026-06-19 (Alicia, Privacy-by-Design): later-phase ML fills the curation queue with confidence-scored recommendations (operators confirm rather than decide); thresholds sized after 2-4 weeks of measurement — `memory/decisions.md#d-104`
- Decided 2026-06-12 (Mike, exec direction): CDP is the source of truth that apps and agentic features build on; requirement is a CDP "good for AI and good for regular application lifecycle events, or agentic events" — `memory/decisions.md#d-047`
- Reuse of DAS's existing AI layer (`ai.das-technology.com`) routed to the architecture narrative (2026-06-13, validated with Dan + Mike) — `memory/decisions.md`
- `wiki/Identity-Resolution.md` — Tier 2 (pairwise classifier) / Tier 3 (GNN/embeddings) design, link types (`ml_confirmed`, `gnn_cluster`, `llm_confirmed`), and the Phase 2 queue-escalation model
- `docs/cdp-architecture.md` · `docs/deliverables/identity-resolution-strategy.md` — the tiered resolution architecture this story extends
