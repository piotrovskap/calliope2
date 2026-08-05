---
title: "DAG base + conventions"
type: story
status: planned
priority: high
estimate: XL
depends_on: [phase-1-build.ingest.dag-framework]
labels: [ingest, conventions, 1a]
date: ~
---

Base classes plus conventions for ingestion DAGs — naming, retries, idempotency keys, provenance tagging at ingestion time, and the S3 bronze layout (raw, replayable, partitioned). Encodes the framework's defaults so every DAG inherits consistent, replay-safe behavior.

**Acceptance:** a DAG built on the base classes inherits a deterministic idempotency key, ingestion-time provenance tags, and the partitioned S3 bronze layout by default; re-running it produces no duplicate output, and the conventions are documented.

**References:**
- Decided 2026-06-13 (Confluence baseline, amended Dan Aston 2026-06-12): Airflow = all batch ingest; data provenance classification required at ingestion time — `memory/decisions.md#d-045`
- Raw-data buffer / bronze layer (2026-06-18, Leo): raw lands in object storage as parquet — raw, replayable, the bronze layer dehydration runs from — `memory/decisions.md`
- Source onboarding 2026-06-13 (Leo): config-driven source registry — declarative per-source mapping + provenance tag — `memory/decisions.md`
- Ingest tokenization boundary (2026-06-21, Leo): bronze parquet landing is the raw, fragmented ingest edge — tokens enter at the CDP boundary, not the edge — `memory/decisions.md`
- `docs/cdp-architecture.md` · `wiki/Tech-Stack.md` — Airflow/MWAA orchestration, S3 bronze (SSE-KMS, replayable), S3-replay DR
- `wiki/Ingestion-Channels.md` — shared validate→normalize→resolve pipeline; idempotency key prevents duplicate processing
