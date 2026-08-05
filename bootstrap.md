# DAS CDP — Workspace Bootstrap

> **What this file is.** This is the cross-repo entry point at the root of the DAS CDP workspace metarepo. Read it before touching anything. It covers structure, project context, conventions, and common workflows. Each individual subrepo will have its own `bootstrap.md` for repo-local concerns; this one is workspace-wide.

> **The engagement:** building a Customer Data Platform for DAS Technology (Digital Air Strike). One system that ingests consumer and vehicle data from CRMs, DMS platforms, ad channels, and internal apps — resolves it to a single consumer identity, stores it clean, and exposes it via API.

---

## 1. Project Context

**Client:** Dan Aston — DAS Technology (Digital Air Strike)
**Engagement type:** Forward-deployed — CONFLICT engineers embedded with the DAS team

### The Problem

DAS has consumer and vehicle data scattered across CRMs, DMS platforms, ad channels, and internal apps with no unified view across dealerships. Every downstream application (including the Vehicle Smart Score) solves the same identity and data aggregation problem from scratch.

### The Solution

A Customer Data Platform (CDP):
- Source onboarding through a universal ingestion spine (webhook, event stream, bulk upload, batch pull) as required by product outcomes
- Identity resolution engine — deterministic matching → conflict review queue → ML extension (Phase 3)
- Multi-tenant isolation — PostgreSQL row-level security, dealership data siloed, DAS maintains global view
- Consumer 360° profile API — single query returns attributes, vehicles, events, consent, identity links
- 4-role access model: `das_admin`, `das_analyst`, `dealer_admin`, `dealer_user`

### Data Model (Field Catalog v1 — initial 27 data points across 5 categories)

| Category | Data Points |
|----------|------------|
| Vehicle & Owner Info | VIN, year/make/model/trim, mileage, condition, owner name/email/phone, dealer customer ID |
| Service & Parts | Service records, parts purchases, service dates |
| Service History | Historical service events, technician notes |
| Vehicle Protection | Warranty, extended service contracts |
| Equity / Trade-In / Insurance | Equity position, trade-in value, insurance provider |

Core tables: `dealership`, `consumer`, `consumer_dealership`, `consumer_attribute`, `vehicle`, `consumer_vehicle`, `identity`, `identity_link`, `event`, `consent`, `merge_history`

> **Field Catalog v1 — the initial 27 — is the bare-minimum MVP floor, not the architecture ceiling. We are building and designing past MVP.** They're the first slice to prove the pipeline — not the design target. DAS frames them as "the core of a much larger picture" (100+ sources feed enrichment). Architect for **post-MVP** from day one: the EAV + JSONB attribute model (14 of the 27 already use it) absorbs new fields without migration, and an "inventory item" generalization extends beyond vehicles to other verticals. Design the data model, identity graph, and ingestion to scale well past the v1 catalog — don't optimize around exactly these fields. Field-level scope/availability and post-v1 candidates: `docs/cdp-field-source-matrix.md`.

---

## 2. Workspace Layout

```
das-tech/                         ← this metarepo (you are here)
├── .gitmodules                   ← submodule pointers (pinned SHAs)
├── README.md
├── bootstrap.md                  ← you are here
├── PROCESS.md                    ← release / commit / branch conventions
├── Makefile                      ← workspace-level targets
├── CLAUDE.md / AGENTS.md               ← agent shims → bootstrap.md (AGENTS.md = Codex)
├── memory/                       ← workspace memory (cross-repo decisions)
│   └── MEMORY.md                 ← always-loaded index
├── artifacts/                    ← source docs + deliverables (see artifacts/README.md)
│   └── phase-0/
│       ├── kickoff/              ← kickoff agenda + notes
│       ├── source-docs/          ← DAS source documents (MVP spec v4, Architecture Plan v3)
│       └── deliverables/         ← Phase 0 deliverable docs (produced — see docs/deliverables/)
├── analysis/                     ← Planopticon meeting analysis outputs
│   └── kickoff-2026-05-27/
└── wiki/                         ← GitHub wiki submodule (knowledge base)
    ├── Home.md
    ├── Kickoff-Questions.md      ← 16 kickoff Q's with answer status
    └── ...
```

**Artifacts vs. Wiki:**
- `artifacts/` — primary source docs (DAS specs, deliverables). For both human and AI consumption. Versioned with the repo.
- `wiki/` — living knowledge base. Updated continuously. Cross-referenced and structured for navigation. The canonical reference for project state.
- `analysis/` — Planopticon outputs (transcripts, knowledge graphs). Raw meeting intelligence.

**Subrepos (added as submodules when build begins — stack TBD via Phase 0):**

| Repo | Owns |
|------|------|
| `das-cdp-app` | Backend (API, ingestion engine, identity resolution, batch pipeline) + Frontend (admin dashboard, consumer 360°, dealer portal) |
| `das-cdp-opscode` | Infrastructure-as-code, deployment topology, CI/CD pipelines |
| `das-cdp-dags` | Airflow DAGs — batch ETL per source system (managed or self-hosted Airflow), the modernized replacement for the legacy SSIS pipeline (discovery inventory: `docs/etl-data-inventory.md`) |
| `das-cdp-docs` | External documentation site |

Stack for each repo is determined by Phase 0 findings. See `wiki/Tech-Stack.md`.

---

## 3. Phase 0 — Discovery (COMPLETE — awaiting DAS sign-off)

**Duration:** ~1 month, started 2026-05-27
**Output:** Three documents. No code, no infrastructure.

**Deliverables (agreed at 2026-05-27 kickoff):**
1. Executive Summary — findings, recommendation, roadmap
2. Revised CDP Architecture Plan — rewrite of DAS's Architecture v3 with actual findings
3. DAS CDP Roadmap — four sub-documents:
   - CDP Scoping Document (converts to build backlog)
   - Security- and Privacy-by-Design Framework for Dealer Data
   - Identity Resolution Policy, Strategy & Identity Graph Plan
   - Detailed Phase 1 & Phase 2 Plans (enables fixed-scope Phase 1 SOW)

See `wiki/Phase-0.md` for the full scope, open questions, and kickoff findings.

**Phase framing:**

| Phase | Meaning |
|---|---|
| **Phase 0 — Discovery** | COMPLETE (deliverables produced; awaiting DAS sign-off). Validate reality, document architecture, security/privacy posture, identity policy, risks, and buildable scope. |
| **Phase 1 — Build** | Productionized CDP V1: data model, tenant security, priority ingestion framework, golden record, identity resolution, APIs, operational surfaces, and VSS-ready consumer record. |
| **Phase 2 — Applications** | Application layer on top of CDP data: activation, dashboards, utilities, source-onboarding console, and downstream product surfaces. |
| **Phase 3 — AI/ML** | Advanced identity, model-assisted review, predictive/decisioning layers, and agentic/AI applications. |
| **Future horizon** | Phase 4+ remains directional until Phase 1/2 produce live operating evidence. |

Full source ingestion is not a standalone roadmap driver. The ingestion framework starts in Phase 1, source coverage expands through Phase 1/2 as CDP applications require it, and onboarding continues after Phase 3 as DAS adds systems and use cases.

---

## 4. Submodule Discipline

### Cloning

```bash
git clone --recurse-submodules git@github.com:ConflictHQ/das-tech.git
git submodule update --init --recursive   # if already cloned without --recurse
```

### Push order (mandatory)

When a change spans more than one repo:
1. Push the submodule(s) first
2. Commit the metarepo with the new submodule SHAs
3. Push the metarepo

A metarepo commit must never reference a submodule SHA that isn't reachable on the remote. A dangling reference (metarepo bump pointing at an unpushed wiki SHA) breaks `pull`/`merge` for everyone — the gitlink merge fails with `commits not present` and PRs go `CONFLICTING`. Safe path: `make all-push` (submodules then metarepo, in order). Verify: `git -C wiki branch -r --contains "$(git rev-parse @:wiki)"` must be non-empty before pushing the metarepo. See `PROCESS.md` §5.

### Updating submodules

```bash
git submodule update --remote --merge   # pull each submodule's tip
```

Review each submodule's diff before staging the metarepo update. Bumping a submodule pointer is a meaningful commit — don't batch it with unrelated work.

---

## 5. Conventions (Non-Negotiable)

These apply across all submodules. Every contributor and agent shim respects them.

- **No rebases.** New commits only. Ever.
- **No AI / co-author attribution** in commit messages or PR bodies. If your agent tooling (Claude Code, Codex, Copilot) appends a `Co-Authored-By` trailer by default, turn it off.
- **No force pushes** to `main`.
- **Commit identity.** Author commits with your `@weareconflict.com` email — set per-repo (`git config user.email`), and add that email to your GitHub account. Not a personal address. See `PROCESS.md` §8.
- **Self-check before pushing: run `make ci-checks`.** There is no pre-commit hook or CI — the gate (no `Co-Authored-By` trailers, `@weareconflict.com` author identity, submodule SHAs resolvable) only runs if you run it. It scans your unpushed commits only; published history is never rewritten. See `PROCESS.md` §6.
- **Branch naming:** `feature/<area>-<short>`, `fix/<area>-<short>`, `chore/<short>`. Reference issue number.
- **Specs live in `specs/` during discovery.** Hierarchical spec tree (epic → feature → story — see `specs/README.md`). Converted to GitHub issues (or the chosen PM tool) when build begins.
- **Prefer agent-friendly, diffable formats — avoid binary office docs.** Author deliverables and specs in Markdown (or another plain-text, openable format). Do **not** commit `.docx`/`.xlsx`/`.pptx` unless there is no alternative (e.g. a DAS-provided source doc in `artifacts/`); binaries don't diff, agents can't read them, and they corrupt silently in git without binary attributes. If a tool only exports office formats, also commit a Markdown rendering alongside it. Existing `.docx` deliverables get re-authored to `.md`.
- **Auth check on every endpoint.** First line of every resolver/controller.
- **Group-based permissions only.** Never assign permissions to users directly.
- **Soft deletes only.** Never hard-delete business objects.
- **No integer PKs in APIs.** UUID or cuid.
- **Real database in tests.** Never mock the database.
- **Multi-tenant safety.** Every query is scoped to the tenant in context. Unscoped queries are bugs.
- **Semantic density.** Docs, descriptions, and artifacts maximize information per token — no filler, no restated context. Read by humans (scanning) and agents (finite context budget); dense content is cheaper to load and faster to read. Precision is the lever: choose the exact, specifically-loaded term over vague phrasing — the right word carries what would otherwise take a clause. Prefer tables/lists over prose for structured data; link instead of restating.
- **Extending the corpus.** To add data sources, code/data repos, documents, sessions, or portal data as the team grows, follow the repeatable practice in [`docs/discovery-guide.md`](docs/discovery-guide.md).
- **Page naming + no duplicates.** One page per subject; **search for an existing page before creating one** (an agent's second research pass must update the existing page, never spawn a parallel one). Naming is fixed by type — do not invent variants (e.g. `-Info`, `-Notes`):
  - Wiki API/source research → `<Service>-API.md`, Title-Case-Hyphenated (e.g. `Carfax-API.md`, `Google-Ads-API.md`).
  - Wiki structural/topic pages → `Title-Case-Hyphenated.md` (e.g. `Identity-Resolution.md`).
  - DB pages are **generated** into `docs/databases/<db-id>.md` (lowercase-hyphenated) by `make` — never hand-create.
  - Service/brand casing follows the vendor (e.g. `Mailgun`, not `MailGun`).
  New research pages: add a catalogue entry in `docs/wiki-research-catalog.json` (category + tags) and link from `wiki/Home.md` so they're indexed, not orphaned.

---

## 6. Workspace Makefile Targets

| Target | What it does |
|--------|-------------|
| `make bootstrap` | Initialize submodules to pinned SHAs; print next steps |
| `make sync` | Pull tip of each submodule; prompt to review and stage |
| `make pin` | Force submodules to the SHAs the metarepo references |
| `make all-status` | `git status` for metarepo + each submodule |
| `make all-push` | Push each submodule, then the metarepo (correct order) |
| `make all-fmt` | Run each submodule's formatter |
| `make all-lint` | Run each submodule's linter |
| `make all-test` | Run each submodule's test suite with real Postgres |
| `make all-verify` | `all-fmt` + `all-lint` + `all-test` |
| `make wiki-sync` | Pull latest wiki content from the GitHub wiki remote |

---

## 7. Knowledge Base

The `wiki/` submodule is the project's federated knowledge base. It is a GitHub wiki — flat file structure, all pages at the root as `Page-Name.md`.

**Wiki branch: `master` only.** GitHub renders the wiki exclusively from `master` (hardcoded — `main` or a renamed branch makes the wiki vanish). All wiki commits go to `master`; never push wiki content to `main` or SHA-named branches (they don't render and fork the wiki). When bumping the `wiki` submodule pointer, the SHA must be on `master` and pushed. See `PROCESS.md` §5.

**Branch naming is inverted vs. the code repo.** The `das-tech` code repo's primary is `main` and `master` is locked (ruleset `lock-master-branch`); the wiki's primary is `master` and `main` must not exist. Wikis cannot be branch-protected (not in the GitHub rulesets API), so the wiki's `main` is held off by manual deletion, not a rule — delete any stray `main`/SHA-named wiki branch on sight. See `PROCESS.md` §5 for the full table.

Key pages:
- `Home.md` — navigation index
- `Project-Overview.md` — client context, goals, what we're building
- `Architecture.md` — stack decisions, system topology
- `Data-Model.md` — Field Catalog v1 (initial 27, designed to grow), core tables, schema decisions
- `Identity-Resolution.md` — matching strategy, conflict queue design
- `Ingestion-Channels.md` — 4 channels, priority order, implementation approach
- `Multi-Tenancy.md` — RLS strategy, tenant isolation model, role definitions
- `Phase-0.md` — Phase 0 scope, deliverables, timeline
- `Kickoff-Notes.md` — 2026-05-27 kickoff meeting notes
- `Roadmap.md` — Phase 1 MVP/build, Phase 2 applications & activation

---

## 8. Knowledge Graph

A Planopticon knowledge graph built from the Phase 0 kickoff meeting transcript and wiki documents lives at:

```
app/knowledge_graph.json
```

This is the **single generated federation** (used by the app viewer and the `/kg` skill). Regenerate it with `python3 scripts/gen-kg.py` (federates per-session graphs per `analysis/sessions/catalog.json` with the `analysis/kg-curation.json` overlay); `scripts/check-kg.py` validates it (superset of frozen baselines, no untraceable nodes/edges). See `docs/knowledge-engine.md` for the schema.

**Query it:**
```bash
export $(grep -v '^#' /Users/ragelink/repos/conflict/CONFLICT.env | xargs)
planopticon query --db-path app/knowledge_graph.json --mode agentic "<question>"
```

**Via skill:** Use the `/kg` skill (global) for shortcuts — `stats`, `entities`, `neighbors`, `path`, `clusters`, or any natural language question.

**Viewer:** Open `app/index.html` via `python3 -m http.server 8080` → `http://localhost:8080/app/` for the visual explorer.

---

## 9. Memory System

`memory/MEMORY.md` is always loaded at conversation start. It stores cross-repo decisions and context that would otherwise require re-reading every spec.

See `memory/MEMORY.md` for the current index.


---

## 10. Keeping the Stakeholder Deck Current

The **Phase 0 Discovery Deck** lives at `docs/das-cdp-phase0-discovery-deck.html` — a self-contained slide deck (current-state findings, target architecture, Field Catalog v1 — the initial 27 MVP data points, source mapping, open decisions). Edit the slides directly in the HTML; there is no separate data file. It's surfaced via the Deliverables gallery and the `stakeholder-deck` artifact — update `analysis/artifacts/stakeholder-deck.json` if the title or href changes. Record any decisions reached in `memory/decisions.md` (the canonical log).

---

## 11. Portal Data Accuracy

**Rule: no count, status, or list in portal HTML is hardcoded.** Everything must come from a JSON data file.

Full inventory: [`docs/portal-data-inventory.md`](docs/portal-data-inventory.md)

Quick reference — the files that drive the portal:

| File | Drives | How to update |
|---|---|---|
| `analysis/catalog.json` | Session/artifact counts everywhere | Regenerated by Planopticon after each session |
| `docs/manifest.json` | Doc counts everywhere | Regenerated by `scripts/gen-docs-manifest.py` (or equivalent) |
| `app/knowledge_graph.json` | KG entity/edge counts | Generated by `scripts/gen-kg.py`; validated by `scripts/check-kg.py` |
| `activity.json` | Homepage activity feed | `python3 scripts/gen-activity.py` before each push |
| `analysis/action-items.json` | Global action items page | `python3 scripts/gen-action-items.py` after each new session |
| `analysis/artifacts/access-tracker/access.json` | Access tracker + homepage tag | Edit status field; bump `version`, `updated`, append `changelog` |
| `docs/deliverables.json` | Deliverables gallery | Add item to `items` array; bump version |

**Before editing any portal HTML page** — check this file list. If the data you're changing belongs in one of these files, edit the JSON, not the HTML.

**Before pushing** — run `python3 scripts/gen-activity.py && git add activity.json` to keep the activity feed current.

**Versioning convention:** All hand-maintained JSON files carry `version` (int), `updated` (YYYY-MM-DD), and `changelog` (array, newest first). Bump all three on every change.

---

## 12. Planopticon Analysis Pages — Branding & Fixups

Every `analysis/sessions/*/results/analysis.html` file generated by Planopticon must have two post-generation patches applied:

### A. CONFLICT brand overlay (injected at generation time)

A `<style>` block is injected at the top of `<head>` before Planopticon's own styles. It sets brand tokens, overrides fonts/colors with `!important`, and adds a fixed top-bar (`#_conflict-topbar`) with a back link. When adding a new session analysis page, verify this block is present. If Planopticon regenerates the file, re-apply it from any existing `analysis.html` in the repo (they all share the identical block).

The block ends with these two rules — keep them in every analysis page:

```css
  /* suppress Planopticon template title duplicate — markdown headings carry anchor IDs, template ones don't */
  h1:not([id]){display:none!important}
```

### B. Duplicate heading fix

Planopticon produces two heading duplications per analysis page:

1. **Title duplication** — a no-ID `<h1>` (template wrapper) AND an ID-anchored `<h1 id="...">` (from the markdown `# Title`). The CSS rule `h1:not([id]){display:none!important}` hides the wrapper one.

2. **Section header duplication** — template injects `<h2 id="summary">` immediately before the markdown `<h1 id="summary_1">`. CSS can't select a preceding sibling, so a one-liner script at the bottom of `<body>` handles it:

```html
<script>document.querySelectorAll('h2+h1').forEach(function(h1){var p=h1.previousElementSibling;if(p&&p.tagName==='H2')p.style.display='none'});</script>
```

Both fixes are already applied to all current analysis pages. Apply the same pattern to any new ones.

---

## 13. ETL Codebase (former `etl/` submodule — removed)

The DAS SSIS codebase (stored procedures, job definitions) was checked in as a submodule during extraction:

| Field | Value |
|-------|-------|
| Path | `etl/` |
| Remote | `git@github-das:3birdsmarketing/Database-Processes.git` |
| Org | `3birdsmarketing` (DAS's GitHub org) |
| Added | 2026-06-09 |
| Removed | 2026-06-11 — extraction complete, knowledge lives in `docs/etl-data-inventory.md` |

### What was in it

**231 SQL objects across 20 modules / 5 platforms** (far beyond the SSIS jobs alone):

```
etl/
├── SSIS/              ← SQL Server: CRM (68), DMS (13), CVH (17), Email (19), BlueSky (10)
├── Mautic/            ← legacy↔Mautic sync: Contact Sync (8), Company Sync (6)
├── PostgreSQL (Analytics Mautic)/  ← CDXP marketing schema: 11 modules (25) —
│                         Sync Processes, Contact & Engagement Build, Marketing Insights,
│                         Customer Value, Lead Source Index, Recall, Client Advocate,
│                         CDXP Watch Rule, Archival & Deletion, SMS Replies, Performance
├── Juicebox Reporting/ ← 58 dashboard data-engine procedures
└── BlackBook/         ← vehicle equity valuations (7)
```

The **full verified catalog** — every module's purpose, key procedures, data flow, identity-join (CVH) analysis, and CDP ingestion guidance — is in [`docs/etl-data-inventory.md`](docs/etl-data-inventory.md) (extracted + verified 2026-06-09). Read that, not this summary, for detail.

### CDP relevance

- The CVH module is the current platform-wide identity join (CRM + DMS → CVH). The CDP replaces this with full identity resolution.
- **CDP ingestion should pull from raw SSIS source tables**, not post-processed CVH or DWRPT views.
- The stored procedures here become the authoritative reference for what data each job reads and writes during Airflow migration planning.
- The `etl/SSIS/CRM/` procedures reveal the full set of CRM providers and their data variants — key input for the CDP ingestion channel design.

### Re-cloning for further extraction

The submodule was a **documentation source, not a permanent dependency** — the useful knowledge was extracted into [`docs/etl-data-inventory.md`](docs/etl-data-inventory.md) and the submodule removed. To re-clone if further extraction is needed: deploy key at `~/.ssh/id_ed25519_das`, then `GIT_SSH_COMMAND="ssh -i ~/.ssh/id_ed25519_das -o IdentitiesOnly=yes" git clone git@github.com:3birdsmarketing/Database-Processes.git etl` (clone outside version control or re-add as a submodule; `etl/` is no longer in `.gitmodules`). No `github-das` host alias is required — the `GIT_SSH_COMMAND` form works directly.
