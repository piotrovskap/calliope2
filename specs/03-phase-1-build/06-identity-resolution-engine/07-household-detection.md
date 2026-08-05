---
title: "Household detection & membership"
type: story
status: planned
priority: high
estimate: XL
depends_on: [phase-1-build.identity-resolution-engine.resolution-engine-core, phase-1-build.backend-data-model.data-model-foundation]
labels: [identity, household, resolution, 1a]
date: ~
---

Build the household entity and its detection logic (locked Phase-1 decision). A household is a distinct entity; a consumer belongs to zero or one household; households are **detected, never asserted by the source**. Detection signal: canonical-address match + ≥1 of (shared phone, shared surname, co-occurring vehicle service history). Membership is **provisional until human curation confirms** — detected groupings feed the curation queue, and the household layer is rendered in the Identity Map read surface. The relationship is modeled bitemporally so Phase-2 household lifecycle events (forming, splitting on divorce, merging) add without migration. This is the producing mechanism the Identity Map renders.

**Acceptance:** the engine creates household entities and provisional consumer↔household membership from the locked detection signals (canonical address + ≥1 secondary signal); membership is flagged provisional vs curator-confirmed; detected households surface in the curation queue for confirmation and in the Identity Map; and the relationship is bitemporal (a membership change is recorded, not overwritten). Household lifecycle events are explicitly out of scope (Phase 2).

**References:**
- Decided 2026-06-17 (Luis + Alicia, identity strategy LOCKED): household = distinct entity (zero-or-one per consumer), detected via canonical address + ≥1 of (shared phone, surname, co-occurring vehicle service history), provisional until curation confirms, bitemporal so Phase 2 lifecycle adds without migration — `memory/decisions.md#d-108`
- `wiki/Identity-Resolution.md` (Household / Family Resolution) — canonical detection signals, dual-layer activation, and Phase 1/Phase 2 scope boundary
- `docs/deliverables/identity-resolution-strategy.md` — household detection locked alongside matching model + survivorship + 15-table data model (2026-06-18)
