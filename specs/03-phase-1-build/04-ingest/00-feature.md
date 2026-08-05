---
title: "Ingest (Batch + Event)"
type: feature
status: planned
priority: high
depends_on: [phase-1-build.foundation.cd-integration, phase-1-build.backend-data-model.data-model-foundation]
labels: [track-3, ingest, airflow, phase-1]
date: ~
---

The ingestion stack on Apache Airflow (managed: Azure Managed Airflow / MWAA, or self-hosted), split from the app layer — Temporal stays off the ingest path. Provides a reusable DAG framework, base classes, and conventions; standard stepped flows (extract -> S3 bronze -> normalize -> resolve -> CDP Postgres); a DAG documentation design; and a config-driven source registry (declarative per-source mapping + provenance tag) that drives initial feeds. Flow ingests original sources only (app DBs, SFTP/CSV, vendor APIs) into replayable **object-store bronze (parquet, Blob / S3, encrypted)** — locked 2026-06-18; analytical processing runs over this layer via Glue (AWS) / Synapse (Azure) — then normalizes and resolves into CDP Postgres; CDC at source (Debezium / cloud-native). Co-primary with batch is the real-time **event-intake** path (Event Grid webhook -> NATS JetStream + object-store bronze, CloudEvents contract) sharing the same normalize -> resolve pipeline, so sources graduate batch -> event without redesign. Continues into the Long Tail until all core entities and sources are processed.

**Milestone.** Framework + conventions + first feeds flowing end-to-end (extract -> S3 bronze -> normalize -> resolve -> CDP Postgres).
