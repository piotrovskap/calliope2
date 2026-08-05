---
title: "Person search (OpenSearch)"
type: story
status: planned
priority: high
estimate: XXL
depends_on: [phase-1-build.backend-data-model.org-tenancy-data]
labels: [backend, search, opensearch, 1a]
date: ~
---

OpenSearch-backed fuzzy person search baked into the stack — an index pipeline kept in sync from the canonical model, plus a tenant-scoped search API (role- and dealer-scoped). Query logging captured for eval and data-quality signals. Powers the web-UI search surface and the curation lookups.

**Acceptance:** fuzzy search returns ranked matches against name/contact-point/address and never surfaces a person outside the caller's dealer scope; a canonical-model change is reflected in the index within the pipeline's sync window; every query is logged with its scope for eval and data-quality signals.

**References:**
- Decided 2026-06-13 (Leo, Phase 0 architecture recommendation): OpenSearch = fuzzy person search + query logging (Phase 1, not deferred) — `memory/decisions.md#d-069`
- Ingest tokenization boundary 2026-06-21 (Leo): search stores tokens + non-PII provenance only, never raw PII — `memory/decisions.md`
- `docs/cdp-architecture.md` · `wiki/Tech-Stack.md` — OpenSearch as the self-hosted search tier (portable OSS core)
- `docs/cdp-reference-topology.md` — canonical Postgres changes sync to OpenSearch; Django serves Postgres (RLS, tenant-scoped) + OpenSearch
- `wiki/Privacy-by-Design.md` — RLS tenant isolation and the PII vault / token model the index must honor
