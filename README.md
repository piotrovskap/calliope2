# DAS Technology — Customer Data Platform

**Client:** Dan Aston / DAS Technology (Digital Air Strike)
**Engagement:** CONFLICT — forward-deployed engineering
**Phase:** Phase 0 — Discovery & Scoping (complete — awaiting DAS sign-off; started 2026-05-27)

---

## What This Is

This is the workspace metarepo for the DAS CDP engagement. It is the central command for all repos, knowledge, and tooling related to building a Customer Data Platform for DAS Technology.

DAS has consumer and vehicle data scattered across CRMs, DMS platforms, ad channels, and internal apps — with no unified view of who a customer is across dealerships. The CDP fixes this at the root: one system that ingests data from every source, resolves it to a single consumer identity, stores it clean, and exposes it via API to anything that needs it.

## Workspace Layout

```
das-tech/                         ← this metarepo
├── bootstrap.md                  ← workspace conventions (read before everything)
├── PROCESS.md                    ← branch/commit/PR/release conventions
├── CLAUDE.md / AGENTS.md         ← agent shims → bootstrap.md
├── Makefile                      ← workspace-level targets
├── memory/                       ← workspace memory (cross-repo decisions)
└── wiki/                         ← GitHub wiki submodule (knowledge base)
```

Subrepos — added as submodules when the build begins, each instantiated **1:1 from a `boilerworks` base template**. The `boilerworks-*` repos are the reusable starting points; the `das-cdp-*` repos are the DAS instances built from them:

| Submodule | Built from (boilerworks base) | Purpose |
|---|---|---|
| `das-cdp-app` | `boilerworks-django-nextjs` | Django backend + Next.js frontend |
| `das-cdp-opscode` | `boilerworks-opscode` | Infrastructure-as-code, CI/CD |
| `das-cdp-dags` | — | Airflow DAGs — batch ETL per source system (managed or self-hosted Airflow), the modernized replacement for the legacy SSIS pipeline |
| `das-cdp-docs` | `boilerworks-docs` | External documentation site |

Stack determined by Phase 0 — see [`memory/decisions.md`](memory/decisions.md).

## Phase 0 — Discovery (complete — awaiting DAS sign-off)

Fixed-scope discovery engagement (~1 month) that mapped the real data, validated assumptions, and produced a concrete build recommendation before any code. **Complete; awaiting DAS sign-off.**

**Key questions Phase 0 answers:**
- What do the actual data sources look like? Formats, quality, gaps?
- What does the unified Dealer-Customer record look like across 100+ sources?
- What are the reliable identity keys? Where does identity break down?
- Which ingestion channels matter first?
- What's the right technology and infrastructure for DAS's constraints?
- Refined scope, risk register, build estimate.

See `wiki/Phase-0.md` for the full scope and deliverables.

## Delivery Phases

This repository is the **Phase 0 planning and scaffold** for a production-ready CDP, not the production CDP itself. The immediate roadmap is intentionally crisp; later phases are directional until Phase 1 produces real operating data.

| Phase | Scope | Ingestion posture |
|---|---|---|
| **Phase 0 — Planning** | Discovery, source evidence, architecture recommendation, security-by-design, identity-resolution policy/framework, privacy/tenant model, risk register, and buildable roadmap. | Inventory and prioritize sources; no production ingestion. |
| **Phase 1 — Build** | Productionized CDP V1: data model, tenant security, golden record, priority ingestion spine, identity resolution, APIs, admin/dealer surfaces, and VSS-ready consumer record. | Implement the ingestion framework and highest-value sources needed to make the CDP real. |
| **Phase 2 — Applications** | Application layer on top of CDP data: utilities, activation, dashboards, source-onboarding console, and downstream product surfaces. | Continue source onboarding as applications and activation require it. |
| **Phase 3 — AI/ML** | Advanced identity, model-assisted review, predictive/decisioning layers, and agentic/AI applications on the CDP backbone. | Keep expanding feeds where model quality and product use cases justify it. |
| **Future horizon** | Phase 4+ is intentionally fuzzy until the platform is live. | Source ingestion remains continuous as DAS adds systems and use cases. |

## Quick Reference

- **Bootstrap doc:** [`bootstrap.md`](bootstrap.md) — read this first
- **Process:** [`PROCESS.md`](PROCESS.md)
- **Wiki / knowledge base:** [`wiki/`](wiki/) (GitHub wiki submodule)
- **Memory:** [`memory/MEMORY.md`](memory/MEMORY.md)
- **Client / agent review brief:** [`docs/client-agent-brief.md`](docs/client-agent-brief.md) — concise map of what Phase 0 delivered and where the evidence lives

## For Client / Agent Review

If you are pointing an agent at this repository to answer "what did we pay for?", start with [`docs/client-agent-brief.md`](docs/client-agent-brief.md), then follow its review path through objectives, ETL inventory, field-source mapping, architecture decisions, and specs.

The core value here is Phase 0 research and architecture readiness: DAS source systems mapped, legacy ETL understood enough to replace safely, security/privacy/identity decisions captured, CDP ingestion boundaries clarified, and a spec tree prepared for Phase 1 build planning.

## Cloning

```bash
git clone --recurse-submodules git@github.com:ConflictHQ/das-tech.git
cd das-tech
```

If you already cloned without `--recurse-submodules`:

```bash
git submodule update --init --recursive
```
