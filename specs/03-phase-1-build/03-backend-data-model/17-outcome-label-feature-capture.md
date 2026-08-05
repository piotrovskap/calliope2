---
title: "Outcome-label & feature capture"
type: story
status: planned
priority: medium
estimate: L
depends_on: [phase-1-build.backend-data-model.data-model-foundation, phase-1-build.backend-data-model.versioned-event-contract]
labels: [backend, schema, ml, ai-readiness, phase-1, 1b]
date: ~
---

Generalize the curation label store (`identity-curation-data-quality.curation-feedback-labels`, which captures identity *decisions* as labels) to also capture **outcome labels** and the **point-in-time features** behind them — so Phase 3 ML scoring (lead/intent/propensity, review sentiment, next-best-action) and the Tier-2/3 models train on clean, well-formatted, leakage-free data the moment Phase 1/2 produce it, with no separate labeling project and no retrofit.

Built into the schema and event contract **now** because the supervised signal is generated continuously during normal operation; if it is not captured as-of, it cannot be reconstructed later without leakage.

**Scope:**
- **Outcome labels:** persist downstream outcomes as structured target labels — activation conversions/bounces (CAPI feedback), lead results (won/lost), review/CSAT outcomes, service-appointment results — keyed to the person/event with provenance, append-only and bitemporal.
- **Point-in-time feature snapshots:** record the feature vector **as-of the decision/event time** (leveraging the bitemporal model), so training reconstructs exactly what was known then — no future leakage. Features are versioned (definition id + version) for train/serve consistency.
- **Consistent format:** one labeled-example shape across decision labels (from curation-feedback-labels) and outcome labels — `{subject, label_type, value, as_of, features_ref, feature_version, provenance}` — queryable as a training/eval dataset and emitted on the versioned event contract.
- Captured as a side effect of normal operation (curation, activation, app feedback); no extra operator step.

**Acceptance:** outcome events write structured target labels with as-of point-in-time feature snapshots and versioned feature definitions; decision labels and outcome labels share one queryable schema; a Phase-3 model can assemble a leakage-free training/eval set directly, with no backfill.

**References:**
- Decided 2026-06-17 (Luis, Alicia concurrence): Option A locked — Tier 2/3 ML (pairwise, GNN/embeddings) deferred to Phase 2 with schema stubs landed in Phase 1; the curation queue produces the training data ML needs (Option B is right "once labels exist") — `memory/decisions.md#d-104`
- Decided 2026-06-18 (Alicia + Luis, A3): all AI/ML tables (`ml_model_run`, `ml_match_candidate`, `embedding_cache`) deploy in Stage 1, empty — zero Phase-2 migrations — `memory/decisions.md#d-005`
- Data-model invariants 2026-06-13 (Leo): bitemporal valid-time + system-time (`tstzrange` + GiST exclusion, append-only); the as-of time-travel query reconstructs what was known then — the leakage-free basis for point-in-time features — `memory/decisions.md`
- `wiki/Data-Model.md` — AI/ML stub tables, provenance & bitemporality, as-of reconstruction
- `wiki/Identity-Resolution.md` — Tier 2/3 deferral and the curation-queue-as-training-data path
