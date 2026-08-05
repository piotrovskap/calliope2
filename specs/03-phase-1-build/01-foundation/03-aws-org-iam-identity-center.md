---
title: "Cloud org + identity (Azure Entra ID / AWS Organizations + IAM Identity Center)"
type: story
status: planned
priority: high
estimate: M
labels: [cloud, org, identity, foundation, 1a]
date: ~
---

Cloud org with management/bastion account and SSO for human access, plus org guardrails. On AWS: Organizations + IAM Identity Center + SCPs; on Azure: a management-group hierarchy + Entra ID + Azure Policy. Root of the account/permissions tree; blocks member-account and tiered-permission stories.

**Acceptance:** the cloud org/management hierarchy is created with at least one org-wide guardrail enforced; SSO enabled with a user able to assume a role into a member account/subscription via the bastion pattern (no long-lived users/keys); org and guardrails reproducible from Terraform.

**References:**
- Decided 2026-06-13 (Leo, Phase 0 arch recommendation): AWS-primary, no Azure infra initially — `memory/decisions.md`
- Decided 2026-06-17 (Dan Aston): reopens AWS-primary; DAS prefers Azure-primary, cloud bake-off makes it a DAS cost/benefit choice — both clouds must be supported — `memory/decisions.md#d-093`
- `docs/cloud-aws-vs-azure-bakeoff.md` — maps the stack onto AWS and Azure (the dual-cloud framing this org/identity foundation must satisfy)

**Subtasks:**
- AWS: Organizations (management/bastion account) + IAM Identity Center (SSO) + SCP guardrails, Terraform-reproducible
- Azure: management-group hierarchy + Entra ID (SSO) + Azure Policy guardrails, Terraform-reproducible
