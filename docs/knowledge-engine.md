---
title: Knowledge Engine (Brain) — Data Schema
type: reference
updated: 2026-06-14
---

# Knowledge Engine (Brain)

The brain is a single compiled **knowledge graph** over everything structured in this repo. It models docs and data as **AST graphs**: every artifact parses into typed nodes whose leaves *reference source spans*, and a semantic overlay (the KG) weaves them together. It is encoded as JSON (portal/editable) and SQLite (queryable), with Cloudflare D1 as an optional edge deploy.

This document is the schema. It is the design contract for the generators in `scripts/` that compile the brain. The brain itself is a **generated projection** — never hand-edited (see [`source-of-truth.md`](source-of-truth.md)).

## Invariants

These are hard rules. The compiler and its CI validator enforce them; a violation fails the build.

1. **No new data — only relationships.** The brain is purely derivative. It relocates and *relates* existing data; it never authors facts. Its value is the **edges**.
2. **Provenance-complete.** Every node carries a resolvable `source` (path + locator) or is explicitly flagged purely-derived. Every `data` field traces to its origin artifact. Anything in the output that cannot be traced to a source or a declared overlay is a build failure (the hallucination guard).
3. **Index + references, not ingestion.** No markdown prose is copied into the brain. A node stores the pointer (`path#anchor`) and extracted structure (headings, links, frontmatter); the body stays in the file.
4. **Source ⊥ projection.** The existing stores remain the canonical, editable sources. The brain is generated, drift-gated in CI, and never hand-edited.
5. **Federated memory stays.** `memory/*.md` remain canonical and human-authored; the brain mirrors them as index nodes, it does not replace them.
6. **Non-destructive + reversible.** No existing curated artifact is retired until its content is proven present in the regenerated output (golden-baseline equivalence, below). Everything ships via PR.

## The model

The brain is a **forest of per-artifact ASTs plus a semantic overlay**, expressed as one uniform `node` / `edge` graph:

- Each **source kind** has exactly one **adapter** (parser) that emits nodes and edges into a shared vocabulary. Markdown -> doc-AST; DDL -> schema-AST; JSON stores -> record nodes; memory -> index nodes; sessions -> semantic KG nodes. Eventually: code -> code-AST, same vocabulary.
- **Leaves reference, never ingest.** A `Document` node stores `{path, title, headings, refs}` and a `locator`; the prose stays in the `.md`.
- **The KG is the semantic slice** of the same graph, not a separate artifact. SQLite + FTS5 is the queryable encoding.

## Envelope

Every node and edge carries provenance, durability, and (where stateful) lifecycle. Uniform `node` / `edge` shape with a `kind` / `type` discriminator and a JSON `data` payload keeps the graph polymorphic but queryable in SQLite.

```
node = {
  id,                        # stable, kind-prefixed: "db:megatron", "tbl:megatron.Account",
                             #   "field:CustomerFirstName", "doc:docs/discovery-guide.md", "q:Q11", "kgn:CDP",
                             #   "dec:<slug>", "grf:<slug>", "cat:<id>", "phase:phase-0", "step:<id>", "acc:<slug>"
  kind,                      # see Node kinds
  label,                     # human name
  source: { path, locator }, # canonical editable origin + anchor; null only if purely-derived
  derived: false,            # true => purely-derived (no single source span); must still be traceable
  provenance: { sessions[], commit, generated_at },
  durability,                # durable-logic | point-in-time | ephemeral
  status?, owner?,           # stateful records (questions, decisions, action items, RAID)
  updated, version,
  data: { ... }              # kind-specific payload (column type, decision why/how, ...)
}

edge = {
  id, src, dst, type,        # type from the controlled set (structural) or free-text (semantic)
  class,                     # "structural" | "semantic"
  provenance: { session?, source? },
  data?: { ... }
}
```

**Durability** classifies how a datum ages, so drift is interpreted correctly:

- `durable-logic` — architecture, patterns, decisions. Should not silently change.
- `point-in-time` — counts, statuses, access state. Expected to change; tracked by timestamp.
- `ephemeral` — discovery scratch (IP probes, transient observations). Low-trust, retained for trace.

## Node kinds

| kind | source (canonical) | adapter | durability | payload highlights |
|---|---|---|---|---|
| `Document` | any `.md` (docs/, analysis/, wiki/, memory/) | markdown | point-in-time | title, headings[] (text only, ≤40), refs[] — index only; headings are a Document field, not separate nodes |
| `Memory` | `memory/*.md` | markdown | durable-logic | type (reference/decision/process/inventory/tracking), updated — mirror, not replace |
| `Database` | `docs/databases/<id>.md` frontmatter | databases | point-in-time | source server, status, access, owner, researcher |
| `Table`* | `docs/databases/dumps/<db>.sql` | ddl | durable-logic | row-count hint, comment |
| `Column`* | DDL | ddl | durable-logic | type, nullable, is_pk |

\* `Table`/`Column` are **materialized in `docs/databases/schema.json`** (by `scripts/parse-ddl.py`) and referenced from `Database` nodes via `data.schema_ref`; they are **not** emitted as `brain.json` graph nodes (32k columns would swamp the connective graph). They are promoted into the graph as nodes only when a cross-domain edge attaches — e.g. a resolving `sourced-by` from a `Field`. Query column-level structure through `schema.json` or the SQLite encoding.
| `Field` | `docs/cdp-field-source-matrix.md` | field-matrix | durable-logic | cdp_target, provider coverage, status (OK/VALIDATE/GAP) |
| `Decision` | `memory/decisions.md` (+ tracker) | decisions | durable-logic | statement, why, how-to-apply, date, supersedes |
| `OpenQuestion` | `memory/open-questions.md` | questions | point-in-time | status (open/answered/parked), priority, owner, asked/answered |
| `ActionItem` | `analysis/action-items.json` | passthrough | point-in-time | assignee, priority, deadline, status, session |
| `Risk` | `app/raid.json` | passthrough | point-in-time | type, severity, status, owner, mitigation |
| `Session` | `analysis/sessions/*/manifest.json` + registry | sessions | durable-logic | key, date, title, system, artifacts[] |
| `Concept` `Person` `Organization` `Technology` `Time` | per-session KG | kg-federate | point-in-time | descriptions[], sessions[] (provenance) |
| `Phase` | `docs/phase0-deliverables.json` (roadmap deliverable `roadmap[]`); `analysis/artifacts/engagement-timeline/timeline.json` (`phases[]`/`groups[]`) | deliverables / timeline | point-in-time | state/active, focus, detail, sub, badge |
| `Workstream` `Story` | `specs/manifest.json` | specs | point-in-time | status, priority, spec_type, parent_id |
| `Deliverable` | `docs/phase0-deliverables.json` | deliverables | point-in-time | type, summary, md_link |
| `GoldenField` | `analysis/artifacts/golden-record/record.json` | golden-record | point-in-time | tier, status, sources[], note, section |
| `Catalog` | `analysis/artifacts/ssis-job-catalog-v2.json` | ssis | point-in-time | description, type, href, supersedes, source_sessions[] (manifest index) |
| `Step` | `analysis/artifacts/engagement-timeline/timeline.json` (`steps[]`) | timeline | point-in-time | desc, date, status, tags[], output/produces, group, deliverable |
| `AccessRequest` | `analysis/artifacts/access-tracker/access.json` | access | point-in-time | resource, type, status, owner, note, detail, section |

The existing stores (`databases.json`, `action-items.json`, `raid.json`, `specs/manifest.json`, ...) are already versioned and provenance-bearing. The adapters read them as sources; they are not replaced.

## Edge kinds

**Structural** (`class: "structural"`, controlled vocabulary):

| type | from -> to | meaning |
|---|---|---|
| `has-table` | Database -> Table | DB contains table |
| `has-column` | Table -> Column | table contains column |
| `fk` | Column -> Column | foreign-key reference |
| `sourced-by` | Field -> Column | a CDP field is sourced from a physical column — lands the field catalog onto real schema |
| `references` | Document -> any | extracted from `.md` links |
| `gates` | OpenQuestion -> Decision/Deliverable | question blocks a decision/deliverable |
| `produces` | Session/Workstream -> Deliverable | work yields a deliverable |
| `arose-in` / `decided-in` | record -> Session | provenance to the session a record/decision came from |
| `derived-from` | Catalog -> Session | a catalog/artifact derived from a session |
| `in-phase` | Step -> Phase | a timeline step belongs to a phase/group |
| `grants-access-to` | AccessRequest -> Database | an access request targets a database |
| `owns` | Person -> ActionItem/Workstream | ownership |
| `supersedes` | Decision -> Decision, Memory -> Memory, Catalog -> Catalog | replacement with history |
| `mentions` | Session -> Concept | semantic provenance |

**Semantic** (`class: "semantic"`, free-text): the ~900 transcript-derived relation types stay free-text but tagged, carrying their raw `type` and `session`. We separate controlled structural edges from emergent semantic ones rather than forcing a taxonomy.

## Encodings

One schema, three encodings:

- **`app/brain.json`** — `{ meta: {version, generated_at, sources[]}, nodes: [...], edges: [...] }`. Git-tracked, in `PORTAL_GENERATED`, drift-gated in CI; fetched by the portal like today's `knowledge_graph.json`.
- **`brain.db`** (SQLite) — tables `node`, `edge`, `node_fts` (FTS5 over label + headings + frontmatter + memory descriptions — metadata, not bodies). Built from `brain.json`; round-trips back to JSON losslessly. Derived/untracked: built into `_site/` and on demand via `make brain-db`, mirroring the `_site/` discipline, to avoid binary-diff churn.
- **Cloudflare D1** — gated. A `[[d1_databases]]` binding in `wrangler.toml` plus a Worker `/api/brain?q=` endpoint loaded from the `brain.db` dump. Specced now; built only when static JSON plus client-side query proves insufficient for server-side/agent queries.

Planopticon (`/kg`) already reads `.db` or `.json`, so the SQLite query surface is adopted, not invented.

## KG federation

The semantic slice is today fragmented (two disagreeing federated graphs, per-session graphs with zero edges, hand-applied patch scripts, no version field). It becomes a single reproducible source:

1. **Session registry** — `analysis/sessions/catalog.json`: `dir -> {key, date, title, system, phase}`. Resolves the ad-hoc directory-name truncation and the two-kickoff key collision; becomes the `Session` node source.
2. **`gen-kg.py`** — deterministic federation: read per-session graphs, merge nodes by canonical id, union `sessions` provenance, dedupe edges by `(src, dst, type)`, emit versioned `app/knowledge_graph.json` (+ `.db`).
3. **Curation overlay** — `analysis/kg-curation.json`: the `MERGE` / `REMOVE` / `TYPE_FIXES` dictionaries currently embedded in `analysis/curate_kg.py`, **plus** the findings the one-off patch scripts encode (MediaLogix 9-database inventory, CCID-non-functional, the Server-IP / Azure-migration hypothesis), expressed as declarative add/append/edge/suppress entries the generator applies. Reproducible; nothing lost.
4. **Golden-baseline safety** — the current curated graph is frozen as a baseline. The regenerated graph must be a proven **superset** of every baseline node/edge and every migrated finding; the hallucination guard fails the build on any untraceable node/edge. Forks (`knowledge-graph{,-v2,-v3,-curated}/`) and patch scripts are retired only after the equivalence test passes in CI.

## Verification

- **Idempotent** — each generator run twice produces no diff; preserves `generated_at` on no-op.
- **Provenance-complete** — the validator asserts every node has a resolvable `source` (or `derived: true` with a traceable basis), and every node/edge maps to a source artifact or the overlay. Untraceable output fails.
- **Golden-baseline superset** — regenerated KG ⊇ frozen curated KG (nodes, edges, migrated findings).
- **Counts reconcile** — total node/edge counts equal the sum across adapters.
- **Cross-domain queries work** — e.g. "OpenQuestions that gate a Deliverable", "Fields sourced from Megatron", "neighbors of CDP".
- **Round-trip** — `brain.json -> brain.db -> brain.json` is lossless.
- Wired into `make portal-verify` and `portal-generated-clean`; merges via `/pr` (branch protection: PR + `ci` green).

## Build phases

Tracked in #38 (epic) and #39-#43. Phase 1 (this schema) is the design gate; Phases 2-5 are the sequenced build, each a separate PR.
