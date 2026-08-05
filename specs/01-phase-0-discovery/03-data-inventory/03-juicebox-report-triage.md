---
title: "Juicebox report sampling"
type: story
status: done
priority: medium
estimate: M
depends_on: [phase-0-discovery.access-provisioning.dwrpt-edw-juicebox]
labels: [juicebox, reporting, sample, phase-0]
date: ~
artifacts:
  - "Reporting platform decision | specs/02-phase-1-architecture/02-platform-decisions/01-reporting-platform-decision.md"
  - "DWRPT view inventory | /analysis/artifacts/dwrpt-view-inventory/index.html"
---

**Closed 2026-06-14 (done):** resolved — Juicebox replacement decided (Apache Superset, reporting-platform decision); reporting patterns captured. Full custom-report parity build is Phase 2 (`phase-2-build.reporting-parity`).
Pull a representative **sample** of Juicebox reports — not a full triage of all 221 — to model the reporting patterns the CDP must be able to reproduce. Start with the 14 client-facing CDXP-Live reports, then add a cross-section of the other report families (CDXP-Old, DDE, Non-CDXP-*) to cover the range of query shapes, joins, and outputs.

**Why it matters:** the goal is to enable building Juicebox-equivalent reporting on the CDP, not to catalog every legacy report. A representative sample is enough to understand the patterns; classifying all 221 is unnecessary effort. The sampled set informs the reporting platform decision in Phase 1.
