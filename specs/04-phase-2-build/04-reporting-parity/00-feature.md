---
title: "Reporting Parity (Custom Reports / Juicebox Replacement)"
type: feature
status: planned
priority: high
labels: [phase-2, reporting, parity, juicebox]
date: ~
---

Service parity for DAS's existing custom-reporting offering. Phase 1 builds the reporting **platform** (`phase-1-build.integration-etl-reporting`: Apache Superset self-hosted, the Django meta layer, dashboards-as-code, per-tenant guest-token + RLS, and the analytical SQL store) and the operational read surfaces. **Phase 2 builds out the report content to reach parity with Juicebox** — recreating the report catalog DAS dealers rely on today, plus the self-serve custom-report capability, on top of that Phase-1 platform.

**Store-neutral, not Redshift-specific.** The analytical store is cloud-dependent: Redshift on AWS, or **Postgres-only / the Azure equivalent if the bake-off lands on Azure** — we may run Postgres-only with no Redshift at all. Reports are defined as portable dashboards-as-code over standard SQL, so parity does not assume a specific analytical engine.

This is a parity requirement, not net-new infrastructure: DAS must keep offering its dealers the custom reporting they have now (Juicebox replacement was resolved 2026-06-14 to Apache Superset). The platform is Phase 1; the dealer-facing report catalog and self-serve builder are Phase 2.
