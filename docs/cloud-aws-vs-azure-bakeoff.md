# Cloud Bake-Off — AWS vs Azure for the DAS CDP

**Status: analysis + gaps + verified costs as of 2026-06-22.** Unit prices re-verified against first-party rate catalogs — Azure via the live Azure Retail Prices API,[^az-retail] AWS via the official service pricing pages (referenced per line below). This pass corrects a material error in the prior (2026-06-17) version: the **AKS per-vCPU node surcharge cited there does not exist** (see "Pricing correction" below). Produced in response to Dan Aston's 2026-06-17 direction: DAS would prefer to consolidate on **Azure** (its org-primary cloud) unless cost or a technical concern says otherwise. This reopens the 2026-06-13 AWS-primary recommendation. It is **not a flip** — the deliverable is a side-by-side so DAS can make the call on cost/benefit, not preference.

**Costing nature:** the **unit prices are verified and real** as of the date above. The **quantities (node counts, storage, sample/egress volumes, replica counts) are engineering estimates** — there is no observed production load yet (per the 2026-06-16 dev-baseline-first decision). Treat the per-unit rates as firm and the **monthly totals as ±30–40% planning figures**, not a quote. The *structural* conclusions do not depend on the soft quantities.

## Framing

- **The architecture is cloud-neutral by design.** The stack is a portable open-source core behind interfaces ("no vendor lock-in in app code"). Moving the primary target from AWS to Azure is a substrate swap, not a redesign.
- **Design constraint: avoid proprietary SaaS; prefer self-hosted open-source.** Where the AWS design leaned on a managed service, the Azure target self-hosts the OSS equivalent rather than take an Azure-proprietary SaaS. This keeps the stack identical across clouds and removes managed-service premiums, at the cost of running the software ourselves.
- **Honest starting read (Leo):** AWS would be *a little easier* — DAS's source databases already live there (SQL Server on EC2, MySQL on RDS), so there's data gravity, and AWS has managed peers (MWAA, Redshift zero-ETL, DMS) for services Azure lacks. But "a little easier" is not decisive. The cost/benefit comparison decides; DAS chooses.
- **The data-gravity tension:** DAS calls Azure its org-primary cloud, yet its CDP source data currently sits on AWS. Whichever cloud the CDP lands on, ingestion crosses a boundary somewhere (cross-cloud egress from the AWS-resident sources, or an eventual source migration). Egress is a first-class line item below, not a footnote.

## Reference scale (assumptions for costing)

Held constant across both clouds so the comparison is apples-to-apples.

- Consumers: ~10M; tenants (dealers): ~1,700.
- Posture: **dev baseline first, production rightsized on observed load** (2026-06-16 infra-sizing decision). Costs below give a **dev-baseline** figure and a **production steady-state** figure.
- Region: US East (AWS us-east-1 / Azure East US) for both. ~730 hours/month.
- Excluded: one-time migration/build labor, third-party SaaS already cloud-neutral (Auth0), and DAS's existing source infra.

## Component mapping — our stack on each cloud

Cloud-neutral core (runs identically on EKS or AKS, no per-cloud change): **native Postgres, NATS JetStream (event intake), RabbitMQ (messaging/queue), Temporal, self-hosted Airflow, self-hosted OpenSearch, Django/Strawberry GraphQL, Next.js, OTel collector, Debezium, Auth0.**

| Capability | AWS | Azure | Equivalent? | Notes / portability |
|---|---|---|---|---|
| Kubernetes | EKS[^aws-eks] | AKS[^az-aks] | Yes | App workloads identical (CNCF k8s). Delta is control-plane fee + node VM pricing. |
| Managed Postgres | RDS for PostgreSQL (native) + RDS Proxy + read replicas[^aws-rds][^aws-rdsproxy] | Azure Database for PostgreSQL Flexible Server (built-in PgBouncer, read replicas)[^az-pg] | Yes | Both managed native PG. RDS Proxy ↔ built-in PgBouncer (free). PG ≥ 15 either side. |
| Object storage (bronze) | S3 (SSE-KMS)[^aws-s3] | Azure Blob (CMK via Key Vault)[^az-blob] | Yes (behind interface) | Different APIs → isolated behind a storage interface. Lifecycle + replay both. |
| Analytics / warehouse | Redshift via zero-ETL from RDS-Postgres[^aws-redshift] | Fabric mirroring from Azure DB for PostgreSQL (GA, free OneLake ingest); or Synapse Serverless ($/TB-scanned); or Postgres-native[^az-fabric][^az-synapse] | Yes | Fabric mirroring is the Azure zero-ETL analog. Postgres-native stays the portable default. |
| Batch orchestration | MWAA (managed Airflow)[^aws-mwaa] | No managed Airflow peer (ADF Managed Airflow new-instance creation retired) | **GAP** | Close: **self-host Airflow on AKS** (Helm) — identical across clouds, removes the managed premium, adds ops ownership. |
| Search | Amazon OpenSearch Service (managed)[^aws-opensearch] | No first-party managed OpenSearch (Azure AI Search is a different product/API) | **GAP** | Close: **self-host OpenSearch on AKS** for portability. |
| Event stream intake | NATS JetStream (self-host) | NATS JetStream (self-host) | Yes | Cloud-neutral. |
| Messaging / work queue | RabbitMQ (self-host) | RabbitMQ (self-host) | Yes | Replaces SQS / Service Bus; aligns with DAS's CloudAMQP. Cloud-neutral. |
| Workflow engine | Temporal (self-host) | Temporal (self-host) | Yes | Cloud-neutral; no change. |
| Source CDC | AWS DMS | Azure DMS, or self-host Debezium | Yes | Prefer **Debezium (OSS)** for portability. |
| API + frontend | Django REST + GraphQL + Next.js on k8s | Same on AKS | Yes | Cloud-neutral. |
| Auth | Auth0 (federates EntraID) | Auth0 (EntraID native on Azure) | Yes | SaaS — cloud-neutral; already approved. |
| Secrets + keys | Secrets Manager + KMS[^aws-secrets][^aws-kms] | Key Vault (secrets + keys)[^az-kv] | Yes (behind interface) | Key Vault has no per-key/per-secret rent. |
| Cache | ElastiCache for Redis[^aws-elasticache] | Azure Cache for Redis[^az-redis] | Yes | Standard Redis protocol; cloud-neutral. |
| L7 ingress | ALB (AWS LB Controller)[^aws-elb] | Application Gateway v2 + AGIC[^az-appgw] | Yes | Both L7. App Gateway has a ~9× higher fixed fee. |
| Egress / NAT | VPC data transfer + NAT Gateway[^aws-dt][^aws-vpc] | Bandwidth + NAT Gateway[^az-bw][^az-nat] | Yes | Cross-cloud ingestion egress is the real asymmetry (sources on AWS). |
| Monitoring | OTel + AMP (managed Prometheus) + Managed Grafana[^aws-amp][^aws-grafana] | OTel + Azure Monitor (managed Prometheus) + Managed Grafana[^az-monitor][^az-grafana] | Yes | OTel portable; or self-host Prometheus/Grafana on either (consistent with avoid-SaaS). |
| DR / backup | AWS Backup (RDS PITR) + S3 cross-region[^aws-backup] | Azure Backup + geo-redundant Blob + PG PITR[^az-backup] | Yes | Equivalent capabilities. |
| Block storage (PVs) | EBS gp3[^aws-ebs] | Premium SSD v2 / managed disks[^az-disks] | Yes | Stateful sets (OpenSearch, NATS, etc.). |

## Gaps — where the clouds genuinely differ

**Azure-side gaps (each has a close):**
1. **No managed Airflow peer to MWAA** → self-host Airflow on AKS.
2. **No first-party managed OpenSearch** → self-host OpenSearch on AKS.
3. ~~No zero-ETL Postgres→warehouse analog.~~ **CLOSED:** Fabric mirroring for Azure DB for PostgreSQL Flexible Server is GA with free OneLake ingest.

**AWS-side gaps:** effectively none for this stack — it was designed AWS-native. The cost of AWS is the cross-cloud reality that DAS otherwise standardizes on Azure.

**Net:** every Azure gap is closable by self-hosting an OSS component on AKS — exactly the SaaS-avoidance direction. The trade is **managed-service convenience (AWS) vs operational ownership + portability (Azure self-host).**

## Pricing correction (vs the 2026-06-17 version)

The prior version claimed AWS gets cheaper at scale because of a **~$7.05/GP-vCPU-mo AKS node-management surcharge** that scales with node count (crossover ~20 nodes). **This meter does not exist.** The live Azure Retail Prices API exposes no per-vCPU AKS charge; AKS bills only cluster-hour meters — `Standard Uptime SLA` at $0.10/cluster-hr (the same as EKS) and an optional `Standard Long Term Support` at $0.60/cluster-hr — and a **Free tier at $0** (no SLA, fine for non-prod).[^az-aks] The "$7.05/vCPU" figure was a misattribution and is removed. Consequence: the only node-scaling cost difference is the VM list price itself (Azure D-series ~18% above comparable AWS m6i), not a structural surcharge — so the prior "AWS wins at scale" conclusion does not hold.

## Verified unit prices (2026-06-22)

AWS us-east-1 vs Azure East US. Azure rates pulled from the Retail Prices API (`type=Consumption`, USD); AWS from official pricing pages (footnoted).

| Capability | AWS | Azure | Favors |
|---|---|---|---|
| K8s control plane | EKS $0.10/cluster-hr[^aws-eks] | AKS Free $0 / Standard $0.10/cluster-hr (+ optional LTS $0.60)[^az-aks] | Azure (free non-prod) |
| Worker VM, 4 vCPU | m6i.xlarge $0.192/hr[^aws-ec2] | D4ds_v5 $0.226/hr[^az-vm] | AWS |
| Worker VM, 8 vCPU | m6i.2xlarge $0.384/hr[^aws-ec2] | D8ds_v5 $0.452/hr[^az-vm] | AWS |
| Managed PG compute (4 vCPU) | RDS db.r6g.xlarge $0.45/hr single-AZ ($0.90 multi-AZ)[^aws-rds] | PG Flex GP 4-vCore $0.356/hr (HA = 2×)[^az-pg] | Azure |
| Managed PG storage | gp3 $0.115/GB-mo[^aws-rds] | Premium SSD $0.115/GiB-mo[^az-pg] | even |
| PG conn pooler | RDS Proxy $0.015/vCPU-hr (~$44/mo @4vCPU)[^aws-rdsproxy] | built-in PgBouncer, free[^az-pg] | Azure |
| Object storage | S3 $0.023/GB-mo[^aws-s3] | Blob Hot LRS $0.0208/GB-mo[^az-blob] | ~even |
| Redis | ElastiCache cache.r6g.large $0.206/node-hr[^aws-elasticache] | Azure Cache Standard C3 $0.225/hr[^az-redis] | ~even |
| Serverless warehouse | Redshift Serverless $0.375/RPU-hr, **4 RPU min (us-east-1)**[^aws-redshift] | Fabric $0.18/CU-hr; Synapse Serverless $5/TB-scanned[^az-fabric][^az-synapse] | ~even; Azure has the pay-per-scan lever |
| Managed Airflow | MWAA mw1.small $0.49/hr[^aws-mwaa] | retired — self-host | n/a (self-host both) |
| Managed search | OpenSearch r6g.large.search $0.167/hr[^aws-opensearch] | no first-party peer | n/a (self-host both) |
| L7 ingress | ALB $0.0225/hr + $0.008/LCU-hr[^aws-elb] | App Gateway v2 $0.20/gateway-hr + $0.008/CU-hr[^az-appgw] | AWS (~9× lower fixed fee) |
| Managed Prometheus | AMP $0.90/10M ingested; query $0.10/B[^aws-amp] | Azure Monitor $0.16/10M ingested; query $0.001/10M[^az-monitor] | Azure (~5.6× cheaper ingest) |
| Managed Grafana | $9/editor, $5/viewer per mo[^aws-grafana] | $6/user-mo + $0.0428/node-hr[^az-grafana] | ~even |
| Key mgmt | KMS $1/key-mo + $0.03/10k req[^aws-kms] | Key Vault no per-key rent, $0.03/10k ops[^az-kv] | Azure |
| Secrets | Secrets Manager $0.40/secret-mo + $0.05/10k[^aws-secrets] | Key Vault no per-secret rent, $0.03/10k ops[^az-kv] | Azure |
| Block storage (PV) | EBS gp3 $0.08/GB-mo[^aws-ebs] | Premium SSD v2 $0.115/GiB-mo[^az-disks] | AWS |
| Internet egress (≤10TB, after 100GB free) | $0.09/GB[^aws-dt] | $0.08/GB[^az-bw] | Azure |
| Cross-AZ / inter-zone | ~$0.01/GB each way[^aws-dt] | ~$0.01/GB inter-zone[^az-bw] | even |
| NAT Gateway | ~$0.045/hr + $0.045/GB processed[^aws-vpc] | ~$0.045/hr + $0.045/GB processed[^az-nat] | even |
| Backup storage | AWS Backup ~$0.095/GB-mo (beyond free)[^aws-backup] | Azure Backup vault GRS (per-GB)[^az-backup] | ~even |

**Resolved (previously `[unverified]`):** Azure Monitor managed Prometheus ingestion = **$0.16/10M samples** (query $0.001/10M, negligible).[^az-monitor] Azure Managed Grafana = **$6.00/user-mo + $0.0428/node-hr**.[^az-grafana]

## Reference topology

Self-hosted OSS core on the k8s node group (what we build): Django API + Next.js, NATS JetStream, RabbitMQ, Temporal, Airflow (scheduler/web/workers), OpenSearch, OTel, Debezium. Managed services: Postgres, Redis, object storage, L7 ingress, secrets/keys, backups.

| | Dev | Prod (rightsized start) |
|---|---|---|
| k8s nodes | 3 × 4 vCPU/16GB | 6 × 8 vCPU/32GB |
| Postgres (managed) | 4 vCPU, single-AZ, 100GB | 4 vCPU, HA + 1 read replica (×3 compute), 100GB → grows |
| App containers | 2 (1 replica each) | 2 (2–3 replicas each) |
| Redis | 1 small node | HA pair |
| Block storage (PVs) | 300GB | 1.5TB |
| Object storage (bronze + backups) | 200GB | 3TB |
| Ingress / monitoring / secrets / backups | minimal | full |
| Cross-region DR | none | pilot-light PG standby + object geo-replication |

## Bottom line — all-in monthly cost

Self-hosted monitoring (consistent with the avoid-SaaS direction). Includes networking glue (NAT, NLBs, inter-AZ, public IPs, container registry) and backups; prod includes cross-region DR. Warehouse shown separately below.

### Dev

| Line item | AWS | Azure |
|---|--:|--:|
| k8s control plane | $73 | $0 |
| worker nodes | $420 | $495 |
| block storage | $24 | $34 |
| managed Postgres | $340 | $271 |
| conn pooler | $44 | $0 |
| Redis | $50 | $40 |
| object storage | $5 | $4 |
| L7 ingress | $22 | $158 |
| monitoring (self-host) | $20 | $30 |
| secrets + keys | $7 | $1 |
| networking glue | $120 | $100 |
| backups | $15 | $15 |
| warehouse (Postgres-native) | $0 | $0 |
| **DEV TOTAL** | **~$1,140** | **~$1,150** |

### Prod

| Line item | AWS | Azure |
|---|--:|--:|
| k8s control plane | $73 | $73 |
| worker nodes (6×8 vCPU) | $1,682 | $1,980 |
| block storage 1.5TB | $120 | $172 |
| managed Postgres (HA + replica) | $1,020 | $814 |
| conn pooler | $44 | $0 |
| Redis (HA pair) | $301 | $328 |
| object storage 3TB | $69 | $62 |
| L7 ingress | $51 | $204 |
| monitoring (self-host) | $52 | $80 |
| secrets + keys | $16 | $1 |
| internet egress | $72 | $64 |
| cross-cloud ingestion egress | $0 | $90 |
| networking glue | $450 | $350 |
| backups | $44 | $41 |
| DR replication (cross-region) | $458 | $322 |
| warehouse (Postgres-native) | $0 | $0 |
| **PROD TOTAL (Postgres-native warehouse)** | **~$4,451** | **~$4,583** |

**With Postgres-native as the warehouse, the clouds are within ~$130/mo (~3%) — cost-neutral.** Azure's cheaper PG/pooler/secrets/DR/egress offsets its pricier VMs and L7 ingress.

### Warehouse layer (optional, on top of Postgres-native)

A hybrid is realistic: Postgres-native for operational/light queries, a managed warehouse for heavy analytics/reporting.

| Option | $/mo | Prod all-in |
|---|--:|--:|
| Postgres-native only (portable default) | $0 | AWS $4,451 / Azure $4,583 |
| AWS Redshift Serverless 4 RPU (8h/day → 24/7) | +$360 → +$1,095 | **$4,811 → $5,546** |
| Azure Fabric F4 → F8 (24/7) | +$526 → +$1,051 | **$5,109 → $5,634** |
| Azure Synapse Serverless (~5–50 TB scanned/mo) | +$25 → +$250 | **$4,608 → $4,833** |

**The warehouse is the largest single line-item, but the cloud gap narrowed in 2025.** Synapse Serverless (pay-per-TB-scanned) remains the cheapest option for query-driven/bursty reporting (+$25–250/mo). For an always-on *provisioned* warehouse the clouds are now roughly even: AWS lowered the Redshift Serverless floor to **4 RPU** in June 2025 ($0.375/RPU-hr → +$360/mo at 8h/day, +$1,095/mo at 24/7), which lands near Azure Fabric F4→F8 (+$526→+$1,051) — not the ~2× gap the old 8-RPU floor implied. So Azure's warehouse edge is no longer a large structural delta; it reduces to the pay-per-scan lever (Synapse/Fabric mirroring + free OneLake ingest), worth roughly $335–845/mo for query-driven use. Caveat: the 4-RPU floor caps at 32 TB managed storage / 100 columns per table; workloads above that still need ≥8 RPU (recompute at the old figures).

### Monitoring variant

The tables self-host Prometheus. If DAS prefers **managed** Prometheus, add **~$1,800/mo on AWS (AMP)** vs **~$320/mo on Azure (Azure Monitor)** at ~20B samples/mo — a separate ~$1,500/mo swing in Azure's favor. Self-hosting (default here) neutralizes it on both.

## Net read

- **Backbone is cost-neutral** at Postgres-native (~$4,451 AWS vs ~$4,583 Azure prod; ~$1,140 vs ~$1,150 dev). Cloud choice does not move the number.
- **The phantom AKS surcharge is gone**, so the prior "AWS cheaper at scale" basis is void.
- **Where cloud choice moves money:** managed Prometheus (Azure cheaper, ~$1,500/mo) favors Azure; a managed warehouse favors Azure only via the Synapse pay-per-scan lever (~$335–845/mo for query-driven use) — a provisioned warehouse is ~even since the 2025 4-RPU Redshift floor; cross-cloud ingestion egress (~$90/mo + one-time backfill) and L7 ingress favor AWS.
- The two highest-leverage unknowns for a firmer total are the **cross-cloud ingestion volume** and the **managed-vs-self-host monitoring/warehouse choices** — these move the number more than node sizing.

DAS makes the final call on this comparison. The architecture works on both; the avoid-SaaS direction closes every Azure gap the way we would build it anyway, and cost is not a blocker to DAS's stated Azure preference.

## References

All pricing pages accessed 2026-06-22; Azure rates additionally cross-checked against the live Retail Prices API.

[^az-retail]: Azure Retail Prices API — https://learn.microsoft.com/en-us/rest/api/cost-management/retail-prices/azure-retail-prices (endpoint: https://prices.azure.com/api/retail/prices)
[^aws-eks]: AWS EKS pricing — https://aws.amazon.com/eks/pricing/
[^aws-ec2]: AWS EC2 On-Demand pricing — https://aws.amazon.com/ec2/pricing/on-demand/
[^aws-rds]: AWS RDS for PostgreSQL pricing — https://aws.amazon.com/rds/postgresql/pricing/
[^aws-rdsproxy]: AWS RDS Proxy pricing — https://aws.amazon.com/rds/proxy/pricing/
[^aws-s3]: AWS S3 pricing — https://aws.amazon.com/s3/pricing/
[^aws-redshift]: AWS Redshift pricing — https://aws.amazon.com/redshift/pricing/
[^aws-mwaa]: AWS MWAA (Managed Workflows for Apache Airflow) pricing — https://aws.amazon.com/managed-workflows-for-apache-airflow/pricing/
[^aws-opensearch]: Amazon OpenSearch Service pricing — https://aws.amazon.com/opensearch-service/pricing/
[^aws-elasticache]: Amazon ElastiCache pricing — https://aws.amazon.com/elasticache/pricing/
[^aws-elb]: Elastic Load Balancing (ALB) pricing — https://aws.amazon.com/elasticloadbalancing/pricing/
[^aws-amp]: Amazon Managed Service for Prometheus pricing — https://aws.amazon.com/prometheus/pricing/
[^aws-grafana]: Amazon Managed Grafana pricing — https://aws.amazon.com/grafana/pricing/
[^aws-kms]: AWS KMS pricing — https://aws.amazon.com/kms/pricing/
[^aws-secrets]: AWS Secrets Manager pricing — https://aws.amazon.com/secrets-manager/pricing/
[^aws-ebs]: Amazon EBS pricing — https://aws.amazon.com/ebs/pricing/
[^aws-dt]: AWS EC2 / VPC data transfer pricing — https://aws.amazon.com/ec2/pricing/on-demand/#Data_Transfer
[^aws-vpc]: AWS VPC pricing (NAT Gateway) — https://aws.amazon.com/vpc/pricing/
[^aws-backup]: AWS Backup pricing — https://aws.amazon.com/backup/pricing/
[^az-aks]: Azure Kubernetes Service pricing — https://azure.microsoft.com/en-us/pricing/details/kubernetes-service/
[^az-vm]: Azure Linux Virtual Machines pricing — https://azure.microsoft.com/en-us/pricing/details/virtual-machines/linux/
[^az-pg]: Azure Database for PostgreSQL Flexible Server pricing — https://azure.microsoft.com/en-us/pricing/details/postgresql/flexible-server/
[^az-blob]: Azure Blob Storage pricing — https://azure.microsoft.com/en-us/pricing/details/storage/blobs/
[^az-fabric]: Microsoft Fabric pricing — https://azure.microsoft.com/en-us/pricing/details/microsoft-fabric/
[^az-synapse]: Azure Synapse Analytics pricing — https://azure.microsoft.com/en-us/pricing/details/synapse-analytics/
[^az-redis]: Azure Cache for Redis pricing — https://azure.microsoft.com/en-us/pricing/details/cache/
[^az-appgw]: Azure Application Gateway pricing — https://azure.microsoft.com/en-us/pricing/details/application-gateway/
[^az-monitor]: Azure Monitor pricing — https://azure.microsoft.com/en-us/pricing/details/monitor/
[^az-grafana]: Azure Managed Grafana pricing — https://azure.microsoft.com/en-us/pricing/details/managed-grafana/
[^az-kv]: Azure Key Vault pricing — https://azure.microsoft.com/en-us/pricing/details/key-vault/
[^az-disks]: Azure Managed Disks pricing — https://azure.microsoft.com/en-us/pricing/details/managed-disks/
[^az-bw]: Azure Bandwidth pricing — https://azure.microsoft.com/en-us/pricing/details/bandwidth/
[^az-nat]: Azure NAT Gateway pricing — https://azure.microsoft.com/en-us/pricing/details/azure-nat-gateway/
[^az-backup]: Azure Backup pricing — https://azure.microsoft.com/en-us/pricing/details/backup/
