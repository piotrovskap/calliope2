# ER Diagram — RedDawn

**Database:** `RedDawn`
**Server:** `20.51.108.231`
**Date:** 2026-06-11

---

## Diagram

![ER Diagram RedDawn](RedDawn_ER.png)

---

## Purpose & Architecture

RedDawn is the **web crawler and content operations platform**. It has three primary functions:

1. **Dealer website crawling** — Automated spiders (Scrapy-based) crawl automotive dealer websites on configurable schedules, extract vehicle listings, and store them in `Crawler_Results`. The job management layer (`Crawler_Jobs`, `Crawler_Templates`) defines how and when each site is crawled.

2. **Image download pipeline** — Once listings are crawled, vehicle images are downloaded and tracked through a multi-stage queue (`ListingImageDownload` → `ListingImageDownload_Queue` → `ListingImageDownload_Queue_History`). This history table is the largest in the database at 147M rows / 16.8 GB.

3. **SmartVDP / SmartPLD** — A vehicle detail page overlay and click-tracking system. Dealer accounts have listings synced to `SmartVDPListings`, and user engagement (clicks, SRP views) is captured in `SmartVDPClicks` (23.3M rows / 8.3 GB).

Additional systems: Facebook Ads campaign data import, TikTok feed generation, Dynamic Display ad tags, VDP dashboard metrics, and support ticket tracking.

The overall data flow is:

```
Crawler_Templates (spider config)
    → Crawler_Jobs (per-domain schedule)
        → Crawler_ImportLog (each crawl run)
            → Crawler_Results (raw vehicle data — 52.5 GB)
            → Crawler_Stats / Cleanup_Log / Error_Logs (monitoring)

Megatron listings
    → SmartVDPListings / SmartPLDListings (synced inventory)
        → SmartVDPClicks (click events — 8.3 GB)

ListingImageDownload (queued downloads)
    → ListingImageDownload_Queue_History (audit — 16.8 GB, largest table)
```

---

## Legend

| Color / Style | Meaning |
|---|---|
| Solid blue line | Relationship within the same group |
| Teal bold line | Cross-group relationship |
| Dashed purple line | View → table |
| Orange line | Image/file pipeline flows |
| Red dashed line | Error and cleanup flows |
| Yellow `PK` label | Primary key |
| Green `FK` label | Foreign key (inferred from naming conventions) |

> **Note:** No explicit `FOREIGN KEY` constraints exist in the schema. All relationships are inferred from shared column names.

---

## Entity Groups

### Crawler Job Management (6 tables)

| Table | Rows | Description |
|---|---|---|
| `Crawler_Templates` | 269 | Spider script templates — each maps a keyword/type to a Scrapy template file and version |
| `Crawler_Templates_Logs` | 5,120 | Audit log of template changes with who made them |
| `Crawler_Jobs` | 5,242 | Per-domain crawler configuration: schedule (cron), subnet, CPU/memory allocation, proxy type, priority, crawl status |
| `Crawler_Jobs_Group` | 1,410 | Groups of domains launched together in a batch |
| `Crawler_Stores` | 5,370 | Domain-to-keyword/crawler-type mapping used for store-level categorization |
| `Crawler_Proxy_Types` | 8 | Available proxy provider types with name and value |

---

### Crawler Execution (6 tables)

| Table | Rows | Size | Description |
|---|---|---|---|
| `Crawler_ImportLog` | 22,000 | 41 MB | One row per crawl run: file path, timestamps for crawl start/import/SP completion, ARN (AWS task ARN for ECS crawlers) |
| `Crawler_Results` | 1.35 M | **52.5 GB** | Raw vehicle listing data extracted from dealer sites — full vehicle attributes, images, descriptions |
| `Crawler_Unique_AdNum` | 41.7 M | 2.8 GB | Deduplicated listing fingerprints (domain + VIN + stock number) for change detection |
| `Crawler_Stats` | 3.3 M | 274 MB | Per-import stat key-value pairs (field fill rates, record counts, parse metrics) |
| `Crawler_Totals` | 259 K | 18 MB | Daily roll-up of crawl totals per domain/type for trend tracking |
| `Crawler_Revisions` | 28.7 K | 685 MB | Full diff history of crawler template and job configuration changes |

---

### Crawler Monitoring & Errors (8 tables)

| Table | Rows | Size | Description |
|---|---|---|---|
| `Crawler_Logs` | 2.3 M | 188 MB | General event log per domain (info, warning, error events with message text) |
| `Crawler_Error_Logs` | 126 K | 35 MB | SQL-level error log for stored procedure failures during crawl imports |
| `Crawler_MetaData` | 2.85 M | 219 MB | Key-value metadata per domain (e.g., detected site platform, encoding, notes) |
| `Crawler_Classification` | 6,048 | 0.6 MB | Domain-to-classification mapping (automotive, jobs, real estate, etc.) |
| `Crawler_Cleanup_Log` | 5.6 M | 179 MB | Record of each crawl import that was cleaned up / purged after processing |
| `crawler_count_log` | 7.1 M | 661 MB | Per-import record count snapshots from multiple sources for reconciliation |
| `Crawler_Container_Issues` | 0 | — | ECS container health issues (currently empty) |
| `Crawler_Settings` | 2 | — | Global crawler system settings (key-value pairs) |

---

### Results Variants (2 tables, currently empty)

| Table | Description |
|---|---|
| `Crawler_Results_MissingPercent` | Holds crawled results where a high percentage of fields are missing — for quality review |
| `Crawler_Results_RealEstate` | Same structure as `Crawler_Results` but for real estate listing extraction (not yet active) |

---

### Image Download Pipeline (6 tables)

| Table | Rows | Size | Description |
|---|---|---|---|
| `ImageDownloadStatus` | 5 | — | Status code definitions for the image download state machine (Queued, Downloading, Done, Failed, etc.) |
| `ListingImageDownload` | 2.7 M | 799 MB | Master image download registry — one row per image URL per listing with current status, file size, and fail count |
| `ListingImageDownload_Queue` | 700 | 1.3 MB | Active download queue (items currently being processed) |
| `ListingImageDownload_Queue_History` | **147 M** | **16.8 GB** | **Largest table.** Complete history of every image download attempt with results and timestamps |
| `MonthlyPriceImageProcessing` | 175 K | 80 MB | Tracks monthly payment price image generation status per listing (for ad creatives) |
| `MonthlyPriceImageProcessingLogs` | 29 | — | Log of which accounts had monthly price images updated |
| `LongImageURLs` | 298 | — | Domains with image URLs that exceed standard length limits (flagged for special handling) |

---

### Video (2 tables)

| Table | Rows | Description |
|---|---|---|
| `ListingVideoDownload` | 3 | Source video download registry — tracks download attempts, source URL, and AWS SQS message IDs |
| `ListingVideoOutput` | 0 | Transcoded video outputs per source (multiple resolutions/formats per input) |

---

### SmartVDP — Vehicle Detail Page (8 tables)

| Table | Rows | Size | Description |
|---|---|---|---|
| `SmartVDPAccounts` | 789 | 0.4 MB | Dealer accounts enrolled in SmartVDP with address, coordinates, URL, and UTM config |
| `SmartVDPListings` | 117,795 | 189 MB | Active vehicle inventory synced from Megatron for SmartVDP display |
| `SmartPLDListings` | 268 | 0.6 MB | SmartPLD (Property Listing Display) variant — smaller curated set |
| `SmartVDPClicks` | 23.3 M | **8.3 GB** | All SmartVDP user engagement events — clicks, SRP views, VDP loads with bot filtering, session ID, IP, and referrer |
| `SmartVDPBotAgents` | 23 | — | Known bot user agent strings for filtering clicks |
| `SmartVDPOptions` | 224 | — | Per-account SmartVDP configuration: template, algo type, dealer logo, bypass flags |
| `SubscriptionMetaData` | 10,369 | 0.5 MB | Analytics ID and video feed flag per subscription ID |
| `srp_daily_processing` | 5,944 | 0.5 MB | Temporary/staging table for daily SRP action aggregation before writing to Prime |

---

### VDP Dashboard (5 tables + 2 temp tables)

| Table | Rows | Description |
|---|---|---|
| `VDPDashCostByCampaigns` | 146 | Aggregated cost, impressions, clicks, VDP views, and cost-per-VDP per campaign |
| `VDPDashDailyStats` | 900 | Pivoted 31-column daily stats by campaign (one column per calendar day) |
| `VDPDashMonthlyTotals` | 0 | Monthly roll-up totals (not yet populated) |
| `VDPDashPacingCampaign` | 146 | Campaign flight pacing: expected vs. current VDP views with delta |
| `VDPDailyTotals` | 0 | Placeholder daily totals (not yet populated) |
| `VDPListings_Temp` | 0 | Staging table for VDP listing data during dashboard refresh |
| `VDPAccount_Temp` | 271 | Staging table for account data during dashboard refresh |

---

### Facebook Ads (4 tables)

| Table | Rows | Size | Description |
|---|---|---|---|
| `FBImport` | 10,455 | 0.8 MB | Import job registry — each run has a start/finish timestamp and status |
| `FBCampaignData` | 32,602 | 9 MB | Facebook Ads campaign/ad-set/ad snapshot: status, issues, learning phase |
| `FBCampaignDatav2` | 9.3 M | **3.3 GB** | Extended version with ad-set/ad names; much larger scale, indicates active v2 import |
| `FacebookPageMapping` | 13 | 0.2 MB | Maps Facebook page IDs to campaign names and internal account IDs |

---

### TikTok (1 table)

| Table | Rows | Size | Description |
|---|---|---|---|
| `TikTokFeedListings` | 12,595 | 25 MB | Full vehicle listing export formatted for TikTok catalog feed — includes dealer info, vehicle attributes, pricing, and custom labels |

---

### Integration & Misc (9 tables)

| Table | Rows | Description |
|---|---|---|
| `crosslinked` | 507 | Advertiser-to-listing cross-reference with VDP URLs |
| `InventoryTotals` | 7,056 | Per-account feed inventory counts by type with last upload timestamps |
| `GraftChevyListings` | 399 | Specific Chevy dealer listing data pulled from a GraftChevy integration |
| `GraftChevyVDP` | 1,718 | VDP URL mapping for GraftChevy domains |
| `FoxFactoryAgedRAM` | 79 | Fox Factory RAM truck aged unit list with VIN, region, and VDP URL |
| `Tickets` | 340 | Support/ops tickets per domain with type, assignee, and resolution flag |
| `VehicleFilterLocation` | 4 | Maps filter keywords to location names for specific domain crawl filtering |
| `domains_with_dupes` | 228 | Domains identified as having duplicate listings |
| `NoPriceOnSite` | 83 | Domains where no price is displayed on the dealer website |

---

### Backup (4 tables)

| Table | Description |
|---|---|
| `BKUPSettings` | Per-database backup config (path, FTP server, credentials, retention) |
| `BKUPSteps` | Ordered step definitions for the backup pipeline |
| `BKUPHistory` | Execution history per step per database with BAK and ZIP file sizes |
| `BKUPLog` | Per-step execution start timestamps |

---

### System & Utilities (3 tables)

| Table | Description |
|---|---|
| `DBINFO` | Database physical file metadata |
| `CoreLog` | Core command execution audit log |
| `IntMaxes` | Current max int values per table/column (overflow monitoring) |

---

## Key Relationships

```
Crawler_Templates    ──► Crawler_Jobs              (template)
Crawler_Jobs         ──► Crawler_Jobs_Group        (domain)
Crawler_Jobs         ──► Crawler_ImportLog         (domain)   ← central execution hub

Crawler_ImportLog    ──► Crawler_Results           (cil_id)   ← raw crawled data
Crawler_ImportLog    ──► Crawler_Stats             (cil_id)
Crawler_ImportLog    ──► Crawler_Unique_AdNum      (domain)
Crawler_ImportLog    ──► Crawler_Cleanup_Log       (cil_id)   ← red dashed
Crawler_ImportLog    ──► crawler_count_log         (cil_id)   ← red dashed
Crawler_ImportLog    ──► Crawler_Error_Logs        (cil_id)   ← red dashed

ImageDownloadStatus  ──► ListingImageDownload      (ids_ID)
ListingImageDownload ──► ListingImageDownload_Queue (llim_ID)
ListingImageDownload ──► ListingImageDownload_Queue_History (llim_ID)

SmartVDPOptions      ──► SmartVDPAccounts          (AccountId)
SmartVDPAccounts     ──► SmartVDPListings          (acc_id)
SmartVDPAccounts     ──► SmartVDPClicks            (acc_id)
SubscriptionMetaData ──► SmartVDPClicks            (subscription_id)

FBImport             ──► FBCampaignData            (fb_import_id)
FBImport             ──► FBCampaignDatav2          (fb_import_id)

BKUPSettings         ──► BKUPHistory               (dbID)
BKUPSteps            ──► BKUPHistory / BKUPLog     (stpID)
```

---

## Scale Notes

| Table | Rows | Size | Notes |
|---|---|---|---|
| `ListingImageDownload_Queue_History` | 147 M | 16.8 GB | Largest table — full image download audit history |
| `Crawler_Results` | 1.35 M | **52.5 GB** | Largest by size — raw crawled vehicle data (text-heavy) |
| `SmartVDPClicks` | 23.3 M | 8.3 GB | All click/view events on SmartVDP |
| `Crawler_Unique_AdNum` | 41.7 M | 2.8 GB | Deduplication fingerprint table |
| `FBCampaignDatav2` | 9.3 M | 3.3 GB | Facebook Ads v2 data |
| `crawler_count_log` | 7.1 M | 661 MB | Record count reconciliation log |

---

## Views (30 views — grouped by function)

### Views — Crawler (6 views)

| View | Base Table(s) | Description |
|---|---|---|
| `Crawler_MaxMetaData` | `Crawler_MetaData` | Latest metadata entry per domain/keyword |
| `Crawler_Total_Pivot` | `Crawler_Totals` | Last 8 days of crawl counts pivoted by domain and crawler type |
| `Crawler_Total_Single` | `Crawler_Totals` | Unpivoted daily totals per domain/type |
| `vw_Crawler_Results_ByTemplateDomain` | `Crawler_Results`, `Crawler_Jobs` | Results joined to their job template and domain |
| `Scrapy_Crawl_Check` | `Crawler_ImportLog`, `Crawler_Jobs` | Live crawl health check — timing metrics for crawl, SP, and live feed stages |
| `Scrapy_LiveFeedCounts` | *(system join)* | Active feed counts per fduid/fdid with aggregator and last known ad count |

---

### Views — Image & Display (8 views)

| View | Base Table(s) | Description |
|---|---|---|
| `ImageDownload_ToDownload` | `ListingImageDownload` | Images currently queued for download (not yet downloaded) |
| `ImageDownload_SideBySide` | `ListingImageDownload` | Side-by-side comparison of original vs. downloaded URL |
| `ImageDownload_ToRemove` | `ListingImageDownload` | Images that should be removed (failed or superseded) |
| `vw_DomainFailCount` | `ListingImageDownload` | Download failure counts by domain |
| `vw_DomainToDownloadCount` | `ListingImageDownload` | Pending download counts by domain |
| `DynamicDisplay_List` | *(Megatron join)* | Active Dynamic Display ad campaigns with template and master ID |
| `DynamicDisplay_List_Tags` | *(Megatron join)* | HTML ad tags for Dynamic Display campaigns |
| `vw_DynamicDisplay_HTML` | *(Megatron join)* | Full HTML creative per account/aggregator |

---

### Views — DBA / System (8+ views)

| View | Description |
|---|---|
| `BKUPLog_Joined` | Full backup step log with start/end times and file sizes |
| `vw_BkUp_LastStep` | Latest completed step per backup history record |
| `vw_LastJDBBU` | Most recent backup per database from the custom backup system |
| `JobHistory` | SQL Agent job execution history with run status and duration |
| `__IndexSizes` | Index size and fragmentation for all tables |
| `__IndexesNotUsed` | Indexes with zero usage (candidates for removal) |
| `__CurrentPermissions` | Current database user/role permissions |
| `_IDX_Primary_Fix` | Tables with missing or misnamed primary key indexes |

---

### Views — Metadata (7 views)

| View | Description |
|---|---|
| `vw_TInfo` | Table column metadata with SELECT/INSERT/UPDATE templates |
| `vw_TRInfo` | Table row info with replication flags |
| `vw_VInfo` | View column metadata |
| `vw_FInfo` | Function definitions |
| `vw_SInfo` | Stored procedure definitions |
| `vw_IDXInfo` / `vw_IDXInfo_v2` | Index definitions with fill factor and size metrics |

---

> **Architecture note:** RedDawn's most operationally critical path is the crawler pipeline — `Crawler_Jobs` drives `Crawler_ImportLog`, which drives `Crawler_Results` (the 52.5 GB warehouse of raw scraped data). The image download history (`ListingImageDownload_Queue_History`, 16.8 GB) makes this the most disk-heavy database in the system despite having relatively few large tables. The SmartVDP click stream (`SmartVDPClicks`) feeds into `srp_daily_processing`, which is then aggregated into Prime's `grail_srpactions_daily`.
