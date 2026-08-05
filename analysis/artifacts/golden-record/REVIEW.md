# Golden Record v1.0 — Reviewed & Approved (Alicia + Luis)

**Status:** v1.0 — reviewed & approved by Alicia (data engineer) and Luis (lead architect), 2026-06-21. The model is structurally validated and gate-enforced; the review promoted it from v0.9 to v1.0. The decisions below — and the survivorship rules in `record.json` previously flagged PROPOSED — are confirmed at this review.

**Artifacts:** `schema.json` (contract) · `record.json` (instance, gate-enforced) · `index.html` (visualizer) · `audit-findings.json` (verification log). Open the visualizer from the portal (artifact: golden-record).

**What's already verified (so you can focus elsewhere):** every field→source mapping (41/41) is doc-confirmed by deterministic grep + 3-vote consensus; the enforced gate (`make check-golden-record`) asserts schema conformance, reference resolution, and per-field provenance/justification. So provenance correctness is not what needs your eyes — the design judgment calls below are.

## Decisions approved at v1.0 (2026-06-21)

1. **Entity set + relationships (the core).** 23 entities; identity keys are **edges** (Contact point / Address), Person has a persistent UUID and no key columns, Household is **derived/recomputable**, Deal binds Person+Vehicle+Dealer. Grounded in your `01-cdp-data-model-design.md`. Approve the set, or flag missing/over-modeled entities. (`model.entities` / `model.relationships`.)

2. **CDP field names vs source columns.** Golden-record field names are CDP-canonical and deliberately differ from source columns (e.g. "Normalized email(s)" ← `CustomerEmail`/`event-data.recipient`/`franchise_consumer_alias.email`). The classifier flagged these as "rename to the source column"; I kept the CDP names. Confirm that's the convention you want.

3. **Vendor-standard "design-proposed" fields.** Ad click IDs (gclid/msclkid/ttclid), CAPI EMQ, audience hashing are marked verified against the vendor wiki pages, but DAS isn't ingesting them today (access `api-unused`). Confirm treating vendor-standard-but-not-yet-used as in-scope-future is acceptable, or down-rank them.

4. **Reporting-layer seeds.** `CDXP.JuiceReporting_*` are pre-joined **views** (built because Juicebox can't join across tables). I use them as identity **seeds** for the real-data proof, not as production ingestion sources (objective 3, raw-first). Confirm that boundary.

5. **Identity machinery.** `identity_binding` encodes your locked Option A: deterministic waterfall, blocking keys, survivorship (DMS = ground truth), alias graph (`franchise_consumer_alias`), confidence bands, curation queue, merge/split, household, orphan handling, provenance model. Verify it reflects your design faithfully; correct any drift.

6. **Backlog materialization granularity.** The 67-item audit backlog was materialized mostly as **entity attributes** (vehicle/event/consumer_attribute carry 60–125 attrs) rather than dictionary fields, to avoid bloating the sourced catalog. Confirm that structural-layer choice, and whether any attribute should be promoted to a first-class sourced dictionary field.

## How to leave notes
Comment on this PR (`feat/golden-record-dictionary`), or append notes below. This artifact is now v1.0 (reviewed & approved 2026-06-21); further notes are tracked as post-v1.0 revisions.

## Notes

### Decision 6 — Backlog materialization granularity (Alicia, 2026

### Post-v1.0 — I-5 verification reconciliation (2026-06-30)
RAID I-5 flagged 4 source_mappings carrying `verified=true` with stale notes reading "honest verified=false" (Meta EMQ, SendGrid event webhook, Meta Lead Ads/Messenger, Google gclid). The "false" note was an artifact of the deterministic grep running against **DAS internal DDL**, which by definition never contains external vendor-API fields. Checked each against its cited vendor research page and confirmed the field is documented there: `wiki:meta` (Dataset-Quality EMQ; Lead Ads/Messenger), `wiki:sendgrid` (event-webhook events delivered/open/click/bounce/unsubscribe), `wiki:google-ads` (GCLID click attribution via auto-tagging). `verified=true` here means *present in the cited vendor page* (not per-consumer-ingested by DAS today — access stays `api-unused`/`granted`). Rewrote the 4 notes to cite the wiki page as the evidence; no per-person verification is asserted. The "41/41 doc-confirmed" headline is now true against the cited sources.