# Roadmap / Specs

The engagement roadmap as a **hierarchical spec tree** — epic → feature → story, turtles all the way down. Each node is a markdown file; [`_gen.py`](_gen.py) walks the tree into [`manifest.json`](manifest.json); the viewer ([`index.html`](index.html), live at `/specs/`) renders it with full-markdown drawer + Prev/Next paginator.

## Phase model — two adjacent "Phase 1" folders

The folder ordinals follow the engagement lifecycle. Note that **"Phase 1" intentionally spans two folders**: `02-phase-1-architecture` (the design package) and `03-phase-1-build` (the **product-build P1** — MVP + full backend). They are sequential stages of the same phase, not duplicates: architecture/design hardens first (owned by Alicia + Luis, due 2026-06-19), then the build depends on it. After that come `04-phase-2-build` (applications + activation, product P2) and `05-phase-3-ai-ml` (product P3). See [`memory/decisions.md`](../memory/decisions.md) for the engagement-vs-product phasing note.

## Folder & file convention

**Folder depth = hierarchy level.** Numeric ordinals (`NN-`) set order and are stripped from ids.

```
specs/
  01-phase-0-discovery/
    00-epic.md                    ← epic container (level 1)
    01-kickoff-sessions/
      00-feature.md               ← feature container (level 2)
      01-kickoff.md               ← story (level 3)
      02-ssis-deep-dive.md        ← story
```

- `00-epic.md` / `00-feature.md` = **container** files; they describe the folder they sit in.
- Numbered sibling files = **stories** under that container.
- **id** is derived from the path (de-ordinaled segments, dotted): `01-phase-0-discovery/02-access-provisioning/01-dwrpt-edw-juicebox.md` → `phase-0-discovery.access-provisioning.dwrpt-edw-juicebox`. Don't hand-set `id` unless you must.

## Frontmatter schema

| Field | Required | Values / notes |
|---|---|---|
| `title` | yes | Display title. |
| `type` | yes | `epic` \| `feature` \| `story`. |
| `status` | yes | `planned` \| `active` \| `done`. |
| `priority` | rec. | `high` \| `medium` \| `low`. |
| `depends_on` | no | list of **ids** (cross-tree allowed) — drives the dependency edges. |
| `assignee` | no | name. |
| `estimate` | no | T-shirt size (relative effort, not time) — see scale below. |
| `labels` | no | list of tags. |
| `date` | no | `YYYY-MM-DD` or `~` (none). |

**Estimate scale — T-shirt, scoring relative effort + complexity (NOT time).** Work is AI-executed, so calendar time is meaningless at the story level; size by relative effort/complexity only. Time bounds, when needed, are derived separately (low/high) by `scripts/spec-stats.py` — never baked into a size.

| Size | Relative effort + complexity |
|---|---|
| `XXS` | trivial — a one-line / config change |
| `XS` | tiny — a single small, well-understood change |
| `S` | small — one simple component, no unknowns |
| `M` | modest — one component, minor integration |
| `L` | moderate — a component with real integration |
| `XL` | substantial — multi-part or cross-cutting |
| `XXL` | large — several moving parts, some novelty |
| `XXXL` | very large — broad, high-coordination |
| `EPIC` | too big for one story — **needs a spike + breakdown** into chunked stories (multi-person) |
| `Milestone` | a major slice / phase-level objective |

Size by **relative effort and complexity**, never the clock. Anything bigger than `XXXL` (or that won't fit in a quarter) must be broken into chunked stories before it's added; a feature too big to fit gets a note to decompose it (phases are full vertical slices with a definition of done; length varies).

**Counts are data-driven — never store them.** Story/feature counts, size distributions, and rollups go stale the moment the tree changes. Do not write them into specs or docs; expose them live via `scripts/spec-stats.py` (CLI) or `/specs/stats.html` (interactive), both computed from `manifest.json`.

**Computed by `_gen.py` — never set by hand:** `level`, `parent_id`, `children`, `body_preview`.

The markdown **body** is the spec itself — context, acceptance criteria, what it blocks/needs. Mark a milestone in the body (e.g. `**Milestone.**`). Keep it [semantically dense](../docs/discovery-guide.md#quality-standards--references).

## How to add

**A story** (most common): create `NN-<slug>.md` in the feature folder with frontmatter (`type: story`) + body. Reference upstream work via `depends_on: [<id>, …]`.

**A feature:** make `NN-<feature-slug>/` under the epic, add `00-feature.md` (`type: feature`), then story files inside it.

**An epic / phase:** make `NN-<epic-slug>/` at `specs/` root, add `00-epic.md` (`type: epic`).

Then regenerate + view:
```bash
python3 specs/_gen.py      # rebuilds manifest.json
# open /specs/ in the portal (or python3 -m http.server, http://localhost:8080/specs/)
```

Commit the new spec files **and** the regenerated `manifest.json` together (`docs(specs): add <id>`).

## Conventions

- Don't renumber existing files just to insert — pick an unused ordinal (gaps are fine), or use decimals sparingly.
- `depends_on` is by **id**, not path — ids are stable across reordering.
- Status reflects reality (`done` only when actually done); the viewer and any roll-ups read it.
- One concern per story. If a story needs sub-stories, promote it to a feature folder.
