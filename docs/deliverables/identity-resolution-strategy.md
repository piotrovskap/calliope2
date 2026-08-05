---
title: Identity Resolution Strategy & Identity Graph Plan
type: deliverable
status: complete
phase: 0
owners: Alicia Salazar, Luis Hernandez
review: Leo Mata
---

# Identity Resolution Strategy & Identity Graph Plan

*Phase 0 deliverable: the strategy for turning fragmented customer records into a single, trustworthy view of each person. Written for decision-makers. The full technical design lives in `wiki/Identity-Resolution.md`, and every choice below traces to a dated, recorded decision.*

## The problem we are solving

Today, the same consumer exists as a separate, disconnected record in dozens of DAS systems: a lead in the CRM, a buyer in the DMS, an email contact, a hashed ID in an ad platform. There is **no mechanism that recognizes these as one person**; in DAS's own words, *"we don't"* resolve identity across systems. The result is that no one can answer a simple question, *"what does DAS actually know about this customer?"*, without manual stitching.

The CDP's job is to resolve those fragments into one [**golden record**](/analysis/artifacts/golden-record/) per person, with the evidence for every link preserved. Mike Paylor set the bar: the engagement must **demonstrate** that a golden record is achievable from DAS's real data (*"show me all the people that could be Mike"*), rather than assert it with model accuracy projections.

## Our approach: deterministic first, intelligence earned

We resolve identity in stages, and we are deliberate about the order.

**Phase 1 ships deterministic matching**: exact matches on standardized identifiers (email, phone, VIN, dealer customer ID), plus a **human review queue** for the ambiguous cases. This is fast, explainable, and reliable, and it works on day one.

Machine learning is earned in a later phase, not assumed up front. The reason is evidence-based: DAS has no history of confirmed matches to learn from, so there is nothing to train a model on yet. Phase 1's human review decisions *become* that training data. The data model reserves space for the ML components from the start, so adding them later requires no rebuild. We chose this path (recorded as the locked "Option A") over an AI-first design because leading with models would mean projecting accuracy on data that does not exist.

## How a record gets resolved

Every incoming record runs the same path:

1. **Standardize** the identifiers (e.g. email lowercased, phone to a consistent format, VIN normalized).
2. **Match** against the existing identity graph on the strongest available identifier.
3. **Decide**, by confidence:
   - **High confidence** (a strong identifier matches one person): link automatically to that golden record.
   - **Ambiguous** (more than one possible person, or only weak signals): send to the **human review queue** for an operator to confirm, reject, or defer.
   - **No match**: create a new record. Identifiers that arrive with nothing to link to (a social-media ID with no email) are kept, not discarded; they resolve later when a connecting record arrives.

The bias is deliberately conservative: when in doubt, **queue for review rather than risk a wrong merge**. Wrong merges are far more costly to a dealer's trust than an extra record awaiting review.

## The rules that govern it

These are the locked decisions that make the strategy concrete and defensible:

- **Which record wins, field by field (survivorship).** When two sources disagree, a source-trust ranking decides the surviving value: the **DMS is ground truth** for transactions, name, and address (a real, signed transaction); the CRM wins on engagement and sales-relationship fields; engagement platforms win on channel state; third-party enrichment ranks lowest on identity. Most-recent wins within a tier. No value is ever destroyed: losing values stay in the record's history with their source, so every golden value is auditable and re-computable.
- **Households are detected, not assumed.** Family identity is the hardest case (per Dan). A household is its own entity, detected from a shared canonical address plus a corroborating signal (shared phone, surname, or co-occurring service history), and confirmed by a human before it is trusted.
- **The legacy "Common Client ID" is not the foundation.** A 2026-06-14 audit found DAS's CommonClientID column non-functional (all-zero), so the CDP builds its own deterministic identity from first principles and treats the legacy ID only as a migration breadcrumb, never as something live resolution depends on.
- **Identity inherits the privacy rules.** Cross-dealer matching happens in a privileged layer; what each dealer can *see* never crosses tenant boundaries; consent and erasure follow the model in the Privacy-by-Design deliverable.

## What is locked vs. what firms up later

Locked (recorded with dates and owners): the deterministic-first strategy (**Option A, 2026-06-17**, Luis + Alicia); the survivorship ladder, household model, and consent interaction (**2026-06-18**). What firms up on live data: the exact confidence thresholds and the human-review queue volume. These are measured over the first weeks of real traffic and tuned, rather than guessed up front. This is by design: we ship conservative defaults and let observed behavior set the numbers.

## Where to go deeper

- Full technical strategy (tiers, normalization rules, the identity-graph data model, queue mechanics): `wiki/Identity-Resolution.md`
- Field-by-field survivorship rules: `specs/02-phase-1-architecture/01-data-model/05-survivorship-rules.md`
- Privacy, consent, tenant isolation, and erasure: `docs/deliverables/privacy-by-design-framework.md`
- The interactive **golden record** view (the demonstrated record from real data): [/analysis/artifacts/golden-record/](/analysis/artifacts/golden-record/)
- How the golden record is presented and validated: `docs/cdp-architecture.md`
- The comparative options behind the recommendation, and the decision log: `analysis/artifacts/identity-strategies/strategies.json` · `memory/decisions.md`
