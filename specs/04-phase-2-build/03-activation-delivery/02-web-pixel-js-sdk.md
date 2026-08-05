---
title: "Website pixel / JS SDK"
type: story
status: planned
priority: medium
estimate: L
depends_on: [phase-1-build.ingest.cloudevents-contract, phase-1-build.ingest.event-grid-webhook-adapter]
labels: [phase-2, activation, sdk, web-events, net-new, 2a]
date: ~
---

A first-party website pixel / JavaScript SDK that captures dealer-site web events (page/VDP views, form submits, identity hints) and emits them into the **Phase-1 event intake** as CloudEvents (`cloudevents-contract`, via the webhook adapter). The intake, contract, and normalization are Phase-1 infrastructure; this is the browser-side collector and its mapping to the canonical event schema.

**Scope:**
- Lightweight JS SDK / pixel: page + VDP view, form-submit, and identity-hint capture (hashed email/phone where consented); tenant/site keyed.
- Emit canonical CloudEvents into the Phase-1 intake; consent-banner integration so collection respects opt-out at the source.
- Identity hints feed the Phase-1 resolution engine like any other source — no bespoke pipeline.

**Acceptance:** a dealer site embeds the tenant/site-keyed SDK; a page/VDP view and a form-submit each emit a valid CloudEvents 1.0 payload that the Phase-1 webhook adapter accepts, normalizes, and resolves to a consumer record (identity hints land in the resolution engine); with consent absent the SDK fires no collection request (verified at the network layer); identity hints are emitted hashed, never as raw email/phone.

**References:**
- Decided 2026-06-12 (Dan Aston / CONFLICT): bus-agnostic generic event intake, one shared validate→normalize→resolve pipeline so sources graduate batch→events without a bespoke pipeline — `memory/decisions.md#d-045`
- Decided 2026-06-13 (Leo, Phase 0 arch — Option A): DAS/source-emitted events use CloudEvents 1.0 — `memory/decisions.md`
- Decided 2026-06-21 (Leo): ingest tokenization boundary — the ingest edge carries fragmented single-vector views; tokenize on ingest into the CDP, no tokenization barrier in front of event processing — `memory/decisions.md`
- Decided 2026-06-17 (Dan Aston / Alicia): consent is per channel/app and source-record-granular; collection/suppression honored at source — `memory/decisions.md#d-095`
- `wiki/Privacy-by-Design.md` — ingest-edge zone holds raw fragmented web feeds (retention-bounded, no per-request delete); source-record-granular consent provenance
- `wiki/Ingestion-Channels.md` — bus-agnostic intake, CloudEvents 1.0 contract + idempotency this SDK emits into
