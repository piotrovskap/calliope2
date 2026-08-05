---
title: "Identity resolution strategy"
type: story
status: done
priority: high
estimate: XXL
depends_on: []
labels: [identity, matching, phase-0-architecture]
date: ~
artifacts:
  - "Identity Resolution Strategy | docs/deliverables/identity-resolution-strategy.md"
---
**Closed 2026-06-17 (done):** identity strategy Option A locked (deterministic-first; ML earned in Phase 2).

Requirements draft (2026-06-12). Replaces CVH (DealerID + email hash) entirely — CVH cannot resolve across dealers by construction.

Committed at the 2026-06-12 sync: strategy options (Alicia + Luis) in ~1 week; war-room design sessions start within days. Design inputs from the sync: orphan identifiers must be storable and resolvable later (Dan's Facebook-ID example); validate against real data, not just schemas (Mike); output feeds the golden-record view.

## Matching

1. **Deterministic waterfall**: normalized email → E.164 phone → dealer customer ID → VIN + name. Exact match, auto-link.
2. **Heuristic candidate generation** (when no common ID exists): pattern-based blocking to surface potential matches cheaply, before scoring. Blocking keys:
   - Phonetic name keys (Metaphone/Soundex) + zip
   - Normalized address key (USPS-style canonicalization)
   - Email local-part patterns (`jsmith`, `john.smith`, `smithj` against name fields; shared domain for non-freemail)
   - Phone last-7 (survives area-code changes and formatting noise)
   - VIN prefix (year/make/model decode) + surname
   - Name n-gram similarity within a dealer's region
   Output is candidate pairs only — feeds the scorer, never links directly. Each heuristic is independently toggleable and measured (candidates generated vs. confirmed rate).
3. **Data matching**: shared facts as resolution evidence, independent of contact identifiers. Two records sharing a VIN with overlapping ownership windows, the same service event (date + dealer + vehicle), the same deal record arriving from two source systems, or a dealer customer ID reused across CRM and DMS are match signals. Fact overlap scores feed the same scorer as identifier matches — a person who changed email and phone is still resolvable through their vehicle and service history.
4. **Probabilistic scoring**: fuzzy name + address, household inference, fact-overlap scores, over the candidate set. Produces scored candidate edges only — never silent merges.
5. **Three bands**: auto-merge ≥ upper threshold, conflict review queue between, discard below. Thresholds tunable per source.

## Graph

- Identity links are edges with confidence score, match rule, provenance, timestamp.
- Merges are reversible: persistent person IDs never reused, merge history supports unmerge.
- Per-channel keys (from API catalog): GCLID bridges ad click → person; Meta lead forms carry email/phone at click time; page-scoped IDs stay opaque until PII is volunteered; hashed email for ad-platform audience matching.

## Survivorship & Source Trust

When two records resolve to the same consumer but their fields disagree, survivorship picks the winning value **per field**. Source trust is the primary signal. Locked 2026-06-17 (Alicia + Luis); see `wiki/Identity-Resolution.md` §Survivorship & Source Trust and `memory/decisions.md#d-107`.

**Source-trust ranking (Phase 1):**

1. **DMS** — ground truth. Transactional record, dollars attached, customer signed for the transaction. Wins on name, address, vehicle ownership.
2. **CRM** — operational source. Wins on engagement preferences, sales-rep relationship, lead provenance.
3. **Email engagement / Twilio** — wins on channel-state fields (subscribed / unsubscribed, last engaged).
4. **Third-party enrichment** — Recall Masters, BlackBook, etc. Lowest trust on identity fields; high trust on the data they own (recalls, valuation).

**Per-field survivorship (field class → winning source):**

| Field class | Winning source | Rationale |
| --- | --- | --- |
| Name, mailing address, vehicle ownership | DMS | Signed transactional record |
| Engagement preferences, sales-rep relationship, lead provenance | CRM | System of record for operational/sales context |
| Channel state (subscribed / unsubscribed, last engaged) | Email engagement / Twilio | Owns the consent/engagement signal |
| Recalls, valuation, other enrichment-owned facts | Third-party enrichment | High trust only on the data they own |

**Tie-breaker:** most recent observation wins within a trust tier.

**Provenance & non-destruction:** per-element provenance is retained alongside the surviving value (which source supplied it, when, with what method). No source is permanently overridden — losing values remain in the entity history for audit and re-resolution. This binds to the bitemporal provenance model (see `01-cdp-data-model-design.md`).

## Validation

- Common Client ID used as cross-check, not foundation — audited 2026-06-14 (non-functional: all-zero column), so probabilistic matching is primary; coverage re-validated at Phase 1 ingestion.
- Golden set: manually adjudicated matches, including known family cases (hardest case per kickoff), to measure precision/recall before any ML pass. ML extension is Phase 2.

## Acceptance

- Match rule spec with thresholds and per-source key availability.
- Identity conflict queue design: capacity estimate (open question — expected ambiguous-match volume), reviewer workflow, audit trail.
- Unmerge demonstrated on a merged pair without data loss.
- Survivorship rules: per-field winning-source matrix with recency tie-break, retaining per-element provenance for all losing values.

**References:**
- Decided 2026-06-17 (Luis + Alicia): Identity strategy Option A locked — deterministic-first waterfall (email → phone → VIN → dealer customer ID) with heuristic recovery, ML deferred to Phase 2 with schema stubs — `memory/decisions.md#d-104`
- Decided 2026-06-17 (Luis + Alicia): Survivorship + source-trust ladder (DMS → CRM → Email/Twilio → third-party enrichment), most-recent-within-tier tie-break, per-element provenance retained — `memory/decisions.md#d-107`
- Decided 2026-06-12 (Dan Aston): CCID is one weighted signal + migration PK, not the join foundation; orphan identifiers stored and resolved later (Facebook-ID example); validate against real data — `memory/decisions.md#d-110`
- `wiki/Identity-Resolution.md` — canonical strategy: deterministic tier, confidence bands, survivorship matrix, orphan handling
- `docs/deliverables/identity-resolution-strategy.md` — the identity-graph deliverable this story builds
- `specs/02-phase-1-architecture/01-data-model/05-survivorship-rules.md` · `01-cdp-data-model-design.md` — survivorship spec and the bitemporal provenance model this binds to
