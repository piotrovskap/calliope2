---
title: "Django meta layer for Superset"
type: story
status: planned
priority: high
estimate: XXL
depends_on: [phase-1-build.integration-etl-reporting.superset-deploy]
labels: [reporting, superset, django, meta-layer, 1a]
date: ~
---

The identified architecture gap to harmonize: a Django-managed control layer that drives Superset entirely via its REST API. Datasets, charts/widgets, dashboards, and RLS rules are generated FROM Django models and are version-specific (Django -> API-generated).

**Acceptance:** re-running reconciliation from the same Django model version produces zero Superset API mutations (idempotent); a model change generates only the corresponding dataset/chart/dashboard/RLS diff; the generation is pinned to a Superset API version.

**References:**
- Decided 2026-06-14: Superset as headless/embedded engine driven through the REST API (chart/dashboard/dataset CRUD, `security/guest_token`, RLS endpoints); a generator bakes into the create-chart/create-dashboard APIs — `memory/decisions.md#d-030`
- Decided 2026-06-14: per-tenant reporting isolation is derived from the existing tenanted data-isolation model (single source of truth); the per-session guest-token RLS clause is generated from it, no second isolation mechanism — `memory/decisions.md#d-031`
- `docs/cdp-architecture.md` — Apache Superset (self-hosted, headless/embedded, BI-as-code) as the canonical reporting engine for ~1,700 dealer tenants + internal authoring

**Milestone.**
