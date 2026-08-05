---
title: "Segment definition model"
type: story
status: planned
priority: high
estimate: XL
depends_on: [phase-1-build.backend-data-model.data-model-foundation]
labels: [segmentation, model, 1a]
date: ~
---

A model to define segments as composable predicates over the resolved identity graph plus attributes and events — patterns, contact, purchase, media usage, demographics. Versioned and tenant-scoped so a definition is reproducible and auditable.

**Acceptance:** a segment composed of attribute, event, and identity-graph predicates persists and reloads losslessly; editing it creates a new immutable version while prior versions remain resolvable; a definition is scoped to its tenant and never visible or evaluable from another tenant.

**References:**
- Decided 2026-06-21 (Leo): PostgreSQL RLS is the confirmed multi-tenant isolation mechanism (resolver above RLS, tenant-scoped serving) — `memory/decisions.md#d-004`
- `wiki/Multi-Tenancy.md` — tenant isolation enforced at the database level via RLS; the basis for tenant-scoped, cross-tenant-invisible definitions
- `wiki/Data-Model.md` · `wiki/Identity-Resolution.md` — the resolved identity graph, attributes, and events that segment predicates compose over
