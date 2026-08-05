---
title: "Common Client ID coverage map"
type: story
status: done
priority: high
estimate: M
depends_on: []
labels: [identity, common-client-id, inventory, phase-0]
date: ~
artifacts:
  - "Field-source matrix | docs/cdp-field-source-matrix.md"
  - "ETL inventory | docs/etl-data-inventory.md"
---

**Closed 2026-06-18 (done):** resolved — the CDP builds its own deterministic Common Client ID from first principles (Option A, locked 2026-06-17); DAS's CCID is at most a migration/backfill signal, never the foundation. Not a blocker.
Identify which source systems carry a Common Client ID join and which require probabilistic matching. The output is a coverage matrix: per source system, whether identity is deterministic (Common Client ID present) or must fall back to fuzzy matching.

**Input to:** the identity-resolution design (delivered). Coverage sourced from Ron's Common Client ID schema/sample extract plus the identity keys inventoried per source. CCID audit (2026-06-14): the column is non-functional (all-zero), so resolution is probabilistic — see `wiki/Identity-Resolution.md`.
