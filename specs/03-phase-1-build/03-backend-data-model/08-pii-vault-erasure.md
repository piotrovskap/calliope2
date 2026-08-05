---
title: "PII erasure — tokenized reference vault"
type: story
status: planned
priority: high
estimate: L
depends_on: [phase-1-build.backend-data-model.data-model-foundation, phase-1-architecture.data-model.privacy-by-tenant]
labels: [backend, privacy, erasure, vault, 1a]
date: ~
---

Tokenized PII reference vault + delete-the-row erasure. **Supersedes per-consumer crypto-shred / DEK (decided 2026-06-21, Leo — per-person keys rejected as too complex, brittle, expensive; see `memory/decisions.md#d-012` and `wiki/Privacy-by-Design.md`).**

Identity-class PII (name / email / phone / address) lives in a single **mutable PII vault keyed by a surrogate token**. The append-only observation/event log, bronze parquet, analytics, and OpenSearch store **tokens + non-PII provenance only, never raw values**. Erasure = delete/null the vault row(s); tokens elsewhere dereference to nothing — **no cross-store PII purge to propagate**. Provenance/lineage retained (observation log keeps which source supplied each field, when, by what method, by token). Scoped GLBA / legal-hold deletion = plain row selection on source + purpose (no sub-keys). Retention/policy is design-owned.

**Optional defense-in-depth (feature-flagged, per-record, off by default):** per-row salt (stored in row) + a single external pepper (secrets manager) derive a per-row protection key via KDF — backup/dump protection with one secret, not per-person keys. Per-row scheme marker lets plaintext and hardened rows coexist and the flag flip on/off without schema change. Hardened-row ciphertext is non-matchable (matching is on normalized tokens). **Pepper-clear** = coarse kill-switch for decommission / offboard / breach (per-tenant by default; global if scoped global — pepper scope is a policy-config setting).

**Orchestration — Temporal workflow saga (APPROVED 2026-06-19, Alicia; mechanism updated 2026-06-21):** single durable workflow, built-in retries, idempotency, single auditable completion record. Steps:
1. Delete deletable vault rows + write tombstone (retain legal-hold rows)
2. Confirm token references dereference to nothing across stores (Postgres history / S3 bronze / analytics / OpenSearch)
3. Write erasure audit record (`10-erasure-consent-audit`) including the legal-basis hold list

Temporal is already in the stack as the app-layer orchestrator. See `docs/consent-pii-erasure-options.md` Option C2.

**Acceptance:** a delete request removes the person's deletable PII from the vault and renders it unrecoverable system-wide (tokens dereference to nothing) while retaining legal-hold records, non-PII facts/aggregates, and full provenance/lineage; **the saga also scrubs the `person`-row resolver blocking hashes (email/phone) so no re-identification path survives** (the `person_id` shell + tokenized history remain for bitemporal integrity); the saga completes atomically via Temporal with a full audit trail; optional per-record salt+pepper hardening toggles on/off; clearing the pepper renders all values derived from it unreadable.

**References:**
- Decided 2026-06-21 (Leo): PII erasure mechanism = tokenized reference vault + delete-the-row, supersedes per-consumer DEK / crypto-shred (per-tenant pepper default) — `memory/decisions.md#d-012`
- Decided 2026-06-21 (Leo): erasure scrubs the resolver email/phone blocking hashes; `person_id` shell + tokenized history remain — `memory/decisions.md#d-012`
- Approved 2026-06-19 (Alicia): cross-store erasure orchestration as a single durable Temporal workflow saga; mechanism updated 2026-06-21 (Leo) to drive the vault-row delete — `memory/decisions.md#d-011`
- `wiki/Privacy-by-Design.md` — vault + delete-the-row erasure, RLS isolation, retention/policy ownership
- `docs/consent-pii-erasure-options.md` — Option set A (vault default) and Option C2 (Temporal saga orchestration)
- `docs/deliverables/privacy-by-design-framework.md` — the governing privacy deliverable
