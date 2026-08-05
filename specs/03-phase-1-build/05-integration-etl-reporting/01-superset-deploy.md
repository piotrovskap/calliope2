---
title: "Superset self-hosted"
type: story
status: planned
priority: high
estimate: XL
labels: [reporting, superset, infra, 1a]
date: ~
---

Deploy Apache Superset on EKS with Postgres metadata, Redis, and Celery for async/cache, configured headless/embedded. Pin 6.0+ for white-labeling and enable embedding plus theming.

**Acceptance:** Superset 6.0+ serves on EKS with Postgres metadata, Redis, and Celery workers healthy; an embedded SDK iframe renders a dashboard headlessly (no Superset chrome) with the custom theme applied.

**References:**
- Decided 2026-06-14: Two-layer reporting on Apache Superset, self-hosted (Apache-2.0, $0 license baseline), run headless/embedded as a BI-as-code engine (YAML in git, driven via REST API + `security/guest_token`); pin Superset 6.0+; per-tenant isolation derived from the existing tenanted data-isolation model (guest-token RLS clause), not a second mechanism — `memory/decisions.md#d-029`
- `docs/cdp-architecture.md` — establishes Apache Superset as the reporting layer (self-hosted, headless/embedded, BI-as-code) serving ~1,700 dealer tenants + internal authoring; status Locked
