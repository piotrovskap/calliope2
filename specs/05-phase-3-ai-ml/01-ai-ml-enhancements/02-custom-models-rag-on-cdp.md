---
title: "Custom models & RAG on the CDP corpus"
type: story
status: planned
priority: low
estimate: XXL
depends_on: [phase-2-build.source-onboarding.context-metadata-management]
labels: [ai, ml, rag, knowledge-graph, phase-3, net-new, 3]
date: ~
---

With a large enough, **well-structured, labeled, and contextualized** dataset — which the Phase 1 schema conventions and Phase 2 context management guarantee — train or finetune custom models on DAS's own data, and/or build RAG systems over the CDP golden record and its semantic catalog. The data being self-describing (every object carries description, format, canonical type, provenance, and a KG node) is the precondition that makes this feasible without a separate labeling project.

**Scope (directional until Phase 1/2 produce real operating data + volume):**
- Finetuned / custom identity and match models trained on production resolution outcomes and curation feedback (the labels captured upstream).
- Embedding + RAG retrieval over CDP records *and* the schema-context layer, so agents ground answers in both the data and its documented meaning.
- Agentic applications grounded in the knowledge graph — the context hooks established in Phase 1/2 are the retrieval surface.

**Consent-gated AI path:** training, embedding, and RAG serving honor opt-out / suppression and tenant isolation — not just the application serving layer. Opted-out or suppressed records are excluded from training corpora and retrieval; erasure propagates to embeddings (a deleted vault token dereferences to nothing). Consent is enforced at the data-access boundary the models/RAG read through (the governed access API, `phase-1-build.backend-data-model.tool-access-api`), so no AI path bypasses it.

**Acceptance (directional):** a labeled training/eval corpus exists, sourced from curation feedback and the contextualized schema; embedding/RAG retrieval runs over records + semantic catalog; consent/suppression is enforced across training, embedding, and serving (opted-out data excluded; erasure propagates to vectors); at least one custom/finetuned model or RAG application is demonstrated against production CDP data. Feasibility gated on data volume and label coverage from Phases 1–2.

**References:**
- Decided 2026-06-17 (Luis + Alicia, identity strategy Option A): deterministic-first matching with Tier 2/3 (pairwise ML, GNN/embeddings) deferred to Phase 2/3 behind Phase-1 schema stubs — the custom identity/match models this story trains — `memory/decisions.md#d-104`
- Decided 2026-06-18 (Alicia + Luis, A3): 15-table set = 11 core + 4 AI/ML stubs deployed empty-but-complete in Stage 1 (incl. `embedding_cache`) so ML is a model/config addition with zero migration — `memory/decisions.md#d-116`
- Decided 2026-06-13 (Dan + Mike): reuse the DAS AI layer (`ai.das-technology.com`), don't build parallel; CDP must be "good for AI and good for agentic events" — `memory/decisions.md`
- Decided 2026-06-19 (Alicia, Privacy-by-Design): suppression scope hybrid (regulatory opt-outs global, dealer opt-outs tenant-scoped) — the consent gate excluding opted-out records from corpora/retrieval — `memory/decisions.md#d-112`
- Decided 2026-06-21 (Leo): PII vault (delete-the-row) erasure — a deleted vault token dereferences to nothing, which is how erasure propagates to embeddings — `memory/decisions.md#d-012`
- `specs/03-phase-1-build/03-backend-data-model/12-ai-context-schema-conventions.md` · `specs/04-phase-2-build/01-source-onboarding/02-context-metadata-management.md` — the self-describing, labeled, contextualized schema (and its expansion) that is the precondition for this story
- `specs/03-phase-1-build/03-backend-data-model/14-tool-access-api.md` — the governed access API the models/RAG read through, where consent + tenant isolation are enforced for every AI path
- `wiki/Data-Model.md` · `docs/cdp-architecture.md` — the AI/ML stub tables and the four-layer architecture this builds on
