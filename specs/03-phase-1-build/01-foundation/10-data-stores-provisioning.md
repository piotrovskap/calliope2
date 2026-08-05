---
title: "Data stores provisioning"
type: story
status: planned
priority: high
estimate: M
depends_on: [phase-1-build.foundation.boilerworks-opscode-iac, phase-1-build.foundation.accounts-prod-dev-staging]
labels: [foundation, data-stores, terraform, 1a]
date: ~
---

Provision the tiered data stores via Terraform (boilerworks-opscode): managed Postgres (Azure Database for PostgreSQL / RDS) + connection pooling + read replicas (Django read/write routing), object-store bronze (Azure Blob / S3, encrypted, replayable), the analytical warehouse (store-neutral: Redshift / Fabric-Synapse, or Postgres-only) via zero-ETL/mirroring from managed Postgres, OpenSearch (person search + observability), and NATS JetStream (event backbone + event log). The application messaging queue (RabbitMQ), workflow engine (Temporal), and cache (Redis) are provisioned in their own foundation stories.

**Acceptance:** `terraform apply` stands up every tier per environment (dev baseline, prod rightsized): managed Postgres reachable through the pooler with an RLS policy enabled and a read replica serving reads; object-store bronze writable with at-rest encryption on and replay verified; the analytical warehouse receiving rows via zero-ETL/mirroring (or Postgres-native fallback); OpenSearch cluster green and queryable; NATS JetStream stream created and a publish/consume round-trip succeeds.

**References:**
- Decided 2026-06-15 (tiered data stores — never one overloaded Postgres): S3/Blob bronze, native managed Postgres + pooler + read replicas, warehouse via zero-ETL/mirroring, OpenSearch, NATS JetStream — `memory/decisions.md`
- Decided 2026-06-16 (Leo, infra sizing): dev baseline (single-AZ Postgres, no replicas) now, production rightsized on observed load — `memory/decisions.md#d-007`
- Decided 2026-06-17 (Dan, Azure-primary; bake-off): store-neutral provisioning across clouds — zero-ETL gap closed via Fabric mirroring for PG Flex — `memory/decisions.md#d-093`
- Decided 2026-06-18 (Leo, raw/staging buffer): raw lands in object-store bronze as parquet, replayable — `memory/decisions.md#d-008`
- `docs/cdp-architecture.md` · `wiki/Tech-Stack.md` — the canonical tiered store stack
- `docs/cdp-reference-topology.md` — per-environment node/storage counts and the dev-vs-prod sizing the Terraform provisions
- `docs/cloud-aws-vs-azure-bakeoff.md` — store-neutral AWS/Azure equivalents (RDS/Azure DB for PostgreSQL, S3/Blob, Redshift/Fabric-Synapse)
