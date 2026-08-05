---
title: "Activation & Delivery"
type: feature
status: planned
priority: medium
labels: [phase-2, activation, outbound, delivery]
date: ~
---

The outbound delivery layer — the capability Phase 1 explicitly defers (see `phase-1-build.segmentation-engine`: "Outbound activation to external platforms is deferred to P2"). Phase 1 builds and serves segments, the event backbone, and the consent/suppression engine; this feature pushes them **outbound** to external destinations and adds first-party web collection.

**Not in this feature (delivered in Phase 1):** segment definition/evaluation/targeting and the web-UI to use it, Superset/Redshift analytics dashboards, vault erasure + consent/suppression, and the web-UI admin. Phase 2 activates and delivers on top of that infrastructure — it does not rebuild it. All infrastructure (incl. the NATS outbound backbone) is provisioned in Phase 1.
