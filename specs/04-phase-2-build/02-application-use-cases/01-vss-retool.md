---
title: "VSS retool on the CDP (flagship)"
type: story
status: planned
priority: high
estimate: XL
depends_on: [phase-1-build.backend-data-model.graphql-surface, phase-1-build.identity-resolution-engine.identity-record-event-sourcing]
labels: [phase-2, applications, vss, proof-case, parity, 2b]
date: ~
---

Rebuild the Vehicle Smart Score (VSS) — the app the engagement is named against — to consume the Phase-1 golden record instead of re-aggregating consumer+vehicle data and re-solving identity itself. See the rationale catalog (`00-feature.md` §3): the Field Catalog v1 came directly from the VSS data mapping, so the CDP is a superset of what VSS needs.

**Scope:** point VSS at the Phase-1 consumer-360 (GraphQL) surface for the resolved record; drop its from-scratch identity/aggregation; gain CDP-supplied fields VSS marks unsupported today (completed/declined services, recalls, equity freshness); consent-gated and tenant-scoped; event-driven via the CDP intake (VSS already publishes via Event Grid).

**Acceptance:** VSS reads its resolved consumer+vehicle record exclusively from the CDP consumer-360 GraphQL surface (no in-app identity resolution or cross-source aggregation code path remains); the previously-unsupported fields (`CompletedServices`, `DeclinedServices`, recalls, equity freshness) are populated on the record; scores for a known consumer match or exceed today's VSS output on a side-by-side sample; every read is tenant-scoped (RLS) and consent-gated; and VSS receives updates event-driven via the CDP intake adapter (Event Grid). The lowest-risk first Phase-2 app and the cleanest proof of objective 1.

**References:**
- Decided 2026-06-19 (Alicia Salazar): Field Catalog v1 prioritization locked — VSS data mapping seeded the catalog, so the CDP is a superset of VSS's needs — `memory/decisions.md#d-010`
- Decided 2026-06-18 (Alicia + Luis): REST+GraphQL dual surface re-confirmed — GraphQL serves consumer-360, the surface VSS reads — `memory/decisions.md#d-002`
- Decided 2026-06-12 (Dan Aston, client-confirmed): generic bus-agnostic event intake co-primary with batch; DAS Event Grid is the first adapter — VSS already publishes via Event Grid — `memory/decisions.md#d-045`
- Decided 2026-06-21 (Leo): PostgreSQL RLS confirmed as tenant isolation; resolver above RLS, tenant-scoped serving — `memory/decisions.md#d-004`
- `wiki/Tech-Stack.md` · `wiki/Data-Model.md` — the golden-record entities/fields VSS consumes
- `docs/cdp-field-source-matrix.md` — Field Catalog v1 fields, sources, and Phase column
- `specs/04-phase-2-build/02-application-use-cases/00-feature.md` §3 — VSS retool rationale catalog
