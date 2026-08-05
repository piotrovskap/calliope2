---
title: Privacy-by-Design Framework for Dealer Data
type: deliverable
status: complete
phase: 0
owners: Alicia Salazar, Luis Hernandez
review: Leo Mata
---

# Privacy-by-Design Framework for Dealer Data

*Phase 0 deliverable: the framework that lets DAS pool consumer data across ~1,700 dealers and still keep each dealer's data isolated, honor a deletion request, and prove it to a regulator. Written for decision-makers; the full technical framework lives in `wiki/Privacy-by-Design.md`, and every choice below traces to a dated, recorded decision. Companion to the Identity Resolution Strategy: identity resolution crosses tenants; privacy governs what crosses and what never does.*

## The problem we are solving

A CDP that unifies a person's data across dozens of dealers and apps is, by definition, the place where consumer data becomes most concentrated, and therefore most regulated. Two things have to be true at once, and they pull against each other. The platform has to **resolve identity across dealers** to be useful, and it has to **keep each dealer's data invisible to every other dealer**. It has to keep a permanent, append-only history of every change (that history is what makes the golden record trustworthy and auditable), and it has to be able to erase a person on request, which an append-only store fights by its very nature.

This framework is built for that specific tension, not from generic compliance boilerplate. The hard requirements are satisfied **by construction**: isolation enforced at the database, all personal data centralized in one deletable place, erasure that survives an append-only store, rather than bolted on after the fact.

## Our approach: decide the mechanisms, leave the policy values to Legal

We draw a clean line. **This deliverable decides the mechanisms**: how isolation is enforced, where PII lives, how erasure works. **The policy layer** (exact retention periods, the full consent taxonomy, lawful-basis mapping) is owned by Alicia and Luis with DAS Legal, who populate the values; the mechanisms here are built policy-ready. DAS Legal is not a Phase-0 blocker: they sign off on the proposal once it is authored, not before the framework is.

## The regulatory frame

The CDP targets the two obligations that actually bind DAS, and it is **deletion-first**: a defensible deletion mechanism is the priority, because that is the hard one.

- **CCPA (California)** and **TDPSA (Texas, effective 2024-07-01)** are the frame. Texas is the broader of the two: its deletion right covers data "provided by **or obtained about**" a consumer, meaning enrichment and third-party-sourced records, not just first-party. The CDP's source-record-granular provenance model already reaches every source's contribution to a person, so this broader scope is covered by construction.
- Both laws require the deletion to cascade to every downstream copy of the data. In the CDP every downstream store is PII-bearing, so erasure has to reach them all, which the PII vault below makes a logical operation rather than a per-store sweep.
- **Deletion is conditional, not unconditional.** Both laws exempt GLBA-covered financial data from the right to delete. Dealerships handle financing, so a material share of CDP data is GLBA-regulated and must be retained even when a deletion request arrives. Other carve-outs (active legal claim, fraud prevention, statutory retention) work the same way. So deletion is **scoped**: deletable records are erased; legally-held records are retained under an audited legal-basis hold. This is the single most important deviation from a naive "delete everything for this person."
- **Timelines:** acknowledge a request within 10 business days (CCPA), substantive response within 45 days (both, with a permitted 45-day extension on notice).

## Tenant isolation: two planes, enforced at the database

The model is two planes. The **DAS identity plane** may use any dealer's identifiers to link a person across dealers; that is where cross-dealer resolution happens. The **tenant fact plane** (the attributes, events, and deals) is visible only to the dealer(s) who contributed it, plus DAS. A phone from Dealer X and an email from Dealer Y can resolve to the same person, but X never sees Y's email, never sees that Y exists in this person's graph, and vice versa.

Isolation is enforced by **PostgreSQL Row-Level Security** (decided 2026-06-21, Leo). This was moved from working-assumption to a confirmed decision with documented rationale. Isolation policies live on the database tables themselves, so every query is filtered by the database regardless of which service or code path issued it: a forgotten `WHERE tenant_id =` in application code **cannot** leak rows. It runs as shared-database/shared-schema with a tenant discriminator, which is the cost-effective model at ~1,700 dealers (no per-tenant database sprawl), with tenant context set per transaction. **Acknowledged tradeoff:** RLS isolates rows, not compute, cache, or disk. Resource-fairness (noisy-neighbor) is an application-tier concern, not an isolation gap, and nothing here depends on physical per-tenant separation.

## Dealer data segregation: the rules

Isolation is more than "tag each row with an owner." A few rules make it airtight:

- **No link leakage.** A dealer's view renders as if its facts plus DAS-global data are the whole record: no hidden-field counts, no "active elsewhere" hints, no way to infer another dealer's data exists.
- **Visibility is a set, not an owner.** A fact is visible to the set of dealers that contributed it. If two dealers both supplied the same email, both see it, because both brought it.
- Derived facts inherit the most restrictive provenance of their inputs, so dealer-private data cannot launder through a computed field (a household size, a score) into another dealer's view.
- **Deletion traverses the graph.** A deletion request follows the identity graph across all dealers and merged-in records, while honoring per-dealer visibility and the legal-hold exemptions above.

These are not aspirations: a **negative test** (that one dealer cannot infer another's data via API responses, field counts, or even response timing) is an acceptance criterion (`specs/02-phase-1-architecture/01-data-model/03-privacy-by-tenant.md`).

## Consent: first-class, granular, read at the moment of use

Consent is a first-class data category, not a metadata field. It is **source-record granular** (every ingested record carries a consent/provenance linkage), so a withdrawal arriving on one channel removes exactly that source's records and leaves other channels intact, per the client's direction that withdrawal is per channel/app, not whole-record (Dan Aston, 2026-06-17). It is **typed and per-channel**: consent types (marketing / transactional / data-sharing) coexist with per-channel opt-in/out, and a deployment can run either or both (approved 2026-06-19, Alicia). Channel consent, suppression-list membership, and GLBA scope are read at send time, not at record-creation time, so the latest state always governs. And it is recorded in a tamper-evident, application-built **hash-chained ledger** (SHA-256, decided 2026-06-18, Leo) that is cloud-portable and holds pseudonymous references, never raw PII, so it stays immutable and survives erasure.

## PII handling: one vault, delete the row

All identity-class PII (name, email, phone, address) is centralized in a single mutable **PII vault**, keyed by a surrogate token. Everywhere else (the append-only observation log, the golden record, analytics, the search index) stores only the **token plus non-PII provenance, never the raw value**. This single design choice is what makes everything downstream tractable:

- **One place holds PII**, so cross-store erasure stops being a propagation problem. Delete the vault row and every token elsewhere dereferences to nothing.
- **No per-person keys.** Per-consumer encryption keys / crypto-shred were rejected as too complex, brittle, and expensive (decided 2026-06-21, Leo): millions of wrapped-key rows, decrypt-on-every-read infrastructure, and a key-granularity problem for partial GLBA deletion. Erasure is a plain row delete instead.
- **Provenance survives erasure by construction.** The observation log records which source supplied each field, when, and how, by token, never by inlining the value. Erasing the value leaves "a phone was provided by the DMS on 2026-01-01 via batch" fully intact; only the number is gone (Leo's explicit requirement, 2026-06-21).
- **Optional salt + pepper hardening**, off by default and selectable per record (decided 2026-06-21, Leo). A per-row salt stored in the row plus a single external pepper held in a secrets manager protect each value under an effectively-unique key: **one external secret, not millions of per-person keys**. A backup or database-dump leak is useless for hardened rows without that pepper. Clearing the pepper is a coarse kill-switch (decommission, breach, or, scoped per tenant by default, clean dealer offboarding).
- **Tokenize at the CDP, not at the edge** (decided 2026-06-21, Leo). Identity is only ever assembled inside the CDP; the raw ingest edge carries fragmented, single-vector fragments (a lone email, a lone VIN) at much lower re-identification risk. So protection concentrates where the risk concentrates: PII is tokenized as data is resolved into the CDP, while the raw edge is governed by bounded retention/age-out and access control rather than a coordinated cross-store delete. Per-source edge tokenization is available as a policy toggle for high-sensitivity sources.

## Erasure: a durable, auditable, scoped operation

Because PII lives only in the vault, erasing a person is **delete (or null) their vault rows**, and the token references everywhere else resolve to nothing, while the bitemporal structure, non-PII facts, and per-element provenance all stay intact. **Scoped deletion** for GLBA/legal-hold records is plain row selection: vault rows carry source and purpose, so erasure deletes the deletable subset and retains the held rows by a `WHERE` clause, no key juggling. **Backups age out by retention policy**, not by an immediate scrub (decided 2026-06-21, Leo); a deletion policy means data is not retained forever, and the optional pepper keeps backup contents unreadable in the interim.

The whole operation runs as a single durable **Temporal saga** (Option C2, approved 2026-06-19, Alicia) for reliability and one auditable completion record: delete deletable vault rows and write a tombstone, confirm tokens dereference to nothing across stores, write the erasure audit. The orchestration Alicia approved is unchanged; only its first step shifted from key-destruction to vault-row delete when the mechanism was superseded on 2026-06-21. Standard lifecycle: acknowledge within 10 business days, verify the requester, traverse the identity graph for all records, apply legal-hold exemptions, run the saga over the deletable set, respond within 45 days.

## Audit, lineage, and the policy-config layer

Every value keeps **per-element provenance** (which source, when, by what method), surviving erasure because it lives as token plus metadata, never the raw PII. Consent changes and erasures are recorded **bitemporally** (when it changed, when the CDP observed it). Each erasure produces a **single completion record** including the legal-basis hold list for retained records, the defensibility artifact for a regulator inquiry, and the consent ledger is **tamper-evident** via hash-chaining.

A real record matches several scopes at once (a source, a channel, a partner, a dealership, a user), so a **policy-config layer** with deterministic resolution sits over all of this (raised 2026-06-21, Leo). It is where retention periods, the salt+pepper toggle, suppression scope, edge-tokenization, and pepper scope are configured. Pepper scope, for instance, is per-tenant by default but configurable to global (decided 2026-06-21). We build the config layer, resolver, and admin surface; Alicia and Luis with DAS Legal populate the values.

## What is locked vs. what is design-owned

**Locked** (recorded with dates and owners): RLS as the isolation mechanism (2026-06-21, Leo); the tokenized vault + delete-the-row erasure mechanism, no per-person keys, retain-provenance, scoped GLBA deletion, backups-age-out, optional salt+pepper, tokenize-at-the-CDP, pepper-per-tenant-default (all 2026-06-21, Leo); the Temporal erasure saga (2026-06-19, Alicia); the application-built hash-chained consent ledger (2026-06-18, Leo); typed + per-channel consent and the 30-day baseline retention window (2026-06-19, Alicia); per-channel withdrawal granularity (2026-06-17, Dan Aston).

**Design-owned** (the mechanisms are ready; the values get filled in): retention periods, the full consent taxonomy, lawful-basis mapping, and suppression scope, populated by Alicia + Luis with DAS Legal. The analytics warehouse choice is deferred to the AWS-vs-Azure bake-off and the erasure design is agnostic to it.

## Where to go deeper

- Full technical framework (regulatory frame, isolation, segregation, vault, salt+pepper, ingest boundary, erasure, audit/lineage, policy-config): `wiki/Privacy-by-Design.md`
- Mechanism options and their economics (crypto-shred analysis, consent-ledger options, orchestration): `docs/consent-pii-erasure-options.md`
- Build specs: `specs/02-phase-1-architecture/01-data-model/03-privacy-by-tenant.md`; and under `specs/03-phase-1-build/03-backend-data-model/` — `07-consent-store.md`, `08-pii-vault-erasure.md`, `09-opt-out-suppression.md`, `10-erasure-consent-audit.md`, `11-tiered-data-lifecycle.md`, `18-policy-config-layer.md`
- Identity context (what crosses tenants, and how): `docs/deliverables/identity-resolution-strategy.md` · Architecture: `docs/cdp-architecture.md`
- The dated decision log behind every claim above: `memory/decisions.md`
