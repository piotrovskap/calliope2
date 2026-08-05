-- =============================================================================
-- Database:    Zuora
-- Server:      40.83.161.93 (DWRPT / MediaLogix Prod SQL)
-- Discovery:   2026-06-14
-- Researcher:  Alicia Salazar
-- Description: Zuora subscription billing and accounts-receivable platform for
--              the DAS client roster. Manages dealer account billing, payment
--              terms, outstanding balances, and fiscal accounting periods.
--
-- ACCESS NOTE: The ConflictAI login has HAS_DBACCESS = 0 on the Zuora database.
--              This DDL is reconstructed from:
--                (1) ETL staging tables in DataStaging.zuora (accessible)
--                (2) Database-level metadata in master.sys.databases
--                (3) Backup history in msdb.dbo.backupset
--              Column types are inferred from Zuora API field schema and data
--              samples. This file should be regenerated once db_datareader is
--              granted to ConflictAI on the Zuora database.
--
-- To grant access (requires sysadmin):
--   USE [Zuora];
--   CREATE USER [ConflictAI] FOR LOGIN [ConflictAI];
--   ALTER ROLE [db_datareader] ADD MEMBER [ConflictAI];
-- =============================================================================

-- =============================================================================
-- STAGING MIRROR: DataStaging.zuora schema
-- These tables are the only accessible Zuora data surface for the ConflictAI
-- login. They are ETL-loaded from the Zuora REST API into the DataStaging DB.
-- =============================================================================

USE [DataStaging];
GO

-- -----------------------------------------------------------------------------
-- Table: zuora.AccountStage
-- Purpose: Billing account records for every DAS dealer/client.
--          Sourced from the Zuora /v1/accounts REST endpoint.
--          11,632 rows as of 2026-06-14 harvest.
--
-- CDP notes:
--   - ClientID (VARCHAR 50) maps to CommonClientID (INT) — CAST required
--   - CrmId is Salesforce Account GUID — joins to dynamics.Account.accountid
--   - Status, Balance, AutoPay, PaymentTerm are billing health signals
--   - is_deleted supports soft-delete / incremental ETL pattern
-- -----------------------------------------------------------------------------
CREATE TABLE [zuora].[AccountStage] (
    -- Zuora account identifier
    [AccountNumber]           NVARCHAR(50)     NULL,          -- Zuora account number (e.g. A-000001234)

    -- Account identity and naming
    [Name]                    NVARCHAR(255)    NULL,          -- Dealer / client display name
    [Status]                  NVARCHAR(50)     NULL,          -- Account state: Active | Cancelled | Draft

    -- Billing configuration
    [Currency]                NVARCHAR(10)     NULL,          -- ISO 4217 currency code (USD, CAD, etc.)
    [AutoPay]                 NVARCHAR(10)     NULL,          -- Autopay enabled flag ('true'/'false' from API)
    [BillCycleDay]            NVARCHAR(10)     NULL,          -- Day of month billing fires (1–31)
    [PaymentTerm]             NVARCHAR(100)    NULL,          -- Payment terms (Net 30, Due Upon Receipt, etc.)
    [Balance]                 NVARCHAR(50)     NULL,          -- Outstanding AR balance (string from API; cast to DECIMAL on use)

    -- Invoice preferences and tax
    [InvoiceDeliveryPrefs]    NVARCHAR(50)     NULL,          -- Invoice delivery: Email | Print | EmailAndPrint
    [TaxExemptStatus]         NVARCHAR(50)     NULL,          -- Tax exemption status

    -- Cross-system identity keys
    [CrmId]                   NVARCHAR(50)     NULL,          -- Salesforce Account GUID → dynamics.Account.accountid
    [ClientID]                NVARCHAR(50)     NULL,          -- DAS tenant UUID → CommonClientID (CAST to INT required)

    -- Sales attribution
    [SalesRepName]            NVARCHAR(255)    NULL,          -- DAS sales representative (free text)

    -- ETL metadata
    [CreatedDate]             NVARCHAR(50)     NULL,          -- Zuora record creation timestamp (ISO 8601 string from API)
    [UpdatedDate]             NVARCHAR(50)     NULL,          -- Last Zuora update timestamp — used for incremental ETL delta
    [is_deleted]              NVARCHAR(10)     NULL,          -- Soft-delete flag from Zuora API ('true'/'false')

    -- ---------------------------------------------------------------------
    -- Additional columns (43 total; 27 below not observed in data sample)
    -- Names inferred from standard Zuora Account object fields.
    -- Verify against DataStaging INFORMATION_SCHEMA once access is granted.
    -- ---------------------------------------------------------------------
    [BcdSettingOption]        NVARCHAR(50)     NULL,
    [Batch]                   NVARCHAR(50)     NULL,
    [BillToId]                NVARCHAR(50)     NULL,          -- Zuora contact ID for billing address
    [CommunicationProfileId]  NVARCHAR(50)     NULL,
    [DefaultPaymentMethodId]  NVARCHAR(50)     NULL,
    [InvoiceTemplateId]       NVARCHAR(50)     NULL,
    [Notes]                   NVARCHAR(MAX)    NULL,
    [ParentId]                NVARCHAR(50)     NULL,          -- Parent account for account hierarchies
    [PaymentGateway]          NVARCHAR(100)    NULL,
    [PurchaseOrderNumber]     NVARCHAR(100)    NULL,
    [SalesRepId]              NVARCHAR(50)     NULL,
    [SoldToId]                NVARCHAR(50)     NULL,          -- Zuora contact ID for sold-to address
    [TaxCompanyCode]          NVARCHAR(50)     NULL,
    [UsBankAccountNumber]     NVARCHAR(50)     NULL,
    [ZuoraId]                 NVARCHAR(50)     NULL,          -- Native Zuora internal GUID (if surfaced by API)
    -- [col17..col27] -- Remaining inferred columns not yet identified
    -- Run: SELECT COLUMN_NAME, DATA_TYPE FROM DataStaging.INFORMATION_SCHEMA.COLUMNS
    --      WHERE TABLE_SCHEMA = 'zuora' AND TABLE_NAME = 'AccountStage'
    -- to get the authoritative column list.
);
GO

-- -----------------------------------------------------------------------------
-- Table: zuora.AccountingPeriodStage
-- Purpose: Fiscal accounting period definitions loaded from the Zuora
--          Accounting Periods API (/v1/accounting-periods).
--          0 rows as of 2026-06-14 harvest — ETL not yet run or module unused.
--
-- CDP notes:
--   - Empty at harvest — cannot validate types from data
--   - If populated, enables fiscal-period bucketing of billing events
-- -----------------------------------------------------------------------------
CREATE TABLE [zuora].[AccountingPeriodStage] (
    [Id]             NVARCHAR(50)     NULL,          -- Zuora accounting period ID (PK in source)
    [Name]           NVARCHAR(100)    NULL,          -- Period label (e.g. "Jan 2026", "Q1 FY2026")
    [StartDate]      NVARCHAR(50)     NULL,          -- Period start date (ISO 8601 string from API)
    [EndDate]        NVARCHAR(50)     NULL,          -- Period end date
    [Status]         NVARCHAR(50)     NULL,          -- Open | Closed | PendingClose
    [FiscalYear]     NVARCHAR(10)     NULL,          -- Fiscal year integer
    [FiscalQuarter]  NVARCHAR(10)     NULL,          -- Fiscal quarter (1, 2, 3, or 4)
    [Notes]          NVARCHAR(MAX)    NULL,
    [FileIds]        NVARCHAR(MAX)    NULL,          -- Comma-separated IDs of attached report files
    [CreatedDate]    NVARCHAR(50)     NULL,          -- Creation timestamp
    [UpdatedDate]    NVARCHAR(50)     NULL,          -- Last update timestamp
    [is_deleted]     NVARCHAR(10)     NULL,          -- Soft-delete flag ('true'/'false')
);
GO

-- =============================================================================
-- INDEXES
-- No indexes were accessible from the current login.
-- Recommended indexes to create once access is granted:
-- =============================================================================

-- Fast lookup by DAS tenant (most common CDP join pattern)
-- CREATE INDEX [IX_AccountStage_ClientID]
--     ON [zuora].[AccountStage] ([ClientID]);

-- Fast lookup by CRM bridge (Salesforce/Dynamics join)
-- CREATE INDEX [IX_AccountStage_CrmId]
--     ON [zuora].[AccountStage] ([CrmId]);

-- Incremental ETL delta key
-- CREATE INDEX [IX_AccountStage_UpdatedDate]
--     ON [zuora].[AccountStage] ([UpdatedDate]);

-- Fast lookup by account status (billing health queries)
-- CREATE INDEX [IX_AccountStage_Status]
--     ON [zuora].[AccountStage] ([Status]);

GO

-- =============================================================================
-- NATIVE ZUORA DATABASE (40.83.161.93 / Zuora)
-- Schema not accessible — stub comments only.
-- The native Zuora database likely contains:
--   - dbo.ZAccount or dbo.Account (full billing account table with all 43 fields)
--   - dbo.ZSubscription / dbo.Subscription (subscription plans per account)
--   - dbo.ZInvoice / dbo.Invoice (invoice headers)
--   - dbo.ZInvoiceItem (invoice line items)
--   - dbo.ZPayment (payment records)
--   - dbo.ZRefund (refund records)
--   - dbo.ZProductRatePlan / dbo.ZRatePlan (subscription plan catalog)
--   - dbo.ZContact (billing/sold-to contact details — likely contains PII)
--   - dbo.ZAccountingPeriod (accounting period definitions)
--   - dbo.ZJournalEntry / dbo.ZJournalEntryItem (accounting journal)
-- To harvest: grant db_datareader to ConflictAI on Zuora, then run the
-- standard discovery runbook scripts 1–6.
-- =============================================================================

-- =============================================================================
-- VIEWS — None accessible from DataStaging.zuora or Zuora native DB
-- =============================================================================

-- =============================================================================
-- STORED PROCEDURES — None accessible
-- ETL loading DataStaging.zuora.* is likely implemented as:
--   - An SSIS package calling the Zuora REST API
--   - Or a SQL Agent job calling a CLR proc or linked server
-- Identify via: SELECT * FROM msdb.dbo.sysjobs WHERE name LIKE '%zuora%'
--               (requires sysadmin or SQLAgentReaderRole on msdb)
-- =============================================================================

-- =============================================================================
-- BACKUP HISTORY SUMMARY (from msdb — as of 2026-06-14 harvest)
-- =============================================================================
-- Database:          Zuora
-- Full backup size:  8.32 MB
-- Full frequency:    ~Every 4 days
-- Log frequency:     ~Every 2 hours
-- Destination:       Azure Blob Storage
--                    https://medialogixprodsqlstorage.blob.core.windows.net/
-- Recovery model:    FULL
-- =============================================================================
