---
title: "Context & semantic-metadata management"
type: story
status: planned
priority: medium
estimate: L
depends_on: [phase-1-build.backend-data-model.ai-context-schema-conventions]
labels: [phase-2, metadata, ai-readiness, source-onboarding, net-new, 2a]
date: ~
---

Applications manage, use, and **expand** the schema-context references established in Phase 1 (`ai-context-schema-conventions`). The context layer becomes a living, app-managed surface rather than a one-time annotation: as new sources onboard and the field catalog grows past v1, every new field acquires its description, format, base/canonical type, nullability rationale, and provenance through the onboarding flow — and the schema-context artifact + knowledge-graph hooks update automatically.

**Scope:**
- Source onboarding captures per-field semantic metadata (description, format, base type, nullable exception, provenance) as a required step — no field lands without context.
- Operators view, curate, and override field meanings / canonical-type mappings via the onboarding console; overrides are provenance-bearing (who/when/why).
- The schema-context artifact and KG nodes regenerate as sources expand, staying current automatically.
- Applications consume the context layer (the semantic catalog / KG) at runtime to drive mapping, validation, and agent tooling — they read meaning from the graph, not hardcoded field knowledge.

**Acceptance:** onboarding a new source captures per-field semantic metadata + provenance + KG registration as part of the flow; operators can view and edit field context with audited overrides; the schema-context artifact and KG stay current as the field surface grows; consuming applications resolve field meaning from the context layer, not from code.

**References:**
- Phase 1 anchor: `phase-1-build.backend-data-model.ai-context-schema-conventions` — establishes the schema-context artifact, per-object semantic metadata (description/format/base type/nullable rationale), and KG hooks this story manages and expands.
- Decided 2026-06-18 (Alicia + Luis, A3 identity + schema design): per-fact provenance and bitemporal/provenance shapes locked — the per-element provenance each field carries through onboarding — `memory/decisions.md#d-082`
- Source onboarding: config-driven source registry (declarative per-source mapping + provenance tag) — `memory/decisions.md`
- Field Catalog v1 is versioned and grows past the initial 27; expansion candidates graduate per version (validated source + identity/event linkage + a consumer that needs it) — `memory/decisions.md` · `docs/cdp-field-source-matrix.md`
- `docs/knowledge-engine.md` — the brain/KG schema and provenance-complete invariant the regenerated context nodes must satisfy.
- `wiki/Data-Model.md` — per-fact provenance and bitemporality model the canonical/base-type annotations map onto.
