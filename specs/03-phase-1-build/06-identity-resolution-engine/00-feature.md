---
title: "Identity Resolution Engine"
type: feature
status: planned
priority: high
depends_on: [phase-1-architecture.data-model.identity-resolution-strategy, phase-1-build.backend-data-model.data-model-foundation]
labels: [identity, resolution, engine, phase-1]
date: ~
---

The engineering surface that EXECUTES identity resolution across its paths — automated (deterministic), heuristic (fuzzy / scored), and moderated (handoff to human curation), extensible to further modes. Runs as Temporal sagas in the app layer, off the ingest path.

**Design-owned vs built here:** the matching *strategy* — tiers, signals, scoring, threshold values, the survivorship source-trust ranking, the household detection signals — is defined by the identity-resolution design (Alicia + Luis, `specs/02-phase-1-architecture/01-data-model/02-identity-resolution-strategy.md` and `05-survivorship-rules.md`). This feature builds the configurable engine that *executes* that strategy: the resolution paths, per-association provenance + justification, threshold-based positive grouping, orphan handling, identity event-sourcing, **survivorship golden-value resolution**, and **household detection & membership**. Strategy in (config); engine executes (these stories).

**Milestone.** the engine resolves a record across the automated / heuristic / moderated paths, emitting a decision with per-association provenance + justification, with rules and thresholds supplied as configuration.
