---
title: "Frontend RBAC"
type: story
status: planned
priority: high
estimate: XL
depends_on: [phase-1-build.frontend.auth-auth0, phase-1-build.backend-data-model.permissions]
labels: [frontend, rbac, permissions, 1a]
date: ~
---

Role-gated routes and components for the four roles (das_admin, das_analyst, dealer_admin, dealer_user), mirroring the backend permission model as the single source of truth. Enforce deny-by-default so unlisted access is denied.

**Acceptance:** for each of the four roles, only permitted routes render and disallowed routes/components are hidden; any route/action not explicitly granted is denied (deny-by-default); and a direct request to a gated route the user lacks resolves to the same deny the backend returns, so frontend gating never grants more than backend authz.

**References:**
- Decided 2026-06-13 (Leo, Phase 0 arch recommendation): Auth0 primary, 4-role group-based (das_admin/das_analyst/dealer_admin/dealer_user) — `memory/decisions.md#d-086`
- `wiki/Multi-Tenancy.md` — the four roles and their scope/access, and the three enforcement layers (RLS, API middleware, frontend route guards) that must stay consistent
- `wiki/Frontend.md` · `wiki/Tech-Stack.md` — operator/analyst surfaces under the 4-role model; Auth0 as the auth layer
