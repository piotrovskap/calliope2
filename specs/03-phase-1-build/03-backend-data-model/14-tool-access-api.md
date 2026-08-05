---
title: "Governed access API for tools (transport-agnostic)"
type: story
status: planned
priority: medium
estimate: L
depends_on: [phase-1-build.backend-data-model.graphql-surface, phase-1-build.backend-data-model.rest-surface, phase-1-build.backend-data-model.consent-store]
labels: [backend, api, ai-readiness, agentic, consent, 1b]
date: ~
---

One **governed capability contract** over the golden record — typed, auth-scoped, consent-aware operations like `get_person`, `resolve_identity`, `query_events`, `search_people` — defined once and exposable through **multiple transports**: a CLI, an MCP server, and a direct API client all wrap the same contract. We do **not** couple to MCP (or any single protocol); the contract is the source of truth and transports are thin adapters over it. Agents and tools call governed functions, not raw SQL.

**Scope:**
- A declarative capability/tool contract (typed inputs/outputs, described against the semantic glossary) generated from / aligned with the GraphQL + REST serving surfaces — not a third hand-maintained surface.
- Thin transport adapters: CLI, MCP server, HTTP API client — each generated from the one contract so they never drift.
- **Every operation is auth-scoped per role/tenant and consent-gated**: suppression/opt-out and tenant isolation are enforced inside the contract, so no transport can bypass them. Reads honor consent state; an opted-out person's data is not returned to an agent.
- Each operation is self-describing (purpose, params, returns) so an agent discovers and invokes tools from the contract alone.

**Acceptance:** a single capability contract exposes the golden-record operations; CLI, MCP, and API-client transports are generated from it and behave identically; every operation enforces tenant isolation + consent/suppression server-side regardless of transport; an agent can enumerate and call the operations from the contract's self-description without bespoke integration.

**References:**
- Decided 2026-06-13 (Dan + Mike): AI/agentic-readiness + reuse DAS AI layer (`ai.das-technology.com`) routed to the architecture narrative; exec direction — CDP must be "good for AI and good for regular application lifecycle events, or agentic events" — `memory/decisions.md#d-039`
- Decided 2026-06-18 (Alicia + Luis): REST (ingestion/ops) + GraphQL (consumer-360) dual serving surface re-confirmed — this contract aligns with those surfaces, not a third hand-maintained one — `memory/decisions.md#d-002`
- Decided 2026-06-19 (Alicia, Privacy-by-Design): suppression scope hybrid (regulatory opt-outs global, dealer opt-outs tenant-scoped) — the consent/suppression gate enforced inside the contract — `memory/decisions.md#d-112`
- Decided 2026-06-21 (Leo): PostgreSQL RLS is the confirmed multi-tenant isolation mechanism — tenant scoping the contract enforces server-side — `memory/decisions.md#d-004`
- `docs/deliverables/detailed-phase-1-2-plans.md` — establishes the governed access API as the Phase-1 serving foundation for Phase-2/3a external-AI and agentic surfaces
- `specs/03-phase-1-build/03-backend-data-model/12-ai-context-schema-conventions.md` — the AI-readiness anchor this story (multi-transport governed access) completes alongside the glossary/embedding/event-contract siblings
