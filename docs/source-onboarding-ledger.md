# DAS CDP — Source Onboarding & Long-Tail Decomposition Ledger

_Planning artifact (PR #177). The authoritative per-story list for decomposing the three bundled tickets — `initial-feeds`, `ssis-reimplementation` (EPIC), `report-migration` (EPIC) — into real, individually-pointed stories. **One ticket per unique integration type; multiple instances/connections are subtasks, not separate tickets** (the HubSpot rule). Decomposed parents become feature-containers with NO independent points (roll-up only) — no double counting. This doc is the spec the story files will be generated from; review before generation._

## Sizing & sub-phase rules
- Relative t-shirt: S=1, M=2, L=4, XL=8, XXL=16, EPIC=64 pts (≈2× progression).
- **Sub-phase 1a = one representative source per ingest channel** (proves the platform end-to-end); all other onboards → **1b** (long-tail migration).
- The 5 channel reps (1a): **oltp** (db), **Authenticom** (sftp), **TrueCar** (feed), **MailGun** (event), **BlackBook** (api).
- Dual-role vendors = one story, a subtask per role. OEM/CRM unknowns = enumerated placeholders until detail lands.
- Container model: SSIS Reimplementation & Report Migration become **features** (estimate null); their size is the roll-up of children.

## Feature: Source Onboarding & Legacy
`specs/03-phase-1-build/09-long-tail/` (refocused). Primitives + per-source onboards + legacy deprecation.

### Type primitives (reusable scaffolding — 1a)
| # | Source/Story | kind | primitive | size | phase | notes |
|--:|---|---|---|---|---|---|
| 1 | DB/SQL source primitive | primitive | `primitive-db` | XL | 1a | reusable type-handler — existing #10 |
| 2 | REST/API source primitive | primitive | `primitive-api` | XL | 1a | reusable type-handler — existing #11 |
| 3 | SFTP/file-drop source primitive | primitive | `primitive-sftp` | XL | 1a | reusable type-handler — existing #12 |
| 4 | Webhook/event source primitive | primitive | `primitive-event` | XL | 1a | reusable type-handler — existing #13 |
| 5 | CSV/flat-feed source primitive | primitive | `primitive-feed` | XL | 1a | reusable type-handler — existing #14 |

### Source onboards — existing (16)
| # | Source/Story | kind | primitive | size | phase | notes |
|--:|---|---|---|---|---|---|
| 1 | oltp (Response Logix OLTP) | app-db | `primitive-db` | S | 1a | 240 tables/1.13B rows; **db channel rep** — existing #27 |
| 2 | CIM | app-db | `primitive-db` | S | 1b |  — existing #20 |
| 3 | DataOne | app-db | `primitive-db` | S | 1b | **subtask:** + enrichment-API (VIN decode) role — existing #21 |
| 4 | endeavorcentral | app-db | `primitive-db` | S | 1b |  — existing #22 |
| 5 | Feedhub | app-db | `primitive-db` | S | 1b |  — existing #23 |
| 6 | megatron | app-db | `primitive-db` | S | 1b |  — existing #24 |
| 7 | megatron-repository | app-db | `primitive-db` | S | 1b |  — existing #25 |
| 8 | ML_Production (MediaLogix) | app-db | `primitive-db` | S | 1b |  — existing #26 |
| 9 | outbound-feeds | app-db | `primitive-db` | S | 1b |  — existing #28 |
| 10 | petfinder | app-db | `primitive-db` | S | 1b |  — existing #29 |
| 11 | prime | app-db | `primitive-db` | S | 1b |  — existing #30 |
| 12 | reddawn | app-db | `primitive-db` | S | 1b |  — existing #31 |
| 13 | RL_Production | app-db | `primitive-db` | S | 1b | same host as oltp — confirm if logically distinct, else merge — existing #32 |
| 14 | trax | app-db | `primitive-db` | S | 1b |  — existing #33 |
| 15 | web | app-db | `primitive-db` | S | 1b |  — existing #34 |
| 16 | Zuora | app-db | `primitive-db` | — (unpointed) | 1b | **UNPOINTED** placeholder — billing, non-CDP; reprioritize — existing #35 |

### Source onboards — NEW (69)
| # | Source/Story | kind | primitive | size | phase | notes |
|--:|---|---|---|---|---|---|
| 1 | VinSolutions | crm | `primitive-sftp` | M | 1b | per-dealer FTP feeds |
| 2 | eLeads | crm | `primitive-sftp` | M | 1b | per-dealer FTP |
| 3 | Reynolds & Reynolds | crm | `primitive-sftp` | L | 1b | RR/RR2/RR3 instances; manual CAPTCHA |
| 4 | Tekion | crm | `primitive-sftp` | M | 1b | 10k row cap |
| 5 | DriveCentric | crm | `primitive-sftp` | M | 1b | method TBD |
| 6 | DealerSocket | crm | `primitive-api` | M | 1b | per-dealer API |
| 7 | ProMax/Momentum/OpLogic | crm | `primitive-sftp` | M | 1b | one vendor family |
| 8 | Infusionsoft | crm | `primitive-event` | S | 1b | legacy webhook |
| 9 | CRM provider ME (TBD) | crm | `primitive-sftp` | S | 1b | provider code — identify vendor |
| 10 | CRM provider MO (TBD) | crm | `primitive-sftp` | S | 1b | provider code |
| 11 | CRM provider MT (TBD) | crm | `primitive-sftp` | S | 1b | provider code |
| 12 | CRM provider DC (TBD) | crm | `primitive-sftp` | S | 1b | provider code |
| 13 | CRM provider DP (TBD) | crm | `primitive-sftp` | S | 1b | provider code |
| 14 | CDK Global (DMI/3PA) | dms | `primitive-sftp` | L | 1b | multi-brand dealer routing |
| 15 | Authenticom/DealerVault | dms | `primitive-sftp` | L | 1a | primary DMS aggregator; **sftp channel rep** |
| 16 | DealerTrack | dms | `primitive-api` | L | 1b | DMS + credit/F&I |
| 17 | TrueCar | lead | `primitive-feed` | L | 1a | ADF/XML; 2,500+ parsers; **feed channel rep** |
| 18 | AutoTrader | lead | `primitive-feed` | M | 1b | ADF |
| 19 | Edmunds | lead | `primitive-feed` | M | 1b | ADF |
| 20 | CarsDirect | lead | `primitive-feed` | M | 1b | ADF |
| 21 | eBay | lead | `primitive-feed` | M | 1b | ADF |
| 22 | Google Business Profile | review | `primitive-api` | M | 1b | per-dealer OAuth |
| 23 | DealerRater | review | `primitive-api` | M | 1b |  |
| 24 | Yelp | review | `primitive-api` | M | 1b |  |
| 25 | Vendasta | review | `primitive-api` | M | 1b | aggregator |
| 26 | Mozenda | review | `primitive-api` | M | 1b | scraper |
| 27 | CallRevu | review | `primitive-event` | M | 1b | call-tracking webhook |
| 28 | MailGun | email | `primitive-event` | M | 1a | structured webhook; **event channel rep** |
| 29 | Twilio | sms | `primitive-event` | M | 1b | inbound SMS + delivery webhooks |
| 30 | SendGrid | email | `primitive-api` | M | 1b |  |
| 31 | Mandrill | email | `primitive-api` | S | 1b |  |
| 32 | MailChimp | email | `primitive-api` | S | 1b | legacy |
| 33 | Google Analytics 4 | web | `primitive-event` | M | 1b | JS tag + Measurement Protocol |
| 34 | Mixpanel | web | `primitive-api` | S | 1b | internal usage |
| 35 | Dealer Website Crawler (Solr) | web | `primitive-api` | M | 1b | MediaLogix crawler |
| 36 | Engage to Sell / LiveJoin | chat | `primitive-event` | M | 1b | ADF on close |
| 37 | DAS Response Path | chat | `primitive-feed` | S | 1b | internal ADF |
| 38 | HomeNet | inventory | `primitive-api` | L | 1b | VIN anchor; batch pull |
| 39 | Revenue Lab (Tech Pedal) | video | `primitive-api` | M | 1b | video view events |
| 40 | General Motors (OEM) | oem | `primitive-feed` | L | 1b | STAR-XML + ADF; BAC 246435 |
| 41 | Ford (OEM) | oem | `primitive-feed` | M | 1b |  |
| 42 | Toyota (OEM) | oem | `primitive-feed` | M | 1b |  |
| 43 | Honda (OEM) | oem | `primitive-feed` | M | 1b |  |
| 44 | Additional OEMs (TBD) | oem | `primitive-feed` | M | 1b | placeholder — split per OEM as identified |
| 45 | Salesforce (SFDC) | account | `primitive-api` | M | 1b | dealer accounts/flags |
| 46 | Microsoft Dynamics 365 | account | `primitive-api` | M | 1b | SMRM |
| 47 | CommonClientID | account | `primitive-db` | S | 1b | tenant-attribution master |
| 48 | CDXP / 3Birds (Mautic) | internal | `primitive-db` | M | 1b | Mautic MySQL |
| 49 | Radar | internal | `primitive-db` | M | 1b | MongoDB |
| 50 | Mission Control | internal | `primitive-db` | M | 1b | SQL Server |
| 51 | BestRide.com | internal | `primitive-db` | M | 1b | VIN-keyed |
| 52 | Torpedo | internal | `primitive-db` | M | 1b | bulk SMS, phone-keyed |
| 53 | BlackBook | enrichment | `primitive-api` | L | 1a | equity/market value; live source; **api channel rep** |
| 54 | Kelley Blue Book (KBB) | enrichment | `primitive-api` | L | 1b | trade-in valuation |
| 55 | Recall Masters | enrichment | `primitive-api` | L | 1b | open-recall by VIN; new vendor |
| 56 | Experian Conquest | enrichment | `primitive-feed` | L | 1b | bulk CSV append |
| 57 | MaxMind GeoIP2 | enrichment | `primitive-api` | S | 1b | IP->geo |
| 58 | NeverBounce | enrichment | `primitive-api` | S | 1b | email validation |
| 59 | Carfax | enrichment | `primitive-api` | M | 1b | VIN history |
| 60 | 700Credit | enrichment | `primitive-api` | L | 1b | GLBA; hashed SSN only |
| 61 | GreenFlagCredit | enrichment | `primitive-api` | M | 1b | GLBA; hashed SSN |
| 62 | Cars.com | dual | `primitive-feed` | L | 1b | subtasks: lead-feed IN + review-API IN |
| 63 | CarGurus | dual | `primitive-feed` | M | 1b | subtasks: lead-feed IN + review-API IN |
| 64 | Women-Drivers.com | dual | `primitive-api` | M | 1b | subtasks: lead IN + review IN |
| 65 | RouteOne | dual | `primitive-feed` | L | 1b | subtasks: ADF lead IN + F&I API IN |
| 66 | Capital One | dual | `primitive-feed` | L | 1b | subtasks: ADF lead IN + credit API IN |
| 67 | Meta / Facebook | dual | `primitive-api` | M | 1b | subtask: lead-form IN (Phase1); ad push = Phase2 |
| 68 | LotVantage | dual | `primitive-api` | M | 1b | subtask: inventory IN; syndication push = Phase2 |
| 69 | Reconcile CDP vs legacy EDW/DWRPT | reconcile | `primitive-db` | S | 1b | spot-check parity; not ingestion |

### Legacy
- **Legacy system deprecation** — XXL (1b) — existing #04

## Feature: SSIS Reimplementation  — replaces the `ssis-reimplementation` EPIC bundle
`specs/03-phase-1-build/10-ssis-reimplementation/` (new feature). Per ETL module — transform logic, distinct from source onboarding (which lands raw data; this rebuilds dedup/standardize/identity/attribution).
| # | Story | size | phase |
|--:|---|---|---|
| 1 | DMS reconciliation (appts/sales/service) | L | 1b |
| 2 | CRM consolidation (21+ providers) | L | 1b |
| 3 | CRM↔DMS recipient matching | L | 1b |
| 4 | Address geocoding | M | 1b |
| 5 | Declined-service tracking | M | 1b |
| 6 | Marketing attribution engine | L | 1b |
| 7 | Contact-stats / engagement rollup | M | 1b |
| 8 | BlueSky lifecycle position | M | 1b |
| 9 | Vehicle valuation staging (BlackBook pipeline) | M | 1b |
| 10 | Inventory staging | M | 1b |
| 11 | Email engagement (GA/MailGun) transform | M | 1b |
| 12 | Lead prestaging / standardization | L | 1b |
| 13 | CDXP performance transforms | M | 1b |
| 14 | Review / sentiment transforms | M | 1b |
| 15 | SSIS job decommission & cutover | L | 1b |

## Feature: Report Migration  — replaces the `report-migration` EPIC bundle  ⚠ per-item sizing TBD
`specs/03-phase-1-build/11-report-migration/` (new feature). Per DWRPT schema family; per-report work captured as subtasks. **Flagged: first-pass sizing is light for 221 reports — revisit when per-report detail lands.**
| # | Story | size | phase |
|--:|---|---|---|
| 1 | CDXP report family (ALv_CDXP_*) | L | 1b |
| 2 | MediaLogic/ads family (ALv_ML_*) | L | 1b |
| 3 | ReviewLogic family (ALv_RL_*) | M | 1b |
| 4 | SocialLogic family (ALv_SL_*) | M | 1b |
| 5 | Core shared views (core_v_*) | M | 1b |
| 6 | DWRPT parity validation / spot-check | M | 1b |

## Roll-up

**No counts or point totals are stored in this doc — they drift.** Once these stories are generated, the **single source of truth is `specs/manifest.json` + `specs/estimates.json`**, surfaced live on the specs roadmap (`/specs/`) and the estimates view. This ledger is the one-time generation spec, not a live tally.

What the decomposition does (shape, not stored numbers):
- `initial-feeds` dissolves into the 5 channel-representative onboards (1a).
- The two EPIC bundles (`ssis-reimplementation`, `report-migration`) become feature-containers (no independent points) whose size is the roll-up of their decomposed children — no double counting.
- The per-source onboarding surface that was previously invisible (absorbed by `initial-feeds` + the primitives) becomes individually-tracked stories.
- Sub-phase 1a = one representative source per channel; all other source/transform/report stories → 1b.

The per-story **size** column above is the *generation proposal* — it becomes the story's `estimate` frontmatter, after which the manifest/estimates are authoritative. Sizes flagged TBD (report families) get firmed when per-item detail lands.
