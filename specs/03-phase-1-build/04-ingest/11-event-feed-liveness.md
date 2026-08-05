---
title: "Event-feed liveness monitoring"
type: story
status: planned
priority: medium
estimate: L
depends_on: [phase-1-build.ingest.event-grid-webhook-adapter, phase-1-build.foundation.observability]
labels: [ingest, events, monitoring, 1a]
date: ~
---

The DAS-owned Event Grid subscription is a **monitored critical-path dependency** — if it stops publishing, the CDP silently starves. Track event-feed liveness (volume, lag, last-seen per source) and alert on starvation; surface it on the Data Source Status view. Ownership of the subscription documented with DAS.

**Acceptance:** per-source liveness metrics (event volume, delivery lag, last-seen timestamp) are emitted via OTel and queryable in Grafana; a starvation alert fires when a source's last-seen exceeds its configured staleness threshold; the per-source liveness/last-seen state renders on the Data Source Status view; and the Event Grid subscription owner is recorded in the source registry.

**References:**
- Decided 2026-06-13 (Leo, Phase 0 arch recommendation — Event delivery Option A): the DAS-owned Event Grid subscription is a monitored critical-path dependency; Data Source Status alerts on event-feed liveness; ownership documented with DAS — `memory/decisions.md#d-080`
- Decided 2026-06-17 (Dan Aston): Event Grid subscription/contract is a joint workstream with DAS (subscription wiring, CloudEvents 1.0, delivery auth) — `memory/decisions.md#d-102`
- `docs/cdp-architecture.md` (Observability) — OTel → Prometheus → Grafana telemetry path the liveness metrics ride on
