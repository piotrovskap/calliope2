---
title: "Custom report catalog parity (Juicebox replacement)"
type: story
status: planned
priority: high
estimate: XL
depends_on: [phase-1-build.integration-etl-reporting.dashboards-as-code, phase-1-build.integration-etl-reporting.django-superset-meta-layer, phase-1-build.integration-etl-reporting.superset-deploy]
labels: [phase-2, reporting, parity, juicebox, 2a]
date: ~
---

Recreate the report catalog DAS dealers rely on today (the Juicebox reporting set) as portable dashboards-as-code on the Phase-1 Superset platform, so DAS keeps service parity for its dealers when the legacy reporting layer is retired.

**Scope:**
- Inventory the existing Juicebox/DWRPT dealer-facing reports; map each to the CDP/golden-record data model and the analytical store.
- Author the equivalents as dashboards-as-code (YAML in git, deployed via the Phase-1 meta layer), per-tenant via the RLS guest-token harness.
- **Store-neutral SQL:** reports target standard SQL portable across the analytical store — Redshift on AWS or Postgres-only on Azure, per the cloud bake-off — no engine-specific constructs.

**Acceptance:** the dealer-facing reports that exist in Juicebox today have CDP equivalents as versioned dashboards-as-code, per-tenant isolated, rendering correctly on the Phase-1 platform regardless of whether the analytical store is Redshift or Postgres-only.

**References:**
- Decided 2026-06-14: reporting layer is Apache Superset, headless/embedded, dashboards-as-code (YAML in git) via REST API, per-tenant RLS from the existing data-isolation model — closes the "evaluate Juicebox replacement" item — `memory/decisions.md#d-029`
- Confirmed 2026-06-08 / first-principles 2026-06-12: Juicebox (221 reports) is institutional knowledge to migrate, not a foundation to build on — no CDP dependencies on Juicebox; reporting designed from first principles — `memory/decisions.md#d-046`
- Decided 2026-06-12: DWRPT read access granted as the reporting-parity reference (not a CDP ingestion source) — `memory/decisions.md#d-060`
- Decided 2026-06-18 (SSIS rewrite): reporting procs (Juicebox/DWRPT) replaced by Redshift, NOT ported — `memory/decisions.md#d-075`
- `docs/cloud-aws-vs-azure-bakeoff.md` — Postgres-native is the portable default analytical store; Redshift (zero-ETL from RDS-Postgres) is the optional AWS managed warehouse — basis for store-neutral SQL
- `wiki/Tech-Stack.md` — Juicebox (221 reports, no SQL JOINs, not long-term) and DWRPT (pre-joined SQL Server views) as the legacy reporting layer being replaced
