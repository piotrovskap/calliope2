---
title: "Applications on the CDP"
type: feature
status: planned
priority: medium
labels: [phase-2, applications, use-cases]
date: ~
---

The **applications that build on top of the Phase-1 CDP** (the application layer over the golden record). These validate the CDP's purpose: every app consumes the unified record/events/consent instead of re-solving identity and aggregation from scratch (objective 1). The flagship/known apps are pulled out as milestone stories (children of this feature) — enough to show the application layer is thought through, not an exhaustive roadmap. The rest of this file remains the running rationale catalog; each app names the CDP data + signals it consumes so we can confirm the Phase-1 record/contract covers it.

**Phase 2 application milestones (child stories):** VSS retool (flagship/proof case), maintenance & service (CarPlay/mobile), marketing activation, consumer/dealer mobile, data-enrichment tools, reputation management, lead handling, communications, recall management, and service/support console — representative scope, not a committed schedule. Additional apps log into the catalog below as they surface.

**Tagging:** every Phase-2 story is labeled `parity` (replaces/matches an existing DAS system — e.g. VSS, Juicebox, reputation, lead routing) or `net-new` (a new capability the CDP unlocks). The apps ship **deterministic/rule-based cores in Phase 2**; their ML angle (scoring, sentiment, next-best-action, personalization, lookalike) lands in **Phase 3** (`specs/05-phase-3-ai-ml`), trained on clean Phase-2 data.

## 1. Maintenance Cycle Tracker / Service Upseller

**What:** Tracks each consumer's vehicle maintenance cycle and proactively surfaces due/overdue services and the right upsell — with an in-vehicle (CarPlay) surface for reminders/offers alongside the usual email/SMS.

**CDP data consumed (all already in the golden record / on the roadmap):**
- `vehicle` — VIN, year/make/model, mileage; `consumer_vehicle` ownership edge.
- Service-history events — RO number/amount, completed + **declined services**, last-service date, mileage-at-service.
- OEM maintenance schedule + service intervals (DataOne, pending access) — to compute "what's due."
- Equity / valuation (BlackBook) — for the trade-in-vs-repair upsell decision.
- Consent + channel state — to gate outreach (and pick the channel: CarPlay / SMS / email).
- Contact points + identity resolution — reach the *right person* across DMS/CRM.

**Signals it uses (derived consumer_attributes):**
- `service_due` (mileage + interval + last-service) · `declined_service_followup` · `equity_positive` (trade-up trigger).

**Why it needs the CDP:** the value is the *cross-source unified vehicle+owner record* with consent-gated outreach — exactly what's hard without identity resolution + a golden record. A point solution can't see service history + OEM schedule + equity + consent together.

**CarPlay angle:** in-vehicle reminders/offers as a first-party surface (high-intent, high-trust); needs a device/session link to the consumer (orphan identifier upgraded on a known trip/login).

---

## 2. Marketing applications (activation layer)

The classic CDP payoff — marketing built on the unified, consent-gated record instead of siloed lists. A family of related apps:

**a. Audience builder / segmentation → activation.** Build segments from the golden record + signals (in-market, equity-positive, lapsed-service, recent-buyer, lookalike seeds) and push to ad platforms via **Customer Match** (CDP-minted SHA-256 `hashed_email_for_ads`/`hashed_phone_for_ads`), plus email/SMS. Consumes: `person`, contact points, attributes/signals, `audience_segment` membership.

**b. Consent- & suppression-aware campaigns.** Every send checks consent (per channel/tenant, send-time) + suppression (recent-buyer 90-day, opt-out, hard-bounce). Consumes: `consent`, `suppression`, `consent_event`. This is the differentiator — activation that can't leak opted-out consumers.

**c. Lifecycle / journey orchestration.** Trigger campaigns on lifecycle `event`s — lead received, sale closed, service completed, equity crossed a threshold, lease ending. Consumes: `event` time spine + derived signals.

**d. Personalization & dynamic offers.** Use signals (`vehicle_of_interest`, `buyer_intent_score`, equity) to tailor creative/offer per consumer. Consumes: signals (derived consumer_attributes).

**e. Reputation / ReviewSurge.** Trigger review requests post-service to high-CSAT consumers; route detractors to service recovery. Consumes: service events + survey/NPS signals + `dealer_reputation`.

**Why they need the CDP:** identity resolution (reach the *person*, dedup across sources), consent enforcement (legal/defensible activation), and the unified record + signals as the single segmentation surface. Ties directly to objective 2 ("good for AI and regular/agentic lifecycle events") and the offline-conversion (CAPI) feedback loop already modeled.

---

## 3. Vehicle Smart Score (VSS) retool — the flagship / proof case

**What:** VSS is DAS's existing scoring app and the application the engagement is *named against* — bootstrap: "every downstream application (including the Vehicle Smart Score) solves the same identity and data aggregation problem from scratch." Today it re-aggregates consumer+vehicle data and re-solves identity itself. **Retool:** rebuild VSS to consume the **golden record** (the "VSS-ready consumer record" is an explicit Phase-1 goal) instead of from-scratch aggregation.

**CDP data consumed:** essentially the whole golden record — the **Field Catalog v1 (the 27 fields) came directly from the VSS data mapping** (`vss-data-mapping`), so VSS consumes vehicle (VIN/year/make/model/mileage/condition), owner (name/email/phone/address), service history, equity/valuation. The CDP is the superset of what VSS already needs.

**What the retool gains (over today):**
- Fields VSS marks "none / unsupported" that the CDP now supplies — `CompletedServices`, `DeclinedServices`, recalls, equity freshness.
- One **resolved** consumer across DMS/CRM/sources instead of per-app identity re-solve.
- Consent-gated, tenant-scoped, and **event-driven** (VSS already publishes via Event Grid behind Kong — the CDP's bus-agnostic intake plugs straight in).

**Why it's the proof case:** retooling VSS on the CDP is the cleanest demonstration of objective 1 (CDP becomes the source of truth; the from-scratch aggregation dies). It's also the lowest-risk first Phase-2 app — the data contract is already known (its own field mapping seeded ours).

---

## How to add a use case
Append a section: **What**, **CDP data consumed** (map to golden-record entities/fields), **Signals**, **Why it needs the CDP**, and any net-new data the CDP would have to capture (feeds the Phase-1 field/source backlog). Keep it light — these are candidates, not committed stories, until pulled into a Phase-2 build feature.
