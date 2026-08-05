<!-- Source: VSS-Spec-v2-Microservices.html — reference material provided by DAS Technology.
     Converted from HTML; original lives in the shared Drive folder. -->

# VSS Spec v2 — Microservices

> **Reference material provided by DAS.** Converted from the original HTML. This is a DAS source document, not a Conflict deliverable.
>
> Original: [vss-spec-v2-microservices.html](/artifacts/phase-0/source-docs/vss-spec-v2-microservices.html)

---

TECHNICAL SPECIFICATION v2.0 — MICROSERVICES

# Vehicle Smart Score

Multi-tenant vehicle health microsite platform

**Architecture:** Microservices

**Version:** 2.0 MVP

**Date:** March 2026

4 Services 4 Repos Kong Gateway Azure Event Grid Azure AKS Shared PostgreSQL Azure ACR

## Contents

  1. Microservices Architecture
  2. Service Definitions & Ownership
  3. Inter-Service Communication
  4. Infrastructure & Deployment
  5. Database Schema & ER Diagram
  6. URL Routing & Kong Configuration
  7. Consumer Microsite — UI Specification
  8. Backend Portal — UI Specification
  9. Email System — UI Specification
  10. Score Calculation Engine
  11. CDP Integration & API Contracts
  12. MVP Phasing & Task Breakdown



Section 01

## Microservices Architecture

VSS is composed of 4 independently deployable microservices behind an existing Kong API Gateway. All services share a single PostgreSQL instance with schema-per-service isolation. Any service can read directly from any schema; writes are restricted to the owning service. Async events flow through Azure Event Grid. The only inter-service REST calls are portal → vss-email for actions (send, template CRUD).

System Architecture — Microservices

Kong API Gateway (Existing) AZURE KUBERNETES SERVICE (AKS) vss-microsite Next.js · SSR · Public /{dealer}/{uuid}/{vin} Direct DB reads (all schemas) repo: vss-microsite vss-portal Next.js · Azure AD SSO /portal/* /api/portal/* DAS Design System repo: vss-portal vss-data Node.js API · Scoring /api/data/* Owns consumer/vehicle data repo: vss-data vss-email Node.js API · Templates /api/email/* CommunicationAPI client repo: vss-email Azure Event Grid — Async Events Direct DB Direct DB REST Shared PostgreSQL (Azure DB) 3 schemas, each owned by one service: data.* Consumer, Vehicle, Score, ServiceRecord, Recall, Product portal.* Dealer, DealerConfig, PortalUser email.* EmailTemplate, EmailLog Azure Blob Storage Dealer logos & branding assets Uploaded via vss-portal Asset CDN (Existing) Vehicle images & static assets Custom CDP POST → vss-data ingest CommunicationAPI Called by vss-email VIN Image API Called by vss-data Response Logix Called by vss-microsite Azure AD SSO for vss-portal Data Flow: 1\. CDP pushes data → vss-data ingests, calculates score, stores in data.* schema 2\. vss-data publishes "score.calculated" to Event Grid → vss-email subscribes, sends notification 3\. Consumer clicks email link → Kong routes to vss-microsite → direct DB read across schemas → SSR render Azure ACR

Section 02

## Service Definitions & Ownership

Service 1

vss-microsite

Consumer-facing SSR microsite. Renders personalized vehicle pages. No database writes — reads directly from all schemas (data, portal) via shared PostgreSQL.

**Tech:** Next.js 14, SSR, Tailwind  
**Auth:** None (public)  
**Schema:** None (read-only consumer)  
**Repo:** vss-microsite

Service 2

vss-portal

Backend admin UI for dealer management, section visibility, content editing, branding, and user management. DAS Design System.

**Tech:** Next.js 14, shadcn/ui + DAS  
**Auth:** Azure AD SSO, RBAC  
**Schema:** portal.*  
 **Repo:** vss-portal

Service 3

vss-data

Core data service. Ingests CDP data, owns consumer/vehicle/score records, runs scoring engine. Other services read its schema directly.

**Tech:** Node.js, Express/Fastify, Prisma  
**Auth:** API key (CDP ingest)  
**Schema:** data.*  
 **Repo:** vss-data

Service 4

vss-email

Email template management, merge tag rendering, sending via CommunicationAPI, delivery logging.

**Tech:** Node.js, Express/Fastify, Prisma  
**Auth:** Internal JWT  
**Schema:** email.*  
 **Repo:** vss-email

### Schema Ownership & Cross-Schema Access

Schema| Owner| Tables| Read Access  
---|---|---|---  
`data`| vss-data| Consumer, Vehicle, VehicleSmartScore, ServiceRecord, RecallRecord, ProtectionProduct| All services (direct DB read)  
`portal`| vss-portal| Dealer, DealerConfig, PortalUser| All services (direct DB read)  
`email`| vss-email| EmailTemplate, EmailLog| vss-portal (direct DB read + REST for actions)  
  
**Data access rules:** Any service can read directly from any schema via the shared PostgreSQL connection. Writes are restricted — each service writes only to its own schema. The only inter-service REST calls are vss-portal → vss-email for actions (send email, template CRUD) where a synchronous response is needed. 

Section 03

## Inter-Service Communication

### Data Access: Direct Database Reads

All services connect to the shared PostgreSQL instance and can read from any schema directly. This eliminates inter-service REST calls for data retrieval and provides the fastest possible read path — especially critical for vss-microsite SSR rendering.

Service| Reads From| Writes To  
---|---|---  
vss-microsite| `data.*` `portal.*` (single Prisma query across schemas)| None (read-only)  
vss-portal| `data.*` `email.*` (consumer browser, email logs)| `portal.*` only  
vss-data| `portal.*` (dealer lookup during ingest)| `data.*` only  
vss-email| `data.*` `portal.*` (merge tag data at send time)| `email.*` only  
  
### REST API: Actions Only (Portal → Email)

The only inter-service REST calls are from vss-portal to vss-email for actions that require a synchronous response — sending emails and managing templates. These are actions, not data reads.

Caller| Target| Endpoint| Purpose  
---|---|---|---  
vss-portal| vss-email| `POST /api/email/send`| Manual send or test send — user needs sync confirmation  
vss-portal| vss-email| `POST /api/email/bulk-send`| Batch send for a dealer's consumers  
  
**Why REST for email actions only?** When a portal user clicks "Send Test Email" or "Resend," they need immediate feedback (success/failure). Event Grid is fire-and-forget. Template CRUD is handled by the portal reading/writing the `email.*` schema directly — only the send action needs to go through vss-email's API since it orchestrates the CommunicationAPI call. 

### Asynchronous (Azure Event Grid)

vss-data → publishes → score.calculated → subscribes → vss-email

When a new score is calculated, the email service reads consumer/dealer data directly from DB, renders the template, and auto-sends the notification.

vss-portal → publishes → config.updated → subscribes → vss-microsite

When dealer config changes, the microsite can bust any cached SSR pages for that dealer.

vss-data → publishes → consumer.ingested → subscribes → vss-portal

Portal dashboard can update consumer counts in near-real-time.

### Event Grid Topic Schema
    
    
    {
      "id": "event-uuid",
      "eventType": "VSS.Score.Calculated",
      "subject": "/dealers/{dealerId}/consumers/{consumerId}/vehicles/{vin}",
      "eventTime": "2026-03-06T12:00:00Z",
      "data": {
        "dealerId": "uuid",
        "consumerId": "uuid",
        "vin": "1HGCV1F34LA067890",
        "compositeScore": 55,
        "compositeLabel": "Average",
        "triggerEmail": true
      },
      "dataVersion": "1.0"
    }

### Internal Service Authentication

The portal → vss-email REST calls use a shared JWT secret for authentication. Kong is not involved in this internal traffic — the portal calls vss-email directly via Kubernetes service DNS (`http://vss-email.vss.svc.cluster.local`). All other cross-service data access is via direct database reads, requiring no additional auth beyond the shared PostgreSQL credentials.

Section 04

## Infrastructure & Deployment

Component| Technology| Notes  
---|---|---  
Container Registry| Azure ACR (existing)| 4 images: vss-microsite, vss-portal, vss-data, vss-email  
Orchestration| Azure AKS| 4 Deployments, 4 Services, HPA per service  
API Gateway| Kong (existing)| Route-based routing to AKS services  
Database| Azure Database for PostgreSQL| Shared instance, 3 schemas (data, portal, email)  
File Storage| Azure Blob Storage| Dealer logos, managed by vss-portal  
Events| Azure Event Grid| Custom topic for VSS events  
Secrets| Azure Key Vault| DB creds, API keys, JWT secrets  
CI/CD| GitHub Actions (per repo)| Lint → Test → Docker build → Push ACR → Deploy AKS  
  
### Kubernetes Resources (per service)
    
    
    # Each service deploys:
    - Deployment (2+ replicas, resource limits, liveness/readiness probes)
    - Service (ClusterIP for internal, LoadBalancer/NodePort for Kong)
    - HorizontalPodAutoscaler (CPU/memory based)
    - ConfigMap (non-secret config)
    - ExternalSecret (references Azure Key Vault)

### Repo Structure (per service)
    
    
    vss-{service}/
    ├── .github/workflows/ci-cd.yml
    ├── docker/
    │   ├── Dockerfile
    │   └── Dockerfile.dev
    ├── k8s/
    │   ├── deployment.yaml
    │   ├── service.yaml
    │   ├── hpa.yaml
    │   └── configmap.yaml
    ├── prisma/
    │   ├── schema.prisma        # Only this service's schema
    │   ├── migrations/
    │   └── seed.ts
    ├── src/
    │   ├── ...                   # Service-specific code
    ├── .env.example
    ├── package.json
    ├── tsconfig.json
    └── CLAUDE.md                 # Claude Code instructions for this service

Section 05

## Database Schema & ER Diagram

Single PostgreSQL instance with 3 schemas. Each schema is owned and migrated by one service. Color coding matches service ownership.

Entity Relationship Diagram — Schema-per-Service

data schema (vss-data) portal schema (vss-portal) email schema (vss-email)

Dealer portal

id UUID PK  
name · slug (unique)  
logoUrl · poweredByLogo  
salesPhone · servicePhone  
email · website  
address · city · state · zip  
instagramHandle · facebookUrl  
isActive · timestamps 

DealerConfig portal

id UUID PK  
dealerId FK → Dealer (1:1)  
show* (16 boolean toggles)  
*Title, *Body (text overrides)  
primaryColor · secondaryColor  
accentColor · headerBgColor  
fontFamily · heroVideoUrl  
servicePromoText · freeRidesText  
upgradeOverlayText · tradeInCtaUrl  
stockQuoteCtaUrl · conditionCta*  
footerDisclaimerText  
supportLinks · quickLinks (JSON) 

PortalUser portal

id UUID PK  
azureAdId (unique)  
email · name  
role (SUPER_ADMIN|ADMIN|EDITOR|VIEWER)  
dealerId FK → Dealer (nullable) 

Consumer data

id UUID PK  
dealerId (references portal.Dealer)  
cdpId · firstName · lastName  
email · phone  
unique(dealerId, cdpId) 

Vehicle data

id UUID PK  
consumerId FK → Consumer  
year · make · model · trim  
vin · mileage · imageUrl  
purchaseDate · estimatedValue  
purchasePrice · tradeInValue  
loanBalance · loanTerm · loanMonthsPaid  
servicePlanName · servicePlanExpiry 

VehicleSmartScore data

id UUID PK  
vehicleId FK → Vehicle (1:1)  
5 sub-rating scores + labels  
**compositeScore · compositeLabel**  
calculatedAt 

ServiceRecord data

id UUID PK  
vehicleId FK → Vehicle  
serviceDate · description  
status (COMPLETED|SCHEDULED|MISSED|OVERDUE|DECLINED)  
cost · mileageAtService · imageUrl 

RecallRecord data

id UUID PK  
vehicleId FK → Vehicle  
recallNumber · description  
severity · status · recallDate 

ProtectionProduct data

id UUID PK  
vehicleId FK → Vehicle  
type · name · description  
price · ctaLabel · ctaUrl 

EmailTemplate email

id UUID PK  
dealerId (references portal.Dealer)  
name · subject  
bodyHtml · bodyText · isActive 

EmailLog email

id UUID PK  
dealerId · consumerEmail  
templateId · subject · status  
sentAt · errorMessage · micrositeUrl 

Section 06

## URL Routing & Kong Configuration

Kong Route| Target Service| Auth  
---|---|---  
`vss.com/{dealer-slug}/{uuid}/{vin}`| vss-microsite| None (public)  
`vss.com/portal/*`| vss-portal| Azure AD SSO (handled by service)  
`vss.com/api/portal/*`| vss-portal| Azure AD SSO  
`vss.com/api/data/*`| vss-data| API key (external CDP only)  
`vss.com/api/email/*`| vss-email| Internal JWT (portal only)  
  
**Internal traffic:** vss-portal → vss-email REST calls bypass Kong and use Kubernetes DNS directly (`http://vss-email.vss.svc.cluster.local:3000`). All other cross-service data access is via shared PostgreSQL — no network calls needed. 

Section 07

## Consumer Microsite — UI Specification

The microsite is a single long-scroll page rendered server-side by **vss-microsite**. At render time, it reads directly from the shared PostgreSQL database across the `data` and `portal` schemas — no inter-service REST calls needed. Upgrade vehicles are fetched from Response Logix. All sections are conditionally shown based on dealer config toggles. All colors and text are dealer-configurable; the default theme is black/dark with white content areas.

🔒 vss.com/kimberly-eakin-kia/a1b2c3d4-5678-90ef/1HGCV41JXMN109186

VSS  
Shield

Powered by...

KIA

Kimberly Eakin Kia

📞 Sales: 936-287-3088  
🔧 Service: 936-287-5794  
🌐 www.kimberlycakin kia.com  
✉️ sales@kimberlycakinkia.com  
📍 1705 S 1st St Lufkin, TX 75901  
📸 @keakinkia_tx  
📘 facebook.com/KEakinKia/ 

Owner Information

Name

John Smith

Email

Johnsmith23@gmail.com

Phone

936-346-2244

Vehicle Information

Year/Make/Model/Trim

2021 Jeep Grand Cherokee Laredo E RWD

VIN

1HGCV41JXMN109186

Purchase Date

12/31/2020

Mileage

60,798 miles

Purchase Price

$45,999

VSS

▶

↗

John! Welcome to your Vehicle Smart Score.

We are providing this helpful update on all the ways you can continue to protect your investment. For most consumers, your vehicle is in the top three investments you make so it is important to know all the ways you can take care of it. Keeping your vehicle serviced on schedule, coming in for warranty work or complimentary recall repairs can help increase your future trade in-value or sales price of your vehicle. Below you will also find some exciting upgrade options. Contact us anytime using the helpful links below.

Vehicle Smart Score

We providing you with this Vehicle Smart Score to help you monitor and improve the value of your vehicle throughout your ownership journey.

Report Generated 3/6/2026

Needs Attention Average Good Great

_**If you're wondering 'does service history affect car value', the answer is yes – it can significantly influence your car's resale price.**_ The Vehicle Smart Score is your helpful gauge to identify where there are opportunities to aid with the value of your vehicle. Your Vehicle Smart Score is an estimate based on information in the dealer's system. Please visit the dealership for an accurate valuation of your trade-in. 

Your Vehicle Rating Breakdown

Mileage

Average

12,160 miles/year

12,160 miles per year is more than the ideal 10,000 miles/year

Scheduled Maintenance

Average

68% Complete

68% of the scheduled maintenance completed, needs Transmission Fluid Change, Coolant Flush, Air Filter Replacement, and Windshield Replacement

Recall Work

Needs Attention

2 Open Recalls

• Faulty Seat Belt  
• Fuel Pump Gasket

Recalls repairs are completed by the dealership free of charge.

Condition

Good

Good

Base on the features of your model and a review of your vehicle during your last service visit

Click to Add Condition Details

Market Value

Average

76% of purchase price

Your vehicle has depreciated 34% and you have 75% equity

Service Records

✅Completed Service

• Oil & Filter Change  
• Tire Rotation  
• Battery Test  
• Brake Inspection

⚠️Missed Service

• Transmission Fluid Change  
• Coolant Flush  
• Air Filter Replacement

Schedule Service

❌Declined Service

• Windshield Replacement  
• Paint Protection Coating  
• Interior Detailing Package

Schedule Service

Service History

🔧

2026-01-20

Engine inspection - Jan 2025

🛞

2025-11-06

Tire inspection - Oct 2024

Schedule your service through the **Vehicle Smart Score** & receive **10% off** your total. **Click here to schedule now!**

Schedule Service

Conditions & Exclusions apply

📅Schedule Service

☐ Transmission Fluid Change  
☐ Coolant Flush  
☐ Air Filter Replacement  
☐ Windshield Replacement

Schedule Service

⏱️Service Plan Status

Extended Service Plan Plus

5m 30d

Expires 9/5/2026

Renew Service Plan

🚗Free Rides Service

Kimberly Eakin Kia offers complimentary transportation to and from our dealership when you drop off your vehicle for scheduled maintenance. Stay comfortable while we care for your car.

Learn More

Protect Your Vehicle!

🛡️Extended Vehicle Service Plans

Extend your warranty coverage beyond the manufacturer's plan for comprehensive protection and peace of mind.

$1,499

See Plan Options

⚡Gap Insurance

Coverage for the gap between your vehicle's value and loan balance if your car is totaled in an accident.

$599

Get a Quote

🔒Tire & Wheel Protection Plan

Comprehensive coverage for tire damage, wheel repairs, and replacements due to road hazards.

$399

Explore Options

✨Appearance Protection

Protect your vehicle's exterior with coverage for paint, clear coat, and protective film applications.

$799

Learn More

🪟Windshield Protection

Coverage for windshield repair and replacement with minimal or no deductible for peace of mind.

$299

Learn More

🔑Key Replacement

Protection against expensive key fob and replacement key costs with comprehensive coverage.

$199

Learn More

Additional Offers

🔵Roadside Assistance

24/7 emergency roadside support including towing, lockouts, flat tire assistance, and fuel delivery.

$99/year

Learn More

🔧Window Tinting

Premium UV protection window tinting

$299

Shop Now

📍LoJack

GPS tracking and recovery system

$599

Shop Now

🛒Purchase Accessories

Shop Accessories

Equity & Trade-In Opportunities

🎉Positive Equity Position!

Great news! Your current vehicle's trade-in value is **$31,463** , a strong position for upgrading. Our team can help you explore the latest models and financing options tailored to your needs.

Explore Trade-In Options →

VEHICLE LOAN STATUS

60/72

MONTHS  
PAID OFF

🚗

12/72

MONTHS  
REMAINING

83% PAID

17% REMAINING

Financing Options

Explore competitive financing options with Kia Financial Services to find the best rates and terms for your vehicle.

Check Financing Options →

Your Current Vehicle & Upgrade Options

Powered by Response Logix

🚙

Your Current Vehicle

2021 Jeep

$31,463

THE EAKIN DIFFERENCE🚗

Upgrade Option

2026 Kia Sorento EX AWD

View Details →

THE EAKIN DIFFERENCE🚗

Upgrade Option

2025 Kia Telluride S FWD

View Details →

THE EAKIN DIFFERENCE🚗

Upgrade Option

2026 Kia Seltos EX AWD

View Details →

THE EAKIN DIFFERENCE🚗

Upgrade Option

2026 Kia Sorento EX FWD

View Details →

Get Trade-In Offer → Get Your Smart Quote On Any Vehicle In Stock →

🛡️ Shop for a New Vehicle Insurance Quote

Compare rates from leading insurance providers to find the best coverage for your vehicle

STATE FARM

State Farm

Get Quote

PROGRESSIVE

Progressive

Get Quote

GEICO

Geico

Get Quote

ALLSTATE

Allstate

Get Quote

Shopping Made Easy

Use these links to compare insurance rates and get instant quotes. Each provider will ask about your vehicle, driving history, and coverage needs.

Tip: Have your vehicle information handy for faster quote processes.

© 2026 Vehicle Smart Score. All rights reserved. Powered by Kimberly Eakin Kia 

About Vehicle Smart Score

Comprehensive vehicle rating system providing owners with detailed insights about their vehicle's condition, value, and service history.

Vehicle Smart Scorecard products and services are based only on information supplied by the dealer and third parties. Kimberly Eakin Kia and DAS Technology do not have the complete history of every vehicle. Use the Vehicle Smart Scorecard as one important tool, along with a vehicle inspection and test drive, to make a better decision about your next vehicle decision.

Support

Help Center  
Contact Us  
Privacy Policy

Quick Links

Dealership Locator  
Vehicle Pricing  
Service Booking  
Service to Value Article

Copyright DAS Technology 2026 

### Data Points by Section

#### Header Bar

Data Point| Source| Portal Configurable  
---|---|---  
VSS Shield Logo| Static asset| No (system branding)  
Dealer Logo (OEM)| `dealer.poweredByLogo`| Yes — upload via portal  
Dealer Name| `dealer.name`| Yes  
Sales Phone| `dealer.salesPhone`| Yes  
Service Phone| `dealer.servicePhone`| Yes  
Website URL| `dealer.website`| Yes  
Email| `dealer.email`| Yes  
Street Address| `dealer.address, city, state, zip`| Yes  
Instagram Handle| `dealer.instagramHandle`| Yes  
Facebook URL| `dealer.facebookUrl`| Yes  
  
#### Owner & Vehicle Info

Data Point| Source| Portal Configurable  
---|---|---  
Consumer Name, Email, Phone| `consumer.*`| No (from CDP)  
Year/Make/Model/Trim| `vehicle.*`| No (from CDP)  
VIN| `vehicle.vin`| No  
Purchase Date| `vehicle.purchaseDate`| No  
Mileage| `vehicle.mileage`| No  
Purchase Price| `vehicle.purchasePrice`| No  
Hero Video URL| `dealerConfig.heroVideoUrl`| Yes — always a video embed  
Welcome Title| `dealerConfig.welcomeTitle`| Yes  
Welcome Body| `dealerConfig.welcomeBody`| Yes  
  
#### Vehicle Smart Score & Rating Breakdown

Data Point| Source| Portal Configurable  
---|---|---  
Score Gauge Position| `smartScore.compositeScore`| No (calculated)  
Report Generated Date| `smartScore.calculatedAt`| No  
Score Explanation Text| `dealerConfig.smartScoreDescription`| Yes  
5 sub-rating labels + scores| `smartScore.{category}Label`| No (calculated)  
Sub-rating detail text| `smartScore.{category}Detail`| No (calculated)  
Recall item list (bullets)| `recalls[]` descriptions| No (from CDP)  
Maintenance missing items| `serviceRecords[]` where status=MISSED| No  
Condition CTA button| `dealerConfig`| Yes — label + URL  
  
#### Service Records

Data Point| Source| New DB Field?  
---|---|---  
Completed Services list| `serviceRecords[]` where status=COMPLETED| Existing  
Missed Services list| `serviceRecords[]` where status=MISSED| Existing  
Declined Services list| `serviceRecords[]` where status=DECLINED| DECLINED status in ServiceStatus enum  
Service History images| `serviceRecords[].imageUrl`| `serviceRecord.imageUrl`  
Scheduling promo text + discount| `dealerConfig.servicePromoText`| `dealerConfig`  
Service Plan name + expiry| `vehicle.servicePlanName`, `vehicle.servicePlanExpiry`| `vehicle` model  
Free Rides description| `dealerConfig.freeRidesText`| `dealerConfig`  
  
#### Equity & Trade-In / Upgrades

Data Point| Source| Notes  
---|---|---  
Trade-in value| `vehicle.tradeInValue`| `vehicle.tradeInValue` (or from Response Logix)  
Equity amount| Calculated: tradeInValue - loanBalance| Computed at render time  
Loan months paid/remaining| `vehicle.loanMonthsPaid`, `vehicle.loanTerm`| Existing  
Upgrade vehicles| Response Logix API| External call at SSR time  
Dealer inventory overlay text| `dealerConfig.upgradeOverlayText`| `dealerConfig.upgradeOverlayText`  
Trade-in CTA URL| `dealerConfig.tradeInCtaUrl`| `dealerConfig`  
Stock quote CTA URL| `dealerConfig.stockQuoteCtaUrl`| `dealerConfig`  
  
#### Footer

Data Point| Source| Portal Configurable  
---|---|---  
Copyright line| System + `dealer.name`| Partially  
About VSS text| `dealerConfig.footerAboutText`| Yes  
Legal disclaimer| `dealerConfig.footerDisclaimerText`| `dealerConfig`  
Support links| `dealerConfig.supportLinks` (JSON)| JSON array of `{label, url}`  
Quick Links| `dealerConfig.quickLinks` (JSON)| JSON array of `{label, url}`  
  
### DB Schema Changes Required

**Dealer model fields:** `salesPhone`, `servicePhone`, `instagramHandle`, `facebookUrl`  
  
**DealerConfig model fields:** `servicePromoText`, `freeRidesText`, `upgradeOverlayText`, `tradeInCtaUrl`, `stockQuoteCtaUrl`, `footerDisclaimerText`, `supportLinks` (JSON), `quickLinks` (JSON), `conditionCtaLabel`, `conditionCtaUrl`  
  
**Vehicle model fields:** `servicePlanName`, `servicePlanExpiry`, `tradeInValue`  
  
**ServiceRecord model fields:** `imageUrl`  
  
**ServiceStatus enum values:** `COMPLETED`, `SCHEDULED`, `MISSED`, `OVERDUE`, `DECLINED`

Section 08

## Backend Portal — UI Specification

The portal (**vss-portal**) uses the DAS Design System — Satoshi font, clementine orange primary, shuttle gray neutrals, shadcn/ui components with DAS token overrides. Sidebar navigation matches the DAS Storybook pattern.

### Portal Dashboard

🔒 vss.com/portal

◎

DAS Technology

🔍 Search...

🏠 Dashboard

🏢 Dealers 24

👥 Consumers

✉️ Email

📊 Reporting

👤 Users

⚙️ Settings

JS

Jane Smith

jane@das.com

🏠 | Dashboard

Dashboard

Overview of your Vehicle Smart Score platform.

Active Dealers

24

↑ 3 this month

Total Consumers

12,847

↑ 1,204 this month

Emails Sent (7d)

3,291

↑ 18% vs last week

Avg Smart Score

62

Across all vehicles

Recent Dealers

View All

Dealer| Slug| Consumers| Status  
---|---|---|---  
Kimberly Eakin Kia| `kimberly-eakin-kia`| 847| Active  
Metro Honda| `metro-honda`| 1,203| Active  
Prestige BMW Austin| `prestige-bmw-austin`| 562| Active  
Valley Toyota| `valley-toyota`| 0| Setup  
  
### Dealer Configuration — Section Visibility

🔒 vss.com/portal/dealers/kimberly-eakin-kia

◎

DAS

🏠 | Dealers | Kimberly Eakin Kia

Kimberly Eakin Kia

General

Branding

Sections

Content

Videos

Preview

Microsite Section Visibility

Header Bar

Owner Information

Welcome Message

Vehicle Smart Score

Rating Breakdown

Service Dashboard

Protection Products

Additional Offers

Equity & Trade-In

Insurance Quotes

Footer

Save Changes Preview Microsite

Section 09

## Email System — UI Specification

The notification email is managed by **vss-email**. Templates are edited via the portal (which calls vss-email's API). When vss-data publishes a `score.calculated` event, vss-email subscribes, fetches consumer data from vss-data, renders the template, and sends via CommunicationAPI.

✉️ Email Preview — VSS Notification

Vehicle Smart Score

KIA

Kimberly Eakin Kia

Hi John,

Your Vehicle Smart Score for your **2021 Jeep Grand Cherokee** is ready!

We've analyzed your vehicle's service history, condition, and market position to create a personalized report with insights and recommendations.

55

Your Vehicle Smart Score: **Average**

See your full breakdown including service history, open recalls, protection options, and trade-in opportunities.

View Your Vehicle Smart Score →

Questions? Contact us at (555) 201-3456 or service@kimberlykia.com

Kimberly Eakin Kia | 1234 S Las Vegas Blvd, Austin TX 78701  
Powered by Vehicle Smart Score · Unsubscribe

### Merge Tags

Tag| Source| Example  
---|---|---  
`{{firstName}}`| data → consumer.firstName| John  
`{{lastName}}`| data → consumer.lastName| Smith  
`{{vehicleYear}}`| data → vehicle.year| 2021  
`{{vehicleMake}}`| data → vehicle.make| Jeep  
`{{vehicleModel}}`| data → vehicle.model| Grand Cherokee  
`{{dealerName}}`| portal → dealer.name| Kimberly Eakin Kia  
`{{dealerLogo}}`| portal → dealer.logoUrl| https://cdn.vss.com/logos/kimberly-kia.png  
`{{dealerPhone}}`| portal → dealer.salesPhone| 936-287-3088  
`{{dealerServicePhone}}`| portal → dealer.servicePhone| 936-287-5794  
`{{dealerEmail}}`| portal → dealer.email| service@kimberlykia.com  
`{{micrositeUrl}}`| Constructed from dealer slug + consumer UUID + VIN| vss.com/kimberly-eakin-kia/...  
`{{smartScoreLabel}}`| data → compositeLabel| Average  
`{{smartScoreValue}}`| data → compositeScore| 55  
  
Section 10

## Score Calculation Engine

Owned by **vss-data**. The composite score is a weighted average of 5 sub-ratings, each on a 0–100 scale.

Sub-Rating| Weight| Input  
---|---|---  
Mileage| 15%| Actual vs. expected mileage for vehicle age  
Maintenance| 25%| % of scheduled services completed  
Recalls| 25%| Open recalls count + severity weighting  
Condition| 20%| CDP condition rating mapped to numeric score  
Market Value| 15%| Current value vs. purchase price ratio  
      
    
    Labels: 85-100 "Excellent" | 70-84 "Good" | 50-69 "Average" | 30-49 "Below Average" | 0-29 "Needs Attention"

Section 11

## CDP Integration & API Contracts

The external CDP pushes data to **vss-data** via Kong. Other services read vss-data's schema directly from the shared database.

#### External: CDP → vss-data
    
    
    POST /api/data/ingest
    Authorization: Bearer <CDP_API_KEY>
    
    {
      "dealer": { "cdpDealerId": "...", "name": "..." },
      "consumer": { "cdpConsumerId": "...", "firstName": "John", "lastName": "Smith", "email": "...", "phone": "..." },
      "vehicle": { "vin": "1HGCV1F34LA067890", "year": 2021, "make": "Jeep", "model": "Grand Cherokee", ... },
      "serviceHistory": [...],
      "recalls": [...],
      "ratings": { "expectedMileageForYear": 62000, "scheduledMaintenanceTotal": 16, "scheduledMaintenanceCompleted": 11, ... },
      "triggerEmail": true
    }

#### Internal: vss-microsite reads from DB (Prisma cross-schema query)
    
    
    // Single Prisma query across data.* and portal.* schemas at SSR render time
    const pageData = await prisma.vehicle.findFirst({
      where: {
        vin: params.vin,
        consumer: { id: params.consumerUuid }
      },
      include: {
        consumer: true,
        smartScore: true,
        serviceRecords: { orderBy: { serviceDate: 'desc' } },
        recalls: true,
        protectionProducts: { where: { isActive: true } },
      }
    });
    
    const dealerData = await prisma.dealer.findUnique({
      where: { slug: params.dealerSlug },
      include: { config: true }
    });
    
    // Upgrade vehicles fetched from Response Logix (external API)
    const upgradeVehicles = await responseLogix.getUpgrades({
      dealer: dealerData,
      consumer: pageData.consumer,
      vehicle: pageData,
    });

#### Internal: vss-portal → vss-email (REST for send actions only)
    
    
    POST http://vss-email.vss.svc.cluster.local:3000/api/email/send
    Authorization: Bearer <INTERNAL_JWT>
    
    { "consumerId": "uuid", "vin": "1HGCV1F34LA067890", "templateId": "uuid" }
    
    // Response: { "success": true, "messageId": "..." }

Section 12

## MVP Phasing & Task Breakdown

Phase 1

vss-microsite

Consumer-facing SSR pages. All sections from mockup. Direct DB reads across schemas via Prisma.

Phase 2

vss-portal

DAS-themed admin. Dealer CRUD, section toggles, content editing, branding, Azure AD SSO.

Phase 3

vss-data

Core data service. CDP ingest, scoring engine, Event Grid publisher. Other services read its schema directly.

Phase 4

vss-email

Templates, merge tags, CommunicationAPI client, Event Grid subscriber.

**Build order note:** Since all services read directly from the shared database, they can be developed in parallel as long as the Prisma schema/migrations are coordinated. vss-data should define its schema first since most services read from it. vss-email depends on vss-data events for auto-send. 

### Phase 1 — vss-microsite

#| Task| Output  
---|---|---  
1.1| Init Next.js + Tailwind + Docker| Scaffold, Dockerfile, CLAUDE.md  
1.2| Prisma client with cross-schema reads (data.*, portal.*)| Single query for all SSR page data  
1.3| SSR page shell `/[dealer]/[uuid]/[vin]`| Data fetch → conditional section render  
1.4| Header Bar component| Responsive, dealer-branded  
1.5| Owner & Vehicle Info section| Two-column, hero image  
1.6| Smart Score section + Rating Cards| 5 color-coded cards  
1.7| Service Dashboard section| Status cards, history table  
1.8| Protection Products section| 6-card grid + additional offers  
1.9| Response Logix API client| Typed client, sends dealer/consumer/vehicle data, returns upgrade vehicles  
1.10| Equity & Trade-In section| Equity card, loan viz, upgrade carousel (data from Response Logix)  
1.11| Footer + mobile responsiveness| All breakpoints tested  
  
### Phase 2 — vss-portal

#| Task| Output  
---|---|---  
2.1| Init Next.js + DAS tokens + Prisma (portal schema) + Docker| Scaffold with Satoshi, clementine palette  
2.2| NextAuth + Azure AD SSO + role middleware| Login flow, session with role  
2.3| Portal layout + DAS sidebar| Matching Storybook sidebar pattern  
2.4| Dashboard page| Stats cards, recent dealers  
2.5| Dealer CRUD + tabbed config| General, Branding, Sections, Content, Videos, Preview  
2.6| Consumer browser (calls vss-data)| Searchable table, expandable rows  
2.7| Email template editor (writes to email.* schema)| Subject + HTML editor, merge tags  
2.8| User management (Super Admin)| CRUD, role assignment  
2.9| Portal API routes + Blob upload| CRUD endpoints, asset upload, email send via vss-email REST  
  
### Phase 3 — vss-data

#| Task| Output  
---|---|---  
3.1| Init Node.js API + Prisma (data schema) + Docker| Scaffold, Dockerfile, CLAUDE.md  
3.2| CDP ingest endpoint + Zod validation| POST /api/data/ingest  
3.3| Upsert logic for all entities| Consumer, Vehicle, Records  
3.4| Score calculation engine + unit tests| scoring.ts with all 5 sub-ratings  
3.5| Event Grid publisher| score.calculated, consumer.ingested  
3.6| Batch ingest endpoint| POST /api/data/ingest/batch  
3.7| Seed data for development| Demo dealer + consumer + vehicle  
  
### Phase 4 — vss-email

#| Task| Output  
---|---|---  
4.1| Init Node.js API + Prisma (email schema) + Docker| Scaffold, Dockerfile, CLAUDE.md  
4.2| Email send API (for portal calls)| POST /api/email/send, /api/email/bulk-send  
4.3| Merge tag rendering engine| Template → rendered HTML  
4.4| CommunicationAPI client| Send function with retry  
4.5| Event Grid subscriber| Listen for score.calculated, read DB for merge data  
4.6| Email logging| Status tracking in email.EmailLog  
  
### Phase 5 — Infrastructure & Integration

#| Task| Output  
---|---|---  
5.1| K8s manifests (all 4 services)| Deployment, Service, HPA, ConfigMap per service  
5.2| Kong route configuration| Route rules for all 4 services  
5.3| Azure Event Grid topic + subscriptions| Topic creation, webhook endpoints  
5.4| CI/CD pipelines (per repo)| GitHub Actions: lint → test → build → push ACR → deploy AKS  
5.5| End-to-end integration testing| Full flow: ingest → score → email → microsite render
