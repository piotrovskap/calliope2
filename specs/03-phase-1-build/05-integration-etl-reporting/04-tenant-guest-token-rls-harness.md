---
title: "Per-tenant guest-token + RLS harness"
type: story
status: planned
priority: high
estimate: XL
depends_on: [phase-1-build.integration-etl-reporting.django-superset-meta-layer, phase-1-build.backend-data-model.org-tenancy-data]
labels: [reporting, superset, rls, multi-tenant, 1a]
date: ~
---

Mint per-dealer guest tokens whose RLS clause derives from the CDP tenant model. GUEST_TOKEN_VALIDATOR_HOOK rejects any token missing a tenant predicate; embeds refresh tokens silently.

**Acceptance:** an embed minted for dealer A returns only dealer A's rows across every dataset; a token whose RLS clause lacks a tenant predicate, or carries a different dealer's predicate, is rejected by GUEST_TOKEN_VALIDATOR_HOOK (no cross-tenant leak); tokens refresh silently before expiry without reload.

**References:**
- Decided 2026-06-14: Superset headless/embedded; per-tenant isolation derived from the existing tenanted data-isolation model (single source of truth, no second mechanism); per-session guest-token RLS clause generated from it; `GUEST_TOKEN_VALIDATOR_HOOK` cross-tenant-leak guard — `memory/decisions.md#d-031`
- Decided 2026-06-21 (Leo): RLS confirmed as the multi-tenant isolation mechanism — shared-schema + RLS, tenant context via `app.current_tenant` GUC per transaction — `memory/decisions.md#d-004`
- `wiki/Privacy-by-Design.md` · `wiki/Multi-Tenancy.md` — RLS-based tenant isolation on `dealership_id`, tenant context injected per session, the model the guest-token RLS clause derives from
