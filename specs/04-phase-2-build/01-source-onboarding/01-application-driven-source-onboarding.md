---
title: "Application-driven source onboarding"
type: story
status: planned
priority: medium
estimate: XXL
labels: [source-onboarding, activation, phase-2, net-new, 2a]
date: ~
---

Onboard additional CDP sources as Phase 2 applications and activation workflows require them. Acceptance criteria should be tied to concrete downstream uses: audience activation, dashboards, utility workflows, source status, or product surfaces. The Phase 1 ingestion framework remains the platform foundation.

**Acceptance:** each newly onboarded source is registered in the config-driven source registry (declarative mapping + provenance tag), lands via a DAG assembled from the templated factory/shared operators (no bespoke pipeline), passes the DAG test harness (import/integrity + task-level tests + DQ assertions) in non-prod before promotion, and is observably consumed by at least one named downstream surface (activation audience, dashboard, utility workflow, or source-status view) with provenance traceable to that source.

**References:**
- Decided 2026-06-13 (Leo, Phase 0 architecture recommendation): config-driven source registry — declarative per-source mapping + provenance tag — `memory/decisions.md#d-076`
- Decided 2026-06-17 (Dan Aston, Ingestion & scope): templated, convention-driven DAG ecosystem — reusable operators/hooks + DAG factories + templated per-source onboarding over the registry; DAG test harness + dev/prod CI/CD — `memory/decisions.md#d-100`
- `docs/cdp-architecture.md` · `wiki/Tech-Stack.md` — the Phase 1 ingestion framework (Airflow DAGs, Python operators) that this onboarding extends
