---
title: "Push-button prod deploy (modeled)"
type: story
status: planned
priority: high
estimate: XL
depends_on: [phase-1-build.foundation.cd-integration]
labels: [cd, prod, foundation, 1a]
date: ~
---

A modeled (designed, NOT stood up) push-button production deploy path: gates, approvals, rollback. Mirrors the dev/integration CD flow against the prod account, ready to provision later.

**Acceptance:** the prod deploy path is modeled end-to-end as a reviewable artifact (pipeline-as-code + runbook + diagram) covering a manual approval gate, promotion of the dev/integration-built revision (no rebuild), an automated health/smoke check, and one-step rollback to the prior revision. The model targets the prod account/subscription with prod-scoped credentials defined but not activated. Deliverable is the committed, reviewed design + pipeline definition — explicitly NOT a provisioned prod environment. **Milestone.**

**References:**
- Decided 2026-06-15 (ETL delivery workflow): two-environment delivery — separate prod, merged revisions promote from non-prod via CD, no direct prod authoring — `memory/decisions.md#d-101`
- Decided 2026-06-17 (Dan Aston / Conflict): CI/CD across dev+prod on the cloud-agnostic self-hosted core (supersedes the MWAA framing) — `memory/decisions.md#d-101`
- `docs/cdp-reference-topology.md` — fixes the dev + prod environments and prod steady-state sizing
- `docs/cloud-aws-vs-azure-bakeoff.md` — the prod substrate (AKS/EKS) the modeled path targets
