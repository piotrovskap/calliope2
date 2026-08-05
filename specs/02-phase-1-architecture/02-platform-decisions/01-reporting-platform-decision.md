---
title: "Reporting platform decision"
type: story
status: done
priority: high
estimate: M
depends_on: [phase-0-discovery.data-inventory.juicebox-report-triage]
labels: [reporting, decision, phase-0-architecture]
date: ~
artifacts:
  - "Reporting data flow (target) | docs/deliverables/reporting-data-flow.md"
---

**Decided (2026-06-14):** the reporting layer is **Apache Superset run as a headless/embedded engine** on an open, self-hosted baseline (per-tenant guest-token + RLS, dashboards-as-code). Full comparison in the Reporting Strategy artifact (`analysis/artifacts/reporting-strategy/`).

**Alternatives assessed and kept on the table** (so the client can trade license cost for delivery speed if they prefer):

- **Metabase Pro** — best non-technical drag-and-drop authoring; optional add-on; per-seat cost grows at the ~1,700-dealer fan-out.
- **Custom-build** — thin reporting layer over the CDP serving views; maximum control, $0 license, more engineering.
- **Evidence.dev** — BI-as-code, cheapest to serve, but static + code-authored.
- **Power BI** — DAS already has access; staffing-constrained (no internal devs).

Recommendation stands as Superset (open, $0 license); the alternatives are documented for an explicit client choice. Informed by the Juicebox report triage (which reports are genuinely client-facing).

**Acceptance:** the reporting platform is recorded as a dated decision (Superset baseline, alternatives kept on the table for an explicit client trade-off), the full comparison exists in `analysis/artifacts/reporting-strategy/`, and the pre-lock spike items (headless guest-token chart-data calls honor per-tenant RLS outside the Embedded SDK, Superset pinned 6.0+, `GUEST_TOKEN_VALIDATOR_HOOK` cross-tenant-leak guard) are captured with owners.

**References:**
- Decided 2026-06-14 (Alicia + Luis): Apache Superset as the headless/embedded reporting engine, self-hosted Apache-2.0; Metabase Pro / custom-build / Evidence.dev kept as documented alternatives — `memory/decisions.md#d-029`
- Decided 2026-06-14: per-tenant isolation derived from the existing tenanted data-isolation model (no second isolation mechanism); dealer onboarding a scripted guest-token loop — `memory/decisions.md#d-031`
- `analysis/artifacts/reporting-strategy/` (decision-process.md, strategy.json) — full platform comparison and rationale
- `wiki/Tech-Stack.md` — current DAS reporting layer (DWRPT/Juicebox/Power BI) being replaced
