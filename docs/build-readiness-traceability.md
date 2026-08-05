---
title: Build-Readiness & Traceability Matrix
type: reference
status: complete
phase: 0
---

# Build-Readiness & Traceability Matrix

Every critical Phase 1 build story, the acceptance bar that defines "done," and the **locked
decision + supporting doc** that justify it. Nothing here is preference — each row traces to a
dated entry in `memory/decisions.md`. Pairs with [`BUILD-START.md`](../BUILD-START.md) (where to
start) and `docs/cdp-architecture.md` (what it is).

Decision links are clickable (`memory/decisions.md#d-NNN`); open the decision to validate the
acceptance criterion against the reasoning that set it.

---

## 1. Traceability matrix

### Data model & storage
| Build story | Acceptance criterion (key) | Traced to decision | Doc |
|---|---|---|---|
| `backend-data-model.data-model-foundation` | 15-table set deploys (11 core + 4 AI/ML stubs); **zero migrations for Phase 2**; bitemporal provenance (`tstzrange` + GiST exclusion); EAV+JSONB for catalog fields | 15-table locked 2026-06-18 (Alicia + Luis); bitemporal `memory/decisions.md#d-082` | `docs/deliverables/cdp-scoping-document.md`, `wiki/Data-Model.md` |
| `backend-data-model.rest-surface` | REST (Django REST) serves ingest / ops / admin CRUD | dual-surface reconfirmed 2026-06-18; Python-primary `memory/decisions.md#d-088` | `docs/cdp-architecture.md` |
| `backend-data-model.graphql-surface` | GraphQL (Strawberry) serves Consumer-360 reads | dual-surface reconfirmed 2026-06-18 | `docs/cdp-architecture.md` |

### Ingestion
| Build story | Acceptance criterion (key) | Traced to decision | Doc |
|---|---|---|---|
| `ingest.airflow-split` | Airflow owns **all** ingest, Temporal owns the app layer — no overlap, CI-guarded | `memory/decisions.md#d-072` | `docs/deliverables/target-state-data-flow.md` |
| `ingest.source-registry` | New source = one config-driven registry entry, not new code; lands **raw-first** to encrypted bronze before normalize | raw-first `memory/decisions.md#d-098`; NATS backbone `memory/decisions.md#d-070` | `docs/deliverables/target-state-data-flow.md` (intake) |
| `ingest.cdc-capture-debezium` | CDC streams source inserts/updates/deletes continuously; ingest from **originals, not EDW/DWRPT** | Debezium-primary `memory/decisions.md#d-091` / `memory/decisions.md#d-093`; originals-only (SSIS deep-dive 2026-06-08) | `docs/cdp-architecture.md` |

### Identity resolution
| Build story | Acceptance criterion (key) | Traced to decision | Doc |
|---|---|---|---|
| `identity-resolution-engine` | Deterministic Tier-1 match (email/phone/VIN/dealer-ID) + human conflict queue; **ML earned in Phase 2** on Phase-1 labels; AI/ML tables ship empty-but-complete | Option A locked `memory/decisions.md#d-104` | `docs/deliverables/identity-resolution-strategy.md` |
| `identity-curation-data-quality` (survivorship) | Source-trust ladder selects the golden value; **DMS is ground truth**; field-level provenance | survivorship ladder `memory/decisions.md#d-107` | `docs/deliverables/identity-resolution-strategy.md` |
| `identity-curation-data-quality` (household) | Household/family resolution is a first-class derived entity (recomputable, allowed to be wrong) | matching model locked 2026-06-18 (Alicia + Luis) | `docs/deliverables/identity-resolution-strategy.md` |

### Privacy
| Build story | Acceptance criterion (key) | Traced to decision | Doc |
|---|---|---|---|
| `integration-etl-reporting.tenant-guest-token-rls-harness` | A dealer's data is invisible to others at the **database level** even if app-auth is bypassed; resolver runs above tenant RLS, all serving stays tenant-scoped | RLS multi-tenant decided 2026-06-17/18 | `docs/deliverables/privacy-by-design-framework.md` |
| (erasure) | Right-to-erasure = delete the tokenized PII-vault row via a durable Temporal saga; append-only history survives | vault + delete-the-row `memory/decisions.md#d-012`; erasure saga `memory/decisions.md#d-011` | `docs/deliverables/privacy-by-design-framework.md` |
| (consent) | Consent is **first-class** (per person/channel/tenant), typed + per-channel; portable app-built hash-chained ledger, no KMS coupling | consent ledger `memory/decisions.md#d-013`; taxonomy `memory/decisions.md#d-097`; first-class `memory/decisions.md#d-111` | `docs/deliverables/privacy-by-design-framework.md` |

### Infrastructure
| Build story | Acceptance criterion (key) | Traced to decision | Doc |
|---|---|---|---|
| `foundation.*` (IaC, accounts, data stores, CI/CD, observability, DR) | Portable OSS core on k8s + managed tier; dev baseline first, prod rightsized on observed load; OTel → Prometheus/Grafana/Jaeger | rightsize-on-load 2026-06-16; portable core / Azure-primary preferred 2026-06-17 | `docs/cdp-reference-topology.md`, `docs/deliverables/cloud-alignment.md` |
| (auth) | Auth0 primary (federates EntraID), 4-role group model | Auth0 primary `memory/decisions.md#d-086` | `docs/cdp-architecture.md` |

### Portal & reporting
| Build story | Acceptance criterion (key) | Traced to decision | Doc |
|---|---|---|---|
| `integration-etl-reporting.*` | Apache Superset (self-hosted, $0 license) replaces Juicebox; per-tenant isolation from the same RLS model (no second mechanism) | Superset / reporting decided 2026-06-14 | `docs/deliverables/reporting-data-flow.md` |
| `frontend.*` | Next.js admin dashboard, dealer portal, conflict-queue UI, VSS | Next.js kept from v3 (2026-06-13) | `docs/cdp-architecture.md` |

---

## 2. Build-readiness checklist

What's **locked and ready to build** vs **resolved at build time**, by domain. Everything checked
is a decision, not an assumption.

**Data model & storage**
- [x] 15-table Phase-1 set (11 core + 4 AI/ML stubs) — locked 2026-06-18
- [x] Bitemporal + EAV/JSONB shape — locked
- [ ] Schema DDL written + expand/contract migration tests *(build-time)*

**Ingestion**
- [x] Four channels / one pipeline, raw-first, bus-agnostic — locked
- [x] Airflow=ingest / Temporal=app split — locked
- [ ] Debezium CDC tuned against live source DBs; Event Grid subscription wired *(build-time)*

**Identity**
- [x] Deterministic-first (Option A), ML deferred to Phase 2 — locked
- [x] Survivorship / source-trust ladder, DMS ground truth — locked
- [ ] Match precision validated against the curated golden record *(build-time)*

**Privacy**
- [x] Tenant RLS isolation model — locked
- [x] Tokenized PII-vault + delete-the-row erasure (saga) — locked
- [x] Consent first-class, app-built ledger — locked
- [ ] RLS isolation harness proves cross-tenant invisibility *(build-time)*

**Infrastructure**
- [x] Portable OSS core on k8s + managed tier — locked
- [x] Observability + DR posture — locked
- [ ] Cloud substrate (AWS vs Azure) — **DAS's decision, not recorded** (bake-off is the input)

**Portal & reporting**
- [x] Superset reporting, per-tenant RLS — locked
- [x] Next.js frontend surfaces — locked
- [ ] Reporting parity vs Juicebox sampled set *(Phase 1b / 2)*

---

## 3. Assumptions to validate in sprint 1

The plan rests on these; prove them on the first vertical slice, don't assume:

1. **Zero-migration data model** — the 15-table set carries the first real source with no schema change (the all-from-day-1 bet).
2. **Split-estate ingest cost** — cross-cloud egress holds near the modeled ~$90/mo on the first live CDC stream.
3. **AI-assisted throughput** — delivery rate approaches the model behind the ~4-month 1a target; measure against the first 10 issues' actuals (`BUILD-START.md`).
4. **Deterministic match coverage** — Tier-1 deterministic matching resolves enough of the first source that the conflict queue stays a tail, not the main path.
5. **Legacy `3BHS001` extraction** — read-replica / low-impact-window extraction works without disturbing the un-mapped dependencies.

---

*Decision log behind every row: `memory/decisions.md`. Where to start building: `BUILD-START.md`.*
