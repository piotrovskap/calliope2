---
title: "DAG framework"
type: story
status: planned
priority: high
estimate: XXL
depends_on: [phase-1-build.ingest.airflow-split]
labels: [ingest, airflow, framework, 1a]
date: ~
---

A reusable framework for ingestion DAGs exposing extract/land/normalize/resolve building blocks, so a new feed is assembled from shared components rather than bespoke DAG code. Imperative Python transforms (no dbt); per-fact provenance carried through each block.

**Acceptance:** two distinct feeds are assembled purely by composing the shared extract/land/normalize/resolve blocks (config-not-code, no bespoke DAG logic), and per-fact provenance is carried unbroken through every block to the output.

**References:**
- Decided 2026-06-17 (Dan Aston): templated, convention-driven DAG ecosystem — reusable operators/hooks, DAG factories, templated per-source onboarding so each new source assembles from existing building blocks (compounding reuse drives the per-source economics) — `memory/decisions.md#d-100`
- Decided 2026-06-17 (Leo): no dbt — transform is imperative Python on the ingest path; DQ via Great Expectations/SQL — `memory/decisions.md#d-075`
- Source flow: originals → Airflow → S3 bronze → normalize → resolve → CDP Postgres; config-driven source registry with provenance tag — `memory/decisions.md`
- `wiki/Tech-Stack.md` — Airflow (self-hosted) as all-ingest batch orchestration, replacing SSIS
- `docs/deliverables/detailed-phase-1-2-plans.md` — Phase 1 ingestion build plan
