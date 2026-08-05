---
title: "Lead handling app"
type: story
status: planned
priority: medium
estimate: L
depends_on: [phase-1-build.ingest.event-grid-webhook-adapter, phase-1-build.backend-data-model.graphql-surface, phase-1-build.identity-resolution-engine.identity-record-event-sourcing]
labels: [phase-2, applications, leads, routing, parity, 2b]
date: ~
---

The lead-handling app over the CDP — replaces the dealer's Acceptor lead workflow. Lead intake itself is Phase-1 event ingest (leads land via the Event Grid webhook adapter like any other source); this app does dedupe, enrich, route, and assign on top of the resolved record rather than treating each lead as a fresh, unresolved row.

**Scope:** consume leads from the Phase-1 intake, dedupe and enrich them against the resolved golden record (existing consumer? prior vehicles, service history, prior leads?), and apply rule-based routing/assignment (round-robin, territory, source, store) to the right rep; read enriched lead context through the golden-record (GraphQL) surface; tenant-scoped throughout. Routing is deterministic in P2 (rules over resolved attributes); the ML enhancement (lead/intent scoring to prioritize and route by propensity) lands in Phase 3 (see phase-3-ai-ml).

**Acceptance:** a lead arriving through the Phase-1 intake is deduped and enriched against the resolved consumer record and routed/assigned by rule to a rep, with full lead context read from the golden record — not a point solution re-solving identity per lead.

**References:**
- Decided 2026-06-12 (Dan Aston): Acceptor leads publish to Azure Event Grid (CloudEvents 1.0); CDP subscribes and captures raw at point of consumption — lead intake rides the shared event channel, not a per-lead point solution — `memory/decisions.md#d-045`
- Decided 2026-06-18 (Alicia + Luis): REST+GraphQL dual surface re-confirmed — GraphQL for consumer-360, the surface this app reads enriched lead context through — `memory/decisions.md#d-002`
- `docs/cdp-architecture.md` — Acceptor leads (plus Inventory/Comms/Survey/Reputation) publish to Event Grid as CloudEvents 1.0; CDP subscribes via config-only adapter
- `wiki/Identity-Resolution.md` — lead-to-purchase identity gap (throwaway lead-form email, real email at transaction), DMS as ground truth, lead data retained for intent signals not discarded
