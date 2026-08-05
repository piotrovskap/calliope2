---
title: "AI-context schema conventions & knowledge-graph hooks"
type: story
status: planned
priority: high
estimate: L
depends_on: [phase-1-build.backend-data-model.data-model-foundation]
labels: [backend, schema, ai-readiness, knowledge-graph, conventions, 1b]
date: ~
---

Make the CDP schema **self-describing** so any AI agent reading a table, schema, or DDL gets the meaning *along with* the structure — no external doc lookup, no tribal knowledge. Bake this in at Phase 1: every entity ships with machine-readable context, hooked into the project knowledge graph. The throughline is simple — as long as data is well-structured, labeled, and contextualized, Phase 3 (custom models / RAG) becomes achievable; this story establishes the labels and context.

**Applies to every database object**, not just tables and columns: Django models, tables, columns, views, materialized views, functions, stored procedures, triggers, indexes, constraints, enums, and sequences. Each carries its own description and context — a view documents what it returns and why, a function/procedure documents its purpose, inputs, and side effects, an index documents the access pattern it serves. The rule is uniform: no database object ships undocumented.

**Schema conventions (the "PEP-8 for SQL") — all carried on the schema itself, not in a side doc:**
- **Description** — every object (table, column, view, function, procedure, index, constraint, enum) has a mandatory, non-empty description (`COMMENT ON` / Django `db_comment` + `help_text`). Nothing ships undocumented.
- **Format** — the value format/shape where it matters (email, E.164 phone, VIN, ISO-8601 timestamp, currency-with-units), beyond the raw SQL type.
- **Base / canonical type** — the semantic role above the storage type: identifier vs. email vs. phone vs. money vs. timestamp vs. free-text, and which canonical entity it maps to. Storage type (`varchar`, `int`) is not the meaning.
- **Nullable exceptions** — nullability is documented: when `NULL` is allowed and *why* (genuinely-optional vs. not-yet-populated vs. tenant-conditional). A nullable column without a stated reason is a defect.
- **Naming + constraints** — snake_case, documented constraints (FK/unique/check), units, provenance linkage per fact.

**Self-description artifact (the "AST for the database"):** a generated, machine-traversable representation of the live schema (information_schema + comments + constraints + semantic annotations → structured JSON/graph), kept in sync by CI, that agents traverse instead of raw DDL. Reuse the existing `scripts/parse-ddl.py` → `docs/databases/schema.json` pattern, pointed at the CDP's own schema.

**Knowledge-graph hooks:** every entity, column, format, base type, provenance link, and relationship registers as nodes/edges in the project knowledge graph (the Planopticon brain). The meaning lives in the graph *alongside* the data, so an agent queries the graph for context, lineage, and "what is this field, what's its format, where does it come from" without parsing DDL. KG-registration conventions are part of this story, not an afterthought.

**Acceptance:** every database object (table, column, view, function, procedure, index, constraint, enum) has a non-empty description; columns additionally declare format (where applicable), base/canonical type, and a nullability rationale — all enforced in CI (no undocumented object or unexplained-nullable column merges). A generated schema-context artifact regenerates from the live schema (covering all object types) and is validated current. Every object has a corresponding KG node with its semantic metadata and provenance. An agent can answer "what is this object, its format/canonical type, and its source/purpose" from the artifact/graph alone.

**References:**
- `docs/knowledge-engine.md` — the brain/KG schema this story hooks into: DDL→schema-AST adapter, `scripts/parse-ddl.py` → `docs/databases/schema.json` materialization, and the provenance-complete invariant every node must satisfy.
- Decided 2026-06-18 (Alicia + Luis, A3 identity + schema design): per-fact provenance and bitemporal/provenance shapes locked — the per-element provenance linkage each column registers — `memory/decisions.md#d-082`
- `wiki/Data-Model.md` — per-fact provenance and bitemporality model the canonical/base-type and provenance annotations map onto.

This is the anchor of the Phase-1 AI-readiness set; it is completed by its siblings: the semantic glossary (`semantic-glossary-term-registry`), the governed multi-transport access API (`tool-access-api`), the embedding/vector hook (`embedding-vector-hook`), the versioned event contract (`versioned-event-contract`), and curation feedback labels (`phase-1-build.identity-curation-data-quality.curation-feedback-labels`).

Phase 2 applications manage and expand these references (`phase-2-build.source-onboarding.context-metadata-management`); Phase 3 leverages the structured/labeled/contextualized corpus for custom models and RAG (`phase-3-ai-ml.ai-ml-enhancements.custom-models-rag-on-cdp`).
