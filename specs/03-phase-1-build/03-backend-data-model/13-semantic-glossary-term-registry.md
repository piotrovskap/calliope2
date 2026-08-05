---
title: "Semantic glossary & term registry"
type: story
status: planned
priority: medium
estimate: M
depends_on: [phase-1-build.backend-data-model.ai-context-schema-conventions]
labels: [backend, schema, ai-readiness, knowledge-graph, conventions, 1b]
date: ~
---

A canonical term registry that turns scattered per-object descriptions into a single lookup: every business term used across the schema (Account, CommonClientID, golden record, suppression, tenant, VIN, household) has one authoritative definition plus its **synonyms and source aliases** — so an agent resolves `acc_ID` → Account, `NewClientId` → CommonClientID, `franchise_consumer` → Consumer without guessing. This is the meaning layer above the schema-AST: the AST says what columns exist, the glossary says what the words mean.

**Scope:**
- One entry per canonical term: definition, canonical entity/field it maps to, synonyms + known source-system aliases, format/base type where applicable.
- Backed by and synced with the schema conventions (`ai-context-schema-conventions`) — a column's base/canonical type points at a glossary term, not a free-text string.
- Registered in the knowledge graph as term nodes with `alias-of` / `maps-to` edges, so agents traverse from any alias to the canonical meaning.
- Machine-readable artifact (JSON), regenerated and CI-validated current alongside the schema-context artifact.

**Acceptance:** every canonical/base type referenced by the schema resolves to exactly one glossary entry; aliases and source-system names map to their canonical term; the registry is a generated, validated artifact with KG nodes/edges; an agent can resolve any field alias to its canonical definition from the registry alone.

**References:**
- Decided 2026-06-12 (CONFLICT, first-principles identity): CCID is not anchored on — its narrow roles are one deterministic signal + historical join key; `CommonClientID`/`NewClientId` aliases must resolve to the canonical term, not drive the schema — `memory/decisions.md#d-046`
- Decided 2026-06-18 (Alicia + Luis, A3 — identity + schema lock): the canonical entity/field set (15-table deploy unit, broader 23-entity logical model) that glossary terms map to — `memory/decisions.md#d-116`
- `wiki/Data-Model.md` — canonical entities, field catalog, and identity link types the terms map to
- `wiki/Identity-Resolution.md` — identifier normalization/alias rules (email/phone/VIN) the synonym layer encodes
- `specs/03-phase-1-build/03-backend-data-model/12-ai-context-schema-conventions.md` — the schema-AST and base/canonical-type convention this glossary is the meaning layer above (a column's canonical type points at a glossary term)
