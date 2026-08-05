---
title: "Report Migration"
type: feature
status: planned
priority: medium
depends_on: [phase-1-build.integration-etl-reporting.warehouse-reporting-cutover, phase-1-build.integration-etl-reporting.dashboards-as-code]
labels: [reporting, migration, superset, phase-1, 1b]
date: ~
---

Migrate the legacy DWRPT/Juicebox reports (221 reports across the DWRPT schema families) onto the new Superset + warehouse reporting platform, as dashboards-as-code. Decomposed from a single EPIC into per-family stories; per-report work is captured as subtasks. Container only — size is the roll-up of its children. **Per-item sizing is a first pass and firms up as the per-report inventory is detailed.**

**References:**
- Decided 2026-06-14 (reporting platform): Apache Superset replaces Juicebox; dashboards-as-code — `memory/decisions.md`
- `specs/02-phase-1-architecture/02-platform-decisions/01-reporting-platform-decision.md`; `docs/cdp-field-source-matrix.md`
