---
title: "Web-UI admin with CRUD (not Django admin)"
type: story
status: planned
priority: high
estimate: XXL
depends_on: [phase-1-build.frontend.frontend-rbac, phase-1-build.backend-data-model.rest-surface]
labels: [frontend, admin, crud, 1a]
date: ~
---

A custom in-app admin for CRUD over managed entities and config, built in the Next.js UI. Explicitly NOT Django admin — Django admin is never exposed to operators. All actions RBAC-gated and tenant-scoped.

**Acceptance:** an authorized operator can create, read, update, and delete managed records entirely in the Next.js UI; every operation is RBAC-gated and tenant-scoped so an operator cannot read or mutate another tenant's records; and Django admin is unreachable to operators (no link, no route).

**References:**
- Decided 2026-06-13 (Leo, Phase 0 architecture recommendation): Next.js frontend + Auth0 4-role RBAC (das_admin/das_analyst/dealer_admin/dealer_user) — `memory/decisions.md#d-086`
- Decided 2026-06-18 (Alicia + Luis): REST surface serves admin CRUD (GraphQL is for consumer-360) — `memory/decisions.md#d-002`
- `wiki/Multi-Tenancy.md` — tenant isolation enforced at DB (RLS on `dealership_id`), API middleware, and frontend route guards; das_admin global view via explicit audited RLS bypass
- `wiki/Tech-Stack.md` · `wiki/Frontend.md` — Next.js (`boilerworks-django-nextjs`) operator/analyst surfaces, not consumer-facing
