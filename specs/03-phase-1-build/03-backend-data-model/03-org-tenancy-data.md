---
title: "Org management & tenancy data (2b)"
type: story
status: planned
priority: high
estimate: XXL
depends_on: [phase-1-build.backend-data-model.data-model-foundation, phase-1-architecture.data-model.privacy-by-tenant]
labels: [backend, tenancy, rls, multi-tenant, 1a]
date: ~
---

Tenant/org data model with the dealership as the privacy boundary, enforced by Postgres RLS so attributes and events stay dealer-isolated. The cross-tenant identity resolver runs in a privileged GLOBAL role above tenant RLS to span the DAS-global identity graph.

**Acceptance:** dealership-scoped tables carry `FORCE ROW LEVEL SECURITY` and an RLS policy keyed on the tenant discriminator; with `app.current_tenant` set to dealer A, every SELECT/INSERT/UPDATE/DELETE returns/affects only A's rows and zero rows for dealer B (cross-tenant isolation test passes); the app role has no `BYPASSRLS`; the resolver runs in the privileged GLOBAL role and can span the cross-tenant identity graph while serving stays tenant-scoped.

**References:**
- Decided 2026-06-21 (Leo): RLS confirmed as the multi-tenant isolation primitive — shared-database/shared-schema + tenant discriminator, context via `app.current_tenant` GUC per transaction, `FORCE ROW LEVEL SECURITY`, `BYPASSRLS` reserved for narrow maintenance — `memory/decisions.md#d-004`
- Decided 2026-06-13 (Phase 0 architecture): resolver runs in a privileged GLOBAL role above tenant RLS; identity graph spans tenants (DAS-global), attributes/events dealer-isolated — `memory/decisions.md#d-004`
- `wiki/Multi-Tenancy.md` · `wiki/Privacy-by-Design.md` — two-plane isolation model (DAS identity plane crosses tenants, tenant fact plane never does) and the RLS enforcement mechanism
- `wiki/Identity-Resolution.md` · `docs/cdp-architecture.md` — cross-tenant resolver design and where it sits relative to tenant RLS
