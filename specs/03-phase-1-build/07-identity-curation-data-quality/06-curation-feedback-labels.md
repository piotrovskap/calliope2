---
title: "Curation feedback & training labels"
type: story
status: planned
priority: medium
estimate: M
depends_on: [phase-1-build.identity-curation-data-quality.curation-queue]
labels: [backend, curation, ai-readiness, ml, phase-1, 1a]
date: ~
---

Persist every operator curation decision (confirm / reject / merge / split, with the candidate pair and the features the decision was made on) as a **labeled training record** — not just an audit entry. The curation queue captures the *action*; this captures it as a reusable ML label so Phase-3 model-assisted review has ground truth from day one without a separate labeling project. This is the "labeled" half of well-structured + labeled + contextualized.

**Scope:**
- A labels store: candidate identifiers, decision outcome, operator, timestamp, decision context/features, and provenance — bitemporal, append-only.
- Captured automatically as a side effect of curation actions (no extra operator step); reconciles with the merge/split audit (`merge-split-audit`) rather than duplicating it.
- Exposed as a queryable training/eval dataset (and as an event on the versioned event contract).

**Acceptance:** every curation decision writes a structured label with its candidate, outcome, operator, and decision context; labels are queryable as a training/eval set; the label store is consistent with the merge/split audit; a Phase-3 model can consume the labels without backfilling.

**References:**
- Decided 2026-06-17 (Luis, Alicia concurrence): Option A deterministic-first matching with heuristic recovery; Tier 2/3 ML deferred to Phase 2 — Option A's curation queue produces the training data the ML matcher needs — `memory/decisions.md#d-104`
- Decided 2026-06-17 (Phase-2 escalation): Phase 2 ML fills the queue with confidence-scored recommendations (operators confirm rather than decide) — the labels captured here are what the model trains on — `memory/decisions.md#d-104`
- Bitemporal append-only provenance (2026-06-17): valid-time + system-time, append-only, observation/provenance layer — the shape of the labels store — `memory/decisions.md`
- `wiki/Identity-Resolution.md` — Tier 2 pairwise classifier and Tier 3 GNN/embeddings (Phase 2) are the consumers of these labels; `identity_link.link_type` includes `ml_confirmed`/`gnn_cluster`/`llm_confirmed`
