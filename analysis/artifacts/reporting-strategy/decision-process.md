# Reporting Layer — Decision Process

How the reporting-layer recommendation (see `strategy.json` / the Reporting Strategy artifact) was reached. This is the methodology record and a scrubbed working-session log, kept so the reasoning is auditable and reproducible.

**Decision:** Replace Juicebox with a two-layer reporting architecture. Layer A (customer-facing, ~1,700 dealer tenants) on **Apache Superset run as a headless/embedded engine**; Layer B (internal authoring) on the same Superset instance. The whole baseline is open-source, self-hosted, $0 license. **Metabase Pro** is an optional add-on for non-technical self-serve authoring, not a core dependency. **Custom-build** and **Evidence.dev** are documented alternatives.

**Owners:** Alicia Salazar, Luis Hernandez. **Date:** 2026-06-14. **Status:** draft v1, one spike open (see Open Items in the artifact).

---

## Why this was on the table

"Evaluate Juicebox replacement (Power BI, Metabase, custom) for CDP reporting layer" was an open HIGH action item from the 2026-06-08 reporting/Juicebox review. Juicebox is the current client-facing reporting tool (221 reports, iframe-embedded, cannot perform SQL joins) and is explicitly not on the long-term roadmap. The CDP must serve dealer-facing reporting without inheriting Juicebox.

## Requirements taken from discovery

- Customer-facing, embedded, **white-label** dealer dashboards across ~1,700 dealer tenants.
- **Per-tenant data isolation is non-negotiable** (dealer-level), consistent with the CDP's privacy-by-design / multi-tenant model.
- Scale to millions of rows.
- Preserve self-serve authoring for non-technical product staff (the role Juicebox filled).
- Thin internal BI ops (no Power BI developers; offshore team already stretched).
- **Self-hosted** (hosted/Cloud rejected) and pricing-sensitive at 1,700-dealer fan-out.

## Method

1. Framed the problem as two layers with opposite cost/skill profiles — high-fan-out view-only vs bounded self-serve authoring — so a single tool was never going to be optimal for both.
2. Evaluated four approaches (Superset, Metabase, Evidence.dev, custom-build) against six axes (license/cost, isolation, white-label, authoring, serving/freshness, ops).
3. Ran current, source-cited research on each off-the-shelf tool (licensing, self-host embedding, multi-tenancy, and especially cost-at-scale), since pricing and embedding feature-gating change frequently.
4. Adversarially pressure-tested the cost model at 1,700 tenants, which is where Metabase's per-authenticated-external-viewer pricing breaks down.
5. Reviewed the Superset REST API, which showed it can be driven as a headless engine (BI-as-code via YAML export/import; guest-token + RLS minted programmatically) — this collapsed the "Superset vs custom-build" choice into "custom front-end + Superset engine."
6. Positioned commercial tooling (Metabase Pro) as optional so the recommendation rests on an open, $0-license baseline.

## Key findings (with sources, as of 2026-06)

- **Superset** — Apache-2.0, fully self-hostable, $0 license at any tenant count (tenants are guest-token sessions, not seats). Embedded SDK + guest-token RLS is purpose-built for per-tenant embedding; white-labeling is credible on 6.0+. Full REST API (dashboards/charts/datasets CRUD, YAML import/export, `security/guest_token`, Row-Level-Security endpoints, roles/permissions). You own a Postgres+Redis+Celery stack, the token-minting service, and an internet-facing CVE patch cadence. Sources: superset.apache.org docs (developer API, theming, async-queries), Embedded SDK README, guest-token + validator-hook PRs.
- **Metabase** — free OSS self-host lacks sandboxing, white-label, and SSO, so it does not meet requirements unpaid. Pro/Enterprise add data sandboxing, a first-class Tenants feature (JWT auto-provisioning for thousands), white-label, and the best non-technical drag-and-drop authoring. Decisive risk is commercial: authenticated/SSO external viewers are billable; at 1,700 dealers that is ~$220K-$1M+/yr on list pricing unless a negotiated Enterprise unlimited-end-user term is secured (anchored "$20k+/yr", unverifiable without a quote). Non-billable guest embedding exists but is view-only/locked. Sources: metabase.com pricing, embedding-introduction docs, tenants docs, row-and-column-security docs.
- **Evidence.dev** — MIT, BI-as-code (SQL + markdown + git), static-site build. Cheapest to serve and fully branded, but build-time only (rebuild-stale data) and its data-ships-to-browser model means a shared site leaks; safe isolation requires one static build per dealer, i.e. a 1,700-way build pipeline plus all auth/routing built by us. Code-only authoring (not for non-technical users). Sources: docs.evidence.dev (deployment, best-practices), Universal SQL, RLS discussion #3026, evidence.dev pricing/blog.
- **Custom-build** — strongest fit for the standardized customer-facing layer (live data, server-side isolation reusing our own auth, full white-label, $0 license), but a trap if extended to rebuild the self-serve authoring/semantic surface. Largely superseded by Superset-as-engine, which provides the query/viz/RLS engine for ~80% less code.

## Outcome and architecture fit

Superset is run headless: dashboard/chart/dataset definitions live as YAML in git (reviewed in PRs, deployed by CI); a harness / dashboard-report generator bakes into Superset's create-chart (widget), create-dashboard, dataset, and RLS-rule APIs. Per-tenant scoping is **derived from our existing tenanted, privacy-by-nature data-isolation security model**, which remains the single source of truth — reporting adds no second isolation mechanism. Onboarding 1,700 dealers becomes a scripted loop (one template -> per-dealer guest tokens), not manual per-tenant setup.

## Open item before locking

Spike to confirm headless guest-token data calls (chart-data API) honor per-tenant RLS outside the Embedded SDK flow — this decides a fully-custom front-end vs the iframe embed. Plus: pin Superset 6.0+, add the `GUEST_TOKEN_VALIDATOR_HOOK` cross-tenant-leak guard, and regression-test RLS on every upgrade.

---

## Appendix — working-session log (scrubbed)

This decision was worked through in an AI-assisted working session. The log below is scrubbed to the reporting decision only; an unrelated portal-hygiene task from the same session is omitted as out of scope. The substantive analysis is reproduced in full — the reasoning evolved across the discussion, and the full form is the value.

### 1. Opening proposal — Superset vs Metabase

**Prompt:** We never explicitly picked a Juicebox replacement. Proposing one of: Superset (open source, portable, requires some work) or Metabase (commercial + open source — they'll likely need commercial for white-label branding and embedding for customer-facing stuff). What do you think, since we haven't really iterated on this yet?

**Response:** Your framing is right, and the white-label flag is the crux. Here's how I'd weigh it against what the discovery sessions established as requirements.

The hard constraints (from the synthesis + proposal): (1) customer-facing, embedded, white-label dealer dashboards; (2) multi-tenant isolation is "non-negotiable" — per-dealer row-level security across 1,728+ clients; (3) scale — millions of rows; (4) reports authored by a non-technical product team; 221 reports to migrate; (5) thin internal BI ops — no Power BI devs, offshore team stretched.

Where that lands the two:

| Factor | Superset | Metabase |
|---|---|---|
| White-label customer-facing embed | Free (self-hosted, fully yours) but DIY embed UX | Paid (Pro/Enterprise) |
| Per-tenant data isolation | Guest-token RLS — free, but you build the token-minting | Data sandboxing — Enterprise only |
| Non-technical authoring (Juicebox-like) | Weaker — SQL-centric | Strong — closest successor to drag-and-drop |
| Ops burden | Heavy — you run HA, upgrades, CVEs | Light — esp. Metabase Cloud/Pro |
| License cost | $0 | Per-instance/seat (paid tier) |

My pick at this stage: Metabase (Pro/Enterprise) as the default. The two non-negotiables — white-label embedding and per-tenant sandboxing — are exactly its paid feature set, so the cost is a predictable line item rather than open-ended engineering. And it's the only one of the two that preserves the self-serve authoring workflow DAS already depends on, while not adding ops load they can't staff. For a thin-BI-staff org, "buy the embedding/isolation as a feature" beats "build and operate it."

I'd flip to Superset (or Preset.io, managed Superset) if: open-source/no-license is a hard mandate; they're standing up dedicated platform engineering anyway and want full control of the embed UX; or customer-facing concurrency is extreme enough that they want to own the rendering/caching layer.

One thing to verify before committing: Metabase's current embedding/seat pricing at high external viewer counts — that's the number that makes or breaks the Metabase economics for a 1,700-dealer fan-out. If it prices per external end-user, Superset/Preset gets more attractive fast. Either way, point it at the CDP serving layer (DWRPT's successor), not raw SSIS.

### 2. Pricing, self-host, Evidence.dev, and the mix-and-match assessment

**Prompt:** Pricing may be a factor, so we should consider proposing both as part of the architecture. 1,700 dealers feels like it'd be expensive. We'll pick self-host over hosted for this. Potentially we could also evaluate Evidence (https://evidence.dev/). Maybe mix-and-match — let's run an assessment. (Also raised separately: what if we custom-build, via agentic engineering, some Metabase alternative?)

**Response:** Three research agents ran source-cited assessments of Superset, Metabase, and Evidence; the custom-build path is addressed below.

The decisive split: who authors vs who views. The trap in "pick one Juicebox replacement" is that the two jobs have opposite cost/skill profiles, and every tool is strong at one and weak at the other:
- 1,700 dealer-facing dashboards = view-only, standardized, must be white-label + per-tenant isolated + cheap to fan out. Per-seat pricing here is fatal.
- Internal ad-hoc authoring (the real Juicebox-successor need) = a few dozen authors, drag-and-drop, needs governance. Per-seat pricing here is trivial.

So the answer isn't one tool — it's split the architecture by layer, which is the mix-and-match instinct.

Customer-facing layer (the 1,700-dealer fan-out):

| | Custom-built | Superset | Evidence.dev | Metabase (Guest) |
|---|---|---|---|---|
| License @1,700 | $0 | $0 (Apache 2.0) | $0 (MIT) | Pro+ required ($) |
| Per-tenant isolation | Server-side, your auth (reuse CDP identity) | Guest-token RLS (`dealer_id=`) — you build minting + validator | None native — static build-per-tenant or it leaks (parquet ships to browser) | Sandboxing (Pro+) |
| White-label | Total | Realistic only on 6.0+ (Dec 2025 theming) | Total (your static site) | Badge removal = Pro+ |
| Live data | Yes | Yes | No — build-time static, rebuild for freshness | Yes |
| Authoring | N/A (you template) | No-code Explore + SQL | Code (SQL+md+git) | Drag-drop |
| Serving scale | Cheap (cache/CDN) | Query-router; needs Redis+Celery | Cheapest (static CDN, ~0 marginal) | Caching (Pro+) |
| You own | The whole render+API (bounded) | Token service, ops, CVE patching | 1,700-way build pipeline + all auth | License + ops |

Takeaways: Metabase is the wrong tool for this layer — its free tier lacks white-label/sandboxing, and paid makes authenticated external viewers billable: research confirms $220K–$1M+/yr at list unless you negotiate an Enterprise "unlimited-end-user" term (anchored "$20k+/yr", unverifiable without a quote). Evidence is cheapest to serve but its data-ships-to-browser model forces build-per-tenant (1,700 static sites) and can't do live data — a real platform-engineering burden plus a leakage footgun. Superset is the strongest off-the-shelf fit ($0, purpose-built embedding/RLS) but hands you the token-minting security boundary and a heavy Postgres+Redis+Celery stack with internet-facing CVE exposure.

The custom-build path — the sleeper winner for Layer A. Honest read: custom-build is genuinely the best fit for the standardized customer-facing layer, and a trap for the authoring layer. The reason both off-the-shelf options feel awkward is they're solving a harder problem than you have here — the dealer dashboards are a fixed set of templates, not arbitrary self-serve.

What you'd actually build is small and bounded: a thin React dashboard app rendering a fixed template set; a parameterized query API over the CDP serving views; per-tenant scoping that reuses the CDP's own identity/auth layer (which you're building anyway for the golden record) so isolation is server-side and correct by construction; caching in front. That gets you Evidence's economics (cheap, fully branded) without the static-build fan-out or browser-leak risk, with live data and true server-side isolation, at $0 license. Agentic engineering makes the bounded 80% fast.

The trap to not fall into: do not custom-build the self-serve authoring/semantic-modeling/exploration surface. That's the 20% that's secretly 80% of why BI products exist — multi-quarter effort to half-replicate Metabase. Buy that, don't build it.

Recommended architecture (mix-and-match), two layers:
- Layer A — dealer-facing (1,700 tenants): custom-built thin reporting layer (primary), with Superset as the fallback if you'd rather adopt an engine than own the renderer. Both $0 license. Evidence only if these dashboards are static-friendly and you accept the build pipeline.
- Layer B — internal authoring (replaces Juicebox's authoring role): Metabase Pro self-hosted. Best drag-and-drop, true Juicebox successor, and per-seat pricing is fine here because it's bounded internal staff (~$6K/yr + ~$130/seat), not 1,700 dealers. This is the one place Metabase's cost model works.

Net cost shape: customer-facing layer ~$0 license (infra + bounded build), internal layer low-four-figures. You completely dodge the Metabase cost cliff while keeping its authoring strength where it's cheap. To verify before locking: a written Metabase Enterprise quote only if you still want it for Layer A; confirm the CDP serving layer exposes per-dealer-scoped query access cleanly (it should, given identity resolution is the core deliverable).

### 3. The Superset developer API

**Prompt:** https://superset.apache.org/developer-docs/api/ is promising.

**Response:** Your instinct is right — that API is the thing that reshapes the whole Layer A decision. It confirms Superset is fully driveable as a headless engine, not just a UI you embed:
- BI-as-code: dashboards/charts/datasets export+import as YAML bundles → definitions live in git, reviewed in PRs, deployed by CI. Same discipline Evidence sells, but with a live query engine behind it.
- Scripted per-tenant fan-out: `POST /security/guest_token/` + the Row Level Security API (8 endpoints) + roles/users APIs mean onboarding 1,700 dealers is a loop, not 1,700 manual configs. One dashboard template; mint a per-dealer token carrying `dealer_id=` at session time.
- Infra-as-code for the whole BI layer: database connections, datasets, RLS rules, permissions all API-managed → reproducible, testable, no click-ops.
- OpenAPI + JWT login → generate a typed client, wire it straight into the CDP build.

Why this collapses the "Superset vs custom-build" choice: the API dissolves the dichotomy. You don't pick between Superset and a custom build — you do custom front-end + Superset as the headless engine. You write the thin React dealer-facing surface (full white-label control — the appeal of custom-build); Superset provides, via API, the parts you should never hand-build (query execution, the viz library, the RLS engine, guest-token isolation, caching); dashboard definitions sit in git as YAML (the GitOps appeal of Evidence); live data, server-side isolation, $0 license. That's ~80% less code than a true custom build while keeping the white-label and control you wanted, and it sidesteps Evidence's static-build fan-out and browser-leak problems entirely.

Two front-end strategies, pick by control needed: (1) Embedded SDK (iframe) — fastest; Superset renders, you brand via 6.0 theming; limit is cross-origin iframe, so no parent-page CSS reach-in. (2) Fully headless — call the chart-data API, render with your own chart lib; total control, but you draw the charts and must verify guest-token scoping works for direct data calls (the guest-token flow is designed for the SDK path — worth a spike before committing).

The caveats don't go away, they just get scripted: guest tokens still ~5 min (build silent refresh); the RLS-clause-per-token security boundary is still yours (now a testable minting service hitting the API — add the `GUEST_TOKEN_VALIDATOR_HOOK` to reject any token missing a tenant predicate); YAML import/export has known sharp edges (UUIDs, DB-credential handling in bundles); and you still own the Postgres+Redis+Celery stack and CVE cadence.

Updated Layer A recommendation: lead option becomes Superset headless/embedded, API-driven, dashboards-as-YAML-in-git, scripted guest-token + RLS per dealer. Pure custom-build drops to fallback (only if you want zero Superset ops and accept rebuilding the engine); Evidence stays niche. Layer B unchanged: Metabase Pro, where bounded seats make the cost fine.

### 4. Metabase Pro reframed as an optional add-on

**Prompt:** I want the Metabase Pro to be an add-on / optional. Pro also covers embedded client-based analytics, but we shouldn't make it a baked-in part of the recommendation.

**Response:** Agreed — that's the right call. The baseline recommendation should stand entirely on open, $0-license, self-hostable foundations so it doesn't carry a mandatory commercial dependency. Metabase Pro becomes an optional UX upgrade, not load-bearing.

Core recommendation — fully open, $0 license, self-hosted: Layer A (dealer-facing fan-out, 1,700 tenants) on Superset as headless/embedded engine, API-driven, dashboards-as-YAML in git, scripted guest-token + RLS per dealer, thin custom React front-end for white-label. Layer B (internal authoring) on Superset's own Explore (no-code) + SQL Lab, on the same instance — one platform, one ops footprint, $0; adequate for analyst-led authoring against pre-modeled datasets. The whole baseline runs on Apache-2.0 Superset; no license line item.

Optional add-on — Metabase Pro (self-hosted): positioned as an enhancement the client can elect, not part of the core stack. What it buys: best-in-class non-technical drag-and-drop self-serve authoring — the genuine Juicebox successor — for the handful of internal staff who'd find Superset's Explore too analyst-flavored; bounded internal seats, so cost stays small. Bonus optionality: Pro also covers embedded client-based analytics, so it could alternatively serve Layer A on a commercially-supported path — useful to name as a fallback, but explicitly not the baseline. The honest tradeoff that makes "optional" the correct framing: Superset authoring is less friendly to truly non-technical users than Metabase. The open baseline works; Metabase Pro is the authoring-UX upgrade for those who want it.

### 5. Capture, architecture note, and notify

**Prompt:** Capture this recommendation. Add a note that it should play well with our architecture — we'll need to write a harness / dashboard-report generator that bakes into the create-widgets and dashboards APIs on top of our tenanted, privacy-by-nature data-isolation security model. Then notify Alicia and Luis once notes are captured and pushed; document the process (attach this session as context, scrubbed).

**Outcome:** This artifact (`strategy.json` + renderer), this decision-process record, the `decisions.md` entry, and a Slack note to Alicia and Luis. The architecture note is captured as the "Architecture Fit" section of the artifact: the harness bakes into Superset's create-chart (widget), create-dashboard, dataset, and RLS-rule APIs, with per-tenant scoping derived from our tenanted privacy-by-nature data-isolation model as the single source of truth.
