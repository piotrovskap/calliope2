---
title: "NATS event backbone + raw replay"
type: story
status: planned
priority: high
estimate: XXL
depends_on: [phase-1-build.foundation.data-stores-provisioning, phase-1-build.ingest.event-grid-webhook-adapter]
labels: [ingest, events, nats, 1a]
date: ~
---

NATS JetStream is the internal event backbone and event log (retention + replay) — not a Postgres table. The webhook adapter fast-ACKs by publishing to NATS and landing the raw event to S3 bronze; downstream consumers (normalize, resolve) read from NATS; S3 bronze enables full replay.

**Acceptance:** the webhook adapter publishes each intake event to a NATS JetStream stream AND lands the raw event to S3 bronze before ACK; a normalize/resolve consumer reads from the JetStream stream and processes events; replaying a bronze partition re-emits the events through the pipeline and produces identical downstream output (idempotent, no duplicates, no data loss); JetStream retention/replay is configured (not a Postgres table).

**References:**
- Decided 2026-06-12 (Dan Aston): event intake is co-primary with Airflow batch; generic bus-agnostic intake, one shared validate→normalize→resolve pipeline — `memory/decisions.md#d-045`
- Decided 2026-06-17 (messaging split): NATS JetStream = event-stream intake (ingestion backbone + log/replay); RabbitMQ = app messaging — `memory/decisions.md#d-091`
- Decided 2026-06-18 (Leo): raw lands in bronze (object storage, parquet); dehydration runs from there — `memory/decisions.md#d-008`
- Decided 2026-06-21 (Leo): no tokenization barrier in front of block storage / event processing — edge zone is raw+fragmented, governed by bounded retention + access control — `memory/decisions.md#d-012`
- `wiki/Tech-Stack.md` · `docs/cdp-architecture.md` · `docs/cdp-reference-topology.md` — NATS JetStream as event-stream intake backbone + log/replay; S3 bronze as replayable raw landing
