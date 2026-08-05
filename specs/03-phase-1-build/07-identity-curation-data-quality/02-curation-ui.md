---
title: "Curation & eval UI"
type: story
status: planned
priority: high
estimate: XL
depends_on: [phase-1-build.identity-curation-data-quality.curation-queue, phase-1-build.frontend.app-exposure]
labels: [identity, curation, frontend, 1a]
date: ~
---

A web-UI surface in the Next.js frontend to review, confirm, merge, split, and evaluate identity matches. Each candidate shows the supporting evidence and per-fact provenance so curators can judge the recommendation. Actions write back to the resolution store and are recorded for audit.

**Acceptance:** the UI displays a queued candidate with its supporting evidence and per-fact provenance; a curator can confirm/merge/split from that view; the action writes back to the resolution store and records an audit entry (who, when, what, why) — and a merge/split is reversible per the merge-split-audit story.

**References:**
- Decided 2026-06-17 (Luis + Alicia, Option A locked): deterministic-first matching with heuristic recovery; ambiguous matches fall to a human curation queue where an operator decides — `memory/decisions.md#d-104`
- Decided 2026-06-17 (confidence bands): medium-confidence (above threshold but ambiguous) routes to the curation queue for a human operator; decision captured in `merge_history` with full audit trail — `memory/decisions.md#d-104`
- Decided 2026-06-17 (survivorship + source trust ladder): per-element provenance retained alongside the surviving value (which source, when, by what method) — the evidence a curator judges — `memory/decisions.md#d-107`
- `wiki/Identity-Resolution.md` — Conflict Review Queue: side-by-side review, operator chooses merge/reject/defer, decision recorded in `merge_history`
- `wiki/Tech-Stack.md` — Next.js frontend (the surface this UI is built on)
