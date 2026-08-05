---
title: "Auth0 integration"
type: story
status: planned
priority: high
estimate: XL
depends_on: [phase-1-build.foundation.base-org-auth-local-dev]
labels: [frontend, auth, auth0, 1a]
date: ~
---

Integrate Auth0 (federating EntraID) for login and session management. Pass the JWT to Django on every API call and handle silent token refresh.

**Acceptance:** EntraID login via Auth0 establishes a session; a valid JWT is attached to every API call and accepted by Django; an expired access token is silently refreshed without re-login; unauthenticated requests are rejected with 401.

**References:**
- Decided 2026-06-13 (Leo, Phase 0 architecture recommendation): Auth0 primary (SaaS, federates EntraID), Cognito AWS-native fallback; 4-role group-based (das_admin/das_analyst/dealer_admin/dealer_user) — `memory/decisions.md#d-086`
- `docs/cdp-architecture.md` · `wiki/Tech-Stack.md` — Auth0 (EntraID federation, 4-role group-based) as the canonical auth layer; Auth0 JWT validated first-line in Django
- `wiki/Multi-Tenancy.md` — tenant context set from JWT claims and injected into the DB session; role-based route guards
