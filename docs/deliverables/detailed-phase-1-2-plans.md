---
title: Detailed Phase 1 & Phase 2 Plans
type: deliverable
status: complete
phase: 0
updated: 2026-06-23
---

# Detailed Phase 1 & Phase 2 Plans

_Phase 0 deliverable. Build themes, sizing, and sequencing are derived from the project backlog (`specs/manifest.json`, the single source of truth for scope/sizing). The phase model and infrastructure cost model below are planning overlays on that backlog; they group and cost the work, they do not move stories between phases. Edit the backlog, not this prose, to keep scope in sync._

## Purpose

Stage-by-stage scope, sequencing, dependencies, sizing, and infrastructure run-cost for Phase 1 (Build: productionized V1) and Phase 2 (Applications & Activation), detailed enough to support a fixed-scope SOW. Effort is expressed as relative T-shirt sizing (S < M < L < XL < XXL < XXXL < EPIC); converting that sizing into a committed build timeline and labor cost is the SOW step. The infrastructure run-cost model (AWS vs Azure) is summarized below; only the build schedule is deferred to the SOW.

## Phase model

Sub-phased so value lands early and downstream phases can overlap rather than wait on a full predecessor.

| Phase | Focus | Gated by | Can overlap |
|---|---|---|---|
| **1a — Platform** | Platform ready and tested with one source ingest per channel (the 5 intake primitives). Foundation, backend + data model, frontend/read surfaces + search, identity resolution + curation, segmentation, ingest framework, reporting baseline. | Architecture & design close | — |
| **1b — Long-tail migration** | Onboard all remaining sources per channel; SSIS reimplementation; report migration (Juicebox/DWRPT -> Superset/warehouse); legacy deprecation. | 1a platform + ingest framework | Phase 2 (once critical data mass exists) |
| **2 — Enhancements** | Capabilities that deepen the CDP for operators (activation/delivery, reporting parity build-out, data exposure/syndication). | Critical data mass (need not wait for full 1b) | 1b, Phase 2-applicatives |
| **2 — Applicatives** | Applications on the CDP: VSS retool (flagship), maintenance/service, marketing activation, mobile, data-enrichment, each consuming the golden record / events / consent. | Critical data mass + the enhancements they rely on | 1b |
| **3a — External AI** | Integrate external/hosted AI against the CDP (reuse DAS's `ai.das-technology.com` layer; LLM-assisted curation, agentic surfaces). | CDP serving + governed access API | Phase 2 |
| **3b — Own ML** | Stand up DAS's own ML: pairwise classifier and GNN/embeddings for identity (Tier 2/3), trained on the labeled decisions Phase 1 generates. | Labeled merge/curation history from Phase 1; AI/ML schema stubs (shipped empty in Phase 1) | — |

**Phase 1a timeline (derived, not asserted).** The 1a scope's total relative effort, divided by the modeled team capacity (available engineer-time, adjusted for AI-assisted delivery), yields a planning target of **approximately 4 months**. This is computed from the sizing in the live plan rather than fixed by assertion: it recomputes as scope and team are confirmed, and the committed schedule is set in the SOW. 1b runs after and overlapping 1a. Phase 2 deliberately starts before 1b completes, once enough sources are live to make the golden record valuable ("critical data mass"), so applications are not blocked on onboarding the entire long tail. Phase 3 follows in two steps: integrate external AI first (3a), then build proprietary ML (3b) once there is training data and a reason to own it.

## Phase 1a — Platform + one source per channel

The platform substrate plus a working end-to-end slice on one source per ingest channel, tested. Workstreams (full sizing in the workstream detail below): Foundation & Platform, Backend & Data Model, Frontend (incl. read surfaces + search), Identity Resolution Engine, Identity Curation & Data Quality, Segmentation Engine, Ingest framework (Airflow/DAGs/NATS/CloudEvents plus the **5 source primitives**: DB / API / SFTP / event / feed, one each), and the Integration/ETL/Reporting baseline (Superset + per-tenant RLS harness). MVP is a thin slice inside 1a (Foundation + core backend + first feeds + a first resolution path + read surfaces).

## Phase 1b — Long-tail migration

The all-channel migration, sequenced last and heaviest: full source onboarding (the 16 remaining sources), SSIS reimplementation (EPIC), report migration (EPIC), and legacy-system deprecation. Phase 2 can begin once a critical subset of these is live.

## Sizing & conversion (points ↔ engineering-days)

Every activity is sized with a relative T-shirt size, which maps to **both** a dimensionless **story-point** value (complexity on a 2× scale) **and** an **engineering-day** band (one engineer, one day). Both numbers are provided so the plan reads as relative complexity and as time. The mapping is the single source of truth in `specs/estimate-bands.json`; per-activity and per-category totals are derived (via `scripts/gen-estimates.py`), never hand-entered.

| Size | Points | Engineering-days |
|---|--:|--:|
| S | 1 | 0.5 – 1 |
| M | 2 | 1 – 2 |
| L | 4 | 2 – 4 |
| XL | 8 | 4 – 8 |
| XXL | 16 | 8 – 15 |
| XXXL | 32 | 15 – 25 |
| EPIC | 64 | 25 – 50 |

**Per-category totals (points + engineering-days) are computed live** on the estimates view (`specs/estimates.html`, from `specs/estimates.json`) and the specs roadmap, not stored here, so they never drift. As a current reference, Phase 1 build totals ≈ 913 points / 456.5–894 engineering-days; the live view breaks this down per workstream and per role.

## Phase 1 — Build workstreams (sizing)

Nine workstreams; "after" means upstream dependency (drives sequencing). Sizes are the per-workstream story-size distribution.

1. **Foundation & Platform** — _no upstream deps._ L×2, XL×5, XXL×4, XXXL×1. Repos; opscode IaC; cloud org + identity (Azure / AWS); prod/dev/staging accounts; tiered permissions; CI; auto-CD; modeled push-button prod deploy; base org auth + local dev; data-stores provisioning; observability (OTel/Prometheus/Grafana/Jaeger/OpenSearch); DR & backups.
2. **Backend & Data Model** — _after: CDP data-model design._ L×1, XL×5, XXL×3, XXXL×1. Data-model foundation; permissions; org/tenancy data; GraphQL + REST surfaces; person search; consent store; PII vault erasure; opt-out suppression; erasure & consent audit; tiered lifecycle; policy-config layer; AI-context/embedding/glossary/tool-access/outcome-label hooks (schema-complete, stubbed).
3. **Frontend** — _after: base org auth._ L×1, XL×5, XXL×2. App shell; Auth0; frontend RBAC; web-UI admin CRUD; access/user-management UI; read surfaces (Golden Record / Identity Map / Source Status / Data Health); role-based app exposure; search UI.
4. **Ingest (Batch + Event)** — _after: CD integration, data-model foundation._ L×2, XL×4, XXL×5. Airflow split; DAG framework/base/conventions; stepped flows; DAG-doc design; source registry; initial feeds; Event Grid webhook adapter; NATS backbone + raw replay; CloudEvents contract + DLQ; event-feed liveness.
5. **Integration, ETL & Reporting** — _after: CD integration, org-tenancy data._ XL×3, XXL×2. Superset self-hosted; Django meta layer; dashboards-as-code; per-tenant guest-token + RLS harness; warehouse reporting cutover (store-neutral).
6. **Identity Resolution Engine** — _after: identity strategy, data-model foundation._ L×2, XL×1, XXL×2. Resolution engine core; association provenance; threshold grouping; orphan handling; identity-record event sourcing.
7. **Identity Curation & Data Quality** — _after: identity strategy, data-model foundation, grouping._ XL×5, M×1. Curation queue; curation/eval UI; resolution-quality eval; data-quality assessment; merge/split audit; curation feedback labels.
8. **Segmentation Engine** — _after: org-tenancy data, resolution-engine core._ XL×3, XXL×1. Segment definition; evaluation & materialization; retrieval/targeting API; membership explainability.
9. **Long Tail** — _after: initial feeds, Superset meta layer._ S×16, XL×5, XXL×1, EPIC×2. The 5 source primitives (1a); 16 source onboards + SSIS reimplementation + report migration + legacy deprecation (1b).

## Sequencing — build waves (from the dependency graph)

| Wave | Workstreams | Phase | Gated by |
|---|---|---|---|
| 0 — Design | Data Model & Identity; Platform Decisions | (Phase 1 Architecture) | — |
| 1 — Foundation | Foundation & Platform | 1a | — |
| 2 — Core + surfaces | Backend & Data Model; Frontend; Ingest framework; Integration/ETL/Reporting | 1a | Foundation, CDP data-model design |
| 3 — Resolution + segments | Identity Resolution Engine -> Curation & Data Quality; Segmentation | 1a | Data-model foundation, identity strategy, resolution core |
| 4 — Long tail | Source onboarding; SSIS reimplementation; report migration; legacy deprecation | 1b | Initial feeds, Superset meta layer |

## Phase 2 — Applications & Activation

Built on the productionized Phase-1 CDP; can start before 1b completes at critical data mass. Two subphases (derived from `specs/manifest.json` epic `phase-2-build`):

- **Enhancements:** Source Onboarding & Activation Feeds (application-driven onboarding; outbound activation feeds); Activation & Delivery (outbound connectors Meta/TikTok/email/CRM over the Phase-1 NATS backbone, website pixel / JS SDK, event-stream activation); Reporting Parity (custom-report catalog + self-serve reports, store-neutral); Data Exposure & Syndication (governed outbound access).
- **Applicatives:** applications on the CDP. VSS retool (flagship, the engagement's namesake), maintenance/service, marketing activation, mobile, data-enrichment, each consuming the golden record / events / consent instead of re-solving identity.

## Phase 3 — AI / ML

- **3a — External AI integration:** integrate hosted/external AI against the CDP's governed access API; reuse DAS's existing AI layer (`ai.das-technology.com`); LLM-assisted curation and agentic surfaces. The AI/ML schema tables ship empty-but-complete in Phase 1, so this adds with no migration.
- **3b — Build-our-own ML:** Tier 2 pairwise classifier and Tier 3 GNN/embeddings for identity resolution, trained on the labeled merge/curation decisions Phase 1 produces. Earned, not assumed (see the Identity Resolution Strategy).

## Infrastructure cost model (AWS vs Azure)

The plan separates **build cost** (engineering effort, sized above) from **infrastructure run-cost** (the monthly cloud bill the productionized CDP carries). Run-cost is folded in here; full per-line pricing is canonical in [`../cloud-aws-vs-azure-bakeoff.md`](../cloud-aws-vs-azure-bakeoff.md), sizing/placement in [`../cdp-reference-topology.md`](../cdp-reference-topology.md).

**Reference topology** (rightsize-on-load posture, 2026-06-16): dev = 3×4-vCPU nodes + single-AZ 100 GB Postgres; prod = 6×8-vCPU nodes + HA Postgres (100 GB start) + 1 read replica; self-hosted OSS core (NATS, Temporal, Airflow, OpenSearch, Jaeger) on the node group; managed Postgres / Redis / object store / ingress.

**All-in monthly run-cost: BASELINE planning guide, not a final cost.** These figures are an order-of-magnitude **baseline** built from verified unit rates × modeled (assumed) quantities, sized to frame planning and compare clouds, not a quote or a committed bill. Final cost is established only once we have a **sized production footprint**: observed load/data volume (the rightsize-on-load posture), and the locked cloud + warehouse + monitoring choices. Treat the numbers below as a starting point that firms up as the platform is sized.

| Environment | AWS | Azure |
|---|--:|--:|
| Dev | ~$1,140 | ~$1,150 |
| Prod (Postgres-native warehouse) | ~$4,460 | ~$4,590 |
| Prod + managed warehouse | +$360–1,095 (Redshift, 4-RPU) | +$25–250 (Synapse) / +$526+ (Fabric) |

- **Phasing:** Phase 1a runs on the dev baseline (~$1,140/mo); prod run-cost (~$4,460/mo) phases in as the platform approaches production and 1b onboarding scales data volume.
- **Read:** at Postgres-native the clouds are cost-neutral (~3% apart); on a managed warehouse the clouds are roughly even since AWS's 4-RPU Redshift floor (2025), with Synapse pay-per-scan the Azure lever for query-driven use. The architecture is a portable OSS core (no app-code lock-in); **Azure-primary is preferred** (DAS org cloud), AWS the alternative (data gravity). No cloud decision is recorded: the bake-off is the comparison for DAS to choose from, and cross-cloud ingestion egress and the managed-monitoring choice are the swing factors.
- **Caveat:** unit prices are first-party-verified (2026-06-22); node counts and volumes are engineering estimates with no observed prod load yet, so totals are **±30–40% planning figures, not a quote**.

## Effort & sizing notes

- Sizing is **relative** (S->EPIC), per story in `specs/manifest.json`: a complexity/scope signal, not a committed schedule.
- **Heaviest streams:** Foundation & Platform, Backend & Data Model, Ingest (multiple XXL/XXXL); the Long Tail carries the EPICs and is sequenced last (1b).
- **SOW conversion:** the relative sizing maps to team composition, build timeline, and labor cost; the SOW sets the MVP cut line and the phase commercial boundaries. The infrastructure run-cost is summarized above; this document stops short of a committed build schedule by design.

## Source

Derived from `specs/manifest.json` (epics `phase-1-architecture`, `phase-1-build`, `phase-2-build`, `phase-3-ai-ml`). The phase model (1a/1b, Phase 2 subphases, 3a/3b) and the cost model are planning overlays; regenerate the scope/sizing tables here when the backlog changes.
