---
title: "Communications app"
type: story
status: planned
priority: medium
estimate: L
depends_on: [phase-1-build.backend-data-model.consent-store, phase-1-build.backend-data-model.graphql-surface]
labels: [phase-2, applications, communications, telephony, parity, 2b]
date: ~
---

The communications app over the unified, consent-gated record — replaces the dealer's outreach/telephony stack (Comms API, CallRevu, Twilio). Consent-aware multi-channel outreach (email/SMS/phone) plus call/text logging tied back to the golden record, so every interaction attaches to the resolved consumer instead of a per-tool contact silo.

**Scope:** send and receive across channels through the consumer's resolved contact points; gate every outbound communication on Phase-1 consent + channel state at send-time; log calls and texts as events against the golden record (who/when/channel/outcome) and read the consumer's interaction history through the golden-record (GraphQL) surface; tenant-scoped throughout.

**Acceptance:** an operator places a consent-gated call/text/email to a resolved consumer; consent + channel state are read at send-time and a send to an opted-out consumer or suppressed channel is blocked (regulatory opt-out global, dealer opt-out tenant-scoped); the interaction is logged as an event against that consumer's golden record (who/when/channel/outcome) with inbound calls/texts (Twilio status callbacks, webhooks) captured the same way; and prior communications are readable via the GraphQL consumer-360 surface within tenant/consent boundaries.

**References:**
- Decided 2026-06-17 (Dan, client): consent granularity is per channel/per app — `memory/decisions.md#d-095`
- Decided 2026-06-19 (Alicia, Privacy-by-Design): suppression scope hybrid — regulatory opt-outs (DNC/TCPA/unsubscribe) global, dealer opt-outs tenant-scoped, shared contact points suppress most-restrictive-wins — `memory/decisions.md#d-112`
- Decided 2026-06-18 (Alicia + Luis): REST+GraphQL dual surface — GraphQL for consumer-360 read — `memory/decisions.md#d-002`
- `wiki/Privacy-by-Design.md` — consent first-class, bitemporal, read at send/activation time; RLS per-tenant isolation
- `specs/03-phase-1-build/03-backend-data-model/07-consent-store.md` · `09-opt-out-suppression.md` — the consent/suppression store this app gates on
- `wiki/Twilio-API.md` · `wiki/CallRevu-API.md` — outbound activation + inbound webhook/status-callback event surfaces being replaced

**Subtasks:**
- Twilio outbound: send SMS/voice/email through resolved contact points, gated on send-time consent + channel state
- Twilio inbound: ingest delivery-status callbacks and inbound message/call webhooks as golden-record events
- CallRevu inbound: ingest call logging/outcome as events against the resolved consumer
- Comms API parity: cut over the dealer's existing outreach paths onto the unified consent-gated send path
