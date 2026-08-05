---
title: "Foundation & Platform"
type: feature
status: planned
priority: high
labels: [foundation, platform, infra, phase-1]
date: ~
---

The platform substrate: app repos, cloud org/accounts/identity (Azure / AWS), tiered permissions, CI/CD, modeled push-button prod deploy, base org auth + reproducible local dev. Everything else in Phase 1 depends on it. Portable OSS core (Azure-primary preferred; AWS alternative), Kubernetes (AKS / EKS) + Terraform.

**Milestone.** Environments + pipelines green; one service deploys dev -> (modeled) prod.

## Reference artifacts (canonical — do not duplicate here)

Infra sizing and cloud costs are written up once, in `docs/`, and referenced from the plan so they stay single-source:

- **Reference topology (dev + prod sizing, workload placement):** [`docs/cdp-reference-topology.md`](../../../docs/cdp-reference-topology.md) — node groups, what runs where, PV sizing, managed-tier deltas, scaling levers, per-cloud SKU mapping.
- **Cloud cost comparison (AWS vs Azure):** [`docs/cloud-aws-vs-azure-bakeoff.md`](../../../docs/cloud-aws-vs-azure-bakeoff.md) — verified unit prices, all-in dev/prod totals, warehouse options.
