# Homepage Content Spec — the "YC recipe," nailed down

**Status:** Draft for review (Leo + Patrycja). Hero is **locked** (decisions below); §2–§10 copy is ready to refine. Not yet wired into `data/homepage.yml`.
**Canonical noun:** **Workbench** (not "studio"). Use consistently.
**Brand/trademark:** always **"Calliope AI"** in copy (the trademark) — never bare "Calliope." Company/legal entity is **Calliope Labs Inc**. Product is the **Calliope AI Workbench**. **Zentinelle** and **Astrolift** are product names (domains held), **not trademarks** — no ™, don't call them trademarks.
**Positioning:** We are the **enablement layer that makes private AI real** — deployable, safely, professionally. We do *not* compete with mass-market AI tools (Cursor/Copilot/ChatGPT) on capability; for our buyer those are disqualified at the door because data can't leave. Our real competition is **shadow AI / outright bans** and **18-month DIY builds**. Brand voice: **"AI enablement for grown-ups."**
**Hero wedge:** **Private + enablement, fused.** Lead with the *problem we solve*. Never lead with the tool list or a feature count — sell the activities the platform solves.

**Decisions locked (2026-06-18):**
- **BROCS** — H1 uses all five verbs (Build · Run · Observe · Control · Secure).
- **Security line:** "…**under** your security controls."
- **"AI enablement for grown-ups"** becomes **one of several rotating eyebrow themes**, not a single fixed tagline (see §1).
- **Counts don't sell.** Drop "9 vs 19 tools" entirely; frame §5/§6 around activities and outcomes.
- **BROCS vs BROC stays intentionally fluid.** The platform earns its keep on capability (BROC) and *excels* when security is the constraint (BROCS). Lead BROCS, keep BROC available for security-agnostic audiences, tweak by what converts. Do **not** force-reconcile the framework docs yet.

---

## Implementation instructions (for Patrycja's AI assistant / Claude)

**Read this whole document. Your job: update the calliope.ai homepage so it matches this spec.** The current live design at `calliope2.pages.dev` predates these decisions and must be reconciled. The copy in §1–§10 below is the source of truth — use it verbatim unless it conflicts with a rule here.

### Non-negotiable rules (apply across the whole site)
1. **Product noun is "Workbench," never "studio."** Replace every "studio" ("The private-AI studio", "Inside the studio", etc.) with "Workbench" / "Inside the Workbench."
2. **Brand is "Calliope AI"** (the trademark). Never bare "Calliope," never "Calliope.ai" in body copy. Company / legal entity (footer, legal) is **"Calliope Labs Inc."**
3. **Zentinelle** and **Astrolift** are product names, not trademarks — no ™, don't style them as trademarks.
4. **Lead with the problem. Never lead with a tool list or a tool count.** Do not print "9 tools / 19 tools / 6-in-1" anywhere.
5. **Multi-cloud is present tense.** "Runs on AWS, GCP, Azure, on-prem" — it's the official narrative; no "coming soon" hedges.
6. **Voice:** confident, problem-led, no fluff, no AI-writing tells (no "not just X but Y", no em-dash overuse, sentence-case headings, straight quotes).

### Reconciliation deltas (current calliope2 → this spec)
| Element | calliope2 live now | Change to |
|---|---|---|
| Product noun | "studio" (throughout) | **Workbench** |
| Brand | "Calliope.ai" | **Calliope AI** |
| Hero eyebrow | "The private-AI studio" | rotating themes (see §1) |
| Hero H1 | "One secure AI workspace for your technical team." | **Private AI your team can actually Build · Run · Observe · Control · Secure** |
| Hero sub | "Calliope.ai gives developers…" | see §1 sub |
| Framework | absent | add **BROCS** section (§7) |
| Social proof | "Trusted across regulated industries": Finance, Healthcare, Gov & Defense, Energy, Life Sciences | "Trusted in production where data can't leave": **healthcare/telehealth, advertising/marketing/digital, secure dev shops** (real deployments — see §2) |
| Problem section | near the bottom (#9) | move **up to §3** |
| Tool framing | "Inside the studio" tool list | activity-led, no counts (see §5) |

### Hero — build exactly this (details in §1)
- **Eyebrow** rotates on each page load across the theme set in §1; default first paint = "AI enablement for grown-ups."
- **H1:** "Private AI your team can actually **Build · Run · Observe · Control · Secure**." All five verbs always visible; a gradient highlight rotates across them on each load (default = Build). Server-render the full sentence so SEO / no-JS see it complete.
- **Sub (fixed):** "Your team wants AI. Your data can't leave. We make private AI real — secure, governed, in your own cloud."
- **CTAs:** "Book a demo" (primary) · "See how it works →" (secondary).

### Section order (top → bottom)
1 Hero → 2 Social proof → 3 Problem → 4 Solution → 5 Product deep-dives → 6 Benefits → 7 BROCS platform → 8 Use cases → 9 Blueprint → 10 Final CTA.

### Keep what already works
The product deep-dives (AI Lab, AI IDE & Agents, Zentinelle), the blueprint lead-magnet, and the overall visual treatment are aligned. Keep them; just apply the copy + naming fixes.

### Verify before you call it done
- Search the build: zero "studio" in copy; zero bare "Calliope" not immediately followed by "AI"; zero "Calliope.ai" in body copy.
- Hero eyebrow text and the highlighted verb both change on refresh; the full H1 sentence renders with JavaScript disabled.
- The Problem section sits near the top (§3), not the bottom.
- Social proof names the real verticals (healthcare/telehealth, advertising/marketing/digital, secure dev shops), not the old five-industry list.
- No tool count anywhere; every section leads with a problem or an outcome, not a feature roster.

---

## Value foundation (the spine every section hangs on)

**The problem we solve.** Every organization is under pressure to adopt AI. But the way the mass market ships it — your data goes to their cloud — is a non-starter for any team whose data can't leave: regulated industries, sensitive IP, contractual duties to their own customers. Their alternatives are all bad: ban AI and fall behind, tolerate shadow AI they can't see, or spend 12–18 months and a platform team building private AI themselves, fragile and locked to one vendor. Serious teams are stuck choosing between moving fast and staying in control.

**Our value (first principles).** Frontier models are a commodity — everyone has the same ones, so general AI is table stakes, not an advantage. The AI advantage that *compounds* and that competitors **cannot copy** comes from one place: applying AI to the things only you have — your proprietary data, code, institutional knowledge, and workflows. Those are exactly the things that can't leave your perimeter. So the valuable kind of AI (yours, on your data) is locked behind the wall the mass market can't cross. **Calliope AI brings the AI to the data instead of the data to the AI**, and that unlocks the value that's actually yours to capture:

- **Turn private data into leverage** — put AI to work on the proprietary data, code, and knowledge that differentiate you, without any of it leaving. The only durable AI advantage, because it's built from assets competitors don't have.
- **Multiply the whole team's output** — every builder, analyst, and ops person gets the AI multiplier, in the open and governed, instead of a few using shadow tools in the dark. Org-wide throughput up at flat headcount.
- **Own the asset, don't rent it** — the workflows you build and the know-how you encode accrue to you and stay yours. SaaS AI rents you capability while you feed your data into someone else's moat.
- **Adopt at scale, not pilot forever** — governance built in means you can say yes across the org and keep saying yes, instead of every expansion being a fresh risk review.
- **Invest above the commodity** — frontier models and their clouds are the *most volatile* layer in the stack: export controls, access restrictions, price wars, deprecations, recalls, availability shocks, increasingly driven by geopolitics rather than business. Welding your tooling, workflows, and team habits to one model or one cloud makes your most durable investment hostage to the most ephemeral layer. Calliope AI keeps the commodity swappable underneath you, so a model getting cut off is a config change, not a re-platforming. **Your AI investment should outlive the model it started on.**

The one line: everyone can rent commodity AI; we let you build the AI advantage only *you* can build — on your own data, inside your own walls — and keep it. (Speed — days not months — and the buy-vs-build savings are *how* we deliver it, not *why* it matters. Keep them as support, never the headline.)

**Why it matters (by stakeholder):**
- **Security & compliance** — AI is already in your org, approved or not. Govern it or get blindsided. Control before an incident, plus the audit trail that passes SOC 2 / HIPAA / EU AI Act. Their name is on the breach report.
- **CIO / CTO** — every AI option is a one-way door (vendor lock-in, cloud concentration, regulatory exposure). We keep decisions reversible.
- **Builders** — they want to build now and are blocked or wiring fragile toolchains. We get them building on day one.
- **The business** — falling behind on AI is existential; so is a breach or a failed audit. We remove the false choice.

**Why they pay (it beats every alternative, not just "it's good"):**
- **vs. mass-market AI** — can't run in your perimeter; disqualified, not cheaper. Not a price comparison.
- **vs. build-it-yourself** — the real competitor. DIY private AI is 12–18 months, a platform + security team, and a fragile thing you own forever. We're live in days at a fraction of fully-loaded cost. Buy-vs-build is the core sale.
- **vs. assembling open source** — you *can* wire Astrolift + Zentinelle + models for free; you pay so it's productized, supported, patched, and stood up by our engineers inside your perimeter (FDE), not a science project you maintain.
- **vs. doing nothing** — shadow AI is already here; a breach or failed audit is board-level. We're cheap insurance against an expensive, name-on-the-report risk.

What they actually pay for: the enablement layer + governance (picks and shovels that make private AI run and audit), speed/reversibility (months → days; adoption becomes a reversible decision, not a bet-the-company one), and the people (subscription support + Forward-Deployed Engineering). The models are BYO.

**One sentence (value):** we resolve the defining tension of enterprise AI — adopt it fast vs. keep control of your data — so teams stop having to choose.
**One sentence (why pay):** you pay to turn a 12–18-month, bet-your-compliance-posture build into a bought outcome that's live in days and governed by default — because what it replaces costs far more than we do.

---

## The recipe (what each section is for)

Every section has exactly one job, and each earns the right to the next. Order is not cosmetic.

| # | Section | Job | Pass test |
|---|---------|-----|-----------|
| 1 | Hero | What you do · for whom · the wedge | Stranger gets it in 5s |
| 2 | Social proof | "Not the guinea pig" | A number or named verticals |
| 3 | Problem | "They get me" | Reader nods 3–4× |
| 4 | Solution | The reframe | Clear before → after |
| 5 | Product | Show it's real | A visual/demo per marquee feature |
| 6 | Benefits | What they *get*, quantified | Numbers, not adjectives |
| 7 | Differentiated proof | The moat | Answers "why not DIY / a competitor" |
| 8 | Use cases | Reader self-identifies | "That's what I'd build" |
| 9 | Risk reversal | Kill last objection | Security + low-commitment offer |
| 10 | Final CTA | One ask | Single button |

The current live `homepage.yml` is missing §2, §6, §8, §9 — the four conversion sections. This spec adds them.

### Page-order principle: problem leads, tools get demoted

No one cares what the tools are — they care what problem we solve. So the top of the page is **problem → outcome** (§3 Problem, §6 Benefits do the heavy lifting). The tool lineup (§5) drops **well down the page** — there only to reassure the few who scroll to verify it's real, and ideally pushed onto `/product`. Never open with a feature list.

---

## Canonical vocabulary & numbers — LOCK THESE (used everywhere)

Pick one value per row and use it site-wide. ⚠️ = conflicting numbers seen across the designer site; confirm before ship.

| Claim | Proposed canonical | Notes |
|-------|-------------------|-------|
| Product noun | **Workbench** | Never "studio" |
| Tool count | **Don't lead with a count.** | Decision: counts don't sell. Never headline "9/19 tools" or "6-in-1." Name the *activities* (code with AI, explore data, build agents, automate work) and let the tool list live quietly on `/product`. |
| Policy controls | **24 policy controls, enforced in real time** | Zentinelle |
| Packages (AI Lab) | **300+ packages bundled** | |
| Model providers | **12+ model providers** | AI IDE / agents |
| Compliance frameworks | **SOC 2, HIPAA, EU AI Act** (9 frameworks mapped) | Zentinelle |
| Time-to-prod | **Days from contract to production — not 18-month builds** | The Speed hook, as a benefit |
| Data residency | **100% of your data stays in your cloud — nothing leaves your VPC** | The Private wedge |

---

## Market validation — proof points to cite (§2, §6, sales decks)

Third-party validation that sovereignty is now an *architectural* constraint, not a compliance checkbox. Citable in social proof (§2), benefits (§6), decks, and the companion blog post. Source: CIO.com, *"5 things CIOs must do as sovereignty becomes a design constraint"* (Gartner / SUSE / OpenText / Hypori analysts).

- **"Vendor concentration is now treated as systemic risk, not strategic leverage."** — Luis Pinto, Gartner. → Sells §6 **no-lock-in**: reframes portability from convenience to board-level risk.
- **"Where technology is located and who has operational control over it is now a major business risk."** — Gartner. → Backs *"in your cloud or colo / inside your perimeter."*
- **">90% of enterprise data can safely sit in the public domain; a small percentage needs protection."** — Shannon Bell, OpenText. → Positions Calliope AI as the platform for the *high-value protected slice* — not everything, the part that has to stay in.
- **"Three years ago, sourcing started with total cost of ownership. Now it starts more like a risk register."** — Jochen Jaser, SUSE. → The TCO → risk shift.
- **"Designing for workload portability upfront is becoming increasingly important"** — exit by design (OpenText / Gartner). → Validates *"same tools, any backend"* as exit-by-design.
- **"Identity is now becoming the perimeter — not device-centric anymore."** — Matt Stern, Hypori. → Ties to Zentinelle + *enforcing your security controls.*

> **Honest counter to pre-empt:** analysts note sovereignty usually costs "additional cost, slower deployment, reduced access to cutting-edge features." Our answer: the enablement layer *shrinks that tax* — cutting-edge models + backend portability without the control penalty.

---

## §1 — HERO

**Voice:** "AI enablement for grown-ups." Confident, problem-led, anti-toy. Lead with the problem we solve — not the tools.

### Eyebrow — rotating themes (LOCKED: rotate on refresh)

The eyebrow above the H1 rotates across value-lenses on each page load. This lets a security-led lens *and* an enablement-led lens each get their turn — the practical way to "play BROCS by ear" without picking a side. The H1 and sub stay fixed; only this short line changes.

Theme set (all lead with offense/value, none with cost-avoidance):
- `AI enablement for grown-ups.` — enablement / serious-org lens (the brand signature; also travels to nav, OG/meta, deck, swag)
- `Own the tools that own your context.` — data-ownership / "your context is the asset" lens (manifesto line; antanaclasis on *own*; self-selects the AI-literate reader)
- `Same tools. Any backend. No lock-in.` — portability / invest-above-the-commodity lens
- `Sovereignty by design, not a checklist.` — compliance / regulated-buyer lens (ties to the companion blog post)

Both `AI enablement for grown-ups.` and `Own the tools that own your context.` double as recurring **brand/manifesto lines** (nav, OG, deck, swag), not just hero eyebrows.

Notes:
- *"AI enablement"* = we make private AI real (the picks-and-shovels role, made sexy — replaces the unsexy word "middleware"). *"for grown-ups"* = a confident swipe that recasts consumer AI as the kids' table.
- **Tone:** "grown-ups" is cheeky; because it's now one theme among several, the buttoned-up buyer who'd bristle is statistically likely to land on a straighter eyebrow (sovereignty / no-lock-in) instead. Rotation de-risks the cheek.
- **Optional polish:** pair each eyebrow with a matching verb-highlight (e.g. the sovereignty theme highlights **Secure**; the portability theme highlights **Run**; grown-ups highlights **Build**). Theme and highlight reinforce instead of rotating independently.

### H1 — the promise (LOCKED: five verbs, BROCS)

> Private AI your team can actually **Build · Run · Observe · Control · Secure**.

- *"Private AI…"* = the wedge, in the first two words.
- *"…actually…"* = the enablement punch. Implies everyone else fails at the deployable/safe/professional part and we don't. Anti-DIY, anti-shadow-AI, zero backend jargon.
- The verbs spell **BROCS** (Build / Run / Observe / Control / Secure ≈ "rocks") — reads literally as plain verbs even to someone who's never heard the acronym, and rewards the one who has. The framework ends on **Secure**, the sharpest differentiator.
- For a security-agnostic audience/test, the four-verb BROC form (drop **Secure**) is the fallback — kept available on purpose, not retired.

### H1 mechanic — gradient highlight rotates on refresh

All verbs visible **every load** (that's the payoff — it spells the framework *and* proves capability). On each page load, a different verb gets the gradient highlight (Build → Run → Observe → Control → Secure). Delivers the "different every refresh" delight without hiding the acronym and without the comprehension penalty of an auto-rotating carousel.
- **No-JS / first paint:** highlight defaults to **Build** (or none). Server-render all verbs so SEO and no-JS see the complete line.
- ⚠️ Do **not** rotate-and-swap a single verb (the earlier idea) — that hides 3–4 of the verbs per view and kills the BROCS reveal.

### Sub — problem-led, NO tool list (LOCKED: option A)

> Your team wants AI. Your data can't leave. We make private AI real — secure, governed, in your own cloud.

Names the tension the buyer lives in, then resolves it. No feature nouns. (Alternates kept for reference: B — "Bring AI to your whole organization without sending your data anywhere, or spending a year building the platform yourself." C — "The AI your organization wants, where your data has to stay.")

> Note the deliberate **team → organization** widening: the team *builds*, the org *gains*. Intentional, not a mismatch.

### CTAs
- Primary: `Book a demo` → /contact
- Secondary: `See how it works →` → /how-it-works/
- (Optional text link: `Get the deployment blueprint →` → §9 anchor)

### Easter egg — warm audiences only (use in §7, social, deck, swag — NOT the cold H1)
> Private AI you can actually **BROCS**.

A first-time visitor seeing "BROCS" with no decoder is just confused; keep the H1 spelled out and let the acronym click as the eye reads left to right.

---

## §2 — SOCIAL PROOF  *(NEW — highest-leverage missing section)*

Built on **real deployments**, not an aspirational industry list. Pre-logo framing; swap to named logos as customers clear reference rights.

**Headline:**
> Trusted in production where data can't leave.

**Verticals (real):**
- Healthcare & telehealth
- Advertising, marketing & digital
- Secure dev shops & agencies

**Optional supporting line:**
> Teams in regulated and security-conscious industries run Calliope AI inside their own perimeter — because their data never can.

> **TODO:** as soon as 1–2 customers approve it, replace verticals with logos + a one-line outcome quote. Logos > verticals > nothing.

---

## §3 — PROBLEM

**Eyebrow:** `THE PROBLEM`
**Headline:**
> You're stuck between moving fast and staying in control.

**Subhead:**
> Your team wants to build with AI. Your data can't leave, your security team can't see what's running, and standing it up yourself takes months. So AI either stalls or sprawls.

The same four walls, every time:
- **Your team rebuilds the same setup every project** — environment config, model integrations, secrets, from scratch each new initiative.
- **Your developers are waiting on DevOps** — standing up an AI environment takes weeks before a line of AI code gets written.
- **Security can't see what's happening** — who launched what, who accessed which environment, what's running. Nobody knows until something breaks.
- **New AI tools keep landing on laptops** — unapproved tools spreading, each with a different security posture and its own credentials.

**Stakes line:** Both ways out are expensive. Stall, and you fall behind. Sprawl, and the next incident is yours to explain.

**CTA:** `See the Workbench →` → /product/

---

## §4 — SOLUTION

**Eyebrow:** `THE SOLUTION`
**Headline:**
> The AI advantage only you can build.
**Subhead:**
> Calliope AI brings AI to your data, not your data to the AI. Your team puts it to work on the proprietary code, data, and knowledge that actually set you apart — without any of it leaving your perimeter. (Consolidation, speed, and governance below are how we make that real.)

**Body:**
> Calliope AI gives every team a complete, isolated AI environment — purpose-built by us, plus curated open-source add-ons.
>
> - Everything your team does with AI in one place — code with AI, explore data, build and run agents, ship internal apps, automate work
> - Your cloud, your network, your region — BYOC, VPC peering, on-premise, air-gapped, Kasm Workspaces, or desktop
> - One login, one filesystem, one set of access logs across all of it
> - Minimal footprint — deploys inside your perimeter without a major infrastructure lift

**CTA:** `Explore the full Workbench →` → /product/

---

## §5 — PRODUCT / INSIDE THE WORKBENCH  *(demoted — see page-order principle)*

> Lives **well down the page**, after problem + outcomes. It's verification for scrollers, not the opening pitch. Consider pushing most of this to `/product` and keeping only a thin teaser on the homepage.

**Headline:**
> Inside the Workbench.
**Subhead:**
> Everything your team needs to build with AI — in one stack you control.

**Lead with activities, not a roster.** Frame this section as *what your team can do* — code with AI, explore data, build and run agents, govern every action — and let the actual tool names live on `/product`. Don't print a tool count.

**Then 2–3 marquee deep-dives with a demo visual each (the activity is the headline, the tool is the byline):**

**AI Lab —**
> Analysis at the speed of thought.
> JupyterLab with an AI copilot. Ask in plain English, get the query, get the chart — over data that never leaves your cloud.
> • Natural language → SQL • 300+ packages bundled • Governed access & audit
> CTA: `Browse AI Lab →`

**AI IDE & Agents —**
> Autonomous agents that ship real work.
> Five modes, 12+ model providers, background agents that plan and execute — every edit staged for human review.
> • Agent · Ask · Plan · Debug · Council modes • Staged changes, accept/reject • Runs local or air-gapped
> CTA: `Browse AI IDE →`

**Governance (Zentinelle) —**
> See — and control — every agent action.
> Observability, real-time policy enforcement, compliance mapping. Catch violations before they become incidents.
> • 24 policy types, real-time • PII / injection scanning • Audit trail → your SIEM
> CTA: `Browse governance →`

---

## §6 — BENEFITS  *(NEW — quantified outcomes; Speed lives here)*

**Headline:**
> What your team actually gets.

Five callouts — outcomes, not adjectives or counts:
- **100% of your data stays in your cloud** — nothing leaves your VPC
- **Same tools, any backend** — switch clouds, models, or deployment targets (AWS · GCP · Azure · on-prem · air-gapped) without retraining your team or rewriting a line. **No vendor lock-in.**
- **One login, one bill, one governed stack** — not a toolchain to assemble and reconcile
- **Every agent action enforced in real time** — models, tools, budgets, rate limits, all under policy
- **Days from contract to production** — not 18-month build cycles

> **Why this matters (the enablement-layer proof):** your team's interfaces and tools stay constant while the backend underneath becomes swappable. The volatile, lock-in-prone decisions — which cloud, which model vendor, cloud vs. colo vs. air-gapped — stop being one-way doors. That portability *is* the value of running the layer.

---

## §7 — DIFFERENTIATED PROOF — BROCS / the platform

**Headline:**
> One platform. Build · Run · Observe · Control · Secure.

**Easter-egg subhead (warm audience):** *Private AI you can actually BROCS.*

The five BROCS pillars, mapped to products:
- **Build — Calliope AI Workbench.** Code, notebooks, chat & agents in one governed environment.
- **Run — Astrolift.** Deploy across AWS, GCP, Azure & on-prem. Multi-cloud + on-prem K8s PaaS.
- **Observe + Control — Zentinelle.** 24 policy controls mapped to SOC 2, HIPAA & the EU AI Act.
- **Secure — the perimeter itself.** Private deployment + real-time enforcement that wraps all of the above. *In your cloud or colo. Inside your perimeter. Under your security controls.* (LOCKED: "under" — it answers to you, subordinate to your rules.)

> **Note on BROCS vs BROC (intentionally fluid):** the platform delivers value on capability alone (BROC) and *excels* when security is the constraint (BROCS, ending on **Secure**). Lead BROCS; keep BROC available for security-agnostic audiences; tweak by what converts. **Secure** is drafted here as the umbrella that wraps the other four pillars, not a separate product. Do **not** force-reconcile `CLAUDE.md` / `positioning.md` to one form yet — revisit after the messaging is tested.

---

## §8 — USE CASES  *(NEW — reader self-identifies)*

**Headline:**
> One stack. Every AI workflow your team runs.
**Subhead:**
> Build it once, on infrastructure you own.

Lead with the activity; the tool is a quiet byline.
- **Build and run agents** — autonomous agents that plan and execute, inside your perimeter
- **Explore your data** — ask in plain English over data that never leaves your cloud
- **Ship governed chatbots and copilots** — internal assistants with policy and audit built in
- **Automate internal work** — wire workflows across the stack, all logged

> Self-identification is the job here: a visitor should see the thing they were already trying to build.

---

## §9 — RISK REVERSAL / LEAD MAGNET

**Headline:**
> The Private-AI Deployment Blueprint
**Subhead:**
> The guide we use with enterprise teams: reference architecture for self-hosting AI in your VPC, a security & GRC checklist, and the path from zero to governed production.

- Reference architecture for AWS / GCP / Azure / air-gapped
- Security & compliance control mapping (9 frameworks)
- Buy-vs-build cost model

**Form:** Work email · Company → `Get the blueprint`
**Legal:** No spam. Unsubscribe anytime.

> ⚠️ **VERIFY:** does the blueprint asset exist? Designer site says "18-page guide." Confirm page count + that the PDF/delivery exists before promising it.

---

## §10 — FINAL CTA

**Headline:**
> Self-host enterprise AI in days.
**Subhead:**
> Stop choosing between moving fast and staying in control.
**CTA:** `Book a demo` → /contact

(Closes the loop opened in §3: same tension, now resolved. One ask, one button — no competing links here.)

---

## Mapping to `data/homepage.yml` (for the implement step)

| Spec § | homepage.yml key | Exists? | Action |
|--------|------------------|---------|--------|
| 1 Hero | `intro` | yes | Rewrite + add rotating-verb span (new partial logic) |
| 2 Social proof | — | **no** | **New section + partial** |
| 3 Problem | `info_box` + `if_you_section` | yes | Keep, tighten |
| 4 Solution | `secondary_info_box_section` | yes | Keep, reframe to activities (no tool count) |
| 5 Product | — (deep-dives) | partial | Activity-led marquee blocks w/ demo images |
| 6 Benefits | `features_section` | yes (3 items) | Reframe to 5 outcome callouts (no counts) |
| 7 BROCS/products | — | **no** | **New section** |
| 8 Use cases | — | **no** | **New section** |
| 9 Blueprint | — | **no** | **New section + form** |
| 10 Final CTA | `bottom_section` | yes | Tighten to "Self-host enterprise AI in days." |

**New partials needed:** rotating eyebrow themes (hero), social-proof strip, BROCS five-up, use-case grid, blueprint lead-magnet form. The designer's calliope2 site already has visual treatments for most of these — port those rather than design fresh.

---

## Open questions before implementation

**Hero — RESOLVED (2026-06-18):** five-verb BROCS H1; sub option A; "under" security line; "grown-ups" is one of several rotating eyebrow themes; counts dropped in favor of activities. BROCS-vs-BROC kept intentionally fluid.

**Still open:**
1. **Eyebrow theme set** — confirm/extend the four rotating themes (§1), and whether to pair each with a matching verb-highlight.
2. **Hero highlight default** — confirm **Build** as the no-JS/first-paint highlighted verb.
3. **Blueprint asset** — does the deployment-blueprint PDF actually exist? (§9) If not, cut §9 or build the asset.
4. **Logos** — any customer cleared for a named logo yet? (§2) Until then, keep the real verticals.
5. **Astrolift/Zentinelle prominence** — full BROCS section on the homepage (§7), or keep the homepage Workbench-focused and link out? (Designer site includes all three.)
6. **Activity list** — confirm the canonical set of "activities" to lead with (code with AI · explore data · build & run agents · ship internal apps · automate work · govern every action). This replaces the old tool roster as the spine of §4/§5.
