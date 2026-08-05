---
title: "Backend & Data Model"
type: feature
status: planned
priority: high
depends_on: [phase-1-architecture.data-model.cdp-data-model-design]
labels: [track-2, backend, data-model, django, phase-1]
date: ~
---

The Django backend: canonical schema, permissions, org/tenancy data, and the GraphQL + REST serving surfaces. PostgreSQL native model plus RLS as both canonical store and serving layer, with backend permissions as the single source of truth the frontend RBAC mirrors.

**Milestone.** Data model live with RLS; REST + GraphQL serving consumer-360 and ops; permissions enforced server-side across all four roles.
