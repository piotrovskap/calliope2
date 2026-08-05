---
title: "Consumer / dealer mobile app"
type: story
status: planned
priority: medium
estimate: M
depends_on: [phase-1-build.backend-data-model.graphql-surface]
labels: [phase-2, applications, mobile, net-new, 2b]
date: ~
---

A mobile surface over the CDP — the consumer/dealer app layer that consumes the Phase-1 consumer-360 (GraphQL) surface rather than re-solving identity per app. Native/mobile companion to the read surfaces, scoped to the same Phase-1 RBAC + tenant boundaries.

**Scope:** mobile access to the resolved consumer record and the apps built on it (maintenance/service, offers, account); consent- and tenant-scoped via the Phase-1 permission model; reuses the Phase-1 GraphQL/REST surfaces — no separate backend. Representative scope to show the application layer extends to mobile; specific app surfaces are sized when committed.

**Acceptance:** a mobile client authenticates via the Phase-1 auth model and reads tenant-/role-scoped golden-record data through the existing API surfaces, with no cross-tenant leakage and no app-specific identity resolution.

**References:**
- Decided 2026-06-18 (Alicia + Luis, A3): REST+GraphQL dual surface re-confirmed — GraphQL for consumer-360 reads, REST for ingestion/ops; downstream apps consume the shared surface — `memory/decisions.md#d-002`
- Decided 2026-06-21 (Leo): PostgreSQL RLS is the confirmed multi-tenant isolation mechanism (tenant context per transaction; resolver above RLS, serving tenant-scoped) — `memory/decisions.md#d-004`
- `docs/cdp-architecture.md` — the dual REST/GraphQL Consumer 360 surface that downstream apps query (one shared backend, auth, and tenant context)
- The mobile surface itself is net-new in this plan — no app-specific governing decision yet.
