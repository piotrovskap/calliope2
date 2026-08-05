---
title: "Identity Resolution Curation & Data Quality"
type: feature
status: planned
priority: high
depends_on: [phase-1-architecture.data-model.identity-resolution-strategy, phase-1-build.backend-data-model.data-model-foundation, phase-1-build.identity-resolution-engine.threshold-positive-grouping]
labels: [identity, curation, data-quality, phase-1]
date: ~
---

Managing and curating identity resolution where humans are needed, plus tooling to assess data quality around identity resolution. Spans backend (curation queue fed by Temporal resolution sagas, DQ metrics) and frontend (curation/eval UI). Deterministic tiers resolve where signals suffice; ambiguous or low-confidence matches route to human curation. Design owned partly by Alicia + Luis.

**Acceptance:** curators can triage the queue; resolution and data-quality metrics are observable.

**Milestone.** curators can triage the queue; resolution + data-quality metrics observable.
