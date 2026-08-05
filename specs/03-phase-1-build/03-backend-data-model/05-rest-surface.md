---
title: "REST surface (2d)"
type: story
status: planned
priority: high
estimate: XL
depends_on: [phase-1-build.backend-data-model.org-tenancy-data]
labels: [backend, rest, drf, 1a]
date: ~
---

DRF REST surface for ingestion/ops plus backing the web-UI admin CRUD, tenant-scoped and permission-aware. Endpoints enforce the backend permission matrix and Postgres RLS so ops and admin writes stay within the dealer boundary.

**Acceptance:** ingestion/ops and admin-CRUD endpoints accept reads and writes scoped to the caller's dealer; a write or read targeting another dealer's rows is rejected (RLS + permission-matrix enforced), and an action outside the caller's role returns a deny — verified by test.

**References:**
- Decided 2026-06-18 (Alicia + Luis, A3): REST+GraphQL dual surface re-confirmed — REST for ingestion/ops/admin CRUD, GraphQL for consumer-360 — `memory/decisions.md#d-002`
- Decided 2026-06-21 (Leo): RLS confirmed as the tenant-isolation mechanism — tenant context via `app.current_tenant` GUC per transaction, `FORCE ROW LEVEL SECURITY`, `BYPASSRLS` reserved for maintenance — `memory/decisions.md#d-010`
- Decided 2026-06-13 (Leo, Phase 0 arch): Django (REST) backend; Auth0 4-role group-based auth, API-key/HMAC for ingestion — `memory/decisions.md#d-087`
- `docs/cdp-architecture.md` · `wiki/Tech-Stack.md` — dual REST+GraphQL surface, Python-primary Django backend, 4-role auth
- `wiki/Privacy-by-Design.md` — RLS tenant-isolation mechanism the endpoints enforce
