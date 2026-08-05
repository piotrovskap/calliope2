---
title: "Embedding / vector hook"
type: story
status: planned
priority: low
estimate: S
depends_on: [phase-1-build.backend-data-model.data-model-foundation]
labels: [backend, schema, ai-readiness, vector, phase-1, 1b]
date: ~
---

Reserve the vector slot in Phase 1 so Phase-3 RAG and embedding-assisted identity clustering need **no schema migration** later. Provision `pgvector` (extension + a nullable embedding column / sidecar embedding table keyed to the canonical entities and the schema-context artifact), unused at launch but present and documented.

**Scope:**
- Enable `pgvector`; add a nullable embedding column or sidecar table for the entities that Phase 3 will embed (person/golden record, and the semantic-context records).
- No embedding generation in Phase 1 — only the slot, an index placeholder, and the convention for what gets embedded and how it is versioned (model id + dim recorded per vector).
- Documented per the schema conventions (description, nullable rationale = "reserved for Phase-3 embeddings").

**Acceptance:** `pgvector` available; embedding storage present, nullable, documented, and KG-registered; a Phase-3 embedding can be written and queried with zero schema migration.

**References:**
- Decided 2026-06-17 (Luis, Alicia concurrence): Identity Option A locked — deterministic-first, Tier 2/3 (pairwise ML, GNN/embeddings) deferred to Phase 2 with schema stubs landed in Phase 1 — `memory/decisions.md#d-104`
- `wiki/Identity-Resolution.md` — Tier 3 GNN/embeddings: schema tables deployed in Phase 1 (empty), populated Phase 2
- `wiki/Data-Model.md` — `embedding_cache` table (consumer embedding cache for Tier 3 GNN) among the Phase-1-deployed/Phase-2-purpose tables
