---
title: "Tiered data lifecycle & storage policy"
type: story
status: planned
priority: high
estimate: XXL
depends_on: [phase-1-build.backend-data-model.data-model-foundation, phase-1-architecture.data-model.privacy-by-tenant, phase-1-build.backend-data-model.consent-store, phase-1-build.backend-data-model.pii-vault-erasure]
labels: [backend, data-lifecycle, storage, privacy, admin, 1a]
date: ~
---

Policy-driven data lifecycle that moves records across storage tiers — **active records** (hot/serving) + **dehydrated raw** (reduced form, kept hot for a configurable window ~1-N months so it stays queryable/processable) -> **compress** -> **archival / cold** (lower-tier storage) -> **erasure** — with transitions governed by retention/lifecycle policy set **per source and per core entity** (2026-06-17 client decision; DAS has no existing standard, so the CDP defines it). Rides on the bitemporal store-everything model: tiering relocates cold data to cheaper storage (S3 IA/Glacier or Blob Cool/Archive, dropped hot indexes, reduced "dehydrated" payloads) without losing bitemporal history. Terminal hard-delete is vault-row deletion (`08-pii-vault-erasure`); the soft/old-store retention window (30-day baseline, configurable) precedes it.

**Primary driver: scalability + cost.** Keeping fully-hydrated raw source material on hot storage does not scale — the store-everything stance only works if aged data ages *down* to cheaper tiers. Tiering is the mechanism that makes raw-first + store-everything affordable at volume. **Deletion/retention policies are definable per tier** (e.g. expire raw bronze after N days while keeping the derived canonical record), not only at terminal erasure. **Compression is an explicit lifecycle step:** dehydrated raw stays on hot storage for the configured window (~1-N months) for ingest/processing, then is compressed and tiered down (raw -> ingest -> compress -> process).

**Admin wiring (the management surface):** operators must be able to define/edit tier and retention policies per source/core-entity, inspect a record's current tier + lineage, and trigger or override tier transitions and erasure — every action audited (ties to `10-erasure-consent-audit`). Consent withdrawal and per-channel/per-source-record suppression (`07-consent-store`, `09-opt-out-suppression`) feed lifecycle transitions.

**Acceptance:** lifecycle/retention policy is configurable per source and per core entity; records transition across active/raw/archival/dehydrated tiers by policy; cold data lands on lower-cost storage without breaking bitemporal history or non-PII aggregates; an admin surface lets operators view, manage, and override tiers and trigger erasure; all transitions are audited.

**References:**
- Decided 2026-06-17 (Dan, client): tiered data lifecycle (active -> raw -> archival -> dehydrated -> erasure), policy-driven per source and per core entity; primary driver scalability + cost; DAS has no existing standard so the CDP defines it — `memory/decisions.md#d-094`
- Decided 2026-06-18 (Leo): dehydration mechanism — append-only/observation tables range-partitioned by time, old partitions detach + archive to cold object storage, re-hydrate on demand — `memory/decisions.md#d-009`
- Decided 2026-06-18 (Leo): raw/staging buffer is bronze parquet in object storage; dehydration runs from there (raw -> ingest -> compress -> process) — `memory/decisions.md#d-008`
- Decided 2026-06-19 (Alicia): retention window configurable, 30-day baseline, never hardcoded — `memory/decisions.md#d-096`
- Decided 2026-06-21 (Leo): policy-config layer + resolver resolves per source/channel/partner/dealer/user, most-restrictive-wins for retention/tiering — `memory/decisions.md#d-012`
- `docs/cdp-architecture.md` · `wiki/Privacy-by-Design.md` — data-lifecycle (partition + rotate to cold) and the bounded-retention / age-out deletion posture
- `docs/consent-pii-erasure-options.md` — tier/erasure mechanism options + cost notes

Tier/erasure mechanism options + cost notes: `docs/consent-pii-erasure-options.md`.
