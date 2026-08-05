---
title: "Human-in-the-loop curation queue"
type: story
status: planned
priority: high
estimate: XL
labels: [identity, curation, temporal, queue, 1a]
date: ~
---

A queue of ambiguous and low-confidence identity matches surfaced for human review, fed by the Temporal resolution sagas in the app layer. Items carry priority and aging so stale or high-impact cases rise; reviewers are assigned or self-claim. Each item retains the evidence and per-fact provenance that drove the heuristic recommendation.

**Acceptance:** a match routed to moderation enqueues an item carrying its evidence and per-fact provenance; items expose priority and aging so high-impact and stale cases sort to the top; a reviewer can claim (or be assigned) an item and action it (confirm/merge/split/reject), and a claimed item is not actionable by another reviewer.

**References:**
- Decided 2026-06-17 (Luis, Alicia concurrence): Option A — deterministic-first matching with heuristic recovery; no-match falls through to blocking + scoring + human curation queue — `memory/decisions.md#d-104`
- Confidence bands (Phase 1): Medium band (heuristic above threshold but ambiguous) routes to the curation queue; bias to over-queue rather than over-merge — `memory/decisions.md`
- Queue capacity sized after measurement, not upfront: Phase 1 ships manual operator SLAs + configurable thresholds — `memory/decisions.md`
- Temporal = application-layer conflict-queue human-in-loop orchestration, off the ingest path — `memory/decisions.md`
- `wiki/Identity-Resolution.md` — Conflict Review Queue: operator actions, decision captured in `merge_history` with audit trail, per-element provenance retained, queue volume/operator capacity
