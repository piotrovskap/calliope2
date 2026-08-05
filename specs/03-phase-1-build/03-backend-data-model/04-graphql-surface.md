---
title: "GraphQL surface (2c)"
type: story
status: planned
priority: high
estimate: XL
depends_on: [phase-1-build.backend-data-model.org-tenancy-data]
labels: [backend, graphql, strawberry, 1a]
date: ~
---

Strawberry GraphQL surface for consumer-360 queries, tenant-scoped and permission-aware, resolving the golden record over the bitemporal model. Queries respect RLS and the backend permission matrix so no field leaks outside a dealer's boundary.

**Acceptance:** a consumer-360 query resolves the golden record over the bitemporal model and returns only fields the caller's role permits; the same query run as another dealer returns no rows for a person outside that dealer's boundary (RLS-enforced, verified by test).

**References:**
- Decided 2026-06-13 (re-confirmed 2026-06-18, Alicia + Luis): REST + GraphQL dual surface — GraphQL (Strawberry) for consumer-360 — `memory/decisions.md#d-002`
- Updated 2026-06-21 (Leo): RLS confirmed as multi-tenant isolation mechanism; resolver runs above RLS, serving stays tenant-scoped — `memory/decisions.md#d-004`
- Locked 2026-06-18 (Alicia + Luis): bitemporal/provenance model + golden-record as-of evolution view — `memory/decisions.md#d-082`
- `docs/cdp-architecture.md` · `wiki/Tech-Stack.md` — Strawberry GraphQL as the Consumer 360 surface on the Python-primary backend
- `wiki/Privacy-by-Design.md` — RLS isolation (tenant context via `app.current_tenant` GUC, `FORCE ROW LEVEL SECURITY`)
