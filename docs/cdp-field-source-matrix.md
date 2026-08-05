# CDP Field Source Matrix

> **Deliverable.** This mirrors the working sheet **"DAS CDP — Data Source Catalog"** ([Google Sheet](https://docs.google.com/spreadsheets/d/1i5F7TSkwYqlVTVjCGJ4igIF1PEBmKws1l1qnzWjCliU/edit)) — two tabs: **Field Matrix** (this matrix) and **Source Index** (below). The sheet is the live working copy; keep this markdown in sync when either changes.

For each field in **Field Catalog v1 (the initial 27 CDP data points — the bare-minimum MVP floor)**, where the data actually comes from in DAS's source/ETL layer — source table.column, provider coverage, the ETL ingestion path, and availability. Bridges three docs:

- **CDP target** ← `artifacts/phase-0/source-docs/das-cdp-mvp-spec-v4.md` §2 (the Catalog v1 fields → CDP schema)
- **Source column + provider** ← `artifacts/phase-0/source-docs/vss-data-mapping.md` (DAS-provided field→source mapping)
- **Ingestion path** ← [`etl-data-inventory.md`](etl-data-inventory.md) (which ETL module/procs process the source)

> **Scope — this matrix is Field Catalog v1: the bare-minimum MVP floor, not the architecture ceiling.** It scopes the *first* CDP slice; it is not the target, and the catalog is designed to grow past it — we are building and designing past MVP. DAS's own spec frames the 27 as "the core of a much larger picture" with 100+ sources feeding enrichment. Phase 0 must architect for **post-MVP** from day one: the EAV + JSONB attribute model (catalog fields 14–27 already use it) so new fields land without schema migration, an "inventory item" generalization beyond `vehicle` for non-auto verticals, and an ingestion layer that onboards new sources without rework. Treat this table as the starting set to prove the pipeline — design the data model, identity graph, and ingestion to scale well past it. Expansion candidates accrue in [Candidate Fields (post-v1)](#candidate-fields-post-v1) below.

> **At a glance:** ~12 of 27 fields have a confirmed source today — almost all from the **DMS sales/service feed** (Authenticom + CDK) plus **BlackBook** for equity. The rest are **gaps** requiring new integrations or are derived. Service-history, warranty, insurance, and upgrade fields have no current source.

> **Field prioritization — LOCKED 2026-06-19 (Alicia Salazar):** 14 fields are **valuable-now** (Phase 1 build target); 13 are **interesting-later** (Phase 2+). See `memory/decisions.md` "Field prioritization" and the `Phase` column in each table below.

> **Grounding status — discovery-level, not yet implementation-bound.** The source paths here are abbreviated / provider-level / point at not-yet-dumped DBs, so `scripts/gen-field-catalog.py` resolves **0 of 27** to concrete dumped DDL columns. That is expected at Phase-0 discovery. **Phase 1 must bind every field to a concrete `db.schema.table.column` source against dumped DDL before that field is implemented** — this is a build-time gate, not a Phase-0 prerequisite for locking the Catalog v1 priorities. The 16 fields carrying `VALIDATE`/`GAP` status are exactly the ones that need that binding/validation first. (This 0/27 is **not** "no source mapping": the golden record (`analysis/artifacts/golden-record/record.json`) carries **verified column-level source mappings for 27 of its 34 modeled fields** — discovery-level, from DDL dumps + research pages + vendor docs, each tagged with an access status. The 0/27 here is specifically the automated match of *these matrix source-path strings* against the dumped schema (`docs/databases/schema.json`), which fails on abbreviated / wildcarded / cross-DB / not-yet-dumped paths. Phase 1 wires those verified mappings to concrete dumped columns.)

> **Provenance:** source/provider columns are DAS-authored (VSS data mapping); the ETL path was verified against the `etl/` submodule (removed 2026-06-11; the `etl/` paths below are historical — see `docs/etl-data-inventory.md`). Items the VSS mapping marks "No" but the ETL catalog shows a plausible source (e.g. DMS service) are flagged **validate** — open discovery questions, not asserted availability.

---

## Matrix

Legend — **Status:** OK = available · VALIDATE = partial, confirm in discovery · GAP = no current source. **Phase:** P1 = valuable-now (Phase 1 build target) · P2 = interesting-later (Phase 2+). **Provider:** A = Authenticom, C = CDK, BB = BlackBook.

### 2.1 Vehicle & Owner Info (13) — primarily DMS sales/service

> **PII destination = vault, not raw column.** The `CDP target` cells for identity-class PII (name, email, phone, address) name where the field logically belongs to the consumer; the **raw value is held in the mutable PII vault keyed by a surrogate token**, and `consumer`/golden/observation/analytics/search carry a **token reference + non-PII provenance, never the raw value**. This changes only the destination store — the `Source (DB.table.column)` mapping (which source supplies the field) is unchanged; the source still feeds the same value, which is tokenized into the vault on ingest at the CDP boundary. (Email/phone also produce one-way resolver blocking hashes on the `person` shell outside the vault, for deterministic matching; scrubbed on erasure; not raw PII.) Storage model is canonical in `wiki/Privacy-by-Design.md` §PII Handling and `specs/03-phase-1-build/03-backend-data-model/08-pii-vault-erasure.md`.

| # | CDP field | CDP target | Source (DB.table.column) | Prov. | ETL path | Status | Phase |
|---|---|---|---|---|---|---|---|
| 1 | CustomerFirstName | `consumer.first_name` → vault token (raw in PII vault) | `EDW_staging.source_dms_sales/service.CustomerFirstName` | A·C | DMS → `DMS_Fact_Names` → CVH | OK | P1 |
| 2 | CustomerLastName | `consumer.last_name` → vault token (raw in PII vault) | `…source_dms_*.CustomerLastName` | A·C | DMS → `DMS_Fact_Names` → CVH | OK | P1 |
| 3 | CustomerEmail | `consumer.primary_email` → vault token (raw in PII vault) | `…source_dms_*.CustomerEmail` | A·C | DMS → `DMS_Fact/Dim_EmailAddresses` → CVH | OK (identity key) | P1 |
| 4 | CustomerCellPhone | `consumer.primary_phone` → vault token (raw in PII vault) | `…source_dms_*.CustomerCellPhone` | A·C | DMS → `sp_update_DMS_Fact_CellPhone` → CVH | OK (identity key) | P1 |
| 5 | VehicleYear | `vehicle.year` | `…source_dms_*.VehicleYear` | A·C | DMS → `DMS_Fact_Vehicles` → CVH | OK | P1 |
| 6 | VehicleMake | `vehicle.make` | `…source_dms_*.VehicleMake` | A·C | DMS → `DMS_Fact_Vehicles` → CVH | OK | P1 |
| 7 | VehicleModel | `vehicle.model` | `…source_dms_*.VehicleModel` | A·C | DMS → `DMS_Fact_Vehicles` → CVH | OK | P1 |
| 8 | TrimLevel | `vehicle.trim` | `…source_dms_*.TrimLevel` | A·C | DMS → `DMS_Fact_Vehicles` → CVH | VALIDATE — source reliability varies (CDK 3PA vs DMS) — open Q | P2 |
| 9 | VehicleVIN | `vehicle.vin` | `…source_dms_*.VehicleVIN` | A·C | DMS → `DMS_Fact_Vehicles` → CVH | OK (identity key) | P1 |
| 10 | PurchaseDate | `consumer_vehicle.acquired_at` | `…source_dms_sales.ClosedDate` (// DealBookDate/ContractDate) | A·C | DMS sales → `DMS_Fact_Sales` → CVH | OK | P1 |
| 11 | VehicleMileage | `vehicle.mileage` | `…source_dms_*.VehicleMileage` | A·C | DMS → CVH | VALIDATE — snapshot-at-sale; ingest as point-in-time, update from service visits later | P1 |
| 12 | PurchasePrice | `consumer_vehicle.metadata->'purchase_price'` | `…source_dms_sales.FrontGross+BackGross` (// ROAmount) | A·C | DMS sales → `DMS_Fact_Sales` → CVH | VALIDATE — accessible for all dealers? — open Q | P2 |
| 13 | VehicleCondition | `vehicle.vehicle_type` | Derived from deal type in `source_dms_sales` | A·C | DMS sales → deal type flag | GAP — derive from new/used deal type (no direct column) | P1 |

### 2.2 Service & Parts (5)

| # | CDP field | CDP target | Source | Prov. | ETL path | Status | Phase |
|---|---|---|---|---|---|---|---|
| 14 | OemMaintenanceSchedule | `consumer_attribute` | — | — | derived in `Analytics_BlueSky_LifecyclePosition` (prediction, not source) | GAP — no raw source | P2 |
| 15 | CompletedServices | `consumer_attribute` | VSS: none — but `source_dms_service` exists | (A·C?) | DMS service → `DMS_Fact_Services` → CVH | VALIDATE — DMS service feed exists; VSS marked unsupported; validate in Phase 1 | P1 |
| 16 | DeclinedServices | `consumer_attribute` | VSS: none — but declined-service ETL exists | — | DMS → `sp_insert_staging_DMS_Declined_Services` → `…Declined_Service_Flattened` | VALIDATE — ETL exists but messy (Tekion/manual opcodes) | P2 |
| 17 | OpenRecallsByVIN | `consumer_attribute` | `acceleratordb.leads_recall_data` (see RecallMasters sheet) | RecallMasters | PostgreSQL "Recall dashboard data" (`leads_recall_mysql`) | VALIDATE — available via RecallMasters; new vendor integration required | P2 |
| 18 | CompletedRecallsByVIN | `consumer_attribute` | — | — | — | GAP — no source | P2 |

### 2.3 Service History (3)

| # | CDP field | CDP target | Source | ETL path | Status | Phase |
|---|---|---|---|---|---|---|
| 19 | CompletedServicesWithMedia | `consumer_attribute` | — | — | GAP — no source (media not captured) | P2 |
| 20 | ServiceCoupons | `consumer_attribute` | — | — | GAP — no source | P2 |
| 21 | ServicePlanOffering | `consumer_attribute` | COX? (unconfirmed) | — | GAP — provider TBD | P2 |

### 2.4 Protect the Vehicle (1)

| # | CDP field | CDP target | Source | Status | Phase |
|---|---|---|---|---|---|
| 22 | ServiceOrWarrantyPlanOfferings | `consumer_attribute` | N/A — COX? | GAP — provider TBD | P2 |

### 2.5 Equity, Trade-In & Insurance (5)

| # | CDP field | CDP target | Source (DB.table.column) | Prov. | ETL path | Status | Phase |
|---|---|---|---|---|---|---|---|
| 23 | EquityAmount | `consumer_attribute` | `EDW_staging.stage_Vehicle_Valuation` (see BlackBook sheet) | BB | BlackBook → `sp_Calculate_Equity` → `Vehicle_Valuation` | OK | P1 |
| 24 | MarketValue | `consumer_attribute` | `EDW_staging.stage_Vehicle_Valuation` (see BlackBook sheet) | BB | BlackBook → `Vehicle_Valuation` | OK | P1 |
| 25 | VehicleUpgradeOptions | `consumer_attribute` | ResponseLogix? (unconfirmed) | — | — | GAP — provider TBD | P2 |
| 26 | InsuranceProvider | `consumer_attribute` | N/A | — | — | GAP — no source (net-new) | P2 |
| 27 | InsuranceQuoteList | `consumer_attribute` | N/A | — | — | GAP — no source (net-new) | P2 |

## Candidate Fields (post-v1)

The catalog is designed to grow past v1 — this is where expansion candidates accrue as discovery surfaces them. Anything a source feeds that serves the golden record or lifecycle events is eligible; graduation into the next catalog version is a scope decision supporting the progressive build of the record (valuable-now vs interesting-later — Mike's prioritization, 2026-06-12).

| Candidate area | Why | Likely source | Status |
|---|---|---|---|
| Email/SMS engagement events | Best identity signal in the landscape; lifecycle events are the CDP's end-state product | MailGun webhooks, Twilio, Mautic matchback (`utm_term=c_hashkey`) | Candidate — surfaced in discovery |
| Lead events (full payload) | Lead response is in scope as an app-level source (client direction 2026-06-12) | DAS Acceptor → Event Bus, ADF/XML parsers | Candidate — surfaced in discovery |
| Communications data | App-level source named by client | Comms API | Candidate — surfaced in discovery |
| Survey & reputation signals | App-level sources named by client; orphan identifiers (e.g. Facebook reviewer IDs) must be storable before they resolve | Survey systems, Radar | Candidate — surfaced in discovery |
| Web journey events | GCLID/GA4 named in the event time spine | GA4, website pixel | Candidate — Phase 2 channel |
| Inventory reference | "Inventory item" generalization beyond vehicles (decision logged) | HomeNet, Inventory DB | Candidate — generalization driver |

**Graduation rule:** a candidate enters the next catalog version when it has (a) a validated source, (b) an identity key or event linkage, and (c) a consumer that needs it. Each catalog version is a slice — v1 exists to prove the pipeline, not to bound the record.

---

## Source Index

(Mirrors the sheet's **Source Index** tab — every system that feeds or could feed the CDP.)

| Source system | Type | Source tables / feeds | ETL module | Provider(s) | CDP relevance |
|---|---|---|---|---|---|
| **DMS — Sales/Service/Appointment** | DMS feed | `source_dms_sales`, `source_dms_service`, `source_dms_appointment` | `etl/SSIS/DMS` | Authenticom, CDK | **PRIMARY** — owner/vehicle/purchase core (1–12) + identity backbone (VIN/email/phone). Ingest raw, not CVH |
| **CRM — 21+ providers** | CRM | `source_CRM_*` | `etl/SSIS/CRM` | eLeads, DealerSocket, VinSolutions, DriveCentric, Momentum, R&R | Lead/prospect data; feeds identity matching |
| **BlackBook** | Equity API | `stage_Vehicle_Valuation` | `etl/BlackBook` | BlackBook | Equity (23) + Market Value (24) |
| **Recall provider** | Recall data | `acceleratordb.leads_recall_data` | PostgreSQL Recall module | RecallMasters | OpenRecallsByVIN (17) |
| **Email / Engagement** | Legacy email | `[3BHS001]` ClientDB/Lift/Auth/BirdBath | `etl/SSIS/Email` | 3Birds, Mautic | Engagement, matchbacks, GA — not MVP-core |
| **Inventory** | Inventory DB | `[3BHSSQL01].Inventory.dbo.*` | CRM/CVH lookups | DAS | Vehicle reference (make/model/trim) |
| **Authenticom** | DMS aggregator (FTP/SFTP) | feeds `source_dms_*` | `etl/SSIS/DMS` | Authenticom | DMS delivery channel; Batch Pull for CDP |
| **MailGun** | Webhook | — | — | MailGun | Email events → Webhook API |
| **Twilio** | SMS API | — | — | Twilio | SMS → Webhook API |
| **ADF/XML leads** | Email → parser | — | — | TrueCar, Cars.com, … | Leads → Webhook / Bulk Upload |
| **Meta / Facebook** | Lead-forms API | — | — | Meta | Lead forms → Webhook API |
| **Google GA4** | Web analytics | — | `etl/SSIS/Email sp_insert_GA` | Google | Web journey → event stream (Phase 2) |
| **HomeNet** | Inventory API | — | — | HomeNet | Inventory → Batch Pull (Airflow) |

**Key takeaways for the CDP build:**
- The **DMS sales/service feed is the workhorse** — it covers the entire owner/vehicle/purchase core (fields 1–12) and is the identity backbone (VIN, email, phone). The CDP should ingest the raw `source_dms_*` tables, **not** the merged `CVH` layer (per [`etl-data-inventory.md`](etl-data-inventory.md) ingestion guidance).
- **Equity (23–24) is the only enrichment with a real source** (BlackBook), via the round-trip valuation pipeline.
- **~10 fields are net-new** (service history + media, warranty, insurance, upgrade options) — they need new provider integrations or are out of MVP reach. These drive the Phase 1 scope conversation.
- **Validate items** a