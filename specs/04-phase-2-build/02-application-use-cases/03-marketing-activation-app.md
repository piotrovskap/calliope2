---
title: "Marketing activation app"
type: story
status: planned
priority: medium
estimate: L
depends_on: [phase-2-build.activation-delivery.outbound-activation-connectors, phase-1-build.segmentation-engine.segment-retrieval-api]
labels: [phase-2, applications, marketing, activation, parity, 2b]
date: ~
---

The marketing application over the unified, consent-gated record — see the rationale catalog (`00-feature.md` §2). The app layer that drives campaigns, lifecycle/journey orchestration, personalization, and reputation, sending through the Phase-2 outbound activation connectors.

**Scope:** build segments from the Phase-1 golden record + signals; trigger campaigns on lifecycle events (lead, sale, service-complete, equity-threshold, lease-ending); every send checks consent + suppression at send-time (the differentiator — activation that can't leak opted-out consumers); offline-conversion (CAPI) feedback closes back into the event spine. The transport is the Phase-2 outbound connectors; this is the campaign/orchestration app on top.

**Acceptance:** an operator runs a consent- and suppression-aware campaign triggered by a lifecycle event, delivered through the outbound connectors, with conversions fed back — no opted-out consumer reached.

**References:**
- Decided 2026-06-19 (Alicia, Privacy-by-Design): suppression scope hybrid (Option C) — regulatory opt-outs (DNC/TCPA/unsubscribe) global, dealer opt-outs tenant-scoped, most-restrictive-wins on shared contact points — `memory/decisions.md#d-112`
- Decided 2026-06-19 (Alicia, Privacy-by-Design): consent taxonomy typed + per-channel (marketing/transactional/data-sharing), read at send time not at consumer-creation — `memory/decisions.md#d-097`
- `docs/deliverables/privacy-by-design-framework.md` · `wiki/Privacy-by-Design.md` — send-time consent + suppression enforcement, the activation differentiator
- `specs/04-phase-2-build/02-application-use-cases/00-feature.md` §2 — the marketing-activation rationale catalog (segmentation, lifecycle/journey, personalization, reputation, CAPI feedback)
- `specs/04-phase-2-build/03-activation-delivery/01-outbound-activation-connectors.md` — the Phase-2 outbound transport (Customer Match / CAPI, offline-conversion feedback into the event spine)
