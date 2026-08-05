---
title: "Read surfaces (Golden Record / Identity Map / Source Status / Data Health)"
type: story
status: planned
priority: high
estimate: XXL
depends_on: [phase-1-build.backend-data-model.graphql-surface]
labels: [frontend, surfaces, 1a]
date: ~
---

The four read views over the API: Golden Record, Identity Map, Source Status, and Data Health, served from the Strawberry GraphQL surface.

The **Identity Map** renders the resolved identity graph for a record: consumer-level identity links and, above them, the **household / family layer** — the derived household entity, its member consumers, and the detection signals (canonical address + ≥1 secondary signal) that grouped them, with provisional vs. curator-confirmed membership distinguished. See `wiki/Identity-Resolution.md` §Household / Family Resolution and the data model in `specs/02-phase-1-architecture/01-data-model/01-cdp-data-model-design.md`.

**Acceptance:** Golden Record, Identity Map, Source Status, and Data Health each render live data from the GraphQL surface; the Identity Map shows both the consumer identity-link layer and the household membership layer (provisional vs. curator-confirmed membership distinguished); all four are tenant-scoped so a user sees only their tenant's records and no cross-tenant data leaks into any view.

**References:**
- Decided 2026-06-13 (Phase 0 arch): Django + Strawberry GraphQL backend, Next.js frontend, 4 read surfaces (Golden Record / Identity Map / Source Status / Data Health) — `memory/decisions.md#d-087`
- Decided 2026-06-21 (Leo): PostgreSQL RLS is the confirmed multi-tenant isolation mechanism; resolver runs in a privileged role above RLS, serving stays tenant-scoped — `memory/decisions.md#d-004`
- Decided 2026-06-19 (Alicia): household = distinct entity, detected via canonical address + ≥1 secondary signal, membership provisional until curator-confirmed — `memory/decisions.md#d-108`
- `wiki/Frontend.md` — the four read surfaces
- `wiki/Identity-Resolution.md` §Household / Family Resolution — household detection signals and the consumer/household layering the Identity Map renders
- `wiki/Privacy-by-Design.md` — RLS isolation model serving the tenant-scoped views
- `specs/02-phase-1-architecture/01-data-model/01-cdp-data-model-design.md` — the data model behind the read surfaces
