---
title: "Opt-out suppression"
type: story
status: planned
priority: high
estimate: XL
depends_on: [phase-1-build.backend-data-model.consent-store]
labels: [backend, consent, suppression, 1a]
date: ~
---

A suppression service that computes effective suppression from consent state + explicit opt-outs (unsubscribe, DNC), most-restrictive-wins, at person/contact-point granularity. Enforced as a hard filter at the point of use — segmentation now, outbound activation in P2. On identity merge, suppression carries (most-restrictive); shared contact points suppress at contact-point level.

**Suppression scope (APPROVED 2026-06-19, Alicia):** hybrid model — regulatory opt-outs (DNC, TCPA, unsubscribe) are global across all tenants; dealer-specific opt-outs are tenant-scoped (one dealer's opt-out does not suppress another dealer). CCPA/GDPR deletion is always global, traversing all tenants via the identity graph.

**Acceptance:** an opted-out contact is excluded from the relevant channel's audiences; suppression survives identity merges (most-restrictive); regulatory opt-outs suppress globally, dealer-specific opt-outs suppress tenant-scoped.

**References:**
- Decided 2026-06-19 (Alicia, Privacy-by-Design): suppression scope is hybrid (Option C) — regulatory opt-outs (DNC, TCPA, unsubscribe) global, dealer-specific opt-outs tenant-scoped, shared contact points suppress at contact-point level on merge (most-restrictive-wins), CCPA/GDPR deletion global via identity graph — `memory/decisions.md#d-112`
- Decided 2026-06-13 (validated Dan + Mike): consent enforcement / opt-out suppression routed to the Privacy-by-Design deliverable — `memory/decisions.md`
- `wiki/Privacy-by-Design.md` — consent/suppression read at send time, not record-creation; most-restrictive provenance inheritance on merge
- `docs/deliverables/privacy-by-design-framework.md` — tenant-vs-global suppression scope; deletion traverses the identity graph
