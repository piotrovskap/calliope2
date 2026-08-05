---
title: "Tiered permissions"
type: story
status: planned
priority: high
estimate: M
depends_on: [phase-1-build.foundation.aws-org-iam-identity-center]
labels: [iam, permissions, foundation, 1a]
date: ~
---

Tiered IAM permission sets, SCPs, and least-privilege roles across accounts, assigned through Identity Center groups. Enforces separation between prod and lower environments.

**Acceptance:** Least-privilege permission sets assigned to Identity Center groups so a lower-tier group can reach dev but is denied prod (verified by an actual access attempt), prod-write gated to a privileged group, and all permission sets/SCPs defined in Terraform with no inline console grants.

**References:**
- Decided 2026-06-13 (Leo, Phase 0 arch recommendation): AWS-primary, no Azure infra initially — `memory/decisions.md`
- Decided 2026-06-17 (Dan Aston): reopens AWS-primary; DAS prefers Azure-primary, cloud bake-off makes it a DAS cost/benefit choice — both clouds must be supported — `memory/decisions.md#d-093`
- `docs/cloud-aws-vs-azure-bakeoff.md` — maps the stack (incl. org/identity guardrails) onto AWS and Azure, the dual-cloud framing this tiering must satisfy

**Subtasks:**
- AWS: tiered IAM permission sets + SCPs + least-privilege roles via Identity Center groups, Terraform-reproducible, no inline console grants
- Azure: equivalent tiering via Entra ID groups + Azure RBAC roles + Azure Policy guardrails, Terraform-reproducible
