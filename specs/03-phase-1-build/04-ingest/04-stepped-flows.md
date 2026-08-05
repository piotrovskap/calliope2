---
title: "Stepped flows"
type: story
status: planned
priority: high
estimate: XXL
depends_on: [phase-1-build.ingest.dag-base-conventions]
labels: [ingest, pipeline, 1a]
date: ~
---

The standard stepped flow — extract -> land (S3 bronze, parquet) -> normalize -> resolve -> CDP Postgres — built to be order-tolerant and replayable. Bronze (parquet, SSE-KMS) is the durable raw record; downstream steps re-run from bronze without re-hitting sources, and idempotency keys keep replays safe.

**Acceptance:** the extract->land->normalize->resolve flow populates CDP Postgres; re-running the full flow yields identical output (idempotent); normalize/resolve can be replayed from S3 bronze without re-hitting the source; and out-of-order step completion produces the same final state.

**References:**
- Raw-data buffer / bronze layer (2026-06-18, Leo): raw lands in object storage as parquet — the bronze layer dehydration runs from, replayable without re-hitting sources — `memory/decisions.md`
- Raw-first, process close to source, store everything (2026-06-17/18, Leo): raw ingest -> dehydration -> transform -> load; CDP retains the raw bronze and derives everything downstream — `memory/decisions.md`
- Source strategy: original sources only, not EDW (Dan Aston): originals -> Airflow -> S3 bronze -> normalize -> resolve -> CDP Postgres — `memory/decisions.md`
- Order-tolerant intake (2026-06-14, CloudEvents contract): fast-ACK + idempotency-key dedup; bitemporal observation table absorbs out-of-order — `memory/decisions.md`
- `docs/cdp-architecture.md` · `docs/cdp-reference-topology.md` — raw-first replayable bronze (SSE-KMS, parquet), the bronze -> normalize/validate -> resolve -> canonical Postgres flow, idempotent ingest invariant
- `wiki/Ingestion-Channels.md` — shared validate->normalize->resolve pipeline; idempotency key prevents duplicate processing
