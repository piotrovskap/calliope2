---
title: "Legacy system deprecation"
type: story
status: planned
priority: medium
estimate: XXL
depends_on: [phase-1-build.ssis-reimplementation, phase-1-build.report-migration]
labels: [deprecation, legacy, long-tail, 1b]
date: ~
---

Retire SSIS / CDXP / EDW once the CDP is the reliable source of truth: source-of-truth cutover, decommission of the old pipelines and stores, and stakeholder comms throughout.

**Acceptance:** source-of-truth is cut over to the CDP and SSIS/CDXP/EDW pipelines and stores are decommissioned (no production reads or writes against them), with the cutover and decommission communicated to stakeholders and no consumer left depending on the retired systems. **Milestone.**

**References:**
- Decided 2026-06-12 (Dan Aston): CDP becomes the source of truth FOR the apps, enabling retirement of the SSIS jobs — `memory/decisions.md#d-059`
- Decided 2026-06-12 (Dan + Mike, exec sync): legacy SSIS/CDXP stack retires once the CDP is reliable; "jobs will all get dropped", don't redo the legacy system — `memory/decisions.md#d-059`
- Decided 2026-06-15 (ETL delivery): original-sources-only, CDP replaces EDW (no EDW ingest dependency at cutover) — `memory/decisions.md`
- Decided 2026-06-14 (reporting): Redshift replaces EDW's reporting role; Juicebox/DWRPT procs not ported — `memory/decisions.md#d-075`
- Decided 2026-06-13 (CCID role): no production read path depends on CCID after cutover; CCID retained as legacy identifier only — `memory/decisions.md#d-110`
- `docs/cdp-architecture.md` — CDP ingests from original sources, becomes the system of record, and retires the legacy ETL once reliable
