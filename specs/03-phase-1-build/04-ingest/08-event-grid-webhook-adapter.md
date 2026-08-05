---
title: "Event Grid webhook adapter (event intake)"
type: story
status: planned
priority: high
estimate: XXL
depends_on: [phase-1-build.ingest.stepped-flows, phase-1-build.backend-data-model.data-model-foundation]
labels: [ingest, events, webhook, 1a]
date: ~
---

The real-time event-intake path, co-primary with Airflow batch (decided Option A): DAS adds an Event Grid event-subscription pointed at a CDP webhook URL (config-only on the DAS side, no Azure compute we run). Our adapter validates, **fast-ACKs**, dedups on an idempotency key, and hands off into the shared normalize -> resolve pipeline. Order-tolerant (bitemporal absorbs out-of-order).

**Acceptance:** an Event Grid event hits the CDP webhook, is fast-ACKed, deduped, and flows through the same normalize/resolve path as batch; duplicate and out-of-order deliveries are handled.

**References:**
- Decided 2026-06-12 (Dan Aston): event intake is co-primary with Airflow batch — DAS publishes from its Event Grid bus, CDP captures raw at point of consumption — `memory/decisions.md#d-045`
- Decided 2026-06-12 (CONFLICT design principle): generic bus-agnostic intake, per-bus adapters (Event Grid first), one shared validate→normalize→resolve pipeline — `memory/decisions.md#d-045`
- Decided 2026-06-12 (Option A): Event Grid → CDP webhook, config-only on DAS side; CloudEvents 1.0 contract, fast-ACK + idempotency-key dedup, S3 DLQ, order-tolerant via bitemporal — `memory/decisions.md#d-045`
- Decided 2026-06-17: Event Grid subscription/contract (wiring, CloudEvents 1.0, delivery auth) is a joint workstream with DAS, not a unilateral deliverable — `memory/decisions.md#d-102`
- `wiki/Ingestion-Channels.md` — Event Stream channel: NATS JetStream backbone + Event Grid as first external adapter
- `docs/cdp-architecture.md` · `wiki/Tech-Stack.md` — shared ingest pipeline and event intake stack
