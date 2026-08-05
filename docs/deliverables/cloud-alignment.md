---
title: Alignment with DAS's Cloud Footprint
type: deliverable
status: complete
phase: 0
owners: Leo Mata
review: Dan Aston
---

# Alignment with DAS's Cloud Footprint

*Phase 0 deliverable: how the CDP's target architecture fits the cloud environment DAS already runs, and what that means for cost and cloud choice. Written for decision-makers. The full side-by-side pricing lives in `docs/cloud-aws-vs-azure-bakeoff.md`, and the architecture it aligns to is in `docs/cdp-architecture.md`.*

## The reality we are building into: a split estate

DAS's environment is not on one cloud, and the CDP has to respect that. Two facts shape every choice below:

- **Data gravity is on AWS.** The CDP's source databases live there today: SQL Server on EC2 (`ETL01`, `3BHS001`, `SQL01`) and MySQL on RDS (Analytics, Mautic). That is where the consumer data the CDP must ingest physically sits.
- **The application and event layer is on Azure.** DAS publishes its application events through Azure Event Grid (Acceptor leads plus Inventory, Comms, Survey, Reputation) and runs application workloads on AKS. DAS names Azure as its org-primary cloud, the platform it wants to consolidate on.

So the CDP sits between two pulls: its raw input is anchored to AWS, while the organization it serves standardizes on Azure. Wherever the CDP lands, **ingestion crosses a cloud boundary somewhere**, either as cross-cloud egress from the AWS-resident sources or eventually as a source migration. That crossing is real, and we treat it as a first-class cost line, not a footnote.

## What we reuse vs. what is net-new

We do not rebuild what DAS already has. The CDP reuses existing infrastructure where it can:

- **Auth0**, the DAS-approved identity SaaS, which federates EntraID. Cloud-neutral and already in place.
- **The existing source databases**: the CDP reads from them, it does not replace them. Legacy `3BHS001` in particular is touched cautiously (extract via read replica and low-impact windows), because its dependencies are not fully mapped.

Everything else the CDP runs is net-new, deployed by us as part of the engagement: Kubernetes (the runtime for the whole stack), NATS (event intake), Temporal (workflow orchestration), PostgreSQL (the canonical store), OpenSearch (search and trace storage), Airflow (batch ingest orchestration), Superset (reporting), and Jaeger (distributed tracing). None of these displace anything DAS owns today; they are the CDP's own machinery.

## The portable core, and the swap-points around it

The architecture is **cloud-neutral by design**. At its center is a portable open-source core (Postgres, NATS, Temporal, OpenSearch, Airflow, Auth0, OTel) that runs unchanged on either cloud. The application code never names a cloud, so there is no vendor lock-in in app code. Moving the CDP between clouds is a substrate swap, not a redesign.

Around that core sits a small set of **proprietary swap-points**, the places where a cloud's managed service is the natural fit. Each one has both an Azure and an AWS equivalent, chosen behind an interface so the core never has to change:

| Swap-point | Azure | AWS |
|---|---|---|
| Managed Airflow | self-host on AKS | MWAA (managed) |
| Warehouse | Fabric / Synapse / Postgres-native | Redshift / Postgres-native |
| Source CDC | Azure DMS or Debezium | AWS DMS or Debezium |
| Backup / DR | Azure Backup + geo-redundant Blob | AWS Backup + S3 cross-region |
| Secrets / KMS | Key Vault | Secrets Manager + KMS |
| Object storage | Azure Blob | S3 |
| Load balancer (L7) | Application Gateway v2 | ALB |

The portable default for the analytics layer is **Postgres-native**: it carries no per-cloud premium and moves with the core. A managed warehouse is an *optional* layer on top, not a dependency. The same holds for monitoring: the default is self-hosted Prometheus/Grafana on the cluster, with managed services (Azure Monitor / AWS AMP) as an opt-in.

## The cost read — a baseline, not a quote

The full comparison is in the bake-off; here is the shape of it. **Unit prices are verified** against first-party rate catalogs as of 2026-06-22 (Azure via the live Retail Prices API, AWS via official pricing pages). **Quantities are engineering estimates** (node counts, storage, egress and replica volumes), because there is no observed production load yet. So treat per-unit rates as firm and monthly totals as ±30–40% planning figures. The structural conclusions do not depend on the soft numbers.

| Environment | AWS | Azure |
|---|--:|--:|
| Dev baseline | ~$1,140/mo | ~$1,150/mo |
| Production — Postgres-native warehouse | ~$4,460/mo | ~$4,590/mo |
| + managed warehouse (optional layer) | +$360–1,095/mo (Redshift, 4-RPU floor) | +$25–250/mo (Synapse) · +$526+/mo (Fabric) |

*Baseline planning figures (verified rates × modeled quantities), not a quote. Full per-line pricing: `docs/cloud-aws-vs-azure-bakeoff.md`.*

- **Cost-neutral at the Postgres-native baseline.** With Postgres-native as the warehouse, the two clouds land within roughly 3% of each other (about $4,451/mo AWS vs $4,583/mo Azure at the modeled production scale). Cloud choice does not move the backbone number: Azure's cheaper Postgres, connection pooling, secrets, DR, and egress offset its pricier VMs and L7 ingress.
- **Warehouse: pay-per-scan is the Azure lever, but the provisioned gap closed in 2025.** Synapse Serverless (pay-per-TB-scanned) is cheapest for query-driven reporting (+$25–250/mo). After AWS lowered the Redshift Serverless floor to 4 RPU (June 2025), an always-on *provisioned* warehouse is roughly even between clouds — Redshift 4-RPU (+$360–1,095/mo) lands near Azure Fabric (+$526–1,051), not the ~2× gap the old 8-RPU floor implied. Azure's edge reduces to the pay-per-scan option, ~$335–845/mo for query-driven use — no longer a large structural delta. (The 4-RPU floor caps at 32 TB managed storage; above that, ≥8 RPU.)
- **Cross-cloud ingestion egress is the one cost AWS avoids.** Because the sources sit on AWS, landing the CDP on Azure adds an ongoing cross-cloud ingestion egress line (~$90/mo at the modeled volume, plus a one-time backfill). On AWS that line is zero. This is the concrete price of the split estate.
- **The phantom AKS surcharge is corrected.** A prior version claimed AWS won at scale because of a per-vCPU AKS node-management surcharge. That meter does not exist: the Retail Prices API exposes no such charge, and AKS bills only cluster-hour meters (with a free tier for non-prod). With that error removed, the "AWS cheaper at scale" basis is void, which is what leaves the backbone cost-neutral.

## The recommendation framing

The direction set on 2026-06-17 (Dan Aston) is **Azure-primary preferred**: consolidate the CDP on DAS's org cloud, co-located with the Event Grid event layer the CDP already subscribes to. AWS is the credible alternative, justified by data gravity: the source databases live there, and AWS has managed peers for a few services Azure self-hosts. Neither is wrong; the architecture works on both, and the avoid-SaaS direction closes every Azure gap the way we would build it anyway.

Cost is **not a blocker** to either choice: the backbone is cost-neutral, and the places where cloud choice moves money (warehouse, monitoring, cross-cloud egress) are known and bounded. DAS makes the final call on the cost/benefit. As of this writing, no cloud decision is recorded; the bake-off completes the research, and the choice is DAS's to make.

## Where to go deeper

- Full side-by-side pricing, component mapping, and the verified rate catalog: `docs/cloud-aws-vs-azure-bakeoff.md`
- The target architecture this aligns to (layers, services, the cloud footprint alignment section, locked decisions): `docs/cdp-architecture.md`
