---
name: pr
description: gh-wrapper for the PR lifecycle on this repo — open a PROCESS.md-compliant PR (preflight gate + body template + reviewer notes), check CI output and diagnose failures, and address PR review feedback. Use when opening a PR, when CI is red, or when responding to review comments.
---

# /pr — PR lifecycle helper (gh wrapper)

This skill mirrors [`.claude/skills/pr/SKILL.md`](../../../.claude/skills/pr/SKILL.md) — read and follow that file for the full procedure (`open` / `checks` / `feedback`). The full content is kept in one place (the `.claude` copy) to avoid drift; the PR **policy** it enforces lives in [`PROCESS.md`](../../../PROCESS.md) §3.

**Usage:** `/pr open [#issue] [@reviewer…]` · `/pr checks [#PR]` · `/pr feedback [#PR]`
