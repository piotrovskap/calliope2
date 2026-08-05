---
title: "Agency / reseller reporting"
type: story
status: planned
priority: medium
estimate: L
depends_on: [phase-2-build.reporting-parity.custom-report-catalog-parity, phase-1-build.integration-etl-reporting.tenant-guest-token-rls-harness]
labels: [phase-2, reporting, agency, rollup, parity, 2a]
date: ~
---

Multi-dealer rollup reporting for DAS's agency/reseller customers on the Phase-1 platform — so an agency that manages many dealers sees cross-dealer aggregates within its own boundary, matching the rollup reporting DAS provides resellers today. Builds on the catalog parity reports, raising them from single-dealer to agency-scoped rollups.

**Scope:**
- Cross-dealer aggregation within an agency boundary: roll up the catalog-parity report set across the dealers an agency owns, with per-dealer breakdown and agency totals.
- Enforce the agency boundary with the Phase-1 per-tenant guest-token + RLS harness — an agency reaches only its member dealers' data, and never another agency's; a dealer still sees only itself.
- Store-neutral SQL, like the catalog parity — standard SQL over whichever analytical store the cloud bake-off selects.

**Acceptance:** an agency user opens a rollup report aggregating across only the dealers in its agency, with per-dealer breakdown and totals, RLS-enforced so no dealer outside the agency boundary is reachable; a single dealer's own reporting is unchanged.

**References:**
- Decided 2026-06-14: two-layer reporting on Apache Superset, headless/embedded, per-tenant isolation derived from the existing tenant model via a generated guest-token RLS clause (no second isolation mechanism) — `memory/decisions.md#d-031`
- Decided 2026-06-21 (Leo): PostgreSQL RLS confirmed as the multi-tenant isolation mechanism (tenant context via `app.current_tenant` GUC, `FORCE ROW LEVEL SECURITY`) — `memory/decisions.md#d-004`
- `wiki/Privacy-by-Design.md` · `wiki/Multi-Tenancy.md` — the per-tenant RLS isolation model the agency boundary is enforced against
- `docs/cloud-aws-vs-azure-bakeoff.md` — store-neutral SQL target (Redshift on AWS vs Postgres-only on Azure)
