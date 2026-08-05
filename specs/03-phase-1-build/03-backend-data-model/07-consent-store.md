---
title: "Consent store"
type: story
status: planned
priority: high
estimate: XL
depends_on: [phase-1-build.backend-data-model.data-model-foundation, phase-1-architecture.data-model.privacy-by-tenant]
labels: [backend, consent, privacy, 1a]
date: ~
---

Record consent per person x channel (email/SMS/phone/mail) x tenant — bitemporal and provenance-bearing (who/what captured it, when, lawful basis) so "did we have consent at time T" is answerable. The consent taxonomy, lawful basis, and retention policy are owned by the Privacy-by-Design design (Alicia + Luis); this builds the store and its write/query path.

**Granularity (per 2026-06-17 client decision — deletion/withdrawal is per channel/app, NOT whole-record):** consent and suppression must resolve to the **source and source-record** level. Every record ingested from a source carries a consent/provenance linkage (which source/channel it came from, under what consent), so a withdrawal or delete arriving via one channel removes exactly that source's data for the person and leaves other channels intact. This rides on the ingestion-time provenance classification already required: the consent store keys on (person, channel/source, tenant) and joins to per-source-record provenance for record-level suppression and vault erasure (delete-the-row).

**Retention & taxonomy (2026-06-17 client decisions):** the soft-delete/old-store stage before hard delete holds for a **configurable** retention period — **30-day baseline**, tunable later; config-driven, not hardcoded (erasure orchestration in `08-pii-vault-erasure` / `10-erasure-consent-audit` honors it — the vault-row delete). DAS distinguishes consent **types** (marketing / transactional / data-sharing) as well as per-channel opt-in/out — support both via feature flag with **nullable** fields so per-channel-only and typed-consent coexist.

**Acceptance:** consent state is recorded per person/channel/tenant with provenance and bitemporal history; point-in-time consent is queryable; consent/suppression resolves to source and source-record granularity, so a per-channel withdrawal removes only that source's records for the person; retention period is configurable (30-day default); both per-channel and typed-consent models are supported via nullable, feature-flagged fields.

**References:**
- Decided 2026-06-17 (Dan, client): consent granularity is per channel/per app — a single-channel withdrawal removes that source's records, requiring per-source/per-source-record consent linkage — `memory/decisions.md#d-095`
- Decided 2026-06-18 (Leo): consent ledger is application-built, append-only, SHA-256 hash-chained — cloud-portable, no cloud-KMS-specific signing — `memory/decisions.md#d-013`
- Decided 2026-06-19 (Alicia, Privacy-by-Design): retention window configurable, 30-day baseline; consent taxonomy typed + per-channel both supported via feature flag with nullable fields — `memory/decisions.md#d-097`
- Decided 2026-06-19 (Alicia, Privacy-by-Design): suppression scope hybrid — regulatory opt-outs global, dealer opt-outs tenant-scoped, contact-point suppression on merge — `memory/decisions.md#d-112`
- Decided 2026-06-21 (Leo): terminal erasure is the tokenized PII vault (delete-the-row), supersedes per-consumer crypto-shred — `memory/decisions.md#d-012`
- `wiki/Privacy-by-Design.md` — consent first-class, bitemporal, read at send time; RLS per-tenant isolation; vault erasure orthogonal to access control
- `docs/consent-pii-erasure-options.md` — consent-ledger mechanism, suppression scope, and erasure-option set this story derives from
- `docs/deliverables/privacy-by-design-framework.md` — owning deliverable for consent taxonomy, lawful basis, and retention policy (Alicia + Luis)

**Consent-ledger mechanism (DECIDED 2026-06-18, Leo):** append-only, application-built SHA-256 hash chain — cloud-portable, deploys identically on Azure AKS or AWS EKS. Each row hashes the prior row for that `(person_id, tenant_id, channel)` triple for tamper detection. No cloud-KMS-specific signing (avoids coupling to AWS KMS / Azure Key Vault); any signing uses a portable app-held key / HMAC. KMS-signing is a deferred enhancement, not a Phase 1 requirement. See `docs/consent-pii-erasure-options.md`.
