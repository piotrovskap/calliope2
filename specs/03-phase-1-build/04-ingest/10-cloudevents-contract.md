---
title: "CloudEvents contract + DLQ"
type: story
status: planned
priority: medium
estimate: XL
depends_on: [phase-1-build.ingest.event-grid-webhook-adapter]
labels: [ingest, events, cloudevents, 1a]
date: ~
---

Establish the event contract with DAS as **CloudEvents 1.0** — schema + versioning + delivery auth — so a future direct-publish path (bus-agnostic, off Event Grid) is a config swap, not a rewrite. S3 DLQ for events that fail validation/processing; idempotency-key dedup.

**Acceptance:** ingested events validate against a published CloudEvents 1.0 schema with an explicit version field; events failing validation/processing land in the S3 DLQ with original payload + failure reason and can be replayed back through the pipeline; duplicate events (same idempotency key) are deduped, not reprocessed; the contract (schema, versioning, delivery auth) is documented and agreed with DAS.

**References:**
- Decided 2026-06-12 (Dan Aston / CONFLICT): bus-agnostic generic event intake, one shared validate→normalize→resolve pipeline, sources graduate batch→events without redesign — `memory/decisions.md#d-045`
- Decided 2026-06-13 (Leo, Phase 0 arch — Option A): DAS publishes CloudEvents 1.0 (keeps a future direct-publish a config swap, not a rewrite); fast-ACK + idempotency-key dedup; our-side S3 DLQ; order-tolerant — `memory/decisions.md#d-079`
- Decided 2026-06-17 (Dan Aston): Event Grid subscription/contract — CloudEvents 1.0 publishing + delivery auth (Entra token vs signature) — worked jointly with DAS — `memory/decisions.md#d-102`
- `docs/cdp-architecture.md` · `wiki/Ingestion-Channels.md` — bus-agnostic NATS intake, Event Grid as the first config-only adapter, CloudEvents 1.0 contract + idempotency
