-- =============================================================================
-- DataStaging — DDL Schema Dump
-- Server:        DWRPT (40.83.161.93)
-- Discovery date: 2026-06-14
-- Researcher:    Alicia Salazar
-- Description:   Central SQL Server staging and analytics database consolidating
--                data from all major DAS product lines (Juice/BlueSky CXP,
--                MediaLogix, ReviewRocket/Radar, Response Logix, Dynamics 365,
--                Zuora, Google My Business, LotVantage). 108 tables, 13 schemas,
--                58 views, ~335 GB total data.
-- =============================================================================

USE [DataStaging];
GO

-- =============================================================================
-- SCHEMA: clientdb
-- Purpose: Authoritative cross-system client/dealer master registry.
--          Every CommonClientID FK chain in the database resolves here.
-- =============================================================================

-- Master client registry — root of all CommonClientID FK chains
CREATE TABLE [clientdb].[ClientConsolidated] (
    CommonClientId       INT           NOT NULL,  -- Universal tenant identifier (PK, used as FK in 10+ schemas)
    DynamicsAccountId    VARCHAR(36)   NULL,       -- Dynamics 365 account GUID
    ClientName           NVARCHAR(254) NOT NULL,
    Street               NVARCHAR(200) NULL,
    City                 NVARCHAR(128) NULL,
    Province             NVARCHAR(128) NULL,
    PostalCode           NVARCHAR(64)  NULL,
    CountryName          NVARCHAR(200) NULL,
    SiteUrl              NVARCHAR(1000) NULL
);

-- =============================================================================
-- SCHEMA: CDXP
-- Purpose: Juice/BlueSky CXP reporting layer. 23 tables, 327M rows, 131 GB.
--          Contains PII-bearing customer contacts with cross-system identity keys,
--          campaign engagement, revenue attribution, and vehicle equity data.
--          All tables carry CommonClientID (INT FK).
-- =============================================================================

-- Master contact table — four identity keys + full PII + LTV scores + vehicle equity
CREATE TABLE [CDXP].[JuiceReporting_BlueSkyOverview] (
    ContactID                   INT           NULL,
    ClientID                    INT           NULL,
    EDW_DMS_Customer_ID         VARCHAR(50)   NULL,  -- DMS customer identifier
    RecipientID                 VARCHAR(50)   NULL,  -- Email platform recipient ID
    CRMID                       VARCHAR(50)   NULL,  -- CRM identity key
    EmailAddress                VARCHAR(200)  NULL,  -- PII
    FirstName                   VARCHAR(100)  NULL,  -- PII
    LastName                    VARCHAR(100)  NULL,  -- PII
    Address                     VARCHAR(255)  NULL,  -- PII
    Address1                    VARCHAR(255)  NULL,
    Address2                    VARCHAR(255)  NULL,
    City                        VARCHAR(100)  NULL,
    State                       VARCHAR(10)   NULL,
    ZipCode                     VARCHAR(20)   NULL,
    PhoneNumber                 VARCHAR(20)   NULL,  -- PII
    ContactLat                  FLOAT         NULL,
    ContactLong                 FLOAT         NULL,
    LeadCreateDate              DATETIME      NULL,
    LeadSourceType              VARCHAR(100)  NULL,
    LeadStatusType              VARCHAR(100)  NULL,
    LeadSourceProviderType      VARCHAR(100)  NULL,
    LeadSourceProvider          VARCHAR(100)  NULL,
    SaleDate                    DATETIME      NULL,
    LeaseEndDate                DATETIME      NULL,
    LastServiceDate             DATETIME      NULL,
    LastTransactionDate         DATETIME      NULL,
    CustomerType                VARCHAR(50)   NULL,
    LTVSegment                  VARCHAR(50)   NULL,
    LTVScore                    FLOAT         NULL,
    Sale30Score                 FLOAT         NULL,
    Sale180Score                FLOAT         NULL,
    Service30Score              FLOAT         NULL,
    Service180Score             FLOAT         NULL,
    DealType                    VARCHAR(50)   NULL,
    SaleType                    VARCHAR(50)   NULL,
    VehicleType                 VARCHAR(50)   NULL,
    VehicleMake                 VARCHAR(100)  NULL,
    VehicleModel                VARCHAR(100)  NULL,
    VehicleYear                 VARCHAR(4)    NULL,
    EDW_DMS_Vehicle_ID          VARCHAR(50)   NULL,
    EquityValueRough            DECIMAL(18,2) NULL,  -- GLBA-adjacent
    EquityValueClean            DECIMAL(18,2) NULL,  -- GLBA-adjacent
    EquityValueAverage          DECIMAL(18,2) NULL,  -- GLBA-adjacent
    MonthlyPayments             DECIMAL(18,2) NULL,  -- GLBA-adjacent
    Trade_in_Average            DECIMAL(18,2) NULL,  -- GLBA-adjacent
    WarrantyEndDate             DATETIME      NULL,
    ContractEndDate             DATETIME      NULL,
    LeaseEndMileage             INT           NULL,
    IsConvertedLead             BIT           NULL,
    IsUnsubscribed              BIT           NULL,
    LastOpenDate                DATETIME      NULL,
    LastClickDate               DATETIME      NULL,
    ClientName                  VARCHAR(255)  NULL,
    ActiveFlag                  BIT           NULL,
    OEM                         VARCHAR(100)  NULL,
    OwnerName                   VARCHAR(255)  NULL,
    OEMs                        NVARCHAR(500) NULL,
    Live_Date                   DATETIME      NULL,
    CommonClientID              INT           NULL   -- FK → clientdb.ClientConsolidated.CommonClientId
    -- ... (135+ additional columns covering account config, engagement flags, scoring)
);

-- Granular email engagement — every send, open, click, unsubscribe event per recipient
CREATE TABLE [CDXP].[JuiceReporting_HiddenTable_MarketingSummary] (
    ClientID            INT           NULL,
    ClientName          VARCHAR(255)  NULL,
    CampaignID          INT           NULL,
    CampaignName        VARCHAR(255)  NULL,
    EmailID             INT           NULL,
    SendType            VARCHAR(50)   NULL,
    SendName            VARCHAR(255)  NULL,
    EmailName           VARCHAR(255)  NULL,
    SentDate            DATETIME      NULL,
    EmailDate           DATETIME      NULL,
    EmailSubject        VARCHAR(500)  NULL,
    RecipientID         INT           NULL,
    ClientLinkID        INT           NULL,
    LinkText            VARCHAR(255)  NULL,
    LinkCategory        VARCHAR(100)  NULL,
    LinkURL             VARCHAR(1000) NULL,
    FirstName           VARCHAR(100)  NULL,  -- PII
    LastName            VARCHAR(100)  NULL,  -- PII
    EmailAddress        VARCHAR(200)  NULL,  -- PII
    Address1            VARCHAR(255)  NULL,  -- PII
    City                VARCHAR(100)  NULL,
    State               VARCHAR(10)   NULL,
    ZipCode             VARCHAR(20)   NULL,
    HomePhone           VARCHAR(20)   NULL,  -- PII
    CellPhone           VARCHAR(20)   NULL,  -- PII
    WorkPhone           VARCHAR(20)   NULL,  -- PII
    IsUnsubscribed      BIT           NULL,
    IsHardBounce        BIT           NULL,
    IsOpener            BIT           NULL,
    IsClicker           BIT           NULL,
    IsBounce            BIT           NULL,
    IsDelivered         BIT           NULL,
    IsUnsubscriber      BIT           NULL,
    IsNonOpener         BIT           NULL,
    TransactionDate     DATETIME      NULL,
    OpenDate            DATETIME      NULL,
    ClickDate           DATETIME      NULL,
    UnsubscribeDate     DATETIME      NULL,
    OwnerName           VARCHAR(255)  NULL,
    OEMs                NVARCHAR(500) NULL,
    IsCallRevuMatched   BIT           NULL,
    email_preview_url   VARCHAR(1000) NULL,
    CommonClientID      INT           NULL   -- FK → clientdb.ClientConsolidated.CommonClientId
);

-- Per-contact, per-campaign attribution table with 82 columns — most complete attribution table
CREATE TABLE [CDXP].[mv_contact_stats] (
    clientid                        INT           NULL,  -- FK → clientdb.ClientConsolidated.CommonClientId
    clientname                      NVARCHAR(510) NULL,
    client_id                       INT           NULL,
    campaign_id                     INT           NULL,
    contact_source_id               INT           NULL,
    contact_id                      INT           NULL,
    contact_email                   NVARCHAR(510) NULL,  -- PII
    contact_phonenumber             NVARCHAR(510) NULL,  -- PII
    contact_vin                     NVARCHAR(510) NULL,
    contact_make                    NVARCHAR(510) NULL,
    contact_model                   NVARCHAR(510) NULL,
    contact_year                    NVARCHAR(510) NULL,
    contact_address                 NVARCHAR(510) NULL,  -- PII
    contact_city                    NVARCHAR(510) NULL,
    contact_state                   NVARCHAR(510) NULL,
    contact_zip                     NVARCHAR(510) NULL,
    contact_first_name              NVARCHAR(510) NULL,  -- PII
    contact_last_name               NVARCHAR(510) NULL,  -- PII
    send_type                       NVARCHAR(510) NULL,
    campaign_name                   NVARCHAR(510) NULL,
    campaign_date                   DATETIME2     NULL,
    engagement_send                 INT           NULL,
    engagement_delivered            INT           NULL,
    engagement_opened               INT           NULL,
    engagement_clicked              INT           NULL,
    engagement_unsubscribed         INT           NULL,
    attribution_service             INT           NULL,
    attribution_service_count       INT           NULL,
    attribution_sales               INT           NULL,
    attribution_sales_count         INT           NULL,
    attribution_sales_revenue       DECIMAL(18,2) NULL,
    attribution_days_to_first_sale  INT           NULL,
    attribution_pageview            INT           NULL,
    refreshed_timestamp             DATETIME      NULL,
    ownername                       NVARCHAR(510) NULL,
    oems                            NVARCHAR(510) NULL,
    CommonClientID                  INT           NULL   -- FK → clientdb.ClientConsolidated.CommonClientId
    -- ... (additional attribution and engagement columns)
);

-- Campaign-level engagement summary per recipient
CREATE TABLE [CDXP].[JuiceReporting_Marketing_Summary] (
    ClientID            INT           NULL,
    ClientName          VARCHAR(255)  NULL,
    CampaignName        VARCHAR(255)  NULL,
    CampaignId          INT           NULL,
    CampaignEventId     INT           NULL,
    CampaignStartDate   DATETIME      NULL,
    CampaignEndDate     DATETIME      NULL,
    SendType            VARCHAR(50)   NULL,
    SentDateTime        DATETIME      NULL,
    SentDate            DATETIME      NULL,
    SendName            VARCHAR(255)  NULL,
    SendSubject         VARCHAR(500)  NULL,
    contactattemptid    INT           NULL,
    RecipientID         INT           NULL,
    IsDelivered         BIT           NULL,
    IsOpener            BIT           NULL,
    IsClicker           BIT           NULL,
    IsUnsubscriber      BIT           NULL,
    IsBounce            BIT           NULL,
    OpenCount           INT           NULL,
    ClickCount          INT           NULL,
    TransactionID       INT           NULL,
    TransactionType     VARCHAR(50)   NULL,
    TransactionDate     DATETIME      NULL,
    IsNonOpener         BIT           NULL,
    OwnerName           VARCHAR(255)  NULL,
    OEMs                NVARCHAR(500) NULL,
    IsCallRevuMatched   BIT           NULL,
    OpenDate            DATETIME      NULL,
    ClickDate           DATETIME      NULL,
    UnsubscribeDate     DATETIME      NULL,
    CommonClientID      INT           NULL   -- FK → clientdb.ClientConsolidated.CommonClientId
);

-- Lead source attribution index with geo enrichment
CREATE TABLE [CDXP].[JuiceReporting_LeadPerformance_LeadSourceIndex] (
    ClientID                VARCHAR(50)  NULL,
    ClientName              VARCHAR(255) NULL,
    LeadSourceProvider      VARCHAR(255) NULL,
    LeadIdentifier          VARCHAR(255) NULL,
    ContactID               INT          NULL,
    RecipientID             INT          NULL,
    FirstName               VARCHAR(100) NULL,  -- PII
    LastName                VARCHAR(100) NULL,  -- PII
    EmailAddress            VARCHAR(200) NULL,  -- PII
    CRMID                   VARCHAR(50)  NULL,
    LeadCreateDate          DATETIME     NULL,
    SaleDate                DATETIME     NULL,
    IsConvertedLead         BIT          NULL,
    LeadStatusType          VARCHAR(100) NULL,
    city                    VARCHAR(100) NULL,
    state_name              VARCHAR(100) NULL,
    latitude                FLOAT        NULL,
    Longitude               FLOAT        NULL,
    CommonClientID          INT          NULL   -- FK → clientdb.ClientConsolidated.CommonClientId
    -- ... additional columns
);

-- Per-contact transaction attribution
CREATE TABLE [CDXP].[JuiceReporting_CDXPTransactionsOverview] (
    ClientID                    INT           NULL,
    CampaignID                  INT           NULL,
    ClientName                  VARCHAR(255)  NULL,
    SentDateTime                DATETIME      NULL,
    TransactionType             VARCHAR(50)   NULL,
    attribution_service         INT           NULL,
    attribution_service_count   INT           NULL,
    attribution_sales           INT           NULL,
    attribution_sales_count     INT           NULL,
    attribution_sales_revenue   DECIMAL(18,2) NULL,
    Contact_ID                  INT           NULL,
    FirstName                   VARCHAR(100)  NULL,  -- PII
    LastName                    VARCHAR(100)  NULL,  -- PII
    EmailAddress                VARCHAR(200)  NULL,  -- PII
    TransactionDate             DATETIME      NULL,
    SalesRevenue                DECIMAL(18,2) NULL,
    ServiceRevenue              DECIMAL(18,2) NULL,
    VehicleVIN                  VARCHAR(20)   NULL,
    VehicleYear                 VARCHAR(4)    NULL,
    VehicleMake                 VARCHAR(100)  NULL,
    VehicleModel                VARCHAR(100)  NULL,
    CommonClientID              INT           NULL   -- FK → clientdb.ClientConsolidated.CommonClientId
);

-- Vehicle equity estimates — GLBA-adjacent, treat as sensitive
CREATE TABLE [CDXP].[JuiceReporting_BSR_equity] (
    ClientID            INT           NULL,
    ClientName          VARCHAR(255)  NULL,
    FirstName           VARCHAR(100)  NULL,  -- PII
    LastName            VARCHAR(100)  NULL,  -- PII
    EmailAddress        VARCHAR(200)  NULL,  -- PII
    PhoneNumber         VARCHAR(20)   NULL,  -- PII
    CellPhone           VARCHAR(20)   NULL,  -- PII
    [Year]              VARCHAR(4)    NULL,
    Make                VARCHAR(50)   NULL,
    Model               VARCHAR(100)  NULL,
    VIN                 VARCHAR(20)   NULL,
    ExteriorColor       VARCHAR(50)   NULL,
    EstimatedMiles      INT           NULL,
    EquityValueRough    DECIMAL(18,2) NULL,  -- GLBA-adjacent
    EquityValueClean    DECIMAL(18,2) NULL,  -- GLBA-adjacent
    EquityValueAverage  DECIMAL(18,2) NULL,  -- GLBA-adjacent
    Payment             DECIMAL(18,2) NULL,  -- GLBA-adjacent
    Rate_APR            DECIMAL(18,4) NULL,  -- GLBA-adjacent
    Term                INT           NULL,  -- GLBA-adjacent
    RecipientID         INT           NULL,
    CommonClientID      INT           NULL   -- FK → clientdb.ClientConsolidated.CommonClientId
);

-- Unsubscribe and hard-bounce event log
CREATE TABLE [CDXP].[JuiceReporting_RecipientLoss] (
    ClientID        INT           NULL,
    ClientName      VARCHAR(255)  NULL,
    WhenEastern     DATETIME      NULL,
    EmailAddress    VARCHAR(200)  NULL,  -- PII (stored uppercase — normalize on ingest)
    FirstName       VARCHAR(100)  NULL,  -- PII
    LastName        VARCHAR(100)  NULL,  -- PII
    Action          VARCHAR(100)  NULL,  -- 'Hard Bounce', 'Unsubscribe', etc.
    OwnerName       VARCHAR(255)  NULL,
    OEMs            NVARCHAR(500) NULL,
    CommonClientID  INT           NULL   -- FK → clientdb.ClientConsolidated.CommonClientId
);

-- Service RO records with customer and vehicle details
CREATE TABLE [CDXP].[JuiceReporting_BlueSkyServicePerformance] (
    EDW_DMS_Customer_ID     VARCHAR(50)   NULL,
    ContactType             VARCHAR(50)   NULL,
    ClientID                INT           NULL,
    [RO Closed date]        DATETIME      NULL,
    EDW_DMS_Transaction_ID  VARCHAR(50)   NULL,
    EDW_DMS_Vehicle_ID      VARCHAR(50)   NULL,
    RONumber                VARCHAR(50)   NULL,
    ROAmount                DECIMAL(18,2) NULL,
    CPROTotal               DECIMAL(18,2) NULL,
    WPROTotal               DECIMAL(18,2) NULL,
    HasDeclinedService      BIT           NULL,
    Make                    VARCHAR(50)   NULL,
    Model                   VARCHAR(100)  NULL,
    [Year]                  VARCHAR(4)    NULL,
    Mileage                 INT           NULL,
    CommonClientID          INT           NULL   -- FK → clientdb.ClientConsolidated.CommonClientId
    -- ... additional columns
);

-- Remaining CDXP tables (abbreviated — same CommonClientID FK pattern)
CREATE TABLE [CDXP].[JuiceReporting_BlueSkyOverview_v2] (
    ClientID                INT           NULL,
    EDW_DMS_Transaction_ID  VARCHAR(50)   NULL,
    EDW_DMS_Customer_ID     VARCHAR(50)   NULL,
    EDW_DMS_Vehicle_ID      VARCHAR(50)   NULL,
    TransactionTypeID       INT           NULL,
    TransactionDate         DATETIME      NULL,
    ROAmount                DECIMAL(18,2) NULL,
    OwnerName               VARCHAR(255)  NULL,
    OEMs                    NVARCHAR(500) NULL,
    CommonClientID          INT           NULL
);

CREATE TABLE [CDXP].[JuiceReporting_BlueSky_ServicePerf_V2] (
    ContactType             VARCHAR(50)   NULL,
    ClientID                INT           NULL,
    ClientName              VARCHAR(255)  NULL,
    ZipCode                 VARCHAR(20)   NULL,
    EDW_DMS_Customer_ID     VARCHAR(50)   NULL,
    EDW_DMS_Vehicle_ID      VARCHAR(50)   NULL,
    crmid                   VARCHAR(50)   NULL,
    CommonClientID          INT           NULL
    -- additional columns
);

CREATE TABLE [CDXP].[JuiceReporting_CDXPCustomers] (
    ClientID                INT           NULL,
    ContactType             VARCHAR(50)   NULL,
    FirstName               VARCHAR(100)  NULL,  -- PII
    LastName                VARCHAR(100)  NULL,  -- PII
    EmailAddress            VARCHAR(200)  NULL,  -- PII
    VehicleMake             VARCHAR(100)  NULL,
    VehicleModel            VARCHAR(100)  NULL,
    VehicleYear             VARCHAR(4)    NULL,
    VIN                     VARCHAR(20)   NULL,
    EDW_DMS_Customer_ID     VARCHAR(50)   NULL,
    EDW_DMS_Vehicle_ID      VARCHAR(50)   NULL,
    CommonClientID          INT           NULL
    -- additional columns
);

CREATE TABLE [CDXP].[JuiceReporting_DataMiningTool] (
    ClientID                VARCHAR(50)   NULL,
    ContactType             VARCHAR(50)   NULL,
    EmailAddress            VARCHAR(200)  NULL,  -- PII
    FirstName               VARCHAR(100)  NULL,  -- PII
    LastName                VARCHAR(100)  NULL,  -- PII
    LTVScore                FLOAT         NULL,
    Sale30Score             FLOAT         NULL,
    Sale180Score            FLOAT         NULL,
    Service30Score          FLOAT         NULL,
    Service180Score         FLOAT         NULL,
    LastVehicleMake         VARCHAR(100)  NULL,
    LastVehicleModel        VARCHAR(100)  NULL,
    LastVehicleYear         VARCHAR(4)    NULL,
    EstimatedVehicleMileage INT           NULL,
    CommonClientID          INT           NULL
    -- additional columns
);

CREATE TABLE [CDXP].[JuiceReporting_LeadPerformance] (
    ClientID            INT           NULL,
    LeadSourceProvider  VARCHAR(255)  NULL,
    ContactID           INT           NULL,
    RecipientID         INT           NULL,
    FirstName           VARCHAR(100)  NULL,  -- PII
    LastName            VARCHAR(100)  NULL,  -- PII
    EmailAddress        VARCHAR(200)  NULL,  -- PII
    CRMID               VARCHAR(50)   NULL,
    LeadCreateDate      DATETIME      NULL,
    SaleDate            DATETIME      NULL,
    IsConvertedLead     BIT           NULL,
    LeadStatusType      VARCHAR(100)  NULL,
    CommonClientID      INT           NULL
);

CREATE TABLE [CDXP].[JuiceReporting_BlueSkyRecommendations] (
    ClientID                    INT           NULL,
    ClientName                  VARCHAR(255)  NULL,
    ContactType                 VARCHAR(50)   NULL,
    EDW_DMS_Customer_ID         VARCHAR(50)   NULL,
    FirstName                   VARCHAR(100)  NULL,  -- PII
    LastName                    VARCHAR(100)  NULL,  -- PII
    EmailAddress                VARCHAR(200)  NULL,  -- PII
    PhoneNumber                 VARCHAR(20)   NULL,  -- PII
    VIN                         VARCHAR(20)   NULL,
    EquityValueRough            DECIMAL(18,2) NULL,  -- GLBA-adjacent
    Declined_Service_T_F        BIT           NULL,
    CommonClientID              INT           NULL
    -- additional columns
);

CREATE TABLE [CDXP].[JuiceReporting_MatchBacks] (
    ClientID            INT           NULL,
    CampaignID          INT           NULL,
    RecipientID         INT           NULL,
    EDW_DMS_Customer_ID VARCHAR(50)   NULL,
    TransactionType     VARCHAR(50)   NULL,
    SalesRevenue        DECIMAL(18,2) NULL,
    ServiceRevenue      DECIMAL(18,2) NULL,
    DaysToClose         INT           NULL,
    VehicleVIN          VARCHAR(20)   NULL,
    CommonClientID      INT           NULL
    -- additional columns
);

CREATE TABLE [CDXP].[JuiceReporting_TRANSACTION_SUMMARY] (
    ClientID            INT           NULL,
    ClientName          VARCHAR(255)  NULL,
    TransactionDate     DATETIME      NULL,
    Total_transactions  INT           NULL,
    TransactionType     VARCHAR(50)   NULL,
    gross               DECIMAL(18,2) NULL,
    InsertDate          DATETIME      NULL,
    OwnerName           VARCHAR(255)  NULL,
    OEMs                NVARCHAR(500) NULL,
    CommonClientID      INT           NULL
);

CREATE TABLE [CDXP].[JuiceReportingBlueSkyCurrentLeads] (
    ClientID                INT           NULL,
    ClientName              VARCHAR(255)  NULL,
    EDW_DMS_Customer_ID     VARCHAR(50)   NULL,
    CRMID                   VARCHAR(50)   NULL,
    ContactID               INT           NULL,
    EmailAddress            VARCHAR(200)  NULL,  -- PII
    PhoneNumber             VARCHAR(20)   NULL,  -- PII
    ContactType             VARCHAR(50)   NULL,
    LeadCreateDate          DATETIME      NULL,
    CommonClientAPIId       INT           NULL
    -- additional columns
);

CREATE TABLE [CDXP].[JuiceReporting_MarketingPerformance] (
    CampaignEventID         INT           NULL,
    ClientID                INT           NULL,
    SendType                VARCHAR(50)   NULL,
    ContactAttempts         INT           NULL,
    Deliveries              INT           NULL,
    UniqueOpens             INT           NULL,
    UniqueClicks            INT           NULL,
    Unsubscribes            INT           NULL,
    SalesMatchbacks         INT           NULL,
    ServiceMatchbacks       INT           NULL,
    CommonClientAPIId       INT           NULL
    -- additional columns
);

CREATE TABLE [CDXP].[JuiceReporting_NEW_RECIPIENTS] (
    ClientID            INT           NULL,
    CampaignID          INT           NULL,
    SentDateTime        DATETIME      NULL,
    SalesInfluences     INT           NULL,
    FrontGrossSum       DECIMAL(18,2) NULL,
    ServiceInfluences   INT           NULL,
    Service_RO_Sum      DECIMAL(18,2) NULL,
    CommonClientID      INT           NULL
    -- additional columns
);

CREATE TABLE [CDXP].[JuiceReporting_Marketing_Summary_Contact_eng] (
    ClientID            INT           NULL,
    CampaignID          INT           NULL,
    RecipientID         INT           NULL,
    ClientLinkID        INT           NULL,
    LinkText            VARCHAR(255)  NULL,
    LinkURL             VARCHAR(1000) NULL,
    LinkCategory        VARCHAR(100)  NULL,
    IsHandraiser        BIT           NULL,
    CommonClientAPIId   INT           NULL
    -- additional columns
);

CREATE TABLE [CDXP].[ClientDetails] (
    ClientDetailsID         INT           NULL,
    ClientID                INT           NULL,
    StreetAddress1          VARCHAR(255)  NULL,
    City                    VARCHAR(100)  NULL,
    State                   VARCHAR(10)   NULL,
    PostalCode              VARCHAR(20)   NULL,
    PhoneNumber             VARCHAR(20)   NULL,
    FullSiteURL             VARCHAR(500)  NULL,
    Latitude                FLOAT         NULL,
    Longitude               FLOAT         NULL,
    IsFacebookPublished     BIT           NULL,
    CIMFeedId               INT           NULL,
    CommonClientAPIId       INT           NULL
    -- additional columns
);

-- ZIP code geocoding reference — no CommonClientID
CREATE TABLE [CDXP].[Juice_ZipCode_Geo] (
    zip_code        VARCHAR(10)   NULL,
    city            VARCHAR(100)  NULL,
    county          VARCHAR(100)  NULL,
    state_name      VARCHAR(100)  NULL,
    latitude        FLOAT         NULL,
    Longitude       FLOAT         NULL,
    geometry_str    NVARCHAR(MAX) NULL
);

-- =============================================================================
-- SCHEMA: core
-- Purpose: Staging layer for Radar reputation, review ingestion, NPS surveys,
--          transaction records, and ReviewRocket workflow. 30 tables, 244M rows,
--          62 GB. CommonClientId present on Stage_Accounts and denormalized views.
-- =============================================================================

-- Account registry — Radar/ReviewRocket identity anchor; maps Token (GUID) to CommonClientId
CREATE TABLE [core].[Stage_Accounts] (
    Id                      INT              NOT NULL,
    Name                    VARCHAR(255)     NULL,
    Token                   UNIQUEIDENTIFIER NOT NULL,  -- Radar/ReviewRocket identity key
    MySqlDealerId           INT              NULL,
    NewSFDCId               VARCHAR(18)      NULL,
    OldSFDCId               VARCHAR(18)      NULL,
    BACCode                 VARCHAR(12)      NULL,
    RLCustomerId            INT              NULL,  -- FK hint → RLData.customer
    RLName                  VARCHAR(100)     NULL,
    SLName                  VARCHAR(100)     NULL,
    OwnerId                 INT              NULL,
    Website                 VARCHAR(255)     NULL,
    Phone                   VARCHAR(40)      NULL,
    KIACode                 VARCHAR(25)      NULL,
    Deleted                 BIT              NOT NULL,  -- Soft delete flag
    SLActive                BIT              NULL,
    ParentAccountId         INT              NULL,
    OEMProgram              VARCHAR(32)      NULL,
    OEMPrograms             VARCHAR(250)     NULL,
    AlternativeGuid         UNIQUEIDENTIFIER NULL,
    Brands                  VARCHAR(255)     NULL,
    RSActive                BIT              NULL,
    MCActive                BIT              NULL,
    FlexTemplate            BIT              NOT NULL,
    CollectReviews          BIT              NOT NULL,
    AMRSActive              BIT              NOT NULL,
    DynParentAccountId      UNIQUEIDENTIFIER NULL,
    DynId                   UNIQUEIDENTIFIER NULL,  -- Dynamics 365 account ID
    SocialActive            BIT              NOT NULL,
    ReputationActive        BIT              NOT NULL,
    PrivacyPolicyUrl        NVARCHAR(500)    NULL,
    FacebookPageId          NVARCHAR(200)    NULL,
    Latitude                VARCHAR(100)     NULL,
    Longitude               VARCHAR(100)     NULL,
    DealershipHours         VARCHAR(255)     NULL,
    DealershipLogo          VARCHAR(MAX)     NULL,
    RemoteTestDriveBadge    BIT              NOT NULL,
    ConciergeServiceBadge   BIT              NOT NULL,
    ReviewScoreBadge        BIT              NOT NULL,
    BuyFromHomeBadge        BIT              NOT NULL,
    TekionId                VARCHAR(255)     NULL,
    CommonClientId          INT              NULL   -- FK → clientdb.ClientConsolidated.CommonClientId
);

-- Primary review ingestion table — all reviews by source, site, score
CREATE TABLE [core].[Stage_Review] (
    Id                  INT              NOT NULL,
    ReviewGuid          UNIQUEIDENTIFIER NOT NULL,
    ReviewSourceId      INT              NOT NULL,
    AccountGuid         UNIQUEIDENTIFIER NOT NULL,  -- FK → Stage_Accounts.Token
    ExternalId          NVARCHAR(200)    NULL,
    ReviewSiteId        INT              NOT NULL,
    ReviewScore         DECIMAL(5,2)     NULL,
    ReviewerName        NVARCHAR(400)    NULL,
    ReviewerCity        NVARCHAR(400)    NULL,
    ReviewerState       NVARCHAR(400)    NULL,
    ReviewerCountry     NVARCHAR(200)    NULL,
    ReviewUrl           VARCHAR(2083)    NULL,
    ReviewTitle         NVARCHAR(MAX)    NULL,
    ReviewComment       NVARCHAR(MAX)    NULL,
    ReviewCommentShort  VARCHAR(500)     NULL,
    AylienException     BIT              NULL,
    AccountId           INT              NULL,
    IsClosedLoop        BIT              NOT NULL,
    SurveyResponseId    INT              NULL,
    Created             DATETIME         NULL,
    Modified            DATETIME         NULL,
    ReviewDate          DATETIME         NULL,
    SoftDeleteDateUTC   DATETIME         NULL   -- Soft delete
);

-- Partitioned review overflow for 2024
CREATE TABLE [core].[Stage_Review2024] (
    -- Same schema as Stage_Review
    Id                  INT              NOT NULL,
    ReviewGuid          UNIQUEIDENTIFIER NOT NULL,
    ReviewSourceId      INT              NOT NULL,
    AccountGuid         UNIQUEIDENTIFIER NOT NULL,
    ReviewSiteId        INT              NOT NULL,
    ReviewScore         DECIMAL(5,2)     NULL,
    ReviewerName        NVARCHAR(400)    NULL,
    ReviewComment       NVARCHAR(MAX)    NULL,
    Created             DATETIME         NULL,
    ReviewDate          DATETIME         NULL,
    SoftDeleteDateUTC   DATETIME         NULL
);

-- Survey sends — one row per survey dispatched
CREATE TABLE [core].[Stage_Surveys] (
    Id                          INT              NOT NULL,
    TxnId                       INT              NULL,
    OldSurveyId                 UNIQUEIDENTIFIER NOT NULL,
    AccountToken                UNIQUEIDENTIFIER NOT NULL,  -- FK → Stage_Accounts.Token
    SentDate                    DATETIME         NULL,
    [Type]                      VARCHAR(10)      NULL,  -- 'Sales' or 'Service'
    Vin                         VARCHAR(20)      NULL,
    Email                       VARCHAR(100)     NULL,  -- PII
    AccountId                   INT              NULL,
    TxnNumber                   VARCHAR(50)      NULL,
    TxnDate                     DATE             NULL,
    CustomerFirstName           VARCHAR(50)      NULL,  -- PII
    CustomerLastName            VARCHAR(50)      NULL,  -- PII
    EmployeeFirstName           VARCHAR(50)      NULL,
    EmployeeLastName            VARCHAR(50)      NULL,
    TxnTypeId                   SMALLINT         NULL,
    SentViaEmail                BIT              NOT NULL,
    SentViaSms                  BIT              NOT NULL,
    SentFirstVia                VARCHAR(255)     NULL,
    IsSurveyReminderEmailSent   BIT              NOT NULL,
    MobilePhone                 VARCHAR(100)     NULL,  -- PII
    ReviewSurgeConsumerId       UNIQUEIDENTIFIER NULL,
    Method                      VARCHAR(30)      NULL,
    Make                        VARCHAR(50)      NULL,
    [Year]                      VARCHAR(10)      NULL,
    Model                       VARCHAR(100)     NULL,
    SurveyOpenDate              DATETIME         NULL,
    SurveyReminderOpenDate      DATETIME         NULL
);

-- Survey lifecycle event log
CREATE TABLE [core].[Stage_SurveyHistory] (
    id          INT      NOT NULL,
    SurveyId    INT      NOT NULL,  -- FK → Stage_Surveys.Id
    ActionId    SMALLINT NOT NULL,
    ActionTime  DATETIME NULL,
    SiteId      INT      NULL,
    [Count]     INT      NOT NULL
);

-- Survey response records with NPS and rating
CREATE TABLE [core].[Stage_SurveyResponse] (
    Id                      INT              NOT NULL,
    SurveyId                INT              NOT NULL,  -- FK → Stage_Surveys.Id
    ResponseDate            DATETIME         NOT NULL,
    NPSScore                INT              NULL,
    Rating                  INT              NULL,
    Comments                NVARCHAR(MAX)    NULL,
    Feedback                NVARCHAR(MAX)    NULL,
    SurveyResponseGuid      UNIQUEIDENTIFIER NOT NULL,
    PublicationDate         DATETIME         NULL,
    PublicationStatus       INT              NULL,
    EnablePartnerShare      BIT              NULL,
    DisplaySurvey           BIT              NOT NULL,
    SurveyAnsweredBy        VARCHAR(50)      NOT NULL,
    Make                    VARCHAR(50)      NULL,
    [Year]                  VARCHAR(10)      NULL,
    Model                   VARCHAR(100)     NULL,
    PublishedReviewSiteId   INT              NULL,
    PublishedStatus         VARCHAR(100)     NULL,
    ThankYouPageClick       BIT              NOT NULL
);

-- DMS transaction ingestion
CREATE TABLE [core].[Stage_Txns] (
    TxnId           INT              NOT NULL,
    CreatedDate     DATETIME         NOT NULL,
    Token           UNIQUEIDENTIFIER NOT NULL,   -- Account token
    TxnDate         DATETIME         NOT NULL,
    TxnTypeId       SMALLINT         NOT NULL,
    AccountToken    UNIQUEIDENTIFIER NOT NULL,   -- FK → Stage_Accounts.Token
    CustomerId      INT              NOT NULL,
    TxnProviderId   SMALLINT         NOT NULL,
    HasCustomerEmail BIT             NULL
);

-- Denormalized review query surface — indexed for analytics
CREATE TABLE [core].[t_Reviews] (
    Id                  INT              NOT NULL,
    AccountName         VARCHAR(255)     NULL,
    State               VARCHAR(50)      NULL,
    City                NVARCHAR(400)    NULL,
    CommonClientId      INT              NULL,  -- FK → clientdb.ClientConsolidated.CommonClientId
    ReviewSite          NVARCHAR(200)    NULL,
    ReviewSiteId        INT              NOT NULL,
    ReviewScore         DECIMAL(5,2)     NULL,
    DecimalReviewScore  DECIMAL(9,4)     NULL,
    AccountGuid         UNIQUEIDENTIFIER NOT NULL,
    PublicationDate     DATETIME         NULL,
    ReviewerName        NVARCHAR(800)    NULL,
    ReviewTitle         NVARCHAR(MAX)    NULL,
    ReviewComment       NVARCHAR(MAX)    NULL,
    Parent_Group        VARCHAR(255)     NULL
);

-- Denormalized survey query surface (currently empty — ETL job may be disabled)
CREATE TABLE [core].[t_Surveys] (
    Id              INT           NOT NULL,
    AccountName     VARCHAR(255)  NULL,
    CommonClientId  INT           NULL,  -- FK → clientdb.ClientConsolidated.CommonClientId
    AccountId       INT           NULL,
    State           VARCHAR(50)   NULL,
    City            NVARCHAR(400) NULL,
    [Type]          VARCHAR(10)   NULL,
    SentDate        DATETIME      NULL,
    Email           VARCHAR(100)  NULL,  -- PII
    Comments        NVARCHAR(MAX) NULL,
    Feedback        NVARCHAR(MAX) NULL,
    Rating          INT           NULL,
    DecimalRating   DECIMAL(9,4)  NULL,
    NPSScore        INT           NULL,
    SurveyAnsweredBy VARCHAR(50)  NOT NULL,
    [Year]          VARCHAR(10)   NULL,
    Make            VARCHAR(50)   NULL,
    Model           VARCHAR(100)  NULL,
    ThankYouPageClick BIT         NULL,
    PublicationDate DATETIME      NULL,
    TxnNumber       VARCHAR(50)   NULL,
    EmployeeName    VARCHAR(101)  NULL,
    Parent_Group    VARCHAR(255)  NULL
);

-- ReviewRocket survey workflow
CREATE TABLE [core].[ReviewRocketSurvey] (
    Id                          INT              NOT NULL,
    ClientId                    UNIQUEIDENTIFIER NOT NULL,  -- FK → Stage_Accounts.Token
    ReviewRocketGuid            UNIQUEIDENTIFIER NOT NULL,
    SentDate                    DATETIMEOFFSET   NOT NULL,
    [Type]                      VARCHAR(10)      NULL,
    Vin                         VARCHAR(20)      NULL,
    Email                       VARCHAR(100)     NULL,  -- PII
    CustomerFirstName           VARCHAR(50)      NULL,  -- PII
    CustomerLastName            VARCHAR(50)      NULL,  -- PII
    SentViaEmail                BIT              NOT NULL,
    SentViaSms                  BIT              NOT NULL
    -- additional columns
);

-- ReviewRocket per-client configuration (branding, email templates, redirect flags)
CREATE TABLE [core].[ReviewRocketConfiguration] (
    Id                          INT              NOT NULL,
    ReviewRocketConfigId        UNIQUEIDENTIFIER NOT NULL,
    ClientId                    UNIQUEIDENTIFIER NOT NULL,
    WelcomeText                 VARCHAR(MAX)     NOT NULL,
    EmailAddress                VARCHAR(100)     NOT NULL,
    PhoneNumber                 VARCHAR(100)     NOT NULL,
    Active                      BIT              NOT NULL,
    ActivateDate                DATETIME         NOT NULL
    -- additional columns
);

-- MRS review request tracking
CREATE TABLE [core].[Stage_MRSReviewRequest] (
    Id                  INT              NOT NULL,
    ClientId            UNIQUEIDENTIFIER NOT NULL,
    ReviewRequestId     UNIQUEIDENTIFIER NOT NULL,
    SentDate            DATETIME         NOT NULL,
    ConsumerFirstName   NVARCHAR(510)    NOT NULL,
    ConsumerLastName    NVARCHAR(510)    NOT NULL,
    EmployeeFirstName   NVARCHAR(510)    NOT NULL,
    EmployeeLastName    NVARCHAR(510)    NOT NULL,
    Category            NVARCHAR(510)    NOT NULL
);

-- AI-generated sentiment labels per review
CREATE TABLE [core].[Stage_ReviewSentiment] (
    SentimentId     INT  NOT NULL,  -- PK
    ReviewId        INT  NOT NULL   -- FK → Stage_Review.Id
    -- additional columns
);

CREATE TABLE [core].[Stage_ReviewSentimentDetail] (
    DetailId        INT          NOT NULL,  -- PK
    SentimentId     INT          NOT NULL,  -- FK → Stage_ReviewSentiment.SentimentId
    detail_type     VARCHAR(100) NULL,
    detail_text     VARCHAR(500) NULL
);

-- Parent-child account hierarchy
CREATE TABLE [core].[Stage_AccountHierarchy] (
    ChildAccountId  INT NOT NULL,
    ParentAccountId INT NOT NULL
);

-- Social advertising campaign windows per account
CREATE TABLE [core].[Stage_SocialAdsCampaign] (
    -- AccountGuid, campaign dates, budgets
    AccountGuid UNIQUEIDENTIFIER NOT NULL
    -- additional columns
);

-- Reference tables
CREATE TABLE [core].[Stage_ReviewSite]     (Id INT NOT NULL, -- review site name/URL
                                             Name VARCHAR(100) NULL);
CREATE TABLE [core].[Stage_ReviewSource]   (Id INT NOT NULL, Name VARCHAR(100) NULL);
CREATE TABLE [core].[Stage_TxnTypes]       (TxnTypeId INT NOT NULL, Name VARCHAR(50) NULL);
CREATE TABLE [core].[Stage_Category]       (Id INT NOT NULL, Name VARCHAR(50) NULL);
CREATE TABLE [core].[Stage_ReviewCategory] (ReviewId INT NOT NULL, CategoryId INT NOT NULL);
CREATE TABLE [core].[Stage_Addresses]      (AccountId INT NOT NULL, -- address data
                                            Street VARCHAR(255) NULL);

-- =============================================================================
-- SCHEMA: MLdata
-- Purpose: MediaLogix inventory advertising platform. 23 tables, 209M rows,
--          93 GB. Inventory feeds, SRP/VDP actions, GVA, PlatformAuto stats.
--          common_client_id is VARCHAR(50) — type mismatch with other schemas.
-- =============================================================================

-- High-volume SRP action event log
CREATE TABLE [MLdata].[grail_srpactions_daily] (
    event_date      DATE    NOT NULL,
    acc_id          INT     NOT NULL,
    subscription_id INT     NOT NULL,
    lst_id          INT     NOT NULL,  -- FK → Listing.lst_ID
    app_action      INT     NOT NULL,
    is_bot          BIT     NOT NULL,
    action_count    BIGINT  NOT NULL
);

-- Live inventory feed ads — one row per VIN per dealer
CREATE TABLE [MLdata].[FEEDADS] (
    faUID           INT           NOT NULL,
    fdPUBID         INT           NOT NULL,
    fdEDID          INT           NOT NULL,
    faVIN           VARCHAR(64)   NOT NULL,
    faADNUM         INT           NOT NULL,
    faCAT           VARCHAR(255)  NOT NULL,
    faSCLID         INT           NOT NULL,
    faTYPE          TINYINT       NOT NULL,
    faSPECIAL       TINYINT       NOT NULL,
    faTOP           TINYINT       NOT NULL,
    faTEXT          VARCHAR(4096) NOT NULL,
    faHTML          TEXT          NULL,
    faHEADLINE      VARCHAR(128)  NULL,
    faBOXED         BIT           NOT NULL,
    faYEAR          SMALLINT      NULL,
    faMAKE          VARCHAR(32)   NULL,
    faMODEL         VARCHAR(128)  NULL,
    faSUBMODEL      VARCHAR(32)   NULL,
    faPRICE         MONEY         NULL,
    faPHONE         VARCHAR(16)   NULL,
    faPIC1          VARCHAR(512)  NULL,
    faPICS          VARCHAR(8000) NOT NULL,
    faCOST          MONEY         NOT NULL,
    faCREATED       SMALLDATETIME NOT NULL,
    faLASTUPLOAD    SMALLDATETIME NOT NULL,
    faACTIVE        BIT           NOT NULL,
    faVIN_STOCK     VARCHAR(32)   NULL,
    fdUID           INT           NULL,   -- FK → FEEDDEALERS
    faVDP           VARCHAR(256)  NULL,
    faRadius        INT           NULL
);

-- Listing registry — canonical ad record per dealer listing
CREATE TABLE [MLdata].[Listing] (
    lst_ID          INT              NOT NULL,
    lst_GUID        UNIQUEIDENTIFIER NOT NULL,
    acc_ID          INT              NULL,  -- FK → MLdata.Account.acc_ID
    src_ID          INT              NOT NULL,
    scl_ID          INT              NOT NULL,
    rrg_ID          INT              NOT NULL,
    zip_Code        VARCHAR(5)       NOT NULL,
    lst_isSale      BIT              NOT NULL,
    lst_Type        TINYINT          NOT NULL,
    lst_Cost        MONEY            NOT NULL,
    lst_Price       MONEY            NOT NULL,
    lst_Headline    VARCHAR(64)      NOT NULL,
    lst_Title       VARCHAR(128)     NOT NULL,
    lss_ID          INT              NOT NULL,   -- subscription ID
    lst_Created     DATETIME         NOT NULL,
    lst_Modified    DATETIME         NOT NULL,
    lst_LastUpload  DATETIME         NULL,
    lst_Images      VARCHAR(8000)    NULL,
    lpt_ID          INT              NULL
    -- additional columns
);

-- Vehicle attributes per listing
CREATE TABLE [MLdata].[ListingVehicle] (
    lst_id          INT          NOT NULL,  -- FK → Listing.lst_ID
    veh_vin         VARCHAR(32)  NULL,
    veh_stock       VARCHAR(32)  NULL,
    veh_bodytype    VARCHAR(64)  NULL,
    veh_year        VARCHAR(4)   NULL,
    veh_make        VARCHAR(64)  NULL,
    veh_model       VARCHAR(64)  NULL,
    veh_trim        VARCHAR(128) NULL,
    veh_status      VARCHAR(32)  NULL,
    veh_mileage     VARCHAR(32)  NULL,
    veh_condition   VARCHAR(32)  NULL,
    veh_exteriorcolor VARCHAR(128) NULL,
    veh_interiorcolor VARCHAR(128) NULL,
    veh_fueltype    VARCHAR(32)  NULL,
    veh_Options     VARCHAR(4096) NULL
);

-- VIN-level Meta + Google performance by day
CREATE TABLE [MLdata].[VehiclePerformanceDaily] (
    common_client_id    INT           NULL,  -- FK → clientdb (INT, not varchar — no cast needed here)
    customer_name       VARCHAR(255)  NULL,
    campaign_date       DATE          NOT NULL,
    vehicle_year        INT           NULL,
    vehicle_make        VARCHAR(100)  NULL,
    vehicle_model       VARCHAR(100)  NULL,
    stock_number        VARCHAR(50)   NULL,
    vehicle_vin         VARCHAR(50)   NULL,
    vehicle_price       DECIMAL(18,2) NULL,
    meta_impressions    BIGINT        NOT NULL,
    gpm_impressions     BIGINT        NOT NULL,
    meta_vdp_clicks     BIGINT        NOT NULL,
    gpm_vdp_clicks      BIGINT        NOT NULL,
    delisted            INT           NULL,
    vehicle_trim        VARCHAR(128)  NULL,
    ownername           VARCHAR(255)  NULL,
    oems                NVARCHAR(500) NULL
);

-- Google Vehicle Ads VDP performance v2
CREATE TABLE [MLdata].[GVAVDPDatav2] (
    gva_date        INT           NOT NULL,  -- YYYYMMDD integer date
    client_id       BIGINT        NULL,
    client_name     VARCHAR(1024) NULL,
    campaign_id     BIGINT        NULL,
    campaign_name   VARCHAR(1024) NULL,
    landing_page    VARCHAR(2048) NULL,
    impressions     INT           NOT NULL,
    clicks          INT           NOT NULL,
    domain          VARCHAR(128)  NULL,
    fauid           INT           NULL,
    veh_vin         VARCHAR(17)   NULL,
    lst_id          INT           NULL   -- FK → Listing.lst_ID
);

-- PlatformAuto SRP/VDP stats
CREATE TABLE [MLdata].[PlatformAuto_Stats] (
    pls_id          BIGINT        NOT NULL,
    pls_date        INT           NOT NULL,  -- YYYYMMDD integer date
    veh_vin         VARCHAR(17)   NOT NULL,
    pla_dlr_id      BIGINT        NOT NULL,
    pla_lst_id      BIGINT        NOT NULL,
    acc_id          BIGINT        NOT NULL,
    srp_impressions INT           NOT NULL,
    vdp_impressions INT           NOT NULL,
    iml_id          INT           NOT NULL,
    lst_id          BIGINT        NULL,
    year            INT           NULL,
    make            VARCHAR(100)  NULL,
    model           VARCHAR(100)  NULL,
    campaign_id     INT           NULL
);

-- Master ML → CommonClientID mapping table — VARCHAR type mismatch
CREATE TABLE [MLdata].[ML_Account_Info] (
    acc_id          INT          NULL,
    core_client_id  VARCHAR(50)  NULL,
    common_client_id VARCHAR(50) NULL,  -- WARNING: VARCHAR(50), not INT — cast required to join clientdb
    acc_company     VARCHAR(100) NULL,
    acc_address     VARCHAR(100) NULL,
    acc_city        VARCHAR(100) NULL,
    acc_state       VARCHAR(2)   NULL,
    zip_Code        VARCHAR(10)  NULL,
    sfdc_account_id VARCHAR(50)  NULL
);

-- acc_id → sales_channel_id + ref_id cross-walk
CREATE TABLE [MLdata].[MLCommonClientIdMapping] (
    acc_id          INT         NOT NULL,
    sales_channel_id INT        NOT NULL,
    ref_id          VARCHAR(50) NOT NULL,
    client_id       VARCHAR(50) NULL
);

-- Display ad metrics
CREATE TABLE [MLdata].[Display] (
    dis_ID          INT     NOT NULL,
    iml_ID          INT     NOT NULL,
    dis_Date        DATE    NOT NULL,
    rcd_Master_ID   BIGINT  NULL,
    dis_Clicks      INT     NOT NULL,
    dis_Impressions INT     NOT NULL,
    dis_CPC         MONEY   NOT NULL,
    dis_Cost        MONEY   NOT NULL
);

-- Inbound listing leads
CREATE TABLE [MLdata].[LeadQueue] (
    ldq_ID          INT          NOT NULL,
    lst_ID          INT          NOT NULL,  -- FK → Listing.lst_ID
    ldq_Created     DATETIME     NOT NULL,
    ldq_FromMail    VARCHAR(256) NOT NULL,  -- PII
    ldq_FromFirstName VARCHAR(64) NOT NULL, -- PII
    ldq_FromLastName  VARCHAR(64) NOT NULL, -- PII
    ldq_FromZipCode VARCHAR(5)   NOT NULL,
    ldq_FromPhone   VARCHAR(16)  NOT NULL,  -- PII
    ldq_Message     VARCHAR(512) NOT NULL,
    ldq_Source      VARCHAR(32)  NULL
);

-- Additional MLdata tables (abbreviated)
CREATE TABLE [MLdata].[FEEDDEALERS]          (fdUID INT NOT NULL, fdPUBID INT NOT NULL);
CREATE TABLE [MLdata].[Account]              (acc_ID INT NOT NULL, acc_GUID UNIQUEIDENTIFIER NOT NULL, acc_Company VARCHAR(64) NOT NULL);
CREATE TABLE [MLdata].[VDPPerformance]       (acc_id BIGINT NOT NULL, vdp_date INT NOT NULL, impressions INT NOT NULL, clicks INT NOT NULL, cost FLOAT NOT NULL);
CREATE TABLE [MLdata].[VehiclePerformanceDailyV2] (common_client_id INT NULL, campaign_date DATE NOT NULL, vehicle_vin VARCHAR(50) NULL, meta_impressions BIGINT NOT NULL, gpm_impressions BIGINT NOT NULL);
CREATE TABLE [MLdata].[GVACampaignDataset]   (campaign_id BIGINT NULL, campaign_name VARCHAR(1024) NULL, impressions INT NOT NULL, clicks INT NOT NULL);
CREATE TABLE [MLdata].[GVAVDPData]           (gva_date INT NOT NULL, client_id BIGINT NULL, veh_vin VARCHAR(17) NULL, impressions INT NOT NULL);
CREATE TABLE [MLdata].[PlatformAuto_Campaigns] (plc_id BIGINT NOT NULL, acc_id BIGINT NOT NULL, plc_date INT NOT NULL, srp_visits INT NOT NULL, vdp_views INT NOT NULL, plc_cost FLOAT NOT NULL);
CREATE TABLE [MLdata].[srpactions_daily]     (lst_id INT NOT NULL, app_action INT NOT NULL, is_bot BIT NOT NULL, action_count BIGINT NOT NULL);
CREATE TABLE [MLdata].[VDPVINPerformance]    (acc_id BIGINT NOT NULL, veh_vin VARCHAR(17) NULL);
CREATE TABLE [MLdata].[__AllAdEzCampaigns]   (ratchet_id INT NULL, subscription_id INT NULL);
CREATE TABLE [MLdata].[_AllFlights]          (subscription_id INT NULL);
CREATE TABLE [MLdata].[ImportLog]            (Id INT NOT NULL, ImportDate DATETIME NULL, TableName VARCHAR(100) NULL, RowCount INT NULL);

-- =============================================================================
-- SCHEMA: RLData
-- Purpose: Response Logix lead management. 10 tables, 82M rows, 39 GB.
--          No CommonClientID — join path: lead → customer → AccountId → Stage_Accounts.
-- =============================================================================

-- Master lead record — 102 columns, full PII
CREATE TABLE [RLData].[lead] (
    lead_number         INT              NOT NULL,
    lead_id             UNIQUEIDENTIFIER NOT NULL,
    created_date        DATETIME         NOT NULL,
    lead_date           DATETIME         NOT NULL,
    first               VARCHAR(50)      NULL,   -- PII
    last                VARCHAR(50)      NULL,   -- PII
    email               VARCHAR(100)     NOT NULL, -- PII (NOT NULL but may be empty string)
    home_phone          VARCHAR(20)      NULL,   -- PII
    mobile_phone        VARCHAR(20)      NULL,   -- PII
    address_1           VARCHAR(100)     NULL,   -- PII
    city                VARCHAR(100)     NULL,
    state               VARCHAR(2)       NULL,
    zip                 VARCHAR(10)      NULL,
    country             VARCHAR(3)       NOT NULL,
    comments            VARCHAR(1000)    NULL,
    lp_make             VARCHAR(50)      NULL,
    lp_year             VARCHAR(10)      NULL,
    lp_model            VARCHAR(100)     NULL,
    lp_trim             VARCHAR(200)     NULL,
    lp_vin              VARCHAR(20)      NULL,
    customer_id         INT              NOT NULL, -- FK → RLData.customer.customer_id
    customer_name       VARCHAR(50)      NOT NULL,
    franchise_id        INT              NULL,
    status              VARCHAR(30)      NOT NULL,
    [type]              VARCHAR(10)      NOT NULL,
    lead_closed         BIT              NOT NULL
    -- ... (76 additional columns)
);

-- Lead lifecycle event log — 67M rows
CREATE TABLE [RLData].[lead_history] (
    id                  INT              NOT NULL,
    lead_history_id     UNIQUEIDENTIFIER NOT NULL,
    lead_id             UNIQUEIDENTIFIER NOT NULL,  -- FK → RLData.lead.lead_id
    history_date        DATETIME         NOT NULL,
    [type]              VARCHAR(100)     NOT NULL,
    logon               VARCHAR(50)      NULL,
    description_1       VARCHAR(900)     NULL,
    description_2       VARCHAR(900)     NULL,
    description_3       VARCHAR(MAX)     NULL,
    description_4       VARCHAR(MAX)     NULL,
    created_date        DATETIME         NOT NULL
);

-- Smart quote workflow — linked to lead_id
CREATE TABLE [RLData].[smart_quote] (
    smart_quote_id          UNIQUEIDENTIFIER NOT NULL,
    created_date            DATETIME         NOT NULL,
    lead_id                 UNIQUEIDENTIFIER NULL,  -- FK → RLData.lead.lead_id
    [type]                  VARCHAR(20)      NOT NULL,
    email                   VARCHAR(100)     NOT NULL,  -- PII
    home_phone              VARCHAR(20)      NULL,      -- PII
    make                    VARCHAR(50)      NULL,
    year                    VARCHAR(10)      NULL,
    model                   VARCHAR(100)     NULL,
    vin                     VARCHAR(20)      NULL,
    is_billable             BIT              NOT NULL,
    smart_quote_date        DATETIME         NOT NULL,
    id                      INT              NOT NULL
    -- additional columns
);

-- Reactivation campaign events
CREATE TABLE [RLData].[reactivation] (
    id                      INT              NOT NULL,
    reactivation_id         UNIQUEIDENTIFIER NOT NULL,
    created_date            DATETIME         NOT NULL,
    [type]                  VARCHAR(20)      NOT NULL,
    email                   VARCHAR(100)     NOT NULL,  -- PII
    vin                     VARCHAR(20)      NULL,
    make                    VARCHAR(50)      NULL,
    model                   VARCHAR(100)     NULL,
    is_billable             BIT              NOT NULL,
    smart_follow_txn_id     UNIQUEIDENTIFIER NOT NULL,
    reactivation_date       DATETIME         NOT NULL
    -- additional columns
);

-- Dealer (customer) registry
CREATE TABLE [RLData].[customer] (
    customer_id     INT              NOT NULL,
    name            VARCHAR(50)      NOT NULL,
    status          VARCHAR(10)      NOT NULL,
    customer_guid   UNIQUEIDENTIFIER NOT NULL,
    AccountId       INT              NULL,   -- FK → core.Stage_Accounts.Id (no CCI; join here for tenant scoping)
    ClientId        UNIQUEIDENTIFIER NULL,
    NewClientId     INT              NULL,
    reseller_id     INT              NOT NULL,
    zip             VARCHAR(10)      NOT NULL,
    last_updated_date DATETIME       NULL
);

-- Franchise to customer mapping
CREATE TABLE [RLData].[franchise] (
    franchise_id            INT              NOT NULL,
    created_date            DATETIME         NOT NULL,
    customer_id             INT              NOT NULL,  -- FK → RLData.customer
    make_id                 INT              NOT NULL,
    status                  VARCHAR(50)      NULL,
    franchise_guid          UNIQUEIDENTIFIER NOT NULL,
    core_account_guid       UNIQUEIDENTIFIER NULL   -- links to Radar/Stage_Accounts
    -- additional columns
);

-- Additional RLData tables
CREATE TABLE [RLData].[ChatStatistics]              (lead_number INT NOT NULL, lead_date DATETIME NOT NULL, customer_id INT NOT NULL, status SMALLINT NULL);
CREATE TABLE [RLData].[make]                         (make_id INT NOT NULL, name VARCHAR(50) NOT NULL, code CHAR(2) NULL);
CREATE TABLE [RLData].[smart_facts_report_data]      (id INT NOT NULL, lead_id UNIQUEIDENTIFIER NOT NULL, customer_id INT NOT NULL, franchise_id INT NULL, email VARCHAR(100) NOT NULL);
CREATE TABLE [RLData].[smart_follow_performance_report] (report_date DATE NOT NULL, [type] VARCHAR(20) NOT NULL, franchise_id INT NOT NULL, customer_id INT NOT NULL); -- clustered unique on (report_date, type, franchise_id, customer_id)

-- =============================================================================
-- SCHEMA: Google
-- Purpose: Google My Business dealer and vehicle VDP performance data.
--          No CommonClientID — join via DASID (mapping not in this database).
-- =============================================================================

-- Weekly GMB dealer performance
CREATE TABLE [Google].[DealershipDataFile] (
    WindowDate              VARCHAR(50)   NULL,
    DealershipName          VARCHAR(255)  NULL,
    DealershipAddress       VARCHAR(255)  NULL,
    PlaceID                 VARCHAR(255)  NULL,
    GoogleVDPImpressions    VARCHAR(255)  NULL,  -- WARNING: stored as varchar, not int
    DealerVDPClicks         INT           NULL,
    Calls                   INT           NULL,
    [Name]                  VARCHAR(255)  NULL,
    ZipCode                 VARCHAR(10)   NULL,
    DASID                   VARCHAR(255)  NULL,  -- External dealer ID — no CCI mapping in this DB
    DateWeek                DATETIME      NULL
);

-- GMB vehicle-level VDP data — 21M rows
CREATE TABLE [Google].[VehicleDataFile] (
    WindowDate          VARCHAR(50)   NULL,
    DealershipName      VARCHAR(255)  NULL,
    DealershipAddress   VARCHAR(255)  NULL,
    PlaceID             VARCHAR(255)  NULL,
    VIN                 VARCHAR(255)  NULL,
    Vehicle             VARCHAR(255)  NULL,
    DealerVDPClicks     INT           NULL,
    Calls               INT           NULL,
    [Name]              VARCHAR(255)  NULL,
    ZipCode             VARCHAR(10)   NULL,
    DASID               VARCHAR(255)  NULL   -- External dealer ID — no CCI mapping in this DB
);

-- =============================================================================
-- SCHEMA: AI
-- Purpose: LLM query log for ai.das-technology.com + 42 analytics views.
--          Tables are small; views wrap CDXP, core, MLdata, RLData tables.
-- =============================================================================

-- Query log for every AI assistant request
CREATE TABLE [AI].[Log_Questions] (
    Id                          INT          NOT NULL,  -- PK
    Question                    VARCHAR(MAX) NULL,   -- Natural language question
    Query                       VARCHAR(MAX) NULL,   -- Generated SQL or view reference
    NaturalResponse             VARCHAR(500) NULL,
    RAGContext                  VARCHAR(MAX) NULL,
    TotalRecords                INT          NULL,
    QuestionDate                DATETIME     NULL,
    Status                      VARCHAR(50)  NULL,
    ChartType                   VARCHAR(50)  NULL,
    DatasetJson                 VARCHAR(MAX) NULL,
    ViewName                    VARCHAR(100) NULL,
    TotalInputTokensQuery       INT          NULL,
    TotalOutputTokensQuery      INT          NULL,
    TotalInputTokensResponse    INT          NULL,
    TotalOutputTokensResponse   INT          NULL,
    TotalInputTokensAnalytics   INT          NULL,
    TotalOutputTokensAnalytics  INT          NULL,
    Error                       VARCHAR(MAX) NULL,
    Insight                     INT          NULL,
    AppInterface                VARCHAR(10)  NULL
);

-- User-annotated insights on AI query results
CREATE TABLE [AI].[Log_Questions_insights] (
    IdInsights  INT          NOT NULL,  -- PK
    Id          INT          NOT NULL,  -- FK → AI.Log_Questions.Id
    Title       VARCHAR(200) NOT NULL,
    DatasetJson VARCHAR(MAX) NULL,
    [View]      VARCHAR(200) NULL
);

-- =============================================================================
-- SCHEMA: dynamics
-- Purpose: Microsoft Dynamics 365 CRM data. 4 tables, 225K rows.
--          CommonClientId lives in Account_Lookup, not Account directly.
-- =============================================================================

-- Dynamics 365 account records (no direct CCI — use Account_Lookup)
CREATE TABLE [dynamics].[Account] (
    accountid               UNIQUEIDENTIFIER NOT NULL,  -- Dynamics account GUID (PK)
    new_accountguid         UNIQUEIDENTIFIER NULL,
    name                    NVARCHAR(400)    NULL,
    accountnumber           NVARCHAR(100)    NULL,
    parentaccountid         UNIQUEIDENTIFIER NULL,
    netwoven_accountype     INT              NULL,
    netwoven_clientid       UNIQUEIDENTIFIER NULL,
    das_3birdsid            NVARCHAR(100)    NULL,
    das_oemcode             NVARCHAR(200)    NULL,
    address1_line1          NVARCHAR(500)    NULL,
    address1_city           NVARCHAR(200)    NULL,
    address1_stateorprovince NVARCHAR(200)   NULL,
    address1_postalcode     NVARCHAR(40)     NULL,
    telephone1              NVARCHAR(100)    NULL,
    websiteurl              NVARCHAR(1000)   NULL
);

-- CCI mapping for Dynamics accounts
CREATE TABLE [dynamics].[Account_Lookup] (
    accountid           UNIQUEIDENTIFIER NOT NULL,  -- FK → dynamics.Account.accountid (clustered unique)
    oems                NVARCHAR(500)    NULL,
    ownername           NVARCHAR(510)    NULL,
    netwoven_clientid   UNIQUEIDENTIFIER NULL,
    CommonClientId      INT              NULL   -- FK → clientdb.ClientConsolidated.CommonClientId
);

-- CRM option set reference values
CREATE TABLE [dynamics].[OptionSet] (
    objecttypecode  NVARCHAR(200) NOT NULL,
    attributename   NVARCHAR(200) NOT NULL,
    attributevalue  INT           NOT NULL,
    value           NVARCHAR(500) NULL
);

-- Subscription order details
CREATE TABLE [dynamics].[SalesOrderDetail] (
    salesorderdetailid          UNIQUEIDENTIFIER NOT NULL,
    salesorderid                UNIQUEIDENTIFIER NULL,
    netwoven_account            UNIQUEIDENTIFIER NULL,  -- FK → dynamics.Account.accountid
    productid                   UNIQUEIDENTIFIER NULL,
    productname                 NVARCHAR(1000)   NULL,
    productnumber               NVARCHAR(200)    NULL,
    das_productcategorygrouping NVARCHAR(400)    NULL,
    das_productfamily           NVARCHAR(400)    NULL,
    netwoven_startdate          DATETIME         NULL,
    netwoven_status             INT              NULL,
    netwoven_cancellationdate   DATETIME         NULL,
    netwoven_chargename         NVARCHAR(400)    NULL,
    salesorderstatecode         INT              NULL,
    createdon                   DATETIME         NULL,
    modifiedon                  DATETIME         NULL
);

-- =============================================================================
-- SCHEMA: LVData
-- Purpose: LotVantage YouTube vehicle video performance.
--          No CommonClientID — join via dealership_id (mapping not in this DB).
-- =============================================================================

CREATE TABLE [LVData].[youtube_settings] (
    id              INT          NOT NULL,
    dealership_id   INT          NULL,   -- No CCI mapping in this DB
    channel         VARCHAR(255) NULL,
    channel_id      VARCHAR(191) NULL,
    channel_name    VARCHAR(191) NULL,
    maximum_live_videos BIGINT   NULL
    -- additional columns
);

CREATE TABLE [LVData].[youtube_videos] (
    id              INT          NOT NULL,
    vehicle_id      INT          NULL,
    dealership_id   INT          NULL,
    url             VARCHAR(255) NULL,
    external_id     VARCHAR(255) NULL,  -- YouTube video ID
    status          VARCHAR(10)  NULL,
    deleted_at      DATETIME     NULL   -- Soft delete
    -- additional columns
);

CREATE TABLE [LVData].[youtube_video_stats] (
    id              INT      NOT NULL,
    youtube_video_id INT     NOT NULL,  -- FK → youtube_videos.id
    view_count      INT      NOT NULL,
    like_count      INT      NOT NULL,
    comment_count   INT      NOT NULL,
    created_at      DATETIME NULL,
    updated_at      DATETIME NULL
);

CREATE TABLE [LVData].[youtube_voice_recordings] (
    id          INT          NOT NULL,
    vehicle_id  INT          NOT NULL,
    external_id VARCHAR(255) NULL,
    status      NVARCHAR(510) NULL,
    voice       VARCHAR(10)  NOT NULL,
    url         VARCHAR(255) NULL,
    [text]      NVARCHAR(MAX) NULL,  -- Voice script text
    deleted_at  DATETIME     NULL   -- Soft delete
);

CREATE TABLE [LVData].[youtube_video_daily_stats] (
    -- Nearly empty (3 rows) — may be deprecated
    id INT NOT NULL
);

-- =============================================================================
-- SCHEMA: radar
-- Purpose: Reputation management configuration (MongoDB flat dump).
--          All 47 columns are typed text. commonClientID is TEXT (not INT).
-- =============================================================================

-- Client reputation config — all columns text (MongoDB flat export)
CREATE TABLE [radar].[clientConfigurations] (
    _id             TEXT NULL,
    clientid        TEXT NULL,
    ClientName      TEXT NULL,
    enabled         TEXT NULL,
    reviewsites_id              TEXT NULL,
    reviewsites_displayName     TEXT NULL,
    reviewsites_enabled         TEXT NULL,
    reviewsites_reviewSiteId    TEXT NULL,
    slaResponseTimeInHours_numberInt INT NULL,
    aiprompts       TEXT NULL,
    signatures_id   TEXT NULL,
    signatures_content TEXT NULL,
    signatures_clientId TEXT NULL,
    contactUsers_email TEXT NULL,    -- PII
    contactUsers_fullname TEXT NULL, -- PII
    changeHistory   TEXT NULL,
    commonClientID  TEXT NULL   -- WARNING: TEXT, not INT — CAST required to join clientdb
);

-- Review records with response text
CREATE TABLE [radar].[Reviews] (
    ClientName          NVARCHAR(200) NULL,
    DateReviewIngested  DATETIME      NULL,
    DateResponsePosted  DATETIME      NULL,
    StarRating          INT           NULL,
    ReviewSite          NVARCHAR(510) NULL,
    ReviewerHandle      NVARCHAR(200) NULL,
    ReviewText          NVARCHAR(MAX) NULL,
    ResponseText        NVARCHAR(MAX) NULL,
    StatusOfReview      NVARCHAR(100) NULL
    -- No CommonClientID — join via ClientName to clientdb
);

-- =============================================================================
-- SCHEMA: RPData
-- Purpose: RocketChat/LiveJoin chat leads. Company and Messages tables are empty.
-- =============================================================================

CREATE TABLE [RPData].[Company] (
    Id          NVARCHAR(200) NULL,
    Title       NVARCHAR(510) NULL,
    [Type]      NVARCHAR(200) NULL,
    Status      NVARCHAR(200) NULL,
    clientId    NVARCHAR(510) NULL,  -- Maps to DAS client (format unconfirmed)
    Tier        NVARCHAR(200) NULL,
    CreatedAt   DATETIME      NULL
    -- additional columns
);

CREATE TABLE [RPData].[Leads] (
    Id              NVARCHAR(200) NULL,
    CompanyId       NVARCHAR(510) NULL,
    ClientPhone     NVARCHAR(200) NULL,  -- PII
    ClientEmail     NVARCHAR(510) NULL,  -- PII
    FirstName       NVARCHAR(510) NULL,  -- PII
    LastName        NVARCHAR(510) NULL,  -- PII
    Status          NVARCHAR(200) NULL,
    CreatedAt       DATETIME      NULL,
    [Type]          NVARCHAR(200) NULL,
    Source          NVARCHAR(200) NULL,
    Closed          BIT           NULL
);

CREATE TABLE [RPData].[Messages] (
    Id              NVARCHAR(200) NULL,
    ConversationId  NVARCHAR(200) NULL,
    CompanyId       NVARCHAR(200) NULL,
    [Type]          NVARCHAR(200) NULL,
    [Text]          NVARCHAR(MAX) NULL,
    CreatedAt       NVARCHAR(200) NULL,
    ChannelType     NVARCHAR(200) NULL
);

-- =============================================================================
-- SCHEMA: juice
-- Purpose: Cross-source review consolidation. CommonClientId (INT FK).
-- =============================================================================

-- Single-table cross-source review view — cleanest review surface
CREATE TABLE [juice].[Review] (
    Id              INT              NOT NULL,
    ReviewSourceName NVARCHAR(100)   NULL,
    AccountName     NVARCHAR(510)    NULL,
    CommonClientId  INT              NULL,  -- FK → clientdb.ClientConsolidated.CommonClientId
    ReviewGuid      UNIQUEIDENTIFIER NOT NULL,
    ReviewSourceId  INT              NOT NULL,
    AccountGuid     UNIQUEIDENTIFIER NOT NULL,
    ReviewSiteId    INT              NOT NULL,
    ReviewScore     DECIMAL(9,4)     NULL,
    ReviewerName    NVARCHAR(400)    NULL,
    ReviewerCity    NVARCHAR(400)    NULL,
    ReviewerState   NVARCHAR(400)    NULL,
    ReviewUrl       VARCHAR(2083)    NULL,
    ReviewTitle     NVARCHAR(MAX)    NULL,
    ReviewComment   NVARCHAR(MAX)    NULL,
    ReviewDate      DATETIME         NULL,
    Created         DATETIME         NULL,
    Modified        DATETIME         NULL,
    SoftDeleteDateUTC DATETIME       NULL
    -- Note: duplicate column pairs (Created/Created1, etc.) exist — schema merge artifact
);

-- =============================================================================
-- SCHEMA: zuora
-- Purpose: Billing data. ClientID (varchar 50) maps to CommonClientId.
-- =============================================================================

-- Zuora billing accounts — all columns varchar (no typed numerics)
CREATE TABLE [zuora].[AccountStage] (
    AccountNumber           VARCHAR(255)  NULL,
    Name                    VARCHAR(255)  NULL,
    Status                  VARCHAR(255)  NULL,
    Balance                 VARCHAR(18)   NULL,  -- WARNING: varchar, not decimal — cast required
    CreditBalance           VARCHAR(18)   NULL,  -- WARNING: varchar, not decimal — cast required
    TotalInvoiceBalance     VARCHAR(18)   NULL,  -- WARNING: varchar, not decimal — cast required
    CrmId                   VARCHAR(255)  NULL,  -- FK → dynamics.Account.accountid
    Currency                VARCHAR(255)  NULL,
    AutoPay                 VARCHAR(10)   NULL,
    PaymentTerm             VARCHAR(255)  NULL,
    BillCycleDay            VARCHAR(18)   NULL,
    SalesRepName            VARCHAR(1000) NULL,
    Notes                   VARCHAR(MAX)  NULL,
    Id                      VARCHAR(255)  NULL,
    CreatedDate             VARCHAR(255)  NULL,
    UpdatedDate             VARCHAR(255)  NULL,
    ClientID                VARCHAR(50)   NULL   -- Maps to CommonClientId — WARNING: varchar, not INT — cast required
);

-- Fiscal accounting period reference (currently empty)
CREATE TABLE [zuora].[AccountingPeriodStage] (
    Id              VARCHAR(50)   NULL,
    Name            VARCHAR(255)  NULL,
    FiscalYear      VARCHAR(4)    NULL,
    FiscalQuarter   VARCHAR(255)  NULL,
    StartDate       VARCHAR(24)   NULL,
    EndDate         VARCHAR(24)   NULL,
    Status          VARCHAR(50)   NULL,
    Notes           VARCHAR(255)  NULL
);

-- =============================================================================
-- INDEX DEFINITIONS
-- =============================================================================

-- AI schema
CREATE UNIQUE CLUSTERED INDEX [PK_Log_Questions]            ON [AI].[Log_Questions]            (Id);
CREATE UNIQUE CLUSTERED INDEX [PK_Log_Questions_insights]   ON [AI].[Log_Questions_insights]   (IdInsights);

-- core schema — review indexes
CREATE CLUSTERED INDEX  [IDX_Stage_Stage_Review_Created]              ON [core].[Stage_Review]   (Created);
CREATE NONCLUSTERED INDEX [IX_Stage_Review_AccountGuid_Created_INCL_Columns] ON [core].[Stage_Review] (AccountGuid, Created);
CREATE NONCLUSTERED INDEX [IX_Stage_Review_AccountGuid_INCL_ReviewScore]      ON [core].[Stage_Review] (AccountGuid);
CREATE NONCLUSTERED INDEX [IX_Stage_Review_Created_Covering_Full]             ON [core].[Stage_Review] (Created, AccountGuid);
CREATE CLUSTERED INDEX  [IDX_Stage_Review2024_Created]                ON [core].[Stage_Review2024] (Created);
CREATE NONCLUSTERED INDEX [IDX_Stage_Review2024_AccountGuid_ReviewSourceId_ReviewSiteId] ON [core].[Stage_Review2024] (AccountGuid, ReviewSourceId, ReviewSiteId);

-- core schema — survey indexes
CREATE CLUSTERED INDEX  [IDX_Stage_Surveys_SentDate]         ON [core].[Stage_Surveys]      (SentDate);
CREATE NONCLUSTERED INDEX [IX_Stage_Surveys_Id_SentDate_Optimized] ON [core].[Stage_Surveys] (Id, SentDate);
CREATE CLUSTERED INDEX  [IDX_Stage_SurveyHistory_ActionTime] ON [core].[Stage_SurveyHistory] (ActionTime);
CREATE CLUSTERED INDEX  [CIX_Stage_SurveyResponse_SurveyId]  ON [core].[Stage_SurveyResponse] (SurveyId);
CREATE NONCLUSTERED INDEX [IDX_Stage_SurveyResponse_ResponseDate_NC] ON [core].[Stage_SurveyResponse] (ResponseDate);

-- core schema — account indexes
CREATE CLUSTERED INDEX  [CIX_Stage_Accounts_Id]              ON [core].[Stage_Accounts] (Id);
CREATE NONCLUSTERED INDEX [IX_Stage_Accounts_Id_Deleted_INCL_Name_Brands] ON [core].[Stage_Accounts] (Id, Deleted);
CREATE NONCLUSTERED INDEX [IX_Stage_Accounts_Token_Deleted_V3_Optimized]  ON [core].[Stage_Accounts] (Token, Deleted);

-- core schema — transaction indexes
CREATE CLUSTERED INDEX  [CIX_Stage_Txns_TxnDate]             ON [core].[Stage_Txns] (TxnDate);

-- core schema — t_Reviews covering indexes
CREATE NONCLUSTERED INDEX [IX_t_Reviews_CommonClientId]  ON [core].[t_Reviews] (CommonClientId);
CREATE NONCLUSTERED INDEX [IX_t_Reviews_AccountGuid]     ON [core].[t_Reviews] (AccountGuid);
CREATE NONCLUSTERED INDEX [IX_t_Reviews_ReviewSite]      ON [core].[t_Reviews] (ReviewSite);
CREATE NONCLUSTERED INDEX [IX_t_Reviews_PublicationDate] ON [core].[t_Reviews] (PublicationDate);
CREATE NONCLUSTERED INDEX [IX_t_Reviews_AccountName]     ON [core].[t_Reviews] (AccountName);
CREATE NONCLUSTERED INDEX [IX_t_Reviews_State]           ON [core].[t_Reviews] (State);

-- core schema — t_Surveys covering indexes
CREATE NONCLUSTERED INDEX [IX_t_Surveys_CommonClientId]  ON [core].[t_Surveys] (CommonClientId);
CREATE NONCLUSTERED INDEX [IX_t_Surveys_AccountId]       ON [core].[t_Surveys] (AccountId);
CREATE NONCLUSTERED INDEX [IX_t_Surveys_SentDate]        ON [core].[t_Surveys] (SentDate);
CREATE NONCLUSTERED INDEX [IX_t_Surveys_Type]            ON [core].[t_Surveys] ([Type]);

-- dynamics schema indexes
CREATE UNIQUE CLUSTERED INDEX [IX_Account_Lookup_accountid] ON [dynamics].[Account_Lookup] (accountid);
CREATE NONCLUSTERED INDEX [IX_Account_Lookup_netwoven_clientid] ON [dynamics].[Account_Lookup] (netwoven_clientid);
CREATE NONCLUSTERED INDEX [IX_Account_accountype_accountid]     ON [dynamics].[Account] (netwoven_accountype, accountid);
CREATE NONCLUSTERED INDEX [IX_Account_parentaccountid]          ON [dynamics].[Account] (parentaccountid);

-- juice schema
CREATE CLUSTERED INDEX [IDX_Juice_Review_ID] ON [juice].[Review] (Id);

-- MLdata schema — high-volume table indexes
CREATE NONCLUSTERED INDEX [IX_FEEDADS_faVIN]               ON [MLdata].[FEEDADS] (faVIN);
CREATE NONCLUSTERED INDEX [IX_grail_srpactions_LstId_Date] ON [MLdata].[grail_srpactions_daily] (lst_id, event_date);
CREATE NONCLUSTERED INDEX [IX_grail_eventdate_appaction_isbot_lstid] ON [MLdata].[grail_srpactions_daily] (event_date, app_action, is_bot, lst_id);
CREATE NONCLUSTERED INDEX [IX_Listing_LstID_AccID]         ON [MLdata].[Listing] (lst_ID);
CREATE NONCLUSTERED INDEX [IX_Listing_lstID_accID_lastupload] ON [MLdata].[Listing] (lst_ID, acc_ID, lst_LastUpload);
CREATE NONCLUSTERED INDEX [IX_ListingVehicle_lstId_vin]    ON [MLdata].[ListingVehicle] (lst_id, veh_vin);
CREATE NONCLUSTERED INDEX [IX_GVAVDPDatav2_Date_LstId_Vin] ON [MLdata].[GVAVDPDatav2] (gva_date, lst_id, veh_vin);
CREATE NONCLUSTERED INDEX [IX_VPDM_campaign_date]          ON [MLdata].[VehiclePerformanceDaily] (campaign_date);
CREATE NONCLUSTERED INDEX [IX_ML_Account_Info_acc_id]      ON [MLdata].[ML_Account_Info] (acc_id);
CREATE NONCLUSTERED INDEX [IX_PlatformAutoStats_lstID]     ON [MLdata].[PlatformAuto_Stats] (lst_id);

-- RLData schema indexes
CREATE NONCLUSTERED INDEX [IX_lead_date_status_covering]   ON [RLData].[lead] (lead_date, status);
CREATE NONCLUSTERED INDEX [IX_lead_dateonly_covering]      ON [RLData].[lead] (lead_date, lead_id);
CREATE NONCLUSTERED INDEX [IX_lead_make_model_date_type]   ON [RLData].[lead] (lp_make, lp_model, lead_date, [type]);
CREATE NONCLUSTERED INDEX [IX_lead_history_date_type]      ON [RLData].[lead_history] (history_date, [type]);
CREATE NONCLUSTERED INDEX [IX_lead_history_leadid_type]    ON [RLData].[lead_history] (lead_id, [type]);
CREATE UNIQUE CLUSTERED INDEX [ak_smart_follow_performance_report_date_type_franchise_id_customer_id]
    ON [RLData].[smart_follow_performance_report] (report_date, [type], franchise_id, customer_id);
CREATE NONCLUSTERED INDEX [IX_smart_quote_created_billable] ON [RLData].[smart_quote] (is_billable, created_date, lead_id);
CREATE NONCLUSTERED INDEX [IX_reactivation_smart_follow_txn_id] ON [RLData].[reactivation] (smart_follow_txn_id);

-- =============================================================================
-- VIEW DEFINITIONS (headers only — definitions not returned by discovery query)
-- =============================================================================

-- AI schema views — query surface for ai.das-technology.com
CREATE OR ALTER VIEW [AI].[v_CDXP_BlueSkyOverview]                  AS SELECT * FROM [CDXP].[JuiceReporting_BlueSkyOverview];          -- stub
CREATE OR ALTER VIEW [AI].[v_CDXP_Marketing_Summary]                AS SELECT * FROM [CDXP].[JuiceReporting_Marketing_Summary];         -- stub
CREATE OR ALTER VIEW [AI].[v_CDXP_HiddenTable_MarketingSummary]     AS SELECT * FROM [CDXP].[JuiceReporting_HiddenTable_MarketingSummary]; -- stub
CREATE OR ALTER VIEW [AI].[v_CDXP_LeadPerformance]                  AS SELECT * FROM [CDXP].[JuiceReporting_LeadPerformance];           -- stub
CREATE OR ALTER VIEW [AI].[v_CDXP_mv_contact_stats]                 AS SELECT * FROM [CDXP].[mv_contact_stats];                        -- stub
CREATE OR ALTER VIEW [AI].[v_CDXP_CDXPTransactionsOverview]         AS SELECT * FROM [CDXP].[JuiceReporting_CDXPTransactionsOverview];  -- stub
CREATE OR ALTER VIEW [AI].[v_CDXP_CDXPCustomers]                    AS SELECT * FROM [CDXP].[JuiceReporting_CDXPCustomers];             -- stub
CREATE OR ALTER VIEW [AI].[JuiceReporting_BSR_equity]               AS SELECT * FROM [CDXP].[JuiceReporting_BSR_equity];               -- stub
CREATE OR ALTER VIEW [AI].[v_CDXP_MatchBacks]                       AS SELECT * FROM [CDXP].[JuiceReporting_MatchBacks];               -- stub
CREATE OR ALTER VIEW [AI].[v_CDXP_TRANSACTION_SUMMARY]              AS SELECT * FROM [CDXP].[JuiceReporting_TRANSACTION_SUMMARY];      -- stub
CREATE OR ALTER VIEW [AI].[v_CDXP_RecipientLoss]                    AS SELECT * FROM [CDXP].[JuiceReporting_RecipientLoss];            -- stub
CREATE OR ALTER VIEW [AI].[v_CDXP_BlueSkyCurrentLeads]              AS SELECT * FROM [CDXP].[JuiceReportingBlueSkyCurrentLeads];       -- stub
CREATE OR ALTER VIEW [AI].[v_CDXP_MarketingPerformance]             AS SELECT * FROM [CDXP].[JuiceReporting_MarketingPerformance];     -- stub
CREATE OR ALTER VIEW [AI].[v_CDXP_DataMiningTool]                   AS SELECT * FROM [CDXP].[JuiceReporting_DataMiningTool];           -- stub
CREATE OR ALTER VIEW [AI].[v_CDXP_BlueSkyRecommendations]           AS SELECT * FROM [CDXP].[JuiceReporting_BlueSkyRecommendations];   -- stub
CREATE OR ALTER VIEW [AI].[v_CDXP_BlueSkyServicePerformance]        AS SELECT * FROM [CDXP].[JuiceReporting_BlueSkyServicePerformance]; -- stub
CREATE OR ALTER VIEW [AI].[v_CDXP_BlueSky_ServicePerf_V2]           AS SELECT * FROM [CDXP].[JuiceReporting_BlueSky_ServicePerf_V2];   -- stub
CREATE OR ALTER VIEW [AI].[v_CDXP_LeadPerformance_LeadSourceIndex]  AS SELECT * FROM [CDXP].[JuiceReporting_LeadPerformance_LeadSourceIndex]; -- stub
CREATE OR ALTER VIEW [AI].[v_CDXP_NEW_RECIPIENTS]                   AS SELECT * FROM [CDXP].[JuiceReporting_NEW_RECIPIENTS];           -- stub
CREATE OR ALTER VIEW [AI].[v_CDXP_BlueSkyOverview_v2]               AS SELECT * FROM [CDXP].[JuiceReporting_BlueSkyOverview_v2];       -- stub
CREATE OR ALTER VIEW [AI].[v_CDXP_Marketing_Summary_Contact_eng]    AS SELECT * FROM [CDXP].[JuiceReporting_Marketing_Summary_Contact_eng]; -- stub
CREATE OR ALTER VIEW [AI].[v_CDXP_ZipCode_Geo]                      AS SELECT * FROM [CDXP].[Juice_ZipCode_Geo];                      -- stub
CREATE OR ALTER VIEW [AI].[v_ML_VehiclePerformanceDaily]            AS SELECT * FROM [MLdata].[VehiclePerformanceDaily];               -- stub
CREATE OR ALTER VIEW [AI].[v_ML_CampaignLevelPerformance]           AS SELECT * FROM [MLdata].[PlatformAuto_Campaigns];               -- stub (multi-table join)
CREATE OR ALTER VIEW [AI].[MLCampaign_VDP_Performance]              AS SELECT * FROM [MLdata].[VDPPerformance];                       -- stub
CREATE OR ALTER VIEW [AI].[GVACampaignData]                         AS SELECT * FROM [MLdata].[GVACampaignDataset];                   -- stub
CREATE OR ALTER VIEW [AI].[GVACampaignDataByVINv3]                  AS SELECT * FROM [MLdata].[GVAVDPDatav2];                         -- stub
CREATE OR ALTER VIEW [AI].[GVACampaignDataByVINDelistedv3]          AS SELECT * FROM [MLdata].[GVAVDPDatav2];                         -- stub (adds delisted filter)
CREATE OR ALTER VIEW [AI].[VDPData_ML_Google]                       AS SELECT * FROM [MLdata].[VehiclePerformanceDaily];               -- stub (multi-table join with Google)
CREATE OR ALTER VIEW [AI].[VDPData_ML_Google2]                      AS SELECT * FROM [MLdata].[VehiclePerformanceDaily];               -- stub
CREATE OR ALTER VIEW [AI].[MAIACampaignData]                        AS SELECT * FROM [MLdata].[Display];                              -- stub
CREATE OR ALTER VIEW [AI].[TikTokCampaignData]                      AS SELECT * FROM [MLdata].[Display];                              -- stub
CREATE OR ALTER VIEW [AI].[MLData_VIN_Meta_Google_VDP_12month]      AS SELECT * FROM [MLdata].[VehiclePerformanceDaily];               -- stub (12-month window)
CREATE OR ALTER VIEW [AI].[v_RL_Leads]                              AS SELECT * FROM [RLData].[lead];                                 -- stub
CREATE OR ALTER VIEW [AI].[v_RL_Leads_Reactivations]                AS SELECT * FROM [RLData].[reactivation];                        -- stub
CREATE OR ALTER VIEW [AI].[v_RL_Smart_Follow]                       AS SELECT * FROM [RLData].[smart_follow_performance_report];      -- stub
CREATE OR ALTER VIEW [AI].[v_SL_Accounts]                           AS SELECT * FROM [core].[Stage_Accounts];                        -- stub
CREATE OR ALTER VIEW [AI].[v_SL_Reviews]                            AS SELECT * FROM [core].[Stage_Review];                          -- stub
CREATE OR ALTER VIEW [AI].[v_SL_Surveys]                            AS SELECT * FROM [core].[Stage_Surveys];                         -- stub
CREATE OR ALTER VIEW [AI].[v_SL_MRSReviewRequest]                   AS SELECT * FROM [core].[Stage_MRSReviewRequest];                -- stub
CREATE OR ALTER VIEW [AI].[v_SL_SurveyResponseGen2]                 AS SELECT * FROM [core].[Stage_SurveyResponse];                  -- stub
CREATE OR ALTER VIEW [AI].[v_SurveySendSummary]                     AS SELECT * FROM [core].[Stage_Surveys];                         -- stub (aggregated)

-- core schema views
CREATE OR ALTER VIEW [core].[v_Reviews]             AS SELECT * FROM [core].[Stage_Review];       -- stub
CREATE OR ALTER VIEW [core].[v_Surveys]             AS SELECT * FROM [core].[Stage_Surveys];      -- stub
CREATE OR ALTER VIEW [core].[v_SurveyResponseGen2]  AS SELECT * FROM [core].[Stage_SurveyResponse]; -- stub
CREATE OR ALTER VIEW [core].[v_SurveySendSummary]   AS SELECT * FROM [core].[Stage_Surveys];      -- stub (aggregated)
CREATE OR ALTER VIEW [core].[v_MRSReviewRequest]    AS SELECT * FROM [core].[Stage_MRSReviewRequest]; -- stub
CREATE OR ALTER VIEW [core].[v_SocialAdsCampaign]   AS SELECT * FROM [core].[Stage_SocialAdsCampaign]; -- stub
CREATE OR ALTER VIEW [core].[v_AllTimePerformance]  AS SELECT * FROM [core].[Stage_Review];       -- stub (multi-table join)

-- dbo schema views
CREATE OR ALTER VIEW [dbo].[v_RL_Leads]             AS SELECT * FROM [RLData].[lead];             -- stub
CREATE OR ALTER VIEW [dbo].[v_RL_Leads_dev]         AS SELECT * FROM [RLData].[lead];             -- stub (dev variant)
CREATE OR ALTER VIEW [dbo].[v_RL_Leads_Reactivations] AS SELECT * FROM [RLData].[reactivation];  -- stub
CREATE OR ALTER VIEW [dbo].[v_RL_OptOuts]           AS SELECT * FROM [RLData].[lead];             -- stub (opt-out filter)
CREATE OR ALTER VIEW [dbo].[v_RL_Smart_Follow]      AS SELECT * FROM [RLData].[smart_follow_performance_report]; -- stub

-- dynamics schema views
CREATE OR ALTER VIEW [dynamics].[v_AccountProducts]   AS SELECT * FROM [dynamics].[SalesOrderDetail]; -- stub
CREATE OR ALTER VIEW [dynamics].[v_AccountProductsV2] AS SELECT * FROM [dynamics].[SalesOrderDetail]; -- stub (v2 with additional fields)

-- MLdata schema views
CREATE OR ALTER VIEW [MLdata].[v_ML_CampaignPerformanceDaily] AS SELECT * FROM [MLdata].[PlatformAuto_Campaigns]; -- stub
CREATE OR ALTER VIEW [MLdata].[v_ML_VehiclePerformanceDaily]  AS SELECT * FROM [MLdata].[VehiclePerformanceDaily]; -- stub

GO
-- =============================================================================
-- END OF FILE
-- DataStaging DDL — generated 2026-06-14 by discovery runbook
-- All view definitions are stubs (discovery query returned empty definitions).
-- Run OBJECT_DEFINITION() against production to retrieve full view bodies.
-- =============================================================================
