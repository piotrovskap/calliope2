---
title: "Reputation management app"
type: story
status: planned
priority: medium
estimate: L
depends_on: [phase-1-build.backend-data-model.graphql-surface, phase-1-build.backend-data-model.consent-store]
labels: [phase-2, applications, reputation, reviews, parity, 2b]
date: ~
---

The reputation app over the unified, consent-gated record — the "ReviewSurge" surface in the rationale catalog (`00-feature.md` §2e). Replaces the dealer's third-party reputation stack (DealerRater, Vendasta, Soci) by driving review-request campaigns from the golden record instead of a siloed list, with reputation dashboards and detractor routing.

**Scope:** trigger post-service review-request campaigns to high-CSAT consumers off the Phase-1 service events + survey/NPS signals; gate every request on Phase-1 consent + channel state; route detractors into service-recovery workflows; surface per-dealer reputation dashboards over the resolved record, tenant-scoped. Triggers and routing are deterministic in P2 (CSAT threshold, service-complete event, rule-based detractor routing); the ML enhancement (review sentiment classification of free-text feedback) lands in Phase 3 (see phase-3-ai-ml).

**Acceptance:** an operator runs a consent-gated review-request campaign triggered by a service-complete event to consumers above a CSAT threshold, detractors route to service recovery, and the dealer reputation dashboard renders from the unified record within tenant/consent boundaries — no opted-out consumer reached.

**References:**
- Decided 2026-06-12 (Dan Aston, client-confirmed): Reputation data in scope as an app-level source — replaces the dealer's third-party reputation stack — `memory/decisions.md`
- Decided 2026-06-19 (Alicia Salazar, Privacy-by-Design): suppression scope hybrid — regulatory opt-outs (DNC/TCPA/unsubscribe) global, dealer opt-outs tenant-scoped — gates the per-dealer review-request audience — `memory/decisions.md#d-112`
- Consent read at send time, typed + per-channel (2026-06-17 client decision) — every review request checks live consent + channel state — `memory/decisions.md`, `wiki/Identity-Resolution.md` §Consent & Channel State
- Decided 2026-06-21 (Leo): PostgreSQL RLS confirmed as tenant isolation — the per-dealer dashboard renders tenant-scoped — `memory/decisions.md#d-004`
- `wiki/Privacy-by-Design.md` — consent/suppression enforcement read at send time
- `wiki/Data-Model.md` — `dealer_reputation` entity over the resolved record
- `specs/04-phase-2-build/02-application-use-cases/00-feature.md` §2e — Reputation / ReviewSurge rationale catalog
