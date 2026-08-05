---
title: "Integration, ETL & Reporting"
type: feature
status: planned
priority: high
depends_on: [phase-1-build.foundation.cd-integration, phase-1-build.backend-data-model.org-tenancy-data]
labels: [track-4, reporting, superset, etl, phase-1]
date: ~
---

The reporting layer: Apache Superset self-hosted (headless/embedded), a Django meta layer managing Superset via its REST API (Django -> API-generated, version-specific), dashboards-as-code in git, the per-tenant guest-token + RLS harness, and the warehouse reporting cutover (store-neutral) via zero-ETL/mirroring from managed Postgres. See the reporting-strategy artifact (analysis/artifacts/reporting-strategy).

**Acceptance:** Django-managed Superset serves per-tenant embedded dashboards with enforced RLS isolation, dashboards ship from git, and analytics read from the warehouse.

**Milestone.** Django-managed Superset serving per-tenant embedded dashboards.
