---
title: "SFTP / file-drop source primitive"
type: story
status: planned
priority: high
estimate: XL
depends_on: [phase-1-build.ingest.source-registry]
labels: [long-tail, primitive, intake, sftp, 1a]
date: ~
---

Scaffolding primitive. Reusable file-drop intake: SFTP poll, file-pattern + manifest handling, decompress/parse (CSV/fixed-width), idempotent load. New feed = config.

**Acceptance:** a documented, tested intake interface for the sftp type that a new source of this type adopts via registry configuration with no bespoke connector code; covers auth, schema mapping, error handling/DLQ, and tenant attribution.

**References:**
- Decided 2026-06-13 (Leo, Phase 0 arch recommendation): source onboarding = config-driven source registry (declarative per-source mapping + provenance tag) — `memory/decisions.md#d-076`
- Decided 2026-06-17 (Dan Aston): templated, convention-driven DAG ecosystem (reusable operators/hooks, DAG factories, templated per-source onboarding) so marginal cost per source falls — bespoke work is only the long-tail without an existing connector — `memory/decisions.md#d-100`
- Decided 2026-06-12 (Dan): two data types per record + provenance classification stamped at ingestion time — `memory/decisions.md`
- `docs/cdp-architecture.md` · `wiki/Ingestion-Channels.md` — Airflow batch + generic intake sharing one validate->normalize->resolve pipeline; new source = adapter + field map + channel config; our-side S3 DLQ
- `docs/source-onboarding-ledger.md` — names `primitive-sftp` as a 1a type primitive; Authenticom is the sftp channel rep adopting it via registry config
- `specs/03-phase-1-build/04-ingest/06-source-registry.md` — the registry-entry contract this primitive is bound by (connection/auth, ingestion mode, field mapping, provenance, DQ gate)
