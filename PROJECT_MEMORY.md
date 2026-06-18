# Calliope landing site — Project Memory

> Full braindump of the project: what it is, how it's built, conventions, the
> page/copy/generator pipeline, design-system components, assets, and the
> decisions made along the way. Keep this current.

## 1. What the project is
A **static marketing website** for **Calliope.ai** — a *private-AI development
studio/platform* you buy, deploy in your own cloud, and govern with your own
security/GRC. Built by **CONFLICT** (Calliope Labs Inc, Miami, FL).

Sister products referenced throughout:
- **Calliope** — the studio/Hub (IDE, notebooks, chat, agents, secure browser).
- **Zentinelle** — governance / GRC layer.
- **Astrolift** — deployment runtime.

The site is a from-scratch rebrand/rebuild whose **information architecture
intentionally diverges** from the live calliope.ai (we lead with the three named
products, an industry carousel, orchestra-style feature rows, etc.), but whose
**facts and per-page copy are sourced from calliope.ai**.

## 2. Tech & how to run
- **Pure static**: HTML + CSS + vanilla JS. No framework, no build step for the
  site itself (the page generator is a dev-time tool, see §6).
- **Working dir**: `/Users/patrycjapiotrowska/Desktop/ConflictProjects/calliope2`
  — the served root is **`public/`**.
- **Local server**: `python3 -m http.server 8011` from `public/` (port 8000 was
  taken). Also compatible with `wrangler pages dev public` (Cloudflare Pages).
- **Live URL during dev**: `http://localhost:8011/`.
- **Visual review loop**: headless Chrome screenshot + PIL crop, e.g.
  `"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --headless=new --hide-scrollbars --window-size=1440,3000 --screenshot=/tmp/x.png http://localhost:8011/<page>.html`
  then crop with PIL and Read the image.

## 3. Cache-busting / versioning convention
Every page links shared assets with a `?v=N` query string for cache-busting.
**Bump the version whenever you change the file**, and keep it consistent across
ALL pages (sed across `public/*.html`). Current versions:
- `styles.css?v=32`
- `site-header.js?v=9`
- `site-footer.js?v=11`
- `script.js?v=8`

The generator (`scripts/gen_pages.py`) emits these same numbers — keep the
constants at the top of that file in sync when bumping.

## 4. File layout (`public/`)
- `index.html` — homepage.
- 11 other **hand-authored** pages: `pricing`, `product`, `governance`,
  `security`, `security-compliance`, `deployment`, `solutions`, `industries`,
  `product-ide`, `industry-financial-services`, `how-it-works`.
- **47 generated** leaf pages (see §6/§7). **59 HTML pages total.**
- `styles.css` — the entire design system (single file).
- `script.js` — all behavior (IIFEs, guarded so they no-op on pages missing
  their hooks).
- `site-header.js` — `<site-header>` web component (nav).
- `site-footer.js` — `<site-footer>` web component (pre-footer CTA + footer).
- `img/` — assets (see §8).

Repo root also has: `scripts/` (generator, see §6), `docs/calliope-ai-sitemap.md`
(57-page calliope.ai crawl map), `design-system/reference/` (crawl data incl.
`site-content.json` — the source of verbatim copy + reference screenshots).

## 5. Shared components (web components — single source of truth)
Both render into **light DOM** (so `script.js` and CSS work normally) and are
loaded as **blocking scripts in `<head>`** so the custom elements upgrade during
body parse, before `script.js` runs at end of body.

### `<site-header data-active="...">` (`site-header.js`)
- Renders: skip-link (`a.skip-link` → `#main`), announcement bar, sticky header,
  brand, **mega-menu nav**, search button, Sign in, "Book a demo".
- `data-active` highlights the matching top-level item (`product` / `governance`
  / `solutions` / `pricing`). Values used on leaves map to the parent section.
- **Nav triggers are real `<a href>` links to the section hub** (keyboard/SR
  accessible; mega panel is a hover/pointer enhancement). Hover-only open; this
  also fixed the old "click-stick" bug.
- Mega-menu items + mobile menu link to the **real leaf pages**.

### `<site-footer data-page="...">` (`site-footer.js`)
- Renders TWO things: the **pre-footer CTA band** (`.precta`) then the footer.
- **Pre-footer CTA** = a light, squared band: per-page headline (with a
  purple→blue gradient accent), sub, two buttons (primary + ghost), a decorative
  line-grid, and the **Calliope figure on the right** (currently
  `/img/calliope-img/2.png`). Copy comes from a `CTAS` registry keyed by
  `data-page` (`home`, `product`, `ide`, `governance`, `security`, `deployment`,
  `solutions`, `industries`, `industry-fs`, `pricing`, `how`); unknown keys fall
  back to `home`. The CTA **headlines are verbatim from calliope.ai**.
- **Footer** includes the marble-hand image (`/img/calliope-img/3.png`), brand +
  subscribe form, 4 link columns (Product / Solutions / Resources / Company),
  social icons, legal row.

## 6. Page generator (dev-time tooling, `scripts/`, NOT served)
Produces the 47 leaf pages from verbatim calliope.ai copy + our components.
Re-runnable and idempotent.
- `scripts/extract.py` — debug/inspection helper: isolates a page's unique body
  from the flat crawl by stripping the shared nav prefix (computed as the longest
  common substring between two pages) and the footer markers.
- `scripts/build_content.py` — the registry of all ~47 pages (slug, calliope
  path, archetype, `active`, `dataPage`, back-link). Extracts each page's
  verbatim body, derives a clean `eyebrow` from the slug ("Section · Name"),
  parses h1/sub and `**bold** — desc` feature pairs, writes
  `scripts/pages_content.json`.
- `scripts/pages_content.json` — the content map consumed by the generator.
- `scripts/gen_pages.py` — renders `public/<slug>.html` for every entry using the
  existing design-system classes. **Re-run with `python3 scripts/gen_pages.py`.**
  Version constants `V_CSS/V_HDR/V_FTR/V_JS` at the top must match §3.

**Generated page shell** (mirrors `product-ide.html`): head boilerplate →
`.vframe` → `<site-header data-active>` → `<main id="main">` (compact hero +
blocks) → `<site-footer data-page>` → optional `#lightbox` → `script.js`.

**Block renderers** reuse existing classes: compact hero (`.hero.hero--center
.subhero` + `.subhero-back`), `orch-rows` (numbered feature rows with `.img-ph`
aurora frames), `feature-grid.card-grid-3` (on `.band-light`), `valley` CTA,
plus company variants (people grid, prose, contact form).

## 7. Page inventory (59) & copy fidelity
- **Hand-authored (12):** index, pricing, product, governance, security,
  security-compliance, deployment, solutions, industries, product-ide,
  industry-financial-services, how-it-works.
- **Generated (47):** 5 product tools (`product-ai-lab`, `-chat-studio`,
  `-deep-agent`, `-langflow`, `-browser`), 9 core blocks (`product-agents` …
  `product-prompt-engineering`), 6 governance children (`governance-audit` …
  `-secrets`), 2 security children (`security-architecture`,
  `-data-protection`), 5 deployment children (`deployment-cloud-hosted` …
  `-desktop`), 7 solutions (`solution-*`), 7 industries (`industry-*`), 6 company
  (`about`, `team`, `careers`, `contact`, `developer-resources`, `blog`).
- **Copy fidelity:** the 12 hand-authored pages are *adapted* to our voice
  (some headlines coincidentally verbatim: security, pricing, financial-services;
  per-page pre-footer CTAs are near-verbatim). The 47 generated pages use
  **verbatim-sourced** calliope.ai copy (clean feature bullets; a few heroes
  read long/run-on due to the flat crawl). **Pricing plan DATA is 1:1** with
  calliope.ai (see §10).
- **Naming/linking conventions:** flat slug filenames, absolute `/paths`,
  `data-active` per nav section, `data-page` per CTA. Link audit must stay at
  **zero dangling `.html` targets** (run the Python audit after any link change).

## 8. Image assets (`public/img/`)
- `bg.png` — **brand aurora gradient (navy→purple→cyan, grainy)**. This is the
  **backdrop for every image** (cursor.com style): `.img-ph` renders bg.png as a
  cover background with the screenshot/placeholder *floating* on top (rounded +
  shadow + padding). Also fills the studio `.mock-aura` image halves and the
  industry carousel cards.
- `calliope-img/1.png` — the **muse statue at a desk** (with lightbulb), used in
  the Problem section.
- `calliope-img/2.png` — **marble hand** — the hero hand AND the pre-footer CTA
  figure.
- `calliope-img/3.png` — **marble hand** — the footer hand (reaches in from
  bottom-left).
- `screen1.png … screen17.png` (16 files) — product screenshots; a few are used
  in the homepage use-cases bento (now trimmed to 1 big + 2 small).
- Logos: `calliope logo.png`, `zentinelle logo.png`, `astroliftlogo.png` (white
  text; spaces in filenames → URL-encode `%20`).
- `header.png`, `scren2.png` — legacy/misc.

## 9. Design system (`styles.css`) — key tokens & components
- **Tokens** (`:root`): `--navy:#162345`, `--navy-deep:#0e1730`,
  `--navy-card:#1b2a52`, `--cyan:#3ff1ef` (primary accent/CTA), `--purple:#5a4dc7`
  (secondary). Light-band tokens `--l-bg:#eaf0fb`, `--l-ink:#131a2e`,
  `--l-soft`, `--l-accent:#5a4dc7` (purple reads better than cyan on light).
  `--radius:6px`, `--maxw:1140px`. Fonts: **DM Sans** (headings), **IBM Plex
  Sans** (body).
- **`.vframe`** — fixed vertical frame lines at `50% ± 588px` (Cloudflare-style).
  Full-bleed grids align to these via `.bleed-frame`
  (`margin-inline: max(1.5rem, calc(50% - 588px))`).
- **`.band-light`** — light section; has a built-in coarse grain/noise `::before`.
- **`.hero` / `.hero--center` / `.subhero`** — hero variants; subpages use the
  compact `.subhero` (no big hero image).
- **`.orch-rows` / `.orch-row`** — *orchestra.bio style* feature rows: full-bleed,
  circular numbered badge (`.orch-no`), a **vertical divider** between text and
  image, the **image half filled with bg.png** (`.img-ph`), horizontal dividers
  between rows. Alternating layout via `:nth-child(even)`.
- **`.show-row`** (homepage studio) — same treatment: full-bleed, vertical
  divider, bg-filled image half with the CSS `.mock-panel` floating on it; rows
  **touch (no gap)**.
- **`.img-ph`** — image frame = bg.png aurora + floating content (see §8).
- **`.feature-grid.card-grid-3`**, **`a.feature`** clickable cards w/ `.feat-go`,
  **`.bento`** (use-cases), **`.rt-bento`** (Retool-style product family).
- **`.indfocus`** — industry-focus **carousel** (light band): auto-rotates right,
  prev/next arrows, **drag/swipe** (mouse drag + native touch), `.indcard` tiles.
- **Pricing:** `.dep-cards` (BYOC/Managed cards), `.bill-toggle` (annual/monthly
  with animated price roll `num-roll`), `.cmp` full-bleed comparison table,
  `.ent-band`, `.sprawl-table` (vs tool-sprawl), `.cloud-grid` (AWS/GCP/Azure
  status), `.faq-list`/`.faq-q` accordion.
- **`.precta`** — light squared pre-footer CTA (text left, figure right, line
  grid). **`.valley`** — dark final CTA with `.rotator` animated word.
- **A11y:** global `:focus-visible` ring, `.skip-link`, readable
  `.band-light .btn-ghost`, `prefers-reduced-motion` respected (reveal, rotator,
  carousel, price roll).

## 10. Pricing — must stay 1:1 with calliope.ai
Per-user model (NOT the old Teams/Business tiers):
- **Deploy in Your Cloud (BYOC)** — **$39/user/mo** annual, **$45** monthly.
- **Deployed in Our Cloud (Managed)** — **$199/user/mo** annual, **$229** monthly.
- **Enterprise** — Custom.
- 19 integrated tools, **10-user minimum**, BYOK with **zero token markup**,
  annual default / monthly +15%, no long-term contract, Stripe checkout.
- Full 20-row **comparison table** (BYOC/Managed/Enterprise), the **tool-sprawl
  market-rate table** (total $350–$640/user/mo vs Calliope $39), **cloud-support
  matrix** (AWS Fully supported / GCP In progress / Azure Planned), FAQ, and the
  "agentic systems" / "stop paying for tool sprawl" copy.

## 11. Verified brand facts (from the calliope.ai GitHub + crawl)
- **12+ model providers** (Claude, GPT, Gemini, Mistral, Groq, Cerebras,
  Fireworks, xAI/Grok, Ollama, OpenRouter, GitHub Models, DeepSeek). Claude Code,
  Gemini CLI, Codex built in.
- **Zentinelle = 24 policy controls**, tamper-evident audit; frameworks: SOC 2,
  GDPR, HIPAA, EU AI Act, NIST AI RMF, ISO 27001/42001.
- **Astrolift** = deploy to AWS/GCP/Azure/K8s, BYOC, VPC peering, on-prem,
  air-gapped.
- Tagline themes: "Built on open tooling… Secured by design", "Zero lock-in",
  "your data never leaves your perimeter".

## 12. Conventions & gotchas
- Edit shared chrome in `site-header.js` / `site-footer.js` only (one source).
- After ANY link change, run a Python link audit over `public/*.html` +
  `site-*.js` for dangling `.html` targets — keep it at zero.
- Re-run `python3 scripts/gen_pages.py` after editing `pages_content.json` or the
  generator; bump versions if you touch `styles.css`/components.
- The homepage section order (current): hero → proof → **industry carousel** →
  studio (journey + orchestra rows) → use-cases bento → problem → how → product
  family → blueprint → valley. (Removed earlier: "Own your AI…" solution section,
  the "Drive Calliope from a single cell" magic section.)
- Image spots are **aurora `.img-ph` placeholders** until real screenshots are
  supplied (drop in an `<img>` inside `.img-ph` and it floats on bg.png).
