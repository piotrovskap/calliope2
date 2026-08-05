---
title: "Dashboards-as-code"
type: story
status: planned
priority: high
estimate: XL
depends_on: [phase-1-build.integration-etl-reporting.django-superset-meta-layer]
labels: [reporting, gitops, dashboards, 1a]
date: ~
---

Dashboard, chart, and dataset definitions live as YAML in git and deploy via CI through the meta layer / Superset import-export. Source of truth is the repo, not the Superset UI.

**Acceptance:** merging a YAML change in a git PR triggers CI that applies it to Superset and the dashboard updates; an out-of-band edit made in the Superset UI is overwritten on the next CI run, proving the repo is source of truth.

**References:**
- Decided 2026-06-14 (closes "evaluate Juicebox replacement"): dashboards/charts/datasets defined as YAML in git (BI-as-code), driven through the Superset REST API; Superset runs headless/embedded — `memory/decisions.md#d-030`
- `docs/cdp-architecture.md` — canonical reporting stack: Apache Superset, self-hosted, headless/embedded, BI-as-code (status: Locked)
