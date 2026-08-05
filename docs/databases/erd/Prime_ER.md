# ER Diagram — Prime

**Database:** `Prime`
**Server:** `20.51.108.231`
**Date:** 2026-06-11

---

## Diagram

![ER Diagram Prime](Prime_ER.png)

---

## Purpose & Architecture

Prime is the **advertising performance analytics hub**. It ingests campaign data from multiple ad platforms — Google Ads, Display networks, Meta, TikTok, Amazon OTT, PlatformAuto, GVA (Google Vehicle Ads), and Yext — normalizes it against a central `DataSource` registry, and stores it for cross-channel reporting and fulfillment.

The core flow is:

```
DataSource (registry)
    → ImportLog (each data pull)
        → Display / DisplayGEO (display advertising)
        → VDPPerformance / VDPSERPPerformance (vehicle detail page)
        → PlatformAuto_Campaigns / PlatformAuto_Stats (automotive marketplace)
        → GVACampaignDataset / GVAVDPData / GVAVDPDatav2 (Google Vehicle Ads)

Platforms (video/segmented channels)
    → VideoAdCampaignReportData / GeoData / InventoryData / TechnologyData
    → SegmentedCampaignPerformance (age + gender breakdowns)

Yext (local listings)
    → YextCustomer → YextLocation → YextSubscription

grail_srpactions_daily (SRP engagement — largest table)
```

---

## Legend

| Color / Style | Meaning |
|---|---|
| Solid blue line | Relationship within the same group |
| Teal line | Cross-group relationship (ImportLog → performance tables) |
| Dashed purple line | View → table |
| Yellow `PK` label | Primary key |
| Green `FK` label | Foreign key (inferred from naming conventions) |

> **Note:** No explicit `FOREIGN KEY` constraints exist in the schema. All relationships are inferred from shared column names.

---

## Entity Groups

### Import & Data Sources (7 tables)

| Table | Rows | Description |
|---|---|---|
| `DataSource` | ~100s | Registry of all ad platform data sources with API credentials, type, partner, and lag config |
| `DataSourceType` | small | Classification of data source types (Display, VDP, Local Search, etc.) |
| `DataSourceAuthenticationType` | small | Authentication method catalog (OAuth, API key, etc.) |
| `Partner` | small | Partner/agency records linked to data sources |
| `ImportLog` | millions | One row per data pull — links a DataSource to a date range, status, account, and file |
| `ImportStatus` | small | Status codes for import jobs (Pending, Running, Complete, Failed, etc.) |
| `PerformanceReportingMaximumDate` | ~100s | Tracks the latest reporting date per data source for lag-aware reporting |

---

### Display Advertising (5 tables)

| Table | Rows | Size | Description |
|---|---|---|---|
| `Display` | large | — | Core display campaign performance: clicks, impressions, CTR, cost per ImportLog/date/campaign |
| `DisplayGEO` | 32 M | 7.7 GB | Geographic breakdown of display performance by city, metro, region, and zip |
| `DisplayMasterOverwrite` | small | — | Overrides canonical campaign group/name for specific data source + external ID combinations |
| `DisplayAdWordsOverwrite` | small | — | AdWords-specific campaign group overrides per data source + master record |
| `CampaignMetadata` | — | — | Stores extended campaign metadata blobs keyed by platform + campaign ID |

---

### VDP Performance (4 tables)

| Table | Rows | Size | Description |
|---|---|---|---|
| `VDPPerformance` | large | — | Vehicle Detail Page performance per account/data source/date: impressions, clicks, VDP views, cost |
| `VDPSERPPerformance` | large | — | SERP + VDP view counts per individual listing (lst_id / VIN level) |
| `VehicleSnapshot` | — | — | Point-in-time vehicle attributes (year/make/model/VIN/URL) captured at import time |
| `VINtoURLMapping` | — | — | Maps VINs to VDP URLs with creation timestamps for link resolution |

---

### PlatformAuto (6 tables)

| Table | Rows | Size | Description |
|---|---|---|---|
| `PlatformAuto_Dealers` | — | — | Dealer profiles for PlatformAuto (linked by acc_id + iml_id) |
| `PlatformAuto_Dealers_ExtraInfo` | — | — | Extended dealer config: Facebook page, monthly budget, promotion type |
| `PlatformAuto_Campaigns` | large | — | Campaign-level VDP views and cost per dealer/date with flight and remarketing flags |
| `PlatformAuto_Stats` | 31.8 M | 3.5 GB | VIN/listing-level impressions (SRP + VDP) per dealer and campaign |
| `PlatformAuto_Campaign_Flights` | — | — | Flight-level rollup of campaign spend, VDP views, and impressions |
| `Flight_AltId_Mapping` | — | — | Maps subscription IDs and flight IDs to alternate external IDs |

---

### GVA — Google Vehicle Ads (5 tables)

| Table | Rows | Size | Description |
|---|---|---|---|
| `GVASetup` | small | — | GVA account setup: merchant ID, Ads account ID, campaign name, domain verification |
| `GVACampaignMapping` | — | — | Maps GVA campaign IDs to campaign names and internal acc_id |
| `GVACampaignDataset` | — | — | Date-level campaign metrics (clicks, impressions, cost, conversions) |
| `GVAVDPData` | large | — | VIN-level GVA performance (impressions, clicks per landing page) |
| `GVAVDPDatav2` | 15.8 M | 2.8 GB | Extended VIN-level GVA performance with conversion tracking |

---

### Google Ads & Analytics (5 tables)

| Table | Rows | Size | Description |
|---|---|---|---|
| `GAProperties` | small | — | Google Analytics property registry with property ID, account, URL, and active flag |
| `GAAnalyticsData` | — | — | GA4 session/user/key event metrics per property, date, and campaign |
| `GclIdTracking` | 7.1 M | 7.6 GB | Click-level Google Click ID tracking with keyword, device, and campaign attribution |
| `GoogleAdsMapping` | — | — | Geographic targeting criteria IDs with name, country, and type |
| `CampaignGAPropertyMapping` | — | — | Links accounts to GA properties for cross-system correlation |

---

### Mapping & Fulfillment (7 tables)

| Table | Rows | Description |
|---|---|---|
| `FulfillmentState` | small | State machine definitions for client/location fulfillment workflows |
| `MappingClient` | — | Maps internal client master IDs to external platform client IDs per data source |
| `MappingLocation` | — | Maps internal location master IDs to external platform location IDs per data source |
| `MappingInventoryList` | — | Maps client+location pairs to external inventory list IDs per data source |
| `PendingFulfillments` | — | Queue of clients/locations awaiting fulfillment state transitions |
| `ClientFulfillmentEventLog` | — | Audit log of client fulfillment state transitions with timestamps |
| `LocationFulfillmentEventLog` | — | Audit log of location fulfillment state transitions |

---

### Local Search (4 tables)

| Table | Rows | Description |
|---|---|---|
| `PerformanceGroups` | small | Action category groups (Calls, Directions, Website Clicks, etc.) |
| `PerformanceActions` | small | Individual action types within groups with flags for display/local/RAN channels |
| `LocalSearchActionTotal` | — | Raw action counts per location per date per action type (original source label) |
| `LocalSearchActionNormalize` | — | Mapping from raw source action labels to normalized `PerformanceActions` entries |

---

### Video Ads (5 tables)

| Table | Rows | Description |
|---|---|---|
| `Platforms` | small | Platform registry (YouTube, OTT, etc.) linked to data sources |
| `VideoAdPlatformTokens` | small | OAuth/access tokens per platform with expiry |
| `VideoAdCampaignReportData` | — | Date-level video metrics: impressions, clicks, 100% video completions |
| `VideoAdCampaignGeoData` | — | City/state breakdown of video impressions per campaign/date |
| `VideoAdCampaignInventoryData` | — | Publisher site breakdown of impressions per campaign/date |
| `VideoAdCampaignTechnologyData` | — | Device type breakdown of impressions per campaign/date |

---

### Segmented Performance (5 tables)

| Table | Rows | Description |
|---|---|---|
| `AgeGroups` | small | Standard age bracket definitions (18-24, 25-34, etc.) |
| `GenderGroups` | small | Gender segment definitions |
| `PlatformAgeMapping` | — | Maps each platform's native age value strings to canonical AgeGroups |
| `PlatformGenderMapping` | — | Maps each platform's native gender value strings to canonical GenderGroups |
| `SegmentedCampaignPerformance` | — | Campaign performance broken down by age + gender segment per platform/date |

---

### Yext — Local Listings (4 tables)

| Table | Rows | Description |
|---|---|---|
| `YextCustomer` | — | Yext customer accounts with business name, email, and internal ratchet ID |
| `YextLocation` | — | Physical locations under each Yext customer with address, city, state, zip, website |
| `YextSubscription` | — | Active Yext subscriptions per customer with offer ID, status, and paid-through date |
| `YextBusinessCategories` | — | Hierarchical Yext business category tree with parent-child links |
| `YextTmpiCategoryMapping` | — | Cross-reference between internal TMPI category IDs and Yext category IDs |

---

### Social & Other Ad Platforms (5 tables)

| Table | Rows | Description |
|---|---|---|
| `MetaCampaignInfo` | — | Facebook/Instagram campaign registry with account, name, status, and daily budget |
| `FacebookAdAccounts` | — | Ad account records linked to Meta campaigns |
| `TikTokCampaignDataset` | — | TikTok campaign-level conversion and results data by date |
| `TikTokWebsiteMetrics` | — | TikTok website traffic metrics (pageviews) per campaign/date |
| `AmazonOTTData` | — | Amazon OTT impressions and video completions by advertiser/date |

---

### Grail SRP Actions (3 tables)

| Table | Rows | Size | Description |
|---|---|---|---|
| `grail_srpactions_daily` | 98.8 M | 4.8 GB | **Largest table.** Daily SRP engagement events per listing/account/subscription with bot filtering |
| `ImageProxy_By_Date_Account` | — | — | Image proxy request counts (SERP + VDP) aggregated by account/date |
| `ImageProxy_By_Date_Listing` | — | — | Image proxy request counts at listing level by account/date |

---

### Call Tracking (referenced via `Platforms` + `DataSource`)

Call tracking data flows through the Platform and DataSource normalization layer rather than dedicated tables. Related configuration tables include `LocalSearchActionTotal` and the `PerformanceActions` / `LocalSearchActionNormalize` pair.

---

### Backup (4 tables)

| Table | Description |
|---|---|
| `BKUPSettings` | Per-database backup config (path, FTP server, retention days) |
| `BKUPSteps` | Ordered step definitions for the backup pipeline |
| `BKUPHistory` | Execution history per step per database with BAK and ZIP file sizes |
| `BKUPLog` | Per-step execution start timestamps |

---

## Key Relationships

```
DataSourceType        ──► DataSource             (dsr_TypeId)
Partner               ──► DataSource             (pnr_ID)
DataSource            ──► ImportLog              (dsr_ID)
ImportStatus          ──► ImportLog              (ims_ID)
DataSource            ──► PerformanceReportingMaximumDate (dsr_ID)

ImportLog             ──► Display                (iml_ID)   ← teal cross-group
ImportLog             ──► VDPPerformance         (iml_ID)   ← teal cross-group
ImportLog             ──► VDPSERPPerformance     (iml_ID)   ← teal cross-group
ImportLog             ──► PlatformAuto_Campaigns (iml_ID)   ← teal cross-group
ImportLog             ──► PlatformAuto_Stats     (iml_ID)   ← teal cross-group

CampaignMetadata      ──► Display               (CampaignId)
Platforms             ──► CampaignMetadata       (PlatformId)

PlatformAuto_Dealers  ──► PlatformAuto_Campaigns (pla_dlr_id)
PlatformAuto_Dealers  ──► PlatformAuto_Stats      (pla_dlr_id)
PlatformAuto_Dealers  ──► PlatformAuto_Campaign_Flights (pla_dlr_id)

GVACampaignMapping    ──► GVACampaignDataset     (campaign_id)
GVACampaignMapping    ──► GVAVDPData             (campaign_id)
GVACampaignMapping    ──► GVAVDPDatav2           (campaign_id)

GAProperties          ──► GAAnalyticsData        (PropertyId)
GAAnalyticsData       ──► GclIdTracking          (CampaignId)
GAProperties          ──► CampaignGAPropertyMapping (PropertyID)

Platforms             ──► VideoAdCampaignReportData / GeoData / InventoryData / TechnologyData
Platforms             ──► PlatformAgeMapping / PlatformGenderMapping
AgeGroups             ──► SegmentedCampaignPerformance
GenderGroups          ──► SegmentedCampaignPerformance

YextCustomer          ──► YextLocation           (customerId)
YextCustomer          ──► YextSubscription       (customerId)

PerformanceGroups     ──► PerformanceActions     (peg_ID)
PerformanceActions    ──► LocalSearchActionNormalize (pac_ID)

BKUPSettings          ──► BKUPHistory            (dbID)
BKUPSteps             ──► BKUPHistory / BKUPLog  (stpID)
```

---

## Scale Notes

| Table | Rows | Size | Notes |
|---|---|---|---|
| `grail_srpactions_daily` | 98.8 M | 4.8 GB | Largest table — daily SRP engagement events |
| `DisplayGEO` | 32 M | 7.7 GB | Largest by size — geographic display breakdown |
| `GclIdTracking` | 7.1 M | 7.6 GB | Click-level Google ID tracking |
| `GVAVDPDatav2` | 15.8 M | 2.8 GB | VIN-level GVA performance v2 |
| `PlatformAuto_Stats` | 31.8 M | 3.5 GB | VIN-level PlatformAuto impressions |

---

## Views (60+ views — grouped by function)

### Views — Operational (2 views shown in diagram)

| View | Base Table(s) | Description |
|---|---|---|
| `__AllVdpCampaigns` | `VDPPerformance`, `PlatformAuto_Campaigns` | Union of all VDP campaign records across performance sources |
| `Job_Completion_Check` | `ImportLog`, `DataSource` | Current import job completion status per data source with date ranges |
| `Latest_DataPulls` | `ImportLog`, `DataSource` | Most recent pull date and timestamp per data source |

---

### Views — Custom Export (note: not in main diagram)

These views generate formatted exports for specific media buying partners:

- **Audacy / ViaMedia**: Views prefixed `_Audacy_` and `_ViaMedia_` — formatted for linear TV and digital audio campaign reporting
- These are parameterized per-market views joining Display and GEO data to specific campaign groupings

---

### Views — Legacy (note: not in main diagram)

Views prefixed `zzz_` are deprecated predecessors of current operational views. Preserved for reference but not used in active reporting pipelines. Covers older Display, LocalSearch, and VDP report formats.

---

### Views — DBA / System

| View | Description |
|---|---|
| `BKUPLog_Joined` | Full backup step log with start/end times and file sizes |
| `vw_BkUp_LastStep` | Latest completed step per backup history record |
| `vw_LastDBBU` | Most recent backup per database (from msdb backupset) |
| `vw_LastJDBBU` | Most recent backup from the custom backup system |
| `JobHistory` | SQL Agent job execution history with run status and duration |
| `vw_AllScheduledJobsOnServer` | All scheduled SQL Agent jobs with schedule details |
| `__IndexSizes` | Index size and fragmentation for all tables |
| `__IndexesNotUsed` | Indexes with zero usage (candidates for removal) |
| `__CurrentPermissions` | Current database user/role permissions |
| `_IDX_Primary_Fix` | Tables with missing or misnamed primary key indexes |

---

### Views — Metadata

| View | Description |
|---|---|
| `vw_TInfo` | Table column metadata with SELECT/INSERT/UPDATE templates |
| `vw_TRInfo` | Table row info with replication flags |
| `vw_VInfo` | View column metadata |
| `vw_FInfo` | Function definitions |
| `vw_SInfo` | Stored procedure definitions |
| `vw_IDXInfo` / `vw_IDXInfo_v2` | Index definitions with fill factor and size metrics |

---

> **Architecture note:** Prime is the most complex database in the system (~130+ tables, 60+ views) and serves as the single analytics warehouse for all paid advertising channels. The `ImportLog` table is the central hub — every performance record in every channel table traces back to an `iml_ID` import job, which in turn traces back to a `DataSource`. This design allows any performance query to be filtered by data source, date range, account, and import status in a uniform way across channels.
