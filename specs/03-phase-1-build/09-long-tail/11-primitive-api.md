---
title: "REST / API source primitive"
type: story
status: planned
priority: high
estimate: XL
depends_on: [phase-1-build.ingest.source-registry]
labels: [long-tail, primitive, intake, api, 1a]
date: ~
---

Scaffolding primitive. Reusable API-poll intake: auth (key/OAuth), pagination, rate-limit handling, schema mapping, scheduled pull into bronze. New API source = a registry entry.

**Acceptance:** a documented, tested intake interface for the api type that a new source of this type adopts via a registry entry with no bespoke connector code; the primitive handles key and OAuth auth, paginated pulls, rate-limit backoff/retry, field-to-canonical schema mapping, and scheduled landing into bronze parquet; failed records route to the S3 DLQ; landed records carry source provenance and tenant attribution. A new api source onboarded by registry config alone runs end-to-end and lands records in bronze.

**References:**
- Decided 2026-06-13 (Leo, Phase 0 arch recommendation): source onboarding = config-driven source registry (declarative per-source mapping + provenance tag); vendor APIs are an original source class — `memory/decisions.md#d-076`
- Decided 2026-06-17 (Dan Aston): templated, convention-driven DAG ecosystem (reusable operators/hooks, DAG factories) over the registry — the reuse mechanism each primitive embodies — `memory/decisions.md#d-100`
- Decided 2026-06-18 (Leo): raw lands in the bronze layer (object storage, parquet); intake pulls land here before dehydration — `memory/decisions.md#d-008`
- `specs/03-phase-1-build/04-ingest/06-source-registry.md` — the registry-entry contract (type, connection/auth, field mapping, identity keys, provenance, DQ, retention) this primitive is configured by
- `docs/cdp-architecture.md` · `wiki/Ingestion-Channels.md` — generic intake sharing one validate->normalize->resolve pipeline; new source = adapter + field map + config
- `docs/source-onboarding-ledger.md` — the per-source onboard list this api type primitive serves
