# ER Diagram — web

**Database:** `web`
**Server:** `20.51.108.231`
**Date:** 2026-06-11

---

## Diagram

![ER Diagram web](web_ER.png)

---

## Purpose & Architecture

`web` is the **core classified ad marketplace platform**. It is the operational heart of the system — the database where vehicle listings are published, feed-based dealer ads are imported, banners are served, leads are generated and routed, and the entire subscription/sales pipeline (Ratchet CRM) is managed.

The central flow is:

```
PUBLICATIONS (35 publications)
    └── EDITIONS (852 editions: markets/zones within each publication)
            └── CLASS → SUBCLASS (category hierarchy)
            └── FeedManager (18K active feed accounts)
                    └── FEEDDEALERS (22K dealer feed records)
                            └── FEEDADS (8M vehicle ads / 47 GB — LARGEST TABLE)
                                    └── FEEDEXTRAS (12M extended attributes / 8.5 GB)
                            └── RatchetFeedTracker (85K CRM submissions)
                                    └── FEEDDESTINATION (68K destination routing records)
                            └── BUSSCHEDULE → BUSSTEPS → BUSSTOPS
                                    (automated import job scheduler)

Third-Party DMS/Aggregator Staging (~80 vendor tables)
    → FeedManager → FEEDDEALERS → FEEDADS  (import pipeline)

ADS (91K direct ads / 77 MB) — hand-submitted or web-generated listings
    └── ADDETAIL / ADIMAGES / SUBIMAGES

BANNERS (2K banners)
    └── BANNERLOG (178K impressions) + BANNERTOTAL (910K daily totals)

MEMBERS → x__DEALERLOGIN / TPDLINFO → dealer portal access
```

---

## Legend

| Color / Style | Meaning |
|---|---|
| Solid blue line | Relationship within the same cluster |
| Teal line | Cross-cluster relationship (major structural links) |
| Orange line | High-volume data flow (e.g., vendor staging → FeedManager) |
| Dashed purple line | View → source table |
| Red dashed line | Deactivation / error / audit flow |
| Yellow `PK` label | Primary key |
| Green `FK` label | Foreign key (inferred from naming conventions) |

> **Note:** No explicit `FOREIGN KEY` constraints exist in this schema. All relationships are inferred from shared column names and naming conventions.

---

## Entity Groups

### Publications & Editions (8 tables)

The root of the platform hierarchy. Every ad, feed, banner, and member belongs to a publication.

| Table | Rows | Size | Description |
|---|---|---|---|
| `PUBLICATIONS` | 35 | — | Master publication registry. Each publication has its own hostname, database connection, IP, and report source ID |
| `EDITIONS` | 852 | — | Editions (market zones) within each publication. Typed (web/print), with email contact |
| `PUBEDITIONS` | 851 | — | Many-to-many join between publications and editions |
| `PubStates` | 44 | — | Geographic state coverage per publication |
| `PUBEXPIRING` | 31 | — | Publications nearing end-of-life with linked status code |
| `New_PrintPublications` | 35 | — | Print-specific publication registry (mirrors PUBLICATIONS) |
| `New_PrintEditions` | 112 | — | Print edition definitions with Endeavor cross-reference |
| `StatPubs` | 36 | — | Simplified publication list for statistics/reporting systems |

---

### Categories & Classification (8 tables)

| Table | Rows | Size | Description |
|---|---|---|---|
| `CLASS` | 496 | — | Top-level category groups per publication (Automotive, Trucks, Boats, etc.) |
| `SUBCLASS` | 1,903 | — | Subcategories within each class. The `SCLID` is the primary classification key used throughout the feed pipeline |
| `SCLSORT` | 261 | — | Custom sort order for subcategories within editions |
| `MAKES` | 448 | — | Vehicle make reference table (canonical spellings + alternate forms) |
| `MODELS` | 2,699 | — | Vehicle model definitions keyed by make |
| `CARTYPES` | 7 | — | Vehicle type definitions (Car, Truck, SUV, etc.) linked to subcategory |
| `New_Class` | 11 | — | Simplified class lookup for newer UI components |
| `New_SubClass` | 169 | — | Simplified subcategory lookup cross-referenced to old `SCLID` |

---

### Core Ad Engine (9 tables)

Hand-submitted and web-generated listings. Separate from the feed pipeline.

| Table | Rows | Size | Description |
|---|---|---|---|
| `ADS` | 91,014 | 77 MB | Master ad table — one row per live or historical listing. Links to edition, subcategory, dealer, and member |
| `ADDETAIL` | 91,019 | 355 MB | Extended ad content: full text, headline, year/make/model/price, VIN, color, mileage, photo URL |
| `ADIMAGES` | 2,088,709 | 622 MB | Per-ad photo URLs with sort order. Multiple images per ad |
| `SUBIMAGES` | 334,168 | 32 MB | Images for submitted (draft) ads before they are published |
| `SUBMIT` | — | — | Ad submission staging: draft ads before publishing, linking member + publication + subcategory |
| `CART` | — | — | Shopping cart for ad purchases — links member, publication, and submission |
| `CARTIMAGES` | — | — | Cart images for unpublished ads |
| `AdRates` | 116 | — | Pricing tiers per edition with label and cost |
| `ExistingListings` | 2,576,096 | 32 MB | Active listing index — lightweight table used for fast existence checks |

---

### Feed Pipeline — Core (14 tables)

The primary data pathway for the platform. External DMS/aggregator feeds flow in through this pipeline, producing the largest tables in the system.

| Table | Rows | Size | Description |
|---|---|---|---|
| `FeedManager` | 18,343 | 3.6 MB | Registry of all active feed accounts (dealer + publication + edition combinations). Each row is one "feed slot." Controls active/inactive state and deactivation scheduling |
| `feedmanagerlog` | 78,538 | 10.8 MB | Change audit log for FeedManager — who changed what and when |
| `FEEDDEALERS` | 22,784 | 9.3 MB | Dealer-level feed records. One row per dealer per feed. Holds dealer contact info, publication/edition, and links to master DEALERS record. The `fdUID` is the central FK for the entire feed pipeline |
| `FEEDADS` | **8,017,614** | **47.3 GB** | **Largest table.** One row per vehicle ad per feed. Holds VIN, year/make/model, price, category, VDP URL, ad text, active flag, and timestamps. The central data store for all feed-imported vehicle listings |
| `FEEDEXTRAS` | 12,131,724 | 8.5 GB | Extended vehicle attributes keyed by `faUID` → FEEDADS: condition, body type, mileage, transmission, engine size, drive train, fuel type, certified status, exterior/interior color, options string |
| `FEEDTRANSLATE` | 9,152 | — | Maps vendor-specific category strings to internal `SCLID` subcategory IDs, per publication/edition |
| `FEEDUPDATE` | 8,106 | 2.8 MB | Pending feed update queue — dealer changes awaiting import |
| `FEEDLOGS` | 20,964 | 1.9 MB | Import run log — ad count, dealer count, image count per edition per run |
| `NormalizedFAVDP` | 417,936 | 49 MB | Normalized VDP URLs for FEEDADS records (secondary storage for large URL strings) |
| `FeedCategoryTranslations` | 5,179 | — | Feed-to-publication category mappings (alternate translation layer) |
| `FeedAdCount` | 283 | — | Ad count snapshot per dealer feed for display/reporting |
| `FEEDUPSELLS` | — | — | Premium placement flags per FEEDADS record (home page, preferred, enlarged) |
| `FeedMultipleVIN` | 16,169 | 1.5 MB | Tracks VINs that appear in multiple feed records — used to detect duplicate listings |

---

### Third-Party Inventory Feed Staging (~80 tables)

Each vendor/DMS platform has its own staging table(s). The import pattern is:
- `[Vendor]Data` or `[Vendor]Ads` — vehicle records imported from the vendor
- `[Vendor]Dealers` or `[Vendor]Customers` — dealer/account info from the vendor

All staging tables feed into the FeedManager → FEEDDEALERS → FEEDADS pipeline.

**Top vendors by data volume:**

| Vendor Table | Rows | Size | Notes |
|---|---|---|---|
| `VAutoDataTim` | 281,809 | 3.1 GB | vAuto DMS import (Tim variant) |
| `VAutoDatatemp` | 312,695 | 2.6 GB | vAuto DMS import (temp/staging) |
| `HomeNetData` | 99,840 | 1 GB | HomeNet DMS platform |
| `dsvehiclesnew` | 23,919 | 330 MB | AutoConX/DS format vehicles |
| `FirstLookData` | 23,141 | 327 MB | FirstLook DMS import |
| `LotVantage_Ads` | 30,173 | 80 MB | LotVantage platform |
| `DealersLink` | 8,107 | 98 MB | DealersLink platform |
| `ECarlistData` | 6,847 | 44 MB | eCarList DMS import |
| `CarGigiAds` | 3,980 | 36 MB | CarGigi platform |

**Other vendors included (many empty or very small):** AutoRevData, AutoRevCustomers, BestRideAds, BestRideDealers, HomeNetCustomers, dslotdatanew, VAutoData, VAutoDealers, DealerCenterAds, DealerCenterDealers, LotVantage_Dealers, CarGigiDealers, DCSData, DCSDealer, dealercom_ads, dealercom_customers, FusionZoneAds, AutoUplinkUSAData, CobaltData, SincroData, VinSolutionsData, DealerVaultData, AutoBaseDataNew, AutoSweetAds, AutaBuyAds, AutaBuyDealers, Auction123Ads, DealerSocket_Ads, InventoryCC_Ads, and others.

---

### Ratchet CRM (14 tables)

The sales and subscription management system. Every active feed in FeedManager has a corresponding Ratchet record tracking its sales, pricing, status, and destination routing.

| Table | Rows | Size | Description |
|---|---|---|---|
| `RatchetFeedTracker` | 85,300 | 50 MB | **Central CRM table.** One row per feed subscription. Tracks submitting rep (`acc_ID_Submitted`), assigned rep (`acc_ID_Rep`), form type, status, price, group, dealer group, submission/sale/go-live dates, and exclusion flags. Linked to `fduid` → FEEDDEALERS |
| `adez_feed` | 4 | — | Master CRM form template/skeleton (extremely few rows — this is a form definition table, not data storage) |
| `RatchetFormActive` | 10,926 | 1.4 MB | Tracks whether each RatchetFeedTracker record is currently active, with modification timestamps |
| `RatchetDestinations` | 12,853 | 0.4 MB | Maps each Ratchet submission to external ad destinations with per-destination pricing |
| `RatchetDealerGroups` | 101 | — | Dealer group definitions (multi-rooftop dealer groups) |
| `RatchetDeactivations` | 2,652 | — | Deactivation events per feed submission with reason code |
| `RatchetDeactivationReasons` | 9 | — | Reason code lookup for deactivations |
| `RatchetUpsells` | 4,486 | — | Upsell products applied to each submission with pricing |
| `Upsells` | 3 | — | Upsell product definitions (Home Page, Preferred, Enlarged) |
| `RatchetFormTypes` | 8 | — | Form type categories (Local, Display, RAN, etc.) |
| `RatchetFormStatus` | 8 | — | Status codes for feed submissions (Active, Pending, Cancelled, etc.) |
| `WebManagementTeam` | 20 | — | Internal team member list for assignment |
| `RatchetInventory` | 15 | — | Package/inventory definitions including PerformancePro flag |
| `RatchetFeedMigration` | 979 | — | Migration log mapping legacy `ffIDMaster` to new subscription IDs |

---

### Destinations & Leads (9 tables)

Controls where feed data is pushed (outbound routing) and handles lead collection.

| Table | Rows | Size | Description |
|---|---|---|---|
| `FEEDDESTINATION` | 67,933 | 11 MB | One row per dealer-per-destination assignment. Links a `fdUID` feed dealer to a destination with bid price and budget cap. The outbound routing table |
| `Destination` | 52 | — | Destination registry — named outbound feed targets (Cars.com, AutoTrader, Google, etc.) with cost-per-lead and source reference |
| `DestinationRules` | 204 | — | Business rules applied per destination (eligibility conditions) |
| `Rules` | 6 | — | Rule definitions referenced by DestinationRules |
| `LeadQueue` | 1,788 | — | Incoming lead queue — email leads submitted by site visitors, linked to `ADS.ADID` |
| `LeadQStatus` | 7 | — | Status codes for lead processing (New, Sent, Failed, etc.) |
| `FormPublications` | 7,522 | — | Maps CRM form submissions to publications and customer IDs |
| `FormDealerLocation` | 3,649 | — | Maps CRM form submissions to dealer location codes per publication |
| `FormFeedPhoneTracking` | 28 | — | Phone tracking campaign definitions for form-based leads |

---

### Members & Authentication (10 tables)

| Table | Rows | Size | Description |
|---|---|---|---|
| `MEMBERS` | 232 | — | Platform user accounts (dealers, staff) with login credentials, contact info, and publication affiliation |
| `MEMROLES` | 231 | — | Many-to-many mapping of members to roles |
| `ROLES` | 8 | — | Role definitions (Admin, Publisher, Dealer, etc.) |
| `MEMROLES_LOG` | 215 | — | Audit log of role assignment changes |
| `x__DEALERLOGIN` | 125 | — | Dealer portal login accounts with expiration and rep assignment |
| `TPDLINFO` | 144 | — | Third-party dealer login info linking MEMID to a customer ID, package, and DS video source |
| `DealerLoginExpiration` | 947 | — | Tracks expiration dates for dealer logins with mail-sent flag |
| `DealerLogin_MailLog` | 940 | — | Log of expiration notification emails sent to dealers |
| `New_ADAccounts` | 11,910 | 2.9 MB | Internal AD (Active Directory) account registry with last login |
| `AccountClassification` | 1,742 | — | Classifies accounts with labels, TFNs (Toll-Free Numbers), and overlay flags |

---

### Dealers & Web Listings (10 tables)

| Table | Rows | Size | Description |
|---|---|---|---|
| `DEALERS` | 473,558 | 50 MB | Master dealer registry. Largest dealer table — accumulates all dealers ever seen across all feeds. Holds name, address, phone, email, URL, customer ID, and publication |
| `WEBDEALERS` | 2,430 | — | Web-portal-registered dealers per publication |
| `WEBADS` | 7,662 | 4.8 MB | Ads submitted through the web portal (not via feed) |
| `InstaDealers` | 267 | — | "Insta" dealer accounts for rapid listing creation |
| `InstaAds` | 575 | — | Ads submitted through the Insta dealer system |
| `DEALERSUBMIT2` | 3,335 | 1.6 MB | Dealer-submitted ads with full category and pricing info |
| `DealerDirectory` | 1,370 | — | Curated dealer directory entries with region codes |
| `DealersByMake` | 18,774 | — | Per-dealer inventory counts broken down by vehicle make |
| `DlrIDRep` | 829 | — | Maps dealer IDs to sales rep account IDs |
| `DealerLocation` | 20 | — | Location zone definitions (e.g., North, South, East, West) per publication |

---

### Banner Ad System (10 tables)

| Table | Rows | Size | Description |
|---|---|---|---|
| `BANNERS` | 2,062 | — | Banner ad definitions — image URL, click URL, dimensions, type, publication, customer |
| `BANNERLOG` | 178,615 | 8.6 MB | Individual impression/click events per banner per day per hour |
| `BANNERTOTAL` | 910,426 | 31.7 MB | Pre-aggregated daily totals (hits + clicks) per banner per publication |
| `BannerCategory` | 29,207 | — | Per-banner targeting by CLASS and SUBCLASS — controls which categories a banner appears in |
| `BANNERTYPE` | 10 | — | Banner format type definitions with HTML format strings |
| `BANNERSIZES` | 10 | — | Supported banner size specifications per publication |
| `BANKEYWORD` | 3,444 | — | Keyword targeting rules per banner with hit counters |
| `BANLOCATION` | 7 | — | Page location slots (top, side, bottom, etc.) |
| `BANTYPELOC` | 22 | — | Maps banner types to page locations per publication |
| `BANINTERVAL` | 31 | — | Rotation interval definitions (hourly, daily, etc.) |

---

### Bus Scheduler — Import Automation (5 tables)

Manages automated import jobs that run the feed pipeline.

| Table | Rows | Size | Description |
|---|---|---|---|
| `BUSSCHEDULE` | 100 | — | Scheduled import job definitions — each row is one import job tied to a publication, with a stored procedure name and worker assignment |
| `BUSSTEPS` | 43 | — | Ordered steps within each scheduled job (e.g., download, parse, import, cleanup) |
| `BUSSTOPS` | 374 | 0.4 MB | Per-feed URL mappings for the import scheduler — original feed URL and target URL per job |
| `BUSSCHEDULEHISTORY` | 3,413 | — | Execution history per job — timestamp, completion flag, and error message |
| `BUSQUEUES` | 0 | — | Real-time job queue (currently empty — jobs process immediately) |

---

### Geo & Location (8 tables)

| Table | Rows | Size | Description |
|---|---|---|---|
| `STATES` | 64 | — | US states + territories with America flag |
| `New_ZipCode` | 43,198 | 3.8 MB | Authoritative ZIP code table with city, state, lat/long, radius, and DMA code |
| `New_DMA` | 220 | — | DMA (Designated Market Area) definitions |
| `zipcodes` | 42,974 | 2.5 MB | Legacy ZIP code table with city, state, lat/long |
| `DMAtoZIP` | 161 | — | Maps DMAs to center ZIP codes per state — used for market-area searches |
| `searchRadius` | 6 | — | Supported radius values (in miles) for proximity searches |
| `lookupCities` | 1,733 | — | City/state/zip lookup for search autocomplete |
| `AREACODE` | 204 | — | Phone area code to location mapping |

---

### URL, VDP & Tracking (8 tables)

| Table | Rows | Size | Description |
|---|---|---|---|
| `ShortURL` | 1,291,012 | 610 MB | URL shortener table — maps short codes to full destination URLs with group keys |
| `VDPtoVIN` | 4,794,462 | 1.4 GB | VIN-to-VDP URL mapping for external third-party sites — used to resolve dealer website URLs to VINs |
| `dx_HashLog` | 90,752 | 23 MB | Listing change detection — stores binary hashes of listing content; triggers updates when hashes change |
| `dx_ListingCount_Log` | 388,111 | 16 MB | Daily log of listing count changes (add/remove/modify actions) |
| `WCD_Web` | 1,833 | 0.7 MB | Web crawler job definitions — tracks domain, VIN, VDP URL, and last execution time per account |
| `DSVIDEO` | 630 | — | DS (DealerSocket) video thumbnail URLs with key references |
| `DSVKEYS` | 1 | — | Single-row key table for DS video API authentication |
| `NormalizedFAVDP` | 417,936 | 49 MB | Overflow table for large VDP URL strings from FEEDADS |

---

### Phone & Call Tracking (4 tables)

| Table | Rows | Size | Description |
|---|---|---|---|
| `WhosCalllingMasterCampaign` | 503 | 0.2 MB | Call tracking campaign definitions — maps service numbers (tracking phone numbers) to dealer redirect numbers via WhosCallin |
| `DTCL_Calls` | 59,782 | 11 MB | Raw call records from DTCL call tracking system — VIN, caller number, tracking number, duration |
| `Blacklisted` | 11,534 | 2.1 MB | Phone numbers blacklisted from contact per publication |
| `AlexsCallList` | 126 | — | Manual outbound call list with account and phone |

---

### Reporting & Analytics (7 tables)

| Table | Rows | Size | Description |
|---|---|---|---|
| `AlexFridayReport` | 579,129 | 73 MB | Weekly performance report by account — Display, Local, and RAN channel activity per sales rep |
| `new_EmailSources_Count_ByMonth` | 547,874 | 31 MB | Monthly email lead counts per account per email source |
| `SpectrumRollup` | 8,315 | 1.7 MB | Cross-channel rollup report: inventory units, email leads, call leads, display clicks, feed presence per dealer per date |
| `_MonthlyInternet` | — | — | Monthly internet ad counts per publication/edition (scheduled rollup) |
| `Inventory_counts` | 3,832 | — | Point-in-time inventory counts per product |
| `Inventory_Counts_crawler` | 80,898 | 4.7 MB | Crawler-based inventory count history per dealer domain |
| `Tables_Sizes` | 598 | — | Internal monitoring: table sizes, row counts, and truncation flags for all database tables |

---

### Backup & System (7 tables)

| Table | Rows | Description |
|---|---|---|
| `BKUPSettings` | 1 | Per-database backup configuration (path, FTP server, retention) |
| `BKUPSteps` | 13 | Ordered step definitions for the backup pipeline |
| `BKUPHistory` | 2,285 | Execution history per step per database with BAK and ZIP file sizes |
| `BKUPLog` | 10,318 | Per-step execution start timestamps |
| `AllScheduledJobsOnServer` | 878 | All SQL Agent jobs on the server with schedule details and step commands |
| `CoreLog` | — | Internal command audit log |
| `SQLInjectionCheck` | 18 | Tables flagged as infected during SQL injection scans |

---

## Key Relationships

```
PUBLICATIONS         ──► PUBEDITIONS              (PUBID)
EDITIONS             ──► PUBEDITIONS              (EDID)
PUBLICATIONS         ──► CLASS                    (PUBID)
CLASS                ──► SUBCLASS                 (CLSID)

PUBLICATIONS         ──► FeedManager              (PUBID)
EDITIONS             ──► FeedManager              (EDID)
FeedManager          ──► feedmanagerlog            (fmID)

PUBLICATIONS         ──► FEEDDEALERS              (fdPUBID)
EDITIONS             ──► FEEDDEALERS              (fdEDID)
DEALERS              ──► FEEDDEALERS              (dlrID)
FEEDDEALERS          ──► FEEDADS                  (fdUID)   ★ PRIMARY FLOW
FEEDADS              ──► FEEDEXTRAS               (faUID)   ★ VEHICLE ATTRIBUTES
FEEDADS              ──► NormalizedFAVDP           (faUID)
FEEDADS              ──► FEEDUPSELLS              (faUID)
SUBCLASS             ──► FEEDADS                  (faSCLID)
ADS                  ──► FEEDADS                  (adID)

VendorStagingTables  ──► FeedManager              (via import SP)

FEEDDEALERS          ──► RatchetFeedTracker        (fduid)   ★ CRM LINK
RatchetFeedTracker   ──► RatchetFormActive         (ffID)
RatchetFeedTracker   ──► RatchetDestinations       (ffID)
RatchetFeedTracker   ──► RatchetDeactivations      (ffid)
RatchetFeedTracker   ──► FormPublications          (ffID)

FEEDDEALERS          ──► FEEDDESTINATION           (FDUID)   ★ OUTBOUND ROUTING
FEEDDESTINATION      ──► Destination               (DESTID)

EDITIONS             ──► ADS                       (EDID)
SUBCLASS             ──► ADS                       (SCLID)
DEALERS              ──► ADS                       (DLRID)
MEMBERS              ──► ADS                       (MEMID)
ADS                  ──► ADDETAIL                  (ADID)
ADS                  ──► ADIMAGES                  (ADID)
ADS                  ──► LeadQueue                 (AdID)

PUBLICATIONS         ──► BANNERS                  (PUBID)
BANNERS              ──► BANNERLOG                 (BANID)
BANNERS              ──► BANNERTOTAL               (BANID)
BANNERS              ──► BannerCategory            (BANID)

PUBLICATIONS         ──► BUSSCHEDULE              (pubID)
BUSSCHEDULE          ──► BUSSTEPS / BUSSTOPS / BUSSCHEDULEHISTORY

PUBLICATIONS         ──► MEMBERS                  (PUBID)
MEMBERS              ──► MEMROLES                  (MEMID)
MEMBERS              ──► x__DEALERLOGIN            (MEMID)

BKUPSettings         ──► BKUPHistory               (dbID)
BKUPSteps            ──► BKUPHistory / BKUPLog      (stpID)
```

---

## Scale Notes

| Table | Rows | Size | Notes |
|---|---|---|---|
| `FEEDADS` | **8,017,614** | **47.3 GB** | Largest table — all vehicle ads across all feeds |
| `FEEDEXTRAS` | 12,131,724 | 8.5 GB | Extended vehicle attributes (more rows than FEEDADS due to history) |
| `VDPtoVIN` | 4,794,462 | 1.4 GB | VIN-to-VDP URL mapping for third-party sites |
| `VAutoDataTim` | 281,809 | 3.1 GB | vAuto DMS vendor staging |
| `VAutoDatatemp` | 312,695 | 2.6 GB | vAuto DMS vendor staging (temp) |
| `DEALERS` | 473,558 | 50 MB | Master dealer registry (all-time) |
| `ShortURL` | 1,291,012 | 610 MB | URL shortener |
| `ADIMAGES` | 2,088,709 | 622 MB | Ad photo URLs |
| `ExistingListings` | 2,576,096 | 32 MB | Live listing index |
| `BANNERTOTAL` | 910,426 | 31.7 MB | Daily banner impression/click totals |
| `AlexFridayReport` | 579,129 | 73 MB | Weekly channel performance report |
| `new_EmailSources_Count_ByMonth` | 547,874 | 31 MB | Monthly email lead analytics |
| `RatchetFeedTracker` | 85,300 | 50 MB | CRM feed submissions |
| `NormalizedFAVDP` | 417,936 | 49 MB | Overflow VDP URLs |
| `DTCL_Calls` | 59,782 | 11 MB | Call tracking records |
| `HomeNetData` | 99,840 | 1 GB | HomeNet DMS staging |

---

## Views (grouped by function)

### Views — CRM & Feed (3 views shown in diagram)

| View | Base Table(s) | Description |
|---|---|---|
| `feed_Uniques` | `RatchetFeedTracker` | One row per unique feed (deduplicates multi-publication subs) with channel, live status, and status name |
| `Accounts_from_Feeds` | `RatchetFeedTracker` | Flattened account-level view of active feeds with channel classification |
| `RatchetFeedTracker_Uniques` | `RatchetFeedTracker` + `RatchetFormActive` | Unique active Ratchet submissions with status and form active flag |

---

### Views — DBA / System (7+ views)

| View | Description |
|---|---|
| `BKUPLog_Joined` | Full backup step log joining BKUPLog + BKUPHistory with file sizes |
| `vw_BkUp_LastStep` | Latest completed backup step per history record |
| `vw_LastDBBU` | Most recent backup per database from msdb |
| `vw_LastJDBBU` | Most recent backup from the custom backup system |
| `JobHistory` | SQL Agent job history with run status and duration |
| `vw_AllScheduledJobsOnServer` | All scheduled SQL Agent jobs with full schedule details |
| `__CurrentPermissions` | Active database user/role permissions |
| `__IndexSizes` | Index size and fragmentation for all user tables |
| `__IndexesNotUsed` | Indexes with zero usage — candidates for removal |
| `_IDX_Primary_Fix` | Tables with missing or misnamed primary key indexes |

---

### Views — Metadata (6+ views)

| View | Description |
|---|---|
| `vw_TInfo` | Table column metadata with SELECT/INSERT/UPDATE statement templates |
| `vw_TRInfo` | Table row info with replication flags |
| `vw_VInfo` | View column metadata |
| `vw_FInfo` | Function definitions |
| `vw_SInfo` | Stored procedure definitions |
| `vw_IDXInfo` / `vw_IDXInfo_v2` | Index definitions with fill factor and size metrics |

---

> **Architecture note:** `web` is the most operationally complex database in the system. Its central axis is the Publications → FeedManager → FEEDDEALERS → FEEDADS chain, which represents the automated import and publication of vehicle inventory from ~80 third-party DMS and aggregator platforms. The Ratchet CRM layer sits above this axis and manages the sales process that activates each feed. The Banner system and Core Ad Engine (ADS) are parallel subsystems for display advertising and direct user-submitted listings respectively. The Bus Scheduler automates the entire import lifecycle. FEEDADS at 47 GB is the dominant table — nearly all other tables in the system exist to support, qualify, or extend the records it contains.
