---
title: "Survivorship / golden-value resolution"
type: story
status: planned
priority: high
estimate: XL
depends_on: [phase-1-build.identity-resolution-engine.resolution-engine-core, phase-1-build.backend-data-model.data-model-foundation]
labels: [identity, survivorship, golden-record, 1a]
date: ~
---

Implement the survivorship mechanism that selects the surviving (golden) value **per field** when records resolved to one consumer disagree. Applies the locked source-trust ladder (DMS → CRM → email/Twilio engagement → third-party enrichment) with most-recent-observation-wins as the tie-breaker within a trust tier, computed over the bitemporal observation layer. Losing values are never destroyed — they stay in entity history with full per-element provenance (which source supplied the surviving value, when, by what method) for audit and re-resolution. This is the producing mechanism behind the golden-record view, which renders the result. Design is locked in the Identity Resolution Strategy (§Survivorship) and `specs/02-phase-1-architecture/01-data-model/05-survivorship-rules.md`; this story builds it.

**Acceptance:** given multiple source observations for the same consumer field, the engine selects the surviving value per the source-trust ladder + recency tie-break; the surviving value, its winning source, and per-element provenance are queryable; losing values remain in the bitemporal history (not overwritten); and re-running after a higher-trust source arrives flips the surviving value with the change recorded bitemporally.

**References:**
- Decided 2026-06-12 (Dan Aston sync): DMS = ground truth for all consumer/vehicle data (transactional, dollars-attached) — `memory/decisions.md`
- Locked 2026-06-17 (Luis + Alicia): survivorship + source-trust ladder DMS → CRM → email/Twilio engagement → third-party enrichment, most-recent-observation-wins tie-break within tier, per-element provenance retained, no source permanently overridden — `memory/decisions.md#d-107`
- `wiki/Identity-Resolution.md` (§Survivorship & Source Trust) — canonical trust ladder, tie-break, and provenance-retention rule
- `specs/02-phase-1-architecture/01-data-model/05-survivorship-rules.md` — locked design: per-field winner, fallback chain, and the six survivorship rule types this engine applies
- `specs/02-phase-1-architecture/01-data-model/04-golden-record-view.md` — the view this engine produces values for
