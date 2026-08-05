---
title: "Provision DWRPT / EDW / Juicebox access"
type: story
status: done
priority: high
estimate: M
assignee: Ron
labels: [access, dwrpt, edw, juicebox, phase-0]
date: "2026-06-08"
artifacts:
  - "DWRPT view inventory | /analysis/artifacts/dwrpt-view-inventory/index.html"
  - "DWRPT/AI DB docs | docs/databases/dwrpt-ai.md"
---

Provision system access for the CONFLICT team. DWRPT read access is granted (reporting-parity reference); Juicebox read access was not pursued — not needed for Phase 0 (see below).

**Closed 2026-06-12 — no further access requested.** With SSIS-side access already in hand (ETL scripts, stored procedures, staging layer) covering the raw/ingestion side, and the reporting requirements known from the Juicebox review, additional DWRPT/Juicebox grants are not needed for Phase 0. DAS guidance reinforces this: don't over-focus on existing systems — they are to be replaced by what we're building. The inputs (raw sources) and the asks (reporting outputs) matter; the legacy middle layer does not. Re-routed dependencies:

- Common Client ID coverage map: Ron provides the schema/extract directly instead of CONFLICT querying DWRPT.
- Juicebox report sampling: work from report definitions/exports (CDXP-Live set) instead of read access.

Reopen only if a Phase 1 deliverable proves impossible without direct query access.
