---
title: "Segmentation Engine"
type: feature
status: planned
priority: high
depends_on: [phase-1-build.backend-data-model.org-tenancy-data, phase-1-build.identity-resolution-engine.resolution-engine-core]
labels: [segmentation, audiences, phase-1]
date: ~
---

The capability to pull, group, and target swaths of identities across the resolved graph — by patterns, contact, purchase, media usage, demographics, and event signals. The CDP needs this in Phase 1 to be useful beyond a golden record: defining and retrieving audiences.

Phase 1 scope: segment definition, evaluation/materialization, tenant-scoped retrieval, and membership explainability. **Outbound activation** (pushing audiences to ad/email/CRM platforms) is deferred to P2 — this feature builds the engine that produces and serves segments, not the downstream delivery. Tenant-scoped and provenance-aware throughout.

**Milestone.** define a multi-signal segment and retrieve its members, tenant-scoped, with explainable membership.
