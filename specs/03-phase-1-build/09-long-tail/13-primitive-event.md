---
title: "Webhook / event source primitive"
type: story
status: planned
priority: high
estimate: XL
depends_on: [phase-1-build.ingest.source-registry]
labels: [long-tail, primitive, intake, event, 1a]
date: ~
---

Scaffolding primitive. Reusable event intake: webhook adapter + CloudEvents normalization onto the NATS backbone with raw replay and DLQ. New event source plugs into the contract.

**Acceptance:** a documented, tested intake interface for the event type that a new source of this type adopts via registry configuration with no bespoke connector code; covers auth, schema mapping, error handling/DLQ, and tenant attribution.

**References:**
- Decided 2026-06-12 (Dan Aston): event intake co-primary with batch — generic bus-agnostic intake, one shared pipeline, sources graduate batch→events without redesign — `memory/decisions.md#d-045`
- Decided 2026-06-12 (CONFLICT): event contract — DAS publishes CloudEvents 1.0, fast-ACK + idempotency-key dedup, our-side S3 DLQ, order-tolerant — `memory/decisions.md#d-045`
- `wiki/Ingestion-Channels.md` · `docs/cdp-architecture.md` — bus-agnostic NATS JetStream backbone with per-bus adapters; webhook/event-stream channels
