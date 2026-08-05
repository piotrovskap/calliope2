---
title: "Service & support console"
type: story
status: planned
priority: medium
estimate: L
depends_on: [phase-1-build.backend-data-model.graphql-surface, phase-1-build.backend-data-model.person-search-opensearch]
labels: [phase-2, applications, support, consumer-360, net-new, 2b]
date: ~
---

A dealer-facing customer-service/support surface over the CDP: a unified consumer 360 for service advisors and support reps, so a rep handling a call or visit sees one resolved consumer — history, vehicles, consent, interactions — instead of pivoting across DMS/CRM/tool silos.

**Scope:** look up a consumer through the Phase-1 person-search surface, then render the unified consumer 360 from the golden record (GraphQL) — contact points, vehicles and ownership, service and interaction history, and current consent/channel state — tenant-scoped and consent-aware. The view is deterministic in P2 (it presents the resolved record as-is); the ML enhancement (next-best-action recommendations for the rep) lands in Phase 3 (see phase-3-ai-ml).

**Acceptance:** a service advisor searches for a consumer, opens a single consumer-360 view showing vehicles, history, interactions, and consent state from the unified record, and sees only data within the dealer's tenant boundary — no re-aggregation across source tools.

**References:**
- Decided 2026-06-18 (Alicia + Luis): REST+GraphQL dual surface re-confirmed — GraphQL serves consumer-360, the surface this console reads — `memory/decisions.md#d-002`
- Decided 2026-06-21 (Leo): PostgreSQL RLS confirmed as tenant isolation; resolver above RLS, tenant-scoped serving — `memory/decisions.md#d-004`
- Decided 2026-06-19 (Alicia, Privacy-by-Design): consent first-class, typed + per-channel, read at send/serve time — the consent state the console surfaces — `memory/decisions.md#d-097`
- `docs/cdp-architecture.md` — Consumer 360 via Strawberry GraphQL over PostgreSQL+RLS, tenant-scoped serving
- `wiki/Data-Model.md` — the golden-record entities (vehicles, service history, contact points, consent) the 360 view renders
- `wiki/Identity-Resolution.md` — the resolved consumer the console looks up via the Phase-1 person-search (OpenSearch) surface
