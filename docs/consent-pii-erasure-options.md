# Consent & PII Erasure — Architecture Options & Cost Notes

**Status: mechanism decided — tokenized PII vault + delete-the-row (Leo, 2026-06-21); see below. Policy values remain with Privacy-by-Design (Alicia + Luis).** Captured 2026-06-14 so the team can discover what was explored. Policy (retention, consent taxonomy, lawful basis, tenant-vs-global suppression scope) is owned by the Privacy-by-Design design (Alicia + Luis, `specs/02-phase-1-architecture/01-data-model/03-privacy-by-tenant.md`). This note covers the *mechanism* options and their economics.

**Decisions locked (Alicia, 2026-06-19):**
- Erasure orchestration: **Option C2 — Temporal workflow saga** (destroy DEK → evict cache → purge Postgres → purge S3 → purge Redshift → purge OpenSearch → write audit). Single durable workflow, built-in retries, idempotent, single auditable completion record.

**Mechanism superseded (Leo, 2026-06-21):** the per-consumer-DEK / crypto-shred mechanism below (**Option set A**) is replaced by a **tokenized PII reference vault + delete-the-row** — PII centralized in one mutable vault keyed by token; observation log, bronze, analytics, and search hold tokens + non-PII provenance only; erasure = delete the vault row (nothing to propagate cross-store; provenance retained; GLBA/legal-hold = plain row selection). Per-person keys are rejected as too complex, brittle, and expensive. The **Temporal saga (Option C2) orchestration still stands** — its first step becomes vault-row delete + tombstone instead of DEK destroy. Optional per-record salt+pepper hardening (single external pepper) and pepper-clear kill-switch are defense-in-depth extras, not the erasure mechanism. Option sets A/C below are retained for the cost/mechanism analysis that informed the call. See `wiki/Privacy-by-Design.md` and `memory/decisions.md` (2026-06-21).

Related build stories: `specs/03-phase-1-build/03-backend-data-model/` — `08-pii-vault-erasure`, `07-consent-store`, `09-opt-out-suppression`, `10-erasure-consent-audit`.

## Context

The CDP is append-only + bitemporal (every change is a recorded row; "as-of" history is the Golden Record evolution). That fights right-to-erasure (GDPR/CCPA). Consent is recorded per person x channel (email/SMS/phone/mail) x tenant — and, per the 2026-06-17 client decision (deletion/withdrawal is per channel/app, not whole-record), resolves to **source and source-record** granularity: every ingested source record carries a consent/provenance linkage so a single-channel withdrawal removes exactly that source's records (see `specs/03-phase-1-build/03-backend-data-model/07-consent-store.md`). Two mechanism families below: how to erase PII without breaking append-only history (crypto-shred), and how to record consent defensibly (consent ledger).

**Relationship to the privacy-by-design isolation layer.** The isolation mechanism is Postgres **row-level security** (tenant isolation / access control — *who can see which rows*, at query time) — **confirmed 2026-06-21** (see `wiki/Privacy-by-Design.md`). _(This options memo predates that confirmation, when RLS was still the working assumption.)_ Whatever the isolation layer, the encryption paths below (per-consumer DEK + crypto-shred) are a complementary **defense-in-depth + erasure bolt-on**, not a replacement: an access-control layer does not give erasure in an append-only store, and encryption does not give access control. They are orthogonal and compose.

---

## Option set A — KMS crypto-shred cost model

> **SUPERSEDED 2026-06-21 (Leo).** This option set (per-consumer DEK / crypto-shred) is no longer the chosen mechanism — replaced by the tokenized PII vault + delete-the-row (see the superseding note at the top). Retained below for the cost/quota analysis that informed rejecting per-person keys.

**Confirmed unit prices** (aws.amazon.com/kms/pricing, verified 2026-06-14): customer-managed key (CMK) **$1/key/month**; symmetric request (GenerateDataKey / Encrypt / Decrypt) **$0.03 per 10,000 = $0.000003/request = $3 per 1M**; free tier 20,000 requests/month; asymmetric sign/verify ~$0.15/10k. Math below re-validated by arithmetic, not estimated.

**A1 — One CMK per user (rejected on cost, kept for the record):** 10M CMKs x $1 = **$10,000,000/month**, and ~100x past the default ~100k-keys-per-region quota. Non-viable. This is why crypto-shred is always envelope encryption, never per-user CMKs.

**A2 — Envelope encryption (few CMKs + per-user DEKs stored in our DB):** each Person has a 256-bit Data Encryption Key (DEK) stored *wrapped in our database* (not in KMS); the DEK is wrapped by a small number of KMS CMKs. Erase a person = destroy their wrapped DEK row -> PII permanently unreadable, bitemporal structure and non-PII facts intact.

| Driver | Unit | At 10M users |
|---|---|---|
| CMK storage | $1/key/mo | 1-10 keys -> **$1-$10/mo** |
| DEK creation (GenerateDataKey, 1x/user) | $0.000003 | 10M -> **$30 one-time** |
| DEK unwrap (Decrypt on PII access) | $0.000003 | **scales with reads x (1 - cache hit)** |
| Erasure (delete wrapped DEK row) | our DB op | **$0 KMS** |

Per-user fixed KMS cost is effectively **$0** (a DEK is a DB row, not a KMS resource). The only variable is Decrypt volume, controlled by **DEK caching in Redis (ElastiCache)** — decrypt a user's DEK once, cache the plaintext DEK in Redis for a short TTL, reuse it across reads; erasure still holds because a shred deletes the wrapped DEK *and* evicts the Redis entry (short TTL bounds the window regardless). The DEK cache must use a **separate Redis instance / logical DB**, isolated from the regular Redis the Django app uses (cache, sessions, Celery) — so plaintext DEKs never co-mingle with general app cache and get their own access controls and eviction policy:

| Access pattern | Decrypts/mo | KMS cost/mo |
|---|---|---|
| Decrypt per read, no cache (~1B reads) | 1,000,000,000 | **$3,000** |
| Same, heavy (~10B reads) | 10,000,000,000 | $30,000 |
| DEK caching, ~5M decrypts | 5,000,000 | **$15** |
| DEK caching, ~30M decrypts | 30,000,000 | **$90** |

**A3 — CMK per tenant (option, not a pick):** one CMK per dealer (~1,700 dealers) x $1 = **~$1,700/mo**, giving tenant-level key isolation and one-shot crypto-shred of an entire dealer, with per-user DEKs underneath. Affordable; trades a flat monthly fee for blast-radius control.

**A4 — Keystore location (where the wrapped DEKs live):** the per-user wrapped DEKs can sit in a **Postgres key table** (transactional with the data, one store to operate) or in a **separate dedicated keystore — a DynamoDB table** (or other separate DB). Separating the keystore buys: defense-in-depth (compromising the data store yields no keys, and vice versa) with independent IAM; single-digit-ms key lookups at 10M+ items; and — the strongest argument — an **independent backup/retention policy**. The data store wants long bitemporal backups; the keystore wants *guaranteed destroyability* (e.g. DynamoDB TTL + a tight/zero PITR window) so a shredded DEK can never be resurrected from an old backup. Cost is negligible with DEK caching (few lookups). Caveat: writing data (Postgres) and key (DynamoDB) is no longer one ACID transaction — write the key first, use idempotency keys, and reconcile orphans.

**Takeaway:** KMS economics are not the constraint (tens-to-hundreds of $/mo with sane caching; low thousands only if decrypt-per-read with no cache). The real engineering is the **encryption boundary** — no plaintext PII in logs/caches — and **cross-store erasure propagation** to S3 bronze, Redshift, and OpenSearch copies.

---

## Option set B — Consent ledger

A consent ledger is an append-only, tamper-evident record of consent *events* (grant / withdraw / update) per person x channel x tenant, with provenance (who/what captured it, when, lawful basis). Value over a mutable consent table: regulatory defensibility — prove what consent existed at any point in time, demonstrably un-altered, replayable. This is event-sourcing applied to consent (consistent with `specs/03-phase-1-build/06-identity-resolution-engine/05-identity-record-event-sourcing.md`).

**B1 — Bitemporal append-only table (baseline):** consent events in Postgres with valid-time + system-time. Cheap, integrated, queryable point-in-time. Tamper-evidence relies on DB/IAM controls (no cryptographic proof).

**B2 — Hash-chained ledger (tamper-evident):** each entry stores the hash of the previous entry, so any retroactive edit breaks the chain and is detectable/provable. Stays in Postgres/S3 — no new infra — and adds cryptographic verifiability over B1.

**B3 — KMS-signed entries (non-repudiation):** sign each consent event with a KMS key so the recorder and integrity are provable. Cost is asymmetric signing ($0.15/10k), but consent events are low-volume vs reads, so negligible. Composes with B2.

**B4 — Managed verifiable ledger (e.g. Amazon QLDB):** purpose-built immutable + cryptographically verifiable ledger. Two caveats make it a poor fit here: (1) **AWS QLDB is retired** — end of support was 2025-07-31, with AWS directing customers to Aurora PostgreSQL; (2) it is **AWS-specific and not platform-agnostic** — hard to replace if DAS ever moves off AWS, which cuts directly against the stated portability principle. The portable, forward-looking equivalent is B2/B3 (hash-chain + KMS signing in Postgres/S3). Listed for completeness, not recommended.

**B5 — Event-sourced consent artifacts in S3 + Glue:** persist the consent event stream as compressed immutable artifacts in S3 for long-term retention/replay, with analytical access via Glue (access approach TBD) — mirrors the identity event-sourcing approach.

**Interaction with erasure (important):** the consent ledger should store **pseudonymous person/contact references + consent state + provenance, never raw PII**. Then the ledger can stay immutable while PII is crypto-shredded elsewhere (Option set A) — the two coexist. If any PII must live in the ledger, it goes under the same per-consumer DEK so a shred renders it dark without breaking the chain (a hash chain over ciphertext still verifies).

**Cost:** trivial — storage plus optional low-volume KMS signing. Not a cost decision; a defensibility/verifiability decision.

---

## Option set C — Erasure & cleanup orchestration

Crypto-shred is a **multi-store operation** — destroy the wrapped DEK (DynamoDB delete / TTL expiry), evict the plaintext DEK (Redis), and propagate the PII purge to S3 bronze / Redshift / OpenSearch — so it needs reliable, idempotent, audited orchestration. Options compose, they are not exclusive:

**C1 — AWS Lambda.** Event-driven or scheduled functions for delete propagation, key cleanup/expiry, and (re-)encryption. Serverless and cheap; good for fan-out purge jobs and TTL-driven sweeps. Each step idempotent, with a DLQ for failures.

**C2 — Temporal workflows.** A durable workflow runs the full shred saga — destroy DEK, evict cache, purge each PII copy, write the erasure audit — with built-in retries, idempotency, and visibility. Fits the stack (Temporal is already the app-layer orchestrator) and yields a single auditable record that an erasure completed across every store.

The same orchestration covers (re-)encryption and key rotation. If the **consent ledger** is kept in its own separate store, these jobs manage it too — though the ledger itself stays immutable (it holds pseudonymous refs + consent state, not PII, so it is never shredded).

## Open / design-owned

- The **policy** layer (retention, taxonomy, lawful basis, suppression scope) is the Privacy-by-Design deliverable (Alicia + Luis) — not decided here.
- ~~Cross-store erasure propagation~~ **Resolved by the vault (2026-06-21):** PII lives only in the vault, so there is nothing to propagate cross-store — tokens elsewhere dereference to nothing. (This was the main crypto-shred risk; the vault removes it.)
- **Tiered data lifecycle** (active -> raw -> archival -> dehydrated -> erasure; configurable per source/core-entity; admin-managed transitions) — vault-row delete is the terminal stage. See `specs/03-phase-1-build/03-backend-data-model/11-tiered-data-lifecycle.md` (2026-06-17).
- Access path for event-sourced artifacts (consent and identity) over the bronze layer is a Phase-1 detail (the lakehouse engine — Synapse / Glue — per the bake-off).

**No decision — these are options for discussion.**
