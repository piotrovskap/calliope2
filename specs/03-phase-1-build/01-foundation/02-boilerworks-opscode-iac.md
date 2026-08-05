---
title: "Boilerworks-opscode (IaC)"
type: story
status: planned
priority: high
estimate: XL
labels: [iac, terraform, foundation, 1a]
date: ~
---

The Terraform IaC repo (`boilerworks-opscode`) for all cloud infra (Kubernetes — AKS/EKS — networking, accounts/subscriptions). Remote state backend, reusable module layout, naming conventions. Backs every infra-provisioning story.

**Acceptance:** `terraform init`/`plan` succeed against a remote state backend (object storage + state locking) with per-environment workspaces; reusable module layout and naming conventions documented; no local state and no manually-created backend resources.

**References:**
- Decided 2026-06-13 (Leo, Phase 0 arch recommendation): Terraform IaC via `boilerworks-opscode` — `memory/decisions.md`
- Cloud reopened 2026-06-17 (Dan: Azure-primary preference, no flip): IaC must stay cloud-agnostic (AKS/EKS) pending the bake-off — `memory/decisions.md`
- `docs/cdp-architecture.md` · `wiki/Tech-Stack.md` — Terraform/`boilerworks-opscode` as the canonical IaC layer
- `docs/cloud-aws-vs-azure-bakeoff.md` — the AWS-vs-Azure substrate the IaC must provision either of
