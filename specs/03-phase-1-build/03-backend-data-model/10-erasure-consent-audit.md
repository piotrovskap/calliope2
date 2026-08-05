---
title: "Erasure & consent audit"
type: story
status: planned
priority: medium
estimate: L
depends_on: [phase-1-build.backend-data-model.pii-vault-erasure, phase-1-build.backend-data-model.consent-store]
labels: [backend, audit, privacy, 1a]
date: ~
---

An audit trail for every consent change and every erasure (delete request received, vault rows deleted + tombstoned, token references confirmed dereferenced) — enough to demonstrate compliance on request, without itself storing the erased PII.

**Acceptance:** every consent change appends a bitemporal, hash-chained ledger entry (SHA-256, tamper-evident); every erasure writes one completion record capturing what was deleted, what was retained and under which legal basis, the vault-row tombstone, and confirmation that token references dereference to nothing across stores; both record valid-time + system-time and source provenance; the audit references tokens/pseudonymous keys only and contains no raw PII, so it survives the erasure it records; given an erased person, the audit can demonstrate compliance without re-identifying them.

**References:**
- Decided 2026-06-18 (Leo): consent-ledger is application-built, append-only, SHA-256 hash-chained (portable, holds tokens + state + provenance, never raw PII) — `memory/decisions.md#d-013`
- Decided 2026-06-19 (Alicia, Privacy-by-Design): cross-store erasure runs as a durable Temporal saga ending in one auditable completion record — `memory/decisions.md#d-011`
- Decided 2026-06-21 (Leo): erasure = delete the PII-vault row + tombstone; tokens elsewhere dereference to nothing, provenance/lineage retained — `memory/decisions.md#d-012`
- `wiki/Privacy-by-Design.md` (Audit & Lineage) — bitemporal record of consent changes and erasures, ledger tamper-evidence, audit holds tokens not PII
- `docs/deliverables/privacy-by-design-framework.md` — canonical deliverable framing the audit/lineage requirement
