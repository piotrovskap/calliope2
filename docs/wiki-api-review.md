# Wiki API Research Review

> **HISTORICAL AUDIT LOG — not current state.** This is the point-in-time quality audit from 2026-06-17 and its resolution trail. **All findings are resolved** (see the RESOLVED banner under "Priority Fix Groups"). Current per-API state lives on each `wiki/*-API.md` page and in `docs/wiki-research-catalog.json` — not here. Do not quote the findings below as current; read them as the audit record. Status vocabulary: [`status-glossary.md`](status-glossary.md).

**Purpose:** Systematic quality pass over all CDP Research Pages (wiki `*-API.md` files) and the API Integration Catalog to surface template deviations, standards gaps, and veracity problems before Phase 1 build work begins.
**Scope:** 37 wiki `*-API.md` pages · `analysis/artifacts/api-integration-catalog/index.html` · `docs/wiki-research-catalog.json`
**Date:** 2026-06-17
**Methodology:** Each page checked against three dimensions (T/S/V). Findings recorded below; fixes belong in follow-up PRs.

---

## Status Legend

| Symbol | Meaning |
|--------|---------|
| ✓ | Passes — no issues found |
| ⚠ | Minor issue — deviates from standard but not blocking |
| ✗ | Significant issue — missing section, factual conflict, or broken standard |

**Columns:** **T** = Template · **S** = Standards · **V** = Veracity

**Template checklist (A):** Status line format `Phase 0 research — researched & verified YYYY-MM-DD` · preamble · all 10 sections (Overview, CDP Activation Roadmap, Key Details table, Documentation, DAS Current Usage, CDP Relevance, Feature Map, Current vs. Potential, Open Questions, References) · catalog cross-link in header.

**Standards checklist (B):** Auth documented in Key Details · Rate limits present · API version stated · Identity keys row · CDP priority row · ≥1 DAS internal ref · Catalog cross-link uses correct category label.

**Veracity checklist (C):** Wiki status matches catalog status · Auth tag matches catalog · `[ ]` open questions unresolved noted · Stale version claims flagged · No internal contradictions · No placeholder sections.

---

## Summary Table

> _Snapshot as of 2026-06-17. The per-page T/S/V grades below are **superseded** for the 17 P0/P1 pages (upgraded 2026-06-21) and by the P2/P3 resolutions — see Priority Fix Groups. Grades are not maintained cell-by-cell; treat Priority Fix Groups as the current state._

| # | Wiki Page | Cat | T | S | V |
|---|-----------|-----|---|---|---|
| **Ad Platforms** |
| 1 | Amazon-Ads-API.md | Ad Platforms | ⚠ | ✓ | ⚠ |
| 2 | Bing-Ads-API.md | Ad Platforms | ✓ | ✓ | ⚠ |
| 3 | Google-Ads-API.md | Ad Platforms | ⚠ | ⚠ | ✗ |
| 4 | Meta-Facebook-Marketing-API.md | Ad Platforms | ✓ | ✓ | ⚠ |
| 5 | Reddit-Ads-API.md | Ad Platforms | ⚠ | ⚠ | ✗ |
| 6 | TikTok-Ads-API.md | Ad Platforms | ⚠ | ⚠ | ⚠ |
| 7 | YouTube-Data-API.md | Ad Platforms | ⚠ | ⚠ | ✗ |
| **Communications** |
| 8 | ETS-Dashboard-API.md | Communications | ⚠ | ⚠ | ⚠ |
| 9 | ETS-Facebook-SMS-Proxy-API.md | Communications | ⚠ | ⚠ | ⚠ |
| 10 | LiveJoin3-Service-API.md | Communications | ⚠ | ⚠ | ⚠ |
| 11 | Mailgun-API.md | Communications | ✓ | ✓ | ✓ |
| 12 | Mandrill-API.md | Communications | ⚠ | ⚠ | ⚠ |
| 13 | Microsoft-Graph-Outlook-API.md | Communications | ✗ | ⚠ | ✗ |
| 14 | Rocket.Chat-ETS-API.md | Communications | ⚠ | ⚠ | ⚠ |
| 15 | SendGrid-API.md | Communications | ⚠ | ⚠ | ⚠ |
| **DMS / CRM** |
| 16 | Microsoft-Dynamics-365-API.md | DMS/CRM | ✓ | ✓ | ✓ |
| 17 | Salesforce-SFDC-API.md | DMS/CRM | ⚠ | ✓ | ⚠ |
| 18 | Tekion-DMS-API.md | DMS/CRM | ✓ | ✓ | ⚠ |
| **Data Enrichment** |
| 19 | Experian-Conquest-API.md | Data Enrichment | ⚠ | ✗ | ✗ |
| 20 | MaxMind-GeoIP2-API.md | Data Enrichment | ⚠ | ✗ | ✗ |
| 21 | NeverBounce-API.md | Data Enrichment | ⚠ | ✗ | ✗ |
| **Vehicle Valuation** |
| 22 | BlackBook-API.md | Vehicle Valuation | ✓ | ✓ | ✓ |
| **Marketplace** |
| 23 | Craigslist-API.md | Marketplace | ✓ | ✓ | ⚠ |
| 24 | eBay-API.md | Marketplace | ✗ | ⚠ | ⚠ |
| 25 | Facebook-Marketplace-API.md | Marketplace | ✓ | ✓ | ⚠ |
| **Reviews** |
| 26 | CallRevu-API.md | Reviews | ✓ | ✓ | ✓ |
| 27 | CarGurus-API.md | Reviews | ✓ | ✓ | ⚠ |
| 28 | Carfax-API.md | Reviews | ✓ | ✓ | ✗ |
| 29 | DealerRater-API.md | Reviews | ✓ | ✓ | ⚠ |
| 30 | Edmunds-API.md | Reviews | ✓ | ✓ | ⚠ |
| 31 | Mozenda-Scraping-API.md | Reviews | ✓ | ✓ | ⚠ |
| 32 | Vendasta-Reputation-API.md | Reviews | ✓ | ✓ | ⚠ |
| **Social / Listings** |
| 33 | Soci-API.md | Social/Listings | ✓ | ✓ | ⚠ |
| 34 | Yext-API.md | Social/Listings | ✓ | ✓ | ⚠ |
| **Billing** |
| 35 | CyberSource-API.md | Billing | ✓ | ✓ | ⚠ |
| 36 | QuickBooks-API.md | Billing | ✗ | ⚠ | ⚠ |
| 37 | Zuora-API.md | Billing | ✗ | ⚠ | ⚠ |

**Clean pages (all ✓):** Mailgun-API.md · Microsoft-Dynamics-365-API.md · BlackBook-API.md · CallRevu-API.md

---

## Catalog-Level Findings

### ~~CL-1 — CyberSource-API.md missing from wiki-research-catalog.json~~ ✓ Fixed 2026-06-17
~~`docs/wiki-research-catalog.json` has 36 entries; the wiki has 37 `*-API.md` files. `CyberSource-API.md` exists on disk and is referenced in the API Integration Catalog but has no JSON catalog entry.~~ Entry added; catalog now has 37 entries.

### CL-2 — Microsoft-Graph-Outlook-API.md status conflict
`docs/wiki-research-catalog.json` status: `in-progress`. API Integration Catalog badge: `Researched`. The page itself says "Researched (Stage 5)" in the header but "Spike in progress" in the body. All three sources disagree.

### CL-3 — APIs in Integration Catalog with no wiki page _(KBB / Cars.com / Recall Masters resolved 2026-06-21)_
The API Integration Catalog (41 entries) includes entries with no corresponding wiki page:
- **OpenAI** (AI/ML) — catalog badge: Researched — **no wiki page**
- **Google Gemini** (AI/ML) — catalog badge: Researched — **no wiki page**
- **Twilio** (Communications) — catalog badge: Researched — **no wiki page**
- ~~**Kelley Blue Book / KBB** (Vehicle Valuation) — catalog badge: Pending — no wiki page~~ ✓ Resolved 2026-06-21
- ~~**Cars.com** (Reviews) — catalog badge: Pending — no wiki page~~ ✓ Resolved 2026-06-21
- ~~**Recall Masters** (Reviews) — catalog badge: Pending — no wiki page~~ ✓ Resolved 2026-06-21

**Update 2026-06-21:** the finding is inverted for the three vehicle pages — `wiki/Kelley-Blue-Book-KBB-API.md`, `wiki/Cars.com-API.md`, and `wiki/Recall-Masters-API.md` exist on disk; the gap was the research catalog, not the wiki. All three are now entered in `docs/wiki-research-catalog.json` (KBB as `in-progress`, Cars.com and Recall Masters as `researched`, matching each page's status line). The OpenAI / Gemini / Twilio half remains open — the catalog asserts research complete but no wiki page exists for those three.

### ~~CL-4 — "Stage 5" template group: 13 pages use wrong format~~ ✓ Upgraded 2026-06-21
A large group of pages use a legacy operational template ("Stage 5") instead of the CDP research template. These pages share the same structural gaps: no preamble, no Key Details table, no CDP Activation Roadmap, no CDP Relevance, no Feature Map, no Current vs. Potential Usage, no Open Questions.

**Catalog cross-link added ✓** to all 13 pages: ETS-Dashboard, ETS-Facebook-SMS-Proxy, LiveJoin3-Service, Mandrill, Microsoft-Graph-Outlook, Rocket.Chat-ETS, SendGrid, Experian-Conquest, MaxMind-GeoIP2, NeverBounce, eBay, QuickBooks, Zuora.

**Full template upgrade — DONE 2026-06-21:** all 13 pages upgraded to the CDP research template (Mailgun-API.md reference) via the `api-page-cleanup` workflow; existing content preserved, gaps explicitly marked unverified, no fabrication (adversarial verify passed). See Priority Fix Groups below.

### ~~CL-5 — "& verified" wording inconsistency~~ ✓ Fixed 2026-06-17
All Phase 0 research status lines now use `researched & verified YYYY-MM-DD`. Fixed on 12 pages: Amazon, Reddit, TikTok, YouTube, CallRevu, CarGurus, Craigslist, Facebook Marketplace, Soci, Yext, CyberSource, Microsoft Dynamics 365. Also cleaned Google Ads status line parenthetical (F5).

### ~~CL-6 — Paired catalog rows not cross-referenced in wiki~~ ✓ Partially fixed 2026-06-17
Vendasta↔Mozenda already cross-referenced each other. DealerRater→Edmunds link added to `DealerRater-API.md` preamble (Edmunds→DealerRater already existed). All four pages now acknowledge the catalog pairing.

---

## Per-Page Findings

_Only pages with ⚠ or ✗ findings. Clean pages (all ✓) are in the summary table only._

---

### Ad Platforms

#### Amazon-Ads-API.md
- **T ⚠** Status line says "researched" without "& verified"
- **V ⚠** P0① deadline "June 30, 2026" has passed (today 2026-06-17 — 13 days remaining when reviewed); status not marked resolved
- **V ⚠** Open question on AMC workspace eligibility unresolved

#### Bing-Ads-API.md
- **V ⚠** Open question "Is LinkedIn Profile Targeting available via the v13 Bulk or Campaign Management API?" — unresolved, not marked with resolution status
- **V ⚠** SOAP deprecation deadline Jan 31, 2027 noted but no current production code audit logged

#### Google-Ads-API.md
- **T ⚠** Status line includes parenthetical "(adversarial fact-check against primary sources; corrections applied)" — non-standard wording
- **S ⚠** Auth row in Key Details flagged as "unverified from current sources" — fails standards requirement for confirmed auth documentation
- **V ✗ CRITICAL** Key Details states "API version (current, 2026-06): v23" but immediately flags "v17 was sunset June 4, 2025 — catalog entry is stale" — internal contradiction; the API Integration Catalog still shows v17 in its research references; Open Question P0② ("Verify API version in production — v17 sunset June 4, 2025, may be a live production issue") is unresolved; whether `media-logix-googleads-processor` has been migrated to v23 is unknown

#### Meta-Facebook-Marketing-API.md
- **V ⚠** Page ratings endpoint deprecated 2025-09-09 documented correctly but the CDP Relevance table marks the feature as "Dead" — this is accurate but the integration catalog still links to the pre-deprecation Confluence page without a deprecation note
- **V ⚠** Multiple unresolved open questions including OAuth scope confirmation and Messenger ingestion scope

#### Reddit-Ads-API.md
- **T ⚠** Status line: "researched" without "& verified"
- **S ⚠** Allow-list approval from Reddit partner team (`adsapi-partner-support@reddit.com`) unknown — documented as P0③ blocker but unresolved
- **S ⚠** API version gap: Explorer v5 shows v2.1; current Reddit Ads API is v3; P0① "Confirm API version in `media-logix-adcenter` targets v3" unresolved
- **V ✗ URGENT** Breaking change: `conversion_pixel_id` required on all ad groups before **July 13, 2026** (26 days from review date) — DAS fix not confirmed
- **V ✗** Integration described as "in progress" / "not deployed" — catalog badge says Researched but integration is not live
- **V ✗** Open question: "What is the `rdt_cid` capture architecture?" — foundational design question with no answer

#### TikTok-Ads-API.md
- **T ⚠** Status line: "researched" without "& verified"
- **S ⚠** Critical post-launch discovery items unresolved: Lead Generation status "Unknown — no evidence in Explorer v5" (P0 item); TikTok Pixel deployment "Unknown — no evidence in Explorer v5" (P0 item)
- **V ⚠** AIA (Automotive Inventory Ads) "not yet in use — launched after DAS's December 2025 rollout"; auth scopes documented but production grant set not confirmed

#### YouTube-Data-API.md
- **T ⚠** Status line: "researched" without "& verified"
- **S ⚠** VIN → `videoId` mapping "not accessible to the CDP or sales tooling" — flagged as P0① prerequisite, unresolved
- **V ✗ CRITICAL PRODUCTION RISK** API project verification status of LotVantage's YouTube API project is unknown. Per Google policy, all videos uploaded via `videos.insert` from unverified projects created after July 28, 2020 are locked to private visibility until a compliance audit passes. If LotVantage's project is unverified, **all inventory videos uploaded via the API may be silently private with no alert or visible error** — a live P0 defect if true. Documented as Open Question ①; unresolved.
- **V ✗** Open question: "What is the VIN → `videoId` mapping source of truth?" — foundational prerequisite missing

---

### Communications

#### ETS-Dashboard-API.md _(Stage 5 template)_
- **T ⚠** Status format: "Researched (Stage 5)" — not "Phase 0 research — researched & verified YYYY-MM-DD"
- **T ⚠** Missing preamble, Key Details table, CDP Activation Roadmap, CDP Relevance, Feature Map, Current vs. Potential Usage, Open Questions, catalog cross-link
- **S ⚠** Auth/rate limits/version documented in narrative prose but not in the standard structured table

#### ETS-Facebook-SMS-Proxy-API.md _(Stage 5 template)_
- **T ⚠** Same Stage 5 template gaps as ETS-Dashboard: no preamble, no Key Details table, no CDP sections, no catalog cross-link
- **S ⚠** Auth (webhook signature + oauth2) documented in prose, not structured table; no repo ownership for BCProxy integration

#### LiveJoin3-Service-API.md _(Stage 5 template)_
- **T ⚠** Same Stage 5 template gaps; JWT auth documented in prose, not Key Details table
- **S ⚠** No rate limits, no API version, no identity keys, no CDP priority, no catalog cross-link

#### Mandrill-API.md _(Stage 5 template)_
- **T ⚠** Stage 5 template gaps; no preamble, no Key Details table, no CDP sections, no catalog cross-link
- **S ⚠** Auth (API key) and rate limits (10,000/min) mentioned in Overview but not in a structured row
- **V ⚠** No DAS internal references; no Open Questions; no CDP relevance analysis

#### Microsoft-Graph-Outlook-API.md _(Stage 5 template — triple status conflict)_
- **T ✗** Header says "Researched (Stage 5)" but body says "Spike in progress (SPIKE — Review Outlook and RADAR Integration)"; these directly contradict each other within the same page
- **T ✗** Full Stage 5 template gaps: no preamble, no Key Details table, no CDP sections, no catalog cross-link
- **V ✗** Three-way status conflict: page header = "Researched", page body = "Spike in progress", `wiki-research-catalog.json` = "in-progress", API Integration Catalog = "Researched"; none of these agree
- **V ✗** No DAS internal references captured; no Open Questions; no resolution of spike findings

#### Rocket.Chat-ETS-API.md _(Stage 5 template)_
- **T ⚠** Stage 5 template gaps; no preamble, no Key Details table, no CDP sections, no catalog cross-link
- **S ⚠** Auth (API key + OAuth token + system bot) documented in narrative; API version inferred from endpoints but not explicitly stated

#### SendGrid-API.md _(Stage 5 template)_
- **T ⚠** Stage 5 template gaps; no preamble, no Key Details table, no CDP sections, no catalog cross-link
- **S ⚠** API version v3 inferable from context but not stated; rate limits (100 req/s) mentioned in auth section only

---

### DMS / CRM

#### Salesforce-SFDC-API.md
- **T ⚠** Status line says "researched & verified" but API Integration Catalog marks Salesforce as **Pending** — mismatch not acknowledged in the page
- **V ⚠** Known reliability note about `Has Synchronization Issues` flag-clearing being undocumented (lines 74–75) is NOT captured as an Open Question — the issue may persist silently
- **V ⚠** Known reliability note about Facebook review endpoint shut-off (2025-09-09) IS captured as Open Question but its impact on current Case creation flow is unresolved

#### Tekion-DMS-API.md
- **V ⚠** 10k-row CSV export hard limit is documented as a confirmed operational bottleneck (multiple sections) but is NOT formally in the Open Questions list as a blocking item; resolution status ambiguous
- **V ⚠** P0 action "Register DAS as APC Standard partner" (REC-01) is explicitly unresolved — integration requires this before API access can be formalized; current status not updated since page authoring

---

### Data Enrichment

#### Experian-Conquest-API.md _(Stage 5 template — structural failure)_
- **T ⚠** Status format: "Researched (Stage 5)"
- **T ⚠** Missing: preamble, Key Details table, CDP Activation Roadmap, CDP Relevance, Feature Map, Current vs. Potential Usage, Open Questions, catalog cross-link
- **S ✗** No Key Details table — auth (expected api-key), rate limits, API version, identity keys, CDP priority all undocumented in structured form
- **V ✗** No Open Questions section — any unknowns are not captured; Integration Architecture section is a flowchart with no narrative explanation; Configuration section is generic operations guidance, not CDP research

#### MaxMind-GeoIP2-API.md _(Stage 5 template — structural failure)_
- **T ⚠** Status format: "Researched (Stage 5)"
- **T ⚠** Missing: preamble, Key Details table, CDP Activation Roadmap, CDP Relevance, Feature Map, Current vs. Potential Usage, Open Questions, catalog cross-link
- **S ✗** No Key Details table — auth (expected api-key), rate limits, identity keys, CDP priority all undocumented in structured form; "Troubleshooting" and "Security" sections indicate operational runbook, not CDP research artifact
- **V ✗** No Open Questions; no verification of field-to-CDP mapping; no stale version check

#### NeverBounce-API.md _(Stage 5 template — structural failure)_
- **T ⚠** Status format: "Researched (Stage 5)"
- **T ⚠** Missing: preamble, Key Details table, CDP Activation Roadmap, CDP Relevance, Feature Map, Current vs. Potential Usage, Open Questions, catalog cross-link
- **S ✗** No Key Details table — auth (expected api-key), rate limits, API version, identity keys, CDP priority all undocumented; "Troubleshooting" and "Security" sections indicate operational runbook, not CDP research artifact
- **V ✗** No Open Questions; no CDP data consumption analysis

---

### Marketplace

#### eBay-API.md _(Stage 5 template)_
- **T ✗** Status format: "Researched (Stage 5)"; full Stage 5 template gaps (no preamble, no Key Details table, no CDP sections, no catalog cross-link); appears transcribed from an artifact rather than authored as a wiki page
- **S ⚠** Uses legacy SOAP/XML Trading API — this architectural fact is present in code samples but not highlighted in the main narrative or a structured "API Reference" section per standard; API version not explicitly stated; CDP priority not stated
- **V ⚠** No Open Questions section; no CDP Relevance analysis

#### Craigslist-API.md
- **T ✓** (minor: status says "researched" without "& verified")
- **V ⚠** Two outbound pipelines (`obf_CraigsListLV_Ads` vs. `obf_CraigsListDT_Ads`) distinction flagged as P0 architectural investigation — unresolved; 6 open questions on schema, pipeline distinction, per-dealer authorization model all unresolved

#### Facebook-Marketplace-API.md
- **T ✓** (minor: status says "researched" without "& verified")
- **V ⚠** P0 unresolved open question ①: "Are Marketplace leads captured anywhere in the current DAS stack?" — foundational identity data from Marketplace leads is currently unclaimed; no resolution documented

---

### Reviews

#### Carfax-API.md
- **V ✗** 8 unresolved open questions covering critical implementation unknowns: exact Service History API endpoint URL; contract expiry date; CarFaxManager file format; why `ibf_CarFax` DB table shows 0 rows (suggesting integration may be broken or unused); scope of `sl-reviews-carfax-fa-prod`; recall data completeness; `carFaxID` stability; rate limit feasibility. The 0-rows finding on `ibf_CarFax` in particular suggests a possibly broken inbound integration.

#### CarGurus-API.md
- **V ⚠** 6 unresolved open questions including ADF lead source tagging and review record storage location; page describes a dual role (reviews + leads via ADF email) that is broader than the catalog's "Used By=Social Logix" description suggests

#### DealerRater-API.md
- **V ⚠** 8 unresolved open questions (operational, not design-blocking); page does NOT cross-reference Edmunds pairing as noted in catalog (CL-6); catalog category shows "Radar (Reviews)" which conflicts with the standard "Reviews" label

#### Edmunds-API.md
- **V ⚠** Dual role (ADF leads + Reviews) documented; P0 blocker question "Does ADF identity land in CDP?" unresolved; does NOT cross-reference DealerRater pairing (CL-6); 8 open questions

#### Mozenda-Scraping-API.md
- **V ⚠** 8 open questions including critical: ToS compliance audit unresolved; Vendasta overlap unknown; scrape target list beyond yellowpages.com not confirmed; does NOT cross-reference Vendasta pairing (CL-6)

#### Vendasta-Reputation-API.md
- **V ⚠** 6 open questions including: `sourceId` values for automotive platforms (Cars.com, DealerRater, Edmunds, CarGurus) not fully documented — requires vendor inquiry; overlap with Mozenda scraping sources unresolved; does NOT cross-reference Mozenda pairing (CL-6)

---

### Social / Listings

#### Soci-API.md
- **T ✓** (minor: status says "researched" without "& verified")
- **V ⚠** Soci/Yext GBP boundary left as open question ⑤ — both tools write to Google Business Profile and risk conflicting NAP data; no resolution documented; does NOT acknowledge Yext co-listing in catalog

#### Yext-API.md
- **T ✓** (minor: status says "researched" without "& verified")
- **V ⚠** Open question ④ "What is the Soci / Yext boundary for Google Business Profile?" — critical: conflicting writes from both tools to GBP is a live operational risk; does NOT acknowledge Soci co-listing in catalog

---

### Billing

#### CyberSource-API.md
- **V ⚠** 5 open questions; critical: Zuora/CyberSource relationship (which system is billing source of truth) explicitly flagged as a prerequisite blocker; not in `wiki-research-catalog.json` (CL-1)

#### QuickBooks-API.md _(Stage 5 template)_
- **T ✗** Status format: "Researched (Stage 5)"; full Stage 5 template gaps (no Key Details table, no CDP sections, no catalog cross-link)
- **S ⚠** OAuth 2.0 documented in API Reference prose; rate limits not stated; CDP priority not stated; no CDP Relevance assessment (implicit B2B billing only — not CDP-usable)
- **V ⚠** No acknowledgment of CyberSource relationship (both are billing APIs); no cross-reference

#### Zuora-API.md _(Stage 5 template)_
- **T ✗** Status format: "Researched (Stage 5)"; full Stage 5 template gaps
- **S ⚠** OAuth 2.0 + API key documented in prose; rate limits (1,000 req/min) in Overview but not Key Details; API version (v2) stated; CDP priority not stated
- **V ⚠** No CDP Relevance section; no acknowledgment of CyberSource relationship; no cross-reference to CyberSource-API.md despite that page flagging Zuora/CyberSource relationship as a blocker

---

## Priority Fix Groups

> **P0 + P1 RESOLVED 2026-06-21** via the `api-page-cleanup` multi-agent workflow (17/17 pages passed adversarial no-fabrication verify). All 5 P0 pages and 13 P1 (CL-4) pages were upgraded to the CDP research template; flagged external facts were re-verified against vendor docs and corrected with citations (e.g. Google Ads current version v17→**v24**; Carfax owner IHS Markit→**S&P Global Mobility**; MS-Graph throttling limits; legacy `docs.microsoft.com`→`learn.microsoft.com`). **DAS-internal states that are not externally verifiable** — deployment/migration status, the Carfax `ibf_CarFax` 0-row feed, the MS-Graph Radar-Outlook spike state, the Reddit `conversion_pixel_id` DAS fix status (the mandate itself is now vendor-confirmed) — are now **explicitly flagged ACTION REQUIRED (needs DAS confirmation)** on each page rather than asserted; they are tracked there for DAS, not closed here. **P2 (catalog hygiene) and P3 (open-questions) reconciled/closed 2026-06-21** — see below.
>
> **API research is a living workstream that continues past the Phase-0 docs.** This audit is a point-in-time snapshot, not a "must all be done" gate. All 43 API research pages are now **researched** (research-catalog: 43 researched / 0 in-progress / 0 placeholder) as of 2026-06-21 — Microsoft-Graph-Outlook and Kelley-Blue-Book were completed via a deepen + adversarial-verify double pass; OpenAI/Gemini/Twilio were researched the same day. Public/vendor facts are web-verified + cited; DAS-internal state on each page stays flagged unverified. API research nonetheless remains a living workstream (continues past Phase-0 as sources onboard).

### ~~P0 — Urgent / Production Risk~~ ✓ Resolved 2026-06-21 (table below is the historical 2026-06-17 finding)
_Original findings, kept for the record — all resolved by the #6 workflow (see the banner at the top of Priority Fix Groups; e.g. Google Ads is now v24, not the "v17→v23" below; the Reddit July 13, 2026 `conversion_pixel_id` mandate is now vendor-confirmed, only the DAS fix status is unverified). Current state lives on each page and in the banner, not in this table._

| Finding (historical) | Page | Issue (historical) |
|---------|------|-------|
| YouTube API project verification | YouTube-Data-API.md | Inventory videos may be silently private — live P0 defect if unverified |
| Google Ads API version v17→v23 | Google-Ads-API.md | v17 sunset June 4, 2025; production migration status unknown |
| Reddit Ads breaking change | Reddit-Ads-API.md | `conversion_pixel_id` required by July 13, 2026 (~26 days) — vendor-confirmed mandate; DAS fix status unconfirmed |
| Microsoft-Graph-Outlook triple conflict | Microsoft-Graph-Outlook-API.md | Three-way status conflict; spike state unclear |
| Carfax `ibf_CarFax` 0 rows | Carfax-API.md | Inbound integration may be broken or never deployed |

### ~~P1 — Template Upgrade Required~~ ✓ Done 2026-06-21 (historical)
All Stage 5 template pages (CL-4) — **upgraded 2026-06-21** to the CDP research template: ETS-Dashboard, ETS-Facebook-SMS-Proxy, LiveJoin3-Service, Mandrill, Microsoft-Graph-Outlook, Rocket.Chat-ETS, SendGrid, Experian-Conquest, MaxMind-GeoIP2, NeverBounce, eBay, QuickBooks, Zuora.

**Reference template:** `wiki/Mailgun-API.md` is the best-compliant example.

### ~~P2 — Catalog Hygiene~~ ✓ Reconciled 2026-06-21
| Finding | Resolution (2026-06-21) |
|---------|--------|
| CL-1: CyberSource missing from wiki-research-catalog.json | ✓ Already fixed (entry present). |
| CL-2: Microsoft-Graph-Outlook status conflict | ✓ Reconciled to **in-progress** (2026-06-21), then **completed to `researched`** via a deepen + adversarial-verify double pass — public Graph facts re-verified against Microsoft Learn; the DAS Radar-Outlook spike state stays flagged unverified. |
| CL-3: OpenAI / Gemini / Twilio researched in catalog, no wiki page | ✓ **Full research pages created 2026-06-21** (`OpenAI-API.md`, `Gemini-API.md`, `Twilio-API.md`) — web-verified + cited; research-catalog status `researched`. (Originally stubbed as placeholders, then completed.) |
| CL-6: DealerRater+Edmunds / Vendasta+Mozenda not cross-referenced | Deferred to Phase-1 source onboarding — pairing notes are per-source onboarding detail, not a Phase-0 blocker. |
| CL-5: Soci/Yext GBP boundary | Phase-1 onboarding detail (which tool owns Google Business Profile is a per-source integration decision); not a Phase-0 blocker. |
| Salesforce / Tekion catalog vs page status | ✓ No conflict — catalog now reads `researched`, consistent with the pages (the earlier "Pending" mismatch was already reconciled). |

### ~~P3 — Veracity / Open Questions Cleanup~~ ✓ Closed-by-policy 2026-06-21
**Resolved 2026-06-21 (Leo).** The per-page open questions (CarGurus, DealerRater, Edmunds, Mozenda, Vendasta, Craigslist, Facebook-Marketplace, CyberSource, Soci, Yext, Tekion, Salesforce, TikTok, Amazon, Bing) are **Phase-1 per-source onboarding detail, not Phase-0 design blockers** — the CDP intake is source-agnostic (bus-agnostic adapters + EAV+JSONB), so any source/field/contract specifics slot in at integration time without redesign (same stance as the source-availability asks in `memory/open-questions.md`). A closure note was added to each page's Open Questions section; the questions are retained there as the per-source onboarding checklist. **This research continues past the Phase-0 docs** — folks keep feeding it.
