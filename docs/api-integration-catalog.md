# DAS API Integration Catalog

85 integrations across 19 categories. Primary use: CDP ingestion planning.

**Sources:** DAS Integration Explorer v5 · `wiki/Data-Source-Inventory.md` · `docs/etl-data-inventory.md`

> Related: field→source mapping → `docs/cdp-field-source-matrix.md` · ETL detail → `docs/etl-data-inventory.md` · narrative context → `wiki/Data-Source-Inventory.md`

> **RAW INTAKE CATALOG — verify against the per-API wiki pages.** This is the broad point-in-time integration inventory for ingestion planning. The **verified, current** per-API state lives on the `wiki/*-API.md` research pages and `docs/wiki-research-catalog.json`; some rows here are raw/stale intake (version numbers, `TBD` placeholders). Cross-check the wiki before treating a row as current.

---

## 1. CRM Systems

Leads, purchase intent, customer history. All batch CSV/FTP today; real-time APIs exist but unused.

> `wiki/Data-Source-Inventory.md#crm-systems` · ETL: `etl/SSIS/CRM/`

| Integration | DAS Products | Method | Format | Auth | Identity Keys | Repo |
|---|---|---|---|---|---|---|
| **VinSolutions** (Cox Automotive) | CDXP ETL | batch-csv → ftp | CSV | ftp-creds | dealer_id, email, phone | 3birdsmarketing/3birds_etl_process |
| **eLeads** (CDK CRM) | CDXP ETL | batch-csv → ftp | CSV | ftp-creds | dealer_id, email, phone | 3birdsmarketing/3birds_etl_process |
| **Reynolds & Reynolds** | CDXP ETL | manual CSV → ftp (CAPTCHA) | CSV | ftp-creds | dealer_id, email, phone, VIN | 3birdsmarketing/3birds_etl_process |
| **Tekion** | CDXP ETL | manual CSV (10k row limit) → ftp | CSV | ftp-creds | dealer_id, email, phone | 3birdsmarketing/3birds_etl_process |
| **DriveCentric** | CDXP ETL | TBD | TBD | TBD | TBD | 3birdsmarketing/3birds_etl_process |
| **DealerSocket** | CDXP ETL | api | JSON | api-key | dealer_id, consumer_id | 3birdsmarketing/3birds_etl_process |
| **ProMax / Momentum / OpLogic** | CDXP ETL | batch-csv → ftp | CSV | ftp-creds | dealer_id, email, phone | 3birdsmarketing/3birds_etl_process |
| **Infusionsoft** | CDXP (legacy) | webhook | JSON | hmac-webhook | email | — |

---

## 2. DMS Systems

Transactional record of truth — sales and service ROs.

> `wiki/Data-Source-Inventory.md#dms-systems` · ETL: `etl/SSIS/DMS/`

| Integration | DAS Products | Method | Format | Auth | Identity Keys | Repo |
|---|---|---|---|---|---|---|
| **CDK Global** (DMI / IntegraLink / 3PA) | CDXP ETL, SocialLogix ReviewSurge | 3PA → ftp (48–72 hr lag) | flat-file | 3PA | dealer_id, VIN | dastechnology/social-logix-review-surge-transaction-ingestion-cdk · 3birdsmarketing/3birds_etl_process |
| **Authenticom / DealerVault** | CDXP ETL, SocialLogix ReviewSurge | ftp/sftp | flat-file | ftp-creds | dealer_id, consumer_id, VIN | dastechnology/social-logix-review-surge-transaction-ingestion-csv · 3birdsmarketing/3birds_etl_process |
| **DealerTrack** | CDXP ETL, Credit/F&I | api | JSON | api-key | dealer_id, email, phone, SSN-partial, VIN | — |

---

## 3. Lead Providers

Third-party leads via ADF/XML email or API. Route through 2,500+ parsers → Workflow 2.0.

> `wiki/Data-Source-Inventory.md#lead-providers` · ETL: `etl/SSIS/CRM/`

| Integration | DAS Products | Method | Format | Auth | Identity Keys | Notes |
|---|---|---|---|---|---|---|
| **TrueCar** | ResponseLogix | adf-email | ADF-XML | none | email, phone, name | High volume, clean data |
| **AutoTrader** | ResponseLogix | adf-email | ADF-XML | none | email, phone, name | |
| **Cars.com** | ResponseLogix | adf-email | ADF-XML | none | email, phone, VIN-interest | Also review source (§5) |
| **CarGurus** | ResponseLogix | adf-email | ADF-XML | none | email, phone | Also review source (§5) |
| **Edmunds** | ResponseLogix | adf-email | ADF-XML | none | email, phone | |
| **CarsDirect** | ResponseLogix | adf-email | ADF-XML | none | email, phone | |
| **Women-Drivers.com** | ResponseLogix | api | JSON | api-key | email, phone | Native `/dealer-api/`; also review source (§5) |
| **RouteOne** | ResponseLogix | adf-email | ADF-XML | none | email, phone, SSN-partial | Finance leads; F&I API in §10 |
| **Capital One** | ResponseLogix | adf-email | ADF-XML | none | email, phone | Credit leads; credit API in §10 |
| **General Motors** | ResponseLogix | adf-email / STAR-XML | ADF-XML + STAR-XML | none | email, phone, VIN, BAC-code | DAS BAC: 246435; OEM feed in §14 |
| **eBay** | ResponseLogix | adf-email | ADF-XML | none | email, phone | |

---

## 4. Ad Platforms

Ad performance and lead forms. Lead forms yield consumer PII; campaign data is aggregate only.

> `wiki/Data-Source-Inventory.md#advertising-platforms`

| Integration | DAS Products | Method | Format | Auth | Identity Keys | Repo |
|---|---|---|---|---|---|---|
| **Meta / Facebook Marketing API** | MediaLogix, CDXP, SocialLogix | api + webhook | JSON | oauth2 | FB-ID (opaque), email/phone from lead forms | dastechnology/media-logix-metaads-processor |
| **Google Ads API** (v24) | MediaLogix | api | JSON | oauth2 | GCLID, email (offline conversions) | dastechnology/media-logix-googleads-processor |
| **Google Analytics 4 (GA4)** | CDXP reporting, all sites | JS tag + Measurement Protocol | JSON | api-key | GA4-client-id (anon), GCLID, c_hashkey via utm_term | — |
| **Microsoft / Bing Ads** | MediaLogix | api | JSON | oauth2 | MSCLKID, email (offline conversions) | dastechnology/media-logix-bing-processor · [wiki](https://github.com/ConflictHQ/das-tech/wiki/Bing-Ads-API) |
| **Amazon Ads** | MediaLogix | api | JSON | oauth2 | Amazon Click ID, Match ID, hashed email/phone, MAID (CAPI / AMC) | dastechnology/media-logix-adcenter · [wiki](https://github.com/ConflictHQ/das-tech/wiki/Amazon-Ads-API) |
| **TikTok Ads** | MediaLogix | api | JSON | oauth2 | ttclid (TikTok Click ID), hashed email, hashed phone, MAID (Events API) | dastechnology/media-logix-tiktokads-processor · [wiki](https://github.com/ConflictHQ/das-tech/wiki/TikTok-Ads-API) |
| **YouTube Data / Analytics API** | MediaLogix, LotVantage | api | JSON | oauth2 | opaque | dastechnology/media-logix-youtube-processor |
| **Reddit Ads** | MediaLogix | api | JSON | oauth2 | opaque | dastechnology/media-logix-adcenter |

---

## 5. Review & Reputation

Reviews ingested by Radar (C#/.NET, Azure Functions, MongoDB). Mostly anonymous — low identity match rate.

> `wiki/Data-Source-Inventory.md#review--reputation-sources`

| Integration | DAS Products | Method | Format | Auth | Identity Keys | Repo / Function App |
|---|---|---|---|---|---|---|
| **Google Business Profile** | Radar | api | JSON | oauth2 | none | dastechnology/social-logix-app-api |
| **DealerRater** | Radar | api | JSON | api-key | none | dastechnology/social-logix-app-api · sl-reviews-dealerater-fa-prod |
| **Cars.com** | Radar | api (25 req/sec) | JSON | api-key | none | dastechnology/social-logix-app-api · sl-reviews-cardotcom-fa-prod |
| **CarGurus** | Radar | api (200 req/min) | JSON | api-key | none | dastechnology/social-logix-app-api · sl-reviews-cargurus-fa-prod |
| **Carfax** | Radar, LotVantage | api | JSON | api-key | VIN | dastechnology/social-logix-app-api · sl-reviews-carfax-fa-prod |
| **Yelp** | Radar | api | JSON | api-key | none | dastechnology/social-logix-app-api |
| **Vendasta** | Radar | api | JSON | api-key | none | dastechnology/social-logix-app-api · sl-reviews-vendasta-fa-prod |
| **Mozenda** | Radar | scrape | proprietary | api-key | none | dastechnology/social-logix-app-api · sl-reviews-mozenda-fa-prod |
| **Women-Drivers.com** | Radar | api | JSON | api-key | none | dastechnology/social-logix-app-api |
| **CallRevu** | CDXP | api / webhook | JSON | api-key | phone, VIN-interest | 3birdsmarketing/CDXP-Mautic · Jira CDXP-7307/7406/7413 |

---

## 6. Email & SMS Engagement

Highest-fidelity engagement signal — every event tied to a known Mautic contact via `c_hashkey`.

> `wiki/Data-Source-Inventory.md#email--sms-engagement`

| Integration | DAS Products | Method | Format | Auth | Identity Keys | Repo |
|---|---|---|---|---|---|---|
| **MailGun** | CDXP | webhook → Lambda → PostgreSQL | JSON | hmac-webhook | c_hashkey (DealerID + email) | 3birdsmarketing/CDXP-Mautic |
| **Twilio** | CDXP, ETS, Mobile ReviewSurge | api + webhook | JSON | api-key + hmac | phone | dastechnology/shared-svcs-communication-api · 3birdsmarketing/CDXP-Mautic |
| **SendGrid** | shared-svcs, ResponseLogix, ETS | api | JSON | api-key | email | dastechnology/shared-svcs-communication-api · EngageToSellLLC/LiveJoin3 |
| **Mandrill** (Mailchimp Transactional) | ResponseLogix | api | JSON | api-key | email | dastechnology/shared-svcs-communication-api |
| **MailChimp** | CDXP (legacy) | api | JSON | api-key | email | — |

---

## 7. Website & Analytics

Consumer behavior on DAS-hosted web properties. `utm_term=c_hashkey` ties email click-throughs to known Mautic contacts.

> `wiki/Data-Source-Inventory.md#website--analytics`

| Integration | DAS Products | Method | Format | Auth | Identity Keys | Notes |
|---|---|---|---|---|---|---|
| **Mixpanel** | internal usage tracking | api / JS SDK | JSON | api-key | distinct_id (anon) | `artifacts/phase-0/confluence/integrations-description.md` |

---

## 8. Chat & Messaging

Live chat and AI-driven conversations. Leads delivered as ADF when a conversation closes with a capture.

> `wiki/Data-Source-Inventory.md#chat--messaging`

| Integration | DAS Products | Method | Format | Auth | Identity Keys | Repo |
|---|---|---|---|---|---|---|
| **Engage to Sell / LiveJoin (ETS)** (Rocket.Chat + LiveJoin3 + Dashboard API + BCProxy) | ETS, AI Engage Messaging, ResponsePath | api + webhook | JSON | api-key / jwt | email, phone; FB-ID via BCProxy | EngageToSellLLC/LiveJoin3 · EngageToSellLLC/Dashboard · EngageToSellLLC/RocketChat-LeadPlugin |
| **DAS Response Path** | ResponseLogix | internal | ADF-XML on close | internal | email, phone | dastechnology (ResponsePath) |

---

## 9. Inventory Data

Vehicle catalog. VIN is the CDP anchor for consumer-vehicle relationships.

> `wiki/Data-Source-Inventory.md#inventory-data`

| Integration | DAS Products | Method | Format | Auth | Identity Keys | Notes |
|---|---|---|---|---|---|---|
| **HomeNet** | ResponseLogix, CDXP (VOI matching) | api | JSON | api-key | VIN | Make, model, year, VIN, price, condition |
| **LotVantage** | LotVantage | api + Facebook Catalog | JSON + catalog-feed | api-key + oauth2 | VIN | Syncs to Facebook, eBay, Craigslist, YouTube · legacy (Azure DevOps) |

---

## 10. Credit & Financing

Finance application data — GLBA-scoped. CDP stores hashed identifiers only (no raw SSN).

> `wiki/Data-Source-Inventory.md#credit--financing`

| Integration | DAS Products | Method | Format | Auth | Identity Keys | Notes |
|---|---|---|---|---|---|---|
| **700Credit** (CreditLogix) | CreditLogix / shared-svcs | api | JSON | api-key | SSN-partial, email, phone | Bureau pull + credit app |
| **GreenFlagCredit** | shared-svcs | api | JSON | api-key | SSN-partial, email, phone | Pre-qualification |
| **Capital One** (credit API) | ResponseLogix | api | JSON | api-key | email, phone | ADF lead path separate (§3) |
| **RouteOne** (F&I API) | ResponseLogix | api | JSON | api-key | email, phone, SSN-partial | Finance contracting; ADF lead path separate (§3) |

---

## 11. Vehicle Valuation

Equity and trade-in value — Field Catalog fields 23–24 (EquityAmount, MarketValue).

> `wiki/Data-Source-Inventory.md#vehicle-valuation` · ETL: `etl/BlackBook/`

| Integration | DAS Products | Method | Format | Auth | Identity Keys | Notes |
|---|---|---|---|---|---|---|
| **BlackBook API** | CDXP (equity emails) | api | JSON | api-key | VIN | Equity position + market value; called per equity email send · 3birdsmarketing/3birds_etl_process |
| **Kelley Blue Book (KBB)** | consumer-facing trade-in | api | JSON | api-key | VIN, mileage, condition | Consumer submits vehicle info; trade-in value returned |

---

## 12. Internal DAS Systems

DAS-proprietary products that generate consumer data. No shared identity across these today — CDP is the unification layer.

> `wiki/Data-Source-Inventory.md#internal-das-systems`

| System | What It Generates | Method | Identity Keys | Tech / Repo |
|---|---|---|---|---|
| **CDXP / 3Birds** (Mautic) | Email sends, segments, engagement events | internal — Mautic MySQL + MailGun events | c_hashkey, Mautic contactID | Mautic MySQL → PostgreSQL (3B-CDXP) |
| **Response Logix** | Lead response activity, contact history | internal — MongoDB + SQL Server | email, phone | MongoDB + SQL Server |
| **Radar** | Review management activity | internal — MongoDB | dealer_id | MongoDB + Azure Functions |
| **Mission Control** | Dealer portal activity | internal — SQL Server | dealer_id | SQL Server |
| **MediaLogix** | Ad performance, campaign metrics | internal — SQL Server (migrating from SSIS to C#) | dealer_id, VIN | SQL Server + Azure AKS |
| **BestRide.com** | Marketplace listings | internal — BestRide DB | VIN | DAS.Inventory / DataImportController.cs |
| **Torpedo** | Bulk SMS activity | internal — Torpedo DB | phone | Torpedo DB |
| **Salesforce (SFDC)** | Dealer accounts, product flags | api | dealer_id | dastechnology/shared-svcs-account-management-api · dastechnology/social-logix-app-api |
| **Microsoft Dynamics 365** | Dealer accounts, product flags (SMRM) | api | dealer_id | dastechnology/social-logix-process · dastechnology/social-logix-smrm-report |
| **Dealer Website Crawler** | Current inventory indexed in Solr | scrape (MediaLogix FBI Crawler) | VIN | Apache Solr (AKS service-solr:8983) · dastechnology/media-logix-crawler-ui |
| **LotVantage Platform** | Social inventory performance | internal — LotVantage DB | VIN, dealer_id | legacy (Azure DevOps) |

---

## 13. Video Engagement

Personalized video views are a high-intent buying signal.

> `wiki/Data-Source-Inventory.md#video-engagement` · `artifacts/phase-0/confluence/cdxp-tech-pedal-sla.md`

| Integration | DAS Products | Method | Format | Auth | Identity Keys | Notes |
|---|---|---|---|---|---|---|
| **Revenue Lab** (Tech Pedal SLA) | CDXP Dominate (TTS video) | api | JSON | api-key | Mautic contactID, email, VIN | Videos built from CRM/DMS data; view events are strong CDP buying signals |

---

## 14. OEM Feeds

Manufacturer routing, program data, recall signals.

> `wiki/Data-Source-Inventory.md#oem-feeds`

| Integration | DAS Products | Method | Format | Auth | Identity Keys | Notes |
|---|---|---|---|---|---|---|
| **General Motors** | ResponseLogix, CDXP | adf-email + STAR-XML + OEM APIs | ADF-XML / STAR-XML | none + api-key | email, phone, VIN, BAC-code | DAS BAC: 246435; service appt routing via STAR-XML; ADF lead path in §3 |
| **Ford / Toyota / Honda / other OEMs** | ResponseLogix | varies per OEM | varies | varies | email, phone, VIN | Phase 0 to map per OEM |

---

## 15. Data Enrichment

Utility services that augment consumer records or validate data quality.

| Integration | DAS Products | Method | Format | Auth | Identity Keys | Repo / Reference |
|---|---|---|---|---|---|---|
| **MaxMind GeoIP2** | CDXP | api | JSON | api-key | IP → region | 3birdsmarketing/CDXP-Mautic |
| **Experian Conquest** | CDXP | bulk file | CSV | api-key + file transfer | email, phone, name | 3birdsmarketing/CDXP-Mautic · Jira CDXP-7471 |
| **NeverBounce** | CDXP | api | JSON | api-key | email | 3birdsmarketing/Main (ThreeBirds.NeverBounceApi) · 3birdsmarketing/CDXP-Mautic |
| **DataOne** (VIN decoding) | shared-svcs | api | JSON | api-key | VIN | `artifacts/phase-0/confluence/shared-services-apis.md` |
| **Recall Masters** | CDXP (VSS scoring) | api | JSON | api-key | VIN | c_has_recall field · 3birdsmarketing/CDXP-Mautic |

---

## 16. AI / ML

LLM services used across DAS products.

| Integration | DAS Products | Base URL | Auth | Models | Repo |
|---|---|---|---|---|---|
| **OpenAI** | Radar, AI Engage, MediaLogix AI Workflow, CDXP Dominate | api.openai.com/v1 | api-key | gpt-4o, gpt-4o-mini, tts-1 | dastechnology/central-apis-aiservice · dastechnology/media-logix-ai-workflow-engine |
| **Google Gemini** | Central AI Service (fallback) | — | api-key | — | dastechnology/central-apis-aiservice |

---

## 17. Social / Listings Management

Platforms that publish content and sync listings on DAS's behalf.

| Integration | DAS Products | Method | Auth | Channels | Repo |
|---|---|---|---|---|---|
| **Soci** | SocialLogix | api | api-key | Facebook, Instagram, Google Business Profile | dastechnology/social-logix-app-api |
| **Yext** | SocialLogix (Local) | api | api-key | Google, Yelp, Apple, Facebook | dastechnology/social-logix-app-api |

---

## 18. Billing / Payments

LotVantage dealer billing (legacy Azure DevOps). No CDP relevance.

| Integration | DAS Products | Notes | Repo |
|---|---|---|---|
| **CyberSource** | LotVantage | Payment gateway; DB: cybersource_subscription_id | legacy (Azure DevOps) |
| **Zuora** | LotVantage | Subscription billing / monthly invoices | legacy (Azure DevOps) |
| **QuickBooks** | LotVantage | Invoice sync; DB: quickbooks_edit_sequence | legacy (Azure DevOps) |

---

## 19. Infrastructure

Hosting and data platforms underlying DAS products.

| Integration | DAS Products | Notes | Repo |
|---|---|---|---|
| **AWS** (Lambda / S3 / SES) | CDXP/3Birds, ResponsePath/ETS (migrating) | ETL runtime, storage, email · Jira TP2025-14 | 3birdsmarketing/CDXP-terraform · 3birdsmarketing/CSharp-Lambda |
| **HostedFTP** | LotVantage, BestRide | Inventory flat file drops · bestride.hostedftp.com | legacy (Azure DevOps) |
| **Microsoft Graph / Outlook** | Radar (SPIKE) | RadarMail already uses Graph API · Confluence 3525541894 | legacy (Azure DevOps) |
