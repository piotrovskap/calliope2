# Spec Story Standard

Every story (`type: story`) follows this shape so a ticket says **what to build, when it's done, and why/when it was decided** — not just a description.

## Frontmatter

```yaml
---
title: "..."
type: story
status: planned | active | done | blocked
priority: high | medium | low
estimate: S | M | L | XL | XXL | XXXL | EPIC   # the points; omit/null only for unpointed placeholders
depends_on: [<story-id>, ...]                   # within-plan dependencies
labels: [..., 1a|1b|2a|2b]                      # include the sub-phase label
date: ~                                          # or the date the story was committed
---
```

Containers (`00-feature.md`, `00-epic.md`) carry **no `estimate`** — their size is the roll-up of their children (never an independent lump).

## Body sections

1. **Description** — what the story builds and why, in 1–3 sentences. The estimate (frontmatter) is the points; don't restate.
2. **`**Acceptance:**`** — concrete, testable definition of done. What must be observably true. Not "X is configured" — "a merge to main deploys X and the new revision is observably serving."
3. **`**References:**`** — *where applicable* — the decisions and docs this story derives from, each dated/attributed so the rationale is traceable:
   - `- Decided YYYY-MM-DD (<who>): <decision> — \`memory/decisions.md\``
   - `- \`docs/<doc>.md\` / \`wiki/<Page>.md\` — <what it establishes>`
4. **`**Subtasks:**`** — *where applicable* — per-instance / per-connection / per-role breakdown (unpointed; the story carries the points). E.g. one HubSpot integration story, a subtask per agency connection.

## Worked example

```markdown
**Acceptance:** both repos exist with runnable scaffold (backend boots, frontend builds),
README per repo, and branch protection on `main` requiring PR + passing checks.

**References:**
- Decided 2026-06-13 (Leo, Phase 0 arch recommendation): Django + Strawberry GraphQL
  backend, Next.js frontend on `boilerworks-django-nextjs` — `memory/decisions.md`
- Language strategy 2026-06-14: Python primary, Go for measured hot paths — `memory/decisions.md`
- `docs/cdp-architecture.md` · `wiki/Tech-Stack.md` — the canonical stack
```

## Notes

- References point at the **canonical** source (the wiki/docs page or the dated decision), never a duplicated restatement.
- If a story has no governing decision yet (genuinely net-new), omit References rather than inventing one.
- The sub-phase label (`1a`/`1b`/`2a`/`2b`) is how the presenter/roadmap group stories; keep it on every Phase-1/2 story.
