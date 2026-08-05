---
name: project-spec-system
description: Federated markdown spec system design — schema, folder conventions, export approach
metadata:
  type: project
---

Federated spec system lives at `specs/` in the repo root.

**Why:** Markdown-first project management that generates a manifest.json for the Board/Tree/Gantt UI and feeds export skills.

**How to apply:** When adding features to the spec system or writing export instructions, follow these conventions.

## Structure

- Folder depth = hierarchy level: epic (depth 1) → feature (depth 2) → story (depth 3+)
- `00-*.md` files describe the container (epic or feature descriptor)
- Numbered siblings (`01-`, `02-`) are work items at that level
- IDs auto-derived from path: strip leading digits/dashes per segment, join with `.`

## Frontmatter schema

```yaml
id: phase-0-discovery.kickoff-sessions.kickoff   # auto-derived, override if needed
title: "..."
type: epic | feature | story | task
status: done | active | planned | blocked
priority: high | medium | low
depends_on: []   # list of IDs this is blocked by
estimate: "2d"
assignee: ~
labels: []
date: "2026-06-09"
```

## Manifest

Run `python3 specs/_gen.py` from repo root to rebuild `specs/manifest.json`.
The UI (`specs/index.html`) fetches this at runtime — no build step.

## Export approach (skill-based, no code)

**GitHub Issues:** use the `gh` CLI skill. `gh issue create` with title/body/labels from manifest.json. Map epic → GitHub Milestone, feature → label, story → issue. Document in `bootstrap.md` under "Export Skills".

**Jira:** use `acli` (Atlassian CLI) skill. Map type/summary/description/labels. Document in `bootstrap.md` under "Export Skills".

No export library needed — manifest.json is the data contract; skills consume it directly.
