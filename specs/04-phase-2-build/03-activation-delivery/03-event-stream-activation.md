---
title: "Event-stream activation"
type: story
status: planned
priority: medium
estimate: M
depends_on: [phase-1-build.ingest.nats-event-backbone, phase-1-build.backend-data-model.versioned-event-contract]
labels: [phase-2, activation, events, net-new, 2a]
date: ~
---

Activate the CDP event stream for external/real-time consumers. The NATS event backbone and the versioned event contract are **built in Phase 1** but kept internal (built-then-disabled for outbound); this story turns on governed outbound event subscription so downstream apps and partners can consume CDP events (resolution, merge/split, consent change, lifecycle) in real time.

**Scope:**
- Governed outbound subscriptions over the Phase-1 NATS backbone against the Phase-1 versioned event contract — typed, auth-scoped, tenant-filtered.
- Consumer registration + per-subject authorization; replay window honored from the existing event log.
- No new event infrastructure — this exposes what Phase 1 built.

**Acceptance:** an authorized external consumer subscribes to a permitted, tenant-scoped event subject and receives conformant versioned events in real time, with replay available from the Phase-1 event log; unauthorized subjects are denied.

**References:**
- Decided 2026-06-12 (Dan Aston): event intake co-primary with batch; raw events captured at the point of consumption — `memory/decisions.md#d-045`
- Decided 2026-06-17: NATS JetStream is the event-stream backbone + event log (retention/replay); also line 118 — `memory/decisions.md#d-091`
- `docs/cdp-architecture.md` — outbound publishing built and wired in Phase 1 but disabled via config; Phase-2 activation is config-only, no code changes (Event Stream §2)
- `wiki/Tech-Stack.md` · `wiki/Ingestion-Channels.md` — NATS JetStream event-stream intake/log; bus-agnostic event channel
- `docs/deliverables/detailed-phase-1-2-plans.md` — Phase-2 Activation & Delivery: event-stream activation over the Phase-1 NATS backbone
