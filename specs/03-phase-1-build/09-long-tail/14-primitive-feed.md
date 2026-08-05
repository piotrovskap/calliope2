---
title: "CSV / flat-feed source primitive"
type: story
status: planned
priority: high
estimate: XL
depends_on: [phase-1-build.ingest.source-registry]
labels: [long-tail, primitive, intake, feed, 1a]
date: ~
---

Scaffolding primitive. Reusable flat-feed intake: schema-on-read for CSV/TSV/JSON drops, column mapping, validation, load. Shared by the long-tail file sources.

**Acceptance:** a documented, tested intake interface for the feed type that a new source of this type adopts via registry configuration with no bespoke connector code; covers auth, schema mapping, error handling/DLQ, and tenant attribution.

**References:**
- Decided 2026-06-13 (Leo, Phase 0 arch recommendation): source onboarding = config-driven source registry (declarative per-source mapping + provenance tag) — `memory/decisions.md#d-076`
- Decided 2026-06-17 (Dan Aston): templated, convention-driven DAG ecosystem (operators/hooks, DAG factories, templated per-source onboarding) over the config-driven registry — the mechanism that makes a reusable type primitive affordable across the long tail — `memory/decisions.md#d-100`
- Decided 2026-06-12 (Dan Aston): Airflow batch is primary intake — most CRM/DMS data arrives via CSV/FTP today — `memory/decisions.md#d-045`
- `docs/cdp-architecture.md` · `wiki/Ingestion-Channels.md` — generic intake + Airflow batch sharing one validate->normalize->resolve pipeline; new source = field map + channel config, not code
- `specs/03-phase-1-build/04-ingest/06-source-registry.md` — the registry-entry contract this primitive is configured by (type, connection, field mapping + semantic metadata, identity keys, provenance, consent linkage, DQ contract)
- `docs/source-onboarding-ledger.md` — authoritative type-primitive + per-source list; `primitive-feed` is the CSV/flat-feed type handler (TrueCar = feed channel rep)
