---
title: "Backend permissions (2a)"
type: story
status: planned
priority: high
estimate: XL
depends_on: [phase-1-build.backend-data-model.data-model-foundation]
labels: [backend, permissions, authz, 1a]
date: ~
---

Authz model mapping the 4 roles (das_admin, das_analyst, dealer_admin, dealer_user) to object- and field-level permissions, deny-by-default. This is the single source of truth the frontend RBAC mirrors, so the matrix must be queryable by the frontend rather than duplicated there.

**Acceptance:** each of the 4 roles is granted only its permitted object/field actions and denied all others (deny-by-default verified by test for an unlisted action); a request exceeding a role's grant is rejected server-side; the frontend can fetch the full matrix from a single endpoint rather than hardcoding it.

**References:**
- Decided 2026-06-21 (Leo): RLS confirmed as the isolation mechanism, deny-by-default, `app.current_role`/`app.current_tenant` context per transaction, `BYPASSRLS` reserved for narrow maintenance — `memory/decisions.md#d-004`
- 4-role group-based auth (das_admin/das_analyst/dealer_admin/dealer_user), Auth0 primary; permissions group-based only, never per-user — `memory/decisions.md`
- `wiki/Multi-Tenancy.md` — the four-role scope/capability matrix and the three enforcement layers (DB RLS, API middleware, frontend route guards) this authz model is the source of truth for
