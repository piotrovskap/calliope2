---
title: Status Glossary
type: reference
date: ~
---

# Status Glossary

The status vocabulary used across the DAS CDP corpus — research pages, the research catalog, specs, RAID, and deliverables. Central caveat: **a "researched" status describes our research, not DAS's production reality.**

## Research / catalog statuses

Used on wiki `*-API.md` pages and in `docs/wiki-research-catalog.json`.

| Status | Means | Does NOT mean |
|---|---|---|
| `researched` | The page was researched and written against available sources. | The integration is live, deployed, or production-confirmed at DAS. |
| `researched & verified` | The public/vendor API facts on the page were checked against authoritative vendor docs on the stated date. | DAS-internal state (deployment, production version, allow-list approval, whether a fix is applied) is confirmed. |
| `in-progress` | Research underway; the page is incomplete. | — |
| `placeholder` | Stub for a known API not yet researched. | — |

## The four-register accuracy model

Every claim on a research page falls into one of four registers. Final deliverables must keep them distinct rather than collapsing them into one "status."

1. **Vendor / public fact** — from the provider's own docs; independently verifiable (e.g. Reddit requires `conversion_pixel_id` on all ad groups / CBO campaigns from 2026-07-13).
2. **DAS-internal state** — deployment, production version, allow-list approval, whether a fix is applied. Not externally verifiable; carried as an **ACTION REQUIRED / client-validation ask**, not a Phase-0 blocker.
3. **Inferred implementation state** — deduced from Integration Explorer / Confluence; flagged as inferred, pending DAS confirmation.
4. **Phase-1 onboarding question** — per-source integration questions resolved as each source is onboarded; not Phase-0 scoping blockers.

The remaining "unverified" items across the corpus (e.g. Reddit production fix status, Carfax 0-row feed, YouTube project verification, Google Ads production version, Graph/Outlook spike state) are register 2 — client-validation asks / Phase-1 onboarding checks, not unresolved Phase-0 research gaps.

## Spec statuses

Used in `specs/` frontmatter and the generated `specs/manifest.json`.

| Status | Means |
|---|---|
| `planned` | Defined, not started. |
| `active` | In progress. |
| `done` | Complete — design decided or artifact delivered. |

Display phases fold `phase-1-architecture` design work under "Phase 0 — Discovery & Architecture" (it is Phase-0 engagement work that produces the architecture deliverable); `phase-1-build` onward is Phase 1+. Priority chips (`P1`/`P2`/`P3`) are priority, not phase.

## RAID statuses

Used in `app/raid.json`.

| Status | Means |
|---|---|
| `open` | Being worked. |
| `resolved` | Closed with a recorded decision and rationale. |
| `validated` | Resolution confirmed. |

## Roadmap phase states

Used on the `roadmap[]` array of the `cdp-roadmap` deliverable in `docs/phase0-deliverables.json`, rendered by `docs/deliverable.html` and projected into `app/brain.json` `phase:*` nodes. A phase-level lifecycle, distinct from the per-story spec vocabulary above.

| State | Means |
|---|---|
| `complete` | The phase's work is finished (e.g. Phase 0 discovery delivered — awaiting DAS sign-off). |
| `current` | The phase in progress now. |
| `next` | The phase that starts next; not yet underway. |
| `future` | A later phase, directional until earlier phases produce operating evidence. |

## Deliverable statuses

Used in `docs/deliverables/*.md` frontmatter and the `deliverables[].status` field of `docs/phase0-deliverables.json`. `complete` (frontmatter) and `done` (JSON) are synonyms — both mean the deliverable is finished and delivered; they mirror the spec `done` token at the deliverable grain.
