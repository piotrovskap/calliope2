---
title: "Orphan identifier handling"
type: story
status: planned
priority: medium
estimate: L
depends_on: [phase-1-build.identity-resolution-engine.resolution-engine-core]
labels: [identity, orphans, 1a]
date: ~
---

Store identifiers that have nothing to resolve to yet (e.g. Facebook IDs arriving on reviews) as unresolved nodes that may resolve later, and re-evaluate them when new linking evidence arrives.

**Acceptance:** an orphan identifier persists as an unresolved node with provenance; arrival of new linking evidence re-triggers resolution and attaches it to an identity, with its full prior history (arrival source, provenance, intervening evidence) preserved and the attachment auditable.

**References:**
- Decided 2026-06-17 (Luis + Alicia, Option A identity lock): orphan identifiers (`identity_link.link_type='orphan'`, no consumer_id) stored never discarded, upgraded to a deterministic/heuristic link when a later event carries the orphan ID alongside a linkable key — `memory/decisions.md#d-115`
- Decided 2026-06-17 (orphan-vs-tier position): orphans stay on hot storage until linkable — the one hot-required exception in the tiered-lifecycle framework — `memory/decisions.md#d-115`
- `wiki/Identity-Resolution.md` — §Orphan Identifier Handling: late-resolution lifecycle, `link_type='orphan'`, hot-storage rationale (sub-100ms p95 deterministic fast path)
