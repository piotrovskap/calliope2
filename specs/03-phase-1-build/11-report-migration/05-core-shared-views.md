---
title: "Core shared views (core_v_*)"
type: story
status: planned
priority: medium
estimate: M
depends_on: [phase-1-build.integration-etl-reporting.dashboards-as-code]
labels: [reporting, migration, 1b]
date: ~
---

Rebuild the **Core shared views (core_v_*)** reports on Superset reading from the warehouse, as version-controlled dashboards-as-code, replacing the legacy DWRPT views. Per-report migration is tracked as subtasks under this story.

**Acceptance:** the migrated reports render in Superset against the warehouse, results reconcile to the legacy DWRPT output within tolerance, and the dashboards are defined as code (not hand-built).

**Subtasks:** one per report in this family (inventory firms up the count).

**References:**
- Decided 2026-06-14 (reporting platform decision): Superset + dashboards-as-code replaces Juicebox/DWRPT — `memory/decisions.md#d-029`
- `specs/02-phase-1-architecture/02-platform-decisions/01-reporting-platform-decision.md`
