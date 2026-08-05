---
title: "Self-serve custom reports"
type: story
status: planned
priority: medium
estimate: L
depends_on: [phase-2-build.reporting-parity.custom-report-catalog-parity]
labels: [phase-2, reporting, self-serve, parity, 2a]
date: ~
---

Let dealers build and save their own custom reports — the self-serve half of reporting parity — on the Phase-1 Superset platform, within tenant-scoped, RLS-enforced boundaries.

**Scope:**
- Dealer-facing report/chart builder over the governed dataset layer, scoped by the Phase-1 per-tenant guest-token + RLS harness so a dealer only sees its own data.
- Save, name, and share custom reports within a tenant; promotable to the managed catalog.
- Store-neutral, like the catalog parity — standard SQL over whichever analytical store the cloud bake-off selects.

**Acceptance:** a dealer composes, previews, and saves a custom report against only its own tenant data; saved reports persist and re-render; no cross-tenant data is reachable.

**References:**
- Decided 2026-06-14: two-layer reporting on Apache Superset; per-tenant isolation derived from the existing tenanted data-isolation model via per-session guest-token RLS (no second isolation mechanism); Metabase Pro self-serve drag-and-drop is an optional add-on, not baseline — `memory/decisions.md#d-029`
- Updated 2026-06-21 (Leo): RLS confirmed as the isolation mechanism (`app.current_tenant` GUC, `FORCE ROW LEVEL SECURITY`) — `memory/decisions.md#d-004`
- `docs/cdp-architecture.md` / `wiki/Privacy-by-Design.md` — Superset reporting (self-hosted, headless/embedded, BI-as-code) and RLS as the multi-tenant isolation primitive
