---
title: "Versioned event contract & schema registry"
type: story
status: planned
priority: medium
estimate: L
depends_on: [phase-1-build.backend-data-model.data-model-foundation, phase-1-build.identity-resolution-engine.identity-record-event-sourcing]
labels: [backend, events, ai-readiness, contract, phase-1, 1a]
date: ~
---

Give the CDP event stream a **stable, versioned contract** so agents and models can replay and train against it without breaking on schema drift. Every emitted event (ingest, resolution, merge/split, consent change, curation decision) conforms to a registered, versioned schema; consumers pin a version and breaking changes are governed, not silent.

**Scope:**
- CloudEvents-style envelope (id, source, type, time, subject, tenant) + a typed, versioned payload schema per event type, described against the semantic glossary.
- A schema registry (the machine-readable contract artifact, CI-validated) listing every event type, its version, and its payload schema; KG-registered so agents discover event shapes.
- Compatibility policy: additive changes bump minor; breaking changes bump major and keep the prior version readable. No event ships without a registered schema.

**Acceptance:** every event type has a registered, versioned schema; the event log is replayable against a pinned version; a CI check rejects events whose payload diverges from the registered schema; an agent can enumerate event types and their schemas from the registry alone.

**References:**
- Decided 2026-06-12 (Dan Aston): event intake co-primary with Airflow batch; generic bus-agnostic intake, sources graduate batch→events — `memory/decisions.md#d-045`
- Decided 2026-06-13 (Leo, Phase 0 arch recommendation): DAS publishes **CloudEvents 1.0** envelope; bus-agnostic config-only adapter, idempotency-key dedup, order-tolerant — `memory/decisions.md`
- Locked 2026-06-18 (Alicia + Luis, A3): bitemporal/provenance table shapes, append-only as-of event spine, 15-table Phase 1 set — typed payloads describe against this model — `memory/decisions.md#d-082`
- `docs/cdp-architecture.md` — CloudEvents 1.0 publishing, NATS JetStream event log/replay, raw-first replayable bronze
- `wiki/Ingestion-Channels.md` — per-source adapters map to the canonical schema; payload validation (Zod / Pydantic)
