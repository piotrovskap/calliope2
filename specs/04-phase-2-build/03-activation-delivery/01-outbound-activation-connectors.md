---
title: "Outbound activation connectors"
type: story
status: planned
priority: medium
estimate: XL
depends_on: [phase-1-build.ingest.nats-event-backbone, phase-1-build.segmentation-engine.segment-retrieval-api]
labels: [phase-2, activation, outbound, connectors, net-new, 2a]
date: ~
---

Per-destination connectors that push audiences and events outbound — Meta, TikTok, email ESP, and CRM — over the **NATS outbound backbone built in Phase 1** (`nats-event-backbone`). The segments, the backbone, and the consent/suppression engine are Phase-1 infrastructure; this story builds the connectors and the activation orchestration on top.

**Scope:**
- Connectors subscribing to Phase-1 NATS outbound subjects: Meta (Conversions / Customer Match using the CDP-minted `hashed_email_for_ads` / `hashed_phone_for_ads`), TikTok, email ESP, CRM.
- Activation orchestration: take a segment from the Phase-1 retrieval API, enforce consent + suppression at dispatch, deliver to selected destinations with per-connector auth/config, retry, and delivery status.
- Tenant-scoped throughout; offline-conversion (CAPI) feedback loop closes back into the event spine.

**Acceptance:** an operator activates a saved segment to one or more external destinations; members resolve consent-aware via the Phase-1 retrieval API and deliver over the Phase-1 NATS backbone with per-connector status and retry — no new transport infrastructure.

**References:**
- Decided 2026-06-13 (restated 2026-06-21): consent first-class — channel-level state authoritative, read at send time (not creation time), suppression + GLBA scope tracked alongside; activation enforces at dispatch — `memory/decisions.md#d-111`
- Decided 2026-06-17 (Leo): messaging split — NATS JetStream = event-stream backbone/replay; this story reuses it as the outbound transport, no new infra — `memory/decisions.md#d-091`
- Decided 2026-06-21 (Leo): resolver blocking-key boundary — pseudonymous ads hashes (`hashed_email_for_ads`/`hashed_phone_for_ads`) minted by the CDP for Customer Match/CAPI — `memory/decisions.md#d-117`
- `wiki/Meta-Facebook-Marketing-API.md` · `wiki/TikTok-Ads-API.md` — Meta Conversions API / Customer Match and TikTok Events API as activation destinations (server-side, SHA-256-hashed PII)
- `wiki/Privacy-by-Design.md` · `wiki/Identity-Resolution.md` — consent/suppression authoritative before activation, read at send time; activation targets consumer or household layer
- `docs/deliverables/detailed-phase-1-2-plans.md` — Phase 2 Activation & Delivery: outbound connectors over the Phase-1 NATS backbone

**Subtasks:**
- Meta connector — Conversions API + Customer Match, CDP-minted hashed PII
- TikTok connector — Events API (offline conversions) + Custom Audiences, hashed PII
- Email ESP connector — audience + event delivery, suppression-aware
- CRM connector — outbound audience/event sync, per-connector auth/config
- CAPI offline-conversion feedback loop — closes delivery/conversion outcomes back into the event spine
