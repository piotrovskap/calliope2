---
title: "Segment retrieval & targeting API"
type: story
status: planned
priority: high
estimate: XL
depends_on: [phase-1-build.segmentation-engine.segment-evaluation-engine, phase-1-build.backend-data-model.org-tenancy-data]
labels: [segmentation, api, 1a]
date: ~
---

Pull, group, and target identities by segment via the API and web-UI surfaces — counts, paging, and member retrieval — tenant-scoped and RBAC-gated. Outbound activation to external platforms is deferred to P2; this is the internal retrieval/targeting surface.

**Acceptance:** the API returns a segment's member count and a paged member list filtered to the caller's tenant and gated by RBAC; a request for a segment in another tenant returns not-found (no cross-tenant leakage); a caller lacking the role is denied.

**References:**
- Decided 2026-06-21 (Leo): PostgreSQL + RLS is the confirmed multi-tenant isolation mechanism — serving stays tenant-scoped, resolver runs in a privileged role above RLS — `memory/decisions.md#d-004`
- Decided 2026-06-13 (Leo, Phase 0 architecture recommendation): Auth0 primary, 4-role group-based RBAC (das_admin / das_analyst / dealer_admin / dealer_user) — `memory/decisions.md#d-086`
- `docs/cdp-architecture.md` — four-layer architecture, PostgreSQL + RLS, tenant-scoped serving above the cross-tenant resolver
- `specs/03-phase-1-build/08-segmentation-engine/00-feature.md` — Phase-1 scope: tenant-scoped retrieval with explainable membership; outbound activation deferred to P2
