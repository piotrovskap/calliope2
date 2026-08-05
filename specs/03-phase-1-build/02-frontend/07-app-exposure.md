---
title: "Role-based app exposure"
type: story
status: planned
priority: high
estimate: L
depends_on: [phase-1-build.frontend.frontend-rbac, phase-1-build.frontend.read-surfaces]
labels: [frontend, exposure, 1a]
date: ~
---

Wire the read surfaces and admin to the API with role- and tenant-scoped exposure, so each role and tenant sees only its permitted surfaces and data.

**Acceptance:** for each of the four roles and at least two tenants, the surfaces and admin exposed match the permitted set and nothing more; a user sees only their tenant's data on every wired surface, with no cross-tenant exposure in any role/tenant combination.

**References:**
- Decided 2026-06-13 (Leo, Phase 0 arch recommendation): Auth0 primary, 4-role group-based (das_admin/das_analyst/dealer_admin/dealer_user) — `memory/decisions.md#d-086`
- Decided 2026-06-21 (Leo): PostgreSQL RLS confirmed as the multi-tenant isolation mechanism; tenant context via JWT claims into the DB session, serving stays tenant-scoped — `memory/decisions.md#d-004`
- `wiki/Multi-Tenancy.md` — the four roles and their permitted surfaces/scope, and the three enforcement layers (RLS, API middleware, frontend route guards) that must stay consistent
- `wiki/Privacy-by-Design.md` — RLS tenant isolation primitive the per-user/per-tenant serving is scoped by

**Milestone.**
