---
title: "Source CDC capture (Debezium)"
type: story
status: planned
priority: high
estimate: XL
depends_on: [phase-1-build.ingest.nats-event-backbone, phase-1-build.ingest.source-registry]
labels: [ingest, cdc, debezium, 1a]
date: ~
---

Stand up change-data-capture from source databases via Debezium (preferred, portable OSS; cloud-native DMS is the managed alternative). CDC streams inserts/updates/deletes from the DAS source DBs (SQL Server on EC2, RDS MySQL) into the raw bronze landing + the NATS event backbone, so the CDP captures source changes continuously rather than only on batch pull. Debezium runs as a singleton connector per the reference topology; connector config is driven from the source registry (`kind: app-db`). The internal change feed downstream is the bitemporal observation log itself.

**Acceptance:** a change committed in a registered source database (SQL Server / MySQL) is captured by Debezium and lands in bronze + on NATS within target lag, with source/table/operation/timestamp provenance attached; connector config is declared in the source registry, not hand-rolled per source; and the capture is replayable from bronze. Batch pull (Airflow) and CDC coexist for a source without double-counting (idempotent dedup keys).

**References:**
- Decided 2026-06-17 (Dan Aston confirm / Conflict refine): CDC via Debezium (OSS, portable), not a managed DMS — `memory/decisions.md#d-091`
- Decided 2026-06-17 (Leo): AWS-vs-Azure bake-off treats DMS as the cloud-native managed alternative to Debezium — `memory/decisions.md#d-093` · `docs/cloud-aws-vs-azure-bakeoff.md`
- Locked 2026-06-18 (Alicia + Luis): bitemporal append-only observation log is the internal change feed (every change a recorded row) — `memory/decisions.md#d-074`
- `docs/cdp-reference-topology.md` — Debezium as a singleton Kafka Connect connector feeding NATS JetStream + object bronze
- `docs/cdp-architecture.md` — raw-first replayable bronze landing; Debezium CDC (or cloud-native DMS) into raw landing
