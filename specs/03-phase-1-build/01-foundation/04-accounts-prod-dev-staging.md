---
title: "Prod / Dev / Staging accounts"
type: story
status: planned
priority: high
estimate: L
depends_on: [phase-1-build.foundation.aws-org-iam-identity-center]
labels: [cloud, accounts, foundation, 1a]
date: ~
---

Separate cloud member accounts/subscriptions for prod and dev (staging optional) — AWS accounts / Azure subscriptions — each baselined with guardrails. Provisioned via opscode under the org. Needed by CD/integration deploys.

**Acceptance:** Prod and dev member accounts created under the org via opscode Terraform, each with baseline guardrails (SCPs, default-deny networking, billing/CloudTrail) applied; accounts reproducible from Terraform with no console-clicked setup.

**References:**
- Decided 2026-06-13 (Leo, Phase 0 arch recommendation): EKS + Terraform via `boilerworks-opscode`, infra reproducible from IaC — `memory/decisions.md`
- Cloud bake-off 2026-06-17 (Leo): dual-cloud target (AWS Organizations / Azure subscriptions), DAS chooses — `memory/decisions.md`
- `docs/cdp-architecture.md` — canonical infra/platform stack the accounts host
