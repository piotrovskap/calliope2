---
title: "Auto CD to dev/integration"
type: story
status: planned
priority: high
estimate: XL
depends_on: [phase-1-build.foundation.ci-pipeline, phase-1-build.foundation.accounts-prod-dev-staging]
labels: [cd, foundation, 1a]
date: ~
---

Automatic deploy to the dev/integration Kubernetes environment (AKS on Azure-primary; EKS on AWS) on merge to main, no manual steps. Builds on green CI and the provisioned dev account/subscription. Cloud-neutral — the pipeline targets whichever substrate the bake-off selects. Precedes the modeled prod path.

**Acceptance:** A merge to `main` automatically builds and deploys the updated service to the dev/integration Kubernetes cluster (AKS/EKS) with zero manual steps, the new revision is observably serving, and the deploy uses a scoped CI identity into the dev account/subscription only (no prod-capable credentials).

**References:**
- Decided 2026-06-17 (cloud bake-off): tweak the stack to fit BOTH clouds, DAS chooses — pipeline targets whichever substrate (AKS/EKS) the bake-off selects — `memory/decisions.md#d-093`
- Decided 2026-06-16 (infra sizing): dev baseline first, production rightsized on observed load — the dev/integration environment this story deploys into — `memory/decisions.md#d-007`
- IaC: EKS + Terraform via `boilerworks-opscode` (self-host workloads on the node group; DB on managed RDS, not the cluster) — `memory/decisions.md`
- Decided 2026-06-15, refined 2026-06-17 (dev/prod CI/CD): merged code promotes via CD, no direct prod authoring — this story builds the dev/integration leg that precedes the modeled prod path — `memory/decisions.md#d-101`
- `docs/cdp-reference-topology.md` — fixes the dev vs prod node-group/workload placement the deploy targets
- `docs/cloud-aws-vs-azure-bakeoff.md` — the per-cloud (AWS/Azure) substrate comparison driving the cloud-neutral pipeline
