---
title: "Search UI (OpenSearch)"
type: story
status: planned
priority: high
estimate: XL
depends_on: [phase-1-build.backend-data-model.person-search-opensearch, phase-1-build.frontend.app-exposure]
labels: [frontend, search, opensearch, 1a]
date: ~
---

The search surface in the web UI — a fuzzy person-search box and ranked results over the OpenSearch person-search API, with drill-through into the Golden Record. Role- and tenant-scoped exposure; doubles as the entry point for curation lookups.

**Acceptance:** an operator searches and opens a person from the results, scoped to their access; no cross-tenant results leak.

**References:**
- Decided 2026-06-13 (Leo, Phase 0 arch recommendation): OpenSearch = fuzzy person search + query logging, Phase 1, not deferred — `memory/decisions.md#d-069`
- `docs/cdp-architecture.md` · `docs/cdp-reference-topology.md` — canonical model syncs to OpenSearch for fuzzy person search; Django GraphQL/REST serves Postgres (RLS, tenant-scoped) + OpenSearch behind the Next.js UI
- `wiki/Tech-Stack.md` — OpenSearch (self-hosted) as the search tier
- `wiki/Frontend.md` — Consumer 360 / Golden Record Explorer surface and the identity conflict review (curation) queue this search feeds
