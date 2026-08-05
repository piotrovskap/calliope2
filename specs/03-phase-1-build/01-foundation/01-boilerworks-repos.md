---
title: "Boilerworks repos"
type: story
status: planned
priority: high
estimate: L
labels: [repos, foundation, 1a]
date: ~
---

Stand up the app repos: `boilerworks` services + `boilerworks-django-nextjs` frontend (Python/Django backend, Next.js frontend). Base structure, branch protection, README per repo. Needed by CI pipeline.

**Acceptance:** Both repos exist with runnable scaffold (backend boots, frontend builds), README per repo, and branch protection on `main` requiring PR + passing checks with direct pushes blocked.

**References:**
- Decided 2026-06-13 (Leo, Phase 0 architecture recommendation): Django (ORM/migrations/REST) + Strawberry GraphQL backend, Next.js frontend on `boilerworks-django-nextjs` — `memory/decisions.md#d-087`
- Language strategy 2026-06-14: Python primary, Go for measured hot paths — `memory/decisions.md`
- IaC in `boilerworks-opscode` (Terraform; AKS/EKS) — `memory/decisions.md`
- `docs/cdp-architecture.md` · `wiki/Tech-Stack.md` — the canonical stack
