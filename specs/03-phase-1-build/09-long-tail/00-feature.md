---
title: "Source Onboarding & Legacy Deprecation"
type: feature
status: planned
priority: medium
depends_on: [phase-1-build.ingest.source-registry, phase-1-build.integration-etl-reporting.django-superset-meta-layer]
labels: [long-tail, ingest, deprecation, phase-1]
date: ~
---

The continuing path after the tracks stand up: onboard every remaining source via the config-driven registry until all core entities and data sources are ingested and processed, reimplement the SSIS logic against the original sources, migrate the legacy reports, and deprecate the old systems once the CDP is the reliable source of truth. Team context: Oscar, Byron, Hiram, Julio (ownership assigned at planning).

**Milestone.** All sources ingested; reports migrated; legacy stack deprecated.
