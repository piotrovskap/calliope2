# Calliope

Rebrand of **Calliope** into a **private-AI studio** — a complete AI development studio you buy,
deploy on your own cloud, and govern with your own security/GRC. This repo holds the static
marketing landing (deployed on Cloudflare Pages), a standalone design system / Storybook, and
reference material from the current calliope.ai.

## Structure

```
public/                 # the landing page (Cloudflare Pages output dir)
  index.html            # private-AI studio landing (dark, lead-magnet optimized)
  styles.css            # rebrand design system (navy + cyan + purple, DM Sans / IBM Plex Sans)
  script.js             # exit-intent modal, mega-menu, command-palette search, lead capture
design-system/          # standalone Storybook + shadcn core components & brand tokens
  reference/            # crawl of calliope.ai (screenshots + site-content.json) and tokens
docs/
  calliope-ai-sitemap.md  # full IA tree of the current calliope.ai (also below)
wrangler.toml           # Cloudflare Pages config (pages_build_output_dir = "public")
```

## Local preview

```bash
# any static server works; assets use root-absolute paths (need HTTP, not file://)
cd public && python3 -m http.server 4321        # http://localhost:4321
# or, closer to production:
npm install && npm run dev                        # wrangler pages dev public
```

## Deploy (Cloudflare Pages)

```bash
npx wrangler login
npm run deploy                                    # wrangler pages deploy public
```

Or connect the GitHub repo in the Cloudflare Pages dashboard: build output `public`, no build command.

## Design system (Storybook)

```bash
cd design-system && npm install && npm run storybook   # http://localhost:6006
```

Core shadcn components (Button, Badge, Card, Input, Label) plus Colors/Typography foundations,
themed with brand tokens extracted from the live calliope.ai. Visual review via Chromatic
(`npm run chromatic`).

---

## Current calliope.ai — sitemap

Reconstructed from a full crawl of the live site (**57 pages**; via Wayback snapshot since
calliope.ai is behind a Cloudflare bot challenge). Raw content lives in
`design-system/reference/site-content.json`. The live governance product is **Zentinelle GRC**
(renamed **Zemtino** in the rebrand).

```
/                                    Home — "A Secure AI Development Platform"
│
├─ Platform · The Hub
│  /product/                         The Hub (5 tools + browser)
│  ├─ /product/ai-lab/               AI Lab (JupyterLab + AI)
│  ├─ /product/ide/                  AI IDE (5 modes, 9 providers)
│  ├─ /product/chat/                 Chat Studio
│  ├─ /product/deep-agent/           Deep Agent (research / RAG)
│  ├─ /product/langflow/             Langflow (visual builder)
│  └─ /product/browser/              Secure Browser
│  Core building blocks
│  ├─ /product/core/agents/
│  ├─ /product/core/agent-coding/
│  ├─ /product/core/code-assist/
│  ├─ /product/core/data-agents/
│  ├─ /product/core/datasets/
│  ├─ /product/core/model-hosting/
│  ├─ /product/core/notebook-chat/
│  ├─ /product/core/notebook-generation/
│  └─ /product/core/prompt-engineering/
│
├─ Governance · Zentinelle GRC
│  /governance/                      GRC for AI (control theory)
│  ├─ /governance/audit/             Audit & Observability
│  ├─ /governance/compliance/        Compliance Frameworks (9)
│  ├─ /governance/content-scanning/  Content Scanning (PII / injection)
│  ├─ /governance/policies/          Policy Management (18+ types)
│  ├─ /governance/risk/              Risk Management
│  └─ /governance/secrets/           Secrets & Credentials
│
├─ Security
│  /security/                        Security overview
│  ├─ /security/architecture/        Defense in depth
│  ├─ /security/compliance/          Certifications (SOC 2 / HIPAA …)
│  └─ /security/data-protection/     Encryption, isolation, residency
│
├─ Deployment
│  /deployment/                      Deploy anywhere
│  ├─ /deployment/cloud-hosted/      Multi-tenant SaaS
│  ├─ /deployment/dedicated-cloud/   Single-tenant
│  ├─ /deployment/jump-server/       VPC gateway
│  ├─ /deployment/on-premise/        On-prem / air-gapped
│  └─ /deployment/desktop/           Free desktop app
│
├─ Solutions (by use case)
│  /solutions/
│  ├─ /solutions/agent-platforms/
│  ├─ /solutions/ai-applications/
│  ├─ /solutions/chatbots/
│  ├─ /solutions/data-exploration/
│  ├─ /solutions/internal-automation/
│  ├─ /solutions/knowledge-base/
│  └─ /solutions/research-tools/
│
├─ Industries
│  /industries/
│  ├─ /industries/financial-services/
│  ├─ /industries/healthcare-pharma/
│  ├─ /industries/government-defense/
│  ├─ /industries/energy-utilities/
│  ├─ /industries/life-sciences/
│  ├─ /industries/manufacturing/
│  ├─ /industries/research-academia/
│  └─ /industries/climate-environment/
│
└─ Company & utility
   ├─ /about-calliope/               Founder story (built by CONFLICT)
   ├─ /team/                         The team
   ├─ /careers/                      Careers
   ├─ /contact/                      Contact / book a demo
   ├─ /pricing/                      Teams $2,550 · Business $5,750 · Enterprise custom
   ├─ /developer-resources/          Developer resources
   ├─ /download/                     Download desktop
   ├─ /signup/                       Sign up / login
   └─ /blog/                         Blog
```

| Section        | Pages |
|----------------|-------|
| Product / Hub  | 16 (6 tools + The Hub + 9 core) |
| Governance     | 7 |
| Security       | 4 |
| Deployment     | 6 |
| Solutions      | 8 |
| Industries     | 9 |
| Company / util | 7+ |
| **Total**      | **~57** |

See `docs/calliope-ai-sitemap.md` for the same tree plus IA observations for the rebrand.
