---
title: "Embeddable widgets"
type: story
status: planned
priority: medium
estimate: M
depends_on: [phase-1-build.backend-data-model.graphql-surface]
labels: [phase-2, data-exposure, widgets, embeddable, net-new, 2a]
date: ~
---

Golden-record-backed embeddable components for dealer websites — drop-in surfaces (equity / trade-in, service-due) that render a consumer's own data from the CDP on the dealer's site, consent- and tenant-scoped. The embeddable half of data exposure: the unified record surfaced where the consumer already is, rather than a static on-site form.

**Scope:** ship embeddable widgets (e.g. equity/trade-in estimate, service-due reminder) that resolve the consumer to their golden record and render their data through the golden-record (GraphQL) surface; every widget is consent-aware (shows/acts only within the consumer's consent + channel state) and tenant-scoped to the embedding dealer; the consumer is linked to their record via an identifier upgraded on a known login/session, consistent with the orphan-identifier handling. Data-out only — no writeback to legacy systems.

**Acceptance:** a dealer embeds a widget on its site that renders a resolved consumer's equity/service-due data from the golden record, gated by consent and scoped to that dealer's tenant — no cross-tenant data and no opted-out consumer surfaced.

**References:**
- Decided 2026-06-18 (Alicia + Luis): GraphQL is the consumer-360 surface; REST for ingestion/ops — the golden-record read path widgets render from — `memory/decisions.md#d-002`
- Decided 2026-06-19 (Alicia, Privacy-by-Design): consent is first-class and read at access time, per-channel + typed; suppression scope is hybrid (regulatory global, dealer opt-outs tenant-scoped) — what gates each widget — `memory/decisions.md#d-112`
- Decided 2026-06-17 (Luis + Alicia): orphan identifiers stored unresolved, upgraded to a deterministic/heuristic link on a later event carrying the orphan ID alongside a linkable key — the consumer-to-record resolution on known login — `memory/decisions.md#d-104`
- Decided 2026-06-21 (Leo): PostgreSQL RLS is the confirmed multi-tenant isolation mechanism (tenant context via `app.current_tenant`) — the per-dealer tenant scoping — `memory/decisions.md#d-004`
- `wiki/Privacy-by-Design.md` — consent enforcement, suppression scope, tenant isolation model
- `wiki/Identity-Resolution.md` — orphan-identifier upgrade and consumer resolution
