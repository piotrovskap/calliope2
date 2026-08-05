---
title: "ETL modernization plan"
type: story
status: done
priority: high
estimate: L
depends_on: []
labels: [etl, ssis, decision, phase-0-architecture]
date: ~
artifacts:
  - "ETL/SSIS inventory | docs/etl-data-inventory.md"
---

**Orchestration is decided (D-6): Apache Airflow (managed — Azure Managed Airflow / MWAA — or self-hosted)** — AWS Glue was evaluated and rejected, and SSIS is not carried forward (see `memory/decisions.md#d-015`). The platform question is settled; this story records the **delivery workflow** and hands per-job migration to the build.

## Delivery workflow (decided)

1. **Non-prod MWAA + DAG CI.** Every PR spins out an isolated fork/demo deploy of the changed DAGs into non-prod managed Airflow and runs their unit tests — automatic CI/CD, no manual environment. A DAG isn't reviewable until it deploys and its tests pass in non-prod.
2. **Prod setup + promote + CD.** A separate prod managed-Airflow environment; merged DAGs promote from non-prod to prod via CD. Promotion is the only path to prod — no direct prod authoring.

This is the standard loop every ingest DAG follows; it sits on the foundation CI/CD (`cd-integration`, `push-button-prod-deploy`) and the ingest framework (`airflow-split`, `dag-framework`, `dag-base-conventions`).

## Execution

Reimplement the SSIS ingest/transform logic against the original sources as Airflow DAGs — the `phase-1-build.ssis-reimplementation` EPIC, not this story. **Target the source semantics, not the legacy job layout.** The 13 SSIS jobs are the current implementation, not the spec; reimplementation may consolidate coupled jobs, split monoliths, or drop redundant ones. The DAG count is an output of discovery — it may be fewer or more than 13. No 1:1 carry-over unless two jobs are confirmed to be genuinely distinct sources.

## Discovery (before any reimplementation)

No decomposition is committed until we have specifics.

1. **Verified job descriptions** — Rick's full set (the SSIS job descriptions ask) would have replaced AI-inferred behavior with confirmed behavior. **Closed 2026-06-18 as not-needed** (Alicia): the `etl/` inventory (`docs/etl-data-inventory.md`) and the field-source matrix are sufficient to spec reimplementation — not a blocker. Discovery proceeds from those.
2. **Source map** — per job: actual upstream source(s), outputs, stored-procedure logic. Cluster by genuine source, not by job name.
3. **Distinct-source resolution** — collapse jobs hitting the same source / producing the same fact; split jobs that fan across unrelated sources; flag the coupled-dependency chains and the `Mileone_reward_member` failure for redesign, not port.
4. **Target decomposition** — propose the DAG set, each mapped to a source primitive (db/api/sftp/...); size from the result, not from the legacy count.

**Disambiguation buffer:** until discovery lands, the job count — and therefore the effort — is unknown by design. The SSIS reimplementation stays EPIC-sized with a wide band; treat its estimate as a placeholder with built-in slack, re-sized after the target decomposition is known. Don't schedule or commit a figure off the legacy 13.

**Not blocked.** The SSIS job-descriptions ask (`phase-0-discovery.data-inventory.ssis-job-descriptions`) was closed 2026-06-18 as not-needed — `docs/etl-data-inventory.md` (231 SQL objects across 20 modules, verified against the `.sql`) plus the field-source matrix give enough source behavior to spec the reimplementation without Rick's descriptions.

**Acceptance:** the two-environment delivery workflow is operational — non-prod Airflow + DAG CI where each PR deploys the changed DAGs and runs their unit tests in non-prod (a DAG is unreviewable until it deploys green there), and a separate prod environment where merged DAGs promote via CD with no direct prod authoring; the source map and distinct-source resolution (per-job upstream sources, outputs, stored-proc logic, coupled-chain and `Mileone_reward_member` flags) are recorded and the target DAG set is proposed, each DAG mapped to a source primitive, before any reimplementation begins.

**References:**
- Decided 2026-06-15: ETL delivery workflow (two-env, PR-tested non-prod → prod CD) closes the "ETL modernization plan" architecture item — `memory/decisions.md#d-101`
- Decided (D-6): Apache Airflow for orchestration; AWS Glue evaluated and rejected; SSIS not carried forward — `memory/decisions.md`
- Decided 2026-06-17 (Dan): templated convention-driven DAG ecosystem + DAG test harness and dev/prod CI/CD, on self-hosted Airflow (agnostic-core) — `memory/decisions.md#d-101`
- Closed 2026-06-18 (Alicia): SSIS job-descriptions ask not-needed; inventory + discovery cover sourcing — `memory/decisions.md`
- `docs/etl-data-inventory.md` — 231 SQL objects across 20 modules (verified against `.sql`), the source basis for reimplementation
- `docs/cloud-aws-vs-azure-bakeoff.md` — MWAA vs self-hosted Airflow per cloud (Azure has no MWAA peer; self-host)
