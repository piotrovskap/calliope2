---
title: "Accuracy & Verification"
---

# Accuracy & Verification

How the workspace keeps its claims grounded — the guardrails that prevent drift, and the verification pass that checks the corpus against its sources.

## Principle

Every figure, status, and reference in the portal should trace to a verifiable source: a database dump, a generated index, a dated decision, or — for outside-world facts — a primary vendor/regulator page. Nothing is asserted that cannot be checked.

## Durable guardrails (always on)

- **Counts derive from source, not from memory.** Portal cards (databases, knowledge-graph entities/edges) and the golden-record version are computed from the live JSON at render or build time, so they cannot go stale as the data grows.
- **`make check-portal-literals`** (CI gate) — fails the build if any hand-written count or version in the portal diverges from its JSON/markdown source. The drift class cannot regress silently.
- **Generated indexes** — the brain, knowledge graph, database schema, and estimates are regenerated from source; CI rejects hand-edited generated outputs.
- **Traceability checks** — every decision anchor and golden-record field must resolve to real, supporting content.

## Verification passes

Periodically the corpus is swept claim-by-claim and each is re-grounded against its oracle before any correction is made — distinguishing a genuine error from a dated snapshot that was correct when written. The most recent pass (2026-06-24) landed its corrections in PR #187; remaining items that need an owner or client decision are tracked in the RAID log (e.g. `A-10`, `I-5`).

## Team detail

The full claim-by-claim ledger and the narrative findings report for each pass live in `_internal/` (kept in-repo for the team, excluded from the published portal).
