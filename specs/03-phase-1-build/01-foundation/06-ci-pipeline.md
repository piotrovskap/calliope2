---
title: "CI pipeline"
type: story
status: planned
priority: high
estimate: XL
depends_on: [phase-1-build.foundation.boilerworks-repos]
labels: [ci, foundation, 1a]
date: ~
---

Build/test/lint CI for app repos and the IaC repo (Terraform validate/plan). Runs on every PR as a merge gate. Blocks CD.

**Acceptance:** Every PR runs build + unit tests + lint on app repos and `terraform fmt`/`validate`/`plan` on the IaC repo; a failing check blocks merge (required status checks) and a passing one allows it, demonstrated by one red and one green PR.

**References:**
- Decided 2026-06-15 (ETL delivery workflow): every PR runs CI as a merge gate, CD on merge to main — the PR-gate pattern this story applies to app + IaC repos — `memory/decisions.md#d-101`
- Decided 2026-06-13 (Leo, Phase 0 architecture recommendation): app repos `boilerworks` + `boilerworks-django-nextjs`, IaC in `boilerworks-opscode` (Terraform; AKS/EKS) — `memory/decisions.md`
- `docs/cdp-architecture.md` · `wiki/Tech-Stack.md` — the canonical stack (Terraform IaC, containers on Kubernetes) the pipeline builds and validates
