---
name: no-emojis
description: No emojis anywhere in the workspace — docs, wiki, artifacts, portal HTML, commit messages
metadata:
  type: feedback
---

No emojis in anything CONFLICT-authored: docs, wiki pages, deliverables, portal HTML, decks, commit messages, issue/PR text.

Status semantics that emojis used to carry are expressed as words or plain typographic glyphs:

| Was | Use instead |
|-----|-------------|
| Status checkmark/cross emoji | `OK` / `Yes` / `No`, or typographic `✓` / `✕` in HTML UI |
| Warning sign prefix on callouts | Nothing — bold lead sentence carries it |
| Yellow circle (partial) | `VALIDATE` (see `docs/cdp-field-source-matrix.md` legend) |
| No-entry sign (gap) | `GAP` |

Typographic glyphs (`✓`, `✕`, `★`, arrows `←` `→`) are fine — they are plain text, not pictographs.

**Exception:** DAS-provided source material (`artifacts/phase-0/confluence/`, `artifacts/phase-0/source-docs/`) is never edited for style — provenance over polish. Planopticon-generated data files (e.g., raw KG ingest JSON) keep whatever the source contained.

**Why:** Client-facing professional artifacts; stated directly and enforced repeatedly (commit d084e1c, full sweep 2026-06-12).

**How to apply:** Never introduce emojis. When editing a CONFLICT-authored file that contains them, strip them in the lines you touch (or the whole file if doing a style pass).
