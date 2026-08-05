---
title: "Inventory syndication feeds"
type: story
status: planned
priority: medium
estimate: L
depends_on: [phase-1-build.ingest.source-registry, phase-1-build.backend-data-model.graphql-surface]
labels: [phase-2, data-exposure, syndication, inventory, parity, 2a]
date: ~
---

Expose unified dealer + inventory data as outbound syndication feeds to publishers — replaces the dealer's feed stack (Feedhub, OutboundFeeds). Publish per-dealer inventory to the major marketplaces (Cars.com, CarGurus, Craigslist, Facebook Marketplace, eBay) from the CDP's unified data over the Phase-1 surfaces, instead of a separate feed engine per publisher.

**Scope:** assemble per-publisher feeds from the unified dealer + inventory data read over the golden-record (GraphQL) surface; format and deliver to each publisher's required feed spec/cadence; manage publisher destinations as sources/targets in the Phase-1 config-driven source registry rather than bespoke per-publisher pipelines; tenant-scoped so a feed carries only that dealer's inventory. Data-out only — consistent with the data-exposure stance, no reverse-ETL/writeback to legacy systems.

**Acceptance:** for a configured dealer, each enabled publisher receives a feed containing only that dealer's inventory, in that publisher's required format, on its required cadence, assembled from the golden-record (GraphQL) surface and delivered to the publisher's endpoint; publisher destinations are declared in the config-driven source registry (no per-publisher feed engine outside the CDP); a delivery is observable (success/failure logged per publisher) and a feed for dealer A never contains dealer B's inventory.

**References:**
- Decided 2026-06-13 (Leo, Phase 0 architecture recommendation): config-driven source registry for source/destination onboarding — `memory/decisions.md`
- Re-confirmed 2026-06-18 (Alicia + Luis): GraphQL consumer-360 surface as the read surface for unified data — `memory/decisions.md#d-002`
- `specs/04-phase-2-build/05-data-exposure/00-feature.md` — data-out only, no reverse-ETL/writeback to legacy systems (CDP replaces the feed stack, does not feed it)
- `docs/source-onboarding-ledger.md` — publishers (Cars.com, CarGurus, eBay, Meta/Facebook, LotVantage) onboarded as inbound in Phase 1; outbound syndication push scoped to Phase 2

**Subtasks:**
- Cars.com — outbound inventory feed (format + cadence)
- CarGurus — outbound inventory feed (format + cadence)
- Craigslist — outbound inventory feed (format + cadence)
- Facebook Marketplace — outbound inventory feed (format + cadence)
- eBay — outbound inventory feed (format + cadence)
