<!-- Extracted from the read-only `etl/` submodule (3birdsmarketing/Database-Processes) on 2026-06-09.
     Descriptions authored by DAS / Simform Solutions (module READMEs), verified against the SQL.
     The submodule is a documentation source only and may be removed once this catalog is final. -->

# DAS Data Source & ETL Inventory

Comprehensive catalog of the DAS `Database-Processes` ETL system — **231 SQL objects across 20 modules / 5 platforms** — extracted from the `etl/` submodule for the CDP discovery. This supersedes the earlier "5 of 13 SSIS jobs" inventory.

> **Provenance & verification.** Module descriptions are authored by DAS/Simform (the per-module `README.md` files); object/table/proc names were verified against the actual `.sql`. Verified 2026-06-09 via a multi-agent workflow — 20 per-module README↔code audits + 3 adversarial review lenses (accuracy / completeness / CDP-correctness). README↔code drift was found and corrected for: DMS (13 procs not 12), Mautic Contact Sync (case/signature), Mautic Company Sync (`Sp_Insert_Mautic_Owner_Mapping` proc carries a `_dev` suffix), Sync Processes (`marketing.*` schema), CDXP Watch Rule (`cdxp_watch_rule` is a PROCEDURE). A second accuracy pass (2026-06-09) re-verified all 20 module counts (231 total), every discrepancy, and named procedures against the real `.sql`; one synthesis error was corrected (a non-existent CVH `_new` file). The tables below reflect the **verified** state.

> **CDP ingestion rule.** The CDP ingests from **raw source tables**, never from the CVH merge layer or `JuiceReporting_*`/`marketing.*` reporting tables (which bake in legacy merge/DQ decisions). See *CDP Ingestion Guidance* below and `memory/decisions.md`.

---

## Processing Layers (at a glance)

| Layer | Platform | Modules |
|---|---|---|
| Raw Ingestion | SSIS/EDW | SSIS/CRM, DMS, SSIS/Email |
| Identity / Merge (current) | SSIS/EDW | CVH, CRM_DMS_Recipient_Matches (CRM + DMS) |
| Analytics / Enrichment | SSIS/EDW | BlueSky, BlackBook, Email (MatchBacks/GA) |
| Sync / Activation | Mautic + CDXP | Mautic Contact Sync, Mautic Company Sync, Sync Processes, Contact & Engagement Build |
| Reporting | Juicebox + CDXP | Juicebox Reporting, Marketing Insights, Customer Value Data, Lead Source Index, Recall Dashboard, Client Advocate Proofs, Performance Report, SMS Replies View |
| Housekeeping / Governance | CDXP / SSIS | CDXP Watch Rule, Archival & Deletion, sp_reset_* |

---

## Platform: SSIS / EDW (SQL Server)

| Module | #objects | Purpose | Key tables in/out | CDP relevance |
|---|---|---|---|---|
| **SSIS/CRM** | 68 SQL | Ingest + standardize + consolidate CRM lead data from 21+ providers (DealerSocket, eLeads, VinSolutions, DriveCentric, Momentum...) through multi-stage prestaging into unified CRM | in: source_CRM_DS/EL/VS/RR/ME/MO/MT/DC/DP_*, DMS_Dim_Customers, Email_Recipients, lookup_MakeModelBodyStyle / out: CRM, prestaging_CRM_1, staging_CRM, **CRM_DMS_Recipient_Matches**, lookup_CRM_* | **raw-ingestion-source** (raw prospect data upstream of unification) |
| **DMS** | 13 SQL (README says 12 — missing `dms_data_refresh_prestaging.sql`) | Reconcile dealer transactions (appts, sales, service); customer identity matching DMS↔CRM; geocoding; declined-service tracking | in: source_DMS_Appointment/Sales/Service, cdkapi-*, Prestaging_CRM_1, lookup_Address_Geocode / out: DMS_Dim_* , DMS_Fact_* , **CRM_DMS_Recipient_Matches**, staging_DMS_Declined_Service_Flattened, JuiceReporting_DMS_Sales, Analytics_BlueSky_LifecyclePosition | **identity/merge-layer-CDP-replaces** (raw source_DMS_* feed reporting; DMS_Dim/Fact = merged identity layer) |
| **CVH** | 17 SQL | Merge CRM leads + DMS sales/service/appt + inventory/engagement into unified Customer Vehicle History; authoritative customer identity layer | in: DMS_Fact_Sales, DMS_Dim_Transactions/Customers/Vehicles, DMS_Fact_Services/Appointment, fact_declined_service, 3BHSSQL01 Inventory / out: staging_CVH, staging_CVH_List, **CVH**, **CVH_List** | **identity/merge-layer-CDP-replaces** (canonical unified identity table) |
| **SSIS/Email** | 19 SQL (`JuiceReporting_ClientsOEMParentGroups` → `SP_Insert_...`) | Process email sends/opens/clicks/bounces/engagement from Lift/ClientDB/BirdBath/DMS into EDW; matchbacks + GA web-journey | in: [3BHS001] Auth/BirdBath/ClientDB/Lift.dbo.*, Email_Sends, Analytics_Clients / out: Email_Events/Sends/Recipients/Links, Email_Contact_Attempts/Opens/Clicks/Bounces, Analytics_MatchBacks_60, GA_Referrers, GA_PageViews | **reporting-layer** (engagement aggregation + attribution; enriches recipient data downstream, not primary merge) |
| **BlueSky** | 10 SQL | BlueSky campaign-insight dashboards: contact engagement, vehicle lifecycle, messaging readiness from DMS/CRM/Email | in: CVH, DMS Dim/Fact, Prestaging_CRM_1, CRM_DMS_Recipient_Matches, Email_*, GA_PageViews, OEM_Fact_Schedules, Vehicle_Valuation / out: Analytics_BlueSky_{Recommendations,Contact,CustomerVehicle,Engagement,LifecyclePosition,ProductEngagement,StreamMessages,WillReceiveMessaging} | **reporting-layer** (Juicebox consumes Analytics_BlueSky_* exclusively; uses CVH as identity reference, no unification) |
| **BlackBook** | 7 SQL | Calculate/stage vehicle equity valuations for BlackBook API; historical tracking | in: source_DMS_Sales, DMS_Fact_Sales, DMS_Dim_Transactions/Vehicles, CVH, Analytics_BlueSky_CustomerVehicle/LifecyclePosition, Lift_Site_Groups / out: stage_Vehicle_Valuation, **Vehicle_Valuation**, Vehicle_Valuation_History/_temp | **sync-layer** (equity valuation pipeline for third-party API; enrichment over identity layer) |

### SSIS/CRM — key objects
- `sp_insert_CRM` — creates/truncates CRM, inserts from staging_CRM with phone normalization.
- `sp_insert_staging_CRM` — final staging: dedup by email, validate vs BirdBath bad-email tables, enforce lead source/status standardization.
- `sp_insert_prestaging_CRM_1` — UNION ALL of all 21 provider prestaging_*_2 tables → prestaging_CRM_1.
- `sp_insert_prestaging_CRM_DS_Leads` — DealerSocket: cast/clean via fn_standardize_*, stock-prefix reroute to client IDs.
- `sp_insert_CRM_DMS_Recipient_Matches` — **identity bridge**: matches CRM leads → DMS_Dim_Customers + Email_Recipients by email or name+address.
- `sp_insert_CRM_Daily` — RR/VS incremental delete+reinsert. `sp_reset_CRM` — resets source_CRM_* (IsProcessed=0). `sp_upsert_lookup_CRM_Lead_Source` — reference standardization.

### DMS — key objects
- `sp_insert_prestaging_DMS_Appointment/Sales/Service` — validate/standardize, CDK API enrichment, multi-brand dealer routing (Bob Poynter, Joe Rizza, Garber, Menke, West Herr 194416, Easterns 193041).
- `sp_insert_staging_DMS` → `sp_insert_DMS` — build Dim/Fact schema, PK/FK, call `sp_update_DMS_Fact_CellPhone`, `sp_insert_JuiceReporting_DMS_Sales`, `sp_insert_Analytics_BlueSky_LifecyclePosition`.
- `sp_insert_CRM_DMS_Recipient_Matches` — **identity resolution** (email + lastname+address; IsDMS=1 & IsCRM=1).
- `sp_insert_Alteryx_DMS_Addresses` — geocode → Alteryx_Addresses (lat/long), update DMS_Dim_Addresses FK.
- `sp_insert_staging_DMS_Declined_Services` — flatten Tekion/manual opcodes (120-day) for Juicebox. `sp_reset_DMS` — reset audit/source.

### CVH — key objects
- `sp_insert_staging_CVH` — merge all DMS customers (5+ yr sales/service), CRM leads, appt + engagement → staging_CVH (scores, equity, lease penalties, declined services).
- `sp_insert_staging_CVH_List` → `sp_insert_CVH_List` — bucketed scores, marketing flags → CVH_List (PK ClientID + EDW_DMS_Customer_ID).
- `sp_extract_CVH_List` / `_AM` — marketing-automation extracts (email-masked; IsAutomatedMarketing=1).
- `sp_insert_Inventory_CVH` — copy 3BHSSQL01 Inventory tables. `sp_update_CVH_states` — state standardization. `sp_reset_CVH` — reset + trigger MileOne report.

### SSIS/Email — key objects
- `sp_reset_Email` — full daily refresh from Auth/BirdBath/ClientDB/Lift.
- `sp_insert_prestaging_Email_Recipients_1` — standardize recipient contact data.
- `sp_insert_prestaging_Email_Links` — 40+ binary link flags (IsInventory, IsFinance, IsService...).
- `sp_insert_staging_Email_Contact_Attempts` / `sp_upsert_Email_Contact_Attempts` — consolidate engagement (PK CampaignEventID, RecipientID).
- `sp_insert_Analytics_MatchBacks_60` — email→DMS transaction attribution (90-day window). `sp_insert_GA` — GA_Referrers/PageViews.

### BlueSky — key objects
`sp_extract_Analytics_BlueSky_Recommendations`, `sp_insert_Analytics_BlueSky_Contact`, `_CustomerVehicle`, `_Engagement`, `_LifecyclePosition` (OEM maintenance prediction), `_ProductEngagement` (RA/SA/LA/SSA streams), `_StreamMessages` (geo distance), `_WillReceiveMessaging` (program eligibility, reads CVH_List + CRM_DMS_Recipient_Matches).

### BlackBook — key objects
`sp_Calculate_Equity` / `_clientwise` (loan vs trade-in from DMS history), `sp_insert_stage_Vehicle_Valuation` / `_clientwise` (equity-accelerator group filter), `sp_insert_Vehicle_Valuation` (full/incremental + history), `sp_insert_Vehicle_Valuation_History` (7-day archive).

---

## Platform: Mautic

| Module | #objects | Purpose | Key tables in/out | CDP relevance |
|---|---|---|---|---|
| **Mautic Contact Sync** | 8 SQL (multiple case/signature README discrepancies; RetryCount only, no FailureCount) | Sync contacts EDW CVH ↔ Mautic via Mautic_Contact_Mapping; EXCEPT delta detection, suppression filtering, retry tracking | in: CVH, Mautic_Instance_Group_Membership, mautic_company_mapping, Mautic_Contact_Mapping, ClientDB SuppressionLists / out: **Mautic_Contact_Mapping**, Mautic_Contact_Mapping_List | **sync-layer** (CVH is upstream; sync adapter into Mautic, not identity) |
| **Mautic/Company Sync** | 6 SQL (`Sp_Insert_Mautic_Owner_Mapping` → actual `_dev` suffix) | Sync company/dealer/inventory legacy↔Mautic; dealer profiles, company/owner maps, inventory extracts for Lambda | in: Lift_Sites, ClientDB Clients/Details/RoofTops, states, Inventory.dbo.* / out: **Mautic_Company_Mapping**, **Mautic_Owner_Mapping** | **sync-layer** (dealer/client ID identity maps, not unified customer view) |

- Contact: `sp_insert_mautic_contact_mapping_list` (EXCEPT delta from CVH), `sp_update_mauticContactMapping` (udt_mauticContactMappingUpdate TVP, IsFullSync mileage logic), `sp_Insert_Mautic_Contact_Mapping_V2` (MERGE by hash key), `sp_Extract_Mautic_Contact_CustomerHashKey`, `sp_fetch_mautic_client_id`.
- Company: `sp_fetch_dealer_profile_for_sync`, `Sp_Insert_Mautic_Company_Mapping`, `Sp_Update_Mautic_Company_Id_Simulator`, `Sp_Insert_Mautic_Owner_Mapping_dev`, `Sp_Extract_Desired_Inventory_Generic` (top-5 used → d_aged_used_inv), `Sp_Extract_Desired_New_Inventory_Generic` (top-50 new → d_new_generic_inv).

---

## Platform: PostgreSQL-CDXP (`marketing` schema)

| Module | #objects | Purpose | Key tables in/out | CDP relevance |
|---|---|---|---|---|
| **Sync Processes** | 7 SQL (`upsert_client` → marketing.client not cdxp.client; `update_client_flags` → marketing.client_temp) | Bidirectional legacy↔CDXP/Mautic sync; Lambda upserts of message/campaign/event/client; export unsubscribes | in: marketing.contact/message / out: marketing.message/campaign/event/client/client_temp, lead_video_avgTimeViewed | **sync-layer** |
| **Contact & Engagement Build Process** | 4 SQL | Stage Mautic→CDXP contact/engagement batches for Lambda contact-build | in: marketing.campaign/contact/instance/message/engagement / out: **marketing.contact** | **sync-layer-CDP-orchestration** |
| **Marketing Insights** | 3 SQL | Contact-level engagement + attribution stats; match campaign touches to sales/service/appt | in: marketing.engagement/contact/client/campaign/message/event, analytics_matchbacks_60_legacy / out: **mv_contact_stats**, mv_campaign_type_v0, **tbl_attribution** | **reporting-layer** (attribution engine feeding dashboards) |
| **Customer Value Data** | 1 SQL | Aggregate delivery/open/click by channel for Juicebox Customer Value dashboard | in: marketing.engagement/mv_contact_stats/contact/client / out: juicereporting_cdxp_customer_value_data | **reporting-layer** |
| **Lead Source Index Data** | 1 SQL | Lead Source Index dashboard: engagement/attribution with DaysToClick/DaysToTransact/revenue | in: marketing.mv_contact_stats/contact/engagement/client / out: JuiceReporting_CDXP_Lead_Source_Index | **reporting-layer** |
| **Performance Report** | 2 SQL | Functions: 30-day / 10-day datewise engagement+attribution by instance & send type | in: marketing.mv_contact_stats / out: reporting functions | **reporting-layer** |
| **Recall dashboard data** | 1 SQL | Recall Dashboard: recalls × contacts × campaign stats (Video Recall + sales/service/appt attribution) | in: marketing.leads_recall_mysql/contact/mv_contact_stats / out: juicereporting_recall_dashboard_data | **reporting-layer** |
| **Client Advocate Proofs** | 1 SQL | Top-5 recent email campaigns per internal client w/ preview URLs (strategist proof-of-work) | in: marketing.contact/message/client/instance / out: JuiceReporting_BlueSkyCDXP_DigitalStrategistProof | **reporting-layer** |
| **SMS Replies View** | 1 SQL | Curated Twilio Received-SMS reply view for BI | in: marketing.engagement/campaign/contact/client / out: vw_sms_replies | **reporting-layer** |
| **CDXP Watch Rule** | 2 SQL (`cdxp_watch_rule` is a PROCEDURE not Function) | 16+ QA rules on open/bounce/complaint/click rates + DMS/CRM freshness; alerting | in: marketing.mv_contact_stats/client/event/contact / out: marketing.cdxp_watch | **housekeeping** (guardrail, not a CDP source) |
| **Archival & Deletion** | 2 SQL | Archive marketing data >365d to `archived` schema; delete offboarded-client (>180d) engagement/contact | in: marketing.* / out: archived.* | **housekeeping** |

Key CDXP procs: `upsert_message/campaign/event/client`, `get_unsubscribed_contacts_for_legacy_sync`; `get_campaigns_for_contact_build`, `upsert_contact`, `get_instance`, `get_engagement_ids_for_process`; `mv_contact_stats` (MV), `mv_campaign_type_v0` (MV), `sp_insert_attribution_data` (15–90d windows, VIN/email/phone/address+zip match, excludes analytics_matchbacks_60_legacy dupes); `cdxp_watch_rule` / `get_cdxp_watch`; `archive_one_year_data` (DELETEs commented out) / `delete_offboarded_client_data`.

---

## Platform: Juicebox

| Module | #objects | Purpose | Key tables in/out | CDP relevance |
|---|---|---|---|---|
| **Juicebox Reporting** | 58 SQL (DDE sync calls `sp_insert_JuiceReporting_CDXP_ActivityLogs` / `sp_insert_CDXP_registrations` that don't exist as files) | 50+ denormalized dashboards: Marketing, Sales, Service, DDE, Lead Performance, Customer Journey | in: CVH, CVH_List, Email_*, DMS_Dim_Transactions, DMS_Fact_Sales/Services, JuiceReporting_MatchBacks, Analytics_Clients, callrevuinteractions / out: 25+ JuiceReporting_* tables | **reporting-layer** (consumes CVH identity master + DMS + Email; no merge/sync) |

Orchestrators: `sp_juice_data_sync_CVH_ssis` (DataMiningTool, CustomerJourney), `sp_juice_data_sync_DDE_ssis` (12 DDE procs), `sp_juice_data_sync_bluesky_ssis` (sales/service/lead perf), `sp_juice_data_sync_email_ssis` (engagement/matchback/recipient loss). Leaf procs: `sp_insert_JuiceReporting_Marketing_Summary`, `_BlueSkyOverview`, `_LeadPerformance`, `sp_JuiceReporting_transaction_summary_new`.

---

## Data Flow (cross-module DAG)

```
[21+ CRM providers] [source_DMS_* + cdkapi-* + Tekion]   [3BHS001 Auth/BirdBath/ClientDB/Lift]
        |                       |                                      |
  prestaging_CRM_*       prestaging_DMS_*                        source_*
        |                       |                                      |
  sp_insert_prestaging   sp_insert_staging_DMS                 prestaging_Email_*
  _CRM_1 (UNION ALL)            |                                      |
        |                 sp_insert_DMS                          Email_Recipients/Sends/
  staging_CRM            DMS_Dim_* / DMS_Fact_*                  Events/Contact_* + GA_* +
        |                       |                                Analytics_MatchBacks_60
      CRM <------+              |                                      |
                |              \|/                                     |
        sp_insert_CRM_DMS_Recipient_Matches  <----------------------- Email_Recipients
                          |
              CRM_DMS_Recipient_Matches  (email | lastname+address ; IsDMS=1 & IsCRM=1)
                          |
                 sp_insert_staging_CVH  (+ fact_declined_service, 3Birds Inventory)
                          |
                    CVH  /  CVH_List      <==== platform-wide identity join
                  /        |        \
        BlueSky      BlackBook     Mautic Contact Sync (EXCEPT delta + suppression)
   Analytics_      Vehicle_              |
   BlueSky_*       Valuation       Mautic_Contact_Mapping --> [Mautic exec]
        |             |                  |
        +------+------+            Sync Processes / Contact&Engagement Build
               |                         |
        Juicebox sp_juice_data_sync_*    CDXP marketing.* (contact/message/campaign/event)
               |                         |
        JuiceReporting_* (50+)    mv_contact_stats + mv_campaign_type_v0 + tbl_attribution
                                         |
                                  CDXP Juice tables (Customer_Value, Lead_Source_Index,
                                  Recall_Dashboard, DigitalStrategistProof, vw_sms_replies)
                                         |
                               cdxp_watch (QA) ; archived.* (governance)
```

Condensed: **CRM + DMS → CRM_DMS_Recipient_Matches → CVH → BlueSky/BlackBook + Mautic/CDXP sync → Juicebox/CDXP reporting.**

---

## Identity Join (CVH)

**CVH is the current platform-wide identity join.** The person-level cross-system match is performed by `sp_insert_CRM_DMS_Recipient_Matches` (duplicated in both the CRM and DMS modules), linking `DMS_Dim_Customers` ↔ CRM leads (`Prestaging_CRM_1`) ↔ `Email_Recipients` via two deterministic rules — (1) email match (`DMS_Fact/Dim_EmailAddresses` + `Email_Recipients`) and (2) lastname+address match (`DMS_Fact_Names` + `DMS_Fact/Dim_Addresses`, Alteryx-geocoded) — scoped to `Analytics_Clients` with `IsDMS=1` and `IsCRM=1`. Its output, `CRM_DMS_Recipient_Matches`, is the bridge that `sp_insert_staging_CVH` uses to merge 5+ years of DMS sales/service/appointment history with CRM leads into the denormalized `CVH` / `CVH_List` (PK `ClientID + EDW_DMS_Customer_ID`).

**What the CDP replaces:** the hand-rolled deterministic two-rule merge and the CVH/CVH_List snapshot. The CDP's native identity resolution (email/phone/name/address/VIN ownership across CRM, DMS, Email) supersedes `CRM_DMS_Recipient_Matches` and the CVH merge. Because all downstream consumers — BlueSky (`Analytics_BlueSky_*`), BlackBook (`Vehicle_Valuation`), Mautic Contact Sync, and Juicebox — read CVH/CVH_List and CRM_DMS_Recipient_Matches as canonical identity, the CDP's resolved-profile output must be a drop-in replacement for those reads.

---

## CDP Ingestion Guidance

**Ingest (raw source-of-record):**
- CRM provider feeds: `source_CRM_DS/EL/VS/RR/RR2/RR3/ME/MO/MT/DC/DP_{Leads,Sales,Service}` (the 21+ consolidated by `sp_insert_prestaging_CRM_1`).
- DMS transaction feeds: `source_DMS_Appointment/Sales/Service` + CDK API (`cdkapi-customers/sales/service/models/appointments`) + Tekion.
- Email legacy platforms: `[3BHS001].ClientDB.dbo.*` (Recipients, Clients, EmailDelivery*, EmailOpens/Clicks/Unsubscribes/SpamComplaints, ClientLinks, LEADS), `[3BHS001].Lift.dbo.Lift_*`, `[3BHS001].Auth.dbo.*`, `[3BHS001].BirdBath.dbo.*`.
- Inventory: `[3BHSSQL01].Inventory.dbo.{Vehicle,Media,Make,Model,Trim,BodyStyle}`.
- Reference: `Analytics_Clients` (IsDMS/IsCRM/IsInternal), `lookup_MakeModelBodyStyle`, `OEM_Fact_Schedules`/`OEM_Dim_*`.

**Avoid (derived/merge/reporting/sync-state — CDP recreates or supersedes):**
- Identity merge: `CVH`, `CVH_List`, `CRM_DMS_Recipient_Matches`.
- Enrichment/analytics: `Analytics_BlueSky_*`, `Analytics_MatchBacks_60`, `Vehicle_Valuation`/`_History`.
- Reporting: all `JuiceReporting_*` (SSIS) and `marketing.juicereporting_*` / `mv_contact_stats` / `mv_campaign_type_v0` / `tbl_attribution` / `JuiceReporting_CDXP_*`.
- Sync state: `Mautic_Contact_Mapping`, `Mautic_Company_Mapping`, `Mautic_Owner_Mapping`, `marketing.contact/message/campaign/event/client`.

**Nuance:** prefer raw `ClientDB.Recipients` over the standardized `Email_Recipients` / `prestaging_Email_Recipients_1` (avoid baking in legacy DQ transforms); prefer raw `source_DMS_Service` over `fact_declined_service` / `staging_DMS_Declined_Service_Flattened`.

---

## Data Sources NOT in the ETL submodule

These arrive via other channels (not SSIS/CDXP stored procedures) and matter for CDP ingestion design:

| Source | Current path | CDP channel |
|---|---|---|
| MailGun events | Webhook → PostgreSQL | Webhook API (already structured) |
| Twilio SMS | Direct API | Webhook API |
| ADF/XML leads (TrueCar, Cars.com, …) | Email → parser → DB | Webhook / Bulk Upload |
| Meta/Facebook lead forms | Manual or API | Webhook API |
| Google GA4 | SSIS Email module (`sp_insert_GA`) | CDP event stream (Phase 2) |
| HomeNet API | Unknown pull cadence | Batch Pull (Airflow) |
| BlackBook API | valuation round-trip (see BlackBook module) | Batch Pull (Airflow) |
| Authenticom | FTP/SFTP → SSIS DMS module | Batch Pull (Airflow) |

---

## References

- `etl/` submodule — `3birdsmarketing/Database-Processes` (read-only; access via the `github-das` deploy key). Stored procedures + module READMEs are the authoritative source.
- Per-module source: `etl/SSIS/<module>/`, `etl/PostgreSQL (Analytics Mautic)/<module>/`, `etl/Mautic/<module>/`, `etl/Juicebox Reporting/`, `etl/BlackBook/`.
- `etl_stored_procedures.xlsx` / `etl_stored_procedures_v2.xlsx` (repo root) — spreadsheet exports of the ETL stored-procedure set, staged at the root so they publish to the portal (`_site`). They back this inventory's procedure listing. **Provenance: needs-confirmation** — assumed to be exports of the `etl/` `Database-Processes` stored procedures (v2 being the later/corrected pass); confirm the exact origin and which is canonical before relying on either over the `.sql` in the submodule.
- `memory/decisions.md` — CDP ingestion-target decision (raw tables, not CVH/DWRPT).
- `analysis/artifacts/ssis-job-catalog-v2/` — SSIS job health dashboard (operational view).
- Discovery method + contribution practice: [`discovery-guide.md`](discovery-guide.md). Tracking: ConflictHQ/das-tech issue #3.

