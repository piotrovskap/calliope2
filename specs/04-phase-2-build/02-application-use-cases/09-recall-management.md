---
title: "Recall management app"
type: story
status: planned
priority: medium
estimate: M
depends_on: [phase-1-build.backend-data-model.graphql-surface, phase-1-build.backend-data-model.consent-store]
labels: [phase-2, applications, recalls, service, parity, 2b]
date: ~
---

The recall app over the unified, consent-gated record — replaces the dealer's RecallMasters surface. Detects open recalls against the resolved consumer's vehicles and drives recall outreach campaigns, so the dealer reaches the right owner of an affected VIN instead of working from a disconnected recall list.

**Scope:** detect open recalls by deterministic VIN match between the consumer's vehicles on the golden record and the recall feed; build recall-outreach campaigns to affected owners, consent-gated on Phase-1 consent + channel state; read affected-vehicle and owner context through the golden-record (GraphQL) surface; tenant-scoped throughout. Detection is a deterministic VIN match — no scoring, no inference.

**Acceptance:** an open recall is matched to the resolved owner of the affected VIN and a consent-gated recall outreach reaches that owner, computed from the unified vehicle+owner record within tenant/consent boundaries — no opted-out consumer reached.

**References:**
- Decided 2026-06-19 (Alicia, Field Catalog v1 lock): `OpenRecallsByVIN` (#17) is interesting-later / Phase 2 via RecallMasters, a new vendor integration — `memory/decisions.md#d-010`
- Decided 2026-06-19 (Alicia, Privacy-by-Design): consent first-class + hybrid suppression scope (regulatory opt-outs global, dealer opt-outs tenant-scoped), read at send time — `memory/decisions.md#d-112`
- Decided 2026-06-17 (Luis + Alicia): identity Option A deterministic waterfall (email → phone → VIN → dealer customer ID) — `memory/decisions.md#d-104`
- `wiki/Recall-Masters-API.md` · `docs/cdp-field-source-matrix.md` (#17 OpenRecallsByVIN) — RecallMasters as the VIN-keyed recall source; no consumer PII in the lookup
- `docs/deliverables/privacy-by-design-framework.md` — consent/suppression enforcement gating outreach
