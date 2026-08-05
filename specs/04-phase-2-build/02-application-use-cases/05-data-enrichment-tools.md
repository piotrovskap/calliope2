---
title: "Data-enrichment tools"
type: story
status: planned
priority: medium
estimate: M
depends_on: [phase-1-build.ingest.source-registry, phase-1-build.backend-data-model.graphql-surface]
labels: [phase-2, applications, enrichment, net-new, 2b]
date: ~
---

Tools for additional data enrichment on top of the CDP — apps/operators that add third-party or derived signals to the golden record through the Phase-1 ingestion framework and source registry, rather than bespoke enrichment pipelines.

**Scope:** onboard enrichment sources (e.g. additional vehicle/valuation, reputation, demographic, geo) via the Phase-1 config-driven source registry; land and resolve them like any other source with per-fact provenance; expose the enriched attributes through the existing golden-record surfaces. Enrichment is additive and provenance-bearing — it never overwrites source-of-truth values, it adds candidate signals.

**Acceptance:** a new enrichment source is onboarded through the Phase-1 registry, its attributes attach to the resolved record with provenance, and consuming apps read them through the standard surfaces — no bespoke enrichment pipeline.

**References:**
- Decided 2026-06-13 (Leo, Phase 0 architecture): source onboarding via a config-driven source registry (declarative per-source mapping + provenance tag) — `memory/decisions.md#d-076`
- Decided 2026-06-17 (Dan Aston): templated, convention-driven DAG ecosystem — new sources assemble over the source registry at low marginal cost, no bespoke pipeline per source — `memory/decisions.md#d-100`
- Decided 2026-06-17 (Luis + Alicia, identity strategy locked): survivorship + source trust ladder — third-party enrichment is lowest trust on identity, high trust on what it owns; per-element provenance retained, no source permanently overridden — `memory/decisions.md#d-107`
- `wiki/Identity-Resolution.md` (§Survivorship & Source Trust) — how enrichment attributes survive against ground-truth sources and carry provenance
- `docs/source-onboarding-ledger.md` — the enrichment sources cataloged for registry onboarding (BlackBook, KBB, Recall Masters, Experian Conquest, MaxMind, NeverBounce, Carfax, etc.)
