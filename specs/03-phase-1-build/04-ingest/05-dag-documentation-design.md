---
title: "DAG documentation design"
type: story
status: planned
priority: medium
estimate: L
depends_on: [phase-1-build.ingest.dag-base-conventions]
labels: [ingest, docs, 1a]
date: ~
---

A documentation standard for every DAG capturing purpose, source, schedule, lineage, and downstream entities, so each feed is self-describing and its provenance is traceable. Docs surface alongside the DAG rather than living in a separate wiki.

**Acceptance:** every DAG declares purpose/source/schedule/lineage/downstream-entities from a single in-code template (config-not-code, no separate wiki), and those docs auto-surface in the Airflow UI for each DAG with no manual duplication.

**References:**
- Decided 2026-06-17 (Dan Aston, ingestion): templated, convention-driven DAG ecosystem — reusable operators/hooks, DAG factories, templated per-source onboarding over the config-driven source registry — `memory/decisions.md#d-100`
- Decided 2026-06-17 (Dan Aston, scope): maximize value across all sources/channels — document everything per source — `memory/decisions.md#d-099`
- Source onboarding 2026-06-13 (Leo): config-driven source registry — declarative per-source mapping + provenance tag — `memory/decisions.md`
- `docs/cdp-architecture.md` · `wiki/Tech-Stack.md` — Airflow orchestration of all batch ingest; declarative DAGs over the source registry
