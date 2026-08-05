# Sprint 1 — Issue Batch (Foundation slice)

The first sprint's work, **ready to open as GitHub issues**. Each entry below is a complete issue
(title, labels, acceptance criteria, dependencies, and the locked decision it traces to). This is
the dependency-ordered first batch from [`BUILD-START.md`](../BUILD-START.md) §2 — the foundation
that unblocks everything else.

**To open them:** run `scripts/open-sprint-1-issues.sh` (parses this file → `gh issue create`).
Review here first; opening is one command, not auto-run.

Format per issue: `### N. Title` · `**Labels:**` · `**Depends on:**` · body. The parser reads
exactly that shape.

---

### 1. Foundation: IaC + cloud org / accounts / identity-center
**Labels:** phase-1, sprint-1, foundation
**Depends on:** —

Stand up the cloud org, the prod/dev/staging accounts, and centralized identity via Terraform IaC.

**Cloud fork:** this issue branches on DAS's cloud decision — **AWS IAM Identity Center** or **Azure Entra ID**. The backlog names it AWS-first (`aws-org-iam-identity-center`); swap to the Azure equivalent if DAS chooses Azure. Everything after this is cloud-neutral.

Acceptance:
- Terraform in `boilerworks-opscode` provisions the org + prod/dev/staging accounts.
- Centralized SSO/identity-center wired; tiered permissions defined.
- `terraform plan` is clean and reproducible from the repo.

Spec: `phase-1-build.foundation.boilerworks-opscode-iac`, `.accounts-prod-dev-staging`, `.aws-org-iam-identity-center`, `.tiered-permissions`. Traced: rightsize-on-load 2026-06-16; portable core / Azure-primary preferred 2026-06-17 · `docs/cdp-reference-topology.md`, `docs/build-readiness-traceability.md`.

### 2. Foundation: data stores provisioning (Postgres HA, Redis, object store)
**Labels:** phase-1, sprint-1, foundation
**Depends on:** #1

Provision the managed tier the whole stack leans on.

Acceptance:
- PostgreSQL (≥15.4) with HA + a read replica + connection pooler.
- Redis (HA primary + replica) and an encrypted object store (bronze + backups) provisioned via IaC.
- Reachable from the (empty) node group; secrets in Key Vault / KMS behind the swap-point interface.

Spec: `phase-1-build.foundation.data-stores-provisioning`. Traced: managed-tier split · `docs/cdp-architecture.md` (Layer 3), `docs/cdp-reference-topology.md`.

### 3. Foundation: CI/CD (auto-deploy dev, gated prod)
**Labels:** phase-1, sprint-1, foundation
**Depends on:** #1

Continuous delivery to dev, push-button gated promotion to prod.

Acceptance:
- Merge to main auto-deploys to dev; prod promotion is the same artifact behind an explicit human gate.
- Build/test/deploy pipeline green end to end on a hello-world service.

Spec: `phase-1-build.foundation.ci-pipeline`, `.cd-integration`, `.push-button-prod-deploy`. Traced: rightsize-on-load posture 2026-06-16 · `docs/cdp-reference-topology.md`.

### 4. Foundation: observability baseline (OTel → Prometheus/Grafana/Jaeger)
**Labels:** phase-1, sprint-1, foundation
**Depends on:** #2

Portable, self-hosted observability from day one.

Acceptance:
- OTel collector ships metrics to Prometheus/Grafana, logs to OpenSearch, traces to Jaeger.
- A dashboard and one alert exist; traces visible end to end on a sample request.

Spec: `phase-1-build.foundation.observability`. Traced: hosted Jaeger / portable observability · `docs/cdp-architecture.md` (Observability).

### 5. Data model: 15-table schema DDL (11 core + 4 AI/ML stubs)
**Labels:** phase-1, sprint-1, backend-data-model
**Depends on:** #2

The canonical schema, the highest-unblock item.

Acceptance:
- 15 tables deploy (11 core + 4 AI/ML stubs, empty-but-complete) — **zero migrations needed for Phase 2 ML**.
- Bitemporal provenance: `valid_from/valid_to` + `recorded_at/superseded_at` as `tstzrange` with a GiST exclusion constraint; EAV+JSONB for catalog fields.
- Expand/contract migration test passes (zero-downtime invariant).

Spec: `phase-1-build.backend-data-model.data-model-foundation`. Traced: 15-table locked 2026-06-18 (Alicia + Luis); bitemporal `memory/decisions.md#d-082` · `docs/deliverables/cdp-scoping-document.md`, `wiki/Data-Model.md`.

### 6. Backend: REST surface (Django REST) — ingest / ops / admin
**Labels:** phase-1, sprint-1, backend-data-model
**Depends on:** #5

Acceptance:
- Django REST serves ingest/ops/admin CRUD over the canonical schema, tenant-scoped by RLS.
- One source-ingest endpoint accepts a record and returns a `consumer_id`.

Spec: `phase-1-build.backend-data-model.rest-surface`. Traced: dual-surface reconfirmed 2026-06-18; Python-primary `memory/decisions.md#d-088` · `docs/cdp-architecture.md`.

### 7. Backend: GraphQL surface (Strawberry) — Consumer 360
**Labels:** phase-1, sprint-1, backend-data-model
**Depends on:** #5

Acceptance:
- Strawberry GraphQL serves a Consumer-360 read for a `consumer_id`, tenant-scoped.
- Returns the golden-record view (as-of query) for that consumer.

Spec: `phase-1-build.backend-data-model.graphql-surface`. Traced: dual-surface reconfirmed 2026-06-18; bitemporal as-of `memory/decisions.md#d-082` · `docs/cdp-architecture.md`.

### 8. Ingest: Airflow/Temporal split + first source registry entry
**Labels:** phase-1, sprint-1, ingest
**Depends on:** #5

Acceptance:
- Airflow owns all ingest, Temporal owns the app layer — CI-guarded, no overlap.
- A config-driven source-registry entry lands one source raw-first to encrypted bronze before normalize.

Spec: `phase-1-build.ingest.airflow-split`, `.source-registry`. Traced: Airflow=ingest `memory/decisions.md#d-072`; raw-first `memory/decisions.md#d-098`; NATS `memory/decisions.md#d-070` · `docs/deliverables/target-state-data-flow.md`.

### 9. Ingest: first real source onboard (one DB end to end)
**Labels:** phase-1, sprint-1, ingest
**Depends on:** #8

Acceptance:
- One DAS source DB (originals, **not** EDW/DWRPT) flows source → bronze → normalize → validate.
- Debezium CDC streams inserts/updates/deletes; ingest is replayable from bronze.

Spec: `phase-1-build.ingest.cdc-capture-debezium` + first long-tail source. Traced: originals-only (SSIS deep-dive 2026-06-08) · `docs/cdp-architecture.md`.

### 10. Identity: deterministic resolution engine + conflict queue
**Labels:** phase-1, sprint-1, identity-resolution-engine
**Depends on:** #5, #9

The proof point — close the vertical slice.

Acceptance:
- Deterministic Tier-1 match (email/phone/VIN/dealer-ID normalization) → link/create → human conflict queue for ambiguous matches.
- Field-level provenance recorded; survivorship picks the golden value (DMS = ground truth).
- A real record from issue 9 resolves to a `consumer_id` and is readable via issue 7's GraphQL.

Spec: `phase-1-build.identity-resolution-engine.resolution-engine-core`, `phase-1-build.identity-curation-data-quality.curation-queue`, `phase-1-build.identity-resolution-engine.survivorship-golden-value`. Traced: Option A locked `memory/decisions.md#d-104`; survivorship `memory/decisions.md#d-107` · `docs/deliverables/identity-resolution-strategy.md`.

---

*When issues 1–10 are green, the first vertical slice is proven (source → bronze → resolve → Postgres → Consumer-360 read). The long tail is then repetition. Validate the 5 sprint-1 assumptions in `docs/build-readiness-traceability.md` §3 as you go.*
