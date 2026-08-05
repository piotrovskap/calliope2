# BUILD-START — Phase 1a kickoff handoff

The bridge from Phase 0 (discovery, complete) to writing code. Read [`bootstrap.md`](bootstrap.md)
and [`docs/cdp-architecture.md`](docs/cdp-architecture.md) first; this file says **where to start**.

Phase 0 status: **complete, awaiting DAS sign-off.** All design decisions are locked
(see `memory/decisions.md`); the remaining build artifact is code.

---

## 1. First vertical slice

Stand up the **full platform and prove it end to end with one live source per channel** —
a complete, working slice, not a demo. The thinnest path that exercises every layer:

> infra → canonical schema → ingest **one** source → deterministic identity resolution →
> return a `consumer_id` → read it back via the API → see it in the golden-record view.

When a single real record flows source → bronze → resolve → Postgres → Consumer-360 read,
the architecture is proven and the long tail is repetition.

## 2. First 10 implementation issues (dependency-ordered)

| # | Issue | Spec story | Gated by |
|---|---|---|---|
| 1 | IaC + cloud org / accounts / identity-center (branches on the cloud decision) | `phase-1-build.foundation.boilerworks-opscode-iac`, `.aws-org-iam-identity-center`, `.accounts-prod-dev-staging` | — |
| 2 | Data stores provisioning (Postgres HA, Redis, object store) | `phase-1-build.foundation.data-stores-provisioning` | 1 |
| 3 | CI/CD (auto-deploy dev, gated prod) | `phase-1-build.foundation.cd-integration`, `.push-button-prod-deploy` | 1 |
| 4 | Observability baseline (OTel → Prometheus/Grafana/Jaeger) | `phase-1-build.foundation.observability` | 2 |
| 5 | Data-model foundation — the 15-table schema DDL (11 core + 4 AI/ML stubs) | `phase-1-build.backend-data-model.data-model-foundation` | 2 |
| 6 | REST surface (Django REST) — ingest/ops/admin | `phase-1-build.backend-data-model.rest-surface` | 5 |
| 7 | GraphQL surface (Strawberry) — Consumer 360 | `phase-1-build.backend-data-model.graphql-surface` | 5 |
| 8 | Ingest framework — Airflow (ingest) / Temporal (app) split + first DAG | `phase-1-build.ingest.airflow-split`, `.source-registry` | 5 |
| 9 | First source onboard — one DB through the config-driven registry | `phase-1-build.ingest` (first long-tail source) | 8 |
| 10 | Identity resolution engine — deterministic matcher + conflict queue | `phase-1-build.identity-resolution-engine.resolution-engine-core`, `phase-1-build.identity-curation-data-quality.curation-queue` | 5, 9 |

These map 1:1 to the `phase-1-build` backlog in `specs/` (board: `/specs/`, focus Phase 1).

> **Cloud fork:** issue 1 is the one place the cloud substrate matters. The backlog names it AWS-first (`aws-org-iam-identity-center`) reflecting the AWS-leaning default, but it branches — **AWS IAM Identity Center** or **Azure Entra ID** — per DAS's cloud decision (still unrecorded; see `docs/build-readiness-traceability.md` §2). Everything from issue 2 on is cloud-neutral (portable OSS core).

## 3. Required subrepos

- **boilerworks-opscode** — Terraform IaC (accounts, networking, k8s, managed tier). Issues 1–3.
- **CDP application repo** — Django/Strawberry backend, Next.js frontend, Airflow/Temporal workers. Issues 4–10.
- **wiki** (submodule here) — canonical Data-Model / Tech-Stack / Architecture reference, kept in sync.

## 4. Dependency order (critical path)

```
IaC + accounts (1) → data stores (2) → CI/CD (3)
                         └→ data model DDL (5) → REST (6) / GraphQL (7)
                                              └→ ingest framework (8) → first source (9) → identity resolution (10)
observability (4) runs alongside from (2)
```
Foundation (1–4) is the hard prerequisite. Data model (5) unblocks the most. Identity (10) is
the proof point — it needs both the schema and one real source.

## 5. Known build-time validations

These are confirmed unknowns to resolve **as you build**, not before:

- **Schema DDL** — bitemporal (`tstzrange` + GiST exclusion) + EAV/JSONB shapes; migration tests on expand/contract.
- **Tenant RLS isolation harness** — `phase-1-build.integration-etl-reporting.tenant-guest-token-rls-harness`; prove a dealer cannot see another's rows even with app-auth bypassed.
- **CDC connector tuning** — Debezium against the live source DBs (`ETL01`, `3BHS001` cautiously, `SQL01`, RDS MySQL); replication lag and load.
- **Event Grid subscription** — config-only CloudEvents 1.0 adapter wiring (no compute on DAS's side).
- **Identity match precision** — deterministic matcher validated against the curated golden-record decisions (`analysis/artifacts/golden-record/`); the conflict queue absorbs ambiguity.
- **Secrets/KMS** — per-cloud (Key Vault / KMS) behind the swap-point interface.

## 6. Sprint-1 assumptions to validate

- The split-estate ingest path (AWS-resident sources → CDP) holds its modeled egress (~$90/mo) — confirm on first real CDC stream.
- The 15-table set is sufficient for the first source with zero migrations (the all-from-day-1 bet).
- AI-assisted delivery throughput approaches the modeled rate (the basis for the ~4-month 1a target) — measure against issues 1–10 actuals.

---

*Traceability: every critical story's acceptance criterion is linked to its locked decision in [`docs/build-readiness-traceability.md`](docs/build-readiness-traceability.md), with a per-domain build-readiness checklist and the sprint-1 assumptions to validate. The first sprint is batched and ready to open in [`specs/sprint-1-issue-batch.md`](specs/sprint-1-issue-batch.md) (open via `scripts/open-sprint-1-issues.sh`); batching the later sprints is the remaining `specs/` refinement.*
