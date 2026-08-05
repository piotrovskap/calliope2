-- ============================================================
-- DWRPT_AI — Schema DDL Dump
-- DAS Technology — Phase 0 Discovery
-- Researcher:      Alicia Salazar
-- Discovery date:  2026-06-14
-- Server:          40.83.161.93 (accessed as DataStaging;
--                  DWRPT_AI catalog on same instance is an
--                  identical replica accessible under a
--                  different login context)
-- Schemas:         13
-- Tables:          108
-- Views:           58  (42 in AI schema, 16 in core/dbo/dynamics/MLdata)
-- Total on-disk:   ~335 GB
-- Total rows:      ~891 M
-- Backup target:   Azure Blob (medialogixprodsqlstorage)
-- ============================================================
-- This is the central analytics data warehouse for DAS CDP.
-- It consolidates output from every major DAS product line
-- (3Birds/CDXP marketing, MediaLogix inventory, Response Logix
-- leads, Radar reputation, LotVantage YouTube, Dynamics 365 CRM,
-- Google My Business, Zuora billing) into a single read-heavy
-- reporting replica. The AI schema's 58 views are the primary
-- query surface for ai.das-technology.com.
-- ============================================================

-- ============================================================
-- SCHEMA: AI
-- LLM query log + all 58 BI tool views
-- ============================================================

-- Logs every natural-language query to ai.das-technology.com
-- with token accounting (input/output tokens per request)
CREATE TABLE [AI].[Log_Questions] (
    [Id]                         int          NOT NULL,  -- PK (CLUSTERED)
    [Question]                   varchar(MAX) NULL,      -- raw NL question text
    [Query]                      varchar(MAX) NULL,      -- generated SQL or view reference
    [NaturalResponse]            varchar(500) NULL,      -- LLM response text
    [RAGContext]                 varchar(MAX) NULL,      -- retrieval-augmented context
    [TotalRecords]               int          NULL,
    [QuestionDate]               datetime     NULL,
    [Status]                     varchar(50)  NULL,
    [ChartType]                  varchar(50)  NULL,
    [DatasetJson]                varchar(MAX) NULL,      -- serialised result set
    [ViewName]                   varchar(100) NULL,      -- which AI.v_* view was called
    [TotalInputTokensQuery]      int          NULL,
    [TotalOutputTokensQuery]     int          NULL,
    [TotalInputTokensResponse]   int          NULL,
    [TotalOutputTokensResponse]  int          NULL,
    [TotalInputTokensAnalytics]  int          NULL,
    [TotalOutputTokensAnalytics] int          NULL,
    [Error]                      varchar(MAX) NULL,
    [Insight]                    int          NULL,
    [AppInterface]               varchar(10)  NULL       -- 'web', 'api', etc.
);
-- 134 rows | <0.01 GB

-- User-annotated insights on query results
CREATE TABLE [AI].[Log_Questions_insights] (
    [IdInsights] int          NOT NULL,  -- PK (CLUSTERED)
    [Id]         int          NOT NULL,  -- FK -> AI.Log_Questions.Id
    [Title]      varchar(200) NOT NULL,
    [DatasetJson] varchar(MAX) NULL,
    [View]       varchar(200) NULL
);
-- 25 rows | <0.01 GB

-- ============================================================
-- SCHEMA: clientdb
-- Master client / dealer registry — universal tenant anchor
-- ============================================================

-- Authoritative cross-system client master; every tenant join
-- in this database should start here via CommonClientId.
CREATE TABLE [clientdb].[ClientConsolidated] (
    [CommonClientId]    int           NOT NULL,  -- universal tenant PK (INT)
    [DynamicsAccountId] varchar(36)   NULL,      -- D365 GUID (links dynamics.Account)
    [ClientName]        nvarchar(127) NOT NULL,
    [Street]            nvarchar(100) NULL,
    [City]              nvarchar(64)  NULL,
    [Province]          nvarchar(64)  NULL,
    [PostalCode]        nvarchar(32)  NULL,
    [CountryName]       nvarchar(100) NULL,
    [SiteUrl]           nvarchar(500) NULL
);
-- 93,007 rows | 0.02 GB

-- ============================================================
-- SCHEMA: CDXP
-- 3Birds / JuiceReporting marketing — 23 tables, 327 M rows
-- Richest PII source in the estate; primary CDP seed
-- ============================================================

-- Master contact table: four cross-system identity keys on one row + full PII
CREATE TABLE [CDXP].[JuiceReporting_BlueSkyOverview] (
    [ContactID]           int         NOT NULL,  -- 3Birds contact PK
    [ClientID]            int         NOT NULL,  -- FK -> clientdb.ClientConsolidated
    [EDW_DMS_Customer_ID] int         NULL,      -- DMS customer ID
    [RecipientID]         int         NULL,      -- email recipient ID
    [CRMID]               int         NULL,      -- CRM customer ID
    [EmailAddress]        varchar(255) NULL,     -- PII
    [FirstName]           varchar(255) NULL,     -- PII
    [LastName]            varchar(255) NULL,     -- PII
    [Address]             varchar(255) NULL,     -- PII
    [ZipCode]             varchar(255) NULL,
    [PhoneNumber]         varchar(255) NULL,     -- PII
    [ContactLat]          numeric(16,6) NULL,
    [ContactLong]         numeric(16,6) NULL,
    [LeadCreateDate]      date        NULL,
    [LeadSourceType]      varchar(255) NULL,
    [LeadStatusType]      varchar(255) NULL,
    [LeadSourceProvider]  varchar(255) NULL,
    [LinearDistanceToDealer] int      NULL,
    [IsSalesWQO]          bit         NULL,
    [IsServiceWQO]        bit         NULL,
    [DesiredVehicleMake]  varchar(255) NULL,
    [DesiredVehicleModel] varchar(255) NULL,
    [SaleDate]            date        NULL,
    [EDW_DMS_Vehicle_ID]  int         NULL,
    [CustomerType]        varchar(100) NULL,
    [LTVSegment]          varchar(100) NULL,
    [LastServiceDate]     date        NULL,
    [IsOwnedVehicle]      bit         NULL,
    [DealType]            varchar(100) NULL,
    [SaleType]            varchar(100) NULL,
    [LeaseEndDate]        date        NULL,
    [VehicleSoldDate]     date        NULL,
    [CommonClientID]      int         NULL       -- FK -> clientdb.ClientConsolidated (INT)
    -- ... +~120 additional columns (LTV scores, equity, vehicle history, CRM flags)
    -- See docs/databases/dwrpt-ai.md for full column list
);
-- 13,262,840 rows | 13.62 GB | CDP seed table — encrypt PII at ingest

-- Campaign engagement: sends, opens, clicks, unsubscribes per recipient
CREATE TABLE [CDXP].[JuiceReporting_Marketing_Summary] (
    [ClientID]       int          NOT NULL,
    [ClientName]     varchar(255) NOT NULL,
    [CampaignName]   varchar(255) NOT NULL,
    [CampaignId]     int          NOT NULL,
    [CampaignEventId] int         NOT NULL,
    [SendType]       varchar(20)  NULL,
    [SentDateTime]   datetime     NULL,
    [RecipientID]    int          NOT NULL,
    [IsDelivered]    bit          NOT NULL,
    [IsOpener]       bit          NOT NULL,
    [IsClicker]      bit          NOT NULL,
    [IsUnsubscriber] bit          NOT NULL,
    [TransactionType] varchar(7)  NULL,
    [TransactionDate] date        NULL,
    [CommonClientID] int          NULL
);
-- 49,152,011 rows | 11.69 GB

-- Campaign revenue attribution: email-to-sale matchback
CREATE TABLE [CDXP].[JuiceReporting_MatchBacks] (
    [ClientID]           int          NOT NULL,
    [ClientName]         varchar(255) NOT NULL,
    [CampaignID]         int          NOT NULL,
    [CampaignEventID]    int          NOT NULL,
    [RecipientID]        int          NOT NULL,
    [EDW_DMS_Customer_ID] int         NOT NULL,
    [TransactionType]    varchar(7)   NOT NULL,
    [FirstName]          varchar(255) NULL,
    [LastName]           varchar(255) NULL,
    [EmailAddress]       varchar(255) NULL,
    [TransactionDate]    date         NULL,
    [SalesRevenue]       float        NULL,
    [ServiceRevenue]     float        NULL,
    [CommonClientID]     int          NULL
);
-- 241,220 rows | 0.10 GB

-- Trade-in / equity data — GLBA-adjacent, treat as sensitive
CREATE TABLE [CDXP].[JuiceReporting_BSR_equity] (
    [ClientID]         int            NULL,
    [ClientName]       varchar(255)   NOT NULL,
    [FirstName]        varchar(255)   NULL,
    [LastName]         varchar(255)   NULL,
    [EmailAddress]     varchar(255)   NULL,
    [PhoneNumber]      varchar(255)   NULL,
    [VIN]              varchar(255)   NULL,      -- PII / GLBA
    [SoldDate]         datetime       NULL,
    [EstimatedMiles]   int            NULL,
    [EquityValueRough] decimal(25,2)  NULL,      -- GLBA-adjacent
    [EquityValueClean] decimal(26,2)  NULL,
    [RecipientID]      int            NULL,
    [CommonClientID]   int            NULL
);
-- 6,063,697 rows | 1.77 GB

-- Full marketing summary including email content (largest table: 47 GB)
CREATE TABLE [CDXP].[JuiceReporting_HiddenTable_MarketingSummary] (
    [ClientID]       int            NOT NULL,
    [ClientName]     varchar(255)   NOT NULL,
    [CampaignID]     int            NOT NULL,
    [CampaignName]   varchar(255)   NOT NULL,
    [EmailID]        int            NOT NULL,
    [SendType]       varchar(20)    NULL,
    [RecipientID]    int            NOT NULL,
    [EmailAddress]   nvarchar(250)  NULL,
    [FirstName]      nvarchar(4000) NULL,
    [LastName]       nvarchar(4000) NULL,
    [ZipCode]        nvarchar(4000) NULL,
    [IsUnsubscribed] bit            NULL,
    [IsOpener]       bit            NOT NULL,
    [IsClicker]      bit            NOT NULL,
    [TransactionDate] date          NULL,
    [OpenDate]       date           NULL,
    [CommonClientID] int            NULL
);
-- 118,073,500 rows | 47.35 GB — largest table in the database

-- Lead performance with source provider and conversion status
CREATE TABLE [CDXP].[JuiceReporting_LeadPerformance] (
    [ClientID]          int          NOT NULL,
    [ClientName]        varchar(255) NOT NULL,
    [LeadSourceProvider] varchar(255) NULL,
    [ContactID]         int          NOT NULL,
    [RecipientID]       int          NULL,
    [FirstName]         varchar(255) NULL,
    [LastName]          varchar(255) NULL,
    [ZipCode]           varchar(255) NULL,
    [PhoneNumber]       varchar(255) NULL,
    [EmailAddress]      varchar(255) NULL,
    [CRMID]             int          NULL,
    [LeadCreateDate]    date         NULL,
    [SaleDate]          date         NULL,
    [LeadStatusType]    varchar(255) NULL,
    [ContactType]       varchar(255) NULL,
    [IsConvertedLead]   int          NOT NULL,
    [CommonClientID]    int          NULL
);
-- 13,225,622 rows | 3.48 GB

-- Lead source index (leaner version of LeadPerformance)
CREATE TABLE [CDXP].[JuiceReporting_LeadPerformance_LeadSourceIndex] (
    [ClientID]          int          NOT NULL,
    [ClientName]        varchar(255) NOT NULL,
    [LeadSourceProvider] varchar(255) NULL,
    [ContactID]         int          NOT NULL,
    [RecipientID]       int          NULL,
    [EmailAddress]      varchar(255) NULL,
    [LeadCreateDate]    date         NULL,
    [SaleDate]          date         NULL,
    [IsConvertedLead]   int          NOT NULL,
    [CommonClientID]    int          NULL
);
-- 25,446,714 rows | 13.43 GB

-- Pre-computed attribution flags per contact + campaign
CREATE TABLE [CDXP].[mv_contact_stats] (
    [clientid]            int           NULL,
    [client_id]           int           NULL,
    [campaign_id]         int           NULL,
    [contact_id]          int           NULL,
    [contact_email]       nvarchar(255) NULL,
    [contact_phonenumber] nvarchar(15)  NULL,
    [contact_vin]         nvarchar(255) NULL,
    [contact_make]        nvarchar(255) NULL,
    [contact_model]       nvarchar(255) NULL,
    [contact_year]        int           NULL,
    [contact_zip]         nvarchar(255) NULL,
    [attribution_sales]   bit           NULL,
    [attribution_service] bit           NULL,
    [CommonClientID]      int           NULL
);
-- 15,394,147 rows | 15.13 GB

-- Service transaction history (v1)
CREATE TABLE [CDXP].[JuiceReporting_BlueSkyServicePerformance] (
    [EDW_DMS_Customer_ID]   int          NOT NULL,
    [ContactType]           varchar(255) NULL,
    [ClientID]              int          NOT NULL,
    [ClientName]            varchar(255) NOT NULL,
    [ZipCode]               varchar(255) NULL,
    [EDW_DMS_Transaction_ID] int         NOT NULL,
    [EDW_DMS_Vehicle_ID]    int          NULL,
    [TransactionTypeID]     int          NOT NULL,
    [TransactionDate]       datetime     NULL,
    [EDW_DMS_Service_ID]    int          NOT NULL,
    [RONumber]              varchar(255) NULL,
    [ROAmount]              float        NULL,
    [Make]                  varchar(255) NULL,
    [Model]                 varchar(255) NULL,
    [Year]                  varchar(255) NULL,
    [CommonClientID]        int          NULL
);
-- 8,095,604 rows | 4.67 GB

-- Service performance v2 (leaner schema)
CREATE TABLE [CDXP].[JuiceReporting_BlueSky_ServicePerf_V2] (
    [ContactType]          varchar(100) NULL,
    [ClientID]             int          NOT NULL,
    [ClientName]           varchar(255) NOT NULL,
    [ZipCode]              varchar(255) NULL,
    [CustomerType]         varchar(100) NULL,
    [IsOwnedVehicle]       bit          NULL,
    [EDW_DMS_Vehicle_ID]   int          NULL,
    [LastServiceDate]      date         NULL,
    [EDW_DMS_Customer_ID]  int          NULL,
    [crmid]                int          NULL,
    [RelevantContactFilter] int         NOT NULL,
    [OwnerName]            varchar(255) NULL,
    [OEMs]                 varchar(MAX) NULL,
    [CommonClientID]       int          NULL
);
-- 13,262,840 rows | 1.58 GB

-- Transaction overview linking campaign to revenue
CREATE TABLE [CDXP].[JuiceReporting_CDXPTransactionsOverview] (
    [ClientID]       int           NULL,
    [CampaignID]     int           NULL,
    [ClientName]     varchar(255)  NULL,
    [CampaignName]   varchar(255)  NULL,
    [SentDateTime]   datetime2     NULL,
    [TransactionType] varchar(20)  NULL,
    [Contact_ID]     int           NULL,
    [EmailAddress]   varchar(255)  NULL,
    [TransactionDate] datetime2    NULL,
    [SalesRevenue]   float         NULL,
    [ServiceRevenue] float         NULL,
    [CommonClientID] int           NULL
);
-- 15,635,367 rows | 5.42 GB

-- All unique CDXP contacts
CREATE TABLE [CDXP].[JuiceReporting_CDXPCustomers] (
    [ClientID]           int          NULL,
    [ClientName]         varchar(255) NOT NULL,
    [ContactType]        varchar(255) NULL,
    [FirstName]          varchar(255) NULL,
    [LastName]           varchar(255) NULL,
    [EmailAddress]       varchar(255) NULL,
    [ZipCode]            varchar(255) NULL,
    [PhoneNumber]        varchar(255) NULL,
    [RecipientID]        int          NULL,
    [EDW_DMS_Customer_ID] int         NULL,
    [EDW_DMS_Vehicle_ID] int          NULL,
    [CommonClientID]     int          NULL
);
-- 9,720,022 rows | 4.43 GB

-- Vehicle recommendations with contact info
CREATE TABLE [CDXP].[JuiceReporting_BlueSkyRecommendations] (
    [ClientID]        int          NULL,
    [ClientName]      varchar(255) NOT NULL,
    [ContactType]     varchar(255) NULL,
    [EDW_DMS_Customer_ID] int      NULL,
    [FirstName]       varchar(255) NULL,
    [LastName]        varchar(255) NULL,
    [HasEmail]        varchar(5)   NOT NULL,
    [EmailAddress]    varchar(255) NULL,
    [PhoneNumber]     varchar(255) NULL,
    [ZipCode]         varchar(255) NULL,
    [EDW_DMS_Vehicle_ID] int       NULL,
    [VehicleMake]     varchar(100) NULL,
    [VehicleModel]    varchar(100) NULL,
    [LastServiceDate] date         NULL,
    [OwnerName]       varchar(255) NULL,
    [OEMs]            varchar(MAX) NULL,
    [CommonClientID]  int          NULL
);
-- 6,666,942 rows | 2.81 GB

-- Contacts for data mining / export
CREATE TABLE [CDXP].[JuiceReporting_DataMiningTool] (
    [ClientID]       int          NOT NULL,
    [ClientType]     varchar(255) NOT NULL,
    [ContactType]    varchar(255) NOT NULL,
    [EmailAddress]   varchar(255) NULL,
    [FirstName]      varchar(255) NULL,
    [LastName]       varchar(255) NULL,
    [ZipCode]        varchar(255) NULL,
    [LastVehicleMake]  varchar(255) NULL,
    [LastVehicleModel] varchar(255) NULL,
    [LastVehicleYear]  varchar(255) NULL,
    [LTVScore]       varchar(255) NULL,
    [CommonClientID] int          NULL
);
-- 4,706,750 rows | 1.58 GB

-- Transaction summary counts by type per dealer per date
CREATE TABLE [CDXP].[JuiceReporting_TRANSACTION_SUMMARY] (
    [ClientID]          int          NOT NULL,
    [ClientName]        varchar(255) NOT NULL,
    [TransactionDate]   datetime     NULL,
    [Total_transactions] int         NOT NULL,
    [TransactionType]   varchar(7)   NOT NULL,
    [gross]             float        NULL,
    [InsertDate]        datetime     NOT NULL,
    [CommonClientID]    int          NULL
);
-- 7,790,566 rows | 0.78 GB

-- Contact engagement link clicks
CREATE TABLE [CDXP].[JuiceReporting_Marketing_Summary_Contact_eng] (
    [ClientID]        int          NOT NULL,
    [CampaignID]      int          NOT NULL,
    [CampaignEventID] int          NOT NULL,
    [RecipientID]     int          NOT NULL,
    [ClientLinkID]    int          NOT NULL,
    [LinkCategory]    varchar(255) NULL,
    [CommonClientAPIId] int        NULL
);
-- 1,131,789 rows | 0.38 GB

-- BlueSkyOverview v2 (transaction-level, no PII)
CREATE TABLE [CDXP].[JuiceReporting_BlueSkyOverview_v2] (
    [ClientID]                int          NOT NULL,
    [EDW_DMS_Transaction_ID]  int          NOT NULL,
    [EDW_DMS_Customer_ID]     int          NOT NULL,
    [EDW_DMS_Vehicle_ID]      int          NULL,
    [TransactionTypeID]       int          NOT NULL,
    [TransactionDate]         datetime     NULL,
    [ROAmount]                float        NULL,
    [OwnerName]               varchar(255) NULL,
    [OEMs]                    varchar(MAX) NULL,
    [CommonClientID]          int          NULL
);
-- 10,779,160 rows | 0.79 GB

-- Unsubscribes, bounces, and opt-out events
CREATE TABLE [CDXP].[JuiceReporting_RecipientLoss] (
    [ClientID]    int            NOT NULL,
    [ClientName]  varchar(255)   NULL,
    [WhenEastern] datetime       NULL,
    [EmailAddress] nvarchar(250) NOT NULL,
    [FirstName]   nvarchar(4000) NULL,
    [LastName]    nvarchar(4000) NULL,
    [Action]      varchar(14)    NOT NULL,  -- 'unsubscribed', 'bounced', etc.
    [CommonClientID] int         NULL
);
-- 8,661,265 rows | 1.51 GB

-- Active leads currently in pipeline
CREATE TABLE [CDXP].[JuiceReportingBlueSkyCurrentLeads] (
    [ClientID]           int          NOT NULL,
    [ClientName]         varchar(255) NOT NULL,
    [EDW_DMS_Customer_ID] int         NULL,
    [RecipientID]        int          NULL,
    [ContactID]          int          NOT NULL,
    [EmailAddress]       varchar(255) NULL,
    [ContactType]        varchar(255) NULL,
    [LeadCreateDate]     date         NULL,
    [ZipCode]            varchar(255) NULL,
    [PhoneNumber]        varchar(255) NULL,
    [DesiredVehicleMake] varchar(255) NULL,
    [DesiredVehicleModel] varchar(255) NULL,
    [EDW_DMS_Vehicle_ID] int          NULL,
    [CommonClientAPIId]  int          NULL
);
-- 358,318 rows | 0.12 GB

-- Campaign-level send/delivery/open/click/matchback summary
CREATE TABLE [CDXP].[JuiceReporting_NEW_RECIPIENTS] (
    [ClientID]         int          NOT NULL,
    [ClientName]       varchar(255) NOT NULL,
    [CampaignID]       int          NOT NULL,
    [CampaignEventID]  int          NOT NULL,
    [SendType]         varchar(13)  NOT NULL,
    [SentDateTime]     datetime     NULL,
    [TotalDelivered]   int          NOT NULL,
    [UniqueOpens]      int          NOT NULL,
    [UniqueClicks]     int          NOT NULL,
    [SalesInfluences]  int          NULL,
    [ServiceInfluences] int         NULL,
    [InsertDate]       datetime     NOT NULL,
    [CommonClientID]   int          NULL
);
-- 9,593 rows | <0.01 GB

-- Marketing performance by campaign event
CREATE TABLE [CDXP].[JuiceReporting_MarketingPerformance] (
    [CampaignEventID]  int          NULL,
    [ClientID]         int          NULL,
    [ProductName]      varchar(100) NULL,
    [SendType]         varchar(100) NULL,
    [Subject]          varchar(500) NULL,
    [SentDateTime]     datetime     NULL,
    [ContactAttempts]  int          NULL,
    [Deliveries]       int          NULL,
    [UniqueOpens]      int          NULL,
    [UniqueClicks]     int          NULL,
    [Unsubscribes]     int          NULL,
    [SalesMatchbacks]  int          NULL,
    [ServiceMatchbacks] int         NULL,
    [CommonClientAPIId] int         NULL
);
-- 6,919 rows | <0.01 GB

-- Dealer details including address and CIM feed config
CREATE TABLE [CDXP].[ClientDetails] (
    [ClientDetailsID]  int          NOT NULL,
    [ClientID]         int          NOT NULL,
    [StreetAddress1]   varchar(MAX) NULL,
    [StreetAddress2]   varchar(250) NULL,
    [City]             varchar(250) NOT NULL,
    [State]            varchar(50)  NOT NULL,
    [PostalCode]       varchar(50)  NULL,
    [PhoneNumber]      varchar(50)  NOT NULL,
    [FullSiteURL]      varchar(MAX) NOT NULL,
    [CreateDate]       datetime     NOT NULL,
    [ModifyDate]       datetime     NOT NULL,
    [Version]          int          NOT NULL,
    [OemID]            int          NULL,
    [Latitude]         varchar(20)  NULL,
    [Longitude]        varchar(20)  NULL,
    [CountryCode]      char(2)      NOT NULL,
    [CommonClientAPIId] int         NULL,
    [CIMFeedId]        int          NULL
);
-- 32,538 rows | 0.01 GB

-- ZIP code to lat/lon lookup for geo queries
CREATE TABLE [CDXP].[Juice_ZipCode_Geo] (
    [zip_code]     varchar(10)   NULL,
    [city]         varchar(2048) NULL,
    [county]       varchar(255)  NULL,
    [state_name]   varchar(255)  NULL,
    [latitude]     float         NULL,
    [Longitude]    float         NULL,
    [geometry_str] varchar(MAX)  NULL
);
-- 33,113 rows | 0.05 GB

-- ============================================================
-- SCHEMA: core
-- Radar / ReviewRocket staging — 30 tables, 244 M rows
-- Review ingestion, surveys, sentiment, social ads
-- ============================================================

-- Account registry: Radar/ReviewRocket identity linked to CCI
CREATE TABLE [core].[Stage_Accounts] (
    [Id]           int             NOT NULL,  -- CIX (CLUSTERED) on Id
    [Name]         varchar(255)    NULL,
    [Token]        uniqueidentifier NOT NULL, -- Radar/ReviewRocket identity key (GUID)
    [CommonClientId] int           NULL,      -- FK -> clientdb.ClientConsolidated
    [Deleted]      bit             NOT NULL   -- soft deletes in use
);
-- 165,485 rows | 0.05 GB
-- Indexes: CIX on Id; NONCLUSTERED on (Token, Deleted); (Id, Deleted)

-- Physical address per account
CREATE TABLE [core].[Stage_Addresses] (
    [Id]         int            NOT NULL,
    [Street]     nvarchar(255)  NULL,
    [City]       nvarchar(100)  NULL,
    [State]      varchar(50)    NULL,
    [PostalCode] varchar(20)    NULL,
    [AccountId]  int            NULL  -- FK -> Stage_Accounts.Id
);
-- 164,722 rows | 0.01 GB

-- Account parent-child hierarchy
CREATE TABLE [core].[Stage_AccountHierarchy] (
    [Id]            int NOT NULL,
    [ParentAccountId] int NULL,
    [ChildAccountId]  int NULL,
    [HierarchyId]   int NOT NULL
);
-- 3,322 rows | <0.01 GB

-- Review ingestion (main — all time; 35 GB)
CREATE TABLE [core].[Stage_Review] (
    [Id]           int            NOT NULL,  -- CIX on Created
    [AccountId]    int            NULL,      -- FK -> Stage_Accounts.Id
    [ReviewSiteId] int            NOT NULL,
    [ReviewScore]  decimal(18,0)  NULL,
    [ReviewerName] nvarchar(200)  NULL,
    [ReviewDate]   datetime       NULL
    -- NB: AccountGuid implied by indexes; not in schema dump
);
-- 14,628,458 rows | 35.15 GB

-- Review ingestion 2024 window
CREATE TABLE [core].[Stage_Review2024] (
    [Id]           int NOT NULL,
    [AccountId]    int NULL,
    [ReviewSiteId] int NOT NULL,
    [ReviewDate]   datetime NULL
);
-- 424,534 rows | 0.36 GB

-- Review ingestion 4M window
CREATE TABLE [core].[Stage_Review4M] (
    [Id]           int NOT NULL,
    [AccountId]    int NULL,
    [ReviewSiteId] int NOT NULL
);
-- 182,119 rows | 0.15 GB

-- Review category tagging
CREATE TABLE [core].[Stage_ReviewCategory] (
    [ReviewId]   int NOT NULL,  -- FK -> Stage_Review.Id
    [CategoryId] int NOT NULL   -- FK -> Stage_Category.Id
);
-- 3,744,698 rows | 0.14 GB

-- AI-generated sentiment labels per review
CREATE TABLE [core].[Stage_ReviewSentiment] (
    [SentimentId]       bigint      NOT NULL,  -- PK
    [ReviewId]          int         NOT NULL,
    [ai_sentiment_label] varchar(10) NOT NULL  -- 'positive', 'negative', 'neutral'
);
-- 5 rows | <0.01 GB

-- Detailed sentiment sub-labels
CREATE TABLE [core].[Stage_ReviewSentimentDetail] (
    [DetailId]       bigint      NOT NULL,  -- PK
    [SentimentId]    bigint      NOT NULL,  -- FK -> Stage_ReviewSentiment
    [detail_type]    varchar(20) NOT NULL,
    [sentiment_label] varchar(10) NULL
);
-- 10 rows | <0.01 GB

-- Reference: review site lookup
CREATE TABLE [core].[Stage_ReviewSite] (
    [Id]   int           NOT NULL,
    [Name] nvarchar(50)  NULL
);
-- 30 rows | <0.01 GB

-- Reference: review source lookup
CREATE TABLE [core].[Stage_ReviewSource] (
    [Id]   int          NOT NULL,
    [Name] nvarchar(50) NULL
);
-- 11 rows | <0.01 GB

-- Reference: category lookup
CREATE TABLE [core].[Stage_Category] (
    [Id]   int           NOT NULL,
    [Name] nvarchar(50)  NOT NULL
);
-- 2 rows | <0.01 GB

-- Survey sends (main — 78 M rows; 19 GB)
CREATE TABLE [core].[Stage_Surveys] (
    [Id]        int         NOT NULL,  -- CIX on SentDate; NONCLUSTERED on (Id, SentDate)
    [AccountId] int         NULL,
    [SentDate]  datetime    NULL,
    [Type]      varchar(10) NULL,
    [Vin]       varchar(20) NULL,
    [Email]     varchar(100) NULL
);
-- 78,577,255 rows | 18.79 GB

-- Survey responses (NPS + rating)
CREATE TABLE [core].[Stage_SurveyResponse] (
    [Id]           int      NOT NULL,
    [SurveyId]     int      NOT NULL,  -- CIX on SurveyId
    [ResponseDate] datetime NOT NULL,
    [NPSScore]     int      NULL,
    [Rating]       int      NULL
);
-- 7,357,723 rows | 2.13 GB

-- Survey history events
CREATE TABLE [core].[Stage_SurveyHistory] (
    [id]       int NOT NULL,
    [SurveyId] int NOT NULL   -- CIX on ActionTime (implied)
);
-- 82,826,920 rows | 2.79 GB

-- Transactions (billing/service events) per account
CREATE TABLE [core].[Stage_Txns] (
    [TxnId]       int              NOT NULL,
    [AccountToken] uniqueidentifier NOT NULL,  -- FK -> Stage_Accounts.Token
    [TxnDate]     datetime         NOT NULL    -- CIX on TxnDate
);
-- 55,184,247 rows | 2.28 GB

-- Transaction type reference
CREATE TABLE [core].[Stage_TxnTypes] (
    [TxnTypeId] smallint     NOT NULL,
    [TxnType]   varchar(100) NOT NULL
);
-- 2 rows | <0.01 GB

-- MRS review request sends
CREATE TABLE [core].[Stage_MRSReviewRequest] (
    [Id]       int              NOT NULL,
    [ClientId] uniqueidentifier NOT NULL,
    [SentDate] datetime         NOT NULL
);
-- 128,453 rows | 0.02 GB

-- MRS notification delivery log
CREATE TABLE [core].[Stage_MRSReviewRequestNotification] (
    [Id]              int              NOT NULL,
    [NotificationId]  uniqueidentifier NOT NULL,
    [ReviewRequestId] uniqueidentifier NOT NULL
);
-- 124,791 rows | 0.06 GB

-- Social ad campaign windows per Radar account
CREATE TABLE [core].[Stage_SocialAdsCampaign] (
    [Id]          int              NOT NULL,
    [AccountGuid] uniqueidentifier NOT NULL,
    [Name]        varchar(255)     NOT NULL,
    [StartDate]   datetime         NULL,
    [EndDate]     datetime         NULL
);
-- 22,857 rows | 0.04 GB

-- Product inventory feed nodes per account
CREATE TABLE [core].[Stage_ProductInventoryInternalFeedNodes] (
    [NodeId]      uniqueidentifier NOT NULL,
    [ClientId]    uniqueidentifier NOT NULL,
    [ProductCode] nvarchar(5)      NOT NULL
);
-- 5,714 rows | <0.01 GB

-- Denormalised review view (flattened with AccountName + CCI)
CREATE TABLE [core].[t_Reviews] (
    [Id]           int           NOT NULL,
    [AccountName]  varchar(255)  NULL,
    [CommonClientId] int         NULL,
    [ReviewSite]   nvarchar(100) NULL,
    [ReviewScore]  decimal(9,1)  NULL,
    [ReviewDate]   datetime      NULL
    -- Indexed on PublicationDate, ReviewSite, State, AccountGuid, AccountName, CommonClientId
);
-- 204,624 rows | 0.16 GB

-- Denormalised survey view (0 rows — possibly disabled ETL)
CREATE TABLE [core].[t_Surveys] (
    [Id]           int         NOT NULL,
    [AccountName]  varchar(255) NULL,
    [CommonClientId] int       NULL,
    [Type]         varchar(10) NULL,
    [SentDate]     datetime    NULL,
    [NPSScore]     int         NULL,
    [Rating]       int         NULL
);
-- 0 rows | 0.12 GB (allocated but empty)

-- ReviewRocket configuration and workflow tables
CREATE TABLE [core].[ReviewRocketConfiguration] (
    [Id]           int              NOT NULL,
    [ClientId]     uniqueidentifier NOT NULL,
    [EmailAddress] varchar(100)     NOT NULL,
    [Active]       bit              NOT NULL,
    [ActivateDate] datetime         NOT NULL
);
-- 497 rows | <0.01 GB

CREATE TABLE [core].[ReviewRocketDealerSite] (
    [Id]           int              NOT NULL,
    [ClientId]     uniqueidentifier NOT NULL,
    [ReviewSiteId] int              NOT NULL,
    [Active]       bit              NOT NULL
);
-- 730 rows | <0.01 GB

CREATE TABLE [core].[ReviewRocketQuestion] (
    [Id]       int              NOT NULL,
    [ClientId] uniqueidentifier NOT NULL,
    [Type]     varchar(100)     NOT NULL,
    [Active]   bit              NOT NULL
);
-- 5,426 rows | <0.01 GB

CREATE TABLE [core].[ReviewRocketQuestionOption] (
    [Id]                   int          NOT NULL,
    [ReviewRocketQuestionId] int        NOT NULL,
    [OptionText]           varchar(MAX) NOT NULL
);
-- 2,522 rows | <0.01 GB

CREATE TABLE [core].[ReviewRocketSurvey] (
    [Id]       int              NOT NULL,
    [ClientId] uniqueidentifier NOT NULL,
    [SentDate] datetimeoffset   NOT NULL,  -- CIX on SentDate
    [Type]     varchar(10)      NULL,
    [Vin]      varchar(20)      NULL,
    [Email]    varchar(100)     NULL
);
-- 389,522 rows | 0.06 GB

CREATE TABLE [core].[ReviewRocketSurveyResponse] (
    [Id]              int      NOT NULL,
    [ReviewRocketId]  int      NOT NULL,
    [ResponseDate]    datetime NOT NULL   -- CIX on ResponseDate
);
-- 57,824 rows | 0.01 GB

CREATE TABLE [core].[ReviewRocketClickSite] (
    [Id]           int              NOT NULL,
    [ClientId]     uniqueidentifier NOT NULL,
    [ReviewSiteId] int              NOT NULL,
    [VisitedDate]  datetime         NOT NULL
);
-- 103 rows | <0.01 GB

-- ============================================================
-- SCHEMA: dynamics
-- Dynamics 365 CRM — 4 tables, 225 K rows
-- ============================================================

CREATE TABLE [dynamics].[Account] (
    [accountid]              uniqueidentifier NOT NULL,  -- D365 GUID
    [name]                   nvarchar(200)    NULL,
    [das_3birdsid]           nvarchar(50)     NULL,
    [address1_city]          nvarchar(100)    NULL,
    [address1_stateorprovince] nvarchar(100)  NULL,
    [telephone1]             nvarchar(50)     NULL,
    [websiteurl]             nvarchar(500)    NULL,
    [CommonClientId]         int              NULL       -- FK -> clientdb.ClientConsolidated
);
-- 43,518 rows | 0.03 GB

CREATE TABLE [dynamics].[Account_Lookup] (
    [accountid]        uniqueidentifier NOT NULL,  -- CIX (unique)
    [oems]             nvarchar(250)    NULL,
    [ownername]        nvarchar(255)    NULL,
    [CommonClientId]   int              NULL
);
-- 43,518 rows | 0.01 GB

CREATE TABLE [dynamics].[OptionSet] (
    [objecttypecode]  nvarchar(100) NOT NULL,
    [attributename]   nvarchar(100) NOT NULL,
    [attributevalue]  int           NOT NULL,
    [value]           nvarchar(250) NULL
);
-- 60 rows | <0.01 GB

CREATE TABLE [dynamics].[SalesOrderDetail] (
    [salesorderdetailid]      uniqueidentifier NOT NULL,
    [netwoven_account]        uniqueidentifier NULL,  -- FK -> Account.accountid
    [productname]             nvarchar(500)    NULL,
    [netwoven_startdate]      datetime         NULL,
    [netwoven_status]         int              NULL,
    [netwoven_cancellationdate] datetime       NULL
);
-- 138,278 rows | 0.03 GB

-- ============================================================
-- SCHEMA: Google
-- Google My Business — 2 tables, 22 M rows
-- No CommonClientID; join via DASID (mapping TBD)
-- ============================================================

-- GBP dealership-level weekly performance
CREATE TABLE [Google].[DealershipDataFile] (
    [WindowDate]          varchar(50)  NULL,
    [DealershipName]      varchar(255) NULL,
    [PlaceID]             varchar(255) NULL,
    [GoogleVDPImpressions] varchar(255) NULL,
    [DealerVDPClicks]     int          NULL,
    [Calls]               int          NULL,
    [ZipCode]             varchar(10)  NULL,
    [DASID]               varchar(255) NULL,  -- external dealer ID (no CCI mapping found)
    [DateWeek]            datetime     NULL
);
-- 1,046,409 rows | 0.30 GB

-- GBP vehicle-level VDP clicks
CREATE TABLE [Google].[VehicleDataFile] (
    [WindowDate]      varchar(50)  NULL,
    [DealershipName]  varchar(255) NULL,
    [PlaceID]         varchar(255) NULL,
    [VIN]             varchar(255) NULL,
    [Vehicle]         varchar(255) NULL,
    [DealerVDPClicks] int          NULL,
    [ZipCode]         varchar(10)  NULL,
    [DASID]           varchar(255) NULL
);
-- 21,202,024 rows | 6.49 GB

-- ============================================================
-- SCHEMA: juice
-- Consolidated reviews — 1 table, 175 K rows
-- ============================================================

-- Cross-source review consolidation; cleanest review data
CREATE TABLE [juice].[Review] (
    [Id]             int           NOT NULL,  -- CIX on Id
    [ReviewSourceName] nvarchar(50) NULL,
    [AccountName]    nvarchar(255) NULL,
    [CommonClientId] int           NULL,      -- FK -> clientdb.ClientConsolidated
    [ReviewSiteId]   int           NOT NULL,
    [ReviewScore]    decimal(18,0) NULL,
    [ReviewerName]   nvarchar(200) NULL,
    [ReviewDate]     datetime      NULL
);
-- 175,437 rows | 0.16 GB

-- ============================================================
-- SCHEMA: LVData
-- LotVantage / YouTube video performance — 5 tables, 4.5 M rows
-- No CommonClientID; join via dealership_id (mapping TBD)
-- ============================================================

CREATE TABLE [LVData].[youtube_settings] (
    [id]            int          NOT NULL,
    [dealership_id] int          NULL,  -- dealer identifier (not CCI — confirm mapping)
    [channel]       varchar(255) NULL
);
-- 6,098 rows | <0.01 GB

CREATE TABLE [LVData].[youtube_videos] (
    [id]            int          NOT NULL,
    [vehicle_id]    int          NULL,
    [dealership_id] int          NULL,
    [url]           varchar(255) NULL,
    [external_id]   varchar(255) NULL,
    [status]        varchar(10)  NULL
);
-- 2,981,115 rows | 1.23 GB

CREATE TABLE [LVData].[youtube_video_stats] (
    [id]               int NOT NULL,
    [youtube_video_id] int NOT NULL,
    [view_count]       int NOT NULL
);
-- 616,372 rows | 0.04 GB

CREATE TABLE [LVData].[youtube_video_daily_stats] (
    [id]               int  NOT NULL,
    [youtube_video_id] int  NOT NULL,
    [date]             date NOT NULL,
    [view_count]       int  NOT NULL
);
-- 3 rows | <0.01 GB

CREATE TABLE [LVData].[youtube_voice_recordings] (
    [id]          int           NOT NULL,
    [vehicle_id]  int           NOT NULL,
    [external_id] varchar(255)  NULL,
    [status]      nvarchar(255) NULL
);
-- 960,173 rows | 0.74 GB

-- ============================================================
-- SCHEMA: MLdata
-- MediaLogix inventory + advertising — 23 tables, 209 M rows
-- ============================================================

-- AdEz campaign registry
CREATE TABLE [MLdata].[__AllAdEzCampaigns] (
    [cmp_id]     bigint       NULL,
    [adv_id]     bigint       NULL,
    [adv_acc_id] bigint       NULL,
    [adv_name]   varchar(128) NULL,
    [sub_name]   varchar(256) NULL,
    [Start_Date] date         NULL,
    [End_Date]   date         NULL,
    [price_paid] money        NULL,
    [sub_status] varchar(16)  NULL,
    [cmp_status] varchar(16)  NULL
);
-- 17,794 rows | 0.01 GB

-- AdEz flight pricing
CREATE TABLE [MLdata].[_AllFlights] (
    [sf_id]             bigint      NULL,
    [cmp_id]            bigint      NULL,
    [adv_id]            bigint      NULL,
    [adv_acc_id]        bigint      NULL,
    [flight_start_date] date        NULL,
    [flight_end_date]   date        NULL,
    [flight_price]      money       NULL,
    [flight_status]     varchar(32) NULL
);
-- 48,978 rows | 0.02 GB

-- MediaLogix account master
CREATE TABLE [MLdata].[Account] (
    [acc_ID]           int          NOT NULL,
    [acc_Login]        varchar(128) NOT NULL,
    [acc_Company]      varchar(64)  NOT NULL,
    [acc_Email_String] varchar(128) NOT NULL,
    [acc_Phone]        varchar(16)  NOT NULL,
    [acc_City]         varchar(64)  NOT NULL,
    [acc_State]        varchar(2)   NOT NULL,
    [zip_Code]         varchar(10)  NOT NULL
);
-- 2,082,770 rows | 0.49 GB

-- Display ad clicks/impressions/cost by date
CREATE TABLE [MLdata].[Display] (
    [dis_ID]       int    NOT NULL,
    [iml_ID]       int    NOT NULL,
    [dis_Date]     date   NOT NULL,
    [rcd_Master_ID] bigint NULL,
    [dis_Clicks]   int    NOT NULL,
    [dis_Impressions] int NOT NULL,
    [dis_Cost]     money  NOT NULL
);
-- 3,917,269 rows | 0.80 GB

-- Live inventory feed: VIN-level listing ads (33 GB)
CREATE TABLE [MLdata].[FEEDADS] (
    [faUID]    int          NOT NULL,
    [fdPUBID]  int          NOT NULL,
    [fdEDID]   int          NOT NULL,
    [faVIN]    varchar(64)  NOT NULL,  -- IX on faVIN
    [faADNUM]  int          NOT NULL,
    [faYEAR]   smallint     NULL,
    [faMAKE]   varchar(32)  NULL,
    [faMODEL]  varchar(128) NULL,
    [faPRICE]  money        NULL,
    [faACTIVE] bit          NOT NULL,
    [fdUID]    int          NULL
);
-- 8,030,440 rows | 33.60 GB

-- Feed dealer registry
CREATE TABLE [MLdata].[FEEDDEALERS] (
    [fdUID]         int          NOT NULL,
    [fdCUSID]       int          NOT NULL,
    [fdNAME]        varchar(64)  NOT NULL,
    [fdEMAIL_STRING] varchar(96) NOT NULL,
    [fdSTATE]       varchar(2)   NOT NULL,
    [fdZIP]         varchar(10)  NOT NULL
);
-- 22,800 rows | <0.01 GB

-- SRP action events (grail version — 98 M rows; 15.5 GB)
CREATE TABLE [MLdata].[grail_srpactions_daily] (
    [event_date]      date   NOT NULL,
    [acc_id]          int    NOT NULL,
    [subscription_id] int    NOT NULL,
    [lst_id]          int    NOT NULL,  -- listing ID
    [app_action]      int    NOT NULL,
    [is_bot]          bit    NOT NULL,
    [action_count]    bigint NOT NULL
    -- 4 covering indexes on lst_id/event_date variants
);
-- 98,852,570 rows | 15.52 GB

-- Google Vehicle Ads campaign stats
CREATE TABLE [MLdata].[GVACampaignDataset] (
    [rpt_date]      date         NOT NULL,
    [cmp_id]        bigint       NULL,
    [campaign_name] varchar(256) NULL,
    [clicks]        int          NOT NULL,
    [impressions]   int          NOT NULL,
    [cost]          money        NOT NULL
);
-- 144,247 rows | 0.02 GB

-- GVA VDP-level data (v1)
CREATE TABLE [MLdata].[GVAVDPData] (
    [gva_date]    int          NOT NULL,
    [client_id]   bigint       NULL,
    [client_name] varchar(1024) NULL,
    [campaign_id] bigint       NULL,
    [impressions] int          NOT NULL,
    [clicks]      int          NOT NULL,
    [fauid]       int          NULL
);
-- 5,994,636 rows | 1.46 GB

-- GVA VDP-level data (v2; with VIN)
CREATE TABLE [MLdata].[GVAVDPDatav2] (
    [gva_date]    int          NOT NULL,
    [client_id]   bigint       NULL,
    [campaign_id] bigint       NULL,
    [impressions] int          NOT NULL,
    [clicks]      int          NOT NULL,
    [fauid]       int          NULL,
    [veh_vin]     varchar(17)  NULL,
    [lst_id]      int          NULL
);
-- 15,860,196 rows | 3.19 GB

-- ETL import audit log
CREATE TABLE [MLdata].[ImportLog] (
    [iml_ID]        int          NOT NULL,
    [dsr_ID]        int          NOT NULL,
    [ims_ID]        int          NOT NULL,
    [iml_Created]   datetime     NOT NULL,
    [iml_Completed] datetime     NULL,
    [acc_ID]        int          NOT NULL,
    [iml_FileName]  varchar(256) NOT NULL,
    [iml_StartDate] date         NOT NULL,
    [iml_EndDate]   date         NOT NULL
);
-- 10,634 rows | <0.01 GB

-- Inbound leads from listing clicks (PII: name, email, phone)
CREATE TABLE [MLdata].[LeadQueue] (
    [ldq_ID]            int          NOT NULL,
    [lst_ID]            int          NOT NULL,  -- FK -> Listing
    [ldq_Created]       datetime     NOT NULL,
    [ldq_FromMail]      varchar(256) NOT NULL,
    [ldq_FromFirstName] varchar(64)  NOT NULL,
    [ldq_FromLastName]  varchar(64)  NOT NULL,
    [ldq_FromZipCode]   varchar(5)   NOT NULL,
    [ldq_FromPhone]     varchar(16)  NOT NULL
);
-- 204,612 rows | 0.21 GB

-- Active listing registry (24 GB)
CREATE TABLE [MLdata].[Listing] (
    [lst_ID]        int      NOT NULL,
    [acc_ID]        int      NULL,       -- FK -> Account
    [lst_Price]     money    NOT NULL,
    [lss_ID]        int      NOT NULL,
    [lst_Created]   datetime NOT NULL,
    [lst_Modified]  datetime NOT NULL,
    [lst_LastUpload] datetime NULL       -- used for incremental ETL delta
);
-- 7,428,822 rows | 23.81 GB

-- Vehicle details per listing
CREATE TABLE [MLdata].[ListingVehicle] (
    [lst_id]     int          NOT NULL,
    [veh_vin]    varchar(32)  NULL,
    [veh_year]   varchar(4)   NULL,
    [veh_make]   varchar(64)  NULL,
    [veh_model]  varchar(64)  NULL,
    [veh_status] varchar(32)  NULL,
    [veh_mileage] varchar(32) NULL
);
-- 7,815,616 rows | 3.47 GB

-- ML account to CommonClientId bridge (VARCHAR — type mismatch with CCI INT)
CREATE TABLE [MLdata].[ML_Account_Info] (
    [acc_id]          int          NULL,
    [core_client_id]  varchar(50)  NULL,
    [common_client_id] varchar(50) NULL,  -- VARCHAR(50) — CAST to INT required
    [acc_company]     varchar(100) NULL,
    [acc_state]       varchar(2)   NULL,
    [zip_Code]        varchar(10)  NULL,
    [sfdc_account_id] varchar(50)  NULL
);
-- 6,159 rows | <0.01 GB

-- ML account ID cross-walk
CREATE TABLE [MLdata].[MLCommonClientIdMapping] (
    [acc_id]          int         NOT NULL,
    [sales_channel_id] int        NOT NULL,
    [ref_id]          varchar(50) NOT NULL,
    [client_id]       varchar(50) NULL
);
-- 6,163 rows | <0.01 GB

-- PlatformAuto campaign performance
CREATE TABLE [MLdata].[PlatformAuto_Campaigns] (
    [plc_id]     bigint NOT NULL,
    [acc_id]     bigint NOT NULL,
    [pla_dlr_id] bigint NOT NULL,
    [cmp_id]     bigint NOT NULL,
    [plc_date]   int    NOT NULL,
    [local_views] int   NOT NULL,
    [srp_visits] int    NOT NULL,
    [vdp_views]  int    NOT NULL,
    [plc_cost]   float  NOT NULL
);
-- 1,104,704 rows | 0.14 GB

-- PlatformAuto SRP/VDP impressions per VIN (31 M rows)
CREATE TABLE [MLdata].[PlatformAuto_Stats] (
    [pls_id]         bigint      NOT NULL,
    [pls_date]       int         NOT NULL,
    [veh_vin]        varchar(17) NOT NULL,
    [pla_dlr_id]     bigint      NOT NULL,
    [acc_id]         bigint      NOT NULL,
    [srp_impressions] int        NOT NULL,
    [vdp_impressions] int        NOT NULL
);
-- 31,776,870 rows | 4.03 GB

-- Legacy SRP actions (0 rows — likely superseded by grail_srpactions_daily)
CREATE TABLE [MLdata].[srpactions_daily] (
    [event_date]  date   NULL,
    [acc_id]      int    NULL,
    [lst_id]      int    NULL,
    [app_action]  int    NOT NULL,
    [action_count] bigint NOT NULL
);
-- 0 rows | 0 GB

-- VDP performance by account/date
CREATE TABLE [MLdata].[VDPPerformance] (
    [acc_id]      bigint NOT NULL,
    [dsr_id]      int    NOT NULL,
    [vdp_date]    int    NOT NULL,
    [impressions] int    NOT NULL,
    [clicks]      int    NOT NULL,
    [vdp_views]   int    NOT NULL,
    [cost]        float  NOT NULL
);
-- 1,060,205 rows | 0.18 GB

-- VDP performance by VIN (0 rows)
CREATE TABLE [MLdata].[VDPVINPerformance] (
    [acc_id]      int      NOT NULL,
    [vdp_date]    datetime NOT NULL,
    [lst_id]      int      NOT NULL,
    [dsr_id]      int      NOT NULL,
    [impressions] int      NOT NULL,
    [clicks]      int      NOT NULL
);
-- 0 rows | 0 GB

-- VIN-level daily impressions (meta + gpm) v1
CREATE TABLE [MLdata].[VehiclePerformanceDaily] (
    [common_client_id] int          NULL,  -- INT (no cast needed)
    [customer_name]    varchar(255) NULL,
    [campaign_date]    date         NOT NULL,
    [vehicle_vin]      varchar(50)  NULL,
    [vehicle_make]     varchar(100) NULL,
    [vehicle_model]    varchar(100) NULL,
    [meta_impressions] bigint       NOT NULL,
    [gpm_impressions]  bigint       NOT NULL
);
-- 12,500,142 rows | 4.25 GB

-- VIN-level daily impressions v2 (leaner)
CREATE TABLE [MLdata].[VehiclePerformanceDailyV2] (
    [common_client_id] int         NULL,
    [campaign_date]    date        NOT NULL,
    [vehicle_vin]      varchar(50) NULL,
    [vehicle_make]     varchar(100) NULL,
    [meta_impressions] bigint      NOT NULL,
    [gpm_impressions]  bigint      NOT NULL
);
-- 12,607,521 rows | 2.02 GB

-- ============================================================
-- SCHEMA: radar
-- Radar reputation management — 2 tables
-- Note: commonClientID typed TEXT — cast to INT required
-- ============================================================

-- Radar account configuration (TEXT commonClientID — type mismatch)
CREATE TABLE [radar].[clientConfigurations] (
    [commonClientID]          text NULL,  -- TEXT — CAST to INT for joins
    [ClientName]              text NULL,
    [enabled]                 text NULL,
    [reviewsites_displayName] text NULL
);
-- 5,696 rows | 0.01 GB

-- Radar reviews (unstructured text — candidate for sentiment enrichment)
CREATE TABLE [radar].[Reviews] (
    [ClientName]         nvarchar(100) NULL,
    [DateReviewIngested] datetime      NULL,
    [StarRating]         int           NULL,
    [ReviewSite]         nvarchar(255) NULL,
    [ReviewText]         nvarchar(MAX) NULL,
    [ResponseText]       nvarchar(MAX) NULL,
    [StatusOfReview]     nvarchar(50)  NULL
);
-- 128,353 rows | 0.14 GB

-- ============================================================
-- SCHEMA: RLData
-- Response Logix lead management — 10 tables, 82 M rows
-- No CommonClientID; join via customer.AccountId -> core.Stage_Accounts
-- ============================================================

-- Chat statistics per lead
CREATE TABLE [RLData].[ChatStatistics] (
    [lead_number] int       NOT NULL,
    [lead_date]   datetime  NOT NULL,
    [customer_id] int       NOT NULL,
    [status]      smallint  NULL
);
-- 27,489 rows | <0.01 GB

-- Dealer/franchise customer registry
CREATE TABLE [RLData].[customer] (
    [customer_id] int         NOT NULL,
    [name]        varchar(50) NOT NULL,
    [website]     varchar(100) NULL,
    [status]      varchar(10) NOT NULL,
    [AccountId]   int         NULL,  -- FK -> core.Stage_Accounts.Id
    [NewClientId] int         NULL
);
-- 6,024 rows | <0.01 GB

-- Franchise-to-customer mapping with Radar GUID link
CREATE TABLE [RLData].[franchise] (
    [franchise_id]      int              NOT NULL,
    [customer_id]       int              NOT NULL,
    [make_id]           int              NOT NULL,
    [status]            varchar(50)      NULL,
    [lead_crm]          varchar(50)      NULL,
    [core_account_guid] uniqueidentifier NULL  -- links to core.Stage_Accounts.Token
);
-- 9,920 rows | <0.01 GB

-- Inbound lead: contact details + status
CREATE TABLE [RLData].[lead] (
    [lead_number] int              NOT NULL,
    [lead_id]     uniqueidentifier NOT NULL,
    [lead_date]   datetime         NOT NULL,
    [first]       varchar(50)      NULL,      -- PII
    [last]        varchar(50)      NULL,      -- PII
    [email]       varchar(100)     NOT NULL,  -- PII
    [home_phone]  varchar(20)      NULL,
    [mobile_phone] varchar(20)     NULL,
    [zip]         varchar(10)      NULL,
    [customer_id] int              NOT NULL,
    [franchise_id] int             NULL,
    [status]      varchar(30)      NOT NULL,
    [type]        varchar(10)      NOT NULL
);
-- 3,719,180 rows | 5.29 GB

-- Lead lifecycle events (25 GB)
CREATE TABLE [RLData].[lead_history] (
    [id]              int              NOT NULL,
    [lead_history_id] uniqueidentifier NOT NULL,
    [lead_id]         uniqueidentifier NOT NULL,  -- FK -> lead.lead_id
    [history_date]    datetime         NOT NULL,
    [type]            varchar(100)     NOT NULL
);
-- 66,995,841 rows | 25.55 GB

-- Vehicle make reference
CREATE TABLE [RLData].[make] (
    [make_id] int         NOT NULL,
    [name]    varchar(50) NOT NULL,
    [status]  varchar(10) NOT NULL
);
-- 76 rows | <0.01 GB

-- Reactivation events (email + date)
CREATE TABLE [RLData].[reactivation] (
    [id]              int              NOT NULL,
    [reactivation_id] uniqueidentifier NOT NULL,
    [email]           varchar(100)     NOT NULL,
    [reactivation_date] datetime       NOT NULL
);
-- 1,420,146 rows | 0.81 GB

-- Smart facts report data (leads subset)
CREATE TABLE [RLData].[smart_facts_report_data] (
    [id]          int              NOT NULL,
    [lead_id]     uniqueidentifier NOT NULL,
    [lead_date]   datetime         NOT NULL,
    [customer_id] int              NOT NULL,
    [email]       varchar(100)     NOT NULL
);
-- 499,872 rows | 0.08 GB

-- Smart Follow performance report (CLUSTERED unique key)
CREATE TABLE [RLData].[smart_follow_performance_report] (
    [smart_follow_performance_report_id] int      NOT NULL,
    [customer_id]                        int      NULL,
    [report_date]                        datetime NOT NULL,
    [type]                               varchar(10) NOT NULL
    -- CLUSTERED unique on (report_date, type, franchise_id, customer_id)
);
-- 880,439 rows | 0.11 GB

-- Smart Quote linked to lead
CREATE TABLE [RLData].[smart_quote] (
    [smart_quote_id]  uniqueidentifier NOT NULL,
    [lead_id]         uniqueidentifier NULL,
    [email]           varchar(100)     NOT NULL,
    [smart_quote_date] datetime        NOT NULL
);
-- 8,475,447 rows | 7.58 GB

-- ============================================================
-- SCHEMA: RPData
-- RocketChat / LiveJoin ETS Chat — 3 tables
-- No CommonClientID; join via Company.clientId (type TBD)
-- ============================================================

-- Chat company / dealer registry (0 rows)
CREATE TABLE [RPData].[Company] (
    [Id]       nvarchar(100) NULL,
    [Title]    nvarchar(255) NULL,
    [Type]     nvarchar(100) NULL,
    [Status]   nvarchar(100) NULL,
    [clientId] nvarchar(255) NULL  -- dealer identifier (no CCI mapping confirmed)
);
-- 0 rows

-- Inbound chat leads (PII: email, phone, name)
CREATE TABLE [RPData].[Leads] (
    [Id]          nvarchar(100) NULL,
    [CompanyId]   nvarchar(255) NULL,
    [ClientPhone] nvarchar(100) NULL,
    [ClientEmail] nvarchar(255) NULL,
    [Status]      nvarchar(100) NULL,
    [CreatedAt]   datetime      NULL,
    [FirstName]   nvarchar(255) NULL,
    [LastName]    nvarchar(255) NULL
);
-- 536,986 rows | 0.11 GB

-- Full conversation messages (0 rows)
CREATE TABLE [RPData].[Messages] (
    [Id]             nvarchar(100) NULL,
    [ConversationId] nvarchar(100) NULL,
    [CompanyId]      nvarchar(100) NULL,
    [Type]           nvarchar(100) NULL,
    [Text]           nvarchar(MAX) NULL,
    [CreatedAt]      nvarchar(100) NULL
);
-- 0 rows

-- ============================================================
-- SCHEMA: zuora
-- Billing — 2 tables
-- ClientID (VARCHAR) maps to CommonClientId — cast required
-- ============================================================

-- Billing account with subscription status (Zuora source)
CREATE TABLE [zuora].[AccountStage] (
    [Id]            varchar(255) NULL,
    [AccountNumber] varchar(255) NULL,
    [Name]          varchar(255) NULL,
    [Status]        varchar(255) NULL,
    [Currency]      varchar(255) NULL,
    [Balance]       varchar(18)  NULL,
    [CrmId]         varchar(255) NULL,  -- FK -> dynamics.Account.accountid
    [ClientID]      varchar(50)  NULL   -- maps to CommonClientId — VARCHAR, CAST to INT required
);
-- 11,632 rows | 0.02 GB

-- Fiscal year accounting period reference (0 rows)
CREATE TABLE [zuora].[AccountingPeriodStage] (
    [Id]         varchar(50)  NULL,
    [Name]       varchar(255) NULL,
    [StartDate]  varchar(24)  NULL,
    [EndDate]    varchar(24)  NULL,
    [Status]     varchar(50)  NULL,
    [FiscalYear] varchar(4)   NULL
);
-- 0 rows

-- ============================================================
-- VIEWS — AI schema (42 views, primary BI tool query surface)
-- Definitions not accessible via ConflictAI login (no VIEW DEFINITION)
-- Names are authoritative; purpose inferred from name pattern
-- ============================================================

-- v_CDXP_* views: expose CDXP schema tables to ai.das-technology.com
-- v_ML_*  views: expose MLdata tables
-- v_RL_*  views: expose RLData tables
-- v_SL_*  views: expose core (SureLift/Radar) tables

-- Key views:
-- AI.v_CDXP_BlueSkyOverview           (last modified: 2026-01-09)
-- AI.v_CDXP_HiddenTable_MarketingSummary (last modified: 2026-03-27)
-- AI.v_CDXP_LeadPerformance           (last modified: 2026-01-09)
-- AI.v_CDXP_Marketing_Summary         (last modified: 2026-01-09)
-- AI.v_CDXP_MatchBacks                (last modified: 2026-01-09)
-- AI.v_ML_CampaignLevelPerformance    (last modified: 2025-09-02)
-- AI.v_ML_VehiclePerformanceDaily     (last modified: 2026-04-24)
-- AI.v_RL_Leads                       (last modified: 2026-04-30)
-- AI.v_RL_Smart_Follow                (last modified: 2026-04-30)
-- AI.v_SL_Reviews                     (last modified: 2026-04-24)
-- AI.v_SL_Surveys                     (last modified: 2026-04-24)
-- AI.v_SurveySendSummary              (last modified: 2026-06-04)
-- AI.GVACampaignData                  (last modified: 2025-10-14)
-- AI.TikTokCampaignData               (last modified: 2025-10-14)
-- AI.MAIACampaignData                 (last modified: 2025-10-14)
-- AI.MLCampaign_VDP_Performance       (last modified: 2026-01-14)
-- AI.JuiceReporting_BSR_equity        (last modified: 2026-05-04)
-- ... (see docs/databases/dwrpt-ai.md for full view list)

-- VIEWS — core schema (7 views)
-- core.v_AllTimePerformance, v_MRSReviewRequest, v_Reviews,
-- v_SocialAdsCampaign, v_SurveyResponseGen2, v_Surveys, v_SurveySendSummary

-- VIEWS — dbo schema (5 views)
-- dbo.v_RL_Leads, v_RL_Leads_dev, v_RL_Leads_Reactivations,
-- dbo.v_RL_OptOuts, v_RL_Smart_Follow

-- VIEWS — dynamics schema (2 views)
-- dynamics.v_AccountProducts, v_AccountProductsV2

-- VIEWS — MLdata schema (2 views)
-- MLdata.v_ML_CampaignPerformanceDaily, v_ML_VehiclePerformanceDaily

-- ============================================================
-- BACKUP SUMMARY (from msdb.dbo.backupset, 30-day window)
-- Storage: Azure Blob — medialogixprodsqlstorage
-- Full backups (type D): 1,257 entries (de-duplicated ~630 unique)
--   Cadence: every ~15-30 min during batch ETL window; ~30+ per day
--   Avg size: ~340 GB per backup
-- Log backups (type L): 2,586 entries
--   Cadence: every 2–5 min during active ETL; ~5 MB during quiet periods
-- Last full backup: 2026-06-09 06:22 UTC, 340,185 MB
-- ============================================================
