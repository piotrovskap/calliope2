---
title: "Privacy policy configuration layer"
type: story
status: planned
priority: high
estimate: L
depends_on: [phase-1-build.backend-data-model.consent-store, phase-1-build.backend-data-model.tiered-data-lifecycle, phase-1-architecture.data-model.privacy-by-tenant]
labels: [backend, privacy, policy, config, admin, 1a]
date: ~
---

A configurable policy layer that maps privacy/data-handling policies to data, with deterministic resolution. We build the config layer + resolver + admin surface; **Alicia + Luis + DAS Legal populate the policy values** (raised 2026-06-21, Leo). See `wiki/Privacy-by-Design.md`.

## Why

Privacy knobs — PII hardening (salt+pepper on/off), retention/tiering schedule, suppression scope, per-source edge tokenization — are configurable at multiple scopes: **source / channel / partner / dealership / user**. A single record matches several scopes at once, so something must deterministically decide which policy wins. Without a resolver, policy-to-data mapping is ad hoc and drifts.

## Scopes & resolution

- **Scopes** (dimensions, not a strict hierarchy): regulatory floor (non-overridable), global default, partner, source, channel, dealership/tenant, consumer/user. A record carries a `(source, channel, partner, dealership, user)` tuple plus its data-category (PII class, GLBA-covered).
- **Resolution rule:** for protection/retention *obligations* (hardening, retention period, suppression), **most-restrictive-wins** with a non-overridable regulatory floor — a narrower scope can only increase protection / shorten retention, never weaken below a broader or statutory minimum. For non-obligation toggles, explicit per-scope setting with documented precedence (user > dealership > source > channel > partner > global).
- **Evaluation:** retention/erasure obligations resolve dynamically at decision time against the current policy table (avoids stale-stamp drift). At-rest hardening is applied at write; a later policy change re-applies via batch (the salt+pepper scheme marker supports flip-on/flip-off without schema change — see `08-...-pii-erasure` vault).

## Governs

- Salt+pepper hardening toggle (per-record, per-scope) and pepper scope (per-tenant default; configurable to global)
- Retention period + lifecycle tiering per source / core entity (coordinates with `11-tiered-data-lifecycle`)
- Suppression scope (per-tenant vs cross-tenant for shared third-party sources) (coordinates with `07-consent-store`, `09-opt-out-suppression`)
- Optional per-source edge tokenization (default off; on for high-sensitivity sources — see Ingest Tokenization in `wiki/Privacy-by-Design.md`)

## Admin surface

Operators define policies per scope, inspect the effective resolved policy for any record (which scope won and why), and override with audit. All policy changes versioned and audited.

## Acceptance

- Policy table + resolver returning a single effective policy for any record's scope tuple + data-category, with documented precedence and a non-overridable regulatory floor.
- Most-restrictive-wins demonstrated where scopes conflict (e.g. tenant says harden, source says plain -> harden wins).
- Hardening toggle flips on/off and re-applies via batch without schema change.
- Admin can view the effective policy and the winning scope for a sample record; all changes audited and versioned.
- Policy *values* are externally configurable (owned by Privacy-by-Design / Legal), not hard-coded.

**References:**
- Decided 2026-06-21 (Leo): policy-config layer needed — salt+pepper/retention/tiering/suppression/edge-tokenization configurable per source/channel/partner/dealership/user, deterministic resolution (most-restrictive-wins, non-overridable regulatory floor); we build layer+resolver+admin, Alicia+Luis+Legal populate values — `memory/decisions.md#d-012`
- Decided 2026-06-21 (Leo): pepper scope per-tenant by default, configurable to global — a setting resolved via the policy-config layer — `memory/decisions.md#d-012`
- Decided 2026-06-21 (Leo): per-source edge tokenization enablable via the policy-config layer for high-sensitivity sources; PII vault delete-the-row is the default erasure mechanism — `memory/decisions.md#d-012`
- Approved 2026-06-19 (Alicia): suppression scope hybrid (regulatory opt-outs global, dealer opt-outs tenant-scoped, contact-point most-restrictive-wins on merge); retention configurable, 30-day baseline — `memory/decisions.md#d-112`
- `wiki/Privacy-by-Design.md` — establishes the mechanisms (salt+pepper hardening, pepper-clear, edge tokenization boundary, suppression scope) that this layer makes configurable; states the policy values are owned by Alicia + Luis
