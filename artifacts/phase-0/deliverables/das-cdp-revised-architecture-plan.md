# DAS CDP — Revised Architecture Plan

> **ARCHIVED — superseded by [`docs/cdp-architecture.md`](../../../docs/cdp-architecture.md).** This is the Phase 0 (2026-06-13) architecture recommendation, kept as a historical record. Its substance has been harmonized into the canonical architecture doc, and the **v3-delta reconciliation has been migrated to the live deliverable `docs/deliverables/das-plan-comparison.md`** (the canonical comparison). No longer maintained — for current architecture, see the canonical doc.

**Status:** Draft (Phase 0 recommendation) — 2026-06-13
**Supersedes:** DAS CDP Architecture Plan v3 (DAS-authored)
**Purpose:** Rewrite DAS's Architecture v3 against what Phase 0 actually surfaced — real data sources, the identity landscape, and the infrastructure inventory — not assumptions. Structured around the four views from the Phase 0 deliverable outline.
**Working decision log:** `memory/decisions.md` (2026-06-13). Stack detail: `wiki/Tech-Stack.md`.
**Locked elsewhere / not in this doc:** the identity-resolution strategy (Option A, locked 2026-06-17) and the 15-table data model (set locked 2026-06-18: 11 core + 4 AI/ML stubs; the schema DDL itself is the remaining build artifact) — owned by Alicia Salazar + Luis Hernandez. See the *Identity Resolution Strategy* and *CDP Scoping* deliverables.

> **Cloud substrate (updated 2026-06-17): portable OSS core, Azure-primary preferred.** The architecture is a **portable OSS core** — Airflow, NATS, Temporal, OpenSearch, Postgres, Auth0, OTel — that runs on either cloud unchanged; only the substrate and a few proprietary swap-points differ. Per Dan Aston (2026-06-17), DAS prefers consolidating on **Azure-primary** unless a cost/technical blocker emerges; AWS is the alternative (data gravity currently sits on AWS source DBs). The final call is the **AWS-vs-Azure bake-off** (`docs/cloud-aws-vs-azure-bakeoff.md`) — the stack mapped onto both clouds, per-cloud gaps, and per-cloud cost at a reference scale. Service names below are written cloud-neutral with both-cloud equivalents (e.g. AKS/EKS, Azure Database for PostgreSQL / RDS Postgres, Blob / S3); where a single product is named it is illustrative, not a lock.

---

## 0. Current-State Findings (what Phase 0 surfaced)

- **ETL is fragile and near capacity.** SSIS — 13 jobs, truncate-and-rebuild, daily — on ETL01. Flagged for replacement; DAS confirmed jobs will be dropped, not relied on.
- **Source systems.** SQL Server on EC2 (ETL01, 3BHS001, SQL01) + RDS MySQL (Analytics, Analytics-Mautic). 3BHS001 is legacy and modified cautiously (dependencies not fully mapped).
- **EDW + DWRPT.** SSIS lands raw output to `EDW_Staging`/`EDW_Target`; `DWRPT` pre-joined views power all reporting (Juicebox, 221 reports — not long-term).
- **No cross-system identity resolution today.** CVH hash (DealerID+Email) is per-dealer and structurally blocks cross-dealer linkage; Common Client ID is recent and has data-cleanliness issues. DAS's own words: "we don't" resolve identity across systems.
- **Dual cloud.** Data gravity is AWS (source DBs). App/event layer is Azure (Event Grid, AKS, Functions) + SaaS Auth0/Kong. Apps publishing events: Acceptor (leads → Event Grid), plus Inventory, Comms, Survey, Reputation.
- **End-state goal (exec-confirmed).** The CDP becomes the source of truth for lifecycle events; apps and agentic features build on it; SSIS/EDW retire once the CDP is reliable.

This plan replaces the SSIS-centric flow with a CDP that ingests from **original sources** (not EDW) and **becomes** the system of record.

---

## 1. Target-State Data Flow

End-to-end movement of consumer and vehicle data through the CDP:

```
Original sources                     ┌─ Batch pull  → Airflow (managed/self-hosted) / CDC
  app DBs (EC2 SQL Server, RDS MySQL)─┤  Event       → NATS JetStream  ← Event Grid adapter (Option A)
  SFTP / CSV drops                    ┤  Webhook     → Django REST
  vendor APIs (Twilio, Meta, Google)  └─ Bulk upload → admin UI
                                                │
                                                ▼
                                     Object-store raw landing (Blob / S3, bronze, encrypted, replayable)
                                                │  normalize → validate
                                                ▼
                                     Identity resolution (Tier 1 deterministic + conflict queue)
                                                │  resolved consumer_id
                                                ▼
                                     CDP Postgres (canonical, RLS, bitemporal provenance)
                                                │
                        ┌───────────────────────┼────────────────────────────┐
                        ▼                       ▼                            ▼
            REST + GraphQL (Consumer 360)   Postgres-based analytics      index → OpenSearch
            VSS + downstream apps           (portable; reporting)         (search + query log)
```

- **Four channels, one pipeline:** every channel lands raw to S3, then runs the same normalize → resolve → store path. New sources plug in as adapters without touching the resolution engine.
- **Raw-first capture** preserves untrusted source data at the point of consumption (DAS's explicit requirement) and makes the pipeline replayable.
- **Bitemporal provenance** (valid-time + system-time, append-only) records which source fed each field and when — powering the golden-record evolution view ("as-of" time travel).
- **Replaces** SSIS truncate-and-rebuild and removes the EDW/DWRPT dependency for ingestion (DWRPT remains a reporting-parity reference only).

---

## 2. Services Topology

| Service | Responsibility | Tech |
|---|---|---|
| Ingestion | Batch DAGs, source CDC, webhook + bulk endpoints, raw landing | Airflow (managed or self-hosted), CDC (Debezium / cloud-native), Django REST |
| Event intake | Bus-agnostic event capture; Event Grid adapter (Option A) | NATS JetStream + adapter |
| Identity resolution | Normalize → deterministic match → link/create → conflict queue | Python service; Temporal for merge/unmerge sagas + human-in-loop |
| Profile API | Consumer 360 reads; operational/ingestion writes | Strawberry GraphQL + Django REST |
| Admin / ops | Dealer portal, conflict-review UI, source-onboarding console | Next.js + Django |
| Workflow / workers | Queue workers, admin-utility orchestration | Temporal |
| Analytics / search | Reporting; fuzzy person search | Postgres-based analytics (Citus/columnar, portable) or cloud warehouse; OpenSearch |

**Contracts & boundaries:**
- Event intake is **bus-agnostic**; external buses are adapters in (Event Grid first). Internal backbone is NATS.
- Source ingestion is **config-driven** (declarative per-source mapping + provenance classification: DAS-global/shareable vs dealer-isolated).
- The **resolver runs in a privileged role above tenant RLS** (cross-dealer identity); all serving stays tenant-scoped.
- Airflow owns **all ingest**; Temporal owns **application/admin** workflows — no overlap.

---

## 3. Deployment Architecture

Written cloud-neutral; the **Azure-primary** product is named first, the **AWS** equivalent in parentheses (the bake-off finalizes the substrate).

- **Compute:** Kubernetes (**AKS**; EKS) — self-host NATS (JetStream), Temporal, Django, Next.js, workers. Airflow for ingest DAGs (self-hosted on k8s, or managed: Azure-managed Airflow / MWAA).
- **Data stores:** object storage (**Azure Blob**; S3) for raw bronze, encrypted · PostgreSQL (**Azure Database for PostgreSQL**; RDS Postgres, PG ≥ 15.4) + connection pooling + read replicas (Django read/write routing) · Postgres-based analytics (Citus/columnar, portable) or a cloud warehouse · OpenSearch.
- **Ingress & auth:** cloud LB / ingress (**Azure Application Gateway**; AWS ALB); Auth0 (EntraID federation, 4-role group-based); API-key/HMAC for machine ingestion.
- **CDC:** source capture via Debezium or cloud-native CDC (**Azure DMS**; AWS DMS) into raw landing. Internal change feed is the bitemporal observation table itself.
- **Cross-cutting:** secrets + keys (**Azure Key Vault**; AWS Secrets Manager + KMS) for at-rest encryption; erasure via tokenized PII-vault delete, not per-consumer crypto-shred. Managed backup/PITR + object-store raw replay for DR; OTel + Prometheus/Grafana, cloud-native infra logs.
- **IaC:** Terraform (cloud-neutral) via `boilerworks-opscode`; app on `boilerworks-django-nextjs`.
- **Networking:** private VNet/subnets for the data tier; public ingress via the cloud LB; CDC connectivity to source SQL Server; inbound Event Grid subscription delivery to the CDP webhook.

**Operational invariants (productionized V1):** idempotent ingest (dedup keys on event+webhook); Django expand/contract zero-downtime migrations; auth first-line on every endpoint; group-based permissions; soft deletes only; UUID PKs in APIs; real Postgres in tests.

---

## 4. Alignment with DAS's Cloud Footprint

**Honest mapping of target → DAS's actual environment:**

| | Detail |
|---|---|
| **Reused** | Auth0 (DAS-approved, SaaS — federates EntraID); DAS's existing cloud presence and source DBs |
| **Net-new** | Kubernetes cluster (AKS primary; EKS on AWS), NATS, Temporal, PostgreSQL, Postgres-based analytics, OpenSearch, Airflow |
| **Event source** | DAS's app events originate in Azure Event Grid. The CDP subscribes via a **config-only Event Grid subscription → CDP webhook** (Option A). Azure-primary **co-locates** the CDP with this event layer; on AWS it is a cross-cloud subscription (still bus-agnostic, no coupling). |
| **Portability** | The portable OSS core (Postgres, NATS, Temporal, k8s, OpenSearch, Auth0, OTel) runs on either cloud. Proprietary swap-points each have an Azure and an AWS equivalent: managed Airflow, the analytics warehouse, CDC, managed backup, secrets/KMS, object storage, LB. No vendor lock-in in app code. |

**Cloud choice:** DAS prefers **Azure-primary** (Dan, 2026-06-17) to consolidate on its org-primary cloud; AWS is the alternative given data gravity (source DBs on EC2/RDS). The **AWS-vs-Azure bake-off** settles it on per-cloud cost + gaps. Either way the portable core and the bus-agnostic intake are unchanged.

**Honest constraints:**
- Legacy 3BHS001 must be modified cautiously — extract via read replica / low-impact windows.
- **Sizing: dev baseline now, production rightsizing deferred.** DAS volume/profile data isn't expected and isn't a blocker — the stack is elastic (Postgres scale-up + pooling/read-replicas, serverless/elastic analytics, k8s autoscaling, object storage). Phase 1 provisions a **dev baseline** (single-AZ Postgres, no read replicas, minimal analytics tier, a small node group); production is **rightsized once real load is observed** — a config change, not a redesign. The system surfaces its own profile in flight.
- Event Grid delivery details (catalog, subscription ownership, CloudEvents, auth) are Phase-1 build-time; the architecture stands regardless of DAS's answer.

---

## 5. v3 Delta — What Changed and Why

> **Migrated.** The v3-delta reconciliation (the durable per-row analysis of what changed from DAS's v3 and why) now lives in the live deliverable [`docs/deliverables/das-plan-comparison.md`](../../../docs/deliverables/das-plan-comparison.md), which is the canonical home for the DAS-plan-vs-CONFLICT-plan comparison. This archived doc is kept only as the historical Phase 0 (2026-06-13) recommendation.

## 6. Dependencies & Open Items

- **Locked / in build (Alicia + Luis):** the **15-table set is locked 2026-06-18** (11 core + 4 AI/ML stubs; EAV+JSONB + bitemporal provenance shape) — the remaining build-time artifact is the schema DDL itself, not a design decision. The **identity strategy (Option A) and survivorship/source-trust are locked (2026-06-17)**; **field-catalog v1 is locked (2026-06-19, 14 valuable-now / 13 later)**. Residual design detail (consent policy values, household lifecycle) lands in the *Identity Resolution Strategy* and *CDP Scoping* deliverables.
- **DAS inputs:** prior tracked asks are **resolved** — Event Grid catalog (answered by the canonical-schema + transform stance), API-usage walkthrough (done 2026-06-18), Common Client ID assignment logic and the 8 SSIS job descriptions (both closed 2026-06-18 — the CDP builds its own CCID and ingests originals, so neither is on the critical path). Data-profile/volume input closed — not gating (dev baseline + deferred prod rightsizing, see above).
- **Confirmed direction:** REST + GraphQL dual surface; portable OSS core, Azure-primary preferred (bake-off finalizes substrate); native PostgreSQL; NATS; Airflow=all-ingest / Temporal=app-layer; originals-not-EDW; SSIS ingest rewrite; bitemporal provenance; tokenized PII-vault erasure.
