---
title: "Privacy by tenant"
type: story
status: done
priority: high
estimate: L
labels: [privacy, multi-tenancy, rls, phase-0-architecture]
date: ~
artifacts:
  - "Privacy-by-Design Framework | docs/deliverables/privacy-by-design-framework.md"
---
**Closed 2026-06-18 (done):** tenant isolation via Postgres RLS + DAS-global / dealer-isolated model.

Requirements draft (2026-06-12). Two-plane model: identity resolution crosses tenants; fact visibility never does.

## Model

- **DAS plane**: the identity graph. May use any tenant's identifiers to link people across dealers.
- **Tenant plane**: attribute facts, events, deals. Visible only to contributing tenant(s) plus DAS.
- Example: phone from Dealer X, email from Dealer Y, same person. X sees the phone + DAS-global enrichment; Y sees the email; DAS sees the unified record. Neither dealer sees the other's fact.
- Enforcement: PostgreSQL RLS keyed on requesting tenant; visibility computed from per-fact provenance.

## Rules

1. **No link leakage.** A tenant's view renders as if its facts + DAS-global are the whole record. No hidden-field counts, no "active elsewhere" signals.
2. **Visibility is a set, not an owner.** A fact's visibility = set of tenants that contributed it. Same value, multiple provenance rows. If X later uploads a value Y already provided, X sees it — X brought it.
3. **Derived facts inherit the most restrictive provenance of their inputs** unless explicitly declared DAS-global. Prevents tenant-private data laundering through computed fields (household size, scores).
4. **Consent is per-tenant per-channel; deletion traverses the graph but is scoped.** A CCPA/TDPSA deletion request traverses the identity graph across all tenants, including merged-in records — merge history is the index — then **scopes** to deletable records: GLBA-covered financing data and other legally-held records are retained under an audited legal-basis hold (deletion is not unconditional). Mechanism is the tokenized PII vault — delete the vault row(s) for the deletable set; provenance/lineage survives (observation log holds tokens + source/time/method, never raw values). See `wiki/Privacy-by-Design.md`; per-consumer crypto-shred is superseded (2026-06-21).

## Acceptance

- RLS policy set + query-layer visibility filter, tested with cross-tenant fixtures (real database, per workspace test rule).
- Negative test: tenant A cannot infer existence of tenant B's facts via API responses, counts, or timing.
- Derived-field provenance inheritance demonstrated on one computed field.
- Deletion walkthrough: request → graph traversal → suppression across tenants, documented.

**References:**
- Decided 2026-06-21 (Leo): RLS confirmed as the multi-tenant isolation mechanism — shared-database/shared-schema + tenant discriminator, `app.current_tenant` GUC per transaction, `FORCE ROW LEVEL SECURITY`, visibility computed from per-fact provenance (set, not owner) — `memory/decisions.md#d-004`
- Decided 2026-06-21 (Leo): PII erasure via tokenized vault + delete-the-row, supersedes per-consumer DEK / crypto-shred; provenance/lineage retained, scoped GLBA/legal-hold deletion is plain row selection — `memory/decisions.md#d-012`
- Decided 2026-06-19 (Alicia): suppression scope hybrid — regulatory opt-outs global, dealer opt-outs tenant-scoped, CCPA/GDPR deletion traverses all tenants via the identity graph — `memory/decisions.md#d-112`
- `wiki/Privacy-by-Design.md` — canonical two-plane isolation model, RLS enforcement rationale/tradeoffs, segregation rules, scoped deletion
- `docs/deliverables/privacy-by-design-framework.md` — the governing privacy deliverable
