-- =============================================================================
-- Database:     Feedhub
-- Server:       40.83.161.93,1433  (DWRPT server)
-- Discovered:   2026-06-14
-- Researcher:   Alicia Salazar
-- Access:       PARTIAL — ConflictAI login has no user mapping in Feedhub.
--               Schema inferred from DataStaging.MLdata ETL copies (FEEDADS,
--               FEEDDEALERS) and msdb.backupset metadata.
-- Description:  CIM (Car Inventory Management) automotive feed syndication
--               database. Stores dealer profiles and vehicle inventory listings
--               distributed as ad feeds to publisher editions.
-- Notes:
--   - Direct DBA access needed for: stored procedures, views, native indexes,
--     lookup tables (FeedPublications, FeedEditions, FeedCustomers, etc.)
--   - To grant access: USE Feedhub; CREATE USER ConflictAI FOR LOGIN ConflictAI;
--     EXEC sp_addrolemember 'db_datareader', 'ConflictAI';
--   - Column prefix convention: fd = feed dealer, fa = feed ad
--   - Inferred tables are marked with -- INFERRED below
-- =============================================================================

USE [Feedhub];
GO

-- =============================================================================
-- TABLE: dbo.FeedDealers
-- Purpose: Master registry of automotive dealers enrolled in the CIM feed
--          syndication system. One row per dealer per publisher edition.
--          22,800 rows confirmed via DataStaging.MLdata.FEEDDEALERS ETL copy.
-- =============================================================================
CREATE TABLE [dbo].[FeedDealers] (
    [fdUID]         INT             NOT NULL,                    -- PK — surrogate dealer key; FK target for FeedAds.fdUID
    [fdID]          VARCHAR(20)     NULL,                        -- External dealer code (e.g. "18047", "001123")
    [fdPUBID]       INT             NOT NULL,                    -- FK → FeedPublications.fdPUBID — publisher association
    [fdEDID]        INT             NOT NULL,                    -- FK → FeedEditions.fdEDID — edition/market assignment
    [fdCUSID]       INT             NOT NULL,                    -- FK → FeedCustomers.fdCUSID — billing/customer account
    [fdNAME]        VARCHAR(64)     NOT NULL,                    -- Dealer business name — PII-adjacent
    [fdADDR]        VARCHAR(128)    NULL,                        -- Street address
    [fdCITY]        VARCHAR(64)     NULL,                        -- City
    [fdSTATE]       VARCHAR(2)      NOT NULL,                    -- State abbreviation (2-char)
    [fdZIP]         VARCHAR(10)     NOT NULL,                    -- ZIP / postal code
    [fdPHONE]       VARCHAR(20)     NULL,                        -- Primary phone — PII
    [fdALTPHONE]    VARCHAR(20)     NULL,                        -- Alternate phone — PII
    [fdFAX]         VARCHAR(20)     NULL,                        -- Fax number
    [fdEMAIL_STRING] VARCHAR(96)    NULL,                        -- Sales/contact email — PII
    [fdEMAIL_XML]   VARCHAR(96)     NULL,                        -- Lead routing email (motosnap.com domain) — PII
    [fdURL]         VARCHAR(128)    NULL,                        -- Dealer website URL
    [fdPROFILE]     TINYINT         NOT NULL,                    -- Profile display flag (0 = none, 1 = enabled)
    [fdIMG1]        VARCHAR(128)    NULL,                        -- Dealer logo/image 1 filename
    [fdIMG2]        VARCHAR(128)    NULL,                        -- Dealer logo/image 2 filename
    [fdIMG3]        VARCHAR(128)    NULL,                        -- Dealer logo/image 3 filename
    [fdIMG4]        VARCHAR(128)    NULL,                        -- Dealer logo/image 4 filename
    [fdSHOWOTHER]   BIT             NOT NULL,                    -- Show competitor listings on dealer page flag
    [fdCAO]         BIT             NOT NULL,                    -- CAO (Call-Around-Only or campaign opt-in) flag
    [dlrID]         INT             NULL,                        -- Cross-system dealer ID → DataStaging.MLdata dealer ref
    [fdUIDMaster]   INT             NULL,                        -- FK → FeedDealers.fdUID (self-ref: dealer group hierarchy)

    CONSTRAINT [PK_FeedDealers] PRIMARY KEY CLUSTERED ([fdUID] ASC)
);
GO

-- =============================================================================
-- TABLE: dbo.FeedAds
-- Purpose: Vehicle inventory listing records — one row per vehicle advertisement
--          per publisher edition. Stores VIN, vehicle attributes, pricing,
--          photos, VDP URLs, and syndication metadata.
--          8,030,440 rows confirmed via DataStaging.MLdata.FEEDADS ETL copy.
--          NOTE: faUID is the surrogate ad key; PK constraint not confirmed
--          (direct sys.objects access was blocked).
-- =============================================================================
CREATE TABLE [dbo].[FeedAds] (
    [faUID]         INT             NOT NULL,                    -- Surrogate ad key (PK unconfirmed — direct access blocked)
    [fdPUBID]       INT             NOT NULL,                    -- FK → FeedPublications.fdPUBID — publisher this ad runs in
    [fdEDID]        INT             NOT NULL,                    -- FK → FeedEditions.fdEDID — edition/market for this ad
    [faSCLID]       INT             NULL,                        -- FK → FeedSubscriptions.faSCLID — subscription line (inferred)
    [adID]          INT             NULL,                        -- Cross-system ad ID → subscription/AdEz ad record
    [fdUID]         INT             NULL,                        -- FK → FeedDealers.fdUID — owning dealer
    [faVIN]         VARCHAR(64)     NOT NULL,                    -- Vehicle Identification Number — primary vehicle identity key
    [faADNUM]       INT             NOT NULL,                    -- Ad sequence number within the feed
    [faCAT]         VARCHAR(20)     NULL,                        -- Vehicle category (SEDAN, OTHER, etc.)
    [faTYPE]        TINYINT         NOT NULL,                    -- Ad type code (0=standard, 3=commercial/fleet)
    [faSPECIAL]     TINYINT         NOT NULL,                    -- Special placement flag
    [faTOP]         TINYINT         NOT NULL,                    -- Top-of-feed priority ranking
    [faBOXED]       BIT             NOT NULL,                    -- Boxed ad display format flag
    [faHEADLINE]    VARCHAR(255)    NULL,                        -- Ad headline (typically "YEAR MAKE MODEL TRIM")
    [faTEXT]        VARCHAR(MAX)    NULL,                        -- Full ad body text (plain text)
    [faHTML]        TEXT            NULL,                        -- HTML-rendered ad content — legacy TEXT type; migrate to VARCHAR(MAX)
    [faYEAR]        SMALLINT        NULL,                        -- Vehicle model year
    [faMAKE]        VARCHAR(32)     NULL,                        -- Vehicle make (GMC, Ford, Toyota, etc.)
    [faMODEL]       VARCHAR(128)    NULL,                        -- Vehicle model
    [faSUBMODEL]    VARCHAR(255)    NULL,                        -- Trim / sub-model description
    [faPRICE]       MONEY           NULL,                        -- Listed sale price; $0.0 may indicate "price on request"
    [faCOST]        MONEY           NULL,                        -- Dealer invoice/cost price — commercially sensitive; restrict access
    [faPHONE]       VARCHAR(20)     NULL,                        -- Contact phone on ad — PII
    [faPIC1]        VARCHAR(255)    NULL,                        -- Primary photo URL
    [faPIC2]        VARCHAR(255)    NULL,                        -- Secondary photo URL
    [faPIC3]        VARCHAR(255)    NULL,                        -- Tertiary photo URL
    [faPIC4]        VARCHAR(255)    NULL,                        -- Fourth photo URL
    [faPICS]        VARCHAR(MAX)    NULL,                        -- Full photo URL list (pipe- or comma-delimited)
    [faSTOCK]       VARCHAR(50)     NULL,                        -- Dealer stock number
    [faVDP]         VARCHAR(MAX)    NULL,                        -- Vehicle Detail Page (VDP) deep link URL
    [faRadius]      INT             NULL,                        -- Geographic radius for geo-targeted distribution
    [faCREATED]     SMALLDATETIME   NULL,                        -- Record creation timestamp
    [faLASTUPLOAD]  SMALLDATETIME   NULL,                        -- Last inventory upload/sync timestamp
    [faACTIVE]      BIT             NOT NULL                     -- Active flag (0=sold/expired, 1=live listing)
);
GO

-- =============================================================================
-- INFERRED TABLE: dbo.FeedPublications
-- Purpose: Publisher registry — defines the channels (print, digital, platform)
--          into which feeds are distributed. Referenced by fdPUBID FK on both
--          FeedDealers and FeedAds. Not directly confirmed — requires direct
--          Feedhub access to verify structure.
-- =============================================================================
-- INFERRED — structure below is estimated from FK usage patterns
CREATE TABLE [dbo].[FeedPublications] (
    [fdPUBID]       INT             NOT NULL,                    -- PK — publisher ID
    [pubName]       VARCHAR(128)    NULL,                        -- Publication name
    [pubType]       VARCHAR(32)     NULL,                        -- Media type (print, digital, platform)
    [pubActive]     BIT             NULL,                        -- Active flag

    CONSTRAINT [PK_FeedPublications] PRIMARY KEY CLUSTERED ([fdPUBID] ASC)
);
GO

-- =============================================================================
-- INFERRED TABLE: dbo.FeedEditions
-- Purpose: Edition/market configuration — one row per edition of a publication
--          (e.g. a regional print run, a geo-targeted digital edition). Controls
--          which dealers and ads appear in which edition. Referenced by fdEDID
--          FK on FeedDealers and FeedAds.
-- =============================================================================
-- INFERRED — structure below is estimated from FK usage patterns
CREATE TABLE [dbo].[FeedEditions] (
    [fdEDID]        INT             NOT NULL,                    -- PK — edition ID
    [fdPUBID]       INT             NOT NULL,                    -- FK → FeedPublications.fdPUBID
    [editionName]   VARCHAR(128)    NULL,                        -- Edition name / market label
    [market]        VARCHAR(64)     NULL,                        -- Geographic market
    [edActive]      BIT             NULL,                        -- Active flag

    CONSTRAINT [PK_FeedEditions] PRIMARY KEY CLUSTERED ([fdEDID] ASC)
);
GO

-- =============================================================================
-- INFERRED TABLE: dbo.FeedCustomers
-- Purpose: Customer/billing account registry. Referenced by fdCUSID FK on
--          FeedDealers. May map to DWRPT_AI.clientdb.CommonClientId — confirm
--          with DBA. Observed fdCUSID values: 26487, 60010828, 13233.
-- =============================================================================
-- INFERRED — structure below is estimated from FK usage patterns
CREATE TABLE [dbo].[FeedCustomers] (
    [fdCUSID]       INT             NOT NULL,                    -- PK — customer account ID
    [custName]      VARCHAR(128)    NULL,                        -- Customer/account name
    [custStatus]    TINYINT         NULL,                        -- Account status

    CONSTRAINT [PK_FeedCustomers] PRIMARY KEY CLUSTERED ([fdCUSID] ASC)
);
GO

-- =============================================================================
-- INFERRED TABLE: dbo.FeedSubscriptions
-- Purpose: Subscription/contract lines for dealer feed placements. Referenced
--          by faSCLID FK on FeedAds. Also cross-referenced by adID on FeedAds.
-- =============================================================================
-- INFERRED — structure below is estimated from FK usage patterns
CREATE TABLE [dbo].[FeedSubscriptions] (
    [faSCLID]       INT             NOT NULL,                    -- PK — subscription line ID
    [fdUID]         INT             NULL,                        -- FK → FeedDealers.fdUID
    [fdPUBID]       INT             NULL,                        -- FK → FeedPublications.fdPUBID
    [sclType]       VARCHAR(32)     NULL,                        -- Subscription type
    [sclActive]     BIT             NULL,                        -- Active flag

    CONSTRAINT [PK_FeedSubscriptions] PRIMARY KEY CLUSTERED ([faSCLID] ASC)
);
GO

-- =============================================================================
-- INFERRED FOREIGN KEY CONSTRAINTS
-- These relationships are confirmed from FK column presence in ETL copies.
-- Native FK constraint names are unknown without direct DB access.
-- =============================================================================

-- FeedDealers → FeedPublications (fdPUBID)
-- ALTER TABLE [dbo].[FeedDealers]
--     ADD CONSTRAINT [FK_FeedDealers_Publication]
--     FOREIGN KEY ([fdPUBID]) REFERENCES [dbo].[FeedPublications] ([fdPUBID]);

-- FeedDealers → FeedEditions (fdEDID)
-- ALTER TABLE [dbo].[FeedDealers]
--     ADD CONSTRAINT [FK_FeedDealers_Edition]
--     FOREIGN KEY ([fdEDID]) REFERENCES [dbo].[FeedEditions] ([fdEDID]);

-- FeedDealers → FeedCustomers (fdCUSID)
-- ALTER TABLE [dbo].[FeedDealers]
--     ADD CONSTRAINT [FK_FeedDealers_Customer]
--     FOREIGN KEY ([fdCUSID]) REFERENCES [dbo].[FeedCustomers] ([fdCUSID]);

-- FeedDealers self-reference (dealer group hierarchy)
-- ALTER TABLE [dbo].[FeedDealers]
--     ADD CONSTRAINT [FK_FeedDealers_Master]
--     FOREIGN KEY ([fdUIDMaster]) REFERENCES [dbo].[FeedDealers] ([fdUID]);

-- FeedAds → FeedDealers (fdUID)
-- ALTER TABLE [dbo].[FeedAds]
--     ADD CONSTRAINT [FK_FeedAds_Dealer]
--     FOREIGN KEY ([fdUID]) REFERENCES [dbo].[FeedDealers] ([fdUID]);

-- FeedAds → FeedPublications (fdPUBID)
-- ALTER TABLE [dbo].[FeedAds]
--     ADD CONSTRAINT [FK_FeedAds_Publication]
--     FOREIGN KEY ([fdPUBID]) REFERENCES [dbo].[FeedPublications] ([fdPUBID]);

-- FeedAds → FeedEditions (fdEDID)
-- ALTER TABLE [dbo].[FeedAds]
--     ADD CONSTRAINT [FK_FeedAds_Edition]
--     FOREIGN KEY ([fdEDID]) REFERENCES [dbo].[FeedEditions] ([fdEDID]);

-- FeedAds → FeedSubscriptions (faSCLID)
-- ALTER TABLE [dbo].[FeedAds]
--     ADD CONSTRAINT [FK_FeedAds_Subscription]
--     FOREIGN KEY ([faSCLID]) REFERENCES [dbo].[FeedSubscriptions] ([faSCLID]);

-- =============================================================================
-- INDEXES (confirmed on DataStaging ETL copy; native Feedhub indexes unknown)
-- =============================================================================

-- Confirmed on DataStaging.MLdata.FEEDADS (ETL copy):
CREATE NONCLUSTERED INDEX [IX_FEEDADS_faVIN]
    ON [dbo].[FeedAds] ([faVIN] ASC);
GO

-- Expected indexes based on query and FK patterns (not directly confirmed):

-- Active listing lookup (primary feed generation query)
CREATE NONCLUSTERED INDEX [IX_FeedAds_Active_Edition]
    ON [dbo].[FeedAds] ([faACTIVE] ASC, [fdEDID] ASC)
    INCLUDE ([fdUID], [faVIN], [faYEAR], [faMAKE], [faMODEL], [faPRICE]);
GO

-- Dealer lookup on FeedAds (FK join)
CREATE NONCLUSTERED INDEX [IX_FeedAds_fdUID]
    ON [dbo].[FeedAds] ([fdUID] ASC);
GO

-- Publisher/edition filter on FeedDealers
CREATE NONCLUSTERED INDEX [IX_FeedDealers_PubEdition]
    ON [dbo].[FeedDealers] ([fdPUBID] ASC, [fdEDID] ASC);
GO

-- =============================================================================
-- VIEWS
-- =============================================================================

-- Note: The view GVACampaignDataByVINv3 is defined in DataStaging (not Feedhub)
-- and references DataStaging.MLdata.FEEDADS (the ETL copy), not the Feedhub
-- source table directly. Its definition is WITH ENCRYPTION.
--
-- Functional description (from sys.columns recovery):
--   Joins MLdata.GVAVDPDatav2 with MLdata.FEEDADS on faUID/lst_id
--   Output: impressions, clicks, vin, year, make, model, price, lastupload
--
-- CREATE OR ALTER VIEW [dbo].[GVACampaignDataByVINv3]
-- WITH ENCRYPTION
-- AS
-- -- ENCRYPTED — definition not recoverable without SYSADMIN role
-- -- See DataStaging.dbo.GVACampaignDataByVINv3 for the consuming view
-- GO

-- =============================================================================
-- STORED PROCEDURES
-- =============================================================================

-- No stored procedures confirmed — direct Feedhub access was blocked.
-- Procedure list is empty in the harvest output.
-- Complete after DBA grants db_datareader access.

-- =============================================================================
-- BACKUP CONFIGURATION (informational — from msdb.backupset)
-- =============================================================================

-- Storage account:   medialogixprodsqlstorage.blob.core.windows.net
-- Container:         cimsqlbackupcontainer
-- Recovery model:    FULL (confirmed by presence of log backups)
-- Full backup:       Weekly, Wednesdays ~18:45, size ~8.32 MB
-- Log backup:        Every ~2 hours (6+ per day observed)
-- Naming pattern:    Feedhub_c841d72d2cfb4b01a0197916fb5d35ad_{timestamp}-07.{bak|log}

-- =============================================================================
-- ACCESS ERRORS (recorded for audit trail)
-- =============================================================================

-- Error 1: LOGIN_NO_DB_MAPPING
-- "The server principal 'ConflictAI' is not able to access the database
--  'Feedhub' under the current security context."
-- Affected queries: tables, columns, tableSizes, indexes, procedures, views, agentJobs
-- Remediation: USE Feedhub;
--              CREATE USER ConflictAI FOR LOGIN ConflictAI;
--              EXEC sp_addrolemember 'db_datareader', 'ConflictAI';

-- Error 2: MSDB_INSUFFICIENT_ROLE
-- "The SELECT permission was denied on the object 'sysjobs', database 'msdb'."
-- Affected queries: agentJobs
-- Remediation: USE msdb;
--              EXEC sp_addrolemember 'SQLAgentReaderRole', 'ConflictAI';
