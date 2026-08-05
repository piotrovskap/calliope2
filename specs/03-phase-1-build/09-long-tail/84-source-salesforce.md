---
title: "Onboard Salesforce"
type: story
status: planned
priority: medium
estimate: M
depends_on: [phase-1-build.long-tail.primitive-api]
labels: [long-tail, source, account, api, ingest, 1b]
date: ~
---

Onboard the **Salesforce** source through the api primitive: register it in the source registry, map its schema and identity keys to the canonical model, validate tenant attribution, and land it through ingest to processed. Config + mapping against the `primitive-api` scaffold — no bespoke connector code.

**Acceptance:** Salesforce records land through ingest with correct tenant attribution, map to the canonical identity keys, and reconcile to source counts; the source is declared as a single registry entry (per-connection instances handled as registry config, not new stories).

**Subtasks:** dealer accounts / product flags.

**References:**
- Decided 2026-06-18 (Leo): the CDP ingests from **original sources, not EDW/DWRPT** — `memory/decisions.md`
- Config-driven source registry — one declarative entry per source, no bespoke connector code — `specs/03-phase-1-build/04-ingest/06-source-registry.md`
- `docs/cdp-field-source-matrix.md` — per-source identity keys + field mapping; `docs/source-onboarding-ledger.md` — the source decomposition plan
