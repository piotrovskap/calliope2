# Calliope.ai — Project Context

> Full working context for the Calliope.ai marketing site. Living document — update as the build evolves.
> Last updated: 2026-06-22.

---

## 1. What this is

A static marketing website for **Calliope.ai** — a private-AI development platform.

- **Product:** Calliope AI **Workbench** (the canonical product noun — never "studio").
- **Brand/trademark:** always **"Calliope AI"** in body copy (never bare "Calliope", never "Calliope.ai").
- **Legal entity:** **Calliope Labs Inc.** (footer/legal only).
- **Sister product names** (not trademarks, no ™): **Zentinelle** (GRC / governance), **Astrolift** (deployment / run layer).
- **Positioning:** the enablement layer that makes private AI real — deployable, governed, in your own perimeter. Real competition is **shadow AI / bans** and **12–18-month DIY builds**, NOT Cursor/Copilot/ChatGPT (those are disqualified because data can't leave).
- **Voice:** "AI enablement for grown-ups." Confident, problem-led, no fluff, sentence-case headings, straight quotes.

The source-of-truth content spec is **`HOMEPAGE-CONTENT-SPEC.md`** (read it before touching homepage copy).

---

## 2. Tech stack & how to run

- Plain **HTML + CSS + vanilla JS**. No framework, no build step for the pages themselves.
- Served locally on **`http://localhost:8011`** (`python3 -m http.server 8011` from `public/`, or wrangler pages).
- **Deploy:** Cloudflare Pages project **`calliope2`**, build output dir = **`public/`**, wired to the GitHub repo. Pushing a branch creates a preview deploy. Cloudflare strips `.html` (serves clean paths, 308 → `/page`).
  - Config: `wrangler.toml` (`name = "calliope2"`, `pages_build_output_dir = "public"`).

### Git
- **Repo:** https://github.com/piotrovskap/calliope2.git (`origin`, user `piotrovskap`).
- **`main`** = v1 homepage (untouched by the v2 work).
- **`homepage2`** = active branch for the v2 homepage. Latest commit at last save: `d9c86cb`.
- **Branch on GitHub:** https://github.com/piotrovskap/calliope2/tree/homepage2

### Shareable preview links (v2)
- **Live preview:** https://homepage2.calliope2.pages.dev/homepage2  *(v2 page only — root `/` of this preview is still v1)*
- **Source on GitHub:** https://github.com/piotrovskap/calliope2/blob/homepage2/public/homepage2.html

---

## 3. Cache-busting (IMPORTANT)

Shared assets carry a `?v=N` query string that **must stay consistent across all 66 pages**. When a shared file changes, bump its version with `sed` across `public/*.html`.

**Current versions:**

| Asset | Version |
|---|---|
| `styles.css` | **v=49** |
| `site-header.js` | **v=14** |
| `site-footer.js` | **v=18** |
| `script.js` | **v=14** |

Bump example:
```bash
cd public && sed -i '' 's/styles\.css?v=49/styles.css?v=50/g' *.html
```
Generator constants (`scripts/gen_full.py`, `scripts/gen_pages.py`) hold `V_CSS, V_HDR, V_FTR, V_JS` — keep in sync if regenerating pages.

> Note: the local `python http.server` ignores `?v` and serves the live file, so screenshots always reflect current files. The version bump only matters for production/CDN caching.

---

## 4. Shared architecture

### Web components (light DOM, blocking `<head>` scripts)
- **`<site-header data-active="…">`** (`site-header.js`) — nav / mega-menus. `data-active` highlights the current nav item.
- **`<site-footer data-page="…">`** (`site-footer.js`) — renders, in order: a **valley rotator** ("Enterprises are scaling … with Calliope") → a per-page **precta** (pre-footer CTA) → the full footer (with the marble-hand figure).
  - Per-page CTA copy lives in the `CTAS` registry keyed by `data-page` (defaults to `home`).
  - **`home2`** key = homepage2's final CTA: *"Self-host enterprise AI in days."* / sub *"Stop choosing between moving fast and staying in control."* / Book a demo.
  - The precta figure now includes a `<canvas class="split-ascii">` code-field animation behind the statue.

### Global CSS — `public/styles.css`
Design tokens (`:root`):
- Dark: `--navy`, `--navy-deep`, `--cyan: #3ff1ef`, `--muted`, `--line`.
- Light bands: `--l-bg: #eaf0fb`, `--l-bg2: #e3ebf8`, `--l-ink`, `--l-soft`, `--l-line: rgba(19,26,46,.12)`, `--l-accent: #5a4dc7`.
- Type: `--font-head` (DM Sans), body IBM Plex Sans. `--maxw: 1140px`.
- **vframe lines** at `50% ± 588px` → `max(1.5rem, calc(50% - 588px))`. Many components "bleed out" to these lines and use them as their L/R border (e.g. `.products .rt-bento`, `.fc`, the §2 board).
- `section { padding: 5rem 0 }`; `.proof + section` overrides with `margin-top:-20px; padding-top: calc(5rem+20px)`.

### Shared JS — `public/script.js`
- Lead modal (`#leadModal`), search overlay (`#searchOverlay`, ⌘K), sticky header, mobile menu, lead-form handlers (`[data-lead-form]`).
- **`.split-ascii` / `.sol-ascii` "fire-from-code" animation** (IIFE near line 639): glyph field `"CALLIOPEai01<>/\*=+-#·"`, `STEP=13`, reduced-motion aware. Drives every code-field canvas on the site.
  - **Speed knobs:** wave `Math.sin(t * 0.022 …)` and glyph churn `(t >> 4)`. (Slowed ~2.7× from the original `0.06` / `t>>2` per user feedback.)

### The `.split` component (documented in styles.css)
Canonical two-column section with a **center divider line at exactly 50%**, full-height, no padding on the line.
- `.split > .wrap.split-grid` = `grid-template-columns: 1fr 1fr`.
- `.split::after` draws the 50% divider; `.split.band-light::after` uses `--l-line`.
- **`.split--figure`** variant = subtitle → title → animation (`.split-ascii` canvas) → Calliope figure (`.split-stage`). Used on `how-it-works.html`.
- Collapses to one column at `max-width: 860px`.

---

## 5. homepage2.html — the v2 homepage

The main file. Has a large **inline `<style>`** block for homepage2-only CSS (scoped to that doc) plus the global `styles.css`. Section order follows the spec.

### Section map (top → bottom)
1. **§1 Hero** — `.hero--center { min-height: 62vh }`, content vertically centered.
   - Rotating **eyebrow** themes (JS, default "AI enablement for grown-ups."): also "Own the tools that own your context." / "Same tools. Any backend. No lock-in." / "Sovereignty by design, not a checklist."
   - **BROCS H1:** "Private AI your team can actually **Build · Run · Observe · Control · Secure**." All five verbs always visible; one verb highlighted, rotates on load (default Build). *Currently cyan + italic — spec asks for a gradient highlight (open item).*
   - Sub (fixed, option A): "Your team wants AI. Your data can't leave. We make private AI real — secure, governed, in your own cloud."
   - CTAs: Book a demo · See how it works →.
   - Linear-style blur→sharp word-by-word reveal.
2. **Proof bar** (between hero and §2) — v1-style dark band, v2 numbers: 100% / 24 / 12+ / 300+ / 9 / Days. *(Extra vs the strict spec order; content is the spec's canonical numbers, not a banned tool count.)*
3. **§2 Social proof — Ramp-style logo board** (`.proofgrid`). See §6 below.
4. **§3 Problem** (`.fc` blueprint bento) — eyebrow "The problem", H "You're stuck between moving fast and staying in control.", 4 walls with RED labels (`.fc-label` `#e5484d`): Repetition / Bottleneck / Blind spots / Sprawl. Seated muse `6.png` + `.sol-ascii` canvas. Bleeds to vframe; dashed crosshair grid; divider runs to top edge.
5. **§4 Solution** — eyebrow "The solution", H "The AI advantage only you can build.", `.sol-lead` + `.sol-body` hierarchy, 4 bullets, CTA "Explore the full Workbench →". Figure `7.png` centered, top-anchored (`.sol-stage` `left:50%; translateX(-50%)`), bottom clipped. 50% center divider.
6. **§5 Product / Inside the Workbench** — activity-led; 3 marquee deep-dives (AI Lab, AI IDE & Agents, Governance/Zentinelle) with aurora `.img-ph` visuals. No tool count.
7. **§6 Benefits** — "What your team actually gets." 5 outcome callouts. **⚠️ user dislikes the current visual** (loose white `.feature` cards, uneven 4+1). Planned redesign: connected bento (big "100%" hero cell + 2×2 grid) bleeding to vframe — NOT YET DONE.
8. **§7 BROCS platform** (`.rt-bento`, dark, bleeds to vframe) — "One platform. Build · Run · Observe · Control · Secure." Pillars: Build = Workbench, Run = Astrolift, Observe+Control = Zentinelle, Secure = the perimeter ("…under your security controls").
9. **§8 Use cases** (`.uc-*`, Shade-style scroll-fill timeline, normal height — no scroll-pin) — eyebrow "USE CASES", H "One stack. Every AI workflow your team runs.", subhead "Build it once, on infrastructure you own." (soft-grey, demoted — teal removed). 4 steps: Build and run agents / Explore your data / Ship governed chatbots and copilots / Automate internal work. Bar fills via scroll progress `p = (innerHeight*0.5 - rect.top)/rect.height`.
10. **§9 Blueprint / lead magnet** — "The Private-AI Deployment Blueprint" + 3 bullets + email form.
11. **§10 Final CTA** = footer precta via `data-page="home2"` ("Self-host enterprise AI in days.").

### Scroll behaviors
- **Scroll-reveal:** head script sets `html.js-reveal` before paint; each `main > section:not(.hero)` starts blurred/translated and reveals once via IntersectionObserver (threshold 0.12, rootMargin `0px 0px -7% 0px`).
- **Marketing modal** `#hp2Modal` (lead magnet, `data-source="hp2-scroll-modal"`) fires once at 50% scroll.
- Wheel-hijack "smooth scroll" was **removed** (user disliked it).

---

## 6. §2 Ramp-style logo board (`.proofgrid`)

Replaced the old auto-rotating industry carousel (spec says avoid carousels; "logos > verticals > nothing").

- Two-tone headline (`.pg-head` dark + `.pg-grey` soft) = the spec §2 headline + supporting line.
- "See how deployments work →" link (`.pg-link`).
- **Board** (`.pg-board`) bleeds L/R to the vframe lines (those lines are its frame); `border-top/bottom` only. **4×2** grid + a highlighted feature card.
- **8 tiles = only the industries that have real subpages** (each links out, all with a corner ↗):
  Healthcare & pharma, Financial services, Gov & defense, Energy & utilities, Manufacturing, Life sciences, Research & academia, Climate & environment.
- Tiles **blend with the band** — transparent fill, thin gridlines from **cell borders** (NOT a board background-fill; a board `--l-line` fill greyed the whole block — avoid). Bottom-left aligned, internal padding, **two-tier hierarchy**: bold name (`.pg-logo`, `--l-ink`) + muted caption (`.pg-cap`, e.g. "HIPAA-aligned · PHI stays in").
- **Feature card** (`.pg-feature`, col 5, rows 1–2): aurora `.img-ph` + gradient overlay + "REGULATED DEPLOYMENT / 100% / of data stays inside the customer perimeter".
- Section padding: `margin-top:0` (cancels the `.proof + section` −20px pull) + generous top padding; headline & link get **left/right inset (1.5rem)** so they align with the tile text while the board stays flush to the frame.
- **All logos/photo/captions are swap-ready placeholders** — replace with named customer logos + a real outcome quote as references clear (per spec §2 TODO).

---

## 7. Other pages

- **`how-it-works.html`** — uses `.split` and `.split--figure` (problem section: eyebrow "The problem" + `.split-ascii` canvas + `6.png`). `data-page="how"`.
- ~66 pages total (6 section overviews, product/governance/security/deployment/solution/industry leaves, company pages, `index` = v1 home). Generated/maintained via `scripts/gen_full.py`, `scripts/gen_pages.py` + content JSON.

---

## 8. Tooling notes (screenshot verification loop)

- Headless Chrome screenshot + PIL crop is the verification method:
  `"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --headless --disable-gpu --hide-scrollbars --force-device-scale-factor=1 --window-size=1280,N --virtual-time-budget=4000 --screenshot=out.png URL`
- **vh distortion gotcha:** tall headless captures inflate `vh`-based heights (hero `min-height: 62vh`). Workaround: copy to a temp file with the hero pinned to px, screenshot, delete:
  `sed 's/min-height: 62vh/min-height: 600px/' homepage2.html > _t.html` … then `rm _t.html`.
- **js-reveal gotcha:** sections below the fold sit at `opacity:0` in a static capture until IntersectionObserver fires; use `--virtual-time-budget` and/or a tall window so they intersect and reveal. Pages without `js-reveal` (e.g. how-it-works) render fully and are handy for verifying shared components (precta, footer).
- `numpy` is NOT available in the Python here; use PIL + plain loops for pixel scans.

---

## 9. Spec-compliance status (homepage2 vs HOMEPAGE-CONTENT-SPEC.md)

**Aligned:** §1 hero (eyebrow rotation, BROCS, sub A, CTAs), §3–§9 copy, "Workbench" naming, "Calliope AI" brand, multi-cloud present tense, BROCS pillars, "under your security controls", §10 final CTA.

**Open deviations / TODO:**
1. **Footer `site-footer.js` rule violations** (apply to every page): brand blurb says **"The private-AI studio."** → must be "Workbench" (rule #1); valley rotator says **"…with Calliope"** → must be "Calliope AI" (rule #2). *Clean fixes, not yet applied.*
2. **§6 Benefits** visual redesign requested (loose white cards → connected bento). *Not yet done.*
3. **Hero verb highlight** is cyan+italic; spec asks for a **gradient** highlight. *Minor.*
4. **§2 board** lists 8 sector placeholders; spec's literal "real verticals" are 3 (healthcare/telehealth, advertising/marketing/digital, secure dev shops) — current board follows the "logos>verticals" intent with placeholders; swap to real logos when available.
5. Extra **proof/numbers bar** after the hero is an addition over the strict §1→§10 order (content is spec-canonical numbers).

---

## 10. Conventions & gotchas learned

- All center dividers at **exactly 50%** (`1fr 1fr; gap:0`), lines drawn with pseudo-elements; "extend to edge" = a tall `::before`/`::after` clipped by an `overflow:hidden` parent (used for §3 divider, §4 divider-to-top, the precta full-height divider).
- A canvas with `left+right+auto` width ignores `right` → set explicit `width: calc(...)`. A canvas needs a **sized parent** to animate; `height:100%` fails if the parent has no definite height (pin with `top:0;bottom:0`). `justify-self:end` on a box whose children are all absolutely-positioned **collapses it to ~0 width** (this zeroed the precta canvas — fixed with `justify-self:stretch`).
- Translucent `--l-line` used as a **solid fill** tints everything grey — use it for 1px lines only.
- Keep RWD: components that bleed to vframe need a `@media (max-width:860px)` stack + figure-hide.
- End commit messages with `Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>`.
