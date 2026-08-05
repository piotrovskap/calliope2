---
title: "Access & user management UI"
type: story
status: planned
priority: high
estimate: XL
depends_on: [phase-1-build.frontend.admin-crud-ui]
labels: [frontend, admin, access, 1a]
date: ~
---

An admin surface to manage and check users, roles, and tenant access, and to audit current access state. Scoped to das_admin.

**Acceptance:** a das_admin can assign and revoke a user's role and tenant access and see the change reflected in a current-access view; non-das_admin roles cannot reach or invoke this surface (gated and tenant-scoped); and the access view lists each user's effective roles and tenants without exposing other tenants' users to a tenant-scoped admin.

**References:**
- Decided 2026-06-21 (Leo): RLS confirmed as the multi-tenant isolation mechanism; `das_admin` queries across tenants via privileged/`app.current_role` check, serving stays tenant-scoped — `memory/decisions.md#d-004`
- `wiki/Multi-Tenancy.md` — the four roles (das_admin/das_analyst/dealer_admin/dealer_user) and their scope/permission matrix this surface manages
- `wiki/Tech-Stack.md` — Auth0 (federates EntraID), 4-role group-based auth model
