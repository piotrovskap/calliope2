-- Endeavorcentral Database — DDL Schema Dump
-- Source: SQL Server 20.51.108.231
-- Generated: 2026-06-11
-- Schema-only; no data. Re-extract to refresh.

CREATE TABLE [__AllFeeds] (
    [adv_id] BIGINT NULL,
    [adv_name] VARCHAR(1024) NULL,
    [subscription_id] BIGINT NULL,
    [cmp_id] BIGINT NULL,
    [sub_name] VARCHAR(256) NULL,
    [sub_status] VARCHAR(64) NULL,
    [Start_Date] DATE NULL,
    [End_Date] DATE NULL,
    [ratchet_id] BIGINT NULL
);

CREATE TABLE [_Active_Campaigns] (
    [id] BIGINT NULL,
    [ratchet_id] BIGINT NULL,
    [Subscription_Id] BIGINT NULL,
    [provider] VARCHAR(255) NULL,
    [Provider_Id] VARCHAR(255) NULL,
    [name] VARCHAR(255) NULL,
    [start_date] DATE NULL,
    [end_date] DATE NULL,
    [monthly_budget] MONEY NULL,
    [Target_Impressions] BIGINT NULL,
    [target_clicks] BIGINT NULL,
    [target_actions] BIGINT NULL,
    [daily_budget] MONEY NULL,
    [state] VARCHAR(255) NULL,
    [submit_type] VARCHAR(255) NULL,
    [submit_date] DATETIME NULL,
    [price_sold] MONEY NULL
);

CREATE TABLE [_Advertiser_Alt_ID] (
    [acc_id] BIGINT NULL,
    [acc_company] NVARCHAR(512) NULL,
    [alt_id] NVARCHAR(256) NULL,
    [sales_channel] NVARCHAR(1024) NULL
);

CREATE TABLE [_All_Flights] (
    [sf_id] BIGINT NOT NULL,
    [cmp_id] BIGINT NOT NULL,
    [ratchet_id] BIGINT NOT NULL,
    [subscription_id] BIGINT NOT NULL,
    [provider] VARCHAR(32) NOT NULL,
    [provider_id] VARCHAR(64) NULL,
    [prd_id] BIGINT NOT NULL,
    [prd_type] VARCHAR(64) NOT NULL,
    [prd_package] VARCHAR(128) NOT NULL,
    [adv_id] BIGINT NOT NULL,
    [adv_acc_id] BIGINT NOT NULL,
    [adv_cusid] BIGINT NOT NULL,
    [adv_name] VARCHAR(128) NULL,
    [adv_state] VARCHAR(50) NOT NULL,
    [Phone] VARCHAR(16) NOT NULL,
    [sc_aso_id] BIGINT NOT NULL,
    [sc_id] BIGINT NOT NULL,
    [sales_channel] VARCHAR(128) NOT NULL,
    [sr_id] BIGINT NULL,
    [sr_login] VARCHAR(128) NULL,
    [sub_name] VARCHAR(128) NOT NULL,
    [flight_status] VARCHAR(32) NOT NULL,
    [submit_date] DATETIME NOT NULL,
    [modified_date] DATETIME NOT NULL,
    [flight_start_date] DATE NOT NULL,
    [flight_end_date] DATE NOT NULL,
    [flight_deactivation_date] DATE NULL,
    [flight_days] BIGINT NOT NULL,
    [flight_price] MONEY NOT NULL,
    [flight_impressions] NUMERIC(18,2) NULL,
    [flight_clicks] NUMERIC(18,2) NULL,
    [daily_price] MONEY NULL,
    [daily_impressions] NUMERIC(18,2) NULL,
    [daily_clicks] NUMERIC(18,2) NULL,
    [remainder_price] MONEY NULL,
    [remainder_impressions] NUMERIC(18,2) NULL,
    [remainder_clicks] NUMERIC(18,2) NULL,
    [campaign_type] VARCHAR(64) NOT NULL,
    [cmp_status] VARCHAR(16) NOT NULL,
    [aggregator] VARCHAR(64) NULL,
    [exclude_ran] BIT NULL,
    [exclude_recycler] BIT NULL,
    [flight_bill_amount] MONEY NOT NULL,
    [original_start_date] DATE NULL,
    [Wholesale_Rate] MONEY NULL,
    [pl_vehicle_type] VARCHAR(32) NULL,
    [pl_language] VARCHAR(32) NULL
);

CREATE TABLE [_AllProducts] (
    [cmp_id] BIGINT NULL,
    [ratchet_id] BIGINT NULL,
    [subscription_id] BIGINT NULL,
    [Submit_Date] DATETIME2 NULL,
    [Modified_Date] DATETIME2 NULL,
    [Aggregator] NVARCHAR(255) NULL,
    [Start_Date] DATETIME2 NULL,
    [End_Date] DATETIME2 NULL,
    [campaign_type] NVARCHAR(255) NULL,
    [adv_id] BIGINT NULL,
    [adv_acc_id] BIGINT NULL,
    [adv_cusid] BIGINT NULL,
    [sc_aso_id] BIGINT NULL,
    [adv_name] NVARCHAR(512) NULL,
    [adv_state] NVARCHAR(2) NULL,
    [Sales_Channel] NVARCHAR(1024) NULL,
    [sc_name] NVARCHAR(1024) NULL,
    [sc_id] BIGINT NULL,
    [sub_name] NVARCHAR(128) NULL,
    [Price_Paid] NUMERIC(12,2) NULL,
    [sub_status] NVARCHAR(32) NULL,
    [cmp_status] NVARCHAR(8) NOT NULL,
    [prd_id] BIGINT NULL,
    [prd_Type] NVARCHAR(255) NULL,
    [prd_Package] NVARCHAR(255) NULL,
    [sr_id] BIGINT NULL,
    [sr_login] NVARCHAR(200) NULL,
    [Provider] NVARCHAR(255) NULL,
    [Provider_Id] NVARCHAR(255) NULL,
    [Phone] NVARCHAR(32) NULL,
    [Budget] NUMERIC(12,2) NULL,
    [exclude_ran] NUMERIC(3,0) NULL,
    [exclude_recycler] NUMERIC(3,0) NULL,
    [pl_vehicle_type] VARCHAR(32) NULL,
    [pl_language] VARCHAR(32) NULL,
    [utm_code] VARCHAR(256) NULL,
    [isFacebook] BIT NULL,
    [isRetargeting] BIT NULL,
    [Retargeting_VDP_Goal] INT NULL
);

CREATE TABLE [_AllTargets] (
    [id] BIGINT NULL,
    [Target_Impressions] BIGINT NULL,
    [Target_Clicks] BIGINT NULL,
    [Target_Profile_Views] BIGINT NULL,
    [Target_Actions] BIGINT NULL
);

CREATE TABLE [_RAN_XML] (
    [cmp_id] BIGINT NULL,
    [ratchet_id] BIGINT NULL,
    [subscription_id] BIGINT NULL,
    [name] NVARCHAR(255) NULL,
    [email_xml] NTEXT NULL,
    [Submit_Date] DATETIME2 NULL,
    [Modified_Date] DATETIME2 NULL,
    [Aggregator] NVARCHAR(255) NULL,
    [Start_Date] DATETIME2 NULL,
    [End_Date] DATETIME2 NULL,
    [cmp_status] NVARCHAR(8) NOT NULL,
    [product_type] NVARCHAR(255) NULL
);

CREATE TABLE [AdvertiserSalesChannel_Log] (
    [advertiser_id] INT NULL,
    [old_sales_channel_id] INT NULL,
    [new_sales_channel_id] INT NULL,
    [old_cus_id] INT NULL,
    [new_cus_id] INT NULL
);

CREATE TABLE [BKUPSettings] (
    [dbID] INT NOT NULL,
    [dbName] NVARCHAR(32) NOT NULL,
    [dbBKUPKeep] SMALLINT NOT NULL,
    [dbBKUPPath] NVARCHAR(256) NOT NULL,
    [dbBKFTPServer] NVARCHAR(32) NOT NULL,
    [dbBKUserName] NVARCHAR(32) NOT NULL,
    [dbBKPassword] NVARCHAR(32) NOT NULL
);

CREATE TABLE [charterview] (
    [Advertiser_ID] BIGINT NOT NULL,
    [acc_ID] BIGINT NULL,
    [Channel] NVARCHAR(3072) NULL,
    [Customer] NVARCHAR(512) NULL,
    [Phone] NVARCHAR(32) NULL,
    [leads] NVARCHAR(3) NULL,
    [min_leads_date] DATETIME2 NULL,
    [max_leads_date] DATETIME2 NULL,
    [directories] NVARCHAR(3) NULL,
    [min_directories_date] DATETIME2 NULL,
    [max_directories_date] DATETIME2 NULL,
    [display] NVARCHAR(3) NULL,
    [min_display_date] DATETIME2 NULL,
    [max_display_date] DATETIME2 NULL,
    [smartads] NVARCHAR(3) NULL,
    [min_smartads_date] DATETIME2 NULL,
    [max_smartads_date] DATETIME2 NULL,
    [package] NVARCHAR(3) NULL,
    [min_package_date] DATETIME2 NULL,
    [max_package_date] DATETIME2 NULL
);

CREATE TABLE [CommercialCustomer] (
    [DB] NVARCHAR(128) NULL,
    [CUSID] INT NOT NULL,
    [CUSCOMPANY] VARCHAR(64) NULL,
    [CUSPHONE] VARCHAR(16) NOT NULL,
    [CUSADDRESS] VARCHAR(64) NULL,
    [CUSCITY] VARCHAR(32) NULL,
    [CUSSTATE] VARCHAR(2) NULL,
    [CUSZIP] VARCHAR(5) NULL,
    [CUSEMAIL] VARCHAR(64) NULL,
    [CUSBTEMAIL] VARCHAR(64) NULL,
    [CUSBTEMAIL_CC] VARCHAR(64) NULL,
    [ctid] INT NULL,
    [sum_sales] MONEY NULL,
    [count_months] INT NULL,
    [min_saledate] VARCHAR(6) NULL,
    [max_saledate] VARCHAR(6) NULL,
    [ctName] VARCHAR(32) NOT NULL
);

CREATE TABLE [DBINFO] (
    [file_id] INT NOT NULL,
    [name] NVARCHAR(128) NOT NULL,
    [type] TINYINT NOT NULL,
    [type_desc] NVARCHAR(60) NULL,
    [physical_name] NVARCHAR(260) NOT NULL,
    [size] INT NOT NULL,
    [max_size] INT NOT NULL,
    [growth] INT NOT NULL
);

CREATE TABLE [FactualInfo] (
    [office] VARCHAR(64) NULL,
    [db] NVARCHAR(128) NULL,
    [cusid] INT NOT NULL,
    [cusphone] VARCHAR(16) NOT NULL,
    [cuswcprint] VARCHAR(16) NULL,
    [cuswcweb] VARCHAR(16) NULL,
    [cuscompany] VARCHAR(64) NULL,
    [cusaddress] VARCHAR(64) NULL,
    [cuszip] VARCHAR(5) NULL,
    [cconame] VARCHAR(64) NULL,
    [ccoemail] VARCHAR(8000) NULL,
    [cusemail] VARCHAR(8000) NULL,
    [cusurl] VARCHAR(128) NULL,
    [Twitter] VARCHAR(128) NULL,
    [FaceBook] VARCHAR(128) NULL,
    [FourSquare] VARCHAR(128) NULL
);

CREATE TABLE [SalesBreakdown] (
    [Operation] VARCHAR(128) NULL,
    [Name] VARCHAR(128) NULL,
    [Phone] VARCHAR(16) NOT NULL,
    [Email] VARCHAR(128) NULL,
    [Rep] VARCHAR(128) NOT NULL,
    [Category] VARCHAR(128) NOT NULL,
    [Type] VARCHAR(128) NOT NULL,
    [FirstSale] VARCHAR(128) NULL,
    [CusID] INT NOT NULL,
    [BookType] VARCHAR(128) NULL,
    [Media] VARCHAR(128) NOT NULL,
    [2014-12] MONEY NULL,
    [2015-01] MONEY NULL,
    [2015-02] MONEY NULL,
    [2015-03] MONEY NULL,
    [2015-04] MONEY NULL,
    [2015-05] MONEY NULL,
    [2015-06] MONEY NULL,
    [2015-07] MONEY NULL,
    [2015-08] MONEY NULL,
    [2015-09] MONEY NULL,
    [2015-10] MONEY NULL,
    [2015-11] MONEY NULL,
    [2015-12] MONEY NULL,
    [2016-01] MONEY NULL,
    [2016-02] MONEY NULL,
    [2016-03] MONEY NULL,
    [2016-04] MONEY NULL,
    [2016-05] MONEY NULL,
    [2016-06] MONEY NULL,
    [2016-07] MONEY NULL,
    [2016-08] MONEY NULL,
    [2016-09] MONEY NULL,
    [2016-10] MONEY NULL,
    [2016-11] MONEY NULL,
    [2016-12] MONEY NULL,
    [2017-01] MONEY NULL,
    [2017-02] MONEY NULL,
    [2017-03] MONEY NULL,
    [2017-04] MONEY NULL,
    [2017-05] MONEY NULL,
    [2017-06] MONEY NULL,
    [2017-07] MONEY NULL,
    [2017-08] MONEY NULL,
    [2017-09] MONEY NULL,
    [2017-10] MONEY NULL,
    [2017-11] MONEY NULL,
    [2017-12] MONEY NULL,
    [2018-01] MONEY NULL,
    [2018-02] MONEY NULL,
    [2018-03] MONEY NULL,
    [2018-04] MONEY NULL,
    [2018-05] MONEY NULL,
    [2018-06] MONEY NULL,
    [2018-07] MONEY NULL,
    [2018-08] MONEY NULL,
    [2018-09] MONEY NULL,
    [2018-10] MONEY NULL,
    [2018-11] MONEY NULL,
    [2018-12] MONEY NULL,
    [2019-01] MONEY NULL,
    [2019-02] MONEY NULL,
    [2019-03] MONEY NULL,
    [2019-04] MONEY NULL,
    [2019-05] MONEY NULL,
    [2019-06] MONEY NULL,
    [2019-07] MONEY NULL,
    [2019-08] MONEY NULL,
    [2019-09] MONEY NULL,
    [2019-10] MONEY NULL,
    [2019-11] MONEY NULL,
    [2019-12] MONEY NULL,
    [DepName] VARCHAR(64) NOT NULL,
    [db] VARCHAR(64) NOT NULL
);

CREATE TABLE [SalesMedia] (
    [pubDB] VARCHAR(32) NULL,
    [cusID] INT NOT NULL,
    [RunMonth] VARCHAR(32) NULL,
    [Media] VARCHAR(8) NOT NULL,
    [SumSales] MONEY NULL,
    [connDB] VARCHAR(32) NULL
);

CREATE TABLE [Subscription_Flight_Date] (
    [S_Id] BIGINT NOT NULL,
    [Start_Date] DATE NULL,
    [End_Date] DATE NULL,
    [Action_Date] DATE NULL,
    [Action] NVARCHAR(11) NOT NULL,
    [Id] INT NULL
);
