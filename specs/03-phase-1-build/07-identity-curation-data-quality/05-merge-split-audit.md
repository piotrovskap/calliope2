---
title: "Merge/split history & audit"
type: story
status: planned
priority: medium
estimate: XL
depends_on: [phase-1-build.identity-curation-data-quality.curation-ui]
labels: [identity, audit, provenance, 1a]
date: ~
---

Record every merge and split with its driving evidence and a path to reversibility. Bitemporal history reattaches on merge so prior facts and timelines are preserved; a full audit trail captures who acted, when, and why.

**Acceptance:** every merge/split records its driving evidence and an audit trail (who acted, when, why); the operation is reversible, and reversing it restores the prior identity boundaries with bitemporal facts and timelines reattached intact — no history lost.

**References:**
- Decided 2026-06-13 (Leo, Phase 0 data-model invariants): identity merges reattach bitemporal history + record the merge in `merge_history`; bitemporal provenance (valid-time + system-time) is append-only so as-of time-travel is preserved — `memory/decisions.md`
- Reconciled 2026-06-17: `merge_history` is the bitemporal audit trail for identity lifecycle, under the tiered data lifecycle policy — `memory/decisions.md`
- `wiki/Identity-Resolution.md` — merge decision captured in `merge_history` with full audit trail; bitemporal merge/unmerge trail retained through tiering
- `specs/02-phase-1-architecture/01-data-model/01-cdp-data-model-design.md` — `merge_history` as a core table in the Phase 1 set
