---
title: "Base org auth + local dev"
type: story
status: planned
priority: high
estimate: XL
labels: [auth, local-dev, foundation, 1a]
date: ~
---

Base org auth: Auth0 tenant with the four role groups (das_admin, das_analyst, dealer_admin, dealer_user), plus reproducible one-command local dev environments. Unblocks application feature work.

**Acceptance:** the Auth0 tenant is configured federating EntraID, with the four role groups (das_admin, das_analyst, dealer_admin, dealer_user) defined and a login issuing a JWT whose claims carry the user's role and tenant context. A single command (`make dev` / compose) brings up the full local stack — Django API, Next.js, Postgres, NATS, OpenSearch — seeded and reachable, with a documented health check confirming each service is up and a test login succeeds end-to-end against the local stack.

**References:**
- Decided 2026-06-13 (Leo, Phase 0 arch recommendation): Auth0 primary (SaaS, federates EntraID), Cognito AWS-native fallback; 4-role group-based — das_admin / das_analyst / dealer_admin / dealer_user — `memory/decisions.md#d-086`
- `wiki/Tech-Stack.md` — Auth0 as the approved auth stack (cloud-neutral, federates EntraID; API-key/HMAC for ingestion)
- `wiki/Privacy-by-Design.md` — tenant context (`app.current_tenant` GUC) the JWT's tenant claim feeds for RLS isolation (Updated 2026-06-21, Leo)
