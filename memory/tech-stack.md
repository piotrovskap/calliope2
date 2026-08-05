---
name: das-current-tech-stack
description: DAS's existing technology landscape — infrastructure topology, databases, ETL, reporting, AI layer
metadata:
  type: project
---

## AWS Infrastructure (as of 2026-06-08)

Three EC2 instances + two RDS instances. All in AWS (migrating to Azure long-term).

| Server | Instance | IP | Databases |
|--------|----------|----|-----------|
| ETL01 | r5a.8xlarge | 10.254.210.32 | EDW_Staging, EDW_Target, SSISDB — the SSIS execution server |
| 3BHS001 | r7l.2xlarge | 10.254.210.10 | Auth, Automobiles, BirdBath, ClientDB, Lift — application DBs (legacy; modified cautiously, dependencies not fully mapped). Name = 3B (3Birds) + HS (likely Host Server, unconfirmed) — it's the 3Birds app DB server (BirdBath, Lift are 3Birds products) |
| SQL01 | r6i.4xlarge | 10.254.210.28 | ActivityLog, DmsWarehouse, DigitalBundle, Inventory, Tracking |
| RDS (MySQL) | db.m6g.2xlarge | — | Analytics |
| RDS (MySQL) | db.m6g.2xlarge | — | Analytics-Mautic (Mautic open-source, decoupled from main SSIS) |

**Legacy, likely unused:** BirdBath, DigitalBundle — retained but not deleted (downstream dependencies not yet mapped, 12-year-old codebase, multiple ownership changes).

## SSIS Pipeline (ETL01)

13 SSIS jobs running daily, midnight–morning window (~3am–9am). Truncate-and-rebuild pattern — fragile by design.

| Job | Avg Duration | Success Rate | Notes |
|-----|-------------|-------------|-------|
| ThreeBirds.Analytics.CRM | 3h 20m | 93% | Longest-running job |
| ThreeBirds.Analytics.Email | 4h 25m | — | |
| appointment-process | 2h 53m | 97% | Most reliable long-runner |
| ThreeBirds.Analytics.CVH | 2h 4m | 100% | CVH hash pipeline |
| ThreeBirds.Analytics.DDE | 1h 54m | 97% | |
| ThreeBirds.Analytics.LeadSource_LeadPerformance | 1h 28m | — | |
| ThreeBirds.Analytics.BlueSky | 2h 37m | 93% | **FAILING** — "already an object" error on JuiceReporting_CDXPCustomers |
| ThreeBirds.Analytics.CustomerValue | 8m 41m | 100% | |
| JuiceReporting_CDXPCustomers | 7m 7s | 71% | |
| Conquest_Mailing | 57s | 100% | |
| MileOne Weekly Unsubscribe | 2m 54m | 100% | |
| Mileone_reward_member | 4s | **0%** | Never succeeded in 20 runs — unknown purpose |
| ThreeBirds.Analytics.SmartSuppression | — | — | No data |

Monitoring: `localhost:3000/cdxp-job-status` dashboard — built ~1 week before 2026-06-08. The pipeline's first centralized visibility layer.
3–4 offshore data engineers monitor and remediate daily failures. No alerting yet, and limited documentation.

**SFTP ingestion:** Dual-sided — sometimes DAS hosts SFTP (source pushes), sometimes source hosts it (DAS pulls). AWS monitors SFTP and triggers SSIS on new file arrival.

## Reporting Layer

**DWRPT database** — the pre-joined SQL layer that feeds all reporting. Well-structured with schema-prefixed views. Owner: Ron Mulder. CONFLICT has read access (granted); DWRPT is the reporting-parity reference, not a CDP ingestion source.

| Schema prefix | Owned by | Content |
|--------------|----------|---------|
| `ALv_CDXP_*` | CDXP | BlueSky, CDXPCustomers, Transactions, LeadPerformance, MatchBacks, NEW_RECIPIENTS, Marketing_Summary |
| `ALv_ML_*` | MediaLogic | CampaignLevelPerformance, VehiclePerformanceDaily |
| `ALv_RL_*` | ReviewLogic | Leads, Leads_Reactivations, Smart_Follow |
| `ALv_SL_*` | Social Logic | Accounts, Reviews, Surveys, MRSReviewRequest |
| `ALML*` | MediaLogic | Campaign + vehicle performance, VDP data |
| `ALGVACampaign*` | GVA | Campaign data by VIN |
| `ALMAIA*` | MAIA | Campaign data |
| `ALTikTok*` | TikTok | Campaign data |
| `core_v_*` | Core | AllTimePerformance, Reviews, SocialAdsCampaign, Surveys |
| `dbo.` | Default | RL_Leads, RL_Leads_dev |
| `zuora.` | Zuora billing | AccountStage |

**Juicebox** (`das-technology.myjuicebox.io`) — drag-and-drop, no-code reporting. 221 reports (111 sign-in, 110 public). Built primarily by Jacob on the product team, without engineering involvement. **NOT on long-term roadmap.** Critical limitation: cannot perform SQL JOINs — all multi-source data must be pre-joined in DWRPT before Juicebox sees it. CDP must not add new Juicebox dependencies.

## DAS AI Agents (live production)

URL: `ai.das-technology.com` — Microsoft Copilot-style interface with multiple specialized agents.

Active agents: Lead Response Client Results Analysis, QuickChart Analytics, Client Review Sentiment Analysis
Draft agents: CDXP Performance Dashboard, CDXP & RL Lead Nurture

Agents execute SQL (`execute_sql` tool against `mssqlclient`) against DWRPT views. CDP AI features should reuse this infrastructure.

## Identity Layer

**CVH = Customer Vehicle History** — two distinct meanings in DAS code:
1. **CVH hash** (= DealerID + Email) — one contact per dealer per email. No cross-dealer resolution. Being replaced by CDP.
2. **CVH table** — the *merged* CRM+DMS dataset that the SSIS CVH module produces. Acts as the unified customer dataset used platform-wide (analytics, dashboards, campaign targeting). Merge logic lives at `etl/SSIS/CVH/sp_insert_staging_CVH.sql`.

When someone says "CVH" without context, ask which. Most spec docs use the hash sense; most ETL/SP code uses the table sense.

**Common Client ID (CCID)** — a legacy cross-source join key with partial coverage and known cleanliness issues. The CDP treats it as one matching signal among several, never the join foundation (see `wiki/Identity-Resolution.md`); quantifying its row-level coverage is deferred to Phase 1 ingestion/validation, not a Phase-0 blocker.
**Mautic contactID** — main ID for marketing automation. Links all email/SMS engagement. CVH hash → Mautic contactID bridge lives at `etl/Mautic/Contact Sync/sp_Extract_Mautic_Contact_CustomerHashKey.sql`.

## The Approved/Available Stack

Auth0 (auth), Kong (API gateway), RabbitMQ/CloudAMQP (service bus), Redis (cache), GitHub (VCS), Azure Event Hubs (streaming), Azure Functions (serverless), Loggly (logging), Power BI (available, no internal developers), Microsoft Teams (communication).

## What Works — Build On It

Analytics_Clients table (per-client config flags), EDW_Target, DMS_Dim_Transactions (CDK), MailGun events in PostgreSQL, DWRPT views, Auth0, Common Client ID (one signal; coverage validated at Phase 1).

## What Doesn't — Don't Build On It

SSIS packages, CVH hashing, manual CRM CSV exports, daily 1-contact-at-a-time Mautic sync, dev-pointing-to-production, Juicebox (not long-term), AWS Glue (evaluated and rejected).

## Key DAS Technical Contacts

- **Dan Aston** — SVP Engineering. Architecture decisions, repo/infra access.
- **Rick Sorich** — Engineering Manager. Day-to-day SSIS ops, offshore data engineering team.
- **Ron Mulder** — DWRPT owner. Reporting layer, Common Client ID, DWRPT access grants.

**How to apply:** CDP ingestion should target raw SSIS source tables (EDW_Staging or source DBs). CDP reporting integration point is DWRPT — read access granted (Ron Mulder); reporting-parity reference only. Don't consume Juicebox output or post-processed views.

## ETL Source Code

The production SQL lived in the `etl/` git submodule (removed 2026-06-11 after extraction; the readable catalog is now `docs/etl-data-inventory.md`). The `etl/` paths in this file are historical. See [[das-etl-repo-structure]] for the module map (SSIS, Juicebox Reporting, BlackBook, Mautic, PostgreSQL analytics) and key reference points (CVH merge SP, MatchBacks chain, Juice sync orchestrators).
