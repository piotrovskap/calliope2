---
title: "Database / SQL source primitive"
type: story
status: planned
priority: high
estimate: XL
depends_on: [phase-1-build.ingest.source-registry]
labels: [long-tail, primitive, intake, db, 1a]
date: ~
---

Scaffolding primitive. Reusable database-source intake: connection + auth, schema introspection, incremental/CDC extract, batched load into bronze via the config-driven registry. Onboarding a DB source becomes config, not code.

**Acceptance:** a documented, tested intake interface for the db type that a new source of this type adopts via registry configuration with no bespoke connector code; covers auth, schema mapping, error handling/DLQ, and tenant attribution.

**References:**
- Decided 2026-06-13 (Leo, Phase 0 arch recommendation): source onboarding = config-driven source registry (declarative per-source mapping + provenance tag) — `memory/decisions.md#d-076`
- Decided 2026-06-17 (Dan Aston): templated, convention-driven DAG ecosystem (reusable operators/hooks, DAG factories, templated per-source onboarding) over the registry — `memory/decisions.md#d-100`
- Decided 2026-06-18 (Leo): raw ingest lands in a raw/staging buffer (object storage, parquet bronze); CDC via Debezium (OSS, portable) or cloud-native DMS — `memory/decisions.md#d-008`
- `docs/cdp-architecture.md` · `wiki/Tech-Stack.md` — batch pull via Airflow + source CDC (Debezium / DMS) into encrypted parquet bronze; new source = adapter + field map + config
- `specs/03-phase-1-build/04-ingest/06-source-registry.md` — the registry-entry contract a db source adopts (connection/auth, field mapping, identity keys, provenance, consent linkage, DQ, retention)
