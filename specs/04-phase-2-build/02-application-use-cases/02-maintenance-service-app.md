---
title: "Maintenance & service app (CarPlay / mobile)"
type: story
status: planned
priority: medium
estimate: L
depends_on: [phase-1-build.backend-data-model.graphql-surface, phase-1-build.backend-data-model.consent-store]
labels: [phase-2, applications, carplay, mobile, service, net-new, 2b]
date: ~
---

The Maintenance Cycle Tracker / Service Upseller as a dealer-facing app on the CDP — see the rationale catalog (`00-feature.md` §1). Tracks each consumer's vehicle maintenance cycle and surfaces due/overdue services and the right upsell, with an in-vehicle **CarPlay** surface and a mobile surface alongside email/SMS.

**Scope:** consume the Phase-1 golden record (vehicle, ownership, service-history events, OEM schedule where available, equity/valuation) and the derived signals (`service_due`, `declined_service_followup`, `equity_positive`); gate outreach on Phase-1 consent + channel state; CarPlay/mobile surface needs a device/session link to the consumer (orphan identifier upgraded on a known trip/login).

**Acceptance:** given a resolved consumer with vehicle + service-history facts, the app computes `service_due` from mileage + interval + last-service and surfaces the due/overdue list plus the matching upsell on CarPlay and mobile; the surface reads consent + channel state at render/send time and suppresses any channel the consumer has not opted into; the record is read from the unified golden record (no re-aggregation of sources in the app); a CarPlay/mobile session presenting an orphan device identifier resolves to the consumer on a known trip/login before any consumer-specific content is shown.

**References:**
- No app-specific governing decision — net-new in this plan (catalog rationale: `specs/04-phase-2-build/02-application-use-cases/00-feature.md` §1).
- Field Catalog v1 — LOCKED 2026-06-19 (Alicia Salazar): declined services, OEM maintenance schedule, and equity/valuation are Phase-2 "interesting-later" — `memory/decisions.md`, `docs/cdp-field-source-matrix.md`
- Consent read at send time, typed + per-channel (2026-06-17 client decision) — `memory/decisions.md`, `wiki/Identity-Resolution.md` §Consent & Channel State
- Orphan identifiers stored and upgraded on a later linkable event (2026-06-17) — `memory/decisions.md`, `wiki/Identity-Resolution.md` §Orphan Identifier Handling
