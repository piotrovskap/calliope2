---
title: "Config-driven source registry"
type: story
status: planned
priority: high
estimate: XL
depends_on: [phase-1-build.ingest.dag-base-conventions, phase-1-build.backend-data-model.consent-store, phase-1-build.backend-data-model.ai-context-schema-conventions]
labels: [ingest, registry, config, 1a]
date: ~
---

A declarative registry holding one entry per original source (app DBs, SFTP/CSV, vendor APIs, event publishers), driving DAG generation and adapter config off the framework. Sources are described as **data, not code**, so onboarding is additive and uniform — and the *same* registry declares batch and event sources, so a source graduates batch -> event without redesign (objective 8).

**Registry-entry contract.** A single declarative entry fully specifies a source; nothing about a source lives in bespoke code. Each entry declares:

- **Source identity & type** — stable source id, kind (app-db / sftp-csv / vendor-api / event-publisher), owning DAS product where known.
- **Connection & auth** — a reference to credentials/endpoint (secret ref, not inline), with environment scoping.
- **Ingestion mode** — `batch`, `event`, or `both`. One registry, two intakes: batch drives Airflow DAG generation; event binds the generic adapter (Event Grid / NATS / CloudEvents). A source can carry both and migrate batch->event by changing this field, not its mapping.
- **Cadence / subscription** — schedule for batch; topic/subscription + CloudEvents `type` for event.
- **Field mapping** — per-field map from source schema to the canonical model, each mapped field carrying its **semantic metadata + glossary term** (per `ai-context-schema-conventions` / the term registry) so onboarding a source populates the context layer.
- **Identity keys** — which fields are identifiers and of what kind (email / phone / VIN / CommonClientID / address / orphan-identifier). This is the registry's direct contract with the resolution engine — declared per source, not inferred.
- **Provenance classification** — DAS-global/shareable vs dealer-isolated per source (the two-data-types decision), plus the provenance tag stamped at ingest.
- **Consent / suppression linkage** — which consent/channel applies and the record-level suppression key, so a per-channel withdrawal removes exactly this source's records (per `consent-store`).
- **Data-quality contract** — the validation/expectations the source's records must pass at ingest (the DQ gate), declared with the source.
- **Lifecycle / retention** — tiering/retention class for the source (ties to tiered-data-lifecycle), config-driven.

**Storage & governance.** In Phase 1 the registry is **config-as-data** — git-versioned declarative entries, validated against the entry contract in CI (a malformed or under-specified entry fails the build) and versioned as a data contract. Phase 2 promotes it to an application/admin-managed surface (`phase-2-build.source-onboarding`) without changing the entry shape.

**Acceptance:** adding an original source is a single declarative registry entry conforming to the contract above (type, connection, ingestion mode, field mapping + semantic metadata, identity keys, provenance classification, consent linkage, DQ contract, retention) — and that entry alone drives DAG generation (batch) or adapter binding (event) with **zero bespoke code**; a CI check rejects an entry missing any required field; a source declared `both` migrates batch->event by flipping the mode field; a newly onboarded source runs end-to-end through the stepped flow and lands records with correct provenance, identity keys, and consent linkage.

**References:**
- Decided 2026-06-13 (Leo, Phase 0 arch recommendation): source onboarding = config-driven source registry (declarative per-source mapping + provenance tag) — `memory/decisions.md#d-076`
- Decided 2026-06-17 (Dan Aston): templated, convention-driven DAG ecosystem (operators/hooks, DAG factories, templated per-source onboarding) over the config-driven registry — `memory/decisions.md#d-100`
- Decided 2026-06-12 (Dan Aston): event intake co-primary with batch; one shared pipeline, sources graduate batch->event without redesign (objective 8) — `memory/decisions.md#d-045`
- Decided 2026-06-12 (Dan): two data types per record (DAS-global/shareable vs dealer-isolated) + provenance classification required at ingestion time — `memory/decisions.md`
- Decided 2026-06-17 (Dan): per-channel consent granularity requires per-source / per-source-record consent linkage so single-channel withdrawal removes exactly that source's records — `memory/decisions.md#d-095`
- `docs/cdp-architecture.md` · `wiki/Ingestion-Channels.md` — generic bus-agnostic intake + Airflow batch sharing one validate->normalize->resolve pipeline; new source = adapter + field map + channel config
- `docs/source-onboarding-ledger.md` — authoritative per-source onboard list (type primitives + per-source entries) generated against this registry's entry shape
- `specs/03-phase-1-build/03-backend-data-model/07-consent-store.md` · `specs/03-phase-1-build/03-backend-data-model/12-ai-context-schema-conventions.md` — the consent-linkage and semantic-metadata contracts the entry references
