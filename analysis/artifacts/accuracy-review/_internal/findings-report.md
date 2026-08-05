# DAS CDP Repository Hallucination Sweep — Findings Report

## 1. Verdict and base rate

The repository is broadly grounded but carries a concentrated cluster of high-impact errors around the golden record's approval status and the dealer-tenant scale figure. Across 19 slices, 408 grounded claims were checked and 68 problems found (16.7% defect rate): 8 high, 36 medium, 24 low. 35 problems reach the live chat assistant (`/api/chat`), meaning a client asking the portal agent can be told a stale or false fact. 40 external vendor/pricing facts were re-checked against primary sources. The dominant failure modes are status overclaim/underclaim on the canonical golden record, stale hardcoded literals in portal cards and specs, wrong-target decision anchors that survived the recent 72-anchor fix (commit 7a117d0), and two load-bearing external facts (Redshift floor, DAS dealer count) that skew cost/scale decisions.

## 2. HIGH-severity findings (client-facing or chat-reaching)

**Canonical golden record mislabeled "experimental v0" in three index sources — reaches chat**
`docs/source-of-truth.md:22`, `app/knowledge-pack.json` (path `analysis/artifacts/golden-record/record.json`), generator `scripts/gen-knowledge-pack.py:34`
Why wrong: all three describe `record.json` as "Candidate CDP golden-record fields (experimental v0)" / "Golden Record sketch (experimental v0)". `record.json` is the locked canonical v1: version=1, schema_version=1, status "v1.0 · reviewed & approved (Alicia + Luis, 2026-06-21)... all 55 materialized attrs verified", locked v1.0 2026-06-18. The "experimental v0" label belongs to the separate scaffold `analysis/artifacts/golden-record.json`, not the locked record.
Evidence: `worker.js:115` loads `knowledge-pack.json` into `/api/chat`, so the chat agent asserts the client-approved canonical record is an "experimental v0 sketch."

**Golden record self-contradicts on verification status — client sign-off doc**
`analysis/artifacts/golden-record/record.json:5,95`; `REVIEW.md:7`
Why wrong: changelog line 95 ("Hardened all 11 soft mappings to verified=true ... zero verified=false") flipped all 41 `source_mappings` to `verified:true` but left the disputing notes intact. 4 mappings carry `verified:true` with a note that says the opposite — e.g. Email-event webhook: `"verified": true, "note": "grep token too generic to confirm — honest verified=false"` (also EMQ, gclid, Lead Ads/Messenger).
Evidence: the headline "zero verified=false" is false against the file's own data; lives in the Alicia+Luis v1.0 sign-off and the portal golden-record tile. Does not project into brain nodes, so it does not reach chat directly.

**DataStaging table count off by +8 (108 claimed, 100 actual) — reaches chat**
`docs/databases/datastaging.md:29,182`; `README.md:51`; `app/brain.json` nodes[1548]
Why wrong: `schema.json` and a `CREATE TABLE` count on `dumps/datastaging.sql` both give 100 tables; core schema is 22, not 30. The 30 (and resulting 108 total) was copied from DWRPT_AI, which genuinely has core=30 / 108 tables.
Evidence: brain node 1548 label asserts "DataStaging (13 schemas, 108 tables, ~335 GB)"; `/api/chat` answers from this node. Fix doc, README row, brain node, and the line-182 core header (30→22).

**DAS dealer-tenant count ~1,700 conflicts with DAS's published 9,200+/9,300+ scale — reaches chat**
`docs/deliverables/executive-summary.md:26`; `privacy-by-design-framework.md:12`; `services-topology.md:39`; `reporting-data-flow.md:15`
Why wrong: DAS public marketing cites 9,300+ dealerships/partners and 9,200+ retailers. The only public "1,700" is the sample size of DAS's 2025 NADA Lead Response Study, not a tenant count. Using ~1,700 as the cost/scale/per-seat basis is ~5x below DAS's own published footprint.
Evidence: ZoomInfo + dastechnology.com. Caveat: 1,700 may be an intentional pilot/CDP cohort scope — confirm with engagement lead before changing, because it drives cost models. If it is total tenancy, models are under-sized 5x.

**Redshift Serverless "8-RPU floor" is stale — drives the cloud bake-off cost decision**
`docs/cloud-aws-vs-azure-bakeoff.md:62,68-90`; also bundled in `docs/deliverables/cloud-alignment.md:58,63,65`
Why wrong: AWS introduced a 4-RPU minimum base-capacity option in June 2025, expanded across regions through May 2026. Current floor is 4 RPU (4-RPU caps at 32 TB managed storage; >32 TB still needs ≥8 RPU). The flat "8-RPU floor" overstates Redshift's minimum cost ~2x and is the load-bearing rationale for "Synapse cheaper than Redshift." The Synapse pay-per-TB, AKS free-tier, and Event Grid CloudEvents 1.0 claims in the same bundle all check out.
Evidence: AWS Redshift serverless-capacity docs + the 4-RPU GA announcements. Update to "4-RPU minimum (8-RPU if >32 TB or region lacks 4-RPU)" and re-check the cost delta. The cloud-alignment.md bundle reaches chat.

**Juicebox "cannot perform SQL JOINs" is unverifiable and partially contradicted — reaches chat, underpins build/replace**
`docs/deliverables/reporting-data-flow.md:15`; `cdp-scoping-document.md:57`; also `analysis/sessions/session-synthesis-2026-06-08.md:157`
Why wrong: no public Juicebox doc states a "cannot JOIN" hard limitation. Juice Analytics' Juicebox markets data-blending and connects to SQL/BigQuery/Snowflake/Databricks; myjuicebox.io docs recommend a single-table report-modeling pattern (directionally consistent) but never prohibit JOINs. The claim originates from a live-demo characterization (Ron, DAS) of DAS's DWRPT pre-join setup, presented as a universal product limitation.
Evidence: it underpins the reporting-replacement rationale. Soften to "in DAS's deployment, data is pre-joined in DWRPT before Juicebox consumption" or cite a vendor source.

## 3. Cross-cutting patterns

**(a) Approval-status overclaim/underclaim on the golden record.** The single canonical artifact (`record.json`) is simultaneously *underclaimed* as "experimental v0" in three index/doc sources (high) and *overclaimed* as "zero verified=false" inside its own sign-off (high). Root cause: status strings are hand-authored in multiple places (`gen-knowledge-pack.py:34`, `source-of-truth.md`, `index.html` nav) instead of derived from `record.json.locked.version` / `status`. The detail view `analysis/artifacts/golden-record/index.html:340` does derive correctly (`d.locked.version` → v1.0) — proving the fix pattern.

**(b) Stale hardcoded literals that should be computed live.** Portal cards and specs hardcode counts that have since drifted from their generated sources:
- `reference/index.html:273-275` — "39 APIs / 9 categories" vs canonical 85/19 (`api-integration-catalog.md:3`).
- `reference/index.html:254-255` — "15 databases / 9 ERD" vs live `databases.json` 22/11/17.
- `knowledge/index.html:206-207` — "1,315 entities / 2,068 connections" vs live `knowledge_graph.json` 1492/2026.
- `index.html:334` — "Golden Record (v0.9)" vs locked v1.0.
- `docs/deliverables/detailed-phase-1-2-plans.md:54` — "852 points / 412–804 days" vs `estimates.json` 913 / 456.5–894 (also replicated in `docs/phase0-deliverables.json:150,209,210`). The doc itself claims these are "computed live ... never drift" while storing a stale figure.
- Chat-agent spec `02-portal-chat-agent.md:18` — "95-doc index" vs `knowledge-pack.json` count:387; "Claude Opus 4.8" vs `worker.js:10` MODEL="claude-sonnet-4-6".
Many of these cards have *no* `id`/fetch, so JS can never refresh them — they must either be driven from the JSON or deleted.

**(c) Archived-presented-as-live.** `artifacts/phase-0/deliverables/das-cdp-revised-architecture-plan.md` carries an "ARCHIVED — superseded by docs/cdp-architecture.md ... No longer maintained" header, yet is cited as the *current* architecture by `docs/client-agent-brief.md:19` ("Records the current recommended architecture") and named as a live deliverable by the three-doc Phase-0 framing in `specs/01-phase-0-discovery/00-epic.md:10` (+ kickoff:17, synthesis:21). The "DAS CDP Roadmap" named alongside it does not exist anywhere. Both reach chat. Repoint to `docs/cdp-architecture.md`.

**(d) Wrong-target decision anchors (survived commit 7a117d0).** A class of `#d-NNN` anchors point at real-but-unrelated decisions; the cited *content* is correct, the *pointer* is wrong, so a chat user following the anchor lands on a contradicting decision:
- "15 tables (11 core + 4 AI/ML stubs)" cited `#d-005` (says table count "not yet scoped") — correct anchor is the unanchored `decisions.md:158` (d-089 block). Recurs at `01-cdp-data-model-design.md:49,64`, `00-feature.md:64`, `01-data-model-foundation.md:17`, `13-semantic-glossary-term-registry.md:24`, `03-phase-1-close/01-architecture-review.md:27`, `02-custom-models-rag-on-cdp.md:25`.
- Bitemporal/provenance layer cited `#d-094` (deletion strategy) — content is at `decisions.md:158`. `00-feature.md:65`.
- Outbound-activation file `01-outbound-activation-connectors.md:22,24` has *swapped* anchors: consent-first-class content tagged d-012 (belongs to d-111); resolver-blocking-key content tagged d-010 (belongs to d-012).
- Exec-direction quote ("good for AI and good for regular application lifecycle events") cited `#d-098` (raw-first pipeline) — belongs to d-047. `01-model-assisted-identity-and-agentic-apps.md:18`.

**(e) Entity-resolution / curated-metadata divergence.** `session-synthesis-2026-06-08.md:10` (+ `session.json:7-14`) lists "Hiram Gonzalez" as an SSIS-review attendee; the transcript names "Sid" in that slot (Hiram appears 0× in the transcript, Sid 5×). The substituted name projects into `brain.json`, so chat answers "Hiram" for a person the source records as Sid.

**(f) Self-stale counts inside one file.** `record.json` claims "~35 of the 100+" sources while `source_registry` holds 73 entries, and "all 14 source categories" while there are 15 in-scope (16 total). Confluence pull counts are inconsistent across the wiki: `Confluence-Findings.md:4` says 51, `Sources.md:46,145,173` says 95, oracle `memory/sources.md:35` says 105, filesystem has 112.

## 4. Coverage gaps (load-bearing claims with no/weak brain projection)

- `record.json` `verified` flags are not projected into brain GoldenField nodes — the high-severity "zero verified=false" contradiction is invisible to chat and to any automated drift check; only a human reading REVIEW.md catches it.
- The stale "852 points" figure is not projected verbatim into `brain.json`, so chat won't repeat the literal, but the deliverable is a referenced brain node — a user can still be routed to the wrong number.
- Reference/knowledge portal cards (39 APIs, 15 dbs, 1,315 entities, Golden Record v0.9) are display-only and do not reach chat, but are client-facing on published pages with no oracle binding.
- External vendor facts (CDK 48-72hr lag, Tekion 10k-row cap, R&R CAPTCHA, BAC 246435, 700Credit hashed-SSN) across the 43 `wiki/*-API.md` pages are verifiable only against DAS-provided source docs, not the open web — they sit outside any oracle and should be marked client-validation asks.

## 5. Canonical-source issues

- **Status not derived from the canonical record.** The golden-record status string is authored in ≥4 places; only the detail view derives it. Bind all to `record.json.locked.version`/`status`.
- **`source-of-truth.md` owner table is itself a brain node** projecting the wrong "experimental v0" description of the canonical owner — the canonical map is contradicted at the place that is supposed to define canon.
- **DataStaging core-schema copy error** (30 from DWRPT_AI) propagated from the doc into README and brain node 1548 — one source error, three downstream surfaces.
- **`estimates.json` vs prose drift**: the deliverable claims live computation but stores 852/412–804 against the generated 913/456.5–894; `phase0-deliverables.json` replicates the stale triple.
- **OpenAI/Gemini vendor pages**: `wiki/OpenAI-API.md:19,47` cites fabricated audio IDs `gpt-audio-1.5`/`gpt-audio-mini` (real lineup: `gpt-realtime-*`, `*-transcribe`); `wiki/Gemini-API.md:17,58` states 2M-token context for Gemini 3.1 Pro (actual 1M). Both reach chat; text-model and retirement claims hold.

## 6. Recommended fixes (ranked)

1. **Golden-record status, single source.** Replace the hardcoded "experimental v0" in `gen-knowledge-pack.py:34`, `source-of-truth.md:22`, and `index.html:334` with a value derived from `record.json.locked.version`/`status`; regenerate `knowledge-pack.json`. Clears 4 high/med findings and the chat-reaching mislabel in one move.
2. **Reconcile `record.json` verified flags vs notes.** Either set the 4 disputed mappings back to `verified:false` or rewrite their notes; then the "zero verified=false" headline becomes true. Update REVIEW.md. (High — sits in the client sign-off.)
3. **DataStaging 100/22 correction.** Fix `datastaging.md:29,182`, `README.md:51`, and brain node 1548; regenerate brain. (High — reaches chat.)
4. **Confirm dealer count with engagement lead.** Decide whether ~1,700 is pilot scope or total tenancy; if total, re-size cost/scale/per-seat models and correct the 4 deliverables. (High — gates cost modeling.)
5. **Update Redshift floor to 4-RPU** in `cloud-aws-vs-azure-bakeoff.md` and `cloud-alignment.md`; re-check the Synapse-vs-Redshift cost delta. (High — drives build decision.)
6. **Soften the Juicebox "cannot JOIN" claim** to DAS-deployment-specific wording or cite a vendor source. (High — underpins build/replace.)
7. **Fix wrong-target anchors** (pattern d): repoint the 15-table/bitemporal/consent/resolver/exec-direction anchors to d-089/d-111/d-012/d-047 and the unanchored `decisions.md:158` block. Extend the 7a117d0 anchor-audit to catch the swapped-pair class.
8. **Re-bind portal cards to live JSON or delete the static counts**: reference (39→85, 15→22/9→11), knowledge (1,315/2,068→live), estimates (852→913). Add `id` + fetch where missing.
9. **Correct the chat-agent spec**: model Sonnet-4.6 (not Opus 4.8), 387-doc index (not 95), add `search_graph` tool.
10. **Repoint `client-agent-brief.md:19`** and the three-doc Phase-0 framing to `docs/cdp-architecture.md`; note the "Roadmap" doc does not exist.
11. **Fix SSIS attendee** Hiram→Sid in synthesis + `session.json`; regenerate brain.
12. **Reconcile self-stale counts**: `record.json` "~35"→73 and "14 categories"→15; Confluence pull count to 112 across `Confluence-Findings.md`, `Sources.md`, `Home.md`.
13. **Fix vendor model IDs**: OpenAI audio IDs → `gpt-realtime-*`/`*-transcribe`; Gemini 3.1 Pro context 2M→1M.
14. **Low-confidence external facts** (Reddit 2026-07-13 pixel mandate, App Gateway $0.20→$0.246/hr, CDK 3PA vs Authenticom trim) — mark unverifiable/client-validation or correct to primary-source values.