# Discovery Contribution Guide

How to extend the DAS CDP discovery corpus as the team clones this repo and brings in more data. Read [`bootstrap.md`](../bootstrap.md) first — it holds the non-negotiable conventions; this is the practical how-to for *adding* material.

Everything here optimizes for two readers: **humans scanning** and **agents with a finite context budget**. Keep additions [semantically dense](../bootstrap.md) — max information per token, precise terms.

---

## Input types → where they land

| You have… | Lands in | Tooling | Core convention |
|---|---|---|---|
| A meeting / recording | `analysis/sessions/<id>/` | Planopticon (`/planopticon`) | Brand overlay + heading fix (see `bootstrap.md` §12) |
| A document shared with us | `artifacts/phase-0/source-docs/` | manual / pandoc | Originals + processed (below) |
| Confluence page(s) | `artifacts/phase-0/confluence/` | `scripts/repull-confluence.py` | Re-pull, don't hand-edit |
| A code or data repo (ETL, app, etc.) | submodule → extract → **remove** | git submodule + deploy key | Read-only extraction (below) |
| A database you have access to | `docs/databases/<db>.md` (+ `dumps/`, `erd/`) | schema dump + ERD tool | Per-DB doc; describe from the dump ([`databases/README.md`](databases/README.md)) |
| A roadmap item (epic / feature / story) | `specs/<phase>/…/NN-<slug>.md` | `specs/_gen.py` | Numbered-folder tree; regen manifest ([`specs/README.md`](../specs/README.md)) |
| A count / status / list shown in the portal | a versioned JSON data file | — | Never hardcode ([`portal-data-inventory.md`](portal-data-inventory.md)) |
| A new portal view/page | `…/<id>/index.html` + descriptor | — | Data-driven + catalog-registered |

---

## Cross-cutting conventions (every addition follows)

1. **Semantic density.** Max info per token; precise, domain-correct terms; tables/lists over prose; link instead of restating.
2. **Originals + processed.** Keep the authoritative original (`.docx/.pdf/.html/.xlsx`) *and* a machine-readable `.md`, cross-linked. The `.md` is what we pull from/cite. See [`artifacts/README.md`](../artifacts/README.md).
3. **Portal accuracy.** Every count/status/list comes from a JSON data file with `version`/`updated`/`changelog`. Never hardcode. See [`portal-data-inventory.md`](portal-data-inventory.md).
4. **Identity separation.** ConflictHQ work uses the CONFLICT identity (`Leo Mata <lmata@weareconflict.com>`). Never steadymd. Verify `gh auth status` + `git config user.email` before committing/filing.
5. **Verify substantial extractions** with multiple passes (workflow fan-out + adversarial review + a final single-thread top-down read).

---

## Quality standards & references

Every contribution must be **traceable and verifiable** — an agent reading our docs should be able to confirm each claim against a real source. These are requirements, not suggestions.

**Provenance — every fact cites its origin.**
- Name the real artifact behind each claim: repo file path, Confluence `page_id`, SQL proc/table name, recording + timestamp. No assertion without a locatable source.
- Lead a substantial doc with a provenance/verification blockquote: what it's derived from, how it was verified, known drift. Pattern: the header of [`etl-data-inventory.md`](etl-data-inventory.md).

**Asserted vs inferred — never blur the two.**
- State only what the source supports. Mark inference, derivation, or open questions explicitly (`VALIDATE`, "open Q", "derive from …") rather than presenting them as fact.
- **Don't invent names.** Verify every referenced file / proc / table / count actually exists before asserting it. (We once shipped a fabricated proc name — `sp_insert_staging_CVH_new`, which did not exist — caught only on a second pass. Check named entities against the source.)

**Linking — cite, don't restate.**
- Markdown doc → `docs/reader.html?f=<path>` (portal) or a relative path (in-repo).
- HTML artifact → root-relative path (`/analysis/artifacts/<id>/index.html`).
- Wiki cross-page → `[[Page-Name]]`; repo ↔ wiki → an explicit path.
- Concept ↔ docs → register in [`app/kg-references.json`](../app/kg-references.json) (`refs["<KG node id>"] = [{title, href}]`) so the knowledge graph surfaces the doc. The node id **must** match an existing graph node.

**Accuracy gate (before commit).**
- Counts/inventories reconcile with the source (sum the parts back to the total).
- Every named entity (file, proc, table, count) exists.
- Inference is flagged, not asserted as fact.
- Large extractions pass the multi-pass verification above.

---

## How to add each

### A document shared with us
1. Drop the **original** in `artifacts/phase-0/source-docs/` (`.docx/.pdf/.html/.xlsx`).
2. Convert to `.md` (pandoc for docx/html; tables preserved). Keep frontmatter (`source`, `title`, `type: source-doc`, `original:`).
3. Add a top-of-file link to the original (`/artifacts/phase-0/source-docs/<file>`).
4. Add a row to `artifacts/README.md` and, if client-facing, a Reference card in `reference/index.html`.

### Confluence page(s)
- Add the `page_id` + `url` to a file's frontmatter, then run `python3 scripts/repull-confluence.py` (scoped `JIRA_API_TOKEN` + Basic auth via the `api.atlassian.com` gateway — see `memory/sources.md`). It fetches `export_view` HTML → pandoc → structured markdown, preserving frontmatter. **Don't hand-edit** Confluence exports; re-pull.

### A code or data repo (the ETL pattern)
The repo is a **read-only extraction source**, not a permanent dependency.
1. Add as a submodule with a dedicated **deploy key** (separate identity, e.g. `~/.ssh/id_ed25519_das`; `update = none` in `.gitmodules`).
2. Check out read-only: `GIT_SSH_COMMAND="ssh -i <key> -o IdentitiesOnly=yes" git -c submodule.<name>.update=checkout submodule update --init <name>`.
3. **Extract** the useful knowledge into our docs (a catalog like [`etl-data-inventory.md`](etl-data-inventory.md)): module purpose, object inventory, data flow, CDP relevance — with references to real file paths.
4. **Verify** (multi-pass): per-module README↔code check → synthesis → adversarial review → final read.
5. **Remove the submodule** once extraction is complete and verified. The knowledge now lives in our docs; the dependency doesn't.

### A database you have access to
Per-DB schema docs live in [`docs/databases/`](databases/README.md) — one `<db>.md` per database (overview, tables, indexes, views, ERD, CDP relevance), with the raw DDL dump in `dumps/<db>.sql` and the diagram in `erd/<db>.svg`. Claim a stub (set `researcher:`), dump the schema (schema-only), describe the structures from the dump, add the ERD. Full workflow + generation hints: [`databases/README.md`](databases/README.md).

### A roadmap item (epic / feature / story)
The roadmap is a hierarchical spec tree in [`specs/`](../specs/README.md) — epic → feature → story (folder depth = level). Add a markdown file in the numbered-folder convention with frontmatter (`type`, `status`, `priority`, `depends_on` by id), then `python3 specs/_gen.py` to rebuild `manifest.json` and commit both. Viewer: `/specs/` (drawer + paginator). Full schema + how-to: [`specs/README.md`](../specs/README.md).

### A new portal artifact / page
1. Build `analysis/artifacts/<id>/index.html` (CONFLICT brand tokens; topbar logo → `/`).
2. Add the descriptor `analysis/artifacts/<id>.json` (`id, title, description, type, icon, href, updated`).
3. Register the id in `analysis/catalog.json` `artifacts[]` → it appears in `/analysis/artifacts/`.
4. If it has dynamic data, put it in a versioned JSON and log it in [`portal-data-inventory.md`](portal-data-inventory.md).

### Portal data (counts/status/lists)
Put it in a versioned JSON (`version` int, `updated` ISO date, `changelog` newest-first). Fetch + render client-side. Never hardcode. Log the file + its consumers in [`portal-data-inventory.md`](portal-data-inventory.md).

---

## Templates

### Source-doc frontmatter
```yaml
---
source: <e.g. DAS Confluence | DAS Technology (internal spec)>
title: <doc title>
type: source-doc            # or confluence-doc
original: <filename.docx>   # the authoritative original, alongside this .md
page_id: <id>               # confluence only
url: <original url>         # confluence only
---
```

### Artifact descriptor (`analysis/artifacts/<id>.json`)
```json
{
  "id": "<id>",
  "title": "<Title>",
  "description": "<one dense sentence>",
  "type": "catalog | tracker | diagram | document",
  "icon": "<4-char label>",
  "href": "artifacts/<id>/index.html",
  "updated": "YYYY-MM-DD"
}
```

### Versioned data-file envelope
```json
{ "version": 1, "updated": "YYYY-MM-DD",
  "changelog": [{ "date": "YYYY-MM-DD", "note": "<what changed>" }],
  "…": "your data" }
```

### ETL / code-repo module catalog row
```
| Module | #objects | Purpose | Key tables in → out | CDP relevance |
```
(See [`etl-data-inventory.md`](etl-data-inventory.md) for the worked example.)

---

## Verify before committing
- **Broken paths:** no `href`/`fetch`/`?f=` points at a missing file.
- **Provenance:** every new fact traces to a real source; named files/procs/tables/counts exist; inference is flagged, not asserted.
- **References registered:** new concept docs added to `app/kg-references.json` (node id matches an existing graph node).
- **Counts match data:** portal numbers come from JSON, not hardcoded.
- **Identity:** `gh auth status` + `git config user.email` = CONFLICT, not steadymd.
- **Re-pull idempotency:** `scripts/repull-confluence.py` reruns clean (only upstream edits change files).
- For large extractions, run the multi-pass verification (workflow + final single-thread read).
