-- Megatron Database — DDL Schema Dump
-- Source: SQL Server 20.51.108.231
-- Generated: 2026-06-11
-- Schema-only; no data. Re-extract to refresh.

CREATE TABLE [__AllAdEzCampaigns] (
    [cmp_id] BIGINT NULL,
    [ratchet_id] BIGINT NULL,
    [subscription_id] BIGINT NULL,
    [Submit_Date] DATETIME NULL,
    [Modified_Date] DATETIME NULL,
    [Aggregator] VARCHAR(128) NULL,
    [Start_Date] DATE NULL,
    [End_Date] DATE NULL,
    [campaign_type] VARCHAR(128) NULL,
    [adv_id] BIGINT NULL,
    [adv_acc_id] BIGINT NULL,
    [adv_cusid] BIGINT NULL,
    [sc_aso_id] BIGINT NULL,
    [adv_name] VARCHAR(128) NULL,
    [adv_state] VARCHAR(5) NULL,
    [Sales_Channel] VARCHAR(128) NULL,
    [sc_name] VARCHAR(128) NULL,
    [sc_id] BIGINT NULL,
    [sub_name] VARCHAR(256) NULL,
    [price_paid] MONEY NULL,
    [sub_status] VARCHAR(16) NULL,
    [cmp_status] VARCHAR(16) NULL,
    [prd_id] BIGINT NULL,
    [prd_Type] VARCHAR(128) NULL,
    [prd_Package] VARCHAR(128) NULL,
    [sr_id] BIGINT NULL,
    [sr_login] VARCHAR(128) NULL,
    [Provider] VARCHAR(128) NULL,
    [Provider_Id] VARCHAR(128) NULL,
    [adv_Phone] VARCHAR(16) NULL,
    [Budget] MONEY NULL,
    [exclude_ran] BIT NULL,
    [exclude_recycler] BIT NULL,
    [Target_Impressions] INT NULL,
    [Target_VDPs] INT NULL,
    [Target_Clicks] INT NULL,
    [Target_Profile_Views] INT NULL,
    [Target_Actions] INT NULL,
    [Flight_Dates] INT NULL,
    [Flight_Daily_Price] MONEY NULL,
    [Flight_Daily_Impressions] FLOAT NULL,
    [Flight_Daily_VDPs] FLOAT NULL,
    [Flight_Daily_Clicks] FLOAT NULL,
    [Flight_Daily_Profile_Views] FLOAT NULL,
    [Flight_Daily_Actions] FLOAT NULL,
    [pl_vehicle_type] VARCHAR(32) NULL,
    [pl_language] VARCHAR(32) NULL,
    [utm_code] VARCHAR(256) NULL,
    [isFacebook] BIT NULL,
    [isRetargeting] BIT NULL,
    [Retargeting_VDP_Goal] INT NULL,
    [Website_Url] VARCHAR(255) NULL
);

CREATE TABLE [__AllAdEzCampaigns_NewCancel_PrepareTemp] (
    [ym] INT NULL,
    [snp_id] BIGINT NULL,
    [adv_acc_id] BIGINT NULL,
    [Sales_Channel] VARCHAR(256) NULL,
    [Division] VARCHAR(256) NULL,
    [adv_cusid] BIGINT NULL,
    [adv_name] VARCHAR(256) NULL,
    [sub_id] BIGINT NULL,
    [cmp_id] BIGINT NULL,
    [prd_Type] VARCHAR(256) NULL,
    [prd_Package] VARCHAR(256) NULL,
    [price_paid] MONEY NULL,
    [start_date] DATE NULL,
    [end_date] DATE NULL,
    [sr_login] VARCHAR(256) NULL,
    [sub_status] VARCHAR(32) NULL,
    [rowtype] VARCHAR(32) NULL
);

CREATE TABLE [__AllAdEzCampaigns_NewCancel_Temp] (
    [ym] INT NULL,
    [snp_id] BIGINT NULL,
    [adv_acc_id] BIGINT NULL,
    [Sales_Channel] VARCHAR(256) NULL,
    [Division] VARCHAR(256) NULL,
    [adv_cusid] BIGINT NULL,
    [adv_name] VARCHAR(256) NULL,
    [sub_id] BIGINT NULL,
    [cmp_id] BIGINT NULL,
    [prd_Type] VARCHAR(256) NULL,
    [prd_Package] VARCHAR(256) NULL,
    [price_paid] MONEY NULL,
    [start_date] DATE NULL,
    [end_date] DATE NULL,
    [sr_login] VARCHAR(256) NULL,
    [sub_status] VARCHAR(32) NULL,
    [rowtype] VARCHAR(32) NULL
);

CREATE TABLE [__AllAdEzCampaigns_Snapshot] (
    [snp_id] BIGINT NOT NULL -- PK,
    [snp_date] DATETIME NOT NULL,
    [cmp_id] BIGINT NULL,
    [ratchet_id] BIGINT NULL,
    [subscription_id] BIGINT NULL,
    [Submit_Date] DATETIME NULL,
    [Modified_Date] DATETIME NULL,
    [Aggregator] VARCHAR(128) NULL,
    [Start_Date] DATE NULL,
    [End_Date] DATE NULL,
    [campaign_type] VARCHAR(128) NULL,
    [adv_id] BIGINT NULL,
    [adv_acc_id] BIGINT NULL,
    [adv_cusid] BIGINT NULL,
    [sc_aso_id] BIGINT NULL,
    [adv_name] VARCHAR(128) NULL,
    [adv_state] VARCHAR(5) NULL,
    [Sales_Channel] VARCHAR(128) NULL,
    [sc_name] VARCHAR(128) NULL,
    [sc_id] BIGINT NULL,
    [sub_name] VARCHAR(256) NULL,
    [price_paid] MONEY NULL,
    [sub_status] VARCHAR(16) NULL,
    [cmp_status] VARCHAR(50) NULL,
    [prd_id] BIGINT NULL,
    [prd_Type] VARCHAR(128) NULL,
    [prd_Package] VARCHAR(128) NULL,
    [sr_id] BIGINT NULL,
    [sr_login] VARCHAR(128) NULL,
    [Provider] VARCHAR(128) NULL,
    [Provider_Id] VARCHAR(128) NULL,
    [adv_Phone] VARCHAR(16) NULL,
    [Budget] MONEY NULL,
    [exclude_ran] BIT NULL,
    [exclude_recycler] BIT NULL,
    [Target_Impressions] INT NULL,
    [Target_VDPs] INT NULL,
    [Target_Clicks] INT NULL,
    [Target_Profile_Views] INT NULL,
    [Target_Actions] INT NULL,
    [pl_vehicle_type] VARCHAR(32) NULL,
    [pl_language] VARCHAR(32) NULL,
    [utm_code] VARCHAR(256) NULL,
    [isFacebook] BIT NULL,
    [isRetargeting] BIT NULL,
    [Retargeting_VDP_Goal] INT NULL,
    [Website_Url] VARCHAR(255) NULL
);

CREATE TABLE [__PROC_Log] (
    [plg_ID] BIGINT NOT NULL,
    [acc_ID] INT NULL,
    [lst_ID] INT NULL,
    [plg_Procedure] VARCHAR(256) NULL,
    [plg_Parameters] VARCHAR(256) NULL,
    [plg_User] VARCHAR(256) NULL,
    [plg_Host] VARCHAR(256) NULL,
    [plg_Start] DATETIME NULL,
    [plg_End] DATETIME NULL
);

CREATE TABLE [_Accounts_from_Advantage] (
    [adv_ID] BIGINT NOT NULL -- PK,
    [acc_ID] INT NOT NULL,
    [acc_Company] VARCHAR(64) NOT NULL,
    [acc_DisplayName] VARCHAR(64) NOT NULL,
    [acc_Phone] VARCHAR(24) NOT NULL,
    [acc_State] VARCHAR(2) NOT NULL,
    [zip_Code] VARCHAR(10) NOT NULL,
    [acc_email_XML] VARCHAR(128) NOT NULL,
    [acc_email_String] VARCHAR(128) NOT NULL,
    [aso_ID] INT NOT NULL,
    [aso_Name] VARCHAR(128) NOT NULL,
    [pubid] INT NULL,
    [cusid] INT NOT NULL,
    [rep_ID] INT NOT NULL,
    [rep_Login] VARCHAR(128) NULL,
    [rep_rco_id] INT NOT NULL,
    [rep_arl_ID] INT NOT NULL,
    [rep_reseler_Company] VARCHAR(64) NULL,
    [rep_reseler_Division] VARCHAR(64) NULL,
    [rep_reseller_Admin] INT NOT NULL,
    [Source] VARCHAR(64) NULL,
    [rco_ServiceList] VARCHAR(128) NULL,
    [Channel] VARCHAR(128) NOT NULL,
    [Division] VARCHAR(64) NULL,
    [isLive] BIT NOT NULL,
    [DateStarted_Formatted] DATE NOT NULL,
    [DateEnded_Formatted] DATE NOT NULL,
    [Status] VARCHAR(8) NOT NULL
);

CREATE TABLE [_Accounts_from_All] (
    [all_ID] BIGINT NOT NULL -- PK,
    [acc_ID] INT NOT NULL,
    [acc_Company] VARCHAR(64) NOT NULL,
    [acc_Phone] VARCHAR(24) NOT NULL,
    [acc_State] VARCHAR(2) NOT NULL,
    [zip_Code] VARCHAR(10) NOT NULL,
    [acc_email_XML] VARCHAR(128) NOT NULL,
    [acc_email_String] VARCHAR(128) NOT NULL,
    [aso_ID] INT NULL,
    [aso_Name] VARCHAR(128) NOT NULL,
    [pubid] INT NULL,
    [cusid] INT NULL,
    [rep_ID] INT NOT NULL,
    [rep_Login] VARCHAR(128) NULL,
    [rep_rco_id] INT NOT NULL,
    [rep_arl_ID] INT NOT NULL,
    [rep_reseler_Company] VARCHAR(64) NULL,
    [rep_reseler_Division] VARCHAR(64) NULL,
    [rep_reseller_Admin] INT NOT NULL,
    [prd_ID] INT NOT NULL,
    [Source] VARCHAR(64) NULL,
    [rco_ServiceList] VARCHAR(128) NULL,
    [Channel] VARCHAR(128) NOT NULL,
    [Division] VARCHAR(64) NULL,
    [isLive] BIT NOT NULL,
    [DateStarted_Formatted] DATE NULL,
    [DateEnded_Formatted] DATE NULL,
    [sta_ID] INT NOT NULL,
    [Status] VARCHAR(8) NOT NULL
);

CREATE TABLE [_Accounts_from_Banners] (
    [ban_ID] BIGINT NOT NULL -- PK,
    [acc_ID] INT NOT NULL,
    [acc_Company] VARCHAR(64) NOT NULL,
    [acc_DisplayName] VARCHAR(64) NOT NULL,
    [acc_Phone] VARCHAR(24) NOT NULL,
    [acc_State] VARCHAR(2) NOT NULL,
    [zip_Code] VARCHAR(10) NOT NULL,
    [acc_email_XML] VARCHAR(128) NOT NULL,
    [acc_email_String] VARCHAR(128) NOT NULL,
    [aso_ID] INT NOT NULL,
    [aso_Name] VARCHAR(128) NOT NULL,
    [pubid] VARCHAR(128) NOT NULL,
    [cusid] INT NULL,
    [rep_ID] INT NOT NULL,
    [rep_Login] VARCHAR(128) NULL,
    [rep_rco_id] INT NOT NULL,
    [rep_arl_ID] INT NOT NULL,
    [rep_reseler_Company] VARCHAR(64) NULL,
    [rep_reseler_Division] VARCHAR(64) NULL,
    [rep_reseller_Admin] INT NOT NULL,
    [Source] VARCHAR(64) NULL,
    [rco_ServiceList] VARCHAR(128) NULL,
    [Channel] VARCHAR(128) NOT NULL,
    [Division] VARCHAR(64) NULL,
    [isLive] BIT NOT NULL,
    [DateStarted_Formatted] DATE NOT NULL,
    [DateEnded_Formatted] DATE NOT NULL,
    [Status] VARCHAR(8) NOT NULL
);

CREATE TABLE [_Accounts_from_Banners_On_RCY] (
    [bnr_ID] BIGINT NOT NULL -- PK,
    [acc_ID] INT NOT NULL,
    [acc_Company] VARCHAR(64) NOT NULL,
    [acc_DisplayName] VARCHAR(64) NOT NULL,
    [acc_Phone] VARCHAR(24) NOT NULL,
    [acc_State] VARCHAR(2) NOT NULL,
    [zip_Code] VARCHAR(5) NOT NULL,
    [acc_email_XML] VARCHAR(128) NOT NULL,
    [acc_email_String] VARCHAR(128) NOT NULL,
    [aso_ID] INT NOT NULL,
    [aso_Name] VARCHAR(128) NOT NULL,
    [pubid] VARCHAR(128) NOT NULL,
    [cusid] INT NULL,
    [rep_ID] INT NOT NULL,
    [rep_Login] VARCHAR(128) NULL,
    [rep_rco_id] INT NOT NULL,
    [rep_arl_ID] INT NOT NULL,
    [rep_reseler_Company] VARCHAR(64) NULL,
    [rep_reseler_Division] VARCHAR(64) NULL,
    [rep_reseller_Admin] INT NOT NULL,
    [Source] VARCHAR(64) NULL,
    [rco_ServiceList] VARCHAR(128) NULL,
    [Channel] VARCHAR(128) NOT NULL,
    [Division] VARCHAR(64) NULL,
    [isLive] BIT NOT NULL,
    [DateStarted_Formatted] DATE NOT NULL,
    [DateEnded_Formatted] DATE NOT NULL,
    [Status] VARCHAR(8) NOT NULL
);

CREATE TABLE [_Accounts_from_Endeavor] (
    [end_ID] BIGINT NOT NULL -- PK,
    [acc_ID] INT NOT NULL,
    [acc_Company] VARCHAR(64) NOT NULL,
    [acc_DisplayName] VARCHAR(64) NOT NULL,
    [acc_Phone] VARCHAR(24) NOT NULL,
    [acc_State] VARCHAR(2) NOT NULL,
    [zip_Code] VARCHAR(5) NOT NULL,
    [acc_email_XML] VARCHAR(128) NOT NULL,
    [acc_email_String] VARCHAR(128) NOT NULL,
    [aso_ID] INT NOT NULL,
    [aso_Name] VARCHAR(128) NOT NULL,
    [pubid] INT NOT NULL,
    [cusid] INT NOT NULL,
    [rep_ID] INT NOT NULL,
    [rep_Login] VARCHAR(128) NULL,
    [rep_rco_id] INT NOT NULL,
    [rep_arl_ID] INT NOT NULL,
    [rep_reseler_Company] VARCHAR(64) NULL,
    [rep_reseler_Division] VARCHAR(64) NULL,
    [rep_reseller_Admin] INT NOT NULL,
    [Source] VARCHAR(64) NULL,
    [rco_ServiceList] VARCHAR(128) NULL,
    [Channel] VARCHAR(128) NOT NULL,
    [Division] VARCHAR(64) NULL,
    [isLive] BIT NOT NULL,
    [DateStarted_Formatted] DATE NULL,
    [DateEnded_Formatted] DATE NULL,
    [Status] VARCHAR(8) NOT NULL
);

CREATE TABLE [_Accounts_from_Feeds] (
    [feed_ID] BIGINT NOT NULL -- PK,
    [acc_ID] INT NOT NULL,
    [acc_Company] VARCHAR(64) NOT NULL,
    [acc_DisplayName] VARCHAR(64) NOT NULL,
    [acc_Phone] VARCHAR(24) NOT NULL,
    [acc_State] VARCHAR(2) NOT NULL,
    [zip_Code] VARCHAR(10) NOT NULL,
    [acc_email_XML] VARCHAR(128) NOT NULL,
    [acc_email_String] VARCHAR(128) NOT NULL,
    [aso_ID] INT NULL,
    [aso_Name] VARCHAR(128) NOT NULL,
    [pubid] VARCHAR(128) NOT NULL,
    [cusid] INT NULL,
    [rep_ID] INT NOT NULL,
    [rep_Login] VARCHAR(128) NULL,
    [rep_rco_id] INT NOT NULL,
    [rep_arl_ID] INT NOT NULL,
    [rep_reseler_Company] VARCHAR(64) NULL,
    [rep_reseler_Division] VARCHAR(64) NULL,
    [rep_reseller_Admin] INT NOT NULL,
    [Source] VARCHAR(64) NULL,
    [rco_ServiceList] VARCHAR(128) NULL,
    [Channel] VARCHAR(128) NOT NULL,
    [Division] VARCHAR(64) NULL,
    [isLive] BIT NOT NULL,
    [DateStarted_Formatted] DATE NOT NULL,
    [DateEnded_Formatted] DATE NOT NULL,
    [Status] VARCHAR(8) NOT NULL,
    [ExcludeRAN] BIT NULL,
    [ExcludeRCY] BIT NULL,
    [fdID] VARCHAR(32) NULL,
    [EdTag] VARCHAR(128) NULL,
    [fiName] VARCHAR(32) NULL
);

CREATE TABLE [_Accounts_from_Ratchet] (
    [lcl_ID] BIGINT NOT NULL -- PK,
    [acc_ID] INT NOT NULL,
    [acc_Company] VARCHAR(64) NOT NULL,
    [acc_DisplayName] VARCHAR(64) NOT NULL,
    [acc_Phone] VARCHAR(24) NOT NULL,
    [acc_State] VARCHAR(2) NOT NULL,
    [zip_Code] VARCHAR(5) NOT NULL,
    [acc_email_XML] VARCHAR(128) NOT NULL,
    [acc_email_String] VARCHAR(128) NOT NULL,
    [aso_ID] INT NOT NULL,
    [aso_Name] VARCHAR(128) NOT NULL,
    [pubid] VARCHAR(128) NOT NULL,
    [cusid] INT NULL,
    [rep_ID] INT NOT NULL,
    [rep_Login] VARCHAR(128) NULL,
    [rep_rco_id] INT NOT NULL,
    [rep_arl_ID] INT NOT NULL,
    [rep_reseler_Company] VARCHAR(64) NULL,
    [rep_reseler_Division] VARCHAR(64) NULL,
    [rep_reseller_Admin] INT NOT NULL,
    [Source] VARCHAR(64) NULL,
    [rco_ServiceList] VARCHAR(128) NULL,
    [Channel] VARCHAR(128) NOT NULL,
    [Division] VARCHAR(64) NULL,
    [isLive] BIT NOT NULL,
    [DateStarted_Formatted] DATE NOT NULL,
    [DateEnded_Formatted] DATE NOT NULL,
    [Status] VARCHAR(8) NOT NULL
);

CREATE TABLE [_ADAccounts] (
    [ADMYID] INT NULL,
    [ADLogin] VARCHAR(128) NULL,
    [ADName] VARCHAR(128) NULL,
    [ADEmail] VARCHAR(128) NULL,
    [acc_id] INT NULL,
    [acc_login] VARCHAR(128) NULL,
    [acc_displayname] VARCHAR(64) NULL,
    [acc_firstname] VARCHAR(32) NULL,
    [acc_lastname] VARCHAR(32) NULL,
    [acc_description] VARCHAR(256) NULL,
    [arl_id] INT NULL,
    [arl_name] VARCHAR(32) NULL,
    [acc_lastlogin] DATETIME NULL,
    [rco_id] INT NULL,
    [rco_companyname] VARCHAR(64) NULL,
    [rco_realname] VARCHAR(64) NULL,
    [rea_isadmin] INT NULL,
    [External] INT NOT NULL,
    [src_site] INT NULL,
    [rco_ServiceList] VARCHAR(128) NULL
);

CREATE TABLE [_Advertiser_Alt_ID] (
    [acc_id] BIGINT NULL,
    [acc_company] NVARCHAR(512) NULL,
    [alt_id] NVARCHAR(256) NULL,
    [sales_channel] NVARCHAR(1024) NULL
);

CREATE TABLE [_AllFlights] (
    [sf_id] BIGINT NULL,
    [cmp_id] BIGINT NULL,
    [ratchet_id] BIGINT NULL,
    [subscription_id] BIGINT NULL,
    [provider] VARCHAR(32) NULL,
    [provider_id] VARCHAR(64) NULL,
    [prd_id] BIGINT NULL,
    [prd_type] VARCHAR(64) NULL,
    [prd_package] VARCHAR(128) NULL,
    [adv_id] BIGINT NULL,
    [adv_acc_id] BIGINT NULL,
    [adv_cusid] BIGINT NULL,
    [adv_name] VARCHAR(128) NULL,
    [adv_state] VARCHAR(2) NULL,
    [Phone] VARCHAR(16) NULL,
    [sc_aso_id] BIGINT NULL,
    [sc_id] BIGINT NULL,
    [sales_channel] VARCHAR(128) NULL,
    [sr_id] BIGINT NULL,
    [sr_login] VARCHAR(128) NULL,
    [sub_name] VARCHAR(128) NULL,
    [flight_status] VARCHAR(32) NULL,
    [submit_date] DATETIME NULL,
    [modified_date] DATETIME NULL,
    [flight_start_date] DATE NULL,
    [flight_end_date] DATE NULL,
    [flight_deactivation_date] DATE NULL,
    [flight_days] BIGINT NULL,
    [flight_price] MONEY NULL,
    [flight_impressions] NUMERIC(18,2) NULL,
    [flight_clicks] NUMERIC(18,2) NULL,
    [daily_price] MONEY NULL,
    [daily_impressions] NUMERIC(18,2) NULL,
    [daily_clicks] NUMERIC(18,2) NULL,
    [remainder_price] MONEY NULL,
    [remainder_impressions] NUMERIC(18,2) NULL,
    [remainder_clicks] NUMERIC(18,2) NULL,
    [campaign_type] VARCHAR(64) NULL,
    [cmp_status] VARCHAR(16) NULL,
    [aggregator] VARCHAR(64) NULL,
    [exclude_ran] BIT NULL,
    [exclude_recycler] BIT NULL,
    [flight_bill_amount] MONEY NULL,
    [original_start_date] DATE NULL,
    [Wholesale_Rate] MONEY NULL,
    [pl_vehicle_type] VARCHAR(32) NULL,
    [pl_language] VARCHAR(32) NULL
);

CREATE TABLE [_AllFlights_Performance] (
    [sf_id] BIGINT NULL,
    [perf_min_int] INT NULL,
    [perf_max_int] INT NULL,
    [perf_source] VARCHAR(64) NULL
);

CREATE TABLE [_AllFlightsOverride] (
    [sf_id] BIGINT NULL,
    [cmp_id] BIGINT NULL,
    [ratchet_id] BIGINT NULL,
    [subscription_id] BIGINT NULL,
    [provider] VARCHAR(32) NULL,
    [provider_id] VARCHAR(64) NULL,
    [prd_id] BIGINT NULL,
    [prd_type] VARCHAR(64) NULL,
    [prd_package] VARCHAR(128) NULL,
    [adv_id] BIGINT NULL,
    [adv_acc_id] BIGINT NULL,
    [adv_cusid] BIGINT NULL,
    [adv_name] VARCHAR(128) NULL,
    [adv_state] VARCHAR(2) NULL,
    [Phone] VARCHAR(16) NULL,
    [sc_aso_id] BIGINT NULL,
    [sc_id] BIGINT NULL,
    [sales_channel] VARCHAR(128) NULL,
    [sr_id] BIGINT NULL,
    [sr_login] VARCHAR(128) NULL,
    [sub_name] VARCHAR(128) NULL,
    [flight_status] VARCHAR(32) NULL,
    [submit_date] DATETIME NULL,
    [modified_date] DATETIME NULL,
    [flight_start_date] DATE NULL,
    [flight_end_date] DATE NULL,
    [flight_deactivation_date] DATE NULL,
    [flight_days] BIGINT NULL,
    [flight_price] MONEY NULL,
    [flight_impressions] NUMERIC(18,2) NULL,
    [flight_clicks] NUMERIC(18,2) NULL,
    [daily_price] MONEY NULL,
    [daily_impressions] NUMERIC(18,2) NULL,
    [daily_clicks] NUMERIC(18,2) NULL,
    [remainder_price] MONEY NULL,
    [remainder_impressions] NUMERIC(18,2) NULL,
    [remainder_clicks] NUMERIC(18,2) NULL,
    [campaign_type] VARCHAR(64) NULL,
    [cmp_status] VARCHAR(16) NULL,
    [aggregator] VARCHAR(64) NULL,
    [exclude_ran] BIT NULL,
    [exclude_recycler] BIT NULL,
    [flight_bill_amount] MONEY NULL,
    [original_start_date] DATE NULL,
    [Wholesale_Rate] MONEY NULL,
    [pl_vehicle_type] VARCHAR(32) NULL,
    [pl_language] VARCHAR(32) NULL
);

CREATE TABLE [_DXLIVEFIX_Rows] (
    [adid] INT NOT NULL,
    [adnum] INT NOT NULL,
    [lsm_Table] VARCHAR(3) NOT NULL,
    [lsm_Action] VARCHAR(3) NOT NULL
);

CREATE TABLE [_FolderContentKeeper] (
    [fckID] INT NOT NULL -- PK,
    [fcmID] INT NULL,
    [fckName] VARCHAR(4000) NULL,
    [fckType] VARCHAR(32) NULL,
    [fckSize] INT NULL,
    [fckModified] DATETIME NULL,
    [Adnum] VARCHAR(32) NULL,
    [LastUpload] DATETIME NULL
);

CREATE TABLE [_FolderContentManager] (
    [fcmID] INT NOT NULL -- PK,
    [fcmPath] VARCHAR(4000) NOT NULL,
    [fcmPattern] VARCHAR(1024) NOT NULL,
    [fcmDate] DATETIME NOT NULL
);

CREATE TABLE [_HiLo_Vehicle] (
    [hilo_ID] BIGINT NOT NULL -- PK,
    [src_id] INT NOT NULL,
    [lacc_id] INT NOT NULL,
    [llst_phone] VARCHAR(16) NULL,
    [llst_id] INT NOT NULL,
    [zip_code] VARCHAR(5) NOT NULL,
    [llst_price] MONEY NOT NULL,
    [scl_id] INT NOT NULL,
    [scl_name] VARCHAR(64) NOT NULL,
    [lst_Year] VARCHAR(128) NULL,
    [lst_Make] VARCHAR(128) NULL,
    [lst_Model] VARCHAR(128) NULL,
    [lst_Trim] VARCHAR(128) NULL,
    [lst_Mileage] VARCHAR(128) NULL,
    [livelistingimage_Top1] VARCHAR(8000) NULL,
    [Hash1] VARBINARY(8000) NULL
);

CREATE TABLE [_IPB_Temp] (
    [startIpNum] BIGINT NULL,
    [endIpNum] BIGINT NULL,
    [locId] BIGINT NULL
);

CREATE TABLE [_IPL_Temp] (
    [locId] BIGINT NULL,
    [country] VARCHAR(50) NULL,
    [region] VARCHAR(50) NULL,
    [city] VARCHAR(50) NULL,
    [zipcode] VARCHAR(50) NULL,
    [latitude] FLOAT NULL,
    [longitude] FLOAT NULL,
    [gdNewLocation] VARCHAR(128) NULL,
    [gdURLLocation] VARCHAR(128) NULL,
    [gdRadius] FLOAT NULL,
    [gdtName] VARCHAR(128) NULL,
    [gdtRanking] INT NULL
);

CREATE TABLE [_Job] (
    [job_id] INT NOT NULL -- PK,
    [job_name] VARCHAR(100) NOT NULL,
    [job_run] VARCHAR(1000) NOT NULL,
    [job_active] BIT NOT NULL
);

CREATE TABLE [_OutboundMaster] (
    [_SrcID] INT NOT NULL,
    [_AccID] INT NULL,
    [_LstID] INT NOT NULL,
    [_Title] VARCHAR(128) NOT NULL,
    [_ClassID] INT NOT NULL,
    [_SubClassID] INT NOT NULL,
    [_SubClass] VARCHAR(64) NOT NULL,
    [_Phone] VARCHAR(16) NOT NULL,
    [_Price] MONEY NOT NULL,
    [_Text] VARCHAR(8000) NOT NULL,
    [_Zip] VARCHAR(10) NOT NULL,
    [_State] VARCHAR(2) NOT NULL,
    [_City] VARCHAR(32) NOT NULL,
    [_ImageURL] VARCHAR(8000) NOT NULL,
    [_DetailsURL] VARCHAR(160) NOT NULL,
    [fduid] INT NULL,
    [_AllImages] VARCHAR(8000) NOT NULL,
    [llst_Created] DATETIME NOT NULL,
    [llst_Modified] DATETIME NOT NULL
);

CREATE TABLE [_OutboundMasterAccount] (
    [_SrcID] INT NOT NULL,
    [_AccID] INT NOT NULL,
    [_FdUID] INT NULL,
    [_Name] VARCHAR(64) NOT NULL,
    [_Address] VARCHAR(64) NOT NULL,
    [_City] VARCHAR(32) NOT NULL,
    [_State] VARCHAR(2) NOT NULL,
    [_Zip] VARCHAR(10) NOT NULL,
    [_Email_String] VARCHAR(128) NOT NULL,
    [_Email_XML] VARCHAR(128) NOT NULL,
    [_Phone] VARCHAR(16) NOT NULL,
    [_URL] VARCHAR(512) NULL,
    [_ImageURL] VARCHAR(512) NOT NULL,
    [_DataSource] VARCHAR(9) NOT NULL
);

CREATE TABLE [_OutboundMasterAutos] (
    [_SrcID] INT NOT NULL,
    [_AccID] INT NULL,
    [_LstID] INT NOT NULL,
    [_Title] VARCHAR(128) NOT NULL,
    [_ClassID] INT NOT NULL,
    [_SubClassID] INT NOT NULL,
    [_SubClass] VARCHAR(64) NOT NULL,
    [_Phone] VARCHAR(16) NOT NULL,
    [_Price] MONEY NOT NULL,
    [_Text] VARCHAR(8000) NOT NULL,
    [_Zip] VARCHAR(10) NOT NULL,
    [_State] VARCHAR(2) NOT NULL,
    [_City] VARCHAR(32) NOT NULL,
    [_ImageURL] VARCHAR(8000) NOT NULL,
    [_DetailsURL] VARCHAR(160) NOT NULL,
    [fduid] INT NULL,
    [_AllImages] VARCHAR(8000) NOT NULL,
    [llst_Created] DATETIME NOT NULL,
    [llst_Modified] DATETIME NOT NULL,
    [_Year] VARCHAR(4) NOT NULL,
    [_Make] VARCHAR(64) NOT NULL,
    [_Model] VARCHAR(64) NOT NULL,
    [_SubModel] VARCHAR(128) NOT NULL,
    [_VIN] VARCHAR(32) NOT NULL,
    [_BodyType] VARCHAR(64) NOT NULL,
    [_Color] VARCHAR(128) NOT NULL,
    [_Int_Color] VARCHAR(128) NOT NULL,
    [_Miles] VARCHAR(32) NOT NULL,
    [_Doors] VARCHAR(8) NOT NULL,
    [_Cylinders] VARCHAR(64) NOT NULL,
    [_Transmission] VARCHAR(64) NOT NULL,
    [_Condition] VARCHAR(32) NOT NULL,
    [_Certified] VARCHAR(5) NOT NULL,
    [_Displacement] VARCHAR(64) NOT NULL,
    [_Stock] VARCHAR(32) NOT NULL,
    [_FuelType] VARCHAR(32) NOT NULL,
    [_Warranty] VARCHAR(32) NOT NULL,
    [_Drivetrain] VARCHAR(32) NOT NULL,
    [_FuelHighway] VARCHAR(32) NOT NULL,
    [_WarrantyTerms] VARCHAR(128) NOT NULL,
    [_SellerType] VARCHAR(16) NOT NULL,
    [_FuelCity] VARCHAR(32) NOT NULL,
    [_Induction] VARCHAR(64) NOT NULL,
    [_Extension] VARCHAR(1) NOT NULL,
    [_Radius] INT NOT NULL,
    [_VDPURL] VARCHAR(1024) NOT NULL
);

CREATE TABLE [_OutboundMasterHomes] (
    [_SrcID] INT NOT NULL,
    [_AccID] INT NULL,
    [_LstID] INT NOT NULL,
    [_Title] VARCHAR(128) NOT NULL,
    [_ClassID] INT NOT NULL,
    [_SubClassID] INT NOT NULL,
    [_SubClass] VARCHAR(64) NOT NULL,
    [_Phone] VARCHAR(16) NOT NULL,
    [_Price] MONEY NOT NULL,
    [_Text] VARCHAR(8000) NOT NULL,
    [_Zip] VARCHAR(10) NOT NULL,
    [_State] VARCHAR(2) NOT NULL,
    [_City] VARCHAR(32) NOT NULL,
    [_ImageURL] VARCHAR(8000) NOT NULL,
    [_DetailsURL] VARCHAR(160) NOT NULL,
    [fduid] INT NULL,
    [_AllImages] VARCHAR(8000) NOT NULL,
    [llst_Created] DATETIME NOT NULL,
    [llst_Modified] DATETIME NOT NULL,
    [_SquarFeet] VARCHAR(32) NOT NULL,
    [_PropertyType] VARCHAR(32) NOT NULL,
    [_Bedrooms] VARCHAR(32) NOT NULL,
    [_Bathrooms] VARCHAR(32) NOT NULL,
    [_Parking] VARCHAR(32) NOT NULL
);

CREATE TABLE [_OutboundMasterJobs] (
    [_SrcID] INT NOT NULL,
    [_AccID] INT NULL,
    [_LstID] INT NOT NULL,
    [_Title] VARCHAR(128) NOT NULL,
    [_ClassID] INT NOT NULL,
    [_SubClassID] INT NOT NULL,
    [_SubClass] VARCHAR(64) NOT NULL,
    [_Phone] VARCHAR(16) NOT NULL,
    [_Price] MONEY NOT NULL,
    [_Text] VARCHAR(8000) NOT NULL,
    [_Zip] VARCHAR(10) NOT NULL,
    [_State] VARCHAR(2) NOT NULL,
    [_City] VARCHAR(32) NOT NULL,
    [_ImageURL] VARCHAR(8000) NOT NULL,
    [_DetailsURL] VARCHAR(160) NOT NULL,
    [fduid] INT NULL,
    [_AllImages] VARCHAR(8000) NOT NULL,
    [llst_Created] DATETIME NOT NULL,
    [llst_Modified] DATETIME NOT NULL,
    [_Company] VARCHAR(128) NOT NULL
);

CREATE TABLE [_OutboundMasterOther] (
    [_SrcID] INT NOT NULL,
    [_AccID] INT NULL,
    [_LstID] INT NOT NULL,
    [_Title] VARCHAR(128) NOT NULL,
    [_ClassID] INT NOT NULL,
    [_SubClassID] INT NOT NULL,
    [_SubClass] VARCHAR(64) NOT NULL,
    [_Phone] VARCHAR(16) NOT NULL,
    [_Price] MONEY NOT NULL,
    [_Text] VARCHAR(8000) NOT NULL,
    [_Zip] VARCHAR(10) NOT NULL,
    [_State] VARCHAR(2) NOT NULL,
    [_City] VARCHAR(32) NOT NULL,
    [_ImageURL] VARCHAR(8000) NOT NULL,
    [_DetailsURL] VARCHAR(160) NOT NULL,
    [fduid] INT NULL,
    [_AllImages] VARCHAR(8000) NOT NULL,
    [llst_Created] DATETIME NOT NULL,
    [llst_Modified] DATETIME NOT NULL,
    [_Company] VARCHAR(128) NOT NULL
);

CREATE TABLE [_OverwriteDupeAccount_Log] (
    [New_acc_ID] INT NULL,
    [Old_acc_ID] INT NULL,
    [Processed] DATETIME NULL,
    [HostName] VARCHAR(128) NULL
);

CREATE TABLE [_OverwriteDupeAccount_Log_Account] (
    [acc_ID] INT NOT NULL,
    [src_ID] INT NOT NULL,
    [src_CusID] VARCHAR(32) NULL,
    [acc_GUID] UNIQUEIDENTIFIER NOT NULL,
    [acc_Login] VARCHAR(128) NOT NULL,
    [acc_Password] VARCHAR(256) NOT NULL,
    [acc_Company] VARCHAR(64) NOT NULL,
    [acc_FirstName] VARCHAR(32) NOT NULL,
    [acc_LastName] VARCHAR(32) NOT NULL,
    [sal_ID] INT NULL,
    [acc_Description] VARCHAR(256) NOT NULL,
    [acc_Email_String] VARCHAR(128) NOT NULL,
    [acc_Email_XML] VARCHAR(128) NOT NULL,
    [acc_URL] VARCHAR(512) NULL,
    [acc_DisplayName] VARCHAR(64) NULL,
    [acc_Phone] VARCHAR(16) NOT NULL,
    [acc_Extension] VARCHAR(10) NOT NULL,
    [acc_AltPhone] VARCHAR(16) NOT NULL,
    [acc_AltExtension] VARCHAR(10) NOT NULL,
    [acc_Address] VARCHAR(64) NOT NULL,
    [acc_City] VARCHAR(64) NOT NULL,
    [acc_State] VARCHAR(2) NOT NULL,
    [zip_Code] VARCHAR(5) NOT NULL,
    [acc_Image] VARCHAR(512) NULL,
    [acs_ID] INT NOT NULL,
    [arl_ID] INT NOT NULL,
    [acc_Created] DATETIME NOT NULL,
    [acc_Modified] DATETIME NOT NULL,
    [acc_LastLogin] DATETIME NOT NULL,
    [acc_LastIP] VARCHAR(15) NOT NULL,
    [acc_Verified] BIT NOT NULL,
    [acc_WhiteListed] BIT NOT NULL
);

CREATE TABLE [_Pending_Feeds] (
    [pend_ID] BIGINT NOT NULL -- PK,
    [acc_id] INT NOT NULL,
    [acc_company] VARCHAR(64) NULL,
    [acc_phone] VARCHAR(16) NULL,
    [zip_code] VARCHAR(10) NULL,
    [acc_created] DATETIME NULL,
    [acc_modified] DATETIME NULL,
    [ffprice] MONEY NULL,
    [acc_rep] VARCHAR(128) NULL,
    [acc_active] BIT NULL,
    [Source] VARCHAR(64) NULL
);

CREATE TABLE [_PubClosestCenterZip] (
    [pub_id] INT NOT NULL,
    [pub_name] VARCHAR(64) NOT NULL,
    [minlat] FLOAT NULL,
    [maxlat] FLOAT NULL,
    [avglat] FLOAT NULL,
    [minlon] FLOAT NULL,
    [maxlon] FLOAT NULL,
    [avglon] FLOAT NULL,
    [closestzip] VARCHAR(5) NULL,
    [radius] DECIMAL(16,4) NULL
);

CREATE TABLE [_Schedule] (
    [sch_id] INT NOT NULL -- PK,
    [job_id] INT NOT NULL,
    [sch_day] INT NOT NULL,
    [sch_hour] INT NOT NULL,
    [enabled] BIT NOT NULL
);

CREATE TABLE [_TempMake] (
    [newsubclass] VARCHAR(80) NULL,
    [famake] VARCHAR(32) NULL,
    [famodel] VARCHAR(128) NULL
);

CREATE TABLE [_TempMakeSynonym] (
    [_id] INT NOT NULL,
    [_Synonym] VARCHAR(8000) NULL
);

CREATE TABLE [_TempModels] (
    [MDLMAKE] VARCHAR(32) NOT NULL,
    [MDLNAME] VARCHAR(32) NOT NULL,
    [MDLTRIM] VARCHAR(32) NOT NULL,
    [MDLCARTYPE] TINYINT NOT NULL
);

CREATE TABLE [_TempPrintCount] (
    [Transfer_Name] VARCHAR(128) NOT NULL,
    [Year] INT NULL,
    [Paid] INT NOT NULL,
    [week1] INT NULL,
    [week2] INT NULL,
    [week3] INT NULL,
    [week4] INT NULL
);

CREATE TABLE [_TMPDomains] (
    [TMPDomains] VARCHAR(128) NULL
);

CREATE TABLE [Account] (
    [acc_ID] INT NOT NULL -- PK,
    [src_ID] INT NOT NULL,
    [src_CusID] VARCHAR(32) NULL,
    [acc_GUID] UNIQUEIDENTIFIER NOT NULL,
    [acc_Login] VARCHAR(128) NOT NULL,
    [acc_Password] VARCHAR(256) NOT NULL,
    [acc_Company] VARCHAR(64) NOT NULL,
    [acc_FirstName] VARCHAR(32) NOT NULL,
    [acc_LastName] VARCHAR(32) NOT NULL,
    [sal_ID] INT NULL,
    [acc_Description] VARCHAR(256) NOT NULL,
    [acc_Email_String] VARCHAR(128) NOT NULL,
    [acc_Email_XML] VARCHAR(128) NOT NULL,
    [acc_URL] VARCHAR(512) NULL,
    [acc_DisplayName] VARCHAR(64) NULL,
    [acc_Phone] VARCHAR(16) NOT NULL,
    [acc_Extension] VARCHAR(10) NOT NULL,
    [acc_AltPhone] VARCHAR(16) NOT NULL,
    [acc_AltExtension] VARCHAR(10) NOT NULL,
    [acc_Address] VARCHAR(64) NOT NULL,
    [acc_City] VARCHAR(64) NOT NULL,
    [acc_State] VARCHAR(2) NOT NULL,
    [zip_Code] VARCHAR(10) NOT NULL,
    [acc_Image] VARCHAR(512) NULL,
    [acs_ID] INT NOT NULL,
    [arl_ID] INT NOT NULL,
    [acc_Created] DATETIME NOT NULL,
    [acc_Modified] DATETIME NOT NULL,
    [acc_LastLogin] DATETIME NOT NULL,
    [acc_LastIP] VARCHAR(15) NOT NULL,
    [acc_Verified] BIT NOT NULL,
    [acc_WhiteListed] BIT NOT NULL
);

CREATE TABLE [Account_Created_LastUpload] (
    [acc_ID] INT NOT NULL -- PK,
    [fdUID] INT NOT NULL -- PK,
    [lst_Created] DATETIME NULL,
    [lst_LastUpload] DATETIME NULL
);

CREATE TABLE [Account_Login_History] (
    [sp] VARCHAR(256) NULL,
    [acc_Login] VARCHAR(128) NULL,
    [acl_RemoteAddress] VARCHAR(15) NULL,
    [acl_ForwardedFor] VARCHAR(15) NULL,
    [src_ID] INT NULL,
    [captured] DATETIME NULL
);

CREATE TABLE [account_save] (
    [acc_id] INT NOT NULL,
    [src_id] INT NOT NULL,
    [src_cusid] VARCHAR(32) NULL,
    [acc_Company] VARCHAR(64) NOT NULL
);

CREATE TABLE [AccountAlerts] (
    [aal_ID] INT NOT NULL -- PK,
    [acc_ID] INT NOT NULL,
    [aal_Date] DATETIME NOT NULL,
    [lst_ID] INT NULL,
    [apo_ID] INT NOT NULL,
    [aal_Closed] DATETIME NULL,
    [aal_SentDate] DATETIME NOT NULL,
    [aal_SentEmail] VARCHAR(256) NULL,
    [aal_SentHTML] TEXT NOT NULL
);

CREATE TABLE [AccountCanvasImageOverlays] (
    [id] INT NOT NULL -- PK,
    [account_id] INT NOT NULL,
    [image_overlay_id] INT NOT NULL,
    [start_x] FLOAT NOT NULL,
    [start_y] FLOAT NOT NULL,
    [width] FLOAT NOT NULL,
    [height] FLOAT NOT NULL,
    [created_date] DATETIME NULL
);

CREATE TABLE [AccountCRM] (
    [acr_ID] INT NOT NULL -- PK,
    [acc_ID] INT NOT NULL,
    [crm_ID] INT NOT NULL,
    [crm_ExternalID] VARCHAR(128) NOT NULL,
    [crm_ExternalDlrID] INT NULL
);

CREATE TABLE [AccountDupeRemoveLog] (
    [acc_ID] INT NOT NULL,
    [src_ID] INT NOT NULL,
    [src_CusID] VARCHAR(32) NULL,
    [acc_GUID] UNIQUEIDENTIFIER NOT NULL,
    [acc_Login] VARCHAR(128) NOT NULL,
    [acc_Password] VARCHAR(256) NOT NULL,
    [acc_Company] VARCHAR(64) NOT NULL,
    [acc_FirstName] VARCHAR(32) NOT NULL,
    [acc_LastName] VARCHAR(32) NOT NULL,
    [sal_ID] INT NULL,
    [acc_Description] VARCHAR(256) NOT NULL,
    [acc_Email_String] VARCHAR(128) NOT NULL,
    [acc_Email_XML] VARCHAR(128) NOT NULL,
    [acc_URL] VARCHAR(512) NULL,
    [acc_DisplayName] VARCHAR(64) NULL,
    [acc_Phone] VARCHAR(16) NOT NULL,
    [acc_Extension] VARCHAR(10) NOT NULL,
    [acc_AltPhone] VARCHAR(16) NOT NULL,
    [acc_AltExtension] VARCHAR(10) NOT NULL,
    [acc_Address] VARCHAR(64) NOT NULL,
    [acc_City] VARCHAR(64) NOT NULL,
    [acc_State] VARCHAR(2) NOT NULL,
    [zip_Code] VARCHAR(5) NOT NULL,
    [acc_Image] VARCHAR(512) NULL,
    [acs_ID] INT NOT NULL,
    [arl_ID] INT NOT NULL,
    [acc_Created] DATETIME NOT NULL,
    [acc_Modified] DATETIME NOT NULL,
    [acc_LastLogin] DATETIME NOT NULL,
    [acc_LastIP] VARCHAR(15) NOT NULL,
    [acc_Verified] BIT NOT NULL,
    [acc_WhiteListed] BIT NOT NULL,
    [sp_makingchange] VARCHAR(256) NULL
);

CREATE TABLE [AccountExtras] (
    [acc_ID] INT NOT NULL -- PK,
    [pub_ID] INT NOT NULL,
    [fdUID] INT NULL,
    [aso_ID] INT NULL,
    [acc_ID_Rep] INT NULL,
    [fdID] VARCHAR(32) NULL,
    [edID] INT NULL,
    [edTag] VARCHAR(64) NULL
);

CREATE TABLE [AccountImageConfig] (
    [acc_id] INT NOT NULL -- PK,
    [use_second_image] BIT NULL,
    [main_image_selected] BIT NULL,
    [overlay_image] VARCHAR(128) NULL,
    [color] VARCHAR(10) NULL
);

CREATE TABLE [AccountImageOverlays] (
    [id] INT NOT NULL -- PK,
    [acc_id] INT NOT NULL,
    [overlay_name] NVARCHAR(255) NOT NULL,
    [overlay_image] NVARCHAR(500) NOT NULL,
    [created_date] DATETIME NULL
);

CREATE TABLE [AccountLeads] (
    [acc_id] INT NOT NULL -- PK,
    [ldq_id] INT NOT NULL -- PK,
    [created] DATETIME NOT NULL
);

CREATE TABLE [AccountListingVerifyAllQueue] (
    [vfq_ID] INT NOT NULL -- PK,
    [acc_ID] INT NULL,
    [Current_lst_ID] INT NULL,
    [vfq_Added] DATETIME NULL,
    [vfq_Completed] DATETIME NULL
);

CREATE TABLE [AccountLogin] (
    [acl_ID] INT NOT NULL -- PK,
    [acc_ID] INT NOT NULL,
    [acl_Date] DATETIME NOT NULL,
    [acl_RemoteAddress] VARCHAR(15) NOT NULL,
    [acl_ForwardedFor] VARCHAR(15) NOT NULL,
    [acl_LoggedIn] BIT NOT NULL
);

CREATE TABLE [AccountMaster] (
    [acc_ID_Master] INT NOT NULL -- PK,
    [acc_ID_Child] INT NOT NULL -- PK,
    [acm_Created] DATETIME NOT NULL,
    [acm_Creator] INT NOT NULL
);

CREATE TABLE [AccountNoHash] (
    [anh_ID] INT NOT NULL -- PK,
    [acc_ID] INT NOT NULL,
    [anh_Entry] VARCHAR(256) NULL
);

CREATE TABLE [AccountNotes] (
    [acn_ID] INT NOT NULL -- PK,
    [acc_ID] INT NOT NULL,
    [lst_ID] INT NULL,
    [acn_AddedBy_acc_ID] INT NOT NULL,
    [acn_Notes] VARCHAR(2048) NOT NULL,
    [acn_Added] DATETIME NOT NULL
);

CREATE TABLE [AccountOverlay] (
    [overlay_id] INT NOT NULL -- PK,
    [acc_id] INT NOT NULL,
    [startX] INT NOT NULL,
    [startY] INT NOT NULL,
    [width] INT NOT NULL,
    [height] INT NOT NULL,
    [priority] INT NULL
);

CREATE TABLE [AccountOverwrite] (
    [aco_ID] INT NOT NULL -- PK,
    [acc_ID] INT NOT NULL,
    [aco_Company] VARCHAR(64) NULL,
    [aco_FirstName] VARCHAR(32) NULL,
    [aco_LastName] VARCHAR(32) NULL,
    [sal_ID] INT NULL,
    [aco_Description] VARCHAR(256) NULL,
    [aco_Email_String] VARCHAR(128) NULL,
    [aco_Email_XML] VARCHAR(128) NULL,
    [aco_URL] VARCHAR(512) NULL,
    [aco_DisplayName] VARCHAR(64) NULL,
    [aco_Phone] VARCHAR(16) NULL,
    [aco_Extension] VARCHAR(10) NULL,
    [aco_AltPhone] VARCHAR(16) NULL,
    [aco_AltExtension] VARCHAR(10) NULL,
    [aco_Address] VARCHAR(64) NULL,
    [aco_City] VARCHAR(64) NULL,
    [aco_State] VARCHAR(2) NULL,
    [zip_Code] VARCHAR(5) NULL,
    [aco_Image] VARCHAR(512) NULL,
    [aco_MasterID] INT NULL,
    [aco_Created] DATETIME NOT NULL,
    [aco_Modified] DATETIME NOT NULL,
    [aco_ModifiedBy] INT NOT NULL
);

CREATE TABLE [AccountPermissions] (
    [acc_id] INT NOT NULL -- PK,
    [per_id] INT NOT NULL -- PK
);

CREATE TABLE [AccountPosition] (
    [acp_ID] INT NOT NULL,
    [acc_address] VARCHAR(64) NOT NULL,
    [acc_city] VARCHAR(64) NOT NULL,
    [acc_state] VARCHAR(2) NOT NULL,
    [zip_code] VARCHAR(10) NOT NULL,
    [acc_latitude] FLOAT NULL,
    [acc_longitude] FLOAT NULL
);

CREATE TABLE [AccountPreference] (
    [acc_ID] INT NOT NULL -- PK,
    [apo_ID] INT NOT NULL -- PK,
    [apf_Preference] BIT NOT NULL
);

CREATE TABLE [AccountPreferenceLog] (
    [apl_id] INT NOT NULL -- PK,
    [acc_id] INT NOT NULL,
    [apo_id] INT NOT NULL,
    [action_date] DATETIME NOT NULL
);

CREATE TABLE [AccountPreferenceOption] (
    [apo_ID] INT NOT NULL -- PK,
    [apo_Name] VARCHAR(128) NULL,
    [apo_AlertType] SMALLINT NOT NULL,
    [apo_Active] BIT NULL
);

CREATE TABLE [AccountPreferenceOptOut] (
    [acc_ID] INT NOT NULL -- PK,
    [apo_ID] INT NOT NULL -- PK,
    [optout_Date] SMALLDATETIME NOT NULL
);

CREATE TABLE [AccountRole] (
    [arl_ID] INT NOT NULL -- PK,
    [arl_Name] VARCHAR(32) NOT NULL,
    [arl_Active] BIT NOT NULL,
    [arl_isBusiness] BIT NOT NULL
);

CREATE TABLE [AccountSecurity] (
    [ase_ID] INT NOT NULL -- PK,
    [acc_ID] INT NOT NULL,
    [aso_ID] INT NOT NULL
);

CREATE TABLE [AccountSecurityGroups] (
    [asg_ID] INT NOT NULL -- PK,
    [asg_Name] VARCHAR(64) NOT NULL,
    [asg_Table] VARCHAR(64) NOT NULL,
    [asg_Sort] INT NOT NULL
);

CREATE TABLE [AccountSecurityOptions] (
    [aso_ID] INT NOT NULL -- PK,
    [asg_ID] INT NOT NULL,
    [aso_Name] VARCHAR(128) NOT NULL,
    [aso_Description] VARCHAR(256) NULL,
    [aso_Value] VARCHAR(128) NOT NULL,
    [aso_Sort] INT NOT NULL,
    [asr_ID] INT NULL,
    [rpt_QuickLink] INT NULL,
    [aso_Notes] VARCHAR(1024) NULL,
    [aso_active] BIT NULL
);

CREATE TABLE [AccountSecurityOptions_Log] (
    [sol_ID] INT NOT NULL -- PK,
    [sol_Modified] DATETIME NOT NULL,
    [sol_Options] VARCHAR(2048) NOT NULL,
    [sol_Ticket] VARCHAR(16) NOT NULL,
    [acc_ID] INT NOT NULL,
    [arl_ID] INT NOT NULL,
    [usr_ID] INT NOT NULL
);

CREATE TABLE [AccountSecurityReportGroup] (
    [asr_ID] INT NOT NULL -- PK,
    [asr_Name_Short] VARCHAR(64) NOT NULL,
    [asr_Name_Cool] VARCHAR(64) NOT NULL,
    [asr_Sort] INT NOT NULL
);

CREATE TABLE [AccountSecurtyUsers] (
    [acc_ID] INT NOT NULL -- PK,
    [acc_Super] BIT NULL,
    [acc_AdOps] BIT NULL
);

CREATE TABLE [AccountStatus] (
    [acs_ID] INT NOT NULL -- PK,
    [acs_Name] VARCHAR(64) NOT NULL,
    [acs_Notes] VARCHAR(1024) NOT NULL,
    [acs_Active] BIT NOT NULL
);

CREATE TABLE [AccountSummary] (
    [acc_id] INT NULL,
    [acc_company] VARCHAR(256) NULL,
    [clb_name] VARCHAR(128) NULL,
    [clp_created] DATE NULL,
    [clp_expires] DATE NULL,
    [post_count] INT NULL,
    [email_count] INT NULL,
    [total_call_count] INT NULL,
    [CL_PhoneNumber] VARCHAR(10) NOT NULL,
    [cl_call_count] INT NULL,
    [CL_TextNumber] VARCHAR(10) NOT NULL,
    [cl_no_price] BIT NULL,
    [cl_no_email] BIT NULL,
    [cl_no_phone] BIT NULL
);

CREATE TABLE [AccountVerifiedLog] (
    [avl_ID] INT NOT NULL -- PK,
    [avl_Date] DATETIME NOT NULL,
    [avl_Total] INT NOT NULL,
    [avl_Verified] INT NOT NULL
);

CREATE TABLE [Active_Campaigns] (
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

CREATE TABLE [ActiveAdEzCampaigns] (
    [c_Id] FLOAT NULL,
    [c_Ratchet_Id] FLOAT NULL,
    [c_Name] NVARCHAR(255) NULL,
    [c_State] NVARCHAR(255) NULL,
    [c_Manager_Id] FLOAT NULL,
    [c_Manager_Name] NVARCHAR(255) NULL,
    [c_Account_Id] FLOAT NULL,
    [c_Client_Id] FLOAT NULL,
    [c_Client_Name] NVARCHAR(255) NULL,
    [c_Sales_Channel] NVARCHAR(255) NULL,
    [c_Campaign_Type] NVARCHAR(255) NULL,
    [c_Sales_Representative] NVARCHAR(255) NULL,
    [s_Id] FLOAT NULL,
    [s_Advertiser_Id] FLOAT NULL,
    [s_Sales_Channel_Id] FLOAT NULL,
    [s_Sales_Representative_Id] FLOAT NULL,
    [s_User_Id] FLOAT NULL,
    [s_State] NVARCHAR(255) NULL,
    [s_Name] NVARCHAR(255) NULL,
    [s_Product_Type] NVARCHAR(255) NULL,
    [a_Id] FLOAT NULL,
    [a_External_Id] FLOAT NULL,
    [a_Business_Name] NVARCHAR(255) NULL,
    [a_External_Business_Id] FLOAT NULL,
    [a_Sales_Channel_Id] FLOAT NULL,
    [sc_Id] FLOAT NULL,
    [sc_External_Id] FLOAT NULL,
    [sc_Name] NVARCHAR(255) NULL,
    [sr_Id] FLOAT NULL,
    [sr_External_Id] FLOAT NULL,
    [sr_First_Name] NVARCHAR(255) NULL,
    [sr_Last_Name] NVARCHAR(255) NULL,
    [sr_Email] NVARCHAR(255) NULL,
    [sr_Channel_Id] FLOAT NULL
);

CREATE TABLE [ActivityLog] (
    [LogID] BIGINT NOT NULL -- PK,
    [LogDateTime] DATETIME2 NULL,
    [SessionID] INT NULL,
    [LoginName] NVARCHAR(128) NULL,
    [ProgramName] NVARCHAR(128) NULL,
    [HostName] NVARCHAR(128) NULL,
    [DatabaseName] NVARCHAR(128) NULL,
    [Status] NVARCHAR(30) NULL,
    [Command] NVARCHAR(32) NULL,
    [CPUTime] BIGINT NULL,
    [TotalElapsedTime] BIGINT NULL,
    [Reads] BIGINT NULL,
    [Writes] BIGINT NULL,
    [LogicalReads] BIGINT NULL,
    [QueryText] NVARCHAR(MAX) NULL,
    [WaitType] NVARCHAR(60) NULL,
    [WaitTime] BIGINT NULL,
    [BlockedBy] INT NULL,
    [MemoryUsageKB] BIGINT NULL,
    [OpenTransactionCount] INT NULL,
    [LastRequestStartTime] DATETIME2 NULL,
    [IsUserProcess] BIT NULL,
    [ClientInterface] NVARCHAR(32) NULL
);

CREATE TABLE [AdCenterImpressions] (
    [act_id] BIGINT NOT NULL -- PK,
    [acc_id] INT NOT NULL,
    [aso_id] INT NOT NULL,
    [action_id] INT NOT NULL,
    [time] DATETIME NOT NULL
);

CREATE TABLE [AdCenterObjects] (
    [dbName] NVARCHAR(128) NULL,
    [priObject] VARCHAR(256) NULL,
    [refObjectID] INT NULL,
    [refObjectName] NVARCHAR(128) NULL,
    [refObjectType] NVARCHAR(60) NULL,
    [refColumnID] INT NULL,
    [refColumnName] NVARCHAR(128) NULL,
    [is_Caller_Dependent] BIT NOT NULL,
    [is_Ambiguous] BIT NOT NULL,
    [refDBName] VARCHAR(32) NULL
);

CREATE TABLE [adez_advertiser] (
    [acc_ID] INT NOT NULL,
    [cusid] BIGINT NULL,
    [acc_Company] VARCHAR(64) NOT NULL,
    [acc_Contact] VARCHAR(65) NULL,
    [acc_URL] VARCHAR(512) NULL,
    [acc_Phone] VARCHAR(16) NOT NULL,
    [acc_Address] VARCHAR(64) NOT NULL,
    [acc_City] VARCHAR(64) NOT NULL,
    [acc_State] VARCHAR(2) NOT NULL,
    [zip_Code] VARCHAR(5) NOT NULL,
    [acc_Image] VARCHAR(512) NULL,
    [acc_Created] DATETIME NOT NULL,
    [acc_Modified] DATETIME NOT NULL,
    [adv_id] BIGINT NULL,
    [sc_aso_id] BIGINT NULL,
    [sr_id] BIGINT NULL,
    [sr_login] VARCHAR(128) NULL,
    [sub_status] VARCHAR(16) NULL,
    [Start_Date] DATE NULL,
    [End_Date] DATE NULL
);

CREATE TABLE [AdEzMegatronMismatch] (
    [cmp_id] BIGINT NULL,
    [ratchet_id] BIGINT NULL,
    [cmp_status] NVARCHAR(16) NULL,
    [end_date] DATETIME2 NULL,
    [sales_channel] NVARCHAR(2048) NULL,
    [adv_id] BIGINT NULL,
    [adv_name] NVARCHAR(1024) NULL,
    [adv_acc_id] BIGINT NULL,
    [acc_id] INT NULL,
    [ffwname] VARCHAR(64) NULL,
    [ffaactive] FLOAT NULL,
    [ftname] VARCHAR(32) NULL,
    [fduid] INT NOT NULL,
    [campaign_type] NVARCHAR(510) NULL
);

CREATE TABLE [ADPActiveCampaign] (
    [rdt_Name] VARCHAR(50) NULL,
    [rcd_Campaign_Name] VARCHAR(8000) NULL,
    [rcd_Master_ID] BIGINT NULL,
    [STATUS] VARCHAR(8) NOT NULL,
    [rcd_StartDate] DATETIME NULL,
    [rcd_EndDate] DATETIME NULL,
    [rcd_ID] INT NOT NULL
);

CREATE TABLE [ADPCampaigns] (
    [id] BIGINT NOT NULL -- PK,
    [ratchetId] BIGINT NULL,
    [subscriptionId] BIGINT NULL,
    [provider] VARCHAR(128) NULL,
    [providerId] VARCHAR(100) NULL,
    [name] VARCHAR(128) NOT NULL,
    [notes] VARCHAR(8000) NULL,
    [monthlyBudget] MONEY NOT NULL,
    [startDate] DATETIME NULL,
    [endDate] DATETIME NULL,
    [targetClicks] INT NOT NULL,
    [targetImpressions] INT NULL,
    [purchasePlan] VARCHAR(128) NULL,
    [purchaseType] VARCHAR(128) NULL,
    [dailyBudget] MONEY NOT NULL,
    [bidStrategy] VARCHAR(128) NULL,
    [adRotation] VARCHAR(128) NULL,
    [mobileBidAdjustment] VARCHAR(128) NULL,
    [mobileBidPercentage] FLOAT NULL,
    [frequencyCap] INT NOT NULL,
    [maxCpc] MONEY NULL,
    [maxCpm] MONEY NULL,
    [managerId] INT NULL,
    [managerName] VARCHAR(128) NULL,
    [accountId] INT NULL,
    [clientId] INT NULL,
    [clientName] VARCHAR(128) NULL,
    [salesChannel] VARCHAR(128) NULL,
    [campaignType] VARCHAR(128) NULL,
    [state] VARCHAR(128) NULL,
    [locations] VARCHAR(8000) NULL,
    [submitType] VARCHAR(128) NULL,
    [submitDate] DATETIME NULL,
    [salesRepId] INT NULL,
    [cost] MONEY NULL,
    [entered] DATETIME NOT NULL,
    [cusId] INT NULL,
    [productId] INT NULL,
    [updated] DATETIME NULL,
    [includeDescriptionVIN] BIT NULL
);

CREATE TABLE [ADPCreatives] (
    [id] BIGINT NOT NULL -- PK,
    [parentId] BIGINT NOT NULL,
    [ratchetId] BIGINT NULL,
    [assetId] BIGINT NULL,
    [subscriptionId] BIGINT NULL,
    [providerId] BIGINT NULL,
    [creativeUrl] VARCHAR(1024) NOT NULL,
    [size] VARCHAR(128) NOT NULL,
    [startDate] DATETIME NULL,
    [endDate] DATETIME NULL,
    [landingUrl] VARCHAR(1024) NULL,
    [creativeType] VARCHAR(128) NULL,
    [entered] DATETIME NOT NULL,
    [template] VARCHAR(128) NULL,
    [color] VARCHAR(20) NULL,
    [landingType] VARCHAR(20) NULL,
    [dealerHomepage] VARCHAR(1024) NULL,
    [trackingCode] VARCHAR(1024) NULL,
    [vehicleType] VARCHAR(50) NULL,
    [companyName] VARCHAR(128) NULL,
    [message] VARCHAR(128) NULL,
    [logo] VARCHAR(1024) NULL,
    [backupAd] VARCHAR(1024) NULL,
    [algoType] VARCHAR(128) NULL
);

CREATE TABLE [ADPFeeds] (
    [ratchetId] BIGINT NOT NULL -- PK,
    [subscriptionId] BIGINT NOT NULL -- PK,
    [formtype] INT NOT NULL,
    [salesChannelId] INT NOT NULL,
    [datestart] SMALLDATETIME NOT NULL,
    [datesold] SMALLDATETIME NOT NULL,
    [dateentered] SMALLDATETIME NOT NULL,
    [enteredby] INT NOT NULL,
    [rep] INT NOT NULL,
    [cusid] INT NOT NULL,
    [price] MONEY NOT NULL,
    [prorate] BIT NULL,
    [package] INT NULL,
    [delayed] BIT NOT NULL,
    [excluderan] BIT NOT NULL,
    [excludercy] BIT NULL,
    [header] VARCHAR(256) NULL,
    [footer] VARCHAR(256) NULL,
    [aggregator] VARCHAR(100) NOT NULL,
    [notes] VARCHAR(MAX) NOT NULL,
    [clientName] VARCHAR(256) NULL,
    [clientAddress] VARCHAR(256) NULL,
    [clientAddress2] VARCHAR(256) NULL,
    [clientCity] VARCHAR(256) NULL,
    [clientState] VARCHAR(2) NULL,
    [clientZip] VARCHAR(10) NULL,
    [clientURL] VARCHAR(512) NULL,
    [clientEmailText] VARCHAR(128) NULL,
    [clientEmailXML] VARCHAR(128) NULL,
    [clientContactEmail] VARCHAR(128) NULL,
    [clientContactName] VARCHAR(128) NULL,
    [clientPhone] VARCHAR(30) NULL,
    [aggregatorName] VARCHAR(128) NULL,
    [aggregatorContactName] VARCHAR(128) NULL,
    [aggregatorAddress] VARCHAR(128) NULL,
    [aggregatorPhone] VARCHAR(128) NULL,
    [aggregatorEmail] VARCHAR(128) NULL,
    [formInventory] INT NOT NULL,
    [trackingNumber] VARCHAR(30) NULL,
    [productId] INT NULL,
    [dateend] DATETIME NULL,
    [wholesaleCost] MONEY NULL
);

CREATE TABLE [ADPLocal] (
    [rcl_ID] INT NOT NULL -- PK,
    [rcl_Master_ID] INT NULL,
    [rcc_ID] INT NOT NULL,
    [rcl_Created] DATETIME NOT NULL,
    [rcl_Created_acc_ID] INT NOT NULL,
    [rcl_DateSold] DATETIME NOT NULL,
    [rcl_Cost] MONEY NOT NULL,
    [rcl_rft_ID] INT NOT NULL,
    [rcl_isLive] BIT NOT NULL,
    [rcl_MeteredLine] BIT NOT NULL,
    [rcl_RecordCalls] BIT NOT NULL,
    [rcl_Email] VARCHAR(128) NOT NULL,
    [rcl_TagLine] VARCHAR(MAX) NOT NULL,
    [rcl_Bullet1] VARCHAR(80) NOT NULL,
    [rcl_Bullet2] VARCHAR(80) NOT NULL,
    [rcl_Bullet3] VARCHAR(80) NOT NULL,
    [rcl_Message] VARCHAR(MAX) NOT NULL,
    [rcl_SiteURL] VARCHAR(512) NOT NULL,
    [rcl_DisplayURL] VARCHAR(512) NOT NULL,
    [rcl_FaceBookURL] VARCHAR(512) NOT NULL,
    [rcl_TwitterAccount] VARCHAR(128) NOT NULL,
    [rcl_TwitterPassword] VARCHAR(50) NOT NULL,
    [rcl_ReservationsLink] VARCHAR(256) NOT NULL,
    [rcl_MenuLink] VARCHAR(256) NOT NULL,
    [rcl_AcceptedPayment] VARCHAR(256) NOT NULL,
    [rcl_SponsoredTagLine] VARCHAR(MAX) NOT NULL,
    [rcl_OwnerImage] VARCHAR(512) NOT NULL,
    [rcl_SponsoredImage] VARCHAR(512) NOT NULL,
    [rcl_LiveDate] DATETIME NULL,
    [rcl_SentToCGDate] DATETIME NULL,
    [rcl_ZipCodes] VARCHAR(MAX) NOT NULL,
    [rlds_id] INT NULL,
    [rcl_TrackingPhone] VARCHAR(24) NOT NULL,
    [rcl_LocalPhone] VARCHAR(24) NOT NULL,
    [rcl_NoWhosCalling] BIT NOT NULL,
    [rcl_CitySearchOnly] BIT NOT NULL,
    [rcl_OfferSlogan] VARCHAR(50) NOT NULL,
    [rcl_HasCoupon] BIT NOT NULL,
    [rcl_YouTubeURL] VARCHAR(255) NOT NULL,
    [rcl_TaglineURL] VARCHAR(255) NOT NULL,
    [rcl_Location_Name] VARCHAR(64) NOT NULL,
    [rcl_Location_Address1] VARCHAR(64) NOT NULL,
    [rcl_Location_Address2] VARCHAR(64) NOT NULL,
    [rcl_Location_City] VARCHAR(64) NOT NULL,
    [rcl_Location_State] VARCHAR(2) NOT NULL,
    [rcl_Location_Zip] VARCHAR(5) NOT NULL,
    [rcl_CG_Budget] MONEY NULL,
    [rcl_Notes] VARCHAR(MAX) NOT NULL,
    [rcl_YextListingManager] BIT NOT NULL,
    [rcl_StartDate] DATETIME NULL,
    [rcl_EndDate] DATETIME NULL,
    [updated] DATETIME NULL
);

CREATE TABLE [ADPPackages] (
    [packageId] INT NOT NULL -- PK,
    [subscriptionId] INT NOT NULL -- PK,
    [startDate] DATETIME NULL,
    [endDate] DATETIME NOT NULL,
    [salesChannelId] INT NOT NULL,
    [businessId] INT NOT NULL,
    [advertiserId] INT NOT NULL,
    [salesRepId] INT NOT NULL,
    [state] VARCHAR(255) NULL
);

CREATE TABLE [ADPSmartAd] (
    [campaignId] INT NOT NULL -- PK,
    [creativeId] INT NOT NULL -- PK,
    [size] VARCHAR(50) NOT NULL,
    [color] VARCHAR(10) NOT NULL,
    [landingType] VARCHAR(20) NOT NULL,
    [dealerHomepage] VARCHAR(1024) NOT NULL,
    [trackingCode] VARCHAR(1024) NOT NULL,
    [vehicleType] VARCHAR(50) NOT NULL,
    [companyName] VARCHAR(128) NOT NULL,
    [message] VARCHAR(128) NOT NULL,
    [algoType] VARCHAR(128) NOT NULL
);

CREATE TABLE [ADPSmartAdMapping] (
    [color] VARCHAR(50) NOT NULL -- PK,
    [size] VARCHAR(50) NOT NULL -- PK,
    [rdm_id] INT NOT NULL
);

CREATE TABLE [Advertiser_Settings] (
    [settings_id] INT NOT NULL,
    [adv_id] INT NOT NULL,
    [acc_id] INT NOT NULL,
    [new_monthly_payment] BIT NOT NULL,
    [new_apr] DECIMAL(18,2) NULL,
    [new_term] INT NULL,
    [new_down] INT NULL,
    [new_disclaimer] VARCHAR(8000) NULL,
    [used_monthly_payment] BIT NOT NULL,
    [used_apr] DECIMAL(18,2) NULL,
    [used_term] INT NULL,
    [used_down] INT NULL,
    [used_disclaimer] VARCHAR(8000) NULL,
    [updated] DATETIME NOT NULL,
    [updated_by] VARCHAR(50) NOT NULL
);

CREATE TABLE [AdvertiserChange] (
    [change_id] INT NOT NULL -- PK,
    [adv_id] INT NOT NULL,
    [updated] DATETIME NOT NULL,
    [orig_adv_name] VARCHAR(200) NOT NULL,
    [orig_domain] VARCHAR(200) NOT NULL,
    [new_adv_name] VARCHAR(200) NOT NULL,
    [new_domain] VARCHAR(200) NOT NULL,
    [reason] VARCHAR(50) NOT NULL
);

CREATE TABLE [AdvertiserSubscriptions] (
    [Id] INT NULL,
    [External_Business_Id] INT NULL,
    [External_Id] INT NULL,
    [Business_Name] VARCHAR(512) NULL,
    [Sales_Channel_ID] INT NULL,
    [Name] VARCHAR(512) NULL,
    [Product_Type] VARCHAR(512) NULL
);

CREATE TABLE [AgentEventContract] (
    [Id] INT NOT NULL -- PK,
    [AgentId] INT NOT NULL,
    [EventTypeId] INT NOT NULL,
    [Enabled] BIT NOT NULL,
    [TimeoutSeconds] INT NULL,
    [MaxRetries] INT NULL,
    [CreatedAt] DATETIME NOT NULL,
    [UpdatedAt] DATETIME NOT NULL
);

CREATE TABLE [AiAgent] (
    [AgentId] INT NOT NULL -- PK,
    [Name] NVARCHAR(200) NOT NULL,
    [Description] NVARCHAR(MAX) NULL,
    [IsActive] BIT NOT NULL,
    [ModelProvider] NVARCHAR(50) NULL,
    [ModelName] NVARCHAR(100) NULL,
    [ModelVersion] NVARCHAR(50) NULL,
    [EndpointUrl] NVARCHAR(500) NULL,
    [CreatedAt] DATETIME NOT NULL,
    [UpdatedAt] DATETIME NOT NULL
);

CREATE TABLE [AlertList] (
    [adv_acc_id] BIGINT NULL,
    [cmp_id] BIGINT NULL,
    [key] VARCHAR(250) NULL,
    [value] VARCHAR(1000) NULL,
    [sort] INT NULL
);

CREATE TABLE [AllScheduledJobsOnServer] (
    [job_id] UNIQUEIDENTIFIER NOT NULL,
    [jobname] NVARCHAR(128) NOT NULL,
    [enabled] TINYINT NOT NULL,
    [description] NVARCHAR(512) NULL,
    [schedulename] NVARCHAR(128) NULL,
    [freq_type] VARCHAR(45) NULL,
    [freq_interval] VARCHAR(64) NULL,
    [freq_subday_interval] INT NULL,
    [freq_subday_type] VARCHAR(21) NULL,
    [freq_relative_interval] VARCHAR(6) NULL,
    [freq_recurrence_factor] INT NULL,
    [active_start_date] INT NULL,
    [active_end_time] INT NULL,
    [step_id] INT NOT NULL,
    [step_name] NVARCHAR(128) NOT NULL,
    [database_name] NVARCHAR(128) NULL,
    [command] NVARCHAR(MAX) NULL,
    [retry_attempts] INT NOT NULL,
    [retry_interval] INT NOT NULL
);

CREATE TABLE [AreaCode] (
    [Area] VARCHAR(3) NOT NULL -- PK,
    [State] VARCHAR(2) NOT NULL,
    [Zip] VARCHAR(5) NOT NULL
);

CREATE TABLE [AreaPrefix] (
    [Area] VARCHAR(3) NOT NULL -- PK,
    [Prefix] VARCHAR(3) NOT NULL -- PK,
    [City] VARCHAR(64) NOT NULL,
    [State] VARCHAR(2) NOT NULL,
    [Zip] VARCHAR(5) NOT NULL
);

CREATE TABLE [AttributeOption] (
    [ato_ID] INT NOT NULL -- PK,
    [att_ID] INT NOT NULL,
    [ato_Text] VARCHAR(128) NOT NULL,
    [ato_Value] VARCHAR(128) NOT NULL,
    [ato_Order] INT NOT NULL,
    [ato_Active] BIT NOT NULL,
    [ato_OnlySome] VARCHAR(128) NULL
);

CREATE TABLE [BackupLog] (
    [LogID] BIGINT NOT NULL -- PK,
    [LogDateTime] DATETIME2 NULL,
    [DatabaseName] NVARCHAR(128) NULL,
    [BackupType] NVARCHAR(20) NULL,
    [BackupStartDate] DATETIME2 NULL,
    [BackupFinishDate] DATETIME2 NULL,
    [BackupSizeMB] DECIMAL(10,2) NULL,
    [CompressedBackupSizeMB] DECIMAL(10,2) NULL,
    [BackupSetName] NVARCHAR(128) NULL,
    [Description] NVARCHAR(255) NULL,
    [UserName] NVARCHAR(128) NULL,
    [ServerName] NVARCHAR(128) NULL,
    [IsRunning] BIT NULL,
    [BackupSetUUID] UNIQUEIDENTIFIER NULL,
    [MediaSetID] INT NULL,
    [Position] SMALLINT NULL
);

CREATE TABLE [BADLEADS] (
    [ldq_id] INT NOT NULL,
    [lst_id] INT NOT NULL,
    [ldq_lqs_id] INT NOT NULL,
    [ldq_fromip] VARCHAR(16) NOT NULL,
    [ldq_created] DATETIME NOT NULL,
    [ldq_Frommail] VARCHAR(256) NOT NULL,
    [lst_onlinetext] VARCHAR(8000) NULL,
    [ldq_adfxml] VARCHAR(8000) NULL
);

CREATE TABLE [BadWords] (
    [bad_ID] INT NOT NULL -- PK,
    [bad_Word] VARCHAR(128) NOT NULL,
    [lastmodified] SMALLDATETIME NULL,
    [lastmodifiedby] INT NULL,
    [active] BIT NULL
);

CREATE TABLE [Banner] (
    [ban_ID] INT NOT NULL -- PK,
    [bst_ID] INT NOT NULL,
    [bty_ID] INT NOT NULL,
    [bsz_ID] INT NOT NULL,
    [ban_CreatedBy] INT NOT NULL,
    [ban_Created] DATETIME NOT NULL,
    [ban_ModifiedBy] INT NOT NULL,
    [ban_Modified] DATETIME NOT NULL,
    [ban_Name] VARCHAR(256) NOT NULL,
    [ban_Cost] MONEY NOT NULL,
    [ban_RolloverText] VARCHAR(256) NOT NULL,
    [ban_HRef] VARCHAR(512) NOT NULL,
    [ban_Target] VARCHAR(16) NOT NULL,
    [ban_Image] VARCHAR(4096) NOT NULL,
    [ban_Image_LastUpload] DATETIME NOT NULL,
    [ban_Hits] BIGINT NOT NULL,
    [ban_OnSchedule] BIT NOT NULL,
    [ban_StartDate] DATETIME NOT NULL,
    [ban_StopDate] DATETIME NOT NULL,
    [ban_AlertGM] BIT NOT NULL,
    [ban_AlertEmail] VARCHAR(128) NOT NULL,
    [aso_ID] INT NOT NULL,
    [ban_Rep_acc_ID] INT NOT NULL,
    [ban_cusid] INT NULL,
    [acc_ID] INT NULL
);

CREATE TABLE [BannerLogTotal] (
    [blt_ID] INT NOT NULL -- PK,
    [ban_ID] INT NOT NULL,
    [blt_Date] INT NOT NULL,
    [blt_Hits] INT NOT NULL,
    [blt_Clicks] INT NOT NULL
);

CREATE TABLE [business_advertiser_compare] (
    [bus_id] BIGINT NULL,
    [bus_name_ans] VARCHAR(256) NULL,
    [bus_address] NVARCHAR(1024) NULL,
    [bus_city] NVARCHAR(1024) NULL,
    [bus_state] NVARCHAR(2) NULL,
    [bus_zip] NVARCHAR(32) NULL,
    [bus_phone] VARCHAR(32) NULL,
    [bus_website] NVARCHAR(1024) NULL,
    [bus_domain_only] VARCHAR(1024) NULL,
    [adv_id] BIGINT NULL,
    [adv_name_ans] VARCHAR(256) NULL,
    [adv_address] NVARCHAR(1024) NULL,
    [adv_city] NVARCHAR(1024) NULL,
    [adv_state] NVARCHAR(2) NULL,
    [adv_zip] NVARCHAR(32) NULL,
    [adv_phone] VARCHAR(32) NULL,
    [adv_domain_only] VARCHAR(1024) NULL
);

CREATE TABLE [business_dedupe] (
    [bus_id] BIGINT NULL,
    [bus_name] NVARCHAR(512) NULL,
    [bus_name_ans] VARCHAR(256) NULL,
    [bus_address] NVARCHAR(1024) NULL,
    [bus_city] NVARCHAR(1024) NULL,
    [bus_state] NVARCHAR(2) NULL,
    [bus_zip] NVARCHAR(32) NULL,
    [bus_address_ans] NVARCHAR(288) NULL,
    [bus_phone] VARCHAR(32) NULL,
    [bus_website] NVARCHAR(1024) NULL,
    [bus_domain_only] VARCHAR(1024) NULL,
    [dis_adv_count] INT NULL,
    [n_sales_channel] VARCHAR(128) NULL,
    [x_sales_channel] VARCHAR(128) NULL,
    [n_sub_status] VARCHAR(16) NULL,
    [active_adv_count] INT NULL,
    [n_active_adv_id] BIGINT NULL,
    [x_active_adv_id] BIGINT NULL,
    [x_end_date] DATE NULL
);

CREATE TABLE [BusinessType] (
    [bty_ID] INT NOT NULL -- PK,
    [bty_Name] VARCHAR(64) NOT NULL
);

CREATE TABLE [CampaignMetaData] (
    [CampaignId] INT NULL,
    [AccountId] INT NULL,
    [Updated] DATETIME NOT NULL,
    [UpdatedBy] VARCHAR(50) NOT NULL,
    [Notes] VARCHAR(1024) NOT NULL
);

CREATE TABLE [CampaignWebsite] (
    [Id] BIGINT NULL,
    [Website_Url] VARCHAR(255) NULL
);

CREATE TABLE [cardata] (
    [model_id] VARCHAR(50) NULL,
    [model_make_id] VARCHAR(500) NULL,
    [model_name] VARCHAR(500) NULL,
    [model_trim] VARCHAR(500) NULL,
    [model_year] VARCHAR(500) NULL,
    [model_body_style] VARCHAR(500) NULL,
    [model_engine_position] VARCHAR(500) NULL,
    [model_engine_cc] VARCHAR(500) NULL,
    [model_engine_num_cyl] VARCHAR(500) NULL,
    [model_engine_type] VARCHAR(500) NULL,
    [mode_engine_valves_per_cyl] VARCHAR(500) NULL,
    [model_engine_power_ps] VARCHAR(500) NULL,
    [model_engine_power_rpm] VARCHAR(500) NULL,
    [model_engine_torque_nm] VARCHAR(500) NULL,
    [model_engine_torque_rpm] VARCHAR(500) NULL,
    [model_engine_bore_mm] VARCHAR(500) NULL,
    [model_engine_stroke_mm] VARCHAR(500) NULL,
    [model_engine_compression] VARCHAR(500) NULL,
    [model_engine_fuel] VARCHAR(500) NULL,
    [model_top_speed_kph] VARCHAR(500) NULL,
    [model_0_to_100_kph] VARCHAR(500) NULL,
    [model_drive] VARCHAR(500) NULL,
    [model_transmission_type] VARCHAR(500) NULL,
    [model_seats] VARCHAR(500) NULL,
    [model_doors] VARCHAR(500) NULL,
    [model_weight_kg] VARCHAR(500) NULL,
    [model_length_mm] VARCHAR(500) NULL,
    [model_width_mm] VARCHAR(500) NULL,
    [model_height_mm] VARCHAR(500) NULL,
    [model_wheelbase] VARCHAR(500) NULL,
    [model_lkm_hwy] VARCHAR(500) NULL,
    [model_lkm_mixed] VARCHAR(500) NULL,
    [model_lkm_city] VARCHAR(500) NULL,
    [model_fuel_cap_l] VARCHAR(500) NULL,
    [model_sold_in_us] VARCHAR(500) NULL,
    [model_co2] VARCHAR(500) NULL,
    [model_make_display] VARCHAR(500) NULL
);

CREATE TABLE [CarFax_ResultLog] (
    [cfr_ID] BIGINT NOT NULL -- PK,
    [cfr_Date] DATETIME NOT NULL,
    [cfr_VIN] VARCHAR(32) NOT NULL,
    [cfr_Result1] VARCHAR(32) NOT NULL,
    [cfr_Result2] VARCHAR(32) NOT NULL,
    [cfr_Result3] VARCHAR(32) NOT NULL,
    [cfr_XML] VARCHAR(MAX) NOT NULL
);

CREATE TABLE [CarFaxData] (
    [acc_id] INT NOT NULL,
    [lst_id] INT NOT NULL -- PK,
    [vin] VARCHAR(128) NOT NULL,
    [freeexpiration] VARCHAR(10) NULL,
    [oneowner] VARCHAR(1) NULL
);

CREATE TABLE [CarModels] (
    [Make] VARCHAR(32) NULL,
    [Model] VARCHAR(64) NULL,
    [SubModel] VARCHAR(64) NULL
);

CREATE TABLE [CarQuery_Temp] (
    [model_id] INT NULL,
    [model_make_id] VARCHAR(32) NULL,
    [model_name] VARCHAR(64) NULL,
    [model_trim] VARCHAR(128) NULL,
    [model_year] VARCHAR(16) NULL,
    [model_body] VARCHAR(32) NULL,
    [model_engine_position] VARCHAR(16) NULL,
    [model_engine_cc] VARCHAR(16) NULL,
    [model_engine_cyl] VARCHAR(16) NULL,
    [model_engine_type] VARCHAR(32) NULL,
    [model_engine_valves_per_cyl] VARCHAR(16) NULL,
    [model_engine_power_ps] VARCHAR(16) NULL,
    [model_engine_power_rpm] VARCHAR(16) NULL,
    [model_engine_torque_nm] VARCHAR(16) NULL,
    [model_engine_torque_rpm] VARCHAR(16) NULL,
    [model_engine_bore_mm] VARCHAR(16) NULL,
    [model_engine_stroke_mm] VARCHAR(16) NULL,
    [model_engine_compression] VARCHAR(16) NULL,
    [model_engine_fuel] VARCHAR(64) NULL,
    [model_top_speed_kph] VARCHAR(16) NULL,
    [model_0_to_160_kph] VARCHAR(16) NULL,
    [model_drive] VARCHAR(16) NULL,
    [model_transmission_type] VARCHAR(32) NULL,
    [model_seats] VARCHAR(16) NULL,
    [model_doors] VARCHAR(16) NULL,
    [model_weight_kg] VARCHAR(16) NULL,
    [model_length_mm] VARCHAR(16) NULL,
    [model_width_mm] VARCHAR(16) NULL,
    [model_height_mm] VARCHAR(16) NULL,
    [model_wheelbase_mm] VARCHAR(16) NULL,
    [model_lkm_hwy] VARCHAR(16) NULL,
    [model_lkm_mixed] VARCHAR(16) NULL,
    [model_lkm_city] VARCHAR(16) NULL,
    [model_fuel_cap_l] VARCHAR(16) NULL,
    [model_sold_in_us] VARCHAR(16) NULL,
    [model_co2] VARCHAR(8) NULL,
    [model_make_display] VARCHAR(64) NULL
);

CREATE TABLE [CharterCustomerDates] (
    [missing] DATE NULL
);

CREATE TABLE [CharterCustomerFinal] (
    [missing] DATE NULL,
    [acc_id] INT NOT NULL,
    [leads] INT NOT NULL,
    [directories] INT NOT NULL,
    [display] INT NOT NULL,
    [smartads] INT NOT NULL,
    [data_display] INT NOT NULL,
    [data_smartads] INT NOT NULL,
    [data_directories] INT NOT NULL,
    [data_leads] INT NOT NULL
);

CREATE TABLE [CharterCustomerMissingDates] (
    [missing] DATE NULL,
    [acc_id] INT NOT NULL,
    [leads] INT NOT NULL,
    [directories] INT NOT NULL,
    [display] INT NOT NULL,
    [smartads] INT NOT NULL,
    [data_display] INT NOT NULL,
    [data_smartads] INT NOT NULL,
    [data_directories] INT NOT NULL
);

CREATE TABLE [CharterCustomerMissingDates_feeds] (
    [acc_id] INT NOT NULL,
    [ncreated] DATE NULL,
    [xlastupload] DATE NULL
);

CREATE TABLE [CharterIDMapping] (
    [acc_ID] INT NOT NULL -- PK,
    [charter_Name] VARCHAR(256) NOT NULL,
    [charter_ID] VARCHAR(256) NOT NULL,
    [cir_ID] INT NULL,
    [alt_ID] VARCHAR(100) NULL
);

CREATE TABLE [CharterIDMapping_Regions] (
    [cir_ID] INT NOT NULL -- PK,
    [cir_Name] VARCHAR(64) NULL,
    [cir_Active] BIT NULL,
    [cir_Sort] INT NULL
);

CREATE TABLE [CharterIDMapping_Temp] (
    [acc_ID] BIGINT NULL,
    [charter_Name] VARCHAR(512) NULL,
    [charter_ID] VARCHAR(256) NOT NULL,
    [cir_ID] INT NOT NULL,
    [alt_ID] VARCHAR(256) NULL
);

CREATE TABLE [CharterView] (
    [Advertiser_ID] BIGINT NOT NULL,
    [acc_ID] BIGINT NULL,
    [Channel] NVARCHAR(3072) NULL,
    [Customer] NVARCHAR(512) NULL,
    [Phone] NVARCHAR(32) NULL,
    [leads] INT NOT NULL,
    [n_leads_date] DATE NULL,
    [x_leads_date] DATE NULL,
    [directories] INT NOT NULL,
    [n_directories_date] DATE NULL,
    [x_directories_date] DATE NULL,
    [display] INT NOT NULL,
    [n_display_date] DATE NULL,
    [x_display_date] DATE NULL,
    [smartads] INT NOT NULL,
    [n_smartads_date] DATE NULL,
    [x_smartads_date] DATE NULL,
    [package] INT NOT NULL,
    [n_package_date] DATE NULL,
    [x_package_date] DATE NULL
);

CREATE TABLE [CityGridCategory] (
    [cgc_ID] INT NOT NULL -- PK,
    [cgt_ID] INT NOT NULL,
    [cgr_ID] INT NOT NULL,
    [cgc_Name] VARCHAR(64) NOT NULL,
    [cgc_MinCPC] VARCHAR(64) NOT NULL,
    [cgc_Appearance] VARCHAR(64) NOT NULL,
    [cgc_Match] BIT NOT NULL,
    [cgc_Sort] INT NOT NULL
);

CREATE TABLE [CityGridRateCard] (
    [cgr_ID] INT NOT NULL -- PK,
    [cgr_Name] VARCHAR(64) NOT NULL,
    [cgr_Sort] INT NOT NULL
);

CREATE TABLE [CityGridTopLevel] (
    [cgt_ID] INT NOT NULL -- PK,
    [cgt_Name] VARCHAR(64) NOT NULL,
    [cgt_Sort] INT NOT NULL
);

CREATE TABLE [cl_Mapped] (
    [Inserted] DATETIME NOT NULL,
    [clb_code] VARCHAR(5) NOT NULL,
    [clsb_code] VARCHAR(5) NOT NULL,
    [acc_id] INT NOT NULL,
    [lst_id] INT NOT NULL -- PK,
    [lst_lastupload] DATETIME NOT NULL,
    [cl_Make] VARCHAR(128) NULL,
    [cl_Model] VARCHAR(128) NULL,
    [cl_Miles] VARCHAR(32) NULL,
    [cl_VIN] VARCHAR(32) NULL,
    [cl_Year] VARCHAR(128) NULL,
    [cl_TitleStatus] VARCHAR(128) NULL,
    [cl_BodyType] VARCHAR(128) NULL,
    [cl_Cylinders] VARCHAR(128) NULL,
    [cl_ExteriorColor] VARCHAR(128) NULL,
    [cl_Transmission] VARCHAR(128) NULL,
    [cl_DriveTrain] VARCHAR(128) NULL,
    [cl_FuelType] VARCHAR(128) NULL,
    [Listing_Attribute_Hash] VARBINARY(8000) NOT NULL,
    [Mapping_Table_Hash] VARBINARY(1) NOT NULL
);

CREATE TABLE [Class] (
    [cls_ID] INT NOT NULL -- PK,
    [cls_Name] VARCHAR(64) NOT NULL,
    [cls_URLName] VARCHAR(64) NOT NULL,
    [cls_Order] INT NOT NULL,
    [fed_CatName] VARCHAR(256) NULL,
    [clt_ID] INT NOT NULL,
    [prq_ID] INT NULL,
    [cls_HomePageExpand] BIT NOT NULL,
    [fed_ID] INT NULL,
    [fed_keyword] VARCHAR(256) NULL,
    [cls_Horizontal] BIT NOT NULL,
    [cls_Slogan] VARCHAR(256) NULL
);

CREATE TABLE [ClassCombo] (
    [cc_ID] INT NOT NULL -- PK,
    [cls_ID] INT NOT NULL,
    [scl_ID] INT NOT NULL
);

CREATE TABLE [ClassType] (
    [clt_ID] INT NOT NULL -- PK,
    [clt_Name] VARCHAR(32) NOT NULL,
    [clt_Vehicle] BIT NOT NULL,
    [clt_Active] BIT NOT NULL
);

CREATE TABLE [Client] (
    [client_id] INT NOT NULL -- PK,
    [account_id] INT NULL,
    [common_client_id] INT NULL,
    [company_name] VARCHAR(128) NOT NULL,
    [friendly_name] VARCHAR(128) NOT NULL,
    [address] VARCHAR(128) NULL,
    [city] VARCHAR(64) NULL,
    [state] VARCHAR(2) NULL,
    [postal_code] VARCHAR(10) NULL,
    [country] VARCHAR(50) NULL,
    [logo] VARCHAR(512) NULL,
    [url] VARCHAR(512) NULL,
    [fb_page] VARCHAR(512) NULL,
    [created] DATETIME NOT NULL,
    [modified] DATETIME NOT NULL,
    [phone] VARCHAR(16) NULL,
    [email_plain] VARCHAR(128) NULL,
    [email_adf] VARCHAR(128) NULL,
    [latitude] FLOAT NULL,
    [longitude] FLOAT NULL,
    [status] INT NOT NULL,
    [notes] VARCHAR(1024) NULL
);

CREATE TABLE [ClientFeedSetting] (
    [id] INT NOT NULL -- PK,
    [client_id] INT NOT NULL,
    [feed_direction] INT NOT NULL,
    [is_active] BIT NOT NULL,
    [name] VARCHAR(150) NULL,
    [feed_id] VARCHAR(50) NULL,
    [feed_data_provider] VARCHAR(50) NULL,
    [feed_source] VARCHAR(50) NULL,
    [priority] INT NOT NULL,
    [start_date] DATE NULL,
    [end_date] DATE NULL
);

CREATE TABLE [ClientGroup] (
    [id] INT NOT NULL -- PK,
    [name] VARCHAR(128) NOT NULL,
    [description] VARCHAR(1024) NOT NULL,
    [createdbyname] VARCHAR(128) NOT NULL,
    [createdby] INT NOT NULL,
    [modifiedbyname] VARCHAR(128) NOT NULL,
    [modifiedby] INT NOT NULL,
    [created] DATETIME NOT NULL,
    [modified] DATETIME NOT NULL,
    [active] BIT NOT NULL
);

CREATE TABLE [ClientGroupAccount] (
    [cg_id] INT NOT NULL -- PK,
    [acc_id] INT NOT NULL -- PK
);

CREATE TABLE [ClientGroupSubscription] (
    [cgsub_id] INT NOT NULL -- PK,
    [cg_id] INT NULL,
    [subscription_id] INT NULL
);

CREATE TABLE [ClientId_Mapping] (
    [client_id] UNIQUEIDENTIFIER NOT NULL -- PK,
    [advertiser_id] SMALLINT NOT NULL,
    [acc_id] INT NOT NULL
);

CREATE TABLE [ClientIdMapping] (
    [sm_id] BIGINT NULL,
    [advertiser_id] BIGINT NOT NULL,
    [sfdc_account_id] VARCHAR(64) NOT NULL,
    [cusid] BIGINT NULL
);

CREATE TABLE [CommonClientIdMapping] (
    [acc_id] INT NOT NULL -- PK,
    [sales_channel_id] INT NOT NULL -- PK,
    [ref_id] VARCHAR(50) NOT NULL -- PK,
    [client_id] VARCHAR(50) NULL,
    [account_tier] VARCHAR(50) NULL
);

CREATE TABLE [CoreLog] (
    [coreID] INT NOT NULL -- PK,
    [coreCMD] NVARCHAR(4000) NOT NULL,
    [coreDate] DATETIME NOT NULL
);

CREATE TABLE [Countries] (
    [country] VARCHAR(50) NULL,
    [countryname] VARCHAR(50) NULL
);

CREATE TABLE [CountryCode] (
    [ci] INT NOT NULL,
    [cc] CHAR(2) NOT NULL,
    [cn] VARCHAR(50) NOT NULL
);

CREATE TABLE [CountyNation] (
    [STATE] VARCHAR(5) NULL,
    [STATEFP] INT NULL,
    [COUNTYFP] INT NULL,
    [COUNTYNAME] VARCHAR(128) NULL,
    [CLASSFP] VARCHAR(5) NULL
);

CREATE TABLE [CountyZCTA] (
    [ZCTA5] VARCHAR(50) NULL,
    [STATE] VARCHAR(50) NULL,
    [COUNTY] VARCHAR(50) NULL,
    [GEOID] VARCHAR(50) NULL,
    [POPPT] VARCHAR(50) NULL,
    [HUPT] VARCHAR(50) NULL,
    [AREAPT] VARCHAR(50) NULL,
    [AREALANDPT] VARCHAR(50) NULL,
    [ZPOP] VARCHAR(50) NULL,
    [ZHU] VARCHAR(50) NULL,
    [ZAREA] VARCHAR(50) NULL,
    [ZAREALAND] VARCHAR(50) NULL,
    [COPOP] VARCHAR(50) NULL,
    [COHU] VARCHAR(50) NULL,
    [COAREA] VARCHAR(50) NULL,
    [COAREALAND] VARCHAR(50) NULL,
    [ZPOPPCT] DECIMAL(18,0) NULL,
    [ZHUPCT] VARCHAR(50) NULL,
    [ZAREAPCT] VARCHAR(50) NULL,
    [ZAREALANDPCT] VARCHAR(50) NULL,
    [COPOPPCT] VARCHAR(50) NULL,
    [COHUPCT] VARCHAR(50) NULL,
    [COAREAPCT] VARCHAR(50) NULL,
    [COAREALANDPCT] VARCHAR(50) NULL
);

CREATE TABLE [Craigslist_Burn] (
    [acc_ID] INT NOT NULL,
    [acc_Company] VARCHAR(64) NOT NULL,
    [clp_posting_id] BIGINT NULL,
    [mustpublish] BIT NULL,
    [newslots] INT NULL,
    [totalslots] INT NULL,
    [clb_Code] VARCHAR(5) NOT NULL,
    [clsb_Code] VARCHAR(5) NOT NULL,
    [sort_id] INT NULL,
    [lst_ID] INT NOT NULL,
    [lst_Price] MONEY NOT NULL,
    [lst_Title] VARCHAR(128) NOT NULL,
    [acc_Phone] VARCHAR(16) NOT NULL,
    [acc_Address] VARCHAR(64) NOT NULL,
    [acc_City] VARCHAR(64) NOT NULL,
    [acc_State] VARCHAR(2) NOT NULL,
    [zip_Code] VARCHAR(5) NOT NULL,
    [lst_OnlineText] VARCHAR(8000) NULL,
    [lst_Images] VARCHAR(8000) NULL,
    [cl_Year] VARCHAR(128) NULL,
    [cl_Make] VARCHAR(128) NULL,
    [cl_Model] VARCHAR(128) NULL,
    [cl_Trim] VARCHAR(128) NOT NULL,
    [cl_VIN] VARCHAR(32) NULL,
    [cl_Stock] VARCHAR(32) NOT NULL,
    [cl_Miles] VARCHAR(32) NULL,
    [cl_Condition] VARCHAR(9) NOT NULL,
    [cl_TitleStatus] VARCHAR(128) NULL,
    [cl_BodyType] VARCHAR(128) NULL,
    [cl_Cylinders] VARCHAR(128) NULL,
    [cl_ExteriorColor] VARCHAR(128) NULL,
    [cl_Transmission] VARCHAR(128) NULL,
    [cl_DriveTrain] VARCHAR(128) NULL,
    [cl_FuelType] VARCHAR(128) NULL,
    [cl_Size] VARCHAR(1) NOT NULL,
    [classification] VARCHAR(50) NULL,
    [cl_no_price] BIT NULL,
    [cl_no_email] BIT NULL,
    [cl_no_phone] BIT NULL,
    [clp_blacklisted] BIT NOT NULL,
    [BurnHour] INT NOT NULL,
    [id] INT NOT NULL,
    [SlotEnd] DATE NULL
);

CREATE TABLE [CraigslistAdvertisers] (
    [cla_ID] BIGINT NOT NULL -- PK,
    [fdUID] INT NOT NULL,
    [acc_ID] INT NULL,
    [cla_NewPosts] INT NOT NULL,
    [cla_Active] BIT NOT NULL,
    [cla_PostDate] DATE NULL
);

CREATE TABLE [CraigslistAdvertisers_BU] (
    [cla_ID] BIGINT NOT NULL,
    [fdUID] INT NOT NULL,
    [acc_ID] INT NULL,
    [cla_NewPosts] INT NOT NULL,
    [cla_Active] BIT NOT NULL,
    [cla_PostDate] DATE NULL
);

CREATE TABLE [CraigslistAdvertisers_BU2] (
    [cla_ID] BIGINT NOT NULL,
    [fdUID] INT NOT NULL,
    [acc_ID] INT NULL,
    [cla_NewPosts] INT NOT NULL,
    [cla_Active] BIT NOT NULL,
    [cla_PostDate] DATE NULL
);

CREATE TABLE [CraigslistAdvertisers_NewPostFix] (
    [claf_ID] INT NOT NULL -- PK,
    [clb_Code] VARCHAR(5) NOT NULL,
    [cla_PostDate] DATE NOT NULL,
    [acc_ID] INT NOT NULL,
    [acc_Company] VARCHAR(64) NOT NULL,
    [cla_NewPosts] INT NOT NULL,
    [Posting_Count] INT NOT NULL
);

CREATE TABLE [CraigslistAttribute] (
    [att_id] INT NOT NULL -- PK,
    [Name] VARCHAR(128) NOT NULL,
    [lvField] VARCHAR(32) NOT NULL,
    [lvField_Alternate] VARCHAR(32) NOT NULL,
    [DefaultValue] VARCHAR(32) NOT NULL,
    [Required] BIT NOT NULL
);

CREATE TABLE [CraigslistBucket] (
    [clb_id] INT NOT NULL -- PK,
    [clb_code] VARCHAR(5) NOT NULL,
    [clb_name] VARCHAR(64) NOT NULL,
    [clb_needsubbucket] BIT NULL,
    [clb_available] INT NULL,
    [clb_productid] INT NULL,
    [clb_lastrun] SMALLDATETIME NULL
);

CREATE TABLE [CraigslistEmail] (
    [clem_id] INT NOT NULL -- PK,
    [clem_email_id] VARCHAR(255) NOT NULL,
    [clem_from] VARCHAR(255) NOT NULL,
    [clem_subject] VARCHAR(255) NOT NULL,
    [clem_body] VARCHAR(4000) NOT NULL,
    [clem_date_received] DATETIME NOT NULL,
    [clem_date_processed] DATETIME NOT NULL,
    [receipt_id] VARCHAR(50) NULL
);

CREATE TABLE [CraigslistErrorLog] (
    [cel_Id] INT NOT NULL -- PK,
    [lst_Id] INT NOT NULL,
    [posting_Id] VARCHAR(50) NOT NULL,
    [cel_Status] VARCHAR(50) NOT NULL,
    [cel_Error] VARCHAR(255) NOT NULL,
    [cel_Date] SMALLDATETIME NOT NULL
);

CREATE TABLE [CraigslistListing] (
    [cll_id] INT NOT NULL -- PK,
    [cll_posted] DATETIME NOT NULL,
    [clp_posting_id] VARCHAR(128) NOT NULL,
    [lst_id] INT NOT NULL,
    [cll_created] DATETIME NOT NULL,
    [cll_last_upload] DATETIME NOT NULL,
    [lst_vin] VARCHAR(17) NULL
);

CREATE TABLE [CraigslistListing_Mapping] (
    [clp_posting_id] VARCHAR(128) NOT NULL,
    [lst_id] INT NOT NULL,
    [acc_ID] INT NULL,
    [fdUID] INT NULL
);

CREATE TABLE [CraigslistMapping] (
    [att_id] INT NOT NULL -- PK,
    [originalValue] VARCHAR(100) NOT NULL -- PK,
    [craigslistValue] VARCHAR(100) NULL
);

CREATE TABLE [CraigslistPosting] (
    [clp_posting_id] VARCHAR(128) NOT NULL -- PK,
    [clp_created] DATETIME NOT NULL,
    [clp_expires] DATETIME NULL,
    [clp_manage_link] VARCHAR(512) NOT NULL,
    [clb_id] INT NULL,
    [clsb_id] INT NULL,
    [clp_blacklisted] BIT NULL
);

CREATE TABLE [craigslistpostingsfromfile] (
    [postingDate] VARCHAR(56) NULL,
    [postingID] VARCHAR(32) NULL,
    [itemDescription] VARCHAR(255) NULL,
    [whoPosted] VARCHAR(255) NULL,
    [poNumber] VARCHAR(32) NULL,
    [quantity] VARCHAR(12) NULL,
    [total] VARCHAR(12) NULL
);

CREATE TABLE [CraigsListRegionList] (
    [clb_Code] VARCHAR(5) NULL,
    [clb_Desc] VARCHAR(256) NULL,
    [clsb_Code] VARCHAR(5) NULL,
    [clsb_Desc] VARCHAR(256) NULL
);

CREATE TABLE [CraigslistSchedule] (
    [clb_code] VARCHAR(3) NOT NULL -- PK,
    [day_of_week] INT NOT NULL -- PK,
    [schedule_time] DATETIME NOT NULL -- PK,
    [action] VARCHAR(10) NULL
);

CREATE TABLE [CraigslistSubBucket] (
    [clsb_id] INT NOT NULL -- PK,
    [clb_id] INT NOT NULL,
    [clsb_code] VARCHAR(5) NOT NULL,
    [clsb_description] VARCHAR(64) NOT NULL
);

CREATE TABLE [CraigslistValues] (
    [att_id] INT NOT NULL -- PK,
    [clValue] VARCHAR(50) NOT NULL -- PK
);

CREATE TABLE [CRM] (
    [crm_ID] INT NOT NULL -- PK,
    [crm_Name] VARCHAR(128) NOT NULL
);

CREATE TABLE [CurrentADAccounts] (
    [ADMYID] INT NOT NULL -- PK,
    [ADLogin] VARCHAR(64) NULL,
    [ADName] VARCHAR(128) NULL,
    [ADEmail] VARCHAR(128) NULL
);

CREATE TABLE [CurrentFBPageAccess] (
    [id] VARCHAR(50) NOT NULL,
    [name] VARCHAR(100) NOT NULL,
    [can_post] BIT NOT NULL,
    [access_token] VARCHAR(MAX) NOT NULL,
    [privacy_info_url] VARCHAR(512) NULL,
    [business_id] VARCHAR(50) NULL,
    [business_name] VARCHAR(128) NULL,
    [website] VARCHAR(512) NULL,
    [status] VARCHAR(50) NOT NULL,
    [username] VARCHAR(128) NULL,
    [inserted] DATETIME NOT NULL,
    [updated] DATETIME NOT NULL
);

CREATE TABLE [CusRepMove] (
    [old_aso_id] INT NOT NULL,
    [old_cusid] INT NOT NULL,
    [cusphone] VARCHAR(16) NOT NULL,
    [cuscompany] VARCHAR(64) NULL,
    [new_aso_id] INT NOT NULL,
    [new_cusid] INT NULL
);

CREATE TABLE [DataFeedProvider] (
    [data_feed_id] INT NOT NULL -- PK,
    [data_feed_provider] VARCHAR(100) NOT NULL
);

CREATE TABLE [DBINFO] (
    [file_id] INT NOT NULL,
    [name] NVARCHAR(128) NOT NULL,
    [type] TINYINT NOT NULL,
    [type_desc] NVARCHAR(60) NULL,
    [physical_name] NVARCHAR(260) NOT NULL,
    [size] BIGINT NULL,
    [max_size] INT NOT NULL,
    [growth] INT NOT NULL
);

CREATE TABLE [DealerGroups] (
    [dgr_ID] INT NOT NULL -- PK,
    [dgr_Rank] INT NOT NULL,
    [dgr_Name] VARCHAR(255) NOT NULL,
    [dgr_City] VARCHAR(255) NOT NULL,
    [dgr_State] VARCHAR(255) NOT NULL,
    [dgr_Executive] VARCHAR(255) NOT NULL,
    [dgr_TotalDealerships] INT NULL,
    [dgr_NewRevenue] MONEY NULL,
    [dgr_NewUnits] INT NULL,
    [dgr_FleetRevenue] MONEY NULL,
    [dgr_FleetUnits] INT NULL,
    [dgr_UsedRevenue] MONEY NULL,
    [dgr_UsedUnits] INT NULL,
    [dgr_WholesaleRevenue] MONEY NULL,
    [dgr_WholesaleUnits] INT NULL,
    [dgr_FIRevenue] MONEY NULL,
    [dgr_ServiceRevenue] MONEY NULL,
    [dgr_BodyShopRevenue] MONEY NULL,
    [dgr_PARevenue] MONEY NULL,
    [dgr_TotalUnits] INT NULL,
    [dgr_TotalRevenue] MONEY NULL
);

CREATE TABLE [DealershipDetails] (
    [acc_ID] INT NULL,
    [MakesHundred] VARCHAR(128) NULL,
    [MakesName] VARCHAR(128) NULL,
    [LastUpload] DATE NULL,
    [dlrType] VARCHAR(1) NULL
);

CREATE TABLE [DealerShips] (
    [dls_ID] INT NOT NULL -- PK,
    [dls_Rank] INT NOT NULL,
    [dls_Name] VARCHAR(255) NOT NULL,
    [dls_DealerGroup] VARCHAR(255) NOT NULL,
    [dls_City] VARCHAR(255) NOT NULL,
    [dls_State] VARCHAR(255) NOT NULL,
    [dls_NewRevenue] MONEY NULL,
    [dls_NewUnits] MONEY NULL,
    [dls_UsedRevenue] MONEY NULL,
    [dls_UsedUnits] INT NULL,
    [dls_FIRevenue] MONEY NULL,
    [dls_ServiceRevenue] MONEY NULL,
    [dls_BodyShopRevenue] MONEY NULL,
    [dls_PARevenue] MONEY NULL,
    [dls_TotalRevenue] MONEY NULL,
    [dls_TotalUnits] INT NULL,
    [dls_DealerGroupID] INT NULL,
    [acc_ID] INT NULL
);

CREATE TABLE [DefZipRadius] (
    [zip_Code] VARCHAR(5) NOT NULL,
    [zip_City] VARCHAR(32) NOT NULL,
    [stt_ID] VARCHAR(2) NOT NULL,
    [zip_Latitude] FLOAT NOT NULL,
    [zip_Longitude] FLOAT NOT NULL,
    [zip_Radius] INT NOT NULL,
    [AREACODE] VARCHAR(3) NULL
);

CREATE TABLE [DigitalOffice] (
    [dfc_ID] INT NOT NULL -- PK,
    [dfc_Name] VARCHAR(64) NOT NULL,
    [dfc_VP_Notify] VARCHAR(64) NOT NULL,
    [dfc_Active] BIT NOT NULL,
    [OffID] INT NOT NULL
);

CREATE TABLE [DigitalOfficeRep] (
    [acc_ID] INT NOT NULL -- PK,
    [dfc_ID] INT NOT NULL
);

CREATE TABLE [DMA] (
    [dma_Code] VARCHAR(5) NOT NULL -- PK,
    [dma_Name] VARCHAR(256) NULL,
    [dma_Homes] INT NULL,
    [dma_USPercent] DECIMAL(18,4) NULL,
    [dma_NielsenName] VARCHAR(128) NULL,
    [dma_Rank] INT NULL,
    [dma_Size] VARCHAR(32) NULL
);

CREATE TABLE [DMAtoZIP] (
    [JobState] VARCHAR(12) NULL,
    [DMA] VARCHAR(128) NULL,
    [CenterZip] VARCHAR(5) NULL,
    [JobStates] VARCHAR(128) NULL
);

CREATE TABLE [DupeDealix] (
    [src_id] INT NOT NULL,
    [src_adid] VARCHAR(32) NULL,
    [adcount] INT NULL,
    [min_lst_id] INT NULL,
    [max_lst_id] INT NULL
);

CREATE TABLE [dx_AccountRep] (
    [dlrid] INT NOT NULL,
    [pubid] INT NOT NULL,
    [aso_id] INT NULL,
    [acc_id_rep] INT NULL
);

CREATE TABLE [dx_EdTag] (
    [edtag] VARCHAR(64) NOT NULL -- PK
);

CREATE TABLE [dx_images] (
    [adid] INT NULL,
    [imgurl] VARCHAR(512) NULL,
    [IMGSORT] TINYINT NOT NULL
);

CREATE TABLE [dx_listings] (
    [dlrid] INT NULL,
    [dlrname] VARCHAR(64) NULL,
    [dlraddr] VARCHAR(64) NULL,
    [dlrcity] VARCHAR(32) NULL,
    [dlrstate] VARCHAR(2) NOT NULL,
    [dlrzip] VARCHAR(10) NULL,
    [dlrphone] VARCHAR(16) NOT NULL,
    [dlrfax] VARCHAR(16) NULL,
    [dlremail_STRING] VARCHAR(96) NULL,
    [dlremail_XML] VARCHAR(96) NULL,
    [dlrurl] VARCHAR(128) NULL,
    [dlrshowother] BIT NOT NULL,
    [adid] INT NULL,
    [edid] INT NOT NULL,
    [adtype] TINYINT NOT NULL,
    [adcost] MONEY NOT NULL,
    [adspecial] TINYINT NOT NULL,
    [adtop] TINYINT NULL,
    [adtext] VARCHAR(4096) NOT NULL,
    [adheadline] VARCHAR(255) NOT NULL,
    [adboxed] BIT NULL,
    [adyear] VARCHAR(4) NULL,
    [admake] VARCHAR(32) NULL,
    [admodel] VARCHAR(128) NULL,
    [adsubmodel] VARCHAR(128) NULL,
    [adprice] MONEY NOT NULL,
    [adphone] VARCHAR(16) NULL,
    [adzip] VARCHAR(10) NULL,
    [advin] VARCHAR(32) NULL,
    [dsid] VARCHAR(32) NULL,
    [dsvthumburl] VARCHAR(512) NULL,
    [fxcondition] VARCHAR(16) NULL,
    [fxcertified] VARCHAR(9) NOT NULL,
    [enlargedphoto] INT NOT NULL,
    [scl_id] INT NOT NULL,
    [scl_name] VARCHAR(64) NOT NULL,
    [pubid] INT NOT NULL,
    [fduid] INT NULL,
    [aso_id] INT NULL,
    [acc_id_rep] INT NULL,
    [fdid] VARCHAR(32) NOT NULL,
    [edtag] VARCHAR(128) NOT NULL,
    [hasHeadline] INT NOT NULL,
    [fauid] INT NOT NULL,
    [faadnum] INT NOT NULL,
    [fdedid] INT NOT NULL,
    [fdpubid] INT NOT NULL,
    [fastock] VARCHAR(32) NULL,
    [fxenginedisposition] VARCHAR(32) NULL,
    [fxenginesize] VARCHAR(64) NULL,
    [fxfueltype] VARCHAR(128) NULL,
    [fxwarranty] VARCHAR(128) NULL,
    [fxdrivetrain] VARCHAR(16) NULL,
    [fxfuelhighway] VARCHAR(100) NULL,
    [fxwarrantyterms] VARCHAR(128) NULL,
    [fxsellertype] VARCHAR(32) NULL,
    [fxfuelcity] VARCHAR(100) NULL,
    [fxinduction] VARCHAR(100) NULL,
    [fxBodyType] VARCHAR(128) NULL,
    [fxMileage] VARCHAR(50) NULL,
    [fxTransmission] VARCHAR(100) NULL,
    [fxDoors] VARCHAR(16) NULL,
    [fxExteriorColor] VARCHAR(128) NULL,
    [fxInteriorColor] VARCHAR(128) NULL,
    [Hash1] VARBINARY(8000) NULL,
    [Hash2] VARBINARY(8000) NULL,
    [Hash3] VARBINARY(8000) NULL,
    [lst_VDP] VARCHAR(256) NULL,
    [lst_Radius] INT NULL
);

CREATE TABLE [dx_listings_list] (
    [lsm_id] INT NOT NULL,
    [lst_id] INT NULL,
    [HP] BIT NULL
);

CREATE TABLE [dx_livesyncmanager_del] (
    [lsm_id] INT NOT NULL,
    [lst_id] INT NULL,
    [isHomePage] BIT NULL
);

CREATE TABLE [dx_options] (
    [lst_id] INT NULL,
    [rop_id] INT NULL
);

CREATE TABLE [DXAccountSyncManager] (
    [asm_ID] INT NOT NULL -- PK,
    [acc_ID] INT NOT NULL,
    [asm_Action] VARCHAR(3) NOT NULL,
    [asm_Timestamp] TIMESTAMP NOT NULL
);

CREATE TABLE [DXAccountToMEMBERS] (
    [acc_ID] INT NOT NULL -- PK,
    [MEMID] INT NOT NULL -- PK,
    [acc_update] DATETIME NULL,
    [mem_update] DATETIME NULL
);

CREATE TABLE [DXListingToSUBMIT] (
    [lst_ID] INT NOT NULL -- PK,
    [ecl_Number] INT NULL,
    [SUBID] INT NULL,
    [ECLSNUMBER] INT NULL
);

CREATE TABLE [DXLiveListingImageID] (
    [llim_ID] BIGINT NOT NULL -- PK,
    [llst_ID] INT NOT NULL,
    [llim_URL] VARCHAR(512) NULL,
    [llim_Sort] INT NOT NULL
);

CREATE TABLE [DXLiveListingOptionID] (
    [llop_ID] INT NOT NULL -- PK,
    [llst_ID] INT NOT NULL,
    [rop_id] INT NOT NULL
);

CREATE TABLE [DXLiveSyncManager] (
    [lsm_ID] INT NOT NULL -- PK,
    [lst_ID] INT NOT NULL,
    [lsm_Table] VARCHAR(25) NULL,
    [lst_Weeks] INT NULL,
    [lsm_Action] VARCHAR(25) NOT NULL,
    [lsm_Timestamp] TIMESTAMP NOT NULL
);

CREATE TABLE [eBillingInfo] (
    [db] VARCHAR(8) NULL,
    [cusID] INT NOT NULL,
    [cusCOmpany] VARCHAR(64) NULL,
    [eBillTo] VARCHAR(64) NULL,
    [eBillCC] VARCHAR(64) NULL,
    [eBillFax] VARCHAR(64) NULL
);

CREATE TABLE [EmailBySource] (
    [src_id] INT NOT NULL,
    [src_name] VARCHAR(32) NOT NULL,
    [lqs_ID] INT NOT NULL,
    [lqs_Name] VARCHAR(32) NOT NULL,
    [Created] DATE NULL,
    [lead_count] INT NULL
);

CREATE TABLE [EmailExternalID] (
    [emo_identity] INT NOT NULL,
    [esr_id] INT NOT NULL,
    [ldq_id] INT NOT NULL -- PK,
    [external_id] VARCHAR(32) NULL
);

CREATE TABLE [EmailFolders] (
    [emf_ID] INT NOT NULL -- PK,
    [emf_Name] VARCHAR(64) NOT NULL,
    [emf_URL] VARCHAR(256) NOT NULL,
    [emf_Sort] INT NOT NULL,
    [emf_Active] BIT NOT NULL,
    [emf_SleepTime] INT NULL,
    [emf_URLDestination] VARCHAR(256) NULL,
    [emf_UserName] VARCHAR(64) NULL,
    [emf_UserPW] VARCHAR(64) NULL,
    [emf_UserDomain] VARCHAR(16) NULL,
    [emf_MessageOnly] BIT NULL,
    [emf_URLBadDestination] VARCHAR(256) NULL
);

CREATE TABLE [EmailObjectCounts] (
    [RunTime] DATETIME NOT NULL,
    [emo_from] VARCHAR(128) NOT NULL,
    [ems_id] INT NOT NULL,
    [ems_name] VARCHAR(64) NOT NULL,
    [LeadCount] INT NULL,
    [max_emo_id] VARCHAR(256) NULL
);

CREATE TABLE [EmailObjects] (
    [emo_IDENTITY] INT NOT NULL -- PK,
    [emo_ID] VARCHAR(256) NOT NULL,
    [emf_ID] INT NOT NULL,
    [emo_From] VARCHAR(128) NOT NULL,
    [emo_To] VARCHAR(128) NOT NULL,
    [emo_CC] VARCHAR(128) NULL,
    [emo_Subject] VARCHAR(256) NOT NULL,
    [emo_Body] VARCHAR(MAX) NOT NULL,
    [emo_Header] VARCHAR(4096) NOT NULL,
    [emt_ID] INT NOT NULL,
    [ems_ID] INT NOT NULL,
    [emo_ExchDate] DATETIME NOT NULL,
    [emo_Created] DATETIME NOT NULL,
    [emo_Modified] DATETIME NOT NULL,
    [ldq_ID] INT NULL
);

CREATE TABLE [emailobjectsto] (
    [exchdate] DATETIME NULL,
    [esrname] VARCHAR(50) NULL,
    [emoto] VARCHAR(128) NULL
);

CREATE TABLE [EmailScrubFinals] (
    [esf_ID] BIGINT NOT NULL -- PK,
    [esr_ID] INT NOT NULL,
    [esr_Name] VARCHAR(50) NOT NULL,
    [ldq_ID] INT NOT NULL,
    [ldq_Created] DATETIME NOT NULL,
    [fdUID] INT NULL,
    [acc_ID] INT NOT NULL,
    [lst_ID] INT NULL,
    [RejectReasons] VARCHAR(1024) NOT NULL,
    [LeadCost] MONEY NOT NULL,
    [Budget] MONEY NOT NULL,
    [rptYearMonth] INT NOT NULL,
    [RunningBalance] MONEY NOT NULL,
    [ActualLeadCost] MONEY NOT NULL,
    [ActualBudget] MONEY NOT NULL
);

CREATE TABLE [EmailScrubRejectReasons] (
    [esrr_ID] INT NOT NULL -- PK,
    [esrr_Name] VARCHAR(64) NOT NULL,
    [esrr_Description] VARCHAR(1024) NOT NULL,
    [esrr_Type] VARCHAR(32) NULL
);

CREATE TABLE [EmailScrubRejects] (
    [esrj_ID] BIGINT NOT NULL -- PK,
    [esrr_ID] INT NOT NULL,
    [ldq_ID] INT NOT NULL,
    [ref_Added] DATETIME NOT NULL,
    [ref_ldq_ID] INT NULL,
    [ref_Notes] VARCHAR(1024) NULL,
    [Ignore_Reason] INT NOT NULL,
    [Ignore_Date] DATETIME NULL,
    [Ignore_By] INT NULL
);

CREATE TABLE [EmailSources] (
    [esr_ID] INT NOT NULL -- PK,
    [esr_Name] VARCHAR(50) NULL,
    [esr_FromMail] VARCHAR(100) NULL,
    [esr_Subject] VARCHAR(128) NULL,
    [esr_FromIP] VARCHAR(15) NULL,
    [esr_SendMail] VARCHAR(100) NULL,
    [esr_Active] BIT NULL,
    [esr_MailRequired] BIT NULL,
    [esr_ShortName] VARCHAR(16) NULL,
    [esr_LeadCost] MONEY NULL,
    [esr_DestID] INT NULL,
    [esr_LeadSort] INT NULL,
    [esrr_ID_Mask_Pay] INT NULL,
    [esrr_ID_Mask_Send] INT NULL,
    [esr_PartnerName] VARCHAR(128) NULL,
    [esr_API_Key] UNIQUEIDENTIFIER NULL,
    [esr_Type] SMALLINT NULL,
    [esr_SourceBody] VARCHAR(50) NULL
);

CREATE TABLE [EmailStatus] (
    [ems_ID] INT NOT NULL -- PK,
    [ems_Name] VARCHAR(64) NOT NULL
);

CREATE TABLE [EmailType] (
    [emt_ID] INT NOT NULL -- PK,
    [emt_Name] VARCHAR(64) NOT NULL
);

CREATE TABLE [EventTypeCatalog] (
    [Id] INT NOT NULL -- PK,
    [EventType] NVARCHAR(200) NOT NULL,
    [InputSchemaJson] NVARCHAR(MAX) NOT NULL,
    [CreatedAt] DATETIME NOT NULL,
    [UpdatedAt] DATETIME NOT NULL
);

CREATE TABLE [EveryAuto_Unprocessed] (
    [emo_IDENTITY] INT NOT NULL,
    [emo_from] VARCHAR(128) NOT NULL,
    [emo_Body] VARCHAR(MAX) NOT NULL
);

CREATE TABLE [Extension] (
    [ext_Number] VARCHAR(4) NOT NULL -- PK
);

CREATE TABLE [ExternalUsers] (
    [exu_ID] INT NOT NULL -- PK,
    [exu_Login] VARCHAR(64) NULL,
    [exu_Name] VARCHAR(128) NULL,
    [exu_Email] VARCHAR(128) NULL
);

CREATE TABLE [FacebookCampaignFluff] (
    [subscription_id] BIGINT NOT NULL -- PK,
    [sort] INT NOT NULL -- PK,
    [fluff_text] VARCHAR(128) NULL
);

CREATE TABLE [FacebookFluff] (
    [id] INT NOT NULL,
    [fluff] VARCHAR(128) NULL,
    [fluff_spanish] VARCHAR(128) NULL
);

CREATE TABLE [fbAutomotiveCatalog_data] (
    [vehicle_id] VARCHAR(37) NOT NULL,
    [vin] VARCHAR(32) NULL,
    [make] VARCHAR(64) NULL,
    [model] VARCHAR(64) NULL,
    [year] VARCHAR(4) NULL,
    [body_style] VARCHAR(128) NULL,
    [description] VARCHAR(8000) NULL,
    [exterior_color] VARCHAR(128) NULL,
    [image.tag] VARCHAR(128) NOT NULL,
    [image.url] VARCHAR(512) NULL,
    [mileage.value] VARCHAR(32) NULL,
    [mileage.unit] VARCHAR(2) NOT NULL,
    [url] VARCHAR(1024) NOT NULL,
    [title] VARCHAR(128) NOT NULL,
    [price] VARCHAR(8000) NULL,
    [state_of_vehicle] VARCHAR(8000) NULL,
    [address.addr1] VARCHAR(64) NOT NULL,
    [address.city] VARCHAR(64) NOT NULL,
    [address.region] VARCHAR(64) NULL,
    [address.stateid] VARCHAR(2) NOT NULL,
    [address.postal_code] VARCHAR(10) NOT NULL,
    [address.country] VARCHAR(13) NOT NULL,
    [longitude] FLOAT NULL,
    [latitude] FLOAT NULL,
    [transmission] VARCHAR(128) NULL,
    [drivetrain] VARCHAR(128) NULL,
    [fuel_type] VARCHAR(128) NULL,
    [trim] VARCHAR(128) NULL,
    [interior_color] VARCHAR(128) NULL,
    [sale_price] MONEY NOT NULL,
    [availability] VARCHAR(9) NOT NULL,
    [dealer_id] BIGINT NULL,
    [dealer_name] VARCHAR(64) NOT NULL,
    [dealer_phone] VARCHAR(16) NOT NULL,
    [custom_label_0] VARCHAR(128) NULL,
    [lst_id] INT NOT NULL,
    [lst_created] DATETIME NOT NULL,
    [lst_modified] DATETIME NOT NULL,
    [vdp_url] VARCHAR(1024) NOT NULL,
    [sub_id] BIGINT NULL
);

CREATE TABLE [fbAutomotiveCatalog_data_v2] (
    [vehicle_id] VARCHAR(37) NOT NULL,
    [vin] VARCHAR(32) NULL,
    [make] VARCHAR(64) NULL,
    [model] VARCHAR(64) NULL,
    [year] VARCHAR(4) NULL,
    [body_style] VARCHAR(128) NULL,
    [description] VARCHAR(8000) NULL,
    [exterior_color] VARCHAR(128) NULL,
    [image.tag] VARCHAR(128) NOT NULL,
    [image.url] VARCHAR(512) NULL,
    [mileage.value] VARCHAR(32) NULL,
    [mileage.unit] VARCHAR(2) NOT NULL,
    [url] VARCHAR(1024) NOT NULL,
    [title] VARCHAR(128) NOT NULL,
    [price] VARCHAR(8000) NULL,
    [state_of_vehicle] VARCHAR(8000) NULL,
    [address.addr1] VARCHAR(64) NOT NULL,
    [address.city] VARCHAR(64) NOT NULL,
    [address.region] VARCHAR(64) NULL,
    [address.stateid] VARCHAR(2) NOT NULL,
    [address.postal_code] VARCHAR(5) NOT NULL,
    [address.country] VARCHAR(13) NOT NULL,
    [longitude] FLOAT NULL,
    [latitude] FLOAT NULL,
    [transmission] VARCHAR(128) NULL,
    [drivetrain] VARCHAR(128) NULL,
    [fuel_type] VARCHAR(128) NULL,
    [trim] VARCHAR(128) NULL,
    [interior_color] VARCHAR(128) NULL,
    [sale_price] MONEY NOT NULL,
    [availability] VARCHAR(9) NOT NULL,
    [dealer_id] BIGINT NULL,
    [dealer_name] VARCHAR(64) NOT NULL,
    [dealer_phone] VARCHAR(16) NOT NULL,
    [custom_label_0] VARCHAR(128) NULL,
    [lst_id] INT NOT NULL,
    [lst_created] DATETIME NOT NULL,
    [lst_modified] DATETIME NOT NULL,
    [vdp_url] VARCHAR(1024) NOT NULL,
    [sub_id] BIGINT NULL,
    [prd_id] BIGINT NULL,
    [lst_onlinetext] VARCHAR(8000) NOT NULL,
    [sub_status] VARCHAR(16) NULL
);

CREATE TABLE [fbAutomotiveCatalog_data_v3] (
    [vehicle_id] VARCHAR(37) NOT NULL,
    [vin] VARCHAR(32) NULL,
    [make] VARCHAR(64) NULL,
    [model] VARCHAR(64) NULL,
    [year] VARCHAR(4) NULL,
    [body_style] VARCHAR(128) NULL,
    [description] VARCHAR(8000) NULL,
    [exterior_color] VARCHAR(128) NULL,
    [image.tag] VARCHAR(128) NOT NULL,
    [image.url] VARCHAR(512) NULL,
    [mileage.value] VARCHAR(32) NULL,
    [mileage.unit] VARCHAR(2) NOT NULL,
    [url] VARCHAR(1024) NOT NULL,
    [title] VARCHAR(128) NOT NULL,
    [price] VARCHAR(8000) NULL,
    [state_of_vehicle] VARCHAR(8000) NULL,
    [address.addr1] VARCHAR(64) NOT NULL,
    [address.city] VARCHAR(64) NOT NULL,
    [address.region] VARCHAR(64) NULL,
    [address.stateid] VARCHAR(2) NOT NULL,
    [address.postal_code] VARCHAR(5) NOT NULL,
    [address.country] VARCHAR(13) NOT NULL,
    [longitude] FLOAT NULL,
    [latitude] FLOAT NULL,
    [transmission] VARCHAR(128) NULL,
    [drivetrain] VARCHAR(128) NULL,
    [fuel_type] VARCHAR(128) NULL,
    [trim] VARCHAR(128) NULL,
    [interior_color] VARCHAR(128) NULL,
    [sale_price] MONEY NOT NULL,
    [availability] VARCHAR(9) NOT NULL,
    [dealer_id] BIGINT NULL,
    [dealer_name] VARCHAR(64) NOT NULL,
    [dealer_phone] VARCHAR(16) NOT NULL,
    [custom_label_0] VARCHAR(128) NULL,
    [lst_id] INT NOT NULL,
    [lst_created] DATETIME NOT NULL,
    [lst_modified] DATETIME NOT NULL,
    [vdp_url] VARCHAR(1024) NOT NULL,
    [sub_id] BIGINT NULL,
    [prd_id] BIGINT NULL,
    [lst_onlinetext] VARCHAR(8000) NOT NULL,
    [sub_status] VARCHAR(16) NULL,
    [LastUpload] DATETIME NOT NULL
);

CREATE TABLE [fbAutomotiveCatalog_data_v3_temp] (
    [vehicle_id] VARCHAR(37) NOT NULL,
    [vin] VARCHAR(32) NULL,
    [make] VARCHAR(64) NULL,
    [model] VARCHAR(64) NULL,
    [year] VARCHAR(4) NULL,
    [body_style] VARCHAR(128) NULL,
    [description] VARCHAR(8000) NULL,
    [exterior_color] VARCHAR(128) NULL,
    [image.tag] VARCHAR(128) NOT NULL,
    [image.url] VARCHAR(512) NULL,
    [mileage.value] VARCHAR(32) NULL,
    [mileage.unit] VARCHAR(2) NOT NULL,
    [url] VARCHAR(1024) NOT NULL,
    [title] VARCHAR(128) NOT NULL,
    [price] VARCHAR(8000) NULL,
    [state_of_vehicle] VARCHAR(8000) NULL,
    [address.addr1] VARCHAR(64) NOT NULL,
    [address.city] VARCHAR(64) NOT NULL,
    [address.region] VARCHAR(64) NULL,
    [address.stateid] VARCHAR(2) NOT NULL,
    [address.postal_code] VARCHAR(5) NOT NULL,
    [address.country] VARCHAR(13) NOT NULL,
    [longitude] FLOAT NULL,
    [latitude] FLOAT NULL,
    [transmission] VARCHAR(128) NULL,
    [drivetrain] VARCHAR(128) NULL,
    [fuel_type] VARCHAR(128) NULL,
    [trim] VARCHAR(128) NULL,
    [interior_color] VARCHAR(128) NULL,
    [sale_price] MONEY NOT NULL,
    [availability] VARCHAR(9) NOT NULL,
    [dealer_id] BIGINT NULL,
    [dealer_name] VARCHAR(64) NOT NULL,
    [dealer_phone] VARCHAR(16) NOT NULL,
    [custom_label_0] VARCHAR(128) NULL,
    [lst_id] INT NOT NULL,
    [lst_created] DATETIME NOT NULL,
    [lst_modified] DATETIME NOT NULL,
    [vdp_url] VARCHAR(1024) NOT NULL,
    [sub_id] BIGINT NULL,
    [prd_id] BIGINT NULL,
    [lst_onlinetext] VARCHAR(8000) NOT NULL,
    [sub_status] VARCHAR(16) NULL,
    [LastUpload] DATETIME NOT NULL
);

CREATE TABLE [fbAutomotiveCatalog_data_v4] (
    [vehicle_id] VARCHAR(37) NOT NULL,
    [vin] VARCHAR(32) NULL,
    [make] VARCHAR(64) NULL,
    [model] VARCHAR(64) NULL,
    [year] VARCHAR(4) NULL,
    [body_style] VARCHAR(128) NULL,
    [description] VARCHAR(8000) NULL,
    [exterior_color] VARCHAR(128) NULL,
    [image.tag] VARCHAR(128) NOT NULL,
    [image.url] VARCHAR(512) NULL,
    [mileage.value] VARCHAR(32) NULL,
    [mileage.unit] VARCHAR(2) NOT NULL,
    [url] VARCHAR(512) NOT NULL,
    [title] VARCHAR(128) NOT NULL,
    [price] VARCHAR(8000) NULL,
    [state_of_vehicle] VARCHAR(8000) NULL,
    [address.addr1] VARCHAR(64) NOT NULL,
    [address.city] VARCHAR(64) NOT NULL,
    [address.region] VARCHAR(64) NULL,
    [address.stateid] VARCHAR(2) NOT NULL,
    [address.postal_code] VARCHAR(10) NOT NULL,
    [address.country] VARCHAR(13) NOT NULL,
    [longitude] FLOAT NULL,
    [latitude] FLOAT NULL,
    [transmission] VARCHAR(128) NULL,
    [drivetrain] VARCHAR(128) NULL,
    [fuel_type] VARCHAR(128) NULL,
    [trim] VARCHAR(128) NULL,
    [interior_color] VARCHAR(128) NULL,
    [sale_price] MONEY NOT NULL,
    [availability] VARCHAR(9) NOT NULL,
    [dealer_id] BIGINT NULL,
    [dealer_name] VARCHAR(64) NOT NULL,
    [dealer_phone] VARCHAR(16) NOT NULL,
    [custom_label_0] VARCHAR(128) NULL,
    [lst_id] INT NOT NULL,
    [lst_created] DATETIME NOT NULL,
    [lst_modified] DATETIME NOT NULL,
    [vdp_url] VARCHAR(1024) NOT NULL,
    [sub_id] BIGINT NULL,
    [prd_id] BIGINT NULL,
    [lst_onlinetext] VARCHAR(8000) NOT NULL,
    [sub_status] VARCHAR(16) NULL,
    [prd_type] VARCHAR(128) NULL,
    [sub_name] VARCHAR(256) NULL,
    [LastUpload] DATETIME NOT NULL
);

CREATE TABLE [fbAutomotiveCatalog_data_v4_temp] (
    [vehicle_id] VARCHAR(37) NOT NULL,
    [vin] VARCHAR(32) NULL,
    [make] VARCHAR(64) NULL,
    [model] VARCHAR(64) NULL,
    [year] VARCHAR(4) NULL,
    [body_style] VARCHAR(128) NULL,
    [description] VARCHAR(8000) NULL,
    [exterior_color] VARCHAR(128) NULL,
    [image.tag] VARCHAR(128) NOT NULL,
    [image.url] VARCHAR(512) NULL,
    [mileage.value] VARCHAR(32) NULL,
    [mileage.unit] VARCHAR(2) NOT NULL,
    [url] VARCHAR(512) NOT NULL,
    [title] VARCHAR(128) NOT NULL,
    [price] VARCHAR(8000) NULL,
    [state_of_vehicle] VARCHAR(8000) NULL,
    [address.addr1] VARCHAR(64) NOT NULL,
    [address.city] VARCHAR(64) NOT NULL,
    [address.region] VARCHAR(64) NULL,
    [address.stateid] VARCHAR(2) NOT NULL,
    [address.postal_code] VARCHAR(10) NOT NULL,
    [address.country] VARCHAR(13) NOT NULL,
    [longitude] FLOAT NULL,
    [latitude] FLOAT NULL,
    [transmission] VARCHAR(128) NULL,
    [drivetrain] VARCHAR(128) NULL,
    [fuel_type] VARCHAR(128) NULL,
    [trim] VARCHAR(128) NULL,
    [interior_color] VARCHAR(128) NULL,
    [sale_price] MONEY NOT NULL,
    [availability] VARCHAR(9) NOT NULL,
    [dealer_id] BIGINT NULL,
    [dealer_name] VARCHAR(64) NOT NULL,
    [dealer_phone] VARCHAR(16) NOT NULL,
    [custom_label_0] VARCHAR(128) NULL,
    [lst_id] INT NOT NULL,
    [lst_created] DATETIME NOT NULL,
    [lst_modified] DATETIME NOT NULL,
    [vdp_url] VARCHAR(1024) NOT NULL,
    [sub_id] BIGINT NULL,
    [prd_id] BIGINT NULL,
    [lst_onlinetext] VARCHAR(8000) NOT NULL,
    [sub_status] VARCHAR(16) NULL,
    [prd_type] VARCHAR(128) NULL,
    [sub_name] VARCHAR(256) NULL,
    [LastUpload] DATETIME NOT NULL
);

CREATE TABLE [FBCatalogStatus] (
    [Id] BIGINT NOT NULL -- PK,
    [Name] VARCHAR(200) NULL,
    [Status] VARCHAR(10) NULL,
    [Count] INT NOT NULL,
    [HasProductSet] BIT NOT NULL,
    [LastChecked] DATETIME NOT NULL,
    [Resubmitted] BIT NOT NULL
);

CREATE TABLE [FbLeadData] (
    [fb_id] BIGINT NOT NULL,
    [retailer_id] VARCHAR(15) NOT NULL,
    [lst_id] INT NOT NULL
);

CREATE TABLE [FbPageAccess] (
    [acc_id] INT NOT NULL -- PK,
    [prd_id] INT NOT NULL -- PK,
    [advertiser_name] VARCHAR(128) NULL,
    [facebook_url] VARCHAR(256) NULL,
    [requested_date] DATETIME NULL,
    [access_status] VARCHAR(16) NULL
);

CREATE TABLE [FeedReactivates] (
    [ratchet_id] BIGINT NULL
);

CREATE TABLE [FeedToPrintAttributeManager] (
    [acc_ID] INT NOT NULL -- PK,
    [att_ID] INT NOT NULL -- PK,
    [att_Order] INT NOT NULL
);

CREATE TABLE [FeedToPrintAttributes] (
    [att_ID] INT NOT NULL -- PK,
    [att_Group] INT NOT NULL,
    [att_Required] BIT NOT NULL,
    [att_Order] INT NOT NULL
);

CREATE TABLE [FeedToPrintListings] (
    [lst_ID] INT NOT NULL -- PK,
    [fpl_Fluff] VARCHAR(128) NOT NULL,
    [fpl_Created] SMALLDATETIME NOT NULL,
    [fpl_CreatedBy] INT NOT NULL,
    [fpl_Modified] SMALLDATETIME NOT NULL,
    [fpl_ModifiedBy] INT NOT NULL,
    [fpl_Active] BIT NOT NULL,
    [ped_ID] INT NOT NULL -- PK
);

CREATE TABLE [FeedToPrintManager] (
    [acc_ID] INT NOT NULL -- PK,
    [ped_ID] INT NOT NULL -- PK,
    [fpm_MaxAds] INT NOT NULL,
    [fpm_Created] SMALLDATETIME NOT NULL,
    [fpm_CreatedBy] INT NOT NULL,
    [fpm_Modified] SMALLDATETIME NOT NULL,
    [fpm_ModifiedBy] INT NOT NULL,
    [fpm_Active] BIT NOT NULL
);

CREATE TABLE [fi_Account_Master] (
    [src_ID] INT NOT NULL,
    [src_Cus_ID] INT NOT NULL,
    [acc_ID_Master] INT NOT NULL
);

CREATE TABLE [FileDetails_Log] (
    [fileID] BIGINT NOT NULL -- PK,
    [groupGUID] VARCHAR(64) NOT NULL,
    [fileLogged] DATETIME NOT NULL,
    [filePath] VARCHAR(1024) NOT NULL,
    [fileName] VARCHAR(256) NOT NULL,
    [fileDateCreated] DATETIME NULL,
    [fileSize] BIGINT NULL,
    [ErrorMessage] VARCHAR(1024) NULL
);

CREATE TABLE [Flight_Range_Data] (
    [ym] INT NULL,
    [range_start] DATE NULL,
    [range_end] DATE NULL,
    [sf_id] BIGINT NULL,
    [cmp_id] BIGINT NULL,
    [ratchet_id] BIGINT NULL,
    [subscription_id] BIGINT NULL,
    [acc_id] BIGINT NULL,
    [prd_type] VARCHAR(64) NULL,
    [flight_start_date] DATE NULL,
    [flight_end_date] DATE NULL,
    [flight_original_end_date] DATE NULL,
    [flight_deactivation_date] DATE NULL,
    [range_days] BIGINT NULL,
    [range_price] MONEY NULL,
    [range_impressions] NUMERIC(18,2) NULL,
    [range_clicks] NUMERIC(18,2) NULL,
    [isAccountFirst] BIT NULL
);

CREATE TABLE [Flight_Range_Data_Sales_Pivot] (
    [acc_id] BIGINT NULL,
    [201701_sales] MONEY NULL,
    [201701_products] VARCHAR(256) NULL,
    [201702_sales] MONEY NULL,
    [201702_products] VARCHAR(256) NULL,
    [201703_sales] MONEY NULL,
    [201703_products] VARCHAR(256) NULL,
    [201704_sales] MONEY NULL,
    [201704_products] VARCHAR(256) NULL,
    [201705_sales] MONEY NULL,
    [201705_products] VARCHAR(256) NULL,
    [201706_sales] MONEY NULL,
    [201706_products] VARCHAR(256) NULL,
    [201707_sales] MONEY NULL,
    [201707_products] VARCHAR(256) NULL,
    [201708_sales] MONEY NULL,
    [201708_products] VARCHAR(256) NULL,
    [201709_sales] MONEY NULL,
    [201709_products] VARCHAR(256) NULL,
    [201710_sales] MONEY NULL,
    [201710_products] VARCHAR(256) NULL,
    [201711_sales] MONEY NULL,
    [201711_products] VARCHAR(256) NULL,
    [201712_sales] MONEY NULL,
    [201712_products] VARCHAR(256) NULL,
    [201801_sales] MONEY NULL,
    [201801_products] VARCHAR(256) NULL,
    [201802_sales] MONEY NULL,
    [201802_products] VARCHAR(256) NULL,
    [201803_sales] MONEY NULL,
    [201803_products] VARCHAR(256) NULL
);

CREATE TABLE [GeoDistance] (
    [gdID] INT NOT NULL -- PK,
    [gdName] VARCHAR(64) NOT NULL,
    [gdState] VARCHAR(2) NOT NULL,
    [gdLAT] FLOAT NOT NULL,
    [gdLON] FLOAT NOT NULL,
    [gdRadius] FLOAT NOT NULL,
    [gdtID] INT NOT NULL,
    [gdNewLocation] VARCHAR(128) NOT NULL,
    [gdURLLocation] VARCHAR(128) NOT NULL,
    [gdZip] VARCHAR(5) NULL
);

CREATE TABLE [GeoDistanceLog] (
    [gl_id] BIGINT NOT NULL -- PK,
    [gl_server] VARCHAR(128) NULL,
    [gl_created] DATETIME NULL,
    [gdID] INT NULL,
    [gdURLLocation] VARCHAR(128) NULL,
    [gdLAT] FLOAT NULL,
    [gdLON] FLOAT NULL
);

CREATE TABLE [GeoDistanceSynonyms] (
    [gdsID] INT NOT NULL -- PK,
    [gdsSynonym] VARCHAR(256) NOT NULL,
    [gdID] INT NOT NULL
);

CREATE TABLE [GeoDistanceTypes] (
    [gdtID] INT NOT NULL -- PK,
    [gdtName] VARCHAR(128) NOT NULL,
    [gdtRanking] INT NOT NULL
);

CREATE TABLE [GoogleAdAccountStatus] (
    [Id] BIGINT NOT NULL -- PK,
    [AccountName] NVARCHAR(255) NULL,
    [MccId] BIGINT NOT NULL,
    [Status] NVARCHAR(50) NOT NULL,
    [IsActive] BIT NOT NULL,
    [LastChecked] DATETIME2 NOT NULL,
    [FirstDetectedSuspended] DATETIME2 NULL,
    [SuspensionReason] NVARCHAR(500) NULL,
    [AccountType] INT NULL,
    [CreatedAt] DATETIME2 NOT NULL,
    [UpdatedAt] DATETIME2 NOT NULL
);

CREATE TABLE [GoogleAnalytics_Post_Log] (
    [gap_id] BIGINT NOT NULL,
    [ldq_id] INT NULL,
    [gap_sent] DATETIME NULL,
    [gap_data] NVARCHAR(MAX) NULL,
    [gap_response] NVARCHAR(4000) NULL
);

CREATE TABLE [GoogleAnalyticsMapping] (
    [acc_id] INT NOT NULL -- PK,
    [google_id] VARCHAR(50) NOT NULL,
    [dealer_name] VARCHAR(100) NOT NULL
);

CREATE TABLE [HeaderInfo] (
    [meta_ID] INT NOT NULL -- PK,
    [cls_Name] VARCHAR(50) NOT NULL,
    [scl_Name] VARCHAR(50) NOT NULL,
    [title] VARCHAR(200) NOT NULL,
    [description] VARCHAR(200) NOT NULL,
    [keyword] VARCHAR(200) NOT NULL
);

CREATE TABLE [ImageHashes] (
    [id] INT NOT NULL -- PK,
    [imgurl] NVARCHAR(2000) NOT NULL,
    [imghash] BIGINT NOT NULL,
    [md5hash] NVARCHAR(32) NOT NULL,
    [isstockphoto] BIT NOT NULL,
    [hastext] BIT NOT NULL,
    [processed] DATETIME2 NOT NULL
);

CREATE TABLE [imageproxy_blanks] (
    [acc_ID] INT NOT NULL,
    [lst_ID] INT NOT NULL
);

CREATE TABLE [ImgPrxy_Data] (
    [adv_acc_id] BIGINT NULL,
    [adv_name] VARCHAR(128) NULL,
    [sales_channel] VARCHAR(128) NULL,
    [im_date] VARCHAR(6) NULL,
    [ImgPrxy_SRP] INT NULL,
    [ImgPrxy_VDP] INT NULL
);

CREATE TABLE [Impersonation] (
    [imp_GUID] UNIQUEIDENTIFIER NOT NULL -- PK,
    [acc_ID] INT NOT NULL,
    [imp_Created] SMALLDATETIME NOT NULL,
    [imp_Authenticated] SMALLDATETIME NOT NULL,
    [imp_IP] VARCHAR(15) NOT NULL,
    [imp_Redirect] VARCHAR(200) NOT NULL,
    [imp_Active] BIT NOT NULL
);

CREATE TABLE [ImportFile] (
    [xmlFileName] VARCHAR(8000) NOT NULL,
    [xml_data] VARCHAR(MAX) NOT NULL
);

CREATE TABLE [ImportIssue] (
    [id] INT NOT NULL -- PK,
    [import] VARCHAR(50) NOT NULL,
    [filename] VARCHAR(50) NOT NULL,
    [time] DATETIME NOT NULL,
    [line] INT NOT NULL,
    [issue] VARCHAR(500) NOT NULL
);

CREATE TABLE [IntMaxes] (
    [IntMax] INT NULL,
    [TableName] VARCHAR(64) NULL,
    [ColumnName] VARCHAR(64) NULL
);

CREATE TABLE [InvalidDomains] (
    [acc_id] INT NOT NULL,
    [src_ID] INT NOT NULL,
    [acc_Login] VARCHAR(128) NOT NULL,
    [acc_Company] VARCHAR(64) NOT NULL,
    [acc_FirstName] VARCHAR(32) NOT NULL,
    [acc_LastName] VARCHAR(32) NOT NULL,
    [acc_LastIP] VARCHAR(15) NOT NULL,
    [acc_LastLogin] DATETIME NOT NULL,
    [arl_ID] INT NOT NULL,
    [acs_ID] INT NOT NULL,
    [acc_Verified] BIT NOT NULL,
    [TMPDomains] VARCHAR(128) NULL
);

CREATE TABLE [InventoryFilter] (
    [id] INT NOT NULL -- PK,
    [name] VARCHAR(100) NOT NULL,
    [account_id] INT NOT NULL,
    [subscription_id] INT NULL,
    [year_include] TINYINT NULL,
    [year_start] INT NULL,
    [year_end] INT NULL,
    [price_include] TINYINT NULL,
    [price_start] INT NULL,
    [price_end] INT NULL,
    [make_include] TINYINT NULL,
    [makes] VARCHAR(500) NULL,
    [model_include] TINYINT NULL,
    [models] VARCHAR(500) NULL,
    [type_include] TINYINT NULL,
    [types] VARCHAR(500) NULL,
    [condition_include] TINYINT NULL,
    [conditions] VARCHAR(100) NULL,
    [days_include] TINYINT NULL,
    [days_on_lot] INT NULL,
    [miles_include] TINYINT NULL,
    [miles] INT NULL,
    [updated] DATETIME NULL,
    [updatedBy] INT NULL,
    [exclude_single_photo] BIT NULL,
    [remove_stock_images] BIT NULL,
    [fallback_to_msrp] BIT NULL,
    [price_type] NVARCHAR(50) NULL
);

CREATE TABLE [InventoryFilterAdvanced] (
    [subscription_id] INT NULL,
    [row] INT NOT NULL,
    [account_id] INT NOT NULL,
    [field] VARCHAR(50) NOT NULL,
    [field_operator] VARCHAR(50) NOT NULL,
    [value] VARCHAR(50) NOT NULL,
    [action] VARCHAR(50) NOT NULL,
    [outcome] VARCHAR(50) NULL
);

CREATE TABLE [InventoryProcessed] (
    [filter_id] BIGINT NOT NULL -- PK,
    [lst_id] BIGINT NOT NULL -- PK
);

CREATE TABLE [InventoryRules] (
    [acc_ID] INT NOT NULL -- PK,
    [export_Type] VARCHAR(10) NOT NULL -- PK,
    [rule_Order] INT NOT NULL -- PK,
    [description] VARCHAR(512) NOT NULL,
    [selector_Field] VARCHAR(50) NOT NULL,
    [selector_Operator] VARCHAR(50) NOT NULL,
    [selector_Value] VARCHAR(50) NOT NULL,
    [operation] VARCHAR(50) NOT NULL,
    [operation_Value] VARCHAR(50) NOT NULL
);

CREATE TABLE [InventorySource] (
    [ins_ID] INT NOT NULL -- PK,
    [ins_Name] VARCHAR(64) NOT NULL,
    [ist_ID] INT NULL
);

CREATE TABLE [InventorySourceType] (
    [ist_ID] INT NOT NULL -- PK,
    [ist_Name] VARCHAR(64) NOT NULL
);

CREATE TABLE [IPBlocks] (
    [startIpNum] BIGINT NOT NULL,
    [endIpNum] BIGINT NOT NULL,
    [locId] BIGINT NOT NULL
);

CREATE TABLE [IPLocation] (
    [locId] BIGINT NULL,
    [country] VARCHAR(50) NULL,
    [region] VARCHAR(50) NULL,
    [city] VARCHAR(50) NULL,
    [zipcode] VARCHAR(50) NULL,
    [latitude] FLOAT NULL,
    [longitude] FLOAT NULL,
    [gdNewLocation] VARCHAR(128) NULL,
    [gdURLLocation] VARCHAR(128) NULL,
    [gdRadius] FLOAT NULL,
    [gdtName] VARCHAR(128) NULL,
    [gdtRanking] INT NULL
);

CREATE TABLE [JobRunTime] (
    [job_id] UNIQUEIDENTIFIER NOT NULL,
    [job_name] VARCHAR(512) NOT NULL,
    [restart_after_minutes] INT NULL,
    [job_restart] BIT NOT NULL
);

CREATE TABLE [JobStatus] (
    [id] INT NOT NULL -- PK,
    [name] VARCHAR(50) NOT NULL,
    [direction] VARCHAR(10) NOT NULL,
    [lastrunstart] DATETIME NOT NULL,
    [lastrunend] DATETIME NULL,
    [lastrunstatus] VARCHAR(500) NOT NULL
);

CREATE TABLE [LeadDupeFind] (
    [ldq_id] INT NOT NULL,
    [ldq_Created] DATETIME NOT NULL,
    [ldq_FromIP] VARCHAR(16) NOT NULL,
    [ldq_FromMail] VARCHAR(256) NOT NULL,
    [ldq_Message] VARCHAR(512) NOT NULL,
    [ldq_Source] VARCHAR(32) NULL,
    [acc_ID] INT NULL,
    [lst_id] INT NOT NULL,
    [scl_ID] INT NOT NULL,
    [scl_Name] VARCHAR(64) NOT NULL
);

CREATE TABLE [LeadGenLogs] (
    [PartnerId] INT NOT NULL,
    [ADFXML] TEXT NOT NULL,
    [Enter] DATETIME NOT NULL
);

CREATE TABLE [LeadHistory] (
    [ldq_id] INT NOT NULL,
    [lYear] INT NULL,
    [lMonth] INT NULL,
    [lDay] INT NULL,
    [lSource] VARCHAR(50) NOT NULL,
    [lst_id] INT NOT NULL,
    [zip_code] VARCHAR(5) NOT NULL,
    [scl_id] INT NOT NULL,
    [scl_name] VARCHAR(64) NOT NULL,
    [lst_Year] VARCHAR(128) NULL,
    [lst_Make] VARCHAR(128) NULL,
    [lst_Model] VARCHAR(128) NULL
);

CREATE TABLE [LeadinMismatch] (
    [lst_ID] INT NULL,
    [clean_leadin] VARCHAR(1024) NULL,
    [clean_printtext] VARCHAR(1024) NULL,
    [lss_ID] INT NULL,
    [lst_ModifiedBy] INT NULL,
    [lst_Modified] DATETIME NULL
);

CREATE TABLE [LeadQueue] (
    [ldq_ID] INT NOT NULL -- PK,
    [lst_ID] INT NOT NULL,
    [ldq_lqs_ID] INT NOT NULL,
    [ldq_Created] DATETIME NOT NULL,
    [ldq_FromMail] VARCHAR(256) NOT NULL,
    [ldq_FromIP] VARCHAR(16) NOT NULL,
    [ldq_FromFirstName] VARCHAR(64) NOT NULL,
    [ldq_FromLastName] VARCHAR(64) NOT NULL,
    [ldq_FromZipCode] VARCHAR(5) NOT NULL,
    [ldq_FromPhone] VARCHAR(16) NOT NULL,
    [ldq_Message] VARCHAR(512) NOT NULL,
    [ldq_proofer_acc_ID] INT NULL,
    [ldq_ProofComment] VARCHAR(512) NULL,
    [ldq_Sent] DATETIME NULL,
    [ldq_ADFXML] VARCHAR(8000) NULL,
    [ldq_MultiSend] BIT NOT NULL,
    [ldq_Source] VARCHAR(32) NULL
);

CREATE TABLE [LeadQueueExtras] (
    [lqe_ID] INT NOT NULL -- PK,
    [ldq_ID] INT NOT NULL,
    [lqt_ID] INT NOT NULL,
    [lqe_Value] VARCHAR(256) NULL
);

CREATE TABLE [LeadqueuePartial] (
    [tmp_ID] BIGINT NOT NULL -- PK,
    [ldq_ID] INT NULL,
    [acc_ID] INT NULL,
    [lst_ID] INT NULL,
    [ldq_Created] DATETIME NULL,
    [ldq_FromMail] VARCHAR(256) NULL,
    [ldq_FromPhone] VARCHAR(16) NULL,
    [ldq_Message] VARCHAR(512) NULL,
    [esr_ID] INT NULL,
    [esr_Name] VARCHAR(50) NULL,
    [esrr_ID_Mask_Pay] INT NULL,
    [NumbersUsed] VARCHAR(10) NULL,
    [EmailDomain] VARCHAR(32) NULL,
    [lst_LastUpload] DATETIME NULL,
    [YearMonth] INT NULL
);

CREATE TABLE [LeadQueueStatus] (
    [lqs_ID] INT NOT NULL -- PK,
    [lqs_Name] VARCHAR(32) NOT NULL
);

CREATE TABLE [LeadQueueTypes] (
    [lqt_ID] INT NOT NULL -- PK,
    [lqt_Name] VARCHAR(64) NOT NULL,
    [lqt_Active] BIT NOT NULL
);

CREATE TABLE [leadsbypub] (
    [user_acc_id] INT NULL,
    [pub_ID] INT NULL,
    [cls_ID] INT NULL,
    [scl_ID] INT NULL,
    [StartDate] DATETIME NULL,
    [EndDate] DATETIME NULL,
    [lss_ID] INT NULL,
    [DateCheck] BIT NULL
);

CREATE TABLE [LeadsPivot] (
    [YearMonth] INT NULL,
    [dat_Name] VARCHAR(64) NULL,
    [Recycler] INT NULL,
    [Automotive] INT NULL,
    [Dealix] INT NULL,
    [Vast] INT NULL,
    [WhosCalling] INT NULL,
    [Web2Carz] INT NULL,
    [CarsDirect] INT NULL,
    [Web2CarzPaid] INT NULL,
    [iSeeCars] INT NULL,
    [GetAuto] INT NULL,
    [LemonFree] INT NULL,
    [CarGurus] INT NULL,
    [AutoByTel] INT NULL,
    [HighGear] INT NULL,
    [WantAdDigest] INT NULL,
    [CarGigi] INT NULL,
    [DXEnhanced] INT NULL,
    [LendingTree] INT NULL,
    [MerchantCircle] INT NULL,
    [AutoList] INT NULL,
    [AutaBuy] INT NULL,
    [PartnerTotal] INT NULL,
    [Total] INT NULL
);

CREATE TABLE [LeadsRaw] (
    [esr_ID] INT NULL,
    [esr_Name] VARCHAR(64) NULL,
    [dat_Month] INT NULL,
    [dat_Year] INT NULL,
    [ldq_Count] INT NULL,
    [dat_Name] VARCHAR(64) NULL
);

CREATE TABLE [LeadSync] (
    [ls_id] INT NOT NULL -- PK,
    [source_id] INT NOT NULL,
    [ext_lead_id] BIGINT NOT NULL,
    [state] INT NOT NULL,
    [created] DATETIME NOT NULL,
    [updated] DATETIME NOT NULL,
    [notes] VARCHAR(200) NULL
);

CREATE TABLE [LeadSyncMapping] (
    [fb_id] BIGINT NULL,
    [ldq_ID] INT NOT NULL
);

CREATE TABLE [LeadVerify] (
    [Source] VARCHAR(64) NULL,
    [Month] INT NULL,
    [Day] INT NULL,
    [Year] INT NULL,
    [Hour] INT NULL,
    [lst_id] INT NOT NULL,
    [acc_id] INT NULL,
    [LeadCount] INT NULL
);

CREATE TABLE [Listing] (
    [lst_ID] INT NOT NULL -- PK,
    [lst_GUID] UNIQUEIDENTIFIER NOT NULL,
    [acc_ID] INT NULL,
    [src_ID] INT NOT NULL,
    [src_AdID] VARCHAR(32) NULL,
    [scl_ID] INT NOT NULL,
    [rrg_ID] INT NOT NULL,
    [zip_Code] VARCHAR(5) NOT NULL,
    [lst_isSale] BIT NOT NULL,
    [lst_Type] TINYINT NOT NULL,
    [lst_Cost] MONEY NOT NULL,
    [lst_Weeks] INT NOT NULL,
    [lst_Headline] VARCHAR(64) NOT NULL,
    [lst_Title] VARCHAR(128) NOT NULL,
    [lst_OnlineText] VARCHAR(8000) NOT NULL,
    [lst_PrintText] VARCHAR(8000) NOT NULL,
    [lst_Price] MONEY NOT NULL,
    [lst_Phone] VARCHAR(16) NOT NULL,
    [lst_Extension] VARCHAR(10) NOT NULL,
    [lss_ID] INT NOT NULL,
    [lst_Created] DATETIME NOT NULL,
    [lst_Modified] DATETIME NOT NULL,
    [lst_VerificationID] UNIQUEIDENTIFIER NULL,
    [lst_Verified] BIT NOT NULL,
    [prq_ID] INT NULL,
    [master_lst_ID] INT NULL,
    [lus_ID] INT NULL,
    [lst_Notes] VARCHAR(1024) NULL,
    [lst_LastUpload] DATETIME NULL,
    [lst_ModifiedBy] INT NULL,
    [lst_Options] VARCHAR(256) NULL,
    [lst_Highlights] VARCHAR(1024) NULL,
    [lst_Images] VARCHAR(8000) NULL,
    [lpt_ID] INT NULL
);

CREATE TABLE [Listing_PRIC] (
    [acc_id] INT NOT NULL,
    [lst_id] INT NOT NULL -- PK,
    [zip_Code] VARCHAR(5) NOT NULL,
    [lst_Mileage_Score] INT NOT NULL,
    [lst_Price_Score] INT NOT NULL,
    [lst_Emails] INT NOT NULL,
    [lst_Details] INT NOT NULL,
    [lst_Search] INT NOT NULL,
    [Vehicle_Sum_Emails] INT NOT NULL,
    [Vehicle_Sum_Details] INT NOT NULL,
    [Vehicle_Sum_Search] INT NOT NULL,
    [Vehicle_Max_Emails] INT NOT NULL,
    [Vehicle_Max_Details] INT NOT NULL,
    [Vehicle_Max_Search] INT NOT NULL,
    [Vehicle_Avg_Emails] INT NOT NULL,
    [Vehicle_Avg_Details] INT NOT NULL,
    [Vehicle_Avg_Search] INT NOT NULL,
    [Vehicle_Count] INT NOT NULL,
    [lst_Hash] VARBINARY(8000) NOT NULL,
    [lst_Updated] DATETIME NOT NULL
);

CREATE TABLE [listing_pric_With_Max] (
    [acc_id] INT NOT NULL,
    [lst_id] INT NOT NULL -- PK,
    [zip_Code] VARCHAR(5) NOT NULL,
    [lst_Mileage_Score] INT NOT NULL,
    [lst_Price_Score] INT NOT NULL,
    [lst_Emails] INT NOT NULL,
    [lst_Details] INT NOT NULL,
    [lst_Search] INT NOT NULL,
    [Vehicle_Sum_Emails] INT NOT NULL,
    [Vehicle_Sum_Details] INT NOT NULL,
    [Vehicle_Sum_Search] INT NOT NULL,
    [Vehicle_Max_Emails] INT NOT NULL,
    [Vehicle_Max_Details] INT NOT NULL,
    [Vehicle_Max_Search] INT NOT NULL,
    [Vehicle_Avg_Emails] INT NOT NULL,
    [Vehicle_Avg_Details] INT NOT NULL,
    [Vehicle_Avg_Search] INT NOT NULL,
    [Vehicle_Count] INT NOT NULL,
    [lst_Hash] VARBINARY(8000) NOT NULL,
    [lst_Updated] DATETIME NOT NULL,
    [zip_Code_From] VARCHAR(5) NULL,
    [radius_max_sum_emails] INT NULL,
    [radius_max_sum_details] INT NULL,
    [radius_max_sum_search] INT NULL,
    [acc_id_group] INT NOT NULL,
    [customer_max_emails] INT NULL,
    [customer_max_details] INT NULL,
    [customer_max_search] INT NULL
);

CREATE TABLE [ListingAssetsDownload] (
    [Id] INT NOT NULL -- PK,
    [ListingId] INT NOT NULL,
    [Index] SMALLINT NULL,
    [SortOrder] INT NULL,
    [MainPhoto] BIT NOT NULL,
    [StockPhoto] BIT NULL,
    [OriginalUrl] VARCHAR(1024) NULL,
    [CDNUrl] VARCHAR(1024) NULL,
    [DownloadStatus] SMALLINT NULL,
    [FailedCount] SMALLINT NULL,
    [CreatedAt] DATETIME NULL,
    [UpdatedAt] DATETIME NULL
);

CREATE TABLE [ListingAttributeVertical] (
    [lia_ID] BIGINT NOT NULL -- PK,
    [lst_ID] INT NOT NULL,
    [att_ID] INT NOT NULL,
    [ato_ID] INT NULL,
    [lia_Value] VARCHAR(128) NOT NULL
);

CREATE TABLE [ListingCentralInventory] (
    [lst_id] INT NOT NULL -- PK,
    [cim_id] INT NOT NULL
);

CREATE TABLE [ListingCIM] (
    [lst_id] INT NOT NULL -- PK,
    [acc_ID] INT NULL,
    [lst_Title] VARCHAR(255) NULL,
    [lst_OnlineText] VARCHAR(4000) NULL,
    [lst_Price] DECIMAL(18,2) NULL,
    [lst_Phone] VARCHAR(32) NULL,
    [lst_Extension] VARCHAR(32) NULL,
    [lss_ID] INT NOT NULL,
    [lst_Created] DATETIME NOT NULL,
    [lst_Modified] DATETIME NOT NULL,
    [lst_Images] VARCHAR(8000) NULL,
    [veh_vin] VARCHAR(32) NULL,
    [veh_stock] VARCHAR(32) NULL,
    [veh_bodytype] VARCHAR(64) NULL,
    [veh_year] VARCHAR(4) NULL,
    [veh_make] VARCHAR(64) NULL,
    [veh_model] VARCHAR(64) NULL,
    [veh_trim] VARCHAR(128) NULL,
    [veh_status] VARCHAR(32) NULL,
    [veh_mileage] VARCHAR(32) NULL,
    [veh_cylinders] VARCHAR(64) NULL,
    [veh_displacement] VARCHAR(64) NULL,
    [veh_induction] VARCHAR(64) NULL,
    [veh_transmission] VARCHAR(128) NULL,
    [veh_drivetrain] VARCHAR(32) NULL,
    [veh_exteriorcolor] VARCHAR(128) NULL,
    [veh_interiorcolor] VARCHAR(128) NULL,
    [veh_condition] VARCHAR(32) NULL,
    [veh_doors] VARCHAR(8) NULL,
    [veh_fuelcity] VARCHAR(32) NULL,
    [veh_fuelhighway] VARCHAR(32) NULL,
    [veh_fueltype] VARCHAR(32) NULL,
    [veh_carfax] VARCHAR(256) NULL,
    [veh_warranty] VARCHAR(32) NULL,
    [veh_warrantyterms] VARCHAR(128) NULL,
    [veh_options] VARCHAR(4096) NULL,
    [veh_msrp] DECIMAL(18,2) NULL
);

CREATE TABLE [ListingExtension] (
    [lst_ID] INT NOT NULL -- PK,
    [ext_Number] VARCHAR(4) NOT NULL -- PK,
    [lex_Created] DATETIME NOT NULL
);

CREATE TABLE [ListingExtras] (
    [lst_ID] INT NOT NULL,
    [faUID] INT NOT NULL,
    [fdUID] INT NULL,
    [faAdnum] INT NOT NULL,
    [fdPubID] INT NOT NULL,
    [fdEdID] INT NOT NULL
);

CREATE TABLE [ListingHistory] (
    [lhs_ID] INT NOT NULL -- PK,
    [lst_ID] INT NOT NULL,
    [lhs_Start] DATETIME NOT NULL,
    [lhs_End] DATETIME NOT NULL,
    [lhs_Active] BIT NOT NULL,
    [lhs_Deactivated] DATETIME NULL
);

CREATE TABLE [ListingImageDownload_ReDownload] (
    [acc_id] INT NULL,
    [llim_URL] VARCHAR(MAX) NULL,
    [llst_id] INT NOT NULL,
    [ids_id] INT NOT NULL,
    [lid_created] DATETIME NOT NULL,
    [lid_modified] DATETIME NOT NULL,
    [lid_FailCount] INT NOT NULL,
    [lid_url] INT NULL,
    [lid_filesize] INT NULL,
    [captured] DATETIME NULL
);

CREATE TABLE [ListingLog] (
    [lsg_ID] INT NOT NULL -- PK,
    [lst_ModifiedBy] INT NOT NULL,
    [lst_ID] INT NOT NULL,
    [rrg_ID] INT NOT NULL,
    [lst_Weeks] INT NOT NULL,
    [lss_ID] INT NOT NULL,
    [lst_Options] VARCHAR(256) NULL,
    [lst_Images] VARCHAR(8000) NULL,
    [lst_Modified] DATETIME NOT NULL,
    [isInstantOn] VARCHAR(128) NULL
);

CREATE TABLE [ListingMainImage] (
    [llst_id] INT NOT NULL -- PK,
    [main_image] VARCHAR(1024) NULL
);

CREATE TABLE [ListingMakeModel] (
    [scl_name] VARCHAR(64) NOT NULL,
    [veh_make] VARCHAR(64) NULL,
    [veh_model] VARCHAR(64) NULL
);

CREATE TABLE [ListingMigrate] (
    [lst_ID] INT NULL,
    [readyToMigrate] BIT NULL,
    [readyToDelete] BIT NULL
);

CREATE TABLE [ListingPriceType] (
    [lpt_ID] INT NOT NULL -- PK,
    [lpt_Name] VARCHAR(128) NOT NULL,
    [lpt_Active] BIT NOT NULL
);

CREATE TABLE [ListingPrintEditions] (
    [lpe_ID] INT NOT NULL -- PK,
    [lst_ID] INT NOT NULL,
    [ped_ID] INT NOT NULL,
    [ecl_Number] INT NOT NULL
);

CREATE TABLE [ListingProperty] (
    [lst_id] INT NOT NULL -- PK,
    [prp_address] VARCHAR(64) NULL,
    [zip_code] VARCHAR(5) NULL,
    [prp_condition] VARCHAR(32) NULL,
    [prp_bedrooms] VARCHAR(32) NULL,
    [prp_bathrooms] VARCHAR(32) NULL,
    [prp_pet_policy] VARCHAR(32) NULL,
    [prp_type] VARCHAR(32) NULL,
    [prp_square_feet] VARCHAR(32) NULL,
    [prp_style] VARCHAR(32) NULL,
    [prp_parking] VARCHAR(32) NULL,
    [prp_available] VARCHAR(32) NULL,
    [prp_furnishing] VARCHAR(1024) NULL,
    [prp_year_built] VARCHAR(4) NULL,
    [prp_mls_number] VARCHAR(32) NULL,
    [prp_city] VARCHAR(64) NULL,
    [prp_seller_type] VARCHAR(32) NULL,
    [prp_on_site] VARCHAR(32) NULL
);

CREATE TABLE [ListingPurge] (
    [lst_ID] INT NULL,
    [lst_PurgeNote] VARCHAR(256) NULL,
    [lst_PurgeDate] DATETIME NULL
);

CREATE TABLE [ListingStatus] (
    [lss_ID] INT NOT NULL -- PK,
    [lss_Name] VARCHAR(32) NOT NULL,
    [lss_Active] BIT NOT NULL,
    [lss_isCart] BIT NOT NULL
);

CREATE TABLE [ListingStatusLog] (
    [lsl_ID] INT NOT NULL -- PK,
    [lst_ID] INT NOT NULL,
    [lss_ID] INT NOT NULL,
    [lsl_ModifiedBy] INT NOT NULL,
    [lsl_Modified] DATETIME NOT NULL,
    [isInstantOn] VARCHAR(128) NULL
);

CREATE TABLE [ListingUpsellStatus] (
    [lus_ID] INT NOT NULL -- PK,
    [lus_Name] VARCHAR(64) NOT NULL,
    [lus_Active] BIT NOT NULL
);

CREATE TABLE [ListingVehicle] (
    [lst_id] INT NOT NULL -- PK,
    [veh_vin] VARCHAR(32) NULL,
    [veh_stock] VARCHAR(32) NULL,
    [veh_bodytype] VARCHAR(64) NULL,
    [veh_year] VARCHAR(4) NULL,
    [veh_make] VARCHAR(64) NULL,
    [veh_model] VARCHAR(64) NULL,
    [veh_trim] VARCHAR(128) NULL,
    [veh_status] VARCHAR(32) NULL,
    [veh_mileage] VARCHAR(32) NULL,
    [veh_cylinders] VARCHAR(64) NULL,
    [veh_displacement] VARCHAR(64) NULL,
    [veh_induction] VARCHAR(64) NULL,
    [veh_transmission] VARCHAR(64) NULL,
    [veh_drivetrain] VARCHAR(32) NULL,
    [veh_exteriorcolor] VARCHAR(128) NULL,
    [veh_interiorcolor] VARCHAR(128) NULL,
    [veh_condition] VARCHAR(32) NULL,
    [veh_doors] VARCHAR(8) NULL,
    [veh_fuelcity] VARCHAR(32) NULL,
    [veh_fuelhighway] VARCHAR(32) NULL,
    [veh_fueltype] VARCHAR(32) NULL,
    [veh_carfax] VARCHAR(32) NULL,
    [veh_comments] VARCHAR(4096) NULL,
    [veh_warranty] VARCHAR(32) NULL,
    [veh_warrantyterms] VARCHAR(128) NULL,
    [veh_sellertype] VARCHAR(16) NULL,
    [veh_Options] VARCHAR(4096) NULL
);

CREATE TABLE [LiveListingRemoved] (
    [llr_ID] INT NOT NULL -- PK,
    [llst_ID] INT NOT NULL,
    [llr_Removed] DATETIME NOT NULL,
    [llr_Homepage] BIT NOT NULL
);

CREATE TABLE [LocalCom] (
    [lcl_ID] INT NOT NULL -- PK,
    [lcl_Name] VARCHAR(100) NOT NULL,
    [lcl_Location] VARCHAR(100) NOT NULL,
    [lcl_Domain] VARCHAR(100) NOT NULL,
    [lcl_Radius] INT NOT NULL,
    [lcl_Latitude] DECIMAL(10,4) NOT NULL,
    [lcl_Longitude] DECIMAL(10,4) NOT NULL
);

CREATE TABLE [LocalComZip] (
    [lcl_ID] INT NOT NULL -- PK,
    [zip_Code] VARCHAR(5) NOT NULL -- PK,
    [distance] INT NULL
);

CREATE TABLE [LogFile] (
    [lfName] VARCHAR(4000) NULL,
    [lfCreated] DATETIME NULL,
    [lfSize] BIGINT NULL
);

CREATE TABLE [LogType] (
    [lgt_ID] INT NOT NULL -- PK,
    [lgt_Desc] VARCHAR(100) NOT NULL
);

CREATE TABLE [MAIACampaigns] (
    [accountId] INT NOT NULL,
    [adgroup_name] VARCHAR(500) NOT NULL,
    [campaign_name] VARCHAR(500) NOT NULL,
    [tier] VARCHAR(20) NULL,
    [inventory_count] INT NULL
);

CREATE TABLE [MAIACustomDealers] (
    [client_id] VARCHAR(50) NOT NULL -- PK,
    [adv_name] VARCHAR(100) NOT NULL,
    [entered] DATETIME NOT NULL,
    [active] BIT NOT NULL,
    [account_id] INT NULL
);

CREATE TABLE [MAIAMarketplace] (
    [id] INT NOT NULL -- PK,
    [fhId] VARCHAR(100) NOT NULL,
    [fhFeedId] VARCHAR(200) NOT NULL,
    [name] VARCHAR(200) NOT NULL,
    [enabled] BIT NULL,
    [count] INT NULL
);

CREATE TABLE [MailQueue] (
    [mlq_ID] INT NOT NULL -- PK,
    [mlq_Received] DATETIME NOT NULL,
    [mlq_isHTML] BIT NOT NULL,
    [mlq_Priority] SMALLINT NOT NULL,
    [mlq_FromEmail] VARCHAR(128) NOT NULL,
    [mlq_FromName] VARCHAR(128) NOT NULL,
    [mlq_ToEmail] VARCHAR(8000) NOT NULL,
    [mlq_Subject] VARCHAR(256) NOT NULL,
    [mlq_Body] TEXT NOT NULL,
    [mlq_Headers] VARCHAR(8000) NOT NULL,
    [mlq_bcc] VARCHAR(8000) NULL,
    [mlq_Sent] DATETIME NULL,
    [mlq_SentResponse] VARCHAR(1024) NULL
);

CREATE TABLE [MailTemplate] (
    [mlt_ID] INT NOT NULL -- PK,
    [mlt_Name] VARCHAR(64) NOT NULL,
    [mlt_Subject] VARCHAR(128) NOT NULL,
    [mlt_Body] VARCHAR(8000) NOT NULL
);

CREATE TABLE [MailTemplateBySource] (
    [mts_ID] INT NOT NULL -- PK,
    [src_ID] INT NOT NULL,
    [mlt_ID] INT NOT NULL,
    [mts_Name] VARCHAR(64) NOT NULL,
    [mts_Subject] VARCHAR(128) NOT NULL,
    [mts_Body] VARCHAR(8000) NOT NULL
);

CREATE TABLE [Make] (
    [mak_ID] INT NOT NULL -- PK,
    [mak_Name] VARCHAR(32) NOT NULL,
    [mak_scl_ID] INT NULL,
    [old_scl_id] INT NULL
);

CREATE TABLE [Make_Long] (
    [mak_ID] INT NOT NULL,
    [mak_Name] VARCHAR(32) NOT NULL
);

CREATE TABLE [MakeModelBody] (
    [Make] VARCHAR(128) NOT NULL -- PK,
    [Model] VARCHAR(128) NOT NULL -- PK,
    [Body] VARCHAR(64) NULL,
    [SubClassID] INT NULL,
    [AutoAdd] BIT NULL
);

CREATE TABLE [MakeSynonym] (
    [ksy_ID] INT NOT NULL -- PK,
    [mak_ID] INT NOT NULL,
    [ksy_Name] VARCHAR(32) NOT NULL
);

CREATE TABLE [MappedFields] (
    [t1] NVARCHAR(128) NULL,
    [c1] NVARCHAR(128) NULL,
    [t2] NVARCHAR(128) NULL,
    [c2] NVARCHAR(128) NULL,
    [upd] NVARCHAR(519) NULL
);

CREATE TABLE [MarineCL] (
    [ID] INT NOT NULL -- PK,
    [dlrName] VARCHAR(256) NULL,
    [fdUID] INT NULL,
    [MaxListings] INT NULL,
    [Posted] DATE NULL
);

CREATE TABLE [MerchantAccountStatus] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(255) NULL,
    [WebsiteUrl] NVARCHAR(255) NULL,
    [WebsiteClaimed] BIT NULL,
    [PhoneVerificationStatus] NVARCHAR(255) NULL,
    [PhoneNumber] NVARCHAR(255) NULL,
    [GoogleMyBusinessStatus] NVARCHAR(255) NULL,
    [GoogleMyBusinessId] NVARCHAR(255) NULL,
    [GoogleMyBusinessEmail] NVARCHAR(255) NULL,
    [DataFeedTotal] BIGINT NULL,
    [DataFeedItemsValid] BIGINT NULL,
    [DataFeedStatus] NVARCHAR(255) NULL,
    [DataFeedLastUploadDate] NVARCHAR(255) NULL,
    [DataFeedErrors] INT NULL,
    [DataFeedWarnings] INT NULL,
    [PendingCount] INT NULL,
    [DisqualCount] INT NULL,
    [ApprovedCount] INT NULL,
    [UpdatedAt] DATETIME NULL,
    [MCAAccountId] BIGINT NULL,
    [OneApprovedTime] DATETIME NULL,
    [AllApprovedTime] DATETIME NULL,
    [DomainMatchVDP] BIT NULL
);

CREATE TABLE [Merge_Campaigns] (
    [old_id] BIGINT NULL,
    [new_id] BIGINT NULL,
    [adv_name] VARCHAR(128) NULL,
    [adv_acc_id] BIGINT NULL,
    [sub_name] VARCHAR(256) NULL
);

CREATE TABLE [MetaAdCreationWebhookLogs] (
    [LogId] BIGINT NOT NULL -- PK,
    [EventType] NVARCHAR(20) NOT NULL,
    [ResultId] NVARCHAR(50) NULL,
    [ReceivedAt] DATETIME2 NULL,
    [ProcessedAt] DATETIME2 NULL,
    [PayloadJson] NVARCHAR(MAX) NULL,
    [Debounced] BIT NULL,
    [Processed] BIT NULL,
    [Matched] BIT NULL,
    [MatchedRuleId] INT NULL,
    [MatchReason] NVARCHAR(400) NULL,
    [AdIdsJson] NVARCHAR(MAX) NULL,
    [EmailsJson] NVARCHAR(MAX) NULL,
    [ErrorMessage] NVARCHAR(MAX) NULL,
    [AppInstance] NVARCHAR(100) NULL,
    [TraceId] NVARCHAR(100) NULL
);

CREATE TABLE [MetaAdCreationWebhookRuleJson] (
    [RuleId] INT NOT NULL -- PK,
    [Enabled] BIT NOT NULL,
    [TimeZoneId] NVARCHAR(64) NOT NULL,
    [RuleJson] NVARCHAR(MAX) NOT NULL,
    [EmailTo] NVARCHAR(400) NULL,
    [EmailCc] NVARCHAR(400) NULL,
    [EmailBcc] NVARCHAR(400) NULL
);

CREATE TABLE [MetaBusinessManagers] (
    [Id] INT NOT NULL -- PK,
    [Name] NVARCHAR(255) NOT NULL,
    [FacebookBusinessId] VARCHAR(50) NOT NULL,
    [DisplayName] NVARCHAR(255) NULL,
    [Notes] NVARCHAR(1000) NULL,
    [StatusId] TINYINT NOT NULL,
    [SystemUserId] VARCHAR(50) NULL,
    [TimezoneId] INT NULL,
    [Currency] VARCHAR(10) NULL,
    [BusinessEmail] NVARCHAR(255) NULL,
    [WebsiteUrl] NVARCHAR(500) NULL,
    [LastApiCallAt] DATETIME2 NULL,
    [LastSuccessfulSyncAt] DATETIME2 NULL,
    [LastErrorMessage] NVARCHAR(1000) NULL,
    [CreatedAt] DATETIME2 NOT NULL,
    [UpdatedAt] DATETIME2 NOT NULL,
    [IsDeleted] BIT NOT NULL
);

CREATE TABLE [MetaBusinessManagerStatuses] (
    [Id] TINYINT NOT NULL -- PK,
    [Name] VARCHAR(50) NOT NULL,
    [Description] NVARCHAR(255) NULL
);

CREATE TABLE [MissingCalls] (
    [XMLID] VARCHAR(50) NULL,
    [VendorName] VARCHAR(50) NULL,
    [VendorID] VARCHAR(50) NULL,
    [ProviderName] VARCHAR(50) NULL,
    [ProviderID] VARCHAR(50) NULL,
    [TollFreeNumber] VARCHAR(50) NULL,
    [Redirect] VARCHAR(50) NULL,
    [CallerName] VARCHAR(50) NULL,
    [TrackingNumber] VARCHAR(50) NULL,
    [Address] VARCHAR(50) NULL,
    [CalledFrom] VARCHAR(50) NULL,
    [City] VARCHAR(50) NULL,
    [Country] VARCHAR(50) NULL,
    [State] VARCHAR(50) NULL,
    [Zip] VARCHAR(50) NULL,
    [ZipPlus4] VARCHAR(50) NULL,
    [Date] VARCHAR(50) NULL,
    [Time] VARCHAR(50) NULL,
    [DurationinMinutes] VARCHAR(50) NULL,
    [DurationinSeconds] VARCHAR(50) NULL,
    [Status] VARCHAR(50) NULL
);

CREATE TABLE [MissingCalls_First] (
    [XMLID] FLOAT NULL,
    [Campaign] NVARCHAR(255) NULL,
    [Number] NVARCHAR(255) NULL,
    [MediaType] NVARCHAR(255) NULL,
    [MediaSubType] NVARCHAR(255) NULL,
    [TrackingNumber] FLOAT NULL,
    [CallerName] NVARCHAR(255) NULL,
    [CalledFrom] NVARCHAR(255) NULL,
    [Address] NVARCHAR(255) NULL,
    [City] NVARCHAR(255) NULL,
    [State] NVARCHAR(255) NULL,
    [Country] NVARCHAR(255) NULL,
    [Zip] FLOAT NULL,
    [ZipPlus4] FLOAT NULL,
    [DNCFlags] NVARCHAR(255) NULL,
    [JournalNote] NVARCHAR(255) NULL,
    [Date] DATETIME NULL,
    [Time] DATETIME NULL,
    [F19] NVARCHAR(255) NULL,
    [Duration] FLOAT NULL,
    [Rating] NVARCHAR(255) NULL,
    [Agent] NVARCHAR(255) NULL
);

CREATE TABLE [MissingFeedExtras] (
    [lst_id] INT NOT NULL,
    [scl_id] INT NOT NULL,
    [fayear] SMALLINT NULL,
    [faMAKE] VARCHAR(32) NULL,
    [faMODEL] VARCHAR(128) NULL,
    [faSUBMODEL] VARCHAR(32) NULL,
    [faVIN] VARCHAR(64) NOT NULL,
    [faSTOCK] VARCHAR(32) NULL,
    [faUID] INT NOT NULL,
    [fxCarType] INT NULL,
    [fxCondition] VARCHAR(16) NULL,
    [fxBodyType] VARCHAR(128) NULL,
    [fxMileage] VARCHAR(50) NULL,
    [fxTransmission] VARCHAR(100) NULL,
    [fxEngineDisposition] VARCHAR(32) NULL,
    [fxEngineSize] VARCHAR(64) NULL,
    [fxInduction] VARCHAR(100) NULL,
    [fxDriveTrain] VARCHAR(16) NULL,
    [fxFuelType] VARCHAR(128) NULL,
    [fxFuelCity] VARCHAR(100) NULL,
    [fxFuelHighway] VARCHAR(100) NULL,
    [fxFuelCombined] VARCHAR(100) NULL,
    [fxDoors] VARCHAR(16) NULL,
    [fxExteriorColor] VARCHAR(128) NULL,
    [fxInteriorColor] VARCHAR(128) NULL,
    [fxPaymentPrice] MONEY NULL,
    [fxPaymentType] VARCHAR(16) NULL,
    [fxWarranty] VARCHAR(128) NULL,
    [fxWarrantyTerms] VARCHAR(128) NULL,
    [fxCertified] VARCHAR(32) NULL,
    [fxComments] VARCHAR(2400) NULL,
    [fxOptions] VARCHAR(8000) NULL,
    [fxSellerType] VARCHAR(32) NULL,
    [fxModelCode] VARCHAR(32) NULL,
    [fxMSRP] MONEY NULL,
    [fxDateInStock] DATETIME NULL,
    [fxGenericExtColor] VARCHAR(32) NULL,
    [fxGenericIntColor] VARCHAR(32) NULL
);

CREATE TABLE [MissingRatchetDisplayCreative] (
    [fckID] INT NOT NULL,
    [fcmID] INT NULL,
    [fckName] VARCHAR(4000) NULL,
    [rcd_ID] INT NULL,
    [rdc_Creative] VARCHAR(512) NULL,
    [ban_ID] INT NULL,
    [rds_ID] INT NULL,
    [rdc_StartDate] DATETIME NULL,
    [rdc_EndDate] DATETIME NULL,
    [rdc_LandingURL] VARCHAR(512) NULL,
    [aso_ID] INT NULL,
    [aso_Name] VARCHAR(128) NULL
);

CREATE TABLE [Model] (
    [mod_ID] INT NOT NULL -- PK,
    [mak_ID] INT NOT NULL,
    [mod_Name] VARCHAR(64) NOT NULL,
    [mod_scl_ID] INT NULL,
    [old_scl_id] INT NULL
);

CREATE TABLE [Model_Long] (
    [mod_ID] INT NOT NULL,
    [mak_ID] INT NOT NULL,
    [mod_Name] VARCHAR(64) NOT NULL,
    [mod_scl_ID] INT NULL
);

CREATE TABLE [ModelSynonym] (
    [dsy_ID] INT NOT NULL -- PK,
    [mod_ID] INT NOT NULL,
    [dsy_Name] VARCHAR(64) NOT NULL
);

CREATE TABLE [MultiFeedOverwrite] (
    [EDTAG] VARCHAR(64) NOT NULL -- PK,
    [FDID_OLD] VARCHAR(32) NOT NULL -- PK,
    [FDID_NEW] VARCHAR(32) NOT NULL,
    [CREATED] DATETIME NOT NULL
);

CREATE TABLE [NCTDCategory] (
    [nctdvehiclecategory] VARCHAR(64) NULL,
    [scl_id] INT NOT NULL
);

CREATE TABLE [NCTDMakeModel] (
    [nctdMake] VARCHAR(64) NULL,
    [nctdModel] VARCHAR(64) NULL,
    [scl_id] INT NOT NULL
);

CREATE TABLE [NewIPBlocks] (
    [startIpNum] BIGINT NULL,
    [endIpNum] BIGINT NULL,
    [locId] BIGINT NULL
);

CREATE TABLE [NewPrintTranslate] (
    [npt_ID] INT NOT NULL -- PK,
    [scl_ID] INT NOT NULL,
    [ped_ID] INT NOT NULL,
    [print_eClsID] INT NOT NULL,
    [print_eClsNumber] INT NOT NULL,
    [print_eClsName] VARCHAR(255) NOT NULL,
    [print_Submit] BIT NOT NULL,
    [LastChange] DATETIME NOT NULL
);

CREATE TABLE [NewZipCodes] (
    [zipCode] VARCHAR(5) NULL,
    [zipType] VARCHAR(1) NULL,
    [cityName] VARCHAR(64) NULL,
    [cityType] CHAR(1) NULL,
    [countyName] VARCHAR(64) NULL,
    [countyFIPS] CHAR(5) NULL,
    [stateName] VARCHAR(64) NULL,
    [stateAbbr] CHAR(2) NULL,
    [stateFIPS] CHAR(2) NULL,
    [MSACode] CHAR(4) NULL,
    [AreaCode] VARCHAR(16) NULL,
    [TimeZone] VARCHAR(16) NULL,
    [UTC] DECIMAL(3,1) NULL,
    [DST] CHAR(1) NULL,
    [Latitude] DECIMAL(9,6) NULL,
    [Longitude] DECIMAL(9,6) NULL
);

CREATE TABLE [obf_Chrome] (
    [x] VARCHAR(MAX) NULL
);

CREATE TABLE [obr_Campaign_Info_V6] (
    [acc_ID] VARCHAR(32) NULL,
    [_Master_ID] VARCHAR(32) NULL,
    [_Campaign_Name] NVARCHAR(256) NULL,
    [Start_Date] VARCHAR(32) NULL,
    [End_Date] VARCHAR(32) NULL,
    [Target_Actions] VARCHAR(32) NULL,
    [Target_Impressions] VARCHAR(32) NULL,
    [Target_Clicks] VARCHAR(32) NULL,
    [Target_Profile_Views] VARCHAR(32) NULL,
    [Target_VDPs] VARCHAR(32) NULL
);

CREATE TABLE [obr_CreativeImages] (
    [acc_id] VARCHAR(32) NULL,
    [rcd_master_id] VARCHAR(32) NULL,
    [rdc_id] VARCHAR(32) NULL,
    [rdc_Creative] VARCHAR(8000) NULL,
    [rcd_Created] DATETIME NULL
);

CREATE TABLE [obr_CreativeImages_V6] (
    [acc_id] VARCHAR(32) NULL,
    [rcd_master_id] VARCHAR(32) NULL,
    [rdc_id] VARCHAR(32) NULL,
    [rdc_Creative] VARCHAR(8000) NULL,
    [rcd_Created] DATETIME NULL
);

CREATE TABLE [obr_CustomerList] (
    [acc_ID] VARCHAR(32) NULL,
    [acc_Customer] VARCHAR(64) NULL,
    [acc_Phone] VARCHAR(16) NULL
);

CREATE TABLE [obr_CustomerList_V10] (
    [rco_id] VARCHAR(32) NOT NULL,
    [acc_ID] VARCHAR(32) NOT NULL,
    [acc_Customer] VARCHAR(64) NOT NULL,
    [acc_phone] VARCHAR(32) NOT NULL,
    [charter_Name] VARCHAR(256) NULL,
    [charter_ID] VARCHAR(256) NULL,
    [charter_Region_ID] VARCHAR(32) NULL,
    [exported] VARCHAR(32) NOT NULL
);

CREATE TABLE [obr_CustomerList_V10_Short] (
    [rco_id] VARCHAR(32) NOT NULL,
    [acc_ID] VARCHAR(32) NOT NULL,
    [acc_Customer] VARCHAR(64) NOT NULL,
    [acc_phone] VARCHAR(32) NOT NULL,
    [External_ID] VARCHAR(256) NULL,
    [exported] VARCHAR(32) NOT NULL
);

CREATE TABLE [obr_CustomerList_v2] (
    [acc_ID] VARCHAR(32) NOT NULL,
    [acc_Customer] VARCHAR(64) NULL,
    [acc_phone] VARCHAR(32) NULL,
    [leads] VARCHAR(1) NOT NULL,
    [directories] VARCHAR(1) NOT NULL,
    [display] VARCHAR(1) NOT NULL,
    [smartads] VARCHAR(1) NOT NULL,
    [charter_Name] VARCHAR(256) NULL,
    [charter_ID] VARCHAR(256) NULL,
    [charter_Region] VARCHAR(256) NULL
);

CREATE TABLE [obr_CustomerList_v4] (
    [acc_ID] VARCHAR(32) NOT NULL -- PK,
    [acc_Customer] VARCHAR(64) NOT NULL,
    [acc_phone] VARCHAR(32) NOT NULL,
    [leads] VARCHAR(32) NOT NULL,
    [directories] VARCHAR(32) NOT NULL,
    [display] VARCHAR(32) NOT NULL,
    [smartads] VARCHAR(32) NOT NULL,
    [charter_Name] VARCHAR(256) NOT NULL,
    [charter_ID] VARCHAR(256) NOT NULL,
    [charter_Region_ID] VARCHAR(32) NOT NULL,
    [exported] VARCHAR(32) NOT NULL -- PK,
    [package] VARCHAR(1) NOT NULL,
    [price] VARCHAR(32) NOT NULL,
    [targetactions] VARCHAR(32) NOT NULL
);

CREATE TABLE [obr_customerlist_v4_201612] (
    [acc_ID] VARCHAR(32) NOT NULL,
    [Customer] VARCHAR(64) NULL,
    [Phone] VARCHAR(32) NULL,
    [leads] INT NULL,
    [directories] INT NULL,
    [display] INT NULL,
    [smartads] INT NULL,
    [charter_Name] VARCHAR(256) NULL,
    [charter_ID] VARCHAR(256) NULL,
    [charter_Region_ID] VARCHAR(32) NULL,
    [exported] INT NULL,
    [package] VARCHAR(1) NOT NULL,
    [price] VARCHAR(32) NULL,
    [targetactions] VARCHAR(32) NULL
);

CREATE TABLE [obr_CustomerList_v6] (
    [acc_ID] VARCHAR(32) NOT NULL,
    [acc_Customer] VARCHAR(64) NOT NULL,
    [acc_phone] VARCHAR(32) NOT NULL,
    [leads] VARCHAR(32) NOT NULL,
    [directories] VARCHAR(32) NOT NULL,
    [display] VARCHAR(32) NOT NULL,
    [smartads] VARCHAR(32) NOT NULL,
    [social] VARCHAR(32) NOT NULL,
    [charter_Name] VARCHAR(256) NULL,
    [charter_ID] VARCHAR(256) NULL,
    [charter_Region_ID] VARCHAR(32) NULL,
    [exported] VARCHAR(32) NOT NULL,
    [package] VARCHAR(1) NOT NULL,
    [price] VARCHAR(32) NULL,
    [targetactions] VARCHAR(32) NULL
);

CREATE TABLE [obr_CustomerList_v6_Short] (
    [acc_ID] VARCHAR(32) NOT NULL,
    [acc_Customer] VARCHAR(64) NOT NULL,
    [acc_phone] VARCHAR(32) NOT NULL,
    [leads] VARCHAR(32) NOT NULL,
    [directories] VARCHAR(32) NOT NULL,
    [display] VARCHAR(32) NOT NULL,
    [smartads] VARCHAR(32) NOT NULL,
    [social] VARCHAR(32) NOT NULL,
    [exported] VARCHAR(32) NOT NULL,
    [External_ID] VARCHAR(256) NULL
);

CREATE TABLE [obr_CustomerList_V7] (
    [rco_id] VARCHAR(32) NOT NULL,
    [acc_ID] VARCHAR(32) NOT NULL,
    [acc_Customer] VARCHAR(64) NOT NULL,
    [acc_phone] VARCHAR(32) NOT NULL,
    [charter_Name] VARCHAR(256) NULL,
    [charter_ID] VARCHAR(256) NULL,
    [charter_Region_ID] VARCHAR(32) NULL,
    [exported] VARCHAR(32) NOT NULL
);

CREATE TABLE [obr_CustomerList_V7_Short] (
    [rco_id] VARCHAR(32) NOT NULL,
    [acc_ID] VARCHAR(32) NOT NULL,
    [acc_Customer] VARCHAR(64) NOT NULL,
    [acc_phone] VARCHAR(32) NOT NULL,
    [External_ID] VARCHAR(256) NULL,
    [exported] VARCHAR(32) NOT NULL
);

CREATE TABLE [obr_Dates_V10] (
    [rco_id] INT NOT NULL,
    [StartDate] DATE NOT NULL,
    [EndDate] DATE NOT NULL,
    [StartINT] INT NOT NULL,
    [EndINT] INT NOT NULL,
    [Captured] VARCHAR(32) NOT NULL
);

CREATE TABLE [obr_Dates_v6] (
    [StartDate] DATE NULL,
    [EndDate] DATE NULL,
    [StartINT] INT NULL,
    [EndINT] INT NULL,
    [Captured] VARCHAR(32) NULL
);

CREATE TABLE [obr_Dates_V7] (
    [rco_id] INT NOT NULL,
    [StartDate] DATE NOT NULL,
    [EndDate] DATE NOT NULL,
    [StartINT] INT NOT NULL,
    [EndINT] INT NOT NULL,
    [Captured] VARCHAR(32) NOT NULL
);

CREATE TABLE [obr_DisplayClicks] (
    [acc_ID] VARCHAR(32) NULL,
    [rcd_Master_ID] VARCHAR(32) NOT NULL -- PK,
    [rcd_Campaign_Name] VARCHAR(8000) NULL,
    [Captured] VARCHAR(32) NOT NULL -- PK,
    [Clicks] VARCHAR(32) NULL,
    [Impressions] VARCHAR(32) NULL,
    [isDynamic] VARCHAR(32) NULL
);

CREATE TABLE [obr_DisplayClicks_V10] (
    [rco_id] VARCHAR(32) NOT NULL,
    [acc_ID] VARCHAR(32) NOT NULL,
    [_Master_ID] VARCHAR(32) NOT NULL,
    [Captured] VARCHAR(32) NOT NULL,
    [Clicks] VARCHAR(32) NOT NULL,
    [Impressions] VARCHAR(32) NOT NULL,
    [isRetargeting] VARCHAR(1) NULL
);

CREATE TABLE [obr_DisplayClicks_V6] (
    [acc_ID] VARCHAR(32) NULL,
    [rcd_Master_ID] VARCHAR(32) NOT NULL,
    [rcd_Campaign_Name] VARCHAR(8000) NULL,
    [Captured] VARCHAR(32) NOT NULL,
    [Clicks] VARCHAR(32) NULL,
    [Impressions] VARCHAR(32) NULL,
    [isDynamic] VARCHAR(32) NULL,
    [isSocial] VARCHAR(32) NULL
);

CREATE TABLE [obr_DisplayClicks_V7] (
    [rco_id] VARCHAR(32) NOT NULL,
    [acc_ID] VARCHAR(32) NOT NULL,
    [_Master_ID] VARCHAR(32) NOT NULL,
    [Captured] VARCHAR(32) NOT NULL,
    [Clicks] VARCHAR(32) NOT NULL,
    [Impressions] VARCHAR(32) NOT NULL,
    [isRetargeting] VARCHAR(1) NULL
);

CREATE TABLE [obr_DisplayGeoClicks] (
    [acc_ID] VARCHAR(32) NULL,
    [rcd_Master_ID] VARCHAR(32) NULL,
    [rcd_Campaign_Name] VARCHAR(8000) NULL,
    [disgeo_city] VARCHAR(255) NOT NULL,
    [disgeo_region] VARCHAR(255) NOT NULL,
    [Captured] VARCHAR(32) NULL,
    [Clicks] VARCHAR(32) NULL,
    [Impressions] VARCHAR(32) NULL,
    [isDynamic] VARCHAR(32) NULL,
    [disgeo_country] VARCHAR(255) NOT NULL,
    [disgeo_zip] VARCHAR(5) NULL
);

CREATE TABLE [obr_DisplayGeoClicks_V10] (
    [rco_id] VARCHAR(32) NOT NULL,
    [acc_ID] VARCHAR(32) NOT NULL,
    [_Master_ID] VARCHAR(32) NOT NULL,
    [disgeo_city] VARCHAR(255) NOT NULL,
    [disgeo_state] VARCHAR(255) NOT NULL,
    [disgeo_country] VARCHAR(255) NOT NULL,
    [disgeo_zip] VARCHAR(5) NULL,
    [Captured] VARCHAR(32) NOT NULL,
    [Clicks] VARCHAR(32) NOT NULL,
    [Impressions] VARCHAR(32) NOT NULL
);

CREATE TABLE [obr_DisplayGeoClicks_V6] (
    [acc_ID] VARCHAR(32) NULL,
    [rcd_Master_ID] VARCHAR(32) NULL,
    [rcd_Campaign_Name] VARCHAR(8000) NULL,
    [disgeo_city] VARCHAR(255) NOT NULL,
    [disgeo_region] VARCHAR(255) NOT NULL,
    [Captured] VARCHAR(32) NULL,
    [Clicks] VARCHAR(32) NULL,
    [Impressions] VARCHAR(32) NULL,
    [isDynamic] VARCHAR(32) NULL,
    [disgeo_country] VARCHAR(255) NOT NULL,
    [disgeo_zip] VARCHAR(5) NULL
);

CREATE TABLE [obr_DisplayGeoClicks_V7] (
    [rco_id] VARCHAR(32) NOT NULL,
    [acc_ID] VARCHAR(32) NOT NULL,
    [_Master_ID] VARCHAR(32) NOT NULL,
    [disgeo_city] VARCHAR(255) NOT NULL,
    [disgeo_state] VARCHAR(255) NOT NULL,
    [disgeo_country] VARCHAR(255) NOT NULL,
    [disgeo_zip] VARCHAR(5) NULL,
    [Captured] VARCHAR(32) NOT NULL,
    [Clicks] VARCHAR(32) NOT NULL,
    [Impressions] VARCHAR(32) NOT NULL
);

CREATE TABLE [obr_DoNotCallList] (
    [Captured] VARCHAR(32) NULL,
    [acc_id] VARCHAR(32) NULL,
    [acc_company] VARCHAR(64) NULL,
    [acc_phone] VARCHAR(16) NULL,
    [zip_code] VARCHAR(10) NULL,
    [acc_created] VARCHAR(32) NULL,
    [acc_modified] VARCHAR(32) NULL,
    [acc_rep] VARCHAR(128) NULL,
    [acc_active] VARCHAR(32) NULL,
    [Source] VARCHAR(64) NULL
);

CREATE TABLE [obr_DoNotCallList_V10] (
    [Captured] VARCHAR(32) NULL,
    [acc_id] VARCHAR(32) NULL,
    [acc_company] VARCHAR(64) NULL,
    [acc_phone] VARCHAR(16) NULL,
    [zip_code] VARCHAR(10) NULL,
    [acc_created] VARCHAR(32) NULL,
    [acc_modified] VARCHAR(32) NULL,
    [acc_rep] VARCHAR(128) NULL,
    [Source] VARCHAR(64) NULL,
    [local] VARCHAR(32) NULL,
    [ran] VARCHAR(32) NULL,
    [smart_ad] VARCHAR(32) NULL,
    [geo_fencing] VARCHAR(32) NULL,
    [power_listing] VARCHAR(32) NULL,
    [display] VARCHAR(32) NULL,
    [zip_city] VARCHAR(32) NULL,
    [stt_id] VARCHAR(2) NULL,
    [dma_Name] VARCHAR(256) NULL,
    [dma_NielsenName] VARCHAR(128) NULL
);

CREATE TABLE [obr_DoNotCallList_V6] (
    [Captured] VARCHAR(32) NULL,
    [acc_id] VARCHAR(32) NULL,
    [acc_company] VARCHAR(64) NULL,
    [acc_phone] VARCHAR(16) NULL,
    [zip_code] VARCHAR(10) NULL,
    [acc_created] VARCHAR(32) NULL,
    [acc_modified] VARCHAR(32) NULL,
    [acc_rep] VARCHAR(128) NULL,
    [acc_active] VARCHAR(32) NULL,
    [Source] VARCHAR(64) NULL
);

CREATE TABLE [obr_DoNotCallList_V7] (
    [Captured] VARCHAR(32) NULL,
    [acc_id] VARCHAR(32) NULL,
    [acc_company] VARCHAR(64) NULL,
    [acc_phone] VARCHAR(16) NULL,
    [zip_code] VARCHAR(10) NULL,
    [acc_created] VARCHAR(32) NULL,
    [acc_modified] VARCHAR(32) NULL,
    [acc_rep] VARCHAR(128) NULL,
    [Source] VARCHAR(64) NULL,
    [local] VARCHAR(32) NULL,
    [ran] VARCHAR(32) NULL,
    [smart_ad] VARCHAR(32) NULL,
    [geo_fencing] VARCHAR(32) NULL,
    [power_listing] VARCHAR(32) NULL,
    [display] VARCHAR(32) NULL,
    [zip_city] VARCHAR(32) NULL,
    [stt_id] VARCHAR(2) NULL,
    [dma_Name] VARCHAR(256) NULL,
    [dma_NielsenName] VARCHAR(128) NULL
);

CREATE TABLE [obr_EmailLeads] (
    [acc_ID] VARCHAR(32) NOT NULL,
    [VIN] VARCHAR(32) NULL,
    [LeadID] VARCHAR(32) NOT NULL -- PK,
    [Captured] VARCHAR(32) NOT NULL,
    [FromMail] VARCHAR(256) NOT NULL,
    [FirstName] VARCHAR(64) NOT NULL,
    [LastName] VARCHAR(64) NOT NULL,
    [Phone] VARCHAR(16) NOT NULL,
    [Zip] VARCHAR(5) NOT NULL,
    [Comment] VARCHAR(512) NOT NULL
);

CREATE TABLE [obr_EmailLeads_V10] (
    [rco_id] VARCHAR(32) NOT NULL,
    [acc_ID] VARCHAR(32) NOT NULL,
    [lst_ID] VARCHAR(32) NOT NULL,
    [VIN] VARCHAR(32) NULL,
    [LeadID] VARCHAR(32) NOT NULL,
    [Captured] VARCHAR(32) NOT NULL,
    [FromMail] VARCHAR(256) NOT NULL,
    [FirstName] VARCHAR(64) NOT NULL,
    [LastName] VARCHAR(64) NOT NULL,
    [Phone] VARCHAR(16) NOT NULL,
    [Zip] VARCHAR(16) NULL,
    [Comment] VARCHAR(512) NOT NULL
);

CREATE TABLE [obr_EmailLeads_V6] (
    [acc_ID] VARCHAR(32) NOT NULL,
    [VIN] VARCHAR(32) NULL,
    [LeadID] VARCHAR(32) NOT NULL,
    [Captured] VARCHAR(32) NOT NULL,
    [FromMail] VARCHAR(256) NOT NULL,
    [FirstName] VARCHAR(64) NOT NULL,
    [LastName] VARCHAR(64) NOT NULL,
    [Phone] VARCHAR(16) NOT NULL,
    [Zip] VARCHAR(5) NOT NULL,
    [Comment] VARCHAR(512) NOT NULL
);

CREATE TABLE [obr_EmailLeads_V7] (
    [rco_id] VARCHAR(32) NOT NULL,
    [acc_ID] VARCHAR(32) NOT NULL,
    [lst_ID] VARCHAR(32) NOT NULL,
    [VIN] VARCHAR(32) NULL,
    [LeadID] VARCHAR(32) NOT NULL,
    [Captured] VARCHAR(32) NOT NULL,
    [FromMail] VARCHAR(256) NOT NULL,
    [FirstName] VARCHAR(64) NOT NULL,
    [LastName] VARCHAR(64) NOT NULL,
    [Phone] VARCHAR(16) NOT NULL,
    [Zip] VARCHAR(16) NULL,
    [Comment] VARCHAR(512) NOT NULL
);

CREATE TABLE [obr_Flight_Info_V10] (
    [rco_id] VARCHAR(32) NOT NULL,
    [acc_ID] VARCHAR(32) NOT NULL,
    [_Master_ID] VARCHAR(32) NOT NULL,
    [_Flight_ID] VARCHAR(32) NOT NULL,
    [flight_status] VARCHAR(32) NOT NULL,
    [flight_start_date] VARCHAR(32) NOT NULL,
    [flight_end_date] VARCHAR(32) NOT NULL,
    [flight_impressions] VARCHAR(32) NULL,
    [flight_vdps] VARCHAR(32) NULL,
    [flight_clicks] VARCHAR(32) NULL,
    [flight_profile_views] VARCHAR(32) NULL,
    [flight_actions] VARCHAR(32) NULL,
    [price_paid] VARCHAR(32) NULL,
    [package] VARCHAR(256) NOT NULL,
    [exported] VARCHAR(32) NOT NULL,
    [Campaign_Name] VARCHAR(256) NULL
);

CREATE TABLE [obr_Flight_Info_V10_pl] (
    [rco_id] VARCHAR(32) NOT NULL,
    [acc_ID] VARCHAR(32) NOT NULL,
    [_Master_ID] VARCHAR(32) NOT NULL,
    [_Flight_ID] VARCHAR(32) NOT NULL,
    [flight_status] VARCHAR(32) NOT NULL,
    [flight_start_date] VARCHAR(32) NOT NULL,
    [flight_end_date] VARCHAR(32) NOT NULL,
    [flight_impressions] VARCHAR(32) NULL,
    [flight_vdps] VARCHAR(32) NULL,
    [flight_clicks] VARCHAR(32) NULL,
    [flight_profile_views] VARCHAR(32) NULL,
    [flight_actions] VARCHAR(32) NULL,
    [price_paid] VARCHAR(32) NULL,
    [package] VARCHAR(256) NOT NULL,
    [exported] VARCHAR(32) NOT NULL,
    [Campaign_Name] VARCHAR(256) NULL,
    [pl_vehicle_type] VARCHAR(32) NULL,
    [pl_language] VARCHAR(32) NULL,
    [flight_live_date] VARCHAR(32) NULL,
    [isRetargeting] VARCHAR(1) NULL,
    [Retargeting_VDP_Goal] VARCHAR(32) NULL
);

CREATE TABLE [obr_Flight_Info_V7] (
    [rco_id] VARCHAR(32) NOT NULL,
    [acc_ID] VARCHAR(32) NOT NULL,
    [_Master_ID] VARCHAR(32) NOT NULL,
    [_Flight_ID] VARCHAR(32) NOT NULL,
    [flight_status] VARCHAR(32) NOT NULL,
    [flight_start_date] VARCHAR(32) NOT NULL,
    [flight_end_date] VARCHAR(32) NOT NULL,
    [flight_impressions] VARCHAR(32) NULL,
    [flight_vdps] VARCHAR(32) NULL,
    [flight_clicks] VARCHAR(32) NULL,
    [flight_profile_views] VARCHAR(32) NULL,
    [flight_actions] VARCHAR(32) NULL,
    [price_paid] VARCHAR(32) NULL,
    [package] VARCHAR(256) NOT NULL,
    [exported] VARCHAR(32) NOT NULL,
    [Campaign_Name] VARCHAR(256) NULL
);

CREATE TABLE [obr_Flight_Info_V7_fl] (
    [rco_id] VARCHAR(32) NOT NULL,
    [acc_ID] VARCHAR(32) NOT NULL,
    [_Master_ID] VARCHAR(32) NOT NULL,
    [_Flight_ID] VARCHAR(32) NOT NULL,
    [flight_status] VARCHAR(32) NOT NULL,
    [flight_start_date] VARCHAR(32) NOT NULL,
    [flight_end_date] VARCHAR(32) NOT NULL,
    [next_flight_start_date] VARCHAR(32) NOT NULL,
    [next_flight_end_date] VARCHAR(32) NOT NULL,
    [flight_impressions] VARCHAR(32) NULL,
    [flight_vdps] VARCHAR(32) NULL,
    [flight_clicks] VARCHAR(32) NULL,
    [flight_profile_views] VARCHAR(32) NULL,
    [flight_actions] VARCHAR(32) NULL,
    [price_paid] VARCHAR(32) NULL,
    [package] VARCHAR(256) NOT NULL,
    [exported] VARCHAR(32) NOT NULL,
    [Campaign_Name] VARCHAR(256) NULL,
    [pl_vehicle_type] VARCHAR(32) NULL,
    [pl_language] VARCHAR(32) NULL,
    [flight_live_date] VARCHAR(32) NULL,
    [isRetargeting] VARCHAR(1) NULL,
    [Retargeting_VDP_Goal] VARCHAR(32) NULL
);

CREATE TABLE [obr_Flight_Info_V7_Flight] (
    [rco_id] VARCHAR(32) NOT NULL,
    [acc_ID] VARCHAR(32) NOT NULL,
    [_Master_ID] VARCHAR(32) NOT NULL,
    [_Flight_ID] VARCHAR(32) NOT NULL,
    [flight_status] VARCHAR(32) NOT NULL,
    [flight_start_date] VARCHAR(32) NOT NULL,
    [flight_end_date] VARCHAR(32) NOT NULL,
    [next_flight_start_date] VARCHAR(32) NOT NULL,
    [next_flight_end_date] VARCHAR(32) NOT NULL,
    [flight_impressions] VARCHAR(32) NULL,
    [flight_vdps] VARCHAR(32) NULL,
    [flight_clicks] VARCHAR(32) NULL,
    [flight_profile_views] VARCHAR(32) NULL,
    [flight_actions] VARCHAR(32) NULL,
    [price_paid] VARCHAR(32) NULL,
    [package] VARCHAR(256) NOT NULL,
    [exported] VARCHAR(32) NOT NULL,
    [Campaign_Name] VARCHAR(256) NULL
);

CREATE TABLE [obr_Flight_Info_V7_pl] (
    [rco_id] VARCHAR(32) NOT NULL,
    [acc_ID] VARCHAR(32) NOT NULL,
    [_Master_ID] VARCHAR(32) NOT NULL,
    [_Flight_ID] VARCHAR(32) NOT NULL,
    [flight_status] VARCHAR(32) NOT NULL,
    [flight_start_date] VARCHAR(32) NOT NULL,
    [flight_end_date] VARCHAR(32) NOT NULL,
    [flight_impressions] VARCHAR(32) NULL,
    [flight_vdps] VARCHAR(32) NULL,
    [flight_clicks] VARCHAR(32) NULL,
    [flight_profile_views] VARCHAR(32) NULL,
    [flight_actions] VARCHAR(32) NULL,
    [price_paid] VARCHAR(32) NULL,
    [package] VARCHAR(256) NOT NULL,
    [exported] VARCHAR(32) NOT NULL,
    [Campaign_Name] VARCHAR(256) NULL,
    [pl_vehicle_type] VARCHAR(32) NULL,
    [pl_language] VARCHAR(32) NULL,
    [flight_live_date] VARCHAR(32) NULL,
    [isRetargeting] VARCHAR(1) NULL,
    [Retargeting_VDP_Goal] VARCHAR(32) NULL
);

CREATE TABLE [obr_HiLoPerformance] (
    [rank] VARCHAR(32) NULL,
    [acc_id] VARCHAR(32) NULL,
    [lst_id] VARCHAR(32) NULL,
    [lst_price] VARCHAR(32) NULL,
    [Details] VARCHAR(32) NULL,
    [Results] VARCHAR(32) NULL,
    [Emails] VARCHAR(32) NULL,
    [lst_onlinetext] VARCHAR(8000) NULL,
    [PriceRange] VARCHAR(1) NULL,
    [Captured] VARCHAR(32) NULL
);

CREATE TABLE [obr_History] (
    [Captured] DATETIME NOT NULL,
    [acc_ID] VARCHAR(32) NOT NULL,
    [acc_Customer] VARCHAR(64) NULL,
    [acc_phone] VARCHAR(32) NULL,
    [leads] VARCHAR(1) NOT NULL,
    [directories] VARCHAR(1) NOT NULL,
    [display] VARCHAR(1) NOT NULL,
    [smartads] VARCHAR(1) NOT NULL,
    [charter_Name] VARCHAR(256) NULL,
    [charter_ID] VARCHAR(256) NULL,
    [charter_Region] VARCHAR(256) NULL,
    [dis_nCaptured] INT NULL,
    [dis_xCaptured] INT NULL,
    [dis_cRows] INT NULL,
    [loc_nCaptured] INT NULL,
    [loc_xCaptured] INT NULL,
    [loc_cRows] INT NULL,
    [phn_nCaptured] INT NULL,
    [phn_xCaptured] INT NULL,
    [phn_cRows] INT NULL,
    [eml_nCaptured] INT NULL,
    [eml_xCaptured] INT NULL,
    [eml_cRows] INT NULL
);

CREATE TABLE [obr_History_v4] (
    [Logged] DATETIME NOT NULL,
    [acc_ID] VARCHAR(32) NOT NULL,
    [acc_Customer] VARCHAR(64) NULL,
    [acc_phone] VARCHAR(32) NULL,
    [leads] VARCHAR(1) NOT NULL,
    [directories] VARCHAR(1) NOT NULL,
    [display] VARCHAR(1) NOT NULL,
    [smartads] VARCHAR(1) NOT NULL,
    [charter_Name] VARCHAR(256) NULL,
    [charter_ID] VARCHAR(256) NULL,
    [charter_Region] VARCHAR(256) NULL,
    [captured] VARCHAR(32) NULL,
    [Package] VARCHAR(1) NULL,
    [Price] VARCHAR(32) NULL,
    [TargetActions] VARCHAR(32) NULL,
    [dis_nCaptured] INT NULL,
    [dis_xCaptured] INT NULL,
    [dis_cRows] INT NULL,
    [loc_nCaptured] INT NULL,
    [loc_xCaptured] INT NULL,
    [loc_cRows] INT NULL,
    [phn_nCaptured] INT NULL,
    [phn_xCaptured] INT NULL,
    [phn_cRows] INT NULL,
    [eml_nCaptured] INT NULL,
    [eml_xCaptured] INT NULL,
    [eml_cRows] INT NULL
);

CREATE TABLE [obr_Leads] (
    [dlrID] VARCHAR(32) NULL,
    [adID] VARCHAR(64) NULL,
    [adVIN] VARCHAR(128) NULL,
    [adSection] VARCHAR(512) NULL,
    [adMake] VARCHAR(128) NULL,
    [adModel] VARCHAR(256) NULL,
    [adSubModel] VARCHAR(256) NULL,
    [adYear] VARCHAR(10) NULL,
    [adMiles] VARCHAR(50) NULL,
    [adHeadline] VARCHAR(512) NULL,
    [adExtColor] VARCHAR(512) NULL,
    [adintColor] VARCHAR(512) NULL,
    [adText] VARCHAR(8000) NULL,
    [adPrice] VARCHAR(32) NULL,
    [adPhone] VARCHAR(32) NULL,
    [adPic1] VARCHAR(512) NULL,
    [adPics] VARCHAR(8000) NULL,
    [carType] VARCHAR(255) NULL,
    [condition] VARCHAR(32) NULL,
    [transmission] VARCHAR(128) NULL,
    [engineDisposition] VARCHAR(128) NULL,
    [engineSize] VARCHAR(128) NULL,
    [induction] VARCHAR(200) NULL,
    [driveTrain] VARCHAR(64) NULL,
    [fuelType] VARCHAR(512) NULL,
    [fuelCity] VARCHAR(200) NULL,
    [fuelHighway] VARCHAR(200) NULL,
    [fuelCombined] VARCHAR(200) NULL,
    [doors] VARCHAR(32) NULL,
    [paymentPrice] VARCHAR(64) NULL,
    [paymentType] VARCHAR(64) NULL,
    [warranty] VARCHAR(512) NULL,
    [warrantyTerms] VARCHAR(512) NULL,
    [certified] VARCHAR(32) NULL,
    [comments] VARCHAR(8000) NULL,
    [options] VARCHAR(8000) NULL,
    [sellerType] VARCHAR(64) NULL,
    [stock] VARCHAR(64) NULL
);

CREATE TABLE [obr_LocalPerformance] (
    [acc_ID] VARCHAR(32) NULL,
    [Captured] VARCHAR(32) NULL,
    [ShortName] VARCHAR(256) NOT NULL,
    [Total] VARCHAR(32) NULL
);

CREATE TABLE [obr_LocalPerformance_V6] (
    [acc_ID] VARCHAR(32) NULL,
    [Captured] VARCHAR(32) NULL,
    [ShortName] VARCHAR(256) NOT NULL,
    [Total] VARCHAR(32) NULL
);

CREATE TABLE [obr_LocalPerformance_V7] (
    [rco_id] VARCHAR(32) NOT NULL,
    [acc_ID] VARCHAR(32) NOT NULL,
    [Captured] VARCHAR(32) NOT NULL,
    [ShortName] VARCHAR(256) NOT NULL,
    [Total] VARCHAR(32) NOT NULL
);

CREATE TABLE [obr_NetworkPerformance_Totals_V10] (
    [rco_ID] VARCHAR(32) NOT NULL,
    [acc_ID] VARCHAR(32) NOT NULL,
    [lst_ID] VARCHAR(32) NULL,
    [_Master_ID] VARCHAR(32) NULL,
    [_Flight_ID] VARCHAR(32) NULL,
    [Captured] VARCHAR(32) NOT NULL,
    [SourceName] VARCHAR(128) NOT NULL,
    [Type] VARCHAR(32) NOT NULL,
    [Total] VARCHAR(32) NOT NULL,
    [isRemarketing] VARCHAR(1) NULL
);

CREATE TABLE [obr_NetworkPerformance_Totals_V6] (
    [captured] VARCHAR(32) NOT NULL,
    [acc_id] VARCHAR(32) NOT NULL,
    [pac_id] VARCHAR(32) NOT NULL,
    [pac_shortname] VARCHAR(256) NOT NULL,
    [total] VARCHAR(32) NOT NULL
);

CREATE TABLE [obr_NetworkPerformance_Totals_V7] (
    [rco_ID] VARCHAR(32) NOT NULL,
    [acc_ID] VARCHAR(32) NOT NULL,
    [lst_ID] VARCHAR(32) NULL,
    [_Master_ID] VARCHAR(32) NULL,
    [_Flight_ID] VARCHAR(32) NULL,
    [Captured] VARCHAR(32) NOT NULL,
    [SourceName] VARCHAR(128) NOT NULL,
    [Type] VARCHAR(32) NOT NULL,
    [Total] VARCHAR(32) NOT NULL,
    [isRemarketing] VARCHAR(1) NULL
);

CREATE TABLE [obr_NetworkPerformance_Totals_V7_Lang] (
    [rco_ID] VARCHAR(32) NOT NULL,
    [acc_ID] VARCHAR(32) NOT NULL,
    [lst_ID] VARCHAR(32) NULL,
    [_Master_ID] VARCHAR(32) NULL,
    [_Flight_ID] VARCHAR(32) NULL,
    [Captured] VARCHAR(32) NOT NULL,
    [SourceName] VARCHAR(128) NOT NULL,
    [Type] VARCHAR(32) NOT NULL,
    [Total] VARCHAR(32) NOT NULL,
    [isRemarketing] VARCHAR(1) NULL,
    [Language] VARCHAR(7) NOT NULL
);

CREATE TABLE [obr_NetworkPerformance_V10] (
    [rco_ID] VARCHAR(32) NOT NULL,
    [acc_ID] VARCHAR(32) NOT NULL,
    [lst_ID] VARCHAR(32) NULL,
    [_Master_ID] VARCHAR(32) NULL,
    [_Flight_ID] VARCHAR(32) NULL,
    [Captured] VARCHAR(32) NOT NULL,
    [SourceName] VARCHAR(128) NOT NULL,
    [Type] VARCHAR(32) NOT NULL,
    [Total] VARCHAR(32) NOT NULL,
    [isRemarketing] VARCHAR(1) NULL
);

CREATE TABLE [obr_NetworkPerformance_V6] (
    [acc_ID] INT NOT NULL,
    [pac_ID] INT NOT NULL,
    [Captured] INT NOT NULL,
    [SourceName] VARCHAR(64) NOT NULL,
    [Total] INT NOT NULL
);

CREATE TABLE [obr_NetworkPerformance_V7] (
    [rco_ID] VARCHAR(32) NOT NULL,
    [acc_ID] VARCHAR(32) NOT NULL,
    [lst_ID] VARCHAR(32) NULL,
    [_Master_ID] VARCHAR(32) NULL,
    [_Flight_ID] VARCHAR(32) NULL,
    [Captured] VARCHAR(32) NOT NULL,
    [SourceName] VARCHAR(128) NOT NULL,
    [Type] VARCHAR(32) NOT NULL,
    [Total] VARCHAR(32) NOT NULL,
    [isRemarketing] VARCHAR(1) NULL
);

CREATE TABLE [obr_NetworkPerformance_V7_Lang] (
    [rco_ID] VARCHAR(32) NOT NULL,
    [acc_ID] VARCHAR(32) NOT NULL,
    [lst_ID] VARCHAR(32) NULL,
    [_Master_ID] VARCHAR(32) NULL,
    [_Flight_ID] VARCHAR(32) NULL,
    [Captured] VARCHAR(32) NOT NULL,
    [SourceName] VARCHAR(128) NOT NULL,
    [Type] VARCHAR(32) NOT NULL,
    [Total] VARCHAR(32) NOT NULL,
    [isRemarketing] VARCHAR(1) NULL,
    [Language] VARCHAR(7) NOT NULL
);

CREATE TABLE [obr_PackageMapping_V10] (
    [rco_ID] INT NOT NULL,
    [prd_ID] INT NOT NULL,
    [ResellersName] VARCHAR(256) NOT NULL
);

CREATE TABLE [obr_PackageMapping_V7] (
    [rco_ID] INT NOT NULL -- PK,
    [prd_ID] INT NOT NULL -- PK,
    [ResellersName] VARCHAR(256) NOT NULL
);

CREATE TABLE [obr_PhoneLeads] (
    [acc_ID] VARCHAR(32) NULL,
    [LeadID] VARCHAR(32) NOT NULL -- PK,
    [Captured] VARCHAR(32) NULL,
    [FirstName] VARCHAR(64) NOT NULL,
    [LastName] VARCHAR(64) NOT NULL,
    [Phone] VARCHAR(16) NOT NULL,
    [Zip] VARCHAR(5) NOT NULL
);

CREATE TABLE [obr_PhoneLeads_V10] (
    [rco_id] VARCHAR(32) NOT NULL,
    [acc_ID] VARCHAR(32) NOT NULL,
    [LeadID] VARCHAR(32) NOT NULL,
    [Captured] VARCHAR(32) NOT NULL,
    [FirstName] VARCHAR(64) NOT NULL,
    [LastName] VARCHAR(64) NOT NULL,
    [Phone] VARCHAR(16) NOT NULL,
    [Zip] VARCHAR(16) NULL
);

CREATE TABLE [obr_PhoneLeads_V6] (
    [acc_ID] VARCHAR(32) NULL,
    [LeadID] VARCHAR(32) NOT NULL,
    [Captured] VARCHAR(32) NULL,
    [FirstName] VARCHAR(64) NOT NULL,
    [LastName] VARCHAR(64) NOT NULL,
    [Phone] VARCHAR(16) NOT NULL,
    [Zip] VARCHAR(5) NOT NULL
);

CREATE TABLE [obr_PhoneLeads_V7] (
    [rco_id] VARCHAR(32) NOT NULL,
    [acc_ID] VARCHAR(32) NOT NULL,
    [LeadID] VARCHAR(32) NOT NULL,
    [Captured] VARCHAR(32) NOT NULL,
    [FirstName] VARCHAR(64) NOT NULL,
    [LastName] VARCHAR(64) NOT NULL,
    [Phone] VARCHAR(16) NOT NULL,
    [Zip] VARCHAR(16) NULL
);

CREATE TABLE [obr_PowerListing_Raw_Summary] (
    [rco_ID] VARCHAR(32) NULL,
    [acc_ID] VARCHAR(32) NULL,
    [Captured] VARCHAR(32) NULL,
    [raw_SERP] VARCHAR(32) NULL,
    [raw_VDP] VARCHAR(32) NULL
);

CREATE TABLE [obr_PowerListingPerformance] (
    [acc_ID] VARCHAR(32) NULL,
    [lst_ID] VARCHAR(32) NULL,
    [rpt_Date] VARCHAR(32) NULL,
    [SERP_Views] VARCHAR(32) NULL,
    [VDP_Views] VARCHAR(32) NULL
);

CREATE TABLE [obr_PowerListingPerformance_V6] (
    [acc_ID] VARCHAR(32) NULL,
    [lst_ID] VARCHAR(32) NULL,
    [rpt_Date] VARCHAR(32) NULL,
    [SERP_Views] VARCHAR(32) NULL,
    [VDP_Views] VARCHAR(32) NULL
);

CREATE TABLE [obr_SearchDetailPerformance] (
    [acc_ID] VARCHAR(32) NULL,
    [rptDate] VARCHAR(32) NULL,
    [pac_ShortName] VARCHAR(256) NOT NULL,
    [DailyTotal] VARCHAR(32) NULL
);

CREATE TABLE [obr_SearchDetailPerformance_V6] (
    [acc_ID] VARCHAR(32) NULL,
    [rptDate] VARCHAR(32) NULL,
    [pac_ShortName] VARCHAR(256) NOT NULL,
    [DailyTotal] VARCHAR(32) NULL
);

CREATE TABLE [obr_VehiclePerformance_V10] (
    [rco_id] VARCHAR(32) NOT NULL,
    [captured] VARCHAR(32) NOT NULL,
    [acc_id] VARCHAR(32) NOT NULL,
    [lst_id] VARCHAR(32) NOT NULL,
    [lst_price] VARCHAR(32) NULL,
    [pricerange] VARCHAR(16) NULL,
    [lst_count] VARCHAR(32) NULL,
    [veh_vin] VARCHAR(128) NULL,
    [veh_year] VARCHAR(128) NULL,
    [veh_make] VARCHAR(128) NULL,
    [veh_model] VARCHAR(128) NULL,
    [veh_trim] VARCHAR(128) NULL,
    [lst_created] VARCHAR(32) NOT NULL,
    [lst_lastupload] VARCHAR(32) NOT NULL,
    [lst_status] VARCHAR(32) NOT NULL
);

CREATE TABLE [obr_VehiclePerformance_V6] (
    [Captured] VARCHAR(32) NOT NULL,
    [acc_id] VARCHAR(32) NOT NULL,
    [lst_id] VARCHAR(32) NOT NULL,
    [Title] VARCHAR(128) NOT NULL,
    [VIn] VARCHAR(32) NULL,
    [Price] VARCHAR(32) NULL,
    [SERPViews] VARCHAR(32) NOT NULL,
    [VDPViews] VARCHAR(32) NOT NULL,
    [BuyersSent] VARCHAR(32) NOT NULL,
    [PriceRange] VARCHAR(1) NULL,
    [LastUpload] VARCHAR(32) NOT NULL,
    [Status] VARCHAR(32) NOT NULL
);

CREATE TABLE [obr_VehiclePerformance_V7] (
    [rco_id] VARCHAR(32) NOT NULL,
    [captured] VARCHAR(32) NOT NULL,
    [acc_id] VARCHAR(32) NOT NULL,
    [lst_id] VARCHAR(32) NOT NULL,
    [lst_price] VARCHAR(32) NULL,
    [pricerange] VARCHAR(16) NULL,
    [lst_count] VARCHAR(32) NULL,
    [veh_vin] VARCHAR(128) NULL,
    [veh_year] VARCHAR(128) NULL,
    [veh_make] VARCHAR(128) NULL,
    [veh_model] VARCHAR(128) NULL,
    [veh_trim] VARCHAR(128) NULL,
    [lst_created] VARCHAR(32) NOT NULL,
    [lst_lastupload] VARCHAR(32) NOT NULL,
    [lst_status] VARCHAR(32) NOT NULL
);

CREATE TABLE [obr_VehicleSummary] (
    [acc_ID] VARCHAR(32) NULL,
    [pac_ID] VARCHAR(32) NULL,
    [pac_Name] VARCHAR(256) NULL,
    [pac_ShortName] VARCHAR(256) NULL,
    [pac_Sort] VARCHAR(32) NULL,
    [total] VARCHAR(32) NULL,
    [count] VARCHAR(32) NULL,
    [Captured] VARCHAR(32) NULL
);

CREATE TABLE [obr_VehicleSummary_V10] (
    [rco_id] VARCHAR(32) NULL,
    [acc_ID] VARCHAR(32) NULL,
    [pac_ID] VARCHAR(32) NULL,
    [pac_Name] VARCHAR(256) NULL,
    [pac_ShortName] VARCHAR(256) NULL,
    [pac_Sort] VARCHAR(32) NULL,
    [total] VARCHAR(32) NULL,
    [count] VARCHAR(32) NULL,
    [Captured] VARCHAR(32) NULL
);

CREATE TABLE [obr_VehicleSummary_V6] (
    [acc_ID] VARCHAR(32) NULL,
    [pac_ID] VARCHAR(32) NULL,
    [pac_Name] VARCHAR(256) NULL,
    [pac_ShortName] VARCHAR(256) NULL,
    [pac_Sort] VARCHAR(32) NULL,
    [total] VARCHAR(32) NULL,
    [count] VARCHAR(32) NULL,
    [Captured] VARCHAR(32) NULL
);

CREATE TABLE [obr_VehicleSummary_V7] (
    [rco_id] VARCHAR(32) NULL,
    [acc_ID] VARCHAR(32) NULL,
    [pac_ID] VARCHAR(32) NULL,
    [pac_Name] VARCHAR(256) NULL,
    [pac_ShortName] VARCHAR(256) NULL,
    [pac_Sort] VARCHAR(32) NULL,
    [total] VARCHAR(32) NULL,
    [count] VARCHAR(32) NULL,
    [Captured] VARCHAR(32) NULL
);

CREATE TABLE [OLMDestinations] (
    [old_ID] INT NOT NULL -- PK,
    [old_Name] VARCHAR(64) NOT NULL,
    [old_MaxListings] INT NOT NULL,
    [old_GetInventorySP] VARCHAR(64) NOT NULL,
    [old_Sort] INT NOT NULL,
    [old_Active] BIT NOT NULL,
    [dsr_ID] INT NOT NULL
);

CREATE TABLE [OLMLog] (
    [oll_ID] BIGINT NOT NULL -- PK,
    [olm_ID] BIGINT NOT NULL,
    [old_ID] INT NOT NULL,
    [oll_rcx_ID] INT NOT NULL,
    [oll_Count] INT NOT NULL,
    [oll_RetryCount] INT NOT NULL,
    [oll_Fulfilled] DATETIME NULL,
    [oll_DateLastAttempted] DATETIME NULL
);

CREATE TABLE [OLMQueue] (
    [olm_ID] BIGINT NOT NULL -- PK,
    [olm_Queued] DATETIME NOT NULL,
    [olm_Processed] DATETIME NULL,
    [acc_ID] INT NOT NULL,
    [olm_Trigger] VARCHAR(64) NOT NULL
);

CREATE TABLE [PaidLeadDetails] (
    [ldq_ID] INT NOT NULL -- PK,
    [esr_ID] INT NOT NULL,
    [esr_LeadCost] MONEY NULL,
    [esr_destid] INT NULL,
    [acd_id] INT NULL,
    [acd_budget] MONEY NULL,
    [acd_bid] MONEY NULL,
    [acd_start] DATETIME NULL,
    [acd_end] DATETIME NULL,
    [acd_active] BIT NULL,
    [acc_ID] INT NULL,
    [acc_lastupload] DATETIME NULL,
    [lst_ID] INT NULL,
    [lst_LastUpload] DATETIME NULL
);

CREATE TABLE [Partner_Data] (
    [adv_acc_id] BIGINT NULL,
    [adv_name] VARCHAR(128) NULL,
    [sales_channel] VARCHAR(128) NULL,
    [vdp_date] VARCHAR(6) NULL,
    [AutoList_SRP] INT NULL,
    [AutoList_VDP] INT NULL,
    [EveryAuto_SRP] INT NULL,
    [EveryAuto_VDP] INT NULL
);

CREATE TABLE [PartnerRules] (
    [esr_ID] INT NOT NULL -- PK,
    [esrr_ID] INT NOT NULL -- PK,
    [active] BIT NOT NULL
);

CREATE TABLE [PerformanceTargetAccounts] (
    [acc_ID] INT NOT NULL -- PK,
    [pta_Leads] INT NOT NULL,
    [pta_Clicks] INT NOT NULL,
    [pta_Actions] INT NOT NULL,
    [pta_PromisedTotal] INT NULL,
    [pat_Price] MONEY NULL,
    [pat_Notes] VARCHAR(4096) NULL
);

CREATE TABLE [PerformanceTargetAccounts_History] (
    [pta_ID] BIGINT NOT NULL -- PK,
    [acc_ID] INT NOT NULL,
    [pta_Leads] INT NOT NULL,
    [pta_Clicks] INT NOT NULL,
    [pta_Actions] INT NOT NULL,
    [pta_PromisedTotal] INT NOT NULL,
    [pat_Price] MONEY NOT NULL,
    [pat_Notes] VARCHAR(4096) NOT NULL,
    [Added] DATETIME NOT NULL
);

CREATE TABLE [Permission] (
    [per_id] INT NOT NULL -- PK,
    [title] VARCHAR(75) NOT NULL,
    [platform] VARCHAR(20) NOT NULL,
    [category] VARCHAR(20) NOT NULL,
    [slug] VARCHAR(50) NOT NULL,
    [description] VARCHAR(250) NOT NULL,
    [active] BIT NOT NULL,
    [created_at] DATETIME NOT NULL,
    [updated_at] DATETIME NOT NULL
);

CREATE TABLE [PhoneFix] (
    [edtag] VARCHAR(128) NOT NULL,
    [adid] INT NULL,
    [dlrphone] VARCHAR(16) NOT NULL,
    [PatFound] VARCHAR(4096) NULL,
    [FormattedPhone] VARCHAR(20) NULL,
    [adtext] VARCHAR(4096) NOT NULL,
    [RUN] INT NULL,
    [POS] INT NULL
);

CREATE TABLE [PhyronDealers] (
    [acc_id] INT NOT NULL -- PK,
    [phyron_dealer_id] VARCHAR(50) NULL,
    [phyron_campaign_id] VARCHAR(50) NULL,
    [max_vehicles] INT NULL,
    [created] DATETIME NOT NULL,
    [updated] DATETIME NULL
);

CREATE TABLE [PhyronVehicles] (
    [acc_id] INT NOT NULL -- PK,
    [lst_id] INT NOT NULL -- PK,
    [added] DATETIME NOT NULL
);

CREATE TABLE [PhyronVideos] (
    [lst_id] INT NOT NULL -- PK,
    [created] DATETIME NOT NULL,
    [last_sent] DATETIME NULL,
    [video_updated] DATETIME NULL,
    [video_url] VARCHAR(1024) NULL,
    [type] VARCHAR(50) NOT NULL -- PK,
    [width] INT NOT NULL -- PK,
    [height] INT NOT NULL -- PK,
    [seconds] INT NOT NULL -- PK,
    [active] BIT NULL
);

CREATE TABLE [PivotRawData] (
    [rptDate] VARCHAR(7) NULL,
    [Channel] VARCHAR(72) NOT NULL,
    [Division] VARCHAR(128) NULL,
    [esr_Name] VARCHAR(50) NULL,
    [esr_LeadSort] INT NULL,
    [Value] MONEY NULL,
    [Type] VARCHAR(1) NOT NULL
);

CREATE TABLE [PlatformAuto_UTM_Mapping] (
    [id] INT NULL,
    [source] VARCHAR(32) NULL,
    [medium] VARCHAR(32) NULL,
    [campaign] VARCHAR(256) NULL,
    [formatted] VARCHAR(512) NULL
);

CREATE TABLE [PlatformExportConfiguration] (
    [subscription_id] INT NOT NULL -- PK,
    [field] VARCHAR(50) NOT NULL -- PK,
    [mapping] VARCHAR(50) NOT NULL,
    [length] INT NULL
);

CREATE TABLE [PlatformExportFields] (
    [platform_id] INT NOT NULL -- PK,
    [field] VARCHAR(50) NOT NULL -- PK,
    [description] VARCHAR(100) NOT NULL
);

CREATE TABLE [PowerListing_URL_UTM] (
    [ratchet_id] BIGINT NOT NULL,
    [subscription_id] BIGINT NULL,
    [adv_acc_id] BIGINT NULL,
    [Provider] NVARCHAR(255) NULL,
    [Provider_Id] NVARCHAR(255) NULL,
    [dealer_url] NVARCHAR(1024) NULL,
    [utm_code] NVARCHAR(512) NULL,
    [utm_source] NVARCHAR(32) NULL,
    [modified_date] DATETIME NULL
);

CREATE TABLE [PowerListingCheck] (
    [adv_acc_id] BIGINT NULL,
    [adv_name] VARCHAR(128) NULL,
    [prd_id] BIGINT NULL,
    [prd_package] VARCHAR(128) NULL,
    [pl_vehicle_type] VARCHAR(32) NULL,
    [pl_language] VARCHAR(32) NULL,
    [ran] INT NOT NULL,
    [isNewVehicle] INT NULL,
    [TotalListings] INT NULL,
    [Have_Prices] INT NULL,
    [Have_Images] INT NULL,
    [Downloaded_Images] INT NULL,
    [Crawl_Matched] INT NULL,
    [Text_Not_Blank] INT NULL,
    [SmartAd_Approved] INT NULL,
    [PowerListing_Approved] INT NULL,
    [minModified] DATETIME NULL,
    [maxModified] DATETIME NULL,
    [created] DATETIME NOT NULL
);

CREATE TABLE [PrintEditions] (
    [ped_ID] INT NOT NULL -- PK,
    [ped_Name] VARCHAR(64) NOT NULL,
    [ped_Description] VARCHAR(3096) NOT NULL,
    [ped_Initials] VARCHAR(16) NOT NULL,
    [ped_Type] INT NULL,
    [ped_Email] VARCHAR(128) NOT NULL,
    [ped_Phone] VARCHAR(16) NOT NULL,
    [ped_Fax] VARCHAR(16) NOT NULL,
    [ped_Address] VARCHAR(64) NOT NULL,
    [ped_City] VARCHAR(64) NOT NULL,
    [ped_State] VARCHAR(2) NOT NULL,
    [ped_Zip] VARCHAR(5) NOT NULL,
    [ped_Center] VARCHAR(5) NOT NULL,
    [ped_Endeavor_EdID] INT NOT NULL,
    [pub_ID] INT NOT NULL,
    [xfg_ID] INT NOT NULL,
    [ped_isInstant_New_rrg_ID] INT NOT NULL,
    [ped_isInstant_Renew_rrg_ID] INT NOT NULL
);

CREATE TABLE [PrintEditionsExtra] (
    [extra_ID] INT NOT NULL,
    [ePublication] VARCHAR(8000) NULL,
    [eBranding] VARCHAR(8000) NULL,
    [eDescription] VARCHAR(8000) NULL,
    [eDeadline] VARCHAR(8000) NULL,
    [ePhoneFax] VARCHAR(8000) NULL,
    [eAddress] VARCHAR(8000) NULL,
    [eEmail] VARCHAR(8000) NULL
);

CREATE TABLE [PrintPublications] (
    [pub_ID] INT NOT NULL -- PK,
    [pub_Name] VARCHAR(64) NOT NULL,
    [pub_PaginationShare] VARCHAR(64) NOT NULL,
    [pub_PaginationPath] VARCHAR(64) NOT NULL,
    [pub_NotifyEmail] VARCHAR(128) NOT NULL,
    [pub_PullFromSales] BIT NOT NULL,
    [pub_UploadFolder] VARCHAR(64) NOT NULL,
    [pub_UploadURL] VARCHAR(128) NOT NULL,
    [pub_dB] VARCHAR(16) NOT NULL,
    [pub_IP] VARCHAR(32) NOT NULL,
    [pub_GM_Notify] VARCHAR(64) NOT NULL,
    [pub_RGM_Notify] VARCHAR(64) NOT NULL,
    [pub_VP_Notify] VARCHAR(64) NOT NULL
);

CREATE TABLE [PrintPublicationsPubDate] (
    [pub_id] INT NOT NULL,
    [dwID] INT NOT NULL,
    [dwName] VARCHAR(9) NOT NULL
);

CREATE TABLE [PrintPublicationsWordReplace] (
    [prw_ID] INT NOT NULL -- PK,
    [pub_ID] INT NOT NULL,
    [prw_Search] VARCHAR(128) NOT NULL,
    [prw_Replace] VARCHAR(128) NOT NULL
);

CREATE TABLE [PrintTranslateImport] (
    [scl_id] INT NULL,
    [scl_name] VARCHAR(255) NULL,
    [ih_scl_ID_Default] INT NULL,
    [old_web_sclid] INT NULL,
    [old_web_sclname] VARCHAR(255) NULL,
    [ptr_id] INT NULL,
    [ped_id] INT NULL,
    [ped_name] VARCHAR(255) NULL,
    [old_print_eclsid] INT NULL,
    [old_print_eclsnumber] INT NULL,
    [old_print_eclsname] VARCHAR(255) NULL,
    [old_print_submit] BIT NOT NULL,
    [changed] VARCHAR(255) NULL,
    [LastChange] DATETIME NULL
);

CREATE TABLE [PrintTranslateUpdates] (
    [scl_id] INT NULL,
    [scl_name] VARCHAR(255) NULL,
    [ih_scl_ID_Default] INT NULL,
    [old_web_sclid] INT NULL,
    [old_web_sclname] VARCHAR(255) NULL,
    [ptr_id] INT NULL,
    [ped_id] INT NULL,
    [ped_name] VARCHAR(255) NULL,
    [old_print_eclsid] INT NULL,
    [old_print_eclsnumber] INT NULL,
    [old_print_eclsname] VARCHAR(255) NULL,
    [old_print_submit] BIT NOT NULL,
    [changed] VARCHAR(255) NULL
);

CREATE TABLE [ProductConfig] (
    [prd_cg_id] BIGINT NULL,
    [prd_id] BIGINT NULL,
    [requires_feed] BIT NULL
);

CREATE TABLE [RANSubscriptionMeta] (
    [Id] BIGINT NULL,
    [AccountId] BIGINT NULL,
    [PrivacyUrl] TEXT NULL,
    [WebsiteUrl] TEXT NULL,
    [FbPageUrl] TEXT NULL,
    [RP] BIT NOT NULL,
    [RL] BIT NOT NULL,
    [ML] BIT NOT NULL,
    [BR] BIT NOT NULL,
    [LV] BIT NOT NULL,
    [YT] BIT NOT NULL
);

CREATE TABLE [RatchetChanges] (
    [rcd_id] INT NOT NULL,
    [rcd_master_id] INT NOT NULL,
    [rcc_id] INT NOT NULL,
    [rcd_campaign_name] VARCHAR(128) NOT NULL,
    [rcd_created] DATETIME NOT NULL,
    [creatives] VARCHAR(MAX) NULL
);

CREATE TABLE [RatchetClient] (
    [rcc_ID] INT NOT NULL -- PK,
    [rcc_Master_ID] INT NULL,
    [rcc_Created_acc_ID] INT NOT NULL,
    [rcc_Created] DATETIME NOT NULL,
    [rcc_Source_aso_ID] INT NOT NULL,
    [rcc_Rep_acc_ID] INT NOT NULL,
    [rcc_Client_acc_ID] INT NULL,
    [cusID] INT NULL,
    [rcc_Site_Name] VARCHAR(64) NOT NULL,
    [rcc_Site_Phone] VARCHAR(16) NOT NULL,
    [rcc_Site_Address1] VARCHAR(64) NOT NULL,
    [rcc_Site_Address2] VARCHAR(64) NOT NULL,
    [rcc_Site_City] VARCHAR(64) NOT NULL,
    [rcc_Site_State] VARCHAR(2) NOT NULL,
    [rcc_Site_Zip] VARCHAR(10) NOT NULL,
    [rcc_Site_URL] VARCHAR(512) NOT NULL,
    [rcc_Site_Email_Text] VARCHAR(128) NOT NULL,
    [rcc_Site_Email_XML] VARCHAR(128) NOT NULL,
    [rcc_Site_Email_Contact] VARCHAR(128) NOT NULL,
    [rcc_Notes] VARCHAR(1024) NOT NULL,
    [rcc_Site_ContactName] VARCHAR(128) NOT NULL,
    [rdg_ID] INT NOT NULL,
    [bty_ID] INT NOT NULL
);

CREATE TABLE [RatchetDisplay] (
    [rcd_ID] INT NOT NULL -- PK,
    [rcd_Master_ID] INT NULL,
    [rcc_ID] INT NOT NULL,
    [rcd_Campaign_Name] VARCHAR(128) NOT NULL,
    [rcd_Created] DATETIME NOT NULL,
    [rcd_Created_acc_ID] INT NOT NULL,
    [rcd_DateSold] DATETIME NOT NULL,
    [rcd_Cost] MONEY NOT NULL,
    [rcd_rft_ID] INT NOT NULL,
    [rcd_isLive] BIT NOT NULL,
    [rcd_StartDate] DATETIME NOT NULL,
    [rcd_EndDate] DATETIME NULL,
    [rcd_LiveDate] DATETIME NULL,
    [rdp_id] INT NOT NULL,
    [rcd_GeoTargetingNotes] VARCHAR(500) NOT NULL,
    [rcd_TargetImpressions] INT NOT NULL,
    [rcd_TargetClicks] INT NOT NULL,
    [rcd_SIMBudget] MONEY NOT NULL,
    [rpp_ID] INT NOT NULL,
    [rdc_ID] INT NULL,
    [rcd_ExpectedImpressions] INT NOT NULL,
    [rcd_Notes] VARCHAR(8000) NULL,
    [wmtid] INT NULL,
    [rcd_MonthlyTargetClicks] INT NULL,
    [rdn_id] INT NOT NULL,
    [rdt_id] INT NULL,
    [rcd_DailyBudget] MONEY NULL,
    [rcd_BidStrategy] INT NULL,
    [rcd_AdRotation] INT NULL,
    [rcd_MobileBidAdjustment] INT NULL,
    [rcd_MobileBidPercentage] FLOAT NULL,
    [rcd_FrequencyCap] INT NULL,
    [rcd_MaxCPC] MONEY NULL,
    [rcd_MaxCPM] MONEY NULL,
    [rcd_Automated] BIT NULL
);

CREATE TABLE [RatchetDisplay_post_Mini_Log] (
    [rcd_ID] INT NULL,
    [rcd_TargetImpressions] INT NULL,
    [rcd_TargetClicks] INT NULL,
    [rcd_Notes] VARCHAR(1024) NULL,
    [rcd_DailyBudget] MONEY NULL,
    [rcd_BidStrategy] INT NULL,
    [rcd_AdRotation] INT NULL,
    [rcd_MobileBidAdjustment] INT NULL,
    [rcd_MobileBidPercentage] FLOAT NULL,
    [rcd_FrequencyCap] INT NULL,
    [rcd_MaxCPC] MONEY NULL,
    [rcd_MaxCPM] MONEY NULL,
    [rcd_Automated] BIT NULL,
    [isMicro] BIT NULL,
    [rcd_isLive] BIT NULL,
    [DateCaptured] DATETIME NULL
);

CREATE TABLE [RatchetDisplayClickPackage] (
    [rdc_ID] INT NOT NULL -- PK,
    [rdc_Name] VARCHAR(32) NOT NULL,
    [rdc_Clicks] INT NOT NULL,
    [rdc_Wholesale] MONEY NOT NULL,
    [rdc_Active] BIT NOT NULL,
    [rdc_Sort] INT NOT NULL
);

CREATE TABLE [RatchetDisplayCreative] (
    [rdc_ID] INT NOT NULL -- PK,
    [rdc_Master_ID] INT NULL,
    [rcd_ID] INT NOT NULL,
    [rdc_Creative] VARCHAR(512) NOT NULL,
    [ban_ID] INT NULL,
    [rds_ID] INT NOT NULL,
    [rdc_StartDate] DATETIME NOT NULL,
    [rdc_EndDate] DATETIME NULL,
    [rdc_LandingURL] VARCHAR(1024) NOT NULL,
    [rdt_id] INT NOT NULL,
    [categories] VARCHAR(50) NULL,
    [keywords] VARCHAR(512) NULL,
    [dyn_Logo] VARCHAR(512) NULL,
    [dyn_Target] VARCHAR(6) NULL,
    [rdm_Id] INT NULL,
    [rda_id] INT NULL,
    [dyn_ShowPhone] BIT NULL,
    [dyn_Company] VARCHAR(64) NULL,
    [dyn_Phone] VARCHAR(16) NULL
);

CREATE TABLE [RatchetDisplayCreativeAlgorithm] (
    [rda_id] INT NOT NULL -- PK,
    [rda_AlgorithmName] VARCHAR(256) NOT NULL,
    [rda_AlgorithmDescription] VARCHAR(256) NULL,
    [rda_SolrId] VARCHAR(128) NULL,
    [rda_DisplaySortOrder] INT NULL
);

CREATE TABLE [RatchetDisplayCreativeTemplate] (
    [rdm_Id] INT NOT NULL -- PK,
    [rdm_templateName] VARCHAR(256) NOT NULL,
    [rdm_templateDescription] VARCHAR(256) NULL,
    [rdm_templatePreviewImg] VARCHAR(1028) NULL,
    [rds_id_creative] INT NULL,
    [rds_id_logo] INT NULL,
    [rdm_active] BIT NOT NULL
);

CREATE TABLE [RatchetDisplayCreativeType] (
    [rdt_id] INT NOT NULL -- PK,
    [rdt_name] VARCHAR(50) NOT NULL,
    [rdt_sort] INT NOT NULL,
    [rdt_active] BIT NOT NULL,
    [rdt_ADP_Name] VARCHAR(128) NULL
);

CREATE TABLE [RatchetDisplayGeo] (
    [rcd_ID] INT NOT NULL -- PK,
    [gdID] INT NOT NULL -- PK,
    [rdg_Created] DATETIME NOT NULL
);

CREATE TABLE [RatchetDisplayIsLiveExpired] (
    [rcd_ID] INT NOT NULL,
    [rcd_Master_ID] INT NULL,
    [rcc_ID] INT NOT NULL,
    [rcd_Campaign_Name] VARCHAR(128) NOT NULL,
    [rcd_Created] DATETIME NOT NULL,
    [rcd_Created_acc_ID] INT NOT NULL,
    [rcd_DateSold] DATETIME NOT NULL,
    [rcd_Cost] MONEY NOT NULL,
    [rcd_rft_ID] INT NOT NULL,
    [rcd_isLive] BIT NOT NULL,
    [rcd_StartDate] DATETIME NOT NULL,
    [rcd_EndDate] DATETIME NULL,
    [rcd_LiveDate] DATETIME NULL,
    [rdp_id] INT NOT NULL,
    [rcd_GeoTargetingNotes] VARCHAR(500) NOT NULL,
    [rcd_TargetImpressions] INT NOT NULL,
    [rcd_TargetClicks] INT NOT NULL,
    [rcd_SIMBudget] MONEY NOT NULL,
    [rpp_ID] INT NOT NULL,
    [rdc_ID] INT NULL,
    [rcd_ExpectedImpressions] INT NOT NULL,
    [rcd_Notes] VARCHAR(8000) NULL,
    [wmtid] INT NULL,
    [rcd_MonthlyTargetClicks] INT NULL,
    [rdn_id] INT NOT NULL,
    [rdt_id] INT NULL,
    [rcd_DailyBudget] MONEY NULL,
    [rcd_BidStrategy] INT NULL,
    [rcd_AdRotation] INT NULL,
    [rcd_MobileBidAdjustment] INT NULL,
    [rcd_MobileBidPercentage] FLOAT NULL,
    [rcd_FrequencyCap] INT NULL,
    [rcd_MaxCPC] MONEY NULL,
    [rcd_MaxCPM] MONEY NULL,
    [rcd_Automated] BIT NULL
);

CREATE TABLE [RatchetDisplayIsLiveFix] (
    [rcd_ID] INT NOT NULL,
    [rcd_Master_ID] INT NULL,
    [rcc_ID] INT NOT NULL,
    [rcd_Campaign_Name] VARCHAR(128) NOT NULL,
    [rcd_Created] DATETIME NOT NULL,
    [rcd_Created_acc_ID] INT NOT NULL,
    [rcd_DateSold] DATETIME NOT NULL,
    [rcd_Cost] MONEY NOT NULL,
    [rcd_rft_ID] INT NOT NULL,
    [rcd_isLive] BIT NOT NULL,
    [rcd_StartDate] DATETIME NOT NULL,
    [rcd_EndDate] DATETIME NULL,
    [rcd_LiveDate] DATETIME NULL,
    [rdp_id] INT NOT NULL,
    [rcd_GeoTargetingNotes] VARCHAR(500) NOT NULL,
    [rcd_TargetImpressions] INT NOT NULL,
    [rcd_TargetClicks] INT NOT NULL,
    [rcd_SIMBudget] MONEY NOT NULL,
    [rpp_ID] INT NOT NULL,
    [rdc_ID] INT NULL,
    [rcd_ExpectedImpressions] INT NOT NULL,
    [rcd_Notes] VARCHAR(8000) NULL,
    [wmtid] INT NULL,
    [rcd_MonthlyTargetClicks] INT NULL,
    [rdn_id] INT NOT NULL,
    [rdt_id] INT NULL,
    [rcd_DailyBudget] MONEY NULL,
    [rcd_BidStrategy] INT NULL,
    [rcd_AdRotation] INT NULL,
    [rcd_MobileBidAdjustment] INT NULL,
    [rcd_MobileBidPercentage] FLOAT NULL,
    [rcd_FrequencyCap] INT NULL,
    [rcd_MaxCPC] MONEY NULL,
    [rcd_MaxCPM] MONEY NULL,
    [rcd_Automated] BIT NULL
);

CREATE TABLE [RatchetDisplayMigration] (
    [rcd_Automated] INT NULL,
    [isDyn] VARCHAR(1) NULL,
    [rdt_Name] VARCHAR(50) NULL,
    [DataSource] VARCHAR(256) NULL,
    [rcd_id] BIGINT NULL,
    [rcd_master_id] BIGINT NOT NULL -- PK,
    [rcc_Site_name] VARCHAR(64) NULL,
    [rcd_campaign_name] VARCHAR(8000) NULL,
    [status] VARCHAR(8) NOT NULL,
    [aso_Name] VARCHAR(64) NULL,
    [rcd_startdate] DATETIME NULL,
    [rcd_enddate] DATETIME NULL,
    [rcd_notes] VARCHAR(8000) NULL,
    [Product] VARCHAR(64) NULL,
    [PricePaid] MONEY NULL,
    [SubmitType] VARCHAR(64) NULL,
    [GeoTargetingNotes] VARCHAR(4096) NULL,
    [ReadyToMigrate] INT NULL,
    [acc_ID] INT NULL,
    [dynColor] VARCHAR(128) NULL,
    [LandingPageType] VARCHAR(16) NULL,
    [DealerWebsite] VARCHAR(256) NULL,
    [TrackingCode] VARCHAR(256) NULL,
    [VehicleType] VARCHAR(16) NULL,
    [dynPhone] VARCHAR(16) NULL,
    [dynCompany] VARCHAR(128) NULL,
    [dynLogo] VARCHAR(8000) NULL,
    [AutoChannelTopic] VARCHAR(2000) NULL,
    [hasSpanish] BIT NULL
);

CREATE TABLE [RatchetDisplayNationWideBackup] (
    [rcd_ID] INT NOT NULL,
    [rcd_Nationwide] BIT NOT NULL
);

CREATE TABLE [RatchetDisplayNetworkPlacement] (
    [rdn_id] INT NOT NULL -- PK,
    [rdn_name] VARCHAR(50) NOT NULL,
    [rdn_active] BIT NOT NULL,
    [rdn_sort] INT NOT NULL,
    [rdn_ADP_Name] VARCHAR(128) NULL
);

CREATE TABLE [RatchetDisplayPackages] (
    [rdp_id] INT NOT NULL -- PK,
    [rdp_name] VARCHAR(50) NOT NULL,
    [rdp_active] BIT NOT NULL,
    [rdp_ADP_Name] VARCHAR(128) NULL
);

CREATE TABLE [RatchetDisplayPaymentPlan] (
    [rpp_ID] INT NOT NULL -- PK,
    [rpp_Name] VARCHAR(32) NOT NULL,
    [rpp_Active] BIT NOT NULL,
    [rpp_Sort] INT NOT NULL,
    [rpp_ADP_Name] VARCHAR(128) NULL
);

CREATE TABLE [RatchetDisplayProfile] (
    [acc_ID] INT NOT NULL -- PK,
    [rdpr_InventoryURL] VARCHAR(512) NOT NULL,
    [rdpr_TrackingCode] VARCHAR(256) NULL
);

CREATE TABLE [RatchetDisplaySize] (
    [rds_id] INT NOT NULL -- PK,
    [rds_label] VARCHAR(50) NOT NULL,
    [rds_active] BIT NOT NULL,
    [rds_width] INT NOT NULL,
    [rds_height] INT NOT NULL
);

CREATE TABLE [RatchetDisplayStates] (
    [rcd_ID] INT NOT NULL -- PK,
    [stt_ID] VARCHAR(2) NOT NULL -- PK,
    [rds_Created] DATETIME NOT NULL
);

CREATE TABLE [RatchetDisplayTarget] (
    [rdt_id] INT NOT NULL -- PK,
    [rdt_Name] VARCHAR(50) NOT NULL,
    [rdt_ADP_Name] VARCHAR(128) NULL
);

CREATE TABLE [RatchetDisplayTargetClickCost] (
    [rdt_RangeMin] INT NOT NULL,
    [rdt_RangeMax] INT NOT NULL,
    [rdt_CostPerClick] MONEY NOT NULL,
    [rdt_Active] BIT NOT NULL
);

CREATE TABLE [RatchetDisplayZipCodes] (
    [rcd_ID] INT NOT NULL -- PK,
    [gdID] INT NOT NULL -- PK,
    [rdg_Created] DATETIME NOT NULL
);

CREATE TABLE [RatchetEmailLog] (
    [rel_ID] INT NOT NULL -- PK,
    [_Master_ID] INT NOT NULL,
    [Product] VARCHAR(32) NOT NULL,
    [EmailType] INT NOT NULL,
    [Sent] SMALLDATETIME NOT NULL,
    [MailTo] VARCHAR(128) NOT NULL
);

CREATE TABLE [RatchetFeedPackage] (
    [rfp_ID] INT NOT NULL -- PK,
    [rfp_Name] VARCHAR(128) NOT NULL,
    [rfp_Cost] MONEY NOT NULL,
    [rfp_Sort] INT NOT NULL,
    [rfp_Active] BIT NOT NULL
);

CREATE TABLE [RatchetFeeds] (
    [rcc_ID] INT NOT NULL -- PK,
    [rcf_Created] DATETIME NOT NULL,
    [rcf_DateSold] DATETIME NOT NULL,
    [rcf_Cost] MONEY NOT NULL,
    [rcf_rft_ID] INT NOT NULL,
    [rcf_isLive] BIT NOT NULL,
    [rcf_Aggregator] VARCHAR(64) NOT NULL,
    [rfp_ID] INT NOT NULL,
    [rcf_Header] VARCHAR(256) NOT NULL,
    [rcf_Footer] VARCHAR(256) NOT NULL
);

CREATE TABLE [RatchetFormTypes] (
    [rft_ID] INT NOT NULL -- PK,
    [rft_Name] VARCHAR(128) NOT NULL,
    [rft_Sort] INT NOT NULL,
    [rft_Active] BIT NOT NULL,
    [rft_ShowOnFeed] BIT NOT NULL,
    [rft_ShowOnDisplay] BIT NOT NULL,
    [rft_ShowOnLocal] BIT NOT NULL
);

CREATE TABLE [RecyclerUTM] (
    [acc_ID] INT NOT NULL -- PK,
    [acc_TrackingCode] VARCHAR(256) NULL,
    [AccountID] VARCHAR(32) NULL
);

CREATE TABLE [ReportGeneratorLogs] (
    [executed] DATETIME NOT NULL -- PK,
    [jobid] VARCHAR(50) NOT NULL -- PK,
    [groupid] VARCHAR(50) NOT NULL,
    [success] BIT NOT NULL
);

CREATE TABLE [ResellerAccounts] (
    [acc_ID] INT NOT NULL -- PK,
    [rco_ID] INT NOT NULL,
    [rea_isAdmin] BIT NOT NULL,
    [rea_CreatedBy] INT NOT NULL,
    [rea_Created] DATETIME NOT NULL,
    [rea_ModifiedBy] INT NOT NULL,
    [rea_Modified] DATETIME NOT NULL,
    [rea_Active] BIT NOT NULL,
    [rea_Hidden] BIT NULL
);

CREATE TABLE [ResellerCompany] (
    [rco_ID] INT NOT NULL -- PK,
    [rct_ID] INT NOT NULL,
    [rco_CompanyName] VARCHAR(64) NULL,
    [rco_DisplayName] VARCHAR(64) NULL,
    [rco_Logo] VARCHAR(1024) NOT NULL,
    [rco_Created] DATETIME NOT NULL,
    [rco_CreatedBy] INT NOT NULL,
    [rco_Modified] DATETIME NOT NULL,
    [rco_ModifiedBy] INT NOT NULL,
    [rco_CompanyExpires] DATETIME NOT NULL,
    [rco_UsersExpire] DATETIME NOT NULL,
    [rco_Active] BIT NOT NULL,
    [rco_Phone] VARCHAR(16) NOT NULL,
    [rco_SupportEmail] VARCHAR(96) NULL,
    [rco_Domain] VARCHAR(128) NOT NULL
);

CREATE TABLE [ResellerCompanyCanUseService] (
    [rco_ID] INT NOT NULL -- PK,
    [svc_ID] INT NOT NULL -- PK,
    [acc_ID] INT NOT NULL,
    [rccus_Created] DATETIME NOT NULL
);

CREATE TABLE [ResellerCompanyType] (
    [rct_ID] INT NOT NULL -- PK,
    [rct_Name] VARCHAR(32) NOT NULL,
    [rct_Active] BIT NOT NULL
);

CREATE TABLE [ResellerReportSharing] (
    [rco_ID] INT NOT NULL -- PK,
    [rrs_File_Pattern] VARCHAR(256) NOT NULL,
    [rrs_Zip_Pattern] VARCHAR(256) NOT NULL,
    [rrs_Local_Folder] VARCHAR(256) NOT NULL,
    [rrs_FTP_Server] VARCHAR(256) NOT NULL,
    [rrs_FTP_Logon] VARCHAR(256) NOT NULL,
    [rrs_FTP_Password] VARCHAR(256) NOT NULL,
    [rrs_FTP_Folder] VARCHAR(256) NOT NULL,
    [rrs_Created] DATETIME NOT NULL
);

CREATE TABLE [ResellerToDisplayPaymentPlan] (
    [rco_ID] INT NOT NULL -- PK,
    [rpp_ID] INT NOT NULL -- PK
);

CREATE TABLE [ResllerAccountCompany] (
    [acc_ID] INT NOT NULL -- PK,
    [rco_ID] INT NOT NULL -- PK
);

CREATE TABLE [Rules] (
    [rule_id] INT NOT NULL -- PK,
    [rule_desc] VARCHAR(100) NOT NULL
);

CREATE TABLE [Salutation] (
    [sal_ID] INT NOT NULL -- PK,
    [sal_Name] VARCHAR(36) NOT NULL,
    [sal_Gender] VARCHAR(1) NOT NULL,
    [sal_Order] INT NOT NULL,
    [sal_Active] BIT NOT NULL
);

CREATE TABLE [SelfServeImage] (
    [lim_URL] VARCHAR(512) NULL
);

CREATE TABLE [SF_Accounts] (
    [ID] NVARCHAR(1024) NULL,
    [NAME] NVARCHAR(1024) NULL,
    [TYPE] NVARCHAR(1024) NULL,
    [PARENTID] NVARCHAR(1024) NULL,
    [BILLINGSTREET] NVARCHAR(1024) NULL,
    [BILLINGCITY] NVARCHAR(1024) NULL,
    [BILLINGSTATE] NVARCHAR(1024) NULL,
    [BILLINGPOSTALCODE] NVARCHAR(1024) NULL,
    [BILLINGCOUNTRY] NVARCHAR(1024) NULL,
    [PHONE] NVARCHAR(1024) NULL,
    [WEBSITE] NVARCHAR(1024) NULL,
    [IS_ACTIVE] NVARCHAR(1024) NULL,
    [PRIMARY_EMAIL_ADDRESS] NVARCHAR(1024) NULL
);

CREATE TABLE [SF_Leads] (
    [ID] NVARCHAR(512) NULL,
    [LASTNAME] NVARCHAR(512) NULL,
    [FIRSTNAME] NVARCHAR(512) NULL,
    [RECORDTYPEID] NVARCHAR(512) NULL,
    [COMPANY] NVARCHAR(512) NULL,
    [STREET] NVARCHAR(512) NULL,
    [CITY] NVARCHAR(512) NULL,
    [STATE] NVARCHAR(512) NULL,
    [POSTALCODE] NVARCHAR(512) NULL,
    [PHONE] NVARCHAR(512) NULL,
    [MOBILEPHONE] NVARCHAR(512) NULL,
    [EMAIL] NVARCHAR(512) NULL,
    [WEBSITE] NVARCHAR(512) NULL,
    [LEADSOURCE] NVARCHAR(512) NULL,
    [STATUS] NVARCHAR(512) NULL,
    [OWNERID] NVARCHAR(512) NULL,
    [CONVERTEDDATE] DATETIME2 NULL,
    [CONVERTEDACCOUNTID] NVARCHAR(512) NULL,
    [CONVERTEDCONTACTID] NVARCHAR(512) NULL,
    [CONVERTEDOPPORTUNITYID] NVARCHAR(512) NULL,
    [CREATEDDATE] DATETIME2 NOT NULL,
    [CREATEDBYID] NVARCHAR(512) NOT NULL,
    [LASTMODIFIEDDATE] DATETIME2 NOT NULL,
    [LASTMODIFIEDBYID] NVARCHAR(512) NOT NULL,
    [SYSTEMMODSTAMP] DATETIME2 NOT NULL,
    [LASTACTIVITYDATE] NVARCHAR(512) NULL,
    [LASTTRANSFERDATE] DATETIME2 NOT NULL,
    [PI__CONVERSION_DATE__C] DATETIME2 NULL,
    [PI__CREATED_DATE__C] DATETIME2 NULL,
    [PI__FIRST_ACTIVITY__C] DATETIME2 NULL,
    [PI__LAST_ACTIVITY__C] DATETIME2 NULL,
    [LEAD_OWNER_ID__C] NVARCHAR(512) NULL,
    [NO_ACTIVITY_FOR_15__C] BIT NULL,
    [X18_DIGIT_ID__C] NVARCHAR(512) NULL,
    [RECORD_TYPE_ID__C] NVARCHAR(512) NULL,
    [I__CREATEDFORUSER__C] NVARCHAR(512) NULL,
    [SOURCE_DATE__C] DATETIME2 NULL,
    [DATE_LEAD_SOURCE_LAST_UPDATED__C] DATETIME2 NULL,
    [DATE_EVENT_NAME_LAST_UPDATED__C] DATETIME2 NULL,
    [X18_CHARACTER_ID__C] NVARCHAR(512) NULL
);

CREATE TABLE [sf_sales_reps] (
    [username] VARCHAR(64) NULL,
    [id] VARCHAR(64) NULL,
    [lastname] VARCHAR(64) NULL,
    [firstname] VARCHAR(64) NULL
);

CREATE TABLE [SF_to_Advertiser_Mapping] (
    [id] VARCHAR(64) NULL,
    [adv_id] BIGINT NULL
);

CREATE TABLE [Shortener] (
    [id] UNIQUEIDENTIFIER NOT NULL -- PK,
    [customkey] VARCHAR(50) NULL,
    [url] VARCHAR(8000) NOT NULL,
    [entered] DATETIME NOT NULL,
    [indexkey] INT NULL,
    [groupkey] VARCHAR(50) NULL
);

CREATE TABLE [SmartAd_ChoiceDefaults] (
    [accountid] VARCHAR(32) NOT NULL -- PK,
    [keyword] VARCHAR(256) NULL
);

CREATE TABLE [SmartAd_Choices] (
    [accountid] VARCHAR(32) NOT NULL,
    [listingid] INT NOT NULL -- PK
);

CREATE TABLE [SmartAdCheck] (
    [CampaignId] INT NOT NULL,
    [CampaignName] VARCHAR(250) NOT NULL,
    [SolrUrl] VARCHAR(250) NOT NULL,
    [AdUnitUrl] VARCHAR(250) NOT NULL,
    [SolrCount] INT NOT NULL,
    [Checked] DATETIME NOT NULL,
    [AccId] INT NOT NULL,
    [RcdMasterId] INT NOT NULL,
    [SameImages] BIT NULL,
    [MissingUtm] BIT NULL
);

CREATE TABLE [smartadcheck_joined] (
    [adv_acc_id] BIGINT NULL,
    [ratchet_id] BIGINT NULL,
    [cmp_id] BIGINT NULL,
    [subscription_id] BIGINT NULL,
    [sc_aso_id] BIGINT NULL,
    [sales_channel] VARCHAR(128) NULL,
    [adv_name] VARCHAR(128) NULL,
    [sub_name] VARCHAR(256) NULL,
    [end_date] DATE NULL,
    [captured] DATETIME NOT NULL,
    [SolrURL] VARCHAR(250) NOT NULL,
    [SolrCount] INT NOT NULL,
    [AdUnitURL] VARCHAR(250) NOT NULL
);

CREATE TABLE [SmartAdListings] (
    [acc_ID] INT NULL,
    [lst_ID] INT NULL,
    [veh_vin] VARCHAR(256) NULL,
    [veh_stock] VARCHAR(32) NULL,
    [rdpr_InventoryURL] VARCHAR(256) NULL
);

CREATE TABLE [SmartPowerInventory] (
    [acc_id] INT NOT NULL -- PK,
    [name] VARCHAR(128) NOT NULL,
    [active] BIT NOT NULL
);

CREATE TABLE [SmartPowerNotes] (
    [acc_id] INT NOT NULL -- PK,
    [created] DATETIME NOT NULL -- PK,
    [created_by] INT NOT NULL,
    [created_by_name] VARCHAR(128) NOT NULL,
    [notes] TEXT NOT NULL
);

CREATE TABLE [SortedListing] (
    [sort_id] INT NOT NULL,
    [lst_id] INT NULL,
    [clb_code] VARCHAR(5) NULL,
    [clsb_code] VARCHAR(5) NULL
);

CREATE TABLE [SortedPosting] (
    [sort_id] INT NOT NULL,
    [clp_posting_id] VARCHAR(128) NULL,
    [clb_code] VARCHAR(5) NULL,
    [clsb_code] VARCHAR(5) NULL
);

CREATE TABLE [Source] (
    [src_ID] INT NOT NULL -- PK,
    [src_Name] VARCHAR(32) NOT NULL,
    [src_SiteName] VARCHAR(128) NULL,
    [src_URLRoot] VARCHAR(128) NULL,
    [src_URLImageSelfServe] VARCHAR(512) NULL,
    [src_URLFAQS] VARCHAR(128) NULL,
    [src_URLHELP] VARCHAR(128) NULL,
    [src_URLDetails] VARCHAR(128) NULL,
    [src_mail_FromName] VARCHAR(64) NULL,
    [src_mail_FromAddress] VARCHAR(128) NULL,
    [src_mail_CCAddress] VARCHAR(128) NULL,
    [src_BannerImageUrl] VARCHAR(512) NULL,
    [src_ProfilePath] VARCHAR(256) NULL,
    [src_ImagePath] VARCHAR(512) NULL,
    [src_BannersPath] VARCHAR(256) NULL,
    [src_SelfServe] BIT NOT NULL,
    [src_isFeed] BIT NOT NULL,
    [src_ADF_ID] VARCHAR(256) NULL,
    [src_Leads_ToAddress] VARCHAR(128) NULL,
    [src_Leads_PostURL] VARCHAR(128) NULL,
    [src_Leads_PhoneRequired] BIT NOT NULL,
    [src_Exclude_OBF] BIT NOT NULL,
    [src_Skip_Proofing] BIT NOT NULL,
    [src_ResellerLogoPath] VARCHAR(512) NULL,
    [src_ResellerFromMail] VARCHAR(128) NULL,
    [src_Site] INT NULL,
    [src_KeepAliveDays] INT NULL,
    [src_AllBusiness] BIT NULL
);

CREATE TABLE [SourceOptions] (
    [sop_ID] INT NOT NULL -- PK,
    [src_ID] INT NOT NULL,
    [option_ID] INT NOT NULL,
    [option_Value] VARCHAR(50) NOT NULL
);

CREATE TABLE [SQLInjectionCheck] (
    [Table_Column] VARCHAR(512) NULL,
    [Rows_Infected] INT NULL
);

CREATE TABLE [State] (
    [stt_ID] VARCHAR(2) NOT NULL -- PK,
    [stt_Name] VARCHAR(64) NULL,
    [stt_InAmerica] BIT NOT NULL
);

CREATE TABLE [SubClass] (
    [scl_ID] INT NOT NULL -- PK,
    [cls_ID] INT NOT NULL,
    [scl_Name] VARCHAR(64) NOT NULL,
    [scl_NameFull] VARCHAR(64) NOT NULL,
    [scl_NamePartial] VARCHAR(64) NOT NULL,
    [scl_Order] INT NOT NULL,
    [fed_CatName1] VARCHAR(256) NULL,
    [clt_ID] INT NOT NULL,
    [prq_ID] INT NULL,
    [scl_URLExpand] TINYINT NULL,
    [old_sclid] INT NULL,
    [scl_Order_Mobile] INT NULL,
    [scl_isInstant_New_rrg_ID] INT NOT NULL,
    [scl_isInstant_Renew_rrg_ID] INT NOT NULL,
    [fed_ID1] INT NULL,
    [fed_keyword1] VARCHAR(256) NULL
);

CREATE TABLE [SubscriptionListing] (
    [subscription_id] INT NOT NULL,
    [llst_id] INT NOT NULL,
    [lacc_ID] INT NULL,
    [scl_id] INT NOT NULL,
    [llst_Title] VARCHAR(128) NOT NULL,
    [llst_OnlineText] VARCHAR(8000) NOT NULL,
    [llst_Price] MONEY NOT NULL,
    [llst_Created] DATETIME NOT NULL,
    [llst_LastUpload] DATETIME NULL,
    [llst_Images] VARCHAR(8000) NULL,
    [veh_vin] VARCHAR(32) NULL,
    [veh_stock] VARCHAR(32) NULL,
    [veh_bodytype] VARCHAR(64) NULL,
    [veh_year] VARCHAR(4) NULL,
    [veh_make] VARCHAR(64) NULL,
    [veh_model] VARCHAR(64) NULL,
    [veh_trim] VARCHAR(128) NULL,
    [veh_status] VARCHAR(32) NULL,
    [veh_mileage] VARCHAR(32) NULL,
    [veh_cylinders] VARCHAR(64) NULL,
    [veh_displacement] VARCHAR(64) NULL,
    [veh_induction] VARCHAR(64) NULL,
    [veh_transmission] VARCHAR(64) NULL,
    [veh_drivetrain] VARCHAR(32) NULL,
    [veh_exteriorcolor] VARCHAR(128) NULL,
    [veh_interiorcolor] VARCHAR(128) NULL,
    [veh_condition] VARCHAR(32) NULL,
    [veh_doors] VARCHAR(8) NULL,
    [veh_fuelcity] VARCHAR(32) NULL,
    [veh_fuelhighway] VARCHAR(32) NULL,
    [veh_fueltype] VARCHAR(32) NULL,
    [veh_carfax] VARCHAR(32) NULL,
    [veh_comments] VARCHAR(4096) NULL,
    [veh_warranty] VARCHAR(32) NULL,
    [veh_warrantyterms] VARCHAR(128) NULL,
    [veh_sellertype] VARCHAR(16) NULL,
    [veh_Options] VARCHAR(4096) NULL
);

CREATE TABLE [sysdiagrams] (
    [name] NVARCHAR(128) NOT NULL,
    [principal_id] INT NOT NULL,
    [diagram_id] INT NOT NULL -- PK,
    [version] INT NULL,
    [definition] VARBINARY(MAX) NULL
);

CREATE TABLE [Tables_Sizes] (
    [rec_id] INT NOT NULL,
    [table_name] VARCHAR(128) NULL,
    [nbr_of_rows] INT NULL,
    [data_space] DECIMAL(15,2) NULL,
    [index_space] DECIMAL(15,2) NULL,
    [total_size] DECIMAL(15,2) NULL,
    [percent_of_db] DECIMAL(15,12) NULL,
    [db_size] DECIMAL(15,2) NULL,
    [created] DATE NULL,
    [modified] DATE NULL,
    [ok_truncate] BIT NULL
);

CREATE TABLE [target_reps] (
    [das_name] VARCHAR(64) NULL,
    [das_email] VARCHAR(64) NULL,
    [tmp_name] VARCHAR(64) NULL
);

CREATE TABLE [Temp_FeedAccounts] (
    [fac_id] INT NOT NULL,
    [src_id] INT NOT NULL,
    [src_cusid] VARCHAR(32) NOT NULL,
    [fac_company] VARCHAR(64) NOT NULL,
    [fac_email_string] VARCHAR(128) NOT NULL,
    [fac_email_xml] VARCHAR(128) NOT NULL,
    [fac_url] VARCHAR(512) NULL,
    [fac_phone] VARCHAR(16) NOT NULL,
    [fac_altphone] VARCHAR(16) NOT NULL,
    [fac_address] VARCHAR(64) NOT NULL,
    [fac_city] VARCHAR(64) NOT NULL,
    [fac_state] VARCHAR(2) NOT NULL,
    [fac_zip_code] VARCHAR(5) NOT NULL,
    [fac_image] VARCHAR(512) NULL,
    [fac_lasupload] DATETIME NOT NULL,
    [fac_active] BIT NOT NULL,
    [acc_id] INT NULL,
    [fac_firstname] VARCHAR(32) NOT NULL,
    [fac_lastname] VARCHAR(32) NOT NULL,
    [fac_description] VARCHAR(256) NOT NULL,
    [fac_extension] VARCHAR(10) NOT NULL
);

CREATE TABLE [Temp_FeedListingProperty] (
    [fac_id] INT NOT NULL,
    [src_id] INT NOT NULL,
    [src_cusid] VARCHAR(32) NOT NULL,
    [acc_id] INT NULL,
    [src_adid] VARCHAR(32) NULL,
    [fli_id] INT NOT NULL,
    [prp_address] VARCHAR(64) NULL,
    [zip_code] VARCHAR(5) NULL,
    [prp_condition] VARCHAR(32) NULL,
    [prp_bedrooms] VARCHAR(32) NULL,
    [prp_bathrooms] VARCHAR(32) NULL,
    [prp_pet_policy] VARCHAR(32) NULL,
    [prp_type] VARCHAR(32) NULL,
    [prp_square_feet] VARCHAR(32) NULL,
    [prp_style] VARCHAR(32) NULL,
    [prp_parking] VARCHAR(32) NULL,
    [prp_available] VARCHAR(32) NULL,
    [prp_furnishing] VARCHAR(1024) NULL,
    [prp_year_built] VARCHAR(4) NULL,
    [prp_mls_number] VARCHAR(32) NULL,
    [prp_city] VARCHAR(64) NULL,
    [prp_seller_type] VARCHAR(32) NULL,
    [prp_on_site] VARCHAR(32) NULL
);

CREATE TABLE [Temp_FeedListings] (
    [fac_id] INT NOT NULL,
    [src_id] INT NOT NULL,
    [src_cusid] VARCHAR(32) NOT NULL,
    [acc_id] INT NULL,
    [src_adid] VARCHAR(32) NULL,
    [fli_id] BIGINT NOT NULL,
    [fli_scl_id] INT NOT NULL,
    [fli_zip_code] VARCHAR(5) NOT NULL,
    [fli_title] VARCHAR(128) NOT NULL,
    [fli_onlinetext] VARCHAR(8000) NOT NULL,
    [fli_price] MONEY NOT NULL,
    [fli_phone] VARCHAR(16) NOT NULL,
    [fli_extension] VARCHAR(10) NOT NULL,
    [fli_lastupload] DATETIME NOT NULL,
    [fls_ID] INT NOT NULL,
    [lst_ID] INT NULL,
    [fli_Options] VARCHAR(256) NULL,
    [fli_HighLights] VARCHAR(1024) NULL,
    [fli_Images] VARCHAR(8000) NULL,
    [fli_VDP] VARCHAR(256) NULL
);

CREATE TABLE [Temp_FeedListings_Keepers] (
    [fac_id] INT NOT NULL,
    [src_id] INT NOT NULL,
    [src_cusid] VARCHAR(32) NOT NULL,
    [acc_id] INT NULL,
    [fli_id] BIGINT NOT NULL,
    [src_adid] VARCHAR(32) NULL,
    [fls_ID] INT NOT NULL,
    [lst_ID] INT NULL,
    [fli_Options] VARCHAR(256) NULL,
    [fli_HighLights] VARCHAR(1024) NULL,
    [fli_Images] VARCHAR(8000) NULL,
    [fli_VDP] VARCHAR(256) NULL
);

CREATE TABLE [Temp_FeedListingVehicle] (
    [fac_id] INT NOT NULL,
    [src_id] INT NOT NULL,
    [src_cusid] VARCHAR(32) NOT NULL,
    [acc_id] INT NULL,
    [src_adid] VARCHAR(32) NULL,
    [fli_id] BIGINT NOT NULL,
    [veh_vin] VARCHAR(32) NULL,
    [veh_stock] VARCHAR(32) NULL,
    [veh_bodytype] VARCHAR(64) NULL,
    [veh_year] VARCHAR(4) NULL,
    [veh_make] VARCHAR(64) NULL,
    [veh_model] VARCHAR(64) NULL,
    [veh_trim] VARCHAR(128) NULL,
    [veh_status] VARCHAR(32) NULL,
    [veh_mileage] VARCHAR(32) NULL,
    [veh_cylinders] VARCHAR(64) NULL,
    [veh_displacement] VARCHAR(64) NULL,
    [veh_induction] VARCHAR(64) NULL,
    [veh_transmission] VARCHAR(64) NULL,
    [veh_drivetrain] VARCHAR(32) NULL,
    [veh_exteriorcolor] VARCHAR(128) NULL,
    [veh_interiorcolor] VARCHAR(128) NULL,
    [veh_condition] VARCHAR(32) NULL,
    [veh_doors] VARCHAR(8) NULL,
    [veh_fuelcity] VARCHAR(32) NULL,
    [veh_fuelhighway] VARCHAR(32) NULL,
    [veh_fueltype] VARCHAR(32) NULL,
    [veh_carfax] VARCHAR(32) NULL,
    [veh_comments] VARCHAR(4096) NULL,
    [veh_warranty] VARCHAR(32) NULL,
    [veh_warrantyterms] VARCHAR(128) NULL,
    [veh_sellertype] VARCHAR(16) NULL,
    [veh_Options] VARCHAR(4096) NULL
);

CREATE TABLE [TempDMA] (
    [zip_code] VARCHAR(5) NULL,
    [dma_code] VARCHAR(5) NULL,
    [dma_name] VARCHAR(256) NULL
);

CREATE TABLE [TMPiServices] (
    [svc_ID] INT NOT NULL -- PK,
    [svc_Name] VARCHAR(32) NOT NULL,
    [svc_Active] BIT NOT NULL,
    [svc_Sort] INT NOT NULL
);

CREATE TABLE [TwilioNumbers] (
    [acc_id] INT NOT NULL -- PK,
    [twilio_number] VARCHAR(10) NOT NULL
);

CREATE TABLE [UserAlert] (
    [ua_id] INT NOT NULL -- PK,
    [ua_message] NVARCHAR(MAX) NULL,
    [ua_level] NVARCHAR(50) NULL,
    [ua_type] INT NULL,
    [ua_created] DATETIME NULL,
    [ua_last_updated] DATETIME NULL,
    [ua_created_by] INT NULL,
    [ua_last_modified_by] INT NULL,
    [ua_active] BIT NULL
);

CREATE TABLE [ValidCharacter] (
    [vac_ID] INT NOT NULL -- PK,
    [vac_Character] VARCHAR(1) NOT NULL,
    [vac_Code] INT NOT NULL,
    [vac_Type] VARCHAR(1) NOT NULL
);

CREATE TABLE [VastPhoneData] (
    [vpd_ID] BIGINT NOT NULL -- PK,
    [acc_ID] INT NULL,
    [fduid] INT NULL,
    [caller_number] VARCHAR(19) NULL,
    [caller_name] VARCHAR(23) NULL,
    [call_id] VARCHAR(20) NULL,
    [inbound_no] VARCHAR(32) NULL,
    [forward_no] VARCHAR(14) NULL,
    [account_id] VARCHAR(20) NULL,
    [group_id] VARCHAR(20) NULL,
    [campaign_id] VARCHAR(20) NULL,
    [a_name] VARCHAR(128) NULL,
    [g_name] VARCHAR(12) NULL,
    [c_name] VARCHAR(65) NULL,
    [call_s] DATETIME NULL,
    [duration] VARCHAR(24) NULL,
    [answer_offset] VARCHAR(24) NULL,
    [call_status] VARCHAR(128) NULL,
    [LeadCost] MONEY NULL
);

CREATE TABLE [VDPDashboard] (
    [subscriptionid] INT NOT NULL -- PK,
    [cmpname] VARCHAR(512) NOT NULL -- PK,
    [lastmodified] DATETIME NOT NULL,
    [mrr] DECIMAL(10,2) NULL,
    [goal] INT NULL,
    [notes] VARCHAR(MAX) NULL
);

CREATE TABLE [VDPDashboard_DailySnapshots] (
    [SnapshotId] INT NOT NULL -- PK,
    [SnapshotDate] DATE NOT NULL,
    [SalesChannel] NVARCHAR(100) NULL,
    [AccountId] BIGINT NOT NULL,
    [ClientName] NVARCHAR(200) NULL,
    [Name] NVARCHAR(200) NOT NULL,
    [Impressions] INT NOT NULL,
    [Clicks] INT NOT NULL,
    [VdpViews] INT NOT NULL,
    [Cost] DECIMAL(18,4) NOT NULL,
    [YesterdayImpressions] INT NOT NULL,
    [YesterdayClicks] INT NOT NULL,
    [YesterdayVdps] INT NOT NULL,
    [YesterdayCost] DECIMAL(18,4) NOT NULL,
    [SubscriptionId] INT NOT NULL,
    [SfId] INT NOT NULL,
    [CmpId] INT NOT NULL,
    [Mrr] DECIMAL(18,4) NOT NULL,
    [Goal] INT NOT NULL,
    [Notes] NVARCHAR(MAX) NULL,
    [UniqueId] NVARCHAR(221) NULL
);

CREATE TABLE [VDPdomain_Mismatch] (
    [adv_acc_id] BIGINT NULL,
    [adv_name] VARCHAR(128) NULL,
    [Webcrawler_domain] VARCHAR(1024) NULL,
    [rdp_domain] VARCHAR(1024) NULL
);

CREATE TABLE [ViewHistory] (
    [lYearMonth] INT NOT NULL,
    [lst_id] INT NOT NULL,
    [zip_code] VARCHAR(5) NOT NULL,
    [scl_id] INT NOT NULL,
    [scl_name] VARCHAR(64) NOT NULL,
    [lst_Year] VARCHAR(128) NULL,
    [lst_Make] VARCHAR(128) NULL,
    [lst_Model] VARCHAR(128) NULL,
    [adtTotal] INT NOT NULL
);

CREATE TABLE [vin_digit] (
    [digit] VARCHAR(1) NOT NULL -- PK,
    [value] INT NOT NULL
);

CREATE TABLE [VIN_Existing] (
    [_lstID] INT NOT NULL,
    [Created] DATETIME NOT NULL,
    [_SubClass] VARCHAR(64) NOT NULL,
    [_Price] MONEY NOT NULL,
    [_Year] VARCHAR(128) NOT NULL,
    [_Make] VARCHAR(128) NOT NULL,
    [_Model] VARCHAR(128) NOT NULL,
    [_SubModel] VARCHAR(128) NULL,
    [_VIN] VARCHAR(128) NOT NULL,
    [_Color] VARCHAR(128) NULL,
    [_Int_Color] VARCHAR(128) NULL,
    [_Doors] VARCHAR(128) NULL,
    [_Cylinders] VARCHAR(128) NULL,
    [_Transmission] VARCHAR(128) NULL,
    [_Displacement] VARCHAR(128) NULL,
    [_FuelType] VARCHAR(128) NULL,
    [_Drivetrain] VARCHAR(128) NULL,
    [_FuelHighway] VARCHAR(128) NULL,
    [_FuelCity] VARCHAR(128) NULL,
    [_Induction] VARCHAR(128) NULL,
    [_Verified] INT NULL
);

CREATE TABLE [vin_weight] (
    [position] INT NOT NULL -- PK,
    [weight] INT NOT NULL
);

CREATE TABLE [VINCheck] (
    [lst_id] INT NOT NULL,
    [src_id] INT NOT NULL,
    [src_adid] VARCHAR(32) NULL,
    [scl_id] INT NOT NULL,
    [scl_name] VARCHAR(64) NOT NULL,
    [lst_VIN] VARCHAR(32) NULL,
    [lst_Year] VARCHAR(4) NULL,
    [lst_Make] VARCHAR(64) NULL
);

CREATE TABLE [VINDecode_Results] (
    [veh_VIN] VARCHAR(17) NULL,
    [response] VARCHAR(MAX) NULL
);

CREATE TABLE [WastedSlots] (
    [captured] DATETIME NOT NULL,
    [clb_code] VARCHAR(5) NULL,
    [clsb_code] VARCHAR(5) NULL,
    [WastedSlots] INT NULL,
    [n_clp_expires] DATE NULL,
    [x_clp_expires] DATE NULL
);

CREATE TABLE [WCD] (
    [job_domain] VARCHAR(128) NULL,
    [job_lastexecution] DATETIME NULL,
    [veh_vin] VARCHAR(256) NULL,
    [veh_url] VARCHAR(1024) NULL,
    [DataSource] VARCHAR(256) NULL,
    [veh_stock] VARCHAR(32) NULL
);

CREATE TABLE [WebCrawlerData] (
    [job_domain] VARCHAR(128) NOT NULL -- PK,
    [job_lastexecution] DATETIME NULL,
    [veh_vin] VARCHAR(256) NOT NULL -- PK,
    [veh_url] VARCHAR(1024) NOT NULL,
    [DataSource] VARCHAR(256) NULL,
    [veh_stock] VARCHAR(32) NOT NULL -- PK,
    [acc_ID] INT NOT NULL -- PK,
    [lst_ID] INT NOT NULL
);

CREATE TABLE [WebCrawlerData_Temp] (
    [job_domain] VARCHAR(128) NOT NULL,
    [job_lastexecution] DATETIME NULL,
    [veh_vin] VARCHAR(256) NOT NULL,
    [veh_url] VARCHAR(1024) NOT NULL,
    [DataSource] VARCHAR(256) NULL,
    [veh_stock] VARCHAR(32) NOT NULL,
    [acc_ID] INT NOT NULL,
    [lst_ID] INT NOT NULL
);

CREATE TABLE [WebCrawlerDeletes] (
    [Captured] DATETIME NULL,
    [DeleteCount] INT NULL,
    [DeleteReason] VARCHAR(64) NULL
);

CREATE TABLE [WebCrawlerImport] (
    [wcid] BIGINT NOT NULL -- PK,
    [veh_ID] BIGINT NOT NULL,
    [job_domain] VARCHAR(128) NOT NULL,
    [job_lastexecution] DATETIME NULL,
    [veh_vin] VARCHAR(256) NOT NULL,
    [veh_url] VARCHAR(1024) NOT NULL,
    [veh_stock] VARCHAR(32) NOT NULL
);

CREATE TABLE [WebCrawlerImportSummary] (
    [wcs_ID] BIGINT NOT NULL,
    [Captured] DATETIME NOT NULL,
    [job_Domain] VARCHAR(128) NOT NULL,
    [job_Lastexecution] DATETIME NULL,
    [veh_Count] INT NULL,
    [withVIN] INT NULL,
    [withStock] INT NULL
);

CREATE TABLE [WebCrawlerTemp] (
    [ID] BIGINT NOT NULL -- PK,
    [job_domain] VARCHAR(128) NULL,
    [job_lastexecution] DATETIME NULL,
    [veh_vin] VARCHAR(256) NULL,
    [veh_url] VARCHAR(1024) NULL,
    [DataSource] VARCHAR(256) NULL,
    [veh_stock] VARCHAR(32) NULL,
    [acc_ID] INT NULL,
    [lst_ID] INT NULL,
    [SyncAction] VARCHAR(32) NULL
);

CREATE TABLE [XferGroups] (
    [xfg_ID] INT NOT NULL -- PK,
    [xfg_Name] VARCHAR(128) NOT NULL,
    [pub_ID] INT NOT NULL,
    [xfg_Interval] INT NULL,
    [xfg_StartDateTime] SMALLDATETIME NULL,
    [xfg_PrintPattern] VARCHAR(128) NULL,
    [xfg_MaxCharacters] INT NULL,
    [xfg_MaxLeadinCharacters] INT NULL
);

CREATE TABLE [XferLog] (
    [xfr_ID] INT NOT NULL -- PK,
    [lst_ID] INT NOT NULL,
    [acc_ID] INT NOT NULL,
    [xfg_ID] INT NOT NULL,
    [xfr_CusID] INT NULL,
    [xfr_AdNum] INT NULL,
    [xfr_EdIDs] VARCHAR(128) NOT NULL,
    [xfr_eclsNumber] INT NOT NULL,
    [xfr_EdType] INT NULL,
    [xfr_AdText] VARCHAR(1024) NOT NULL,
    [xfr_Price] MONEY NOT NULL,
    [xfr_Phone] VARCHAR(16) NOT NULL,
    [xfr_NoPhone] BIT NOT NULL,
    [xfr_Boxed] BIT NOT NULL,
    [xfr_Photo] BIT NOT NULL,
    [xfr_Headline] VARCHAR(255) NOT NULL,
    [xfr_Date] DATETIME NOT NULL,
    [xfr_Status] INT NOT NULL,
    [xfr_Comment] VARCHAR(256) NOT NULL,
    [xfr_FileFullDate] DATETIME NULL
);

CREATE TABLE [XML_CRMEmails] (
    [xml_User] VARCHAR(256) NULL,
    [xml_Domain] VARCHAR(256) NULL,
    [xml_Root] VARCHAR(1024) NULL
);

CREATE TABLE [XMLDump] (
    [xdu_ID] INT NOT NULL -- PK,
    [xdu_URL] VARCHAR(512) NOT NULL,
    [xdu_SaveToFolder] VARCHAR(512) NOT NULL,
    [xdu_SaveAsName] VARCHAR(512) NOT NULL,
    [xdu_LastPull] DATETIME NOT NULL,
    [xdu_LastResponse] VARCHAR(512) NOT NULL
);

CREATE TABLE [xmldump2] (
    [xdu_ID] INT NOT NULL,
    [xdu_URL] VARCHAR(512) NOT NULL,
    [xdu_SaveToFolder] VARCHAR(512) NOT NULL,
    [xdu_SaveAsName] VARCHAR(512) NOT NULL,
    [xdu_LastPull] DATETIME NOT NULL,
    [xdu_LastResponse] VARCHAR(512) NOT NULL
);

CREATE TABLE [XMLImportFile] (
    [xmlFileName] VARCHAR(8000) NOT NULL,
    [xml_data] VARCHAR(MAX) NOT NULL
);

CREATE TABLE [ZipCode] (
    [zip_Code] VARCHAR(10) NOT NULL -- PK,
    [zip_City] VARCHAR(32) NOT NULL,
    [stt_ID] VARCHAR(2) NOT NULL,
    [zip_Latitude] FLOAT NOT NULL,
    [zip_Longitude] FLOAT NOT NULL,
    [zip_Radius] INT NOT NULL,
    [AREACODE] VARCHAR(3) NULL,
    [dma_Code] VARCHAR(5) NULL,
    [Within100] VARCHAR(MAX) NULL,
    [clb_Code] VARCHAR(5) NOT NULL,
    [clsb_Code] VARCHAR(5) NOT NULL,
    [CountyName] VARCHAR(128) NULL,
    [zip_TZ] VARCHAR(8) NULL,
    [zip_UTC] INT NULL
);

CREATE TABLE [ZipCounty] (
    [id] INT NOT NULL,
    [zip_code] VARCHAR(5) NOT NULL,
    [zip_city] VARCHAR(32) NOT NULL,
    [stt_id] VARCHAR(2) NOT NULL,
    [clb_Code] VARCHAR(5) NULL,
    [countyname] VARCHAR(128) NULL,
    [zpoppct] VARCHAR(50) NULL
);

CREATE TABLE [ZipNFTP] (
    [znf_ID] INT NOT NULL -- PK,
    [znf_Server] NVARCHAR(128) NOT NULL,
    [znf_DB] NVARCHAR(32) NOT NULL,
    [znf_Path] NVARCHAR(256) NOT NULL,
    [znf_File] NVARCHAR(256) NOT NULL,
    [znf_FTPServer] NVARCHAR(32) NOT NULL,
    [znf_FTPUser] NVARCHAR(32) NOT NULL,
    [znf_FTPPassword] NVARCHAR(32) NOT NULL,
    [znf_Status] INT NOT NULL,
    [znf_Created] DATETIME NOT NULL,
    [znf_Zip] DATETIME NULL,
    [znf_FTP] DATETIME NULL
);

CREATE TABLE [ZipPublications] (
    [zip_code] VARCHAR(5) NOT NULL -- PK,
    [pub_id] INT NOT NULL
);

CREATE TABLE [zipxml] (
    [zip_Code] VARCHAR(5) NULL,
    [XML_Response] VARCHAR(8000) NULL
);

CREATE TABLE [znfStatus] (
    [znf_Status] INT NOT NULL -- PK,
    [znf_StatusName] VARCHAR(32) NOT NULL
);

CREATE TABLE [zzz__ADRefresh_RoleChange] (
    [acc_ID] INT NOT NULL,
    [arl_ID] INT NOT NULL,
    [ChangeDate] DATETIME NULL
);

CREATE TABLE [zzz__ADRefresh_Terminated] (
    [ADLogin] VARCHAR(64) NULL,
    [ADName] VARCHAR(128) NULL,
    [ADEmail] VARCHAR(128) NULL,
    [Terminated] DATETIME NOT NULL
);

CREATE TABLE [zzz__Alerts] (
    [alt_id] INT NOT NULL -- PK,
    [priority] INT NOT NULL,
    [assign] INT NULL,
    [subject] VARCHAR(250) NULL,
    [message] TEXT NULL,
    [status] VARCHAR(50) NOT NULL,
    [generated] DATETIME NOT NULL,
    [adv_acc_id] INT NOT NULL,
    [cmp_id] INT NOT NULL,
    [alt_source] VARCHAR(64) NULL
);

CREATE TABLE [zzz__AlertsAssignee] (
    [acc_id] INT NOT NULL -- PK,
    [acc_email] VARCHAR(250) NOT NULL,
    [acc_name] VARCHAR(100) NOT NULL,
    [acc_image] VARCHAR(100) NOT NULL,
    [manager] INT NULL
);

CREATE TABLE [zzz__AlertsLabels] (
    [alt_label_id] INT NOT NULL -- PK,
    [alt_id] INT NOT NULL,
    [label] VARCHAR(256) NOT NULL,
    [label_type] INT NULL
);

CREATE TABLE [zzz__AlertsMeta] (
    [alt_meta_id] INT NOT NULL -- PK,
    [alt_id] NCHAR(10) NULL,
    [alt_key] VARCHAR(250) NOT NULL,
    [alt_value] VARCHAR(1000) NULL,
    [alt_sort] INT NOT NULL
);

CREATE TABLE [zzz__AlertsNotes] (
    [alt_notes_id] INT NOT NULL -- PK,
    [alt_id] INT NOT NULL,
    [type_id] INT NOT NULL,
    [entered] DATETIME NOT NULL,
    [submitted] INT NOT NULL,
    [note] TEXT NOT NULL
);

CREATE TABLE [zzz__AlertsNoteType] (
    [type_id] INT NOT NULL -- PK,
    [description] VARCHAR(50) NOT NULL
);

CREATE TABLE [zzz__AutoHomePageShowcase] (
    [ahp_ID] INT NOT NULL -- PK,
    [lst_ID] INT NOT NULL,
    [gdID] INT NOT NULL,
    [ahp_Created] DATETIME NOT NULL,
    [ahp_Removed] DATETIME NULL
);

CREATE TABLE [zzz__ListingDuration] (
    [acc_id] INT NULL,
    [lst_id] INT NOT NULL,
    [lst_created] DATETIME NOT NULL,
    [lastupload] DATETIME NULL
);

CREATE TABLE [zzz__SilverPop] (
    [acc_id] INT NOT NULL,
    [acc_modified] VARCHAR(16) NULL,
    [acc_lastlogin] VARCHAR(16) NULL,
    [acc_created] VARCHAR(16) NULL,
    [acc_email_string] VARCHAR(128) NOT NULL,
    [acc_firstname] VARCHAR(32) NOT NULL,
    [acc_lastname] VARCHAR(32) NOT NULL,
    [zip_code] VARCHAR(5) NOT NULL,
    [src_name] VARCHAR(32) NOT NULL,
    [OptIn] VARCHAR(16) NULL,
    [OptedOut] VARCHAR(16) NULL,
    [Dealer] INT NOT NULL,
    [Commercial] INT NOT NULL,
    [Newsletter] INT NOT NULL,
    [Announcements] INT NOT NULL,
    [PromorOffers] INT NOT NULL,
    [Seller] INT NOT NULL,
    [Buyer] INT NOT NULL,
    [NumberOfAds] INT NOT NULL,
    [TotalAdsSubmitted] INT NOT NULL,
    [MaxAdCreated] VARCHAR(16) NULL,
    [Cars] INT NOT NULL,
    [Pets] INT NOT NULL,
    [ForSale] INT NOT NULL,
    [Music] INT NOT NULL,
    [Sports] INT NOT NULL,
    [ForRent] INT NOT NULL,
    [RealEstate] INT NOT NULL,
    [Community] INT NOT NULL,
    [Services] INT NOT NULL,
    [Wanted] INT NOT NULL,
    [acc_GUID] UNIQUEIDENTIFIER NOT NULL,
    [acc_Verified] BIT NOT NULL
);

CREATE TABLE [zzz__SilverPopAccounts] (
    [acc_id] INT NOT NULL,
    [acc_modified] VARCHAR(16) NULL,
    [acc_lastlogin] VARCHAR(16) NULL,
    [acc_created] VARCHAR(16) NULL,
    [acc_email_string] VARCHAR(128) NOT NULL,
    [acc_firstname] VARCHAR(32) NOT NULL,
    [acc_lastname] VARCHAR(32) NOT NULL,
    [zip_code] VARCHAR(5) NOT NULL,
    [src_name] VARCHAR(32) NOT NULL,
    [arl_id] INT NOT NULL,
    [acc_GUID] UNIQUEIDENTIFIER NOT NULL,
    [acc_Verified] BIT NOT NULL
);

CREATE TABLE [zzz__SlvrP_temp] (
    [acc_email_string] VARCHAR(128) NOT NULL,
    [OptInDate] DATETIME NULL,
    [OptedOut] INT NULL,
    [OptInDetails] VARCHAR(254) NULL,
    [EmailType] INT NULL,
    [OptedOutDate] DATETIME NULL,
    [OptedOutDetails] VARCHAR(254) NULL,
    [acc_id] INT NULL,
    [acc_lastlogin] DATETIME NULL,
    [acc_modified] DATETIME NULL,
    [Announcements] INT NULL,
    [Buyer] INT NULL,
    [Cars] INT NULL,
    [Commercial] INT NULL,
    [Community] INT NULL,
    [Dealer] INT NULL,
    [acc_firstname] VARCHAR(32) NULL,
    [ForRent] INT NULL,
    [ForSale] INT NULL,
    [acc_lastname] VARCHAR(32) NOT NULL,
    [MaxAdCreated] DATETIME NULL,
    [Music] INT NULL,
    [Newsletter] INT NULL,
    [NumberOfAds] INT NULL,
    [Pets] INT NULL,
    [PromorOffers] INT NULL,
    [RealEstate] INT NOT NULL,
    [Seller] INT NOT NULL,
    [Services] INT NOT NULL,
    [Sports] INT NOT NULL,
    [src_name] VARCHAR(32) NOT NULL,
    [Wanted] INT NOT NULL,
    [zip_code] VARCHAR(5) NOT NULL
);

CREATE TABLE [zzz__Steven_Activates_Report] (
    [acc_id] INT NULL,
    [lead_min] DATETIME NULL,
    [lead_max] DATETIME NULL,
    [lead_range] VARCHAR(6) NOT NULL,
    [Recycler] INT NULL,
    [Automotive] INT NULL,
    [Dealix] INT NULL,
    [Vast] INT NULL,
    [WhosCalling] INT NULL,
    [Web2Carz] INT NULL,
    [CarDomain] INT NULL,
    [CarsDirect] INT NULL,
    [Web2CarzPaid] INT NULL,
    [iSeeCars] INT NULL,
    [iOodlePaid] INT NULL,
    [PartnerTotal] INT NULL,
    [Total] INT NULL
);

CREATE TABLE [zzz__Steven_Deactivates_Report] (
    [acc_id] INT NULL,
    [lead_min] DATETIME NULL,
    [lead_max] DATETIME NULL,
    [lead_range] VARCHAR(6) NOT NULL,
    [Recycler] INT NULL,
    [Automotive] INT NULL,
    [Dealix] INT NULL,
    [Vast] INT NULL,
    [WhosCalling] INT NULL,
    [Web2Carz] INT NULL,
    [CarDomain] INT NULL,
    [CarsDirect] INT NULL,
    [Web2CarzPaid] INT NULL,
    [iSeeCars] INT NULL,
    [iOodlePaid] INT NULL,
    [PartnerTotal] INT NULL,
    [Total] INT NULL
);

CREATE TABLE [zzz__TempAutoApprove] (
    [lst_id] INT NOT NULL -- PK,
    [acc_id] INT NOT NULL,
    [scl_id] INT NOT NULL,
    [app_type] INT NOT NULL
);

CREATE TABLE [zzz__WCLastLead] (
    [TollFreeNumber] VARCHAR(4096) NULL,
    [LastCall] DATETIME NULL
);

CREATE TABLE [zzz_AccountBackground] (
    [acc_ID] INT NOT NULL -- PK,
    [abg_Name] VARCHAR(255) NULL
);

CREATE TABLE [zzz_AccountBlacklisted] (
    [abl_ID] INT NOT NULL -- PK,
    [abl_Keyword] VARCHAR(128) NULL,
    [abl_Type] VARCHAR(128) NULL,
    [abl_Added] DATETIME NULL,
    [abl_User] INT NULL
);

CREATE TABLE [zzz_AccountCreditCard] (
    [acc_ID] INT NOT NULL -- PK,
    [acc_CardNumber_Enc] VARCHAR(1024) NOT NULL,
    [acc_CardNumber_Mask] VARCHAR(16) NOT NULL,
    [acc_CardExpiration_Enc] VARCHAR(1024) NOT NULL,
    [acc_CardCVC_Enc] VARCHAR(4) NOT NULL,
    [acc_CardFirstName] VARCHAR(30) NOT NULL,
    [acc_CardMiddleInitial] VARCHAR(1) NOT NULL,
    [acc_CardLastName] VARCHAR(30) NOT NULL,
    [acc_CardAddress] VARCHAR(64) NOT NULL,
    [acc_CardCity] VARCHAR(64) NOT NULL,
    [acc_CardState] VARCHAR(2) NOT NULL,
    [zip_Code] VARCHAR(5) NOT NULL,
    [acr_Created] DATETIME NOT NULL,
    [acr_Modified] DATETIME NOT NULL
);

CREATE TABLE [zzz_AccountPhoneFix] (
    [acc_id] INT NOT NULL,
    [src_id] INT NOT NULL,
    [acc_phone] VARCHAR(16) NOT NULL,
    [lst_id] INT NOT NULL,
    [lst_phone] VARCHAR(16) NOT NULL
);

CREATE TABLE [zzz_AccountSavedListing] (
    [asl_ID] INT NOT NULL -- PK,
    [acc_ID] INT NOT NULL,
    [lst_ID] INT NOT NULL,
    [asl_Created] DATETIME NOT NULL
);

CREATE TABLE [zzz_AccountSavedQuery] (
    [asq_ID] INT NOT NULL -- PK,
    [acc_ID] INT NOT NULL,
    [asq_Name] VARCHAR(32) NOT NULL,
    [asq_Query] VARCHAR(1024) NOT NULL,
    [aqi_ID] INT NOT NULL,
    [asq_Created] DATETIME NOT NULL,
    [asq_Modified] DATETIME NOT NULL,
    [asq_Active] BIT NOT NULL,
    [asq_Vivisimo] VARCHAR(1024) NOT NULL
);

CREATE TABLE [zzz_AccountSavedQueryEmailLog] (
    [ase_ID] INT NOT NULL -- PK,
    [asq_ID] INT NOT NULL,
    [ase_SentDate] DATETIME NOT NULL,
    [ase_SentEmail] VARCHAR(1027) NULL,
    [ase_SentHTML] TEXT NOT NULL,
    [lst_IDs] VARCHAR(1024) NOT NULL
);

CREATE TABLE [zzz_AccountSavedQueryFrequency] (
    [aqi_ID] INT NOT NULL -- PK,
    [aqi_Name] VARCHAR(32) NOT NULL,
    [aqi_EmailFrequency] INT NOT NULL,
    [aqi_Active] BIT NOT NULL
);

CREATE TABLE [zzz_AccountSecurity_WTF] (
    [ase_ID] INT NOT NULL,
    [acc_ID] INT NOT NULL,
    [aso_ID] INT NOT NULL
);

CREATE TABLE [zzz_AccountSource133NotUsed] (
    [acc_ID] INT NOT NULL,
    [src_ID] INT NOT NULL,
    [src_CusID] VARCHAR(32) NULL,
    [acc_GUID] UNIQUEIDENTIFIER NOT NULL,
    [acc_Login] VARCHAR(128) NOT NULL,
    [acc_Password] VARCHAR(256) NOT NULL,
    [acc_Company] VARCHAR(64) NOT NULL,
    [acc_FirstName] VARCHAR(32) NOT NULL,
    [acc_LastName] VARCHAR(32) NOT NULL,
    [sal_ID] INT NULL,
    [acc_Description] VARCHAR(256) NOT NULL,
    [acc_Email_String] VARCHAR(128) NOT NULL,
    [acc_Email_XML] VARCHAR(128) NOT NULL,
    [acc_URL] VARCHAR(512) NULL,
    [acc_DisplayName] VARCHAR(64) NULL,
    [acc_Phone] VARCHAR(16) NOT NULL,
    [acc_Extension] VARCHAR(10) NOT NULL,
    [acc_AltPhone] VARCHAR(16) NOT NULL,
    [acc_AltExtension] VARCHAR(10) NOT NULL,
    [acc_Address] VARCHAR(64) NOT NULL,
    [acc_City] VARCHAR(64) NOT NULL,
    [acc_State] VARCHAR(2) NOT NULL,
    [zip_Code] VARCHAR(5) NOT NULL,
    [acc_Image] VARCHAR(512) NULL,
    [acs_ID] INT NOT NULL,
    [arl_ID] INT NOT NULL,
    [acc_Created] DATETIME NOT NULL,
    [acc_Modified] DATETIME NOT NULL,
    [acc_LastLogin] DATETIME NOT NULL,
    [acc_LastIP] VARCHAR(15) NOT NULL,
    [acc_Verified] BIT NOT NULL,
    [acc_WhiteListed] BIT NOT NULL
);

CREATE TABLE [zzz_AccountStatusLog] (
    [acc_login] VARCHAR(128) NOT NULL,
    [acs_id] INT NOT NULL,
    [acc_modified] DATETIME NOT NULL
);

CREATE TABLE [zzz_AdEz_Active_Flight_20190131] (
    [adv_id] BIGINT NULL,
    [adv_name] VARCHAR(128) NULL,
    [prd_id] BIGINT NULL,
    [prd_type] VARCHAR(64) NULL,
    [prd_package] VARCHAR(128) NULL,
    [cmp_id] BIGINT NULL,
    [provider] VARCHAR(32) NULL,
    [subscription_id] BIGINT NULL,
    [flight_id] BIGINT NULL,
    [flight_status] VARCHAR(32) NULL,
    [flight_start_date] DATE NULL,
    [flight_end_date] DATE NULL,
    [flight_deactivation_date] DATE NULL,
    [flight_price] MONEY NULL,
    [flight_days] BIGINT NULL,
    [daily_price] MONEY NULL,
    [flight_bill_amount] MONEY NULL,
    [original_start_date] DATE NULL
);

CREATE TABLE [zzz_AdEz_Billing] (
    [Review] VARCHAR(23) NULL,
    [flight_price] MONEY NULL,
    [range_price] MONEY NULL,
    [flight_days] BIGINT NULL,
    [range_days] BIGINT NULL,
    [month_days] INT NULL,
    [daily_price] MONEY NULL,
    [flight_bill_amount] MONEY NULL,
    [s_b_bill_amount] MONEY NULL,
    [adv_id] BIGINT NULL,
    [adv_acc_id] BIGINT NULL,
    [adv_name] VARCHAR(128) NULL,
    [sales_channel] VARCHAR(128) NULL,
    [adv_cusid] BIGINT NULL,
    [sc_aso_id] BIGINT NULL,
    [flight_start_date] DATE NULL,
    [flight_end_date] DATE NULL,
    [flight_status] VARCHAR(32) NULL,
    [flight_deactivation_date] DATE NULL,
    [original_start_date] DATE NULL,
    [flight_id] BIGINT NULL,
    [cmp_id] BIGINT NULL,
    [subscription_id] BIGINT NULL,
    [provider] VARCHAR(32) NULL,
    [prd_type] VARCHAR(64) NULL,
    [prd_id] BIGINT NULL,
    [prd_package] VARCHAR(128) NULL,
    [sr_login] VARCHAR(128) NULL
);

CREATE TABLE [zzz_ADPFeeds_CLEANUP] (
    [ratchetId] BIGINT NOT NULL,
    [subscriptionId] BIGINT NOT NULL,
    [formtype] INT NOT NULL,
    [salesChannelId] INT NOT NULL,
    [datestart] SMALLDATETIME NOT NULL,
    [datesold] SMALLDATETIME NOT NULL,
    [dateentered] SMALLDATETIME NOT NULL,
    [enteredby] INT NOT NULL,
    [rep] INT NOT NULL,
    [cusid] INT NOT NULL,
    [price] MONEY NOT NULL,
    [prorate] BIT NULL,
    [package] INT NULL,
    [delayed] BIT NOT NULL,
    [excluderan] BIT NOT NULL,
    [excludercy] BIT NULL,
    [header] VARCHAR(100) NULL,
    [footer] VARCHAR(100) NULL,
    [aggregator] VARCHAR(100) NOT NULL,
    [notes] VARCHAR(MAX) NOT NULL,
    [clientName] VARCHAR(128) NULL,
    [clientAddress] VARCHAR(128) NULL,
    [clientAddress2] VARCHAR(128) NULL,
    [clientCity] VARCHAR(128) NULL,
    [clientState] VARCHAR(2) NULL,
    [clientZip] VARCHAR(5) NULL,
    [clientURL] VARCHAR(512) NULL,
    [clientEmailText] VARCHAR(128) NULL,
    [clientEmailXML] VARCHAR(128) NULL,
    [clientContactEmail] VARCHAR(128) NULL,
    [clientContactName] VARCHAR(128) NULL,
    [clientPhone] VARCHAR(30) NULL,
    [aggregatorName] VARCHAR(128) NULL,
    [aggregatorContactName] VARCHAR(128) NULL,
    [aggregatorAddress] VARCHAR(128) NULL,
    [aggregatorPhone] VARCHAR(128) NULL,
    [aggregatorEmail] VARCHAR(128) NULL,
    [formInventory] INT NOT NULL,
    [trackingNumber] VARCHAR(30) NULL,
    [productId] INT NULL
);

CREATE TABLE [zzz_ADPLocalBusinessHours] (
    [rlbh_id] INT NOT NULL,
    [rcl_ID] INT NOT NULL,
    [rlbh_label] VARCHAR(50) NOT NULL,
    [rlbh_start] VARCHAR(12) NOT NULL,
    [rlbh_end] VARCHAR(12) NOT NULL,
    [rlbh_select] INT NOT NULL,
    [rlbh_sort] INT NOT NULL
);

CREATE TABLE [zzz_ADPLocalCategories] (
    [rcl_ID] INT NOT NULL,
    [cgc_ID] INT NOT NULL,
    [rlc_Created] DATETIME NOT NULL,
    [sort] INT NOT NULL
);

CREATE TABLE [zzz_ADPLocalDisplayStatus] (
    [rlds_id] INT NOT NULL,
    [rlds_name] VARCHAR(50) NOT NULL
);

CREATE TABLE [zzz_ADPLocalOffer] (
    [rlo_ID] INT NOT NULL,
    [rcl_ID] INT NOT NULL,
    [rot_ID] INT NOT NULL,
    [rlo_StartDate] DATETIME NOT NULL,
    [rlo_EndDate] DATETIME NULL,
    [rlo_Details] VARCHAR(512) NOT NULL,
    [rlo_TagLine] VARCHAR(100) NOT NULL,
    [rlo_Description] VARCHAR(500) NOT NULL
);

CREATE TABLE [zzz_ADPLocalOfferType] (
    [rot_ID] INT NOT NULL,
    [rot_Name] VARCHAR(32) NOT NULL,
    [rot_Sort] INT NOT NULL,
    [rot_Active] BIT NOT NULL
);

CREATE TABLE [zzz_ADPLocalProfileImages] (
    [rcl_ID] INT NOT NULL,
    [rlp_Sort] INT NOT NULL,
    [rlp_URL] VARCHAR(512) NOT NULL,
    [rlp_Description] VARCHAR(512) NOT NULL,
    [rlp_Created] DATETIME NOT NULL
);

CREATE TABLE [zzz_ADPLocalStartEnd_v2] (
    [rcl_ID] INT NOT NULL,
    [rcl_Master_ID] INT NOT NULL,
    [rcl_LiveDate] DATETIME NULL,
    [DateEnded_Formatted] DATE NULL,
    [rcl_Master_Created] DATETIME NULL
);

CREATE TABLE [zzz_ADPSubscriptionCost] (
    [subscriptionId] INT NOT NULL -- PK,
    [cost] MONEY NOT NULL
);

CREATE TABLE [zzz_adwordsenddates] (
    [id] VARCHAR(32) NULL,
    [campaign] VARCHAR(256) NULL,
    [status] VARCHAR(32) NULL,
    [enddate] DATE NULL
);

CREATE TABLE [zzz_adwordsmapping] (
    [id] VARCHAR(32) NULL,
    [rcd_master_id] BIGINT NULL,
    [disgeo_adgroup_name] VARCHAR(255) NOT NULL,
    [dateended] INT NULL
);

CREATE TABLE [zzz_allvincreated] (
    [lst_created] DATETIME NOT NULL,
    [veh_vin] VARCHAR(32) NULL
);

CREATE TABLE [zzz_AlreadyPulled] (
    [lst_id] INT NOT NULL
);

CREATE TABLE [zzz_APIKeys] (
    [api_ID] INT NOT NULL -- PK,
    [api_Name] VARCHAR(50) NOT NULL,
    [api_Public] VARCHAR(100) NOT NULL,
    [api_Private] VARCHAR(100) NOT NULL,
    [api_Active] BIT NOT NULL,
    [api_CreatedBy] INT NOT NULL,
    [api_Created] DATETIME NOT NULL,
    [api_Expires] DATETIME NOT NULL,
    [api_TTL] INT NOT NULL,
    [src_ID] INT NOT NULL
);

CREATE TABLE [zzz_APILogs] (
    [apl_ID] INT NOT NULL -- PK,
    [apl_TimeStamp] DATETIME NOT NULL,
    [apl_IP] VARCHAR(20) NOT NULL,
    [apl_UserAgent] VARCHAR(100) NOT NULL,
    [apl_SiteToken] VARCHAR(100) NOT NULL,
    [apl_SiteHash] VARCHAR(100) NOT NULL,
    [apl_Notes] VARCHAR(300) NOT NULL
);

CREATE TABLE [zzz_attrep_truncation_safeguard] (
    [latchTaskName] VARCHAR(128) NOT NULL -- PK,
    [latchMachineGUID] VARCHAR(40) NOT NULL -- PK,
    [LatchKey] CHAR(1) NOT NULL -- PK,
    [latchLocker] DATETIME NOT NULL
);

CREATE TABLE [zzz_Attribute] (
    [att_ID] INT NOT NULL -- PK,
    [att_Desc] VARCHAR(128) NOT NULL,
    [att_Start] VARCHAR(128) NOT NULL,
    [att_End] VARCHAR(128) NOT NULL,
    [aty_ID] INT NOT NULL,
    [att_Required] BIT NOT NULL,
    [att_MaxLen] INT NOT NULL,
    [att_DefaultValue] VARCHAR(128) NOT NULL,
    [att_HelpText] VARCHAR(512) NOT NULL,
    [att_Order] INT NOT NULL,
    [att_Active] BIT NOT NULL,
    [att_Regex] VARCHAR(256) NOT NULL,
    [att_Horizontal] BIT NOT NULL
);

CREATE TABLE [zzz_AttributeClassType] (
    [act_ID] INT NOT NULL -- PK,
    [att_ID] INT NOT NULL,
    [clt_ID] INT NOT NULL
);

CREATE TABLE [zzz_AttributeMerge] (
    [att_ID] INT NOT NULL,
    [old_att_ID] INT NOT NULL
);

CREATE TABLE [zzz_AttributeSearch] (
    [att_ID] INT NOT NULL -- PK,
    [searchstring] VARCHAR(128) NOT NULL -- PK,
    [ato_ID] INT NULL,
    [lia_Value] VARCHAR(128) NULL
);

CREATE TABLE [zzz_AttributeSubClass] (
    [asc_ID] INT NOT NULL -- PK,
    [att_ID] INT NOT NULL,
    [scl_ID] INT NOT NULL,
    [asc_Required] BIT NULL,
    [asc_Regex] VARCHAR(256) NULL,
    [asc_SearchRequired] BIT NULL,
    [asc_SearchDefault] VARCHAR(128) NULL
);

CREATE TABLE [zzz_AttributeType] (
    [aty_ID] INT NOT NULL -- PK,
    [aty_Name] VARCHAR(32) NOT NULL,
    [aty_Active] BIT NOT NULL
);

CREATE TABLE [zzz_AutomotiveExploratory] (
    [esf_ID] BIGINT NOT NULL,
    [esr_ID] INT NOT NULL,
    [esr_Name] VARCHAR(50) NOT NULL,
    [ldq_ID] INT NOT NULL,
    [ldq_Created] DATETIME NOT NULL,
    [fdUID] INT NULL,
    [acc_ID] INT NOT NULL,
    [lst_ID] INT NULL,
    [RejectReasons] VARCHAR(1024) NOT NULL,
    [LeadCost] MONEY NOT NULL,
    [Budget] MONEY NOT NULL,
    [rptYearMonth] INT NOT NULL,
    [RunningBalance] MONEY NOT NULL,
    [ActualLeadCost] MONEY NOT NULL,
    [ActualBudget] MONEY NOT NULL,
    [veh_vin] VARCHAR(64) NULL,
    [ldq_phone] VARCHAR(64) NULL,
    [ldq_email] VARCHAR(64) NULL,
    [NumbersUsed] VARCHAR(64) NULL,
    [EmailDomain] VARCHAR(64) NULL,
    [BothPhoneEmailInvalid] BIT NULL,
    [EmailUsedWithVin] BIT NULL,
    [PhoneUsedWithVin] BIT NULL,
    [EmailOrPhoneUsedWithDealer] BIT NULL,
    [ldq_message] VARCHAR(1024) NULL
);

CREATE TABLE [zzz_AutoStation_d5372751] (
    [acc_id] INT NULL,
    [ldq_ID] INT NOT NULL,
    [lst_ID] INT NOT NULL,
    [ldq_lqs_ID] INT NOT NULL,
    [ldq_Created] DATETIME NOT NULL,
    [ldq_FromMail] VARCHAR(256) NOT NULL,
    [ldq_FromIP] VARCHAR(16) NOT NULL,
    [ldq_FromFirstName] VARCHAR(64) NOT NULL,
    [ldq_FromLastName] VARCHAR(64) NOT NULL,
    [ldq_FromZipCode] VARCHAR(5) NOT NULL,
    [ldq_FromPhone] VARCHAR(16) NOT NULL,
    [ldq_Message] VARCHAR(512) NOT NULL,
    [ldq_proofer_acc_ID] INT NULL,
    [ldq_ProofComment] VARCHAR(512) NULL,
    [ldq_Sent] DATETIME NULL,
    [ldq_ADFXML] VARCHAR(8000) NULL,
    [source_db] VARCHAR(4) NOT NULL
);

CREATE TABLE [zzz_BannerAlertLog] (
    [bal_ID] INT NOT NULL -- PK,
    [ban_ID] INT NOT NULL,
    [bal_Sent] DATETIME NOT NULL
);

CREATE TABLE [zzz_BannerCreative] (
    [banc_ID] INT NOT NULL -- PK,
    [ban_ID] INT NOT NULL,
    [banc_InventoryGen] VARCHAR(32) NOT NULL,
    [banc_Color] VARCHAR(32) NOT NULL,
    [banc_DefaultImage] VARCHAR(512) NULL,
    [banc_ShowPhone] BIT NOT NULL,
    [banc_UseKeywords] BIT NULL
);

CREATE TABLE [zzz_BannerGeoDistance] (
    [bng_ID] INT NOT NULL -- PK,
    [ban_ID] INT NOT NULL,
    [gdID] INT NOT NULL
);

CREATE TABLE [zzz_BannerImageLog] (
    [bil_ID] INT NOT NULL -- PK,
    [ban_ID] INT NOT NULL,
    [ban_Image] VARCHAR(4096) NOT NULL,
    [ban_Image_LastUpload] DATETIME NOT NULL
);

CREATE TABLE [zzz_BannerKeyword] (
    [bky_ID] INT NOT NULL -- PK,
    [ban_ID] INT NOT NULL,
    [bky_Keyword] VARCHAR(32) NOT NULL
);

CREATE TABLE [zzz_BannerLocation] (
    [blo_ID] INT NOT NULL -- PK,
    [blo_Name] VARCHAR(64) NOT NULL,
    [blo_Active] BIT NOT NULL,
    [blo_Order] INT NOT NULL
);

CREATE TABLE [zzz_BannerLocationSelected] (
    [bls_ID] INT NOT NULL -- PK,
    [ban_ID] INT NOT NULL,
    [blo_ID] INT NOT NULL
);

CREATE TABLE [zzz_BannerLog] (
    [bnl_ID] BIGINT NOT NULL -- PK,
    [ban_ID] INT NOT NULL,
    [bnl_Created] DATETIME NOT NULL,
    [bnl_Hour] INT NOT NULL,
    [bnl_Click] BIT NOT NULL,
    [bnl_Latitude] FLOAT NULL,
    [bnl_Longitude] FLOAT NULL,
    [bnl_cls_ID] INT NULL,
    [bnl_scl_ID] INT NULL,
    [bnl_Keyword] VARCHAR(512) NULL
);

CREATE TABLE [zzz_BannerSize] (
    [bsz_ID] INT NOT NULL -- PK,
    [bsz_Name] VARCHAR(64) NOT NULL,
    [bsz_Width] INT NOT NULL,
    [bsz_Height] INT NOT NULL,
    [bsz_Active] BIT NOT NULL,
    [bsz_Order] INT NOT NULL
);

CREATE TABLE [zzz_BannerState] (
    [bst_ID] INT NOT NULL -- PK,
    [bst_Name] VARCHAR(64) NOT NULL,
    [bst_Active] BIT NOT NULL,
    [bst_Order] INT NOT NULL
);

CREATE TABLE [zzz_BannerSubclass] (
    [bsc_ID] INT NOT NULL -- PK,
    [ban_ID] INT NOT NULL,
    [scl_ID] INT NOT NULL
);

CREATE TABLE [zzz_BannerType] (
    [bty_ID] INT NOT NULL -- PK,
    [bty_Name] VARCHAR(64) NOT NULL,
    [bty_FormatString] VARCHAR(MAX) NOT NULL,
    [bty_Active] BIT NOT NULL,
    [bty_Order] INT NOT NULL,
    [bty_Listings] INT NULL
);

CREATE TABLE [zzz_BannerType_jc] (
    [bty_ID] INT NOT NULL,
    [bty_Name] VARCHAR(64) NOT NULL,
    [bty_FormatString] VARCHAR(MAX) NOT NULL,
    [bty_Active] BIT NOT NULL,
    [bty_Order] INT NOT NULL,
    [bty_Listings] INT NULL
);

CREATE TABLE [zzz_BannerZipCode] (
    [bzc_ID] INT NOT NULL -- PK,
    [ban_ID] INT NOT NULL,
    [zip_Code] VARCHAR(5) NOT NULL
);

CREATE TABLE [zzz_BestRideDealerStat] (
    [reportdate] VARCHAR(32) NULL,
    [fdid] VARCHAR(32) NULL,
    [accid] VARCHAR(32) NULL,
    [phonecalls] VARCHAR(32) NULL,
    [emails] VARCHAR(32) NULL,
    [new_searchviews] VARCHAR(32) NULL,
    [used_searchviews] VARCHAR(32) NULL,
    [new_detailviews] VARCHAR(32) NULL,
    [used_detailviews] VARCHAR(32) NULL,
    [clicks_to_map_to_dealership] VARCHAR(32) NULL,
    [clicks_to_the_dealers_site] VARCHAR(32) NULL
);

CREATE TABLE [zzz_BestRideVinStat] (
    [reportdate] VARCHAR(32) NULL,
    [fdid] VARCHAR(32) NULL,
    [accid] VARCHAR(32) NULL,
    [lstid] VARCHAR(32) NULL,
    [vin] VARCHAR(32) NULL,
    [stock] VARCHAR(32) NULL,
    [status] VARCHAR(32) NULL,
    [emails] VARCHAR(32) NULL,
    [searchviews] VARCHAR(32) NULL,
    [detailviews] VARCHAR(32) NULL,
    [print_vehicle_detail] VARCHAR(32) NULL
);

CREATE TABLE [zzz_BKUPHistory] (
    [hstID] INT NOT NULL -- PK,
    [dbID] INT NOT NULL,
    [stpID] INT NOT NULL,
    [hstStart] SMALLDATETIME NOT NULL,
    [hstEnd] SMALLDATETIME NOT NULL,
    [hstBAKFileSize] BIGINT NULL,
    [hstZIPFileSize] BIGINT NULL
);

CREATE TABLE [zzz_BKUPLog] (
    [bulID] INT NOT NULL -- PK,
    [stpID] INT NOT NULL,
    [bulStart] DATETIME NOT NULL
);

CREATE TABLE [zzz_BKUPSettings] (
    [dbID] INT NOT NULL -- PK,
    [dbName] NVARCHAR(32) NOT NULL,
    [dbBKUPKeep] SMALLINT NOT NULL,
    [dbBKUPPath] NVARCHAR(256) NOT NULL,
    [dbBKFTPServer] NVARCHAR(32) NOT NULL,
    [dbBKUserName] NVARCHAR(32) NOT NULL,
    [dbBKPassword] NVARCHAR(32) NOT NULL
);

CREATE TABLE [zzz_BKUPSteps] (
    [stpID] INT NOT NULL -- PK,
    [stpName] VARCHAR(32) NOT NULL,
    [stpOrder] INT NOT NULL
);

CREATE TABLE [zzz_BlogCategory] (
    [bgc_ID] INT NOT NULL -- PK,
    [bgc_Category] VARCHAR(50) NOT NULL,
    [cls_Name] VARCHAR(50) NOT NULL
);

CREATE TABLE [zzz_BlogTitles] (
    [blog_ID] INT NOT NULL -- PK,
    [blog_Title] VARCHAR(200) NOT NULL,
    [blog_Summary] TEXT NOT NULL,
    [blog_Posted] SMALLDATETIME NOT NULL,
    [blog_Link] VARCHAR(200) NOT NULL,
    [blog_Image] VARCHAR(512) NULL
);

CREATE TABLE [zzz_BlogTitlesToCategory] (
    [blog_ID] INT NOT NULL -- PK,
    [bgc_ID] INT NOT NULL -- PK
);

CREATE TABLE [zzz_BorisOnlyChromeData] (
    [llst_ID] INT NOT NULL,
    [lacc_ID] INT NOT NULL,
    [src_ID] INT NOT NULL,
    [src_AdID] VARCHAR(32) NOT NULL,
    [scl_ID] INT NOT NULL,
    [zip_Code] VARCHAR(5) NOT NULL,
    [llst_isSale] BIT NULL,
    [llst_Type] TINYINT NOT NULL,
    [llst_Cost] MONEY NOT NULL,
    [llst_Headline] VARCHAR(64) NOT NULL,
    [llst_Title] VARCHAR(128) NOT NULL,
    [llst_OnlineText] VARCHAR(8000) NOT NULL,
    [llst_Price] MONEY NOT NULL,
    [lpt_ID] INT NULL,
    [llst_Phone] VARCHAR(16) NULL,
    [llst_Extension] VARCHAR(10) NOT NULL,
    [llst_Created] DATETIME NOT NULL,
    [llst_Modified] DATETIME NOT NULL,
    [_Year] VARCHAR(128) NULL,
    [_Make] VARCHAR(128) NULL,
    [_Model] VARCHAR(128) NULL,
    [_SubModel] VARCHAR(128) NULL,
    [_VIN] VARCHAR(128) NULL,
    [_BodyType] VARCHAR(128) NULL,
    [_Color] VARCHAR(128) NULL,
    [_Int_Color] VARCHAR(128) NULL,
    [_Miles] VARCHAR(128) NULL,
    [_Doors] VARCHAR(128) NULL,
    [_Cylinders] VARCHAR(128) NULL,
    [_Transmission] VARCHAR(128) NULL,
    [_Condition] VARCHAR(4) NOT NULL,
    [_Certified] VARCHAR(5) NOT NULL,
    [_Displacement] VARCHAR(128) NULL,
    [_Stock] VARCHAR(128) NULL,
    [_FuelType] VARCHAR(128) NULL,
    [_Warranty] VARCHAR(128) NULL,
    [_Drivetrain] VARCHAR(128) NULL,
    [_FuelHighway] VARCHAR(128) NULL,
    [_WarrantyTerms] VARCHAR(128) NULL,
    [_SellerType] VARCHAR(128) NULL,
    [_FuelCity] VARCHAR(128) NULL,
    [_Induction] VARCHAR(128) NULL
);

CREATE TABLE [zzz_Branding] (
    [acc_ID] INT NOT NULL -- PK,
    [Added] DATETIME NOT NULL
);

CREATE TABLE [zzz_BubbaListings] (
    [acc_id] INT NULL,
    [lst_id] INT NOT NULL,
    [lst_Created] DATETIME NOT NULL,
    [lst_LastUpload] DATETIME NULL,
    [src_id] INT NOT NULL,
    [Source] VARCHAR(64) NOT NULL,
    [Product] VARCHAR(8000) NOT NULL,
    [scl_id] INT NOT NULL,
    [scl_name] VARCHAR(64) NOT NULL,
    [lst_Images] VARCHAR(8000) NULL,
    [ImageCount] INT NULL
);

CREATE TABLE [zzz_CampaignMonitor_Client] (
    [cmc_id] INT NOT NULL -- PK,
    [cmc_name] VARCHAR(128) NOT NULL,
    [cmc_client_id] VARCHAR(128) NOT NULL,
    [cmc_api_key] VARCHAR(128) NOT NULL
);

CREATE TABLE [zzz_CampaignMonitor_List] (
    [cml_id] INT NOT NULL -- PK,
    [cmc_id] INT NOT NULL,
    [cml_name] VARCHAR(128) NOT NULL,
    [cml_list_id] VARCHAR(128) NOT NULL,
    [cml_active] BIT NOT NULL
);

CREATE TABLE [zzz_Captcha] (
    [capID] UNIQUEIDENTIFIER NOT NULL -- PK,
    [grid_string] VARCHAR(9) NOT NULL,
    [active] BIT NOT NULL,
    [created] DATETIME NOT NULL
);

CREATE TABLE [zzz_CG_Main] (
    [rcc_ID] INT NULL,
    [aso_ID] INT NULL,
    [cusid] INT NULL,
    [LISTING_ID] VARCHAR(16) NULL,
    [CAMPAIGN_PRODUCT_ID] VARCHAR(16) NULL,
    [START_DATE] VARCHAR(32) NULL,
    [CANCEL_DATE] VARCHAR(32) NULL,
    [LISTING_NAME] VARCHAR(128) NULL,
    [PRIMARY_TAG_NAME] VARCHAR(128) NULL,
    [PRIMARY_TAG_ID] VARCHAR(16) NULL,
    [STREET_ADDRESS] VARCHAR(64) NULL,
    [CITY] VARCHAR(64) NULL,
    [STATE_OR_PROVINCE] VARCHAR(2) NULL,
    [POSTAL_CODE] VARCHAR(5) NULL,
    [PHONE] VARCHAR(10) NULL,
    [LISTING_TAGS] VARCHAR(1024) NULL,
    [MESSAGE] VARCHAR(1024) NULL,
    [BULLET1] VARCHAR(64) NULL,
    [BULLET2] VARCHAR(64) NULL,
    [BULLET3] VARCHAR(64) NULL,
    [TEASER] VARCHAR(256) NULL,
    [TWITTER_HANDLE] VARCHAR(128) NULL,
    [FACEBOOK_USERNAME] VARCHAR(128) NULL,
    [URL] VARCHAR(256) NULL,
    [DISPLAY_URL] VARCHAR(256) NULL,
    [HAS_METERED_PHONE] VARCHAR(1) NULL,
    [RECORD_CALLS] VARCHAR(1) NULL,
    [TAG_LINE] VARCHAR(256) NULL,
    [MENU] VARCHAR(256) NULL,
    [RESERVATION] VARCHAR(512) NULL,
    [EMAIL] VARCHAR(128) NULL,
    [PAYMENT_METHOD] VARCHAR(128) NULL
);

CREATE TABLE [zzz_CG_Missing] (
    [budget] REAL NULL,
    [listing_id] INT NULL,
    [primary_listing_cat_id] SMALLINT NULL,
    [secondary_listing_cat_ids] VARCHAR(177) NULL,
    [ad_cat_ids] VARCHAR(97) NULL,
    [business_hours] VARCHAR(229) NULL
);

CREATE TABLE [zzz_CG_Offer] (
    [CAMPAIGN_PRODUCT_ID] VARCHAR(16) NULL,
    [OFFER_TYPE] VARCHAR(32) NULL,
    [OFFER_START_DATE] VARCHAR(32) NULL,
    [OFFER_EXPIRATION_DATE] VARCHAR(32) NULL,
    [DESCRIPTION] VARCHAR(512) NULL,
    [OFFER_STATUS_ID] VARCHAR(32) NULL
);

CREATE TABLE [zzz_CGExcel] (
    [ParentID] BIGINT NULL,
    [ParentName] VARCHAR(256) NULL,
    [ChildID] BIGINT NULL,
    [ChildName] VARCHAR(256) NULL
);

CREATE TABLE [zzz_cgResultsBU] (
    [action] VARCHAR(16) NULL,
    [rcl_id] INT NULL,
    [rcl_master_id] INT NULL,
    [rcc_id] INT NULL,
    [rcl_created] DATETIME NULL,
    [rcl_created_acc_id] INT NULL,
    [rcl_datesold] DATETIME NULL,
    [rcl_cost] MONEY NULL,
    [rcl_rft_id] INT NULL,
    [rcl_islive] BIT NULL,
    [rcl_meteredline] BIT NULL,
    [rcl_recordcalls] BIT NULL,
    [rcl_email] VARCHAR(128) NULL,
    [rcl_tagline] VARCHAR(140) NULL,
    [rcl_bullet1] VARCHAR(40) NULL,
    [rcl_bullet2] VARCHAR(40) NULL,
    [rcl_bullet3] VARCHAR(40) NULL,
    [rcl_message] VARCHAR(1024) NULL,
    [rcl_siteurl] VARCHAR(512) NULL,
    [rcl_displayurl] VARCHAR(512) NULL,
    [rcl_facebookurl] VARCHAR(512) NULL,
    [rcl_twitteraccount] VARCHAR(128) NULL,
    [rcl_twitterpassword] VARCHAR(50) NULL,
    [rcl_reservationslink] VARCHAR(256) NULL,
    [rcl_menulink] VARCHAR(256) NULL,
    [rcl_acceptedpayment] VARCHAR(256) NULL,
    [rcl_sponsoredtagline] VARCHAR(140) NULL,
    [rcl_ownerimage] VARCHAR(512) NULL,
    [rcl_sponsoredimage] VARCHAR(512) NULL,
    [rcl_livedate] DATETIME NULL,
    [rcl_senttocgdate] DATETIME NULL,
    [rcl_zipcodes] VARCHAR(500) NULL,
    [rlds_id] INT NULL,
    [rcl_trackingphone] VARCHAR(24) NULL,
    [rcl_localphone] VARCHAR(24) NULL,
    [rcl_nowhoscalling] BIT NULL,
    [rcl_citysearchonly] BIT NULL,
    [rcl_offerslogan] VARCHAR(50) NULL,
    [rcl_hascoupon] BIT NULL,
    [rcl_youtubeurl] VARCHAR(255) NULL,
    [rcl_taglineurl] VARCHAR(255) NULL,
    [rcl_location_name] VARCHAR(64) NULL,
    [rcl_location_address1] VARCHAR(64) NULL,
    [rcl_location_address2] VARCHAR(64) NULL,
    [rcl_location_city] VARCHAR(64) NULL,
    [rcl_location_state] VARCHAR(2) NULL,
    [rcl_location_zip] VARCHAR(5) NULL,
    [rcl_cg_budget] MONEY NULL,
    [rcl_Notes] VARCHAR(1024) NULL,
    [rcl_startDate] DATETIME NULL,
    [rcl_endDate] DATETIME NULL,
    [cgc_xml] XML NULL,
    [rlo_xml] XML NULL,
    [rlp_xml] XML NULL,
    [rcl_businesshours_xml] XML NULL,
    [rcl_YextListingManager] BIT NULL
);

CREATE TABLE [zzz_CM_Images] (
    [cmi_ID] INT NOT NULL -- PK,
    [acc_ID] INT NOT NULL,
    [cmi_File] VARCHAR(100) NOT NULL,
    [cmi_Desc] VARCHAR(200) NOT NULL
);

CREATE TABLE [zzz_CM_Pages] (
    [cmp_ID] INT NOT NULL -- PK,
    [cmt_ID] INT NOT NULL,
    [cmp_Text] VARCHAR(150) NOT NULL,
    [cmp_Controller] VARCHAR(50) NOT NULL,
    [cmp_Action] VARCHAR(50) NOT NULL,
    [cmp_ActionID] VARCHAR(20) NOT NULL,
    [cmp_ViewName] VARCHAR(50) NOT NULL,
    [cmp_Sort] INT NOT NULL,
    [cmp_ShowLeftMenu] BIT NOT NULL,
    [cmp_TimeStamp] SMALLDATETIME NOT NULL,
    [cmp_Author] INT NOT NULL,
    [tem_id] INT NULL
);

CREATE TABLE [zzz_CM_Revisions] (
    [cmr_ID] INT NOT NULL -- PK,
    [cms_ID] INT NOT NULL,
    [cmp_ID] INT NOT NULL,
    [cmr_Revision] INT NOT NULL,
    [cmr_Author] INT NOT NULL,
    [cmr_RevisionDate] SMALLDATETIME NOT NULL,
    [cmr_Content] TEXT NOT NULL,
    [cmr_Notes] TEXT NULL
);

CREATE TABLE [zzz_CM_Status] (
    [cms_ID] INT NOT NULL -- PK,
    [cms_Status] VARCHAR(50) NOT NULL
);

CREATE TABLE [zzz_CM_Templates] (
    [tem_id] INT NOT NULL -- PK,
    [tem_name] VARCHAR(50) NOT NULL,
    [tem_value] VARCHAR(50) NOT NULL,
    [tem_description] VARCHAR(500) NOT NULL,
    [tem_active] BIT NOT NULL
);

CREATE TABLE [zzz_CM_Type] (
    [cmt_ID] INT NOT NULL -- PK,
    [cmt_Desc] VARCHAR(100) NOT NULL
);

CREATE TABLE [zzz_CMS_Content] (
    [ctc_ID] INT NOT NULL -- PK,
    [ctl_ID] INT NOT NULL,
    [ctt_ID] INT NOT NULL,
    [ctc_Description] VARCHAR(250) NOT NULL,
    [ctc_Data] NVARCHAR(MAX) NOT NULL,
    [ctc_Created] DATETIME NOT NULL,
    [ctc_Updated] DATETIME NOT NULL
);

CREATE TABLE [zzz_CMS_History] (
    [cth_ID] INT NOT NULL -- PK,
    [cth_Timestamp] DATETIME NOT NULL,
    [ctc_ID] INT NOT NULL,
    [ctl_ID] INT NOT NULL,
    [ctt_ID] INT NOT NULL,
    [ctc_Description] VARCHAR(250) NOT NULL,
    [ctc_Data] NVARCHAR(MAX) NOT NULL,
    [ctc_Created] DATETIME NOT NULL,
    [ctc_Updated] DATETIME NOT NULL
);

CREATE TABLE [zzz_CMS_Location] (
    [ctl_id] INT NOT NULL -- PK,
    [ctl_Description] VARCHAR(250) NOT NULL
);

CREATE TABLE [zzz_CMS_Type] (
    [ctt_ID] INT NOT NULL -- PK,
    [ctt_Description] VARCHAR(250) NOT NULL
);

CREATE TABLE [zzz_CoBrandURL] (
    [cbu_ID] INT NOT NULL -- PK,
    [cbu_Original] VARCHAR(256) NULL,
    [cbu_New] VARCHAR(128) NULL,
    [cbu_Name] VARCHAR(64) NULL,
    [cbu_Image] VARCHAR(64) NULL,
    [cbu_Regex] VARCHAR(32) NULL
);

CREATE TABLE [zzz_CodingTranslate] (
    [xtype] TINYINT NOT NULL -- PK,
    [name] VARCHAR(32) NOT NULL,
    [csharp] VARCHAR(32) NOT NULL,
    [csharpdbread] VARCHAR(256) NOT NULL,
    [csharpdbwrite] VARCHAR(256) NOT NULL,
    [vb] VARCHAR(32) NULL,
    [vbdbread] VARCHAR(256) NULL,
    [vbdbwrite] VARCHAR(256) NULL,
    [vbprivate] VARCHAR(256) NULL,
    [vbpublic] VARCHAR(256) NULL
);

CREATE TABLE [zzz_ConnTest2Leads] (
    [acc_id] INT NULL,
    [ldq_id] INT NOT NULL,
    [ldq_lqs_id] INT NOT NULL,
    [ldq_created] DATETIME NOT NULL,
    [esr_id] INT NOT NULL,
    [esr_Name] VARCHAR(50) NOT NULL,
    [ldq_frommail] VARCHAR(256) NOT NULL,
    [ldq_fromfirstname] VARCHAR(64) NOT NULL,
    [ldq_fromlastname] VARCHAR(64) NOT NULL,
    [ldq_fromzipcode] VARCHAR(5) NOT NULL,
    [ldq_fromphone] VARCHAR(16) NOT NULL,
    [ldq_message] VARCHAR(512) NOT NULL
);

CREATE TABLE [zzz_ConnTest2Leads_BU20151211] (
    [acc_id] INT NULL,
    [ldq_id] INT NOT NULL,
    [ldq_lqs_id] INT NOT NULL,
    [ldq_created] DATETIME NOT NULL,
    [esr_id] INT NOT NULL,
    [esr_Name] VARCHAR(50) NOT NULL,
    [ldq_frommail] VARCHAR(256) NOT NULL,
    [ldq_fromfirstname] VARCHAR(64) NOT NULL,
    [ldq_fromlastname] VARCHAR(64) NOT NULL,
    [ldq_fromzipcode] VARCHAR(5) NOT NULL,
    [ldq_fromphone] VARCHAR(16) NOT NULL,
    [ldq_message] VARCHAR(512) NOT NULL
);

CREATE TABLE [zzz_ContactTraceData] (
    [id] INT NOT NULL,
    [Contact_ID] VARCHAR(40) NULL,
    [Initiation_Timestamp] DATETIME NULL,
    [Phone_Number] VARCHAR(20) NULL,
    [Queue] VARCHAR(50) NULL,
    [Agent] VARCHAR(50) NULL,
    [Customer_Number] VARCHAR(20) NULL,
    [Disconnect_Timestamp] DATETIME NULL
);

CREATE TABLE [zzz_ContactTraceTemp] (
    [Contact_ID] VARCHAR(40) NULL,
    [Initiation_Timestamp] VARCHAR(24) NULL,
    [Phone_Number] VARCHAR(20) NULL,
    [Queue] VARCHAR(50) NULL,
    [Agent] VARCHAR(50) NULL,
    [Customer_Number] VARCHAR(20) NULL,
    [Disconnect_Timestamp] VARCHAR(24) NULL
);

CREATE TABLE [zzz_Coupon] (
    [cpn_id] INT NOT NULL -- PK,
    [cpn_desc] VARCHAR(500) NOT NULL,
    [cpn_tag] VARCHAR(1000) NOT NULL,
    [cpn_active] BIT NOT NULL,
    [cpn_type] INT NOT NULL,
    [cpn_priority] BIT NOT NULL
);

CREATE TABLE [zzz_CouponCategory] (
    [cpn_id] INT NOT NULL -- PK,
    [cls_id] INT NOT NULL -- PK
);

CREATE TABLE [zzz_craigslist_AZ_201706] (
    [dat] VARCHAR(32) NULL,
    [id] VARCHAR(24) NULL,
    [itemDescription] VARCHAR(255) NULL,
    [whoPosted] VARCHAR(255) NULL,
    [poNumber] VARCHAR(32) NULL,
    [quantity] VARCHAR(12) NULL,
    [total] VARCHAR(12) NULL
);

CREATE TABLE [zzz_CrawlerLog] (
    [clg_ID] INT NOT NULL,
    [clg_Date] INT NOT NULL,
    [acc_ID] INT NOT NULL,
    [acc_Name] VARCHAR(64) NOT NULL,
    [DetailURL] VARCHAR(512) NULL,
    [Aggregator] VARCHAR(128) NULL,
    [DataSource] VARCHAR(256) NULL,
    [FeedCount] INT NULL,
    [NoPrice] INT NULL,
    [NoImages] INT NULL,
    [CrawlCount] INT NULL
);

CREATE TABLE [zzz_CurrentADAccountOffice] (
    [CAOMyID] INT NOT NULL -- PK,
    [CAOLogin] VARCHAR(64) NULL,
    [CAOName] VARCHAR(128) NULL,
    [CAOEmail] VARCHAR(128) NULL,
    [CAOOffice] VARCHAR(128) NULL,
    [CAO_isGM] BIT NULL,
    [CAO_isOSR] BIT NULL,
    [CAO_isISR] BIT NULL,
    [CAO_isADV] BIT NULL,
    [CAO_isISM] BIT NULL,
    [pub_ID] INT NULL,
    [aso_ID] INT NULL,
    [CAO_isDefault] BIT NULL,
    [srcid] INT NULL
);

CREATE TABLE [zzz_CustomRecyclerLocation] (
    [crl_id] INT NOT NULL -- PK,
    [acc_id] INT NOT NULL,
    [val] BIT NOT NULL
);

CREATE TABLE [zzz_DealerVault_Accounts] (
    [acc_ID] INT NULL,
    [_DV_Dealer_ID] VARCHAR(20) NULL
);

CREATE TABLE [zzz_DealerVault_ColumnInfo] (
    [filName] VARCHAR(256) NULL,
    [filType] VARCHAR(128) NULL,
    [colName] VARCHAR(128) NULL,
    [colNumber] INT NULL,
    [colMaxLength] INT NULL
);

CREATE TABLE [zzz_DealerVault_Import_Log] (
    [dvl_ID] INT NOT NULL,
    [FileName] VARCHAR(256) NULL,
    [Imported] DATETIME NULL
);

CREATE TABLE [zzz_DealerVault_INV] (
    [_File_Type] VARCHAR(10) NULL,
    [_DV_Dealer_ID] VARCHAR(9) NULL,
    [_Vendor_Dealer_ID] VARCHAR(13) NULL,
    [_DMS_Type] VARCHAR(12) NULL,
    [_Stock_Number] VARCHAR(12) NULL,
    [_Vehicle_Type] VARCHAR(5) NULL,
    [_Vehicle_Status] VARCHAR(17) NULL,
    [_Inventory_Date] VARCHAR(11) NULL,
    [_Purchase_Date] VARCHAR(11) NULL,
    [_Sold_Date] VARCHAR(10) NULL,
    [_VIN] VARCHAR(18) NULL,
    [_Year] VARCHAR(5) NULL,
    [_Make] VARCHAR(16) NULL,
    [_Model] VARCHAR(26) NULL,
    [_Model_Number] VARCHAR(11) NULL,
    [_Odometer] VARCHAR(7) NULL,
    [_Exterior_Color] VARCHAR(51) NULL,
    [_Exterior_Color_Code] VARCHAR(33) NULL,
    [_Interior_Color] VARCHAR(51) NULL,
    [_Interior_Color_Code] VARCHAR(10) NULL,
    [_Trim] VARCHAR(43) NULL,
    [_Transmission] VARCHAR(10) NULL,
    [_Cylinder] VARCHAR(3) NULL,
    [_Weight] VARCHAR(5) NULL,
    [_Description] VARCHAR(2509) NULL,
    [_Vehicle_Style] VARCHAR(43) NULL,
    [_Engine] VARCHAR(128) NULL,
    [_Fuel_Type] VARCHAR(24) NULL,
    [_MPG] VARCHAR(6) NULL,
    [_Standard_Equipment] VARCHAR(1) NULL,
    [_Factory_Accessory_Code] VARCHAR(20) NULL,
    [_Factory_Accessory_Description] VARCHAR(132) NULL,
    [_Factory_Accessory_Cost] VARCHAR(5) NULL,
    [_Factory_Accessory_Retail] VARCHAR(5) NULL,
    [_Accessory_Code] VARCHAR(290) NULL,
    [_Accessory_Description] VARCHAR(2990) NULL,
    [_Accessory_Cost] VARCHAR(238) NULL,
    [_Accessory_Retail] VARCHAR(62) NULL,
    [_Accessory_Invoice] VARCHAR(1) NULL,
    [_Package_Code] VARCHAR(147) NULL,
    [_Location] VARCHAR(11) NULL,
    [_Certification] VARCHAR(6) NULL,
    [_Certification_Number] VARCHAR(1) NULL,
    [_Sales_Code] VARCHAR(7) NULL,
    [_Wholesale] MONEY NULL,
    [_Accounting_Make] VARCHAR(3) NULL,
    [_Open_RO_Number] VARCHAR(21) NULL,
    [_License_Fee] MONEY NULL,
    [_Category] VARCHAR(5) NULL,
    [_Invoice] VARCHAR(11) NULL,
    [_Cost_Pack] MONEY NULL,
    [_Cost] MONEY NULL,
    [_Holdback] MONEY NULL,
    [_List_Price] MONEY NULL,
    [_MSRP] MONEY NULL,
    [_Internet_Price] MONEY NULL,
    [_VIN_Explosion_Year] VARCHAR(5) NULL,
    [_VIN_Explosion_Make] VARCHAR(14) NULL,
    [_VIN_Explosion_Model] VARCHAR(51) NULL,
    [_VIN_Explosion_Trim] VARCHAR(46) NULL,
    [_VIN_Explosion_Tran_Type] VARCHAR(7) NULL,
    [_VIN_Explosion_Fuel_Type] VARCHAR(20) NULL,
    [_VIN_Explosion_Engine_Size] VARCHAR(5) NULL,
    [_VIN_Explosion_GVW_Range] VARCHAR(16) NULL,
    [_VIN_Explosion_Vehicle_Options] VARCHAR(2206) NULL,
    [_Image_Location_URL] VARCHAR(6650) NULL,
    [_Listing_URL] VARCHAR(72) NULL
);

CREATE TABLE [zzz_DealerVault_INV_TEMP] (
    [_File_Type] VARCHAR(10) NULL,
    [_DV_Dealer_ID] VARCHAR(9) NULL,
    [_Vendor_Dealer_ID] VARCHAR(13) NULL,
    [_DMS_Type] VARCHAR(12) NULL,
    [_Stock_Number] VARCHAR(12) NULL,
    [_Vehicle_Type] VARCHAR(5) NULL,
    [_Vehicle_Status] VARCHAR(17) NULL,
    [_Inventory_Date] VARCHAR(11) NULL,
    [_Purchase_Date] VARCHAR(11) NULL,
    [_Sold_Date] VARCHAR(10) NULL,
    [_VIN] VARCHAR(18) NULL,
    [_Year] VARCHAR(5) NULL,
    [_Make] VARCHAR(16) NULL,
    [_Model] VARCHAR(26) NULL,
    [_Model_Number] VARCHAR(11) NULL,
    [_Odometer] VARCHAR(7) NULL,
    [_Exterior_Color] VARCHAR(51) NULL,
    [_Exterior_Color_Code] VARCHAR(33) NULL,
    [_Interior_Color] VARCHAR(51) NULL,
    [_Interior_Color_Code] VARCHAR(10) NULL,
    [_Trim] VARCHAR(43) NULL,
    [_Transmission] VARCHAR(10) NULL,
    [_Cylinder] VARCHAR(3) NULL,
    [_Weight] VARCHAR(5) NULL,
    [_Description] VARCHAR(2509) NULL,
    [_Vehicle_Style] VARCHAR(43) NULL,
    [_Engine] VARCHAR(128) NULL,
    [_Fuel_Type] VARCHAR(24) NULL,
    [_MPG] VARCHAR(6) NULL,
    [_Standard_Equipment] VARCHAR(1) NULL,
    [_Factory_Accessory_Code] VARCHAR(20) NULL,
    [_Factory_Accessory_Description] VARCHAR(132) NULL,
    [_Factory_Accessory_Cost] VARCHAR(5) NULL,
    [_Factory_Accessory_Retail] VARCHAR(5) NULL,
    [_Accessory_Code] VARCHAR(290) NULL,
    [_Accessory_Description] VARCHAR(2990) NULL,
    [_Accessory_Cost] VARCHAR(238) NULL,
    [_Accessory_Retail] VARCHAR(62) NULL,
    [_Accessory_Invoice] VARCHAR(1) NULL,
    [_Package_Code] VARCHAR(147) NULL,
    [_Location] VARCHAR(11) NULL,
    [_Certification] VARCHAR(6) NULL,
    [_Certification_Number] VARCHAR(1) NULL,
    [_Sales_Code] VARCHAR(7) NULL,
    [_Wholesale] MONEY NULL,
    [_Accounting_Make] VARCHAR(3) NULL,
    [_Open_RO_Number] VARCHAR(21) NULL,
    [_License_Fee] MONEY NULL,
    [_Category] VARCHAR(5) NULL,
    [_Invoice] VARCHAR(11) NULL,
    [_Cost_Pack] MONEY NULL,
    [_Cost] MONEY NULL,
    [_Holdback] MONEY NULL,
    [_List_Price] MONEY NULL,
    [_MSRP] MONEY NULL,
    [_Internet_Price] MONEY NULL,
    [_VIN_Explosion_Year] VARCHAR(5) NULL,
    [_VIN_Explosion_Make] VARCHAR(14) NULL,
    [_VIN_Explosion_Model] VARCHAR(51) NULL,
    [_VIN_Explosion_Trim] VARCHAR(46) NULL,
    [_VIN_Explosion_Tran_Type] VARCHAR(7) NULL,
    [_VIN_Explosion_Fuel_Type] VARCHAR(20) NULL,
    [_VIN_Explosion_Engine_Size] VARCHAR(5) NULL,
    [_VIN_Explosion_GVW_Range] VARCHAR(16) NULL,
    [_VIN_Explosion_Vehicle_Options] VARCHAR(2206) NULL,
    [_Image_Location_URL] VARCHAR(6650) NULL,
    [_Listing_URL] VARCHAR(72) NULL
);

CREATE TABLE [zzz_DealerVault_Matched] (
    [ID] VARCHAR(36) NULL,
    [_Keyword] VARCHAR(128) NULL,
    [_Field] VARCHAR(24) NOT NULL,
    [acc_id] INT NULL,
    [lst_id] INT NULL,
    [veh_vin] VARCHAR(32) NULL,
    [veh_stock] VARCHAR(32) NULL,
    [veh_Price] MONEY NULL,
    [ldq_id] INT NOT NULL,
    [ldq_created] DATETIME NOT NULL,
    [ldq_lqs_id] INT NOT NULL,
    [ldq_fromip] VARCHAR(16) NOT NULL,
    [ldq_FromFirstName] VARCHAR(64) NOT NULL,
    [ldq_FromLastName] VARCHAR(64) NOT NULL,
    [ldq_FromZipCode] VARCHAR(5) NOT NULL,
    [ldq_frommail] VARCHAR(256) NOT NULL,
    [ldq_fromphone] VARCHAR(16) NOT NULL,
    [DataSource] VARCHAR(32) NULL
);

CREATE TABLE [zzz_DealerVault_Matching_XLS] (
    [acc_ID] INT NULL,
    [id] BIGINT NULL,
    [_Keyword] VARCHAR(256) NULL,
    [_Field] VARCHAR(256) NULL,
    [_Secondary] VARCHAR(256) NULL
);

CREATE TABLE [zzz_DealerVault_SL] (
    [_File_Type] VARCHAR(6) NULL,
    [_DV_Dealer_ID] VARCHAR(9) NULL,
    [_Vendor_Dealer_ID] VARCHAR(10) NULL,
    [_DMS_Type] VARCHAR(12) NULL,
    [_Deal_Number] VARCHAR(7) NULL,
    [_Customer_Number] VARCHAR(11) NULL,
    [_Full_Name] VARCHAR(51) NULL,
    [_Salutation] VARCHAR(11) NULL,
    [_First_Name] VARCHAR(19) NULL,
    [_Middle_Name] VARCHAR(21) NULL,
    [_Last_Name] VARCHAR(41) NULL,
    [_Suffix] VARCHAR(4) NULL,
    [_Address_Line_1] VARCHAR(41) NULL,
    [_Address_Line_2] VARCHAR(31) NULL,
    [_City] VARCHAR(21) NULL,
    [_State] VARCHAR(3) NULL,
    [_Zip] VARCHAR(11) NULL,
    [_County] VARCHAR(21) NULL,
    [_Home_Phone] VARCHAR(15) NULL,
    [_Cell_Phone] VARCHAR(15) NULL,
    [_Work_Phone] VARCHAR(15) NULL,
    [_Work_Extension] VARCHAR(9) NULL,
    [_Email_1] VARCHAR(43) NULL,
    [_Email_2] VARCHAR(28) NULL,
    [_Email_3] VARCHAR(1) NULL,
    [_Birth_Date] VARCHAR(11) NULL,
    [_Individual_Business_Flag] VARCHAR(2) NULL,
    [_Opt_Out] VARCHAR(4) NULL,
    [_Block_Email] VARCHAR(4) NULL,
    [_Block_Phone] VARCHAR(4) NULL,
    [_Block_Mail] VARCHAR(4) NULL,
    [_Language] VARCHAR(1) NULL,
    [_Customer_Create_Date] VARCHAR(11) NULL,
    [_Customer_Last_Activity_Date] VARCHAR(11) NULL,
    [_Co_Buyer_Customer_Number] VARCHAR(11) NULL,
    [_Co_Buyer_Full_Name] VARCHAR(36) NULL,
    [_Co_Buyer_Salutation] VARCHAR(9) NULL,
    [_Co_Buyer_First_Name] VARCHAR(24) NULL,
    [_Co_Buyer_Middle_Name] VARCHAR(17) NULL,
    [_Co_Buyer_Last_Name] VARCHAR(21) NULL,
    [_Co_Buyer_Suffix] VARCHAR(8) NULL,
    [_Co_Buyer_Address_Line_1] VARCHAR(33) NULL,
    [_Co_Buyer_Address_Line_2] VARCHAR(24) NULL,
    [_Co_Buyer_City] VARCHAR(21) NULL,
    [_Co_Buyer_State] VARCHAR(3) NULL,
    [_Co_Buyer_Zip] VARCHAR(11) NULL,
    [_Co_Buyer_County] VARCHAR(17) NULL,
    [_Co_Buyer_Home_Phone] VARCHAR(15) NULL,
    [_Co_Buyer_Cell_Phone] VARCHAR(15) NULL,
    [_Co_Buyer_Work_Phone] VARCHAR(15) NULL,
    [_Co_Buyer_Work_Extension] VARCHAR(1) NULL,
    [_Co_Buyer_Email_1] VARCHAR(35) NULL,
    [_Co_Buyer_Email_2] VARCHAR(1) NULL,
    [_Co_Buyer_Email_3] VARCHAR(1) NULL,
    [_Co_Buyer_Birth_Date] VARCHAR(11) NULL,
    [_Co_Buyer_Individual_Business_Flag] VARCHAR(1) NULL,
    [_Co_Buyer_Opt_Out] VARCHAR(2) NULL,
    [_Co_Buyer_Block_Email] VARCHAR(1) NULL,
    [_Co_Buyer_Block_Phone] VARCHAR(1) NULL,
    [_Co_Buyer_Block_Mail] VARCHAR(1) NULL,
    [_VIN] VARCHAR(18) NULL,
    [_Year] VARCHAR(5) NULL,
    [_Make] VARCHAR(21) NULL,
    [_Model] VARCHAR(29) NULL,
    [_Model_Number] VARCHAR(19) NULL,
    [_Mileage] INT NULL,
    [_Description] VARCHAR(36) NULL,
    [_Exterior_Color] VARCHAR(42) NULL,
    [_New_Used] VARCHAR(5) NULL,
    [_Stock_Number] VARCHAR(10) NULL,
    [_Transmission] VARCHAR(2) NULL,
    [_Engine_Configuration] VARCHAR(1) NULL,
    [_Trim] VARCHAR(26) NULL,
    [_Engine_Number] VARCHAR(20) NULL,
    [_Chassis_Number] VARCHAR(2) NULL,
    [_License_Plate_Number] VARCHAR(9) NULL,
    [_Delivery_Date] VARCHAR(11) NULL,
    [_Delivery_Mileage] INT NULL,
    [_Inventory_Date] VARCHAR(11) NULL,
    [_In_Service_Date] VARCHAR(11) NULL,
    [_VIN_Explosion_Year] VARCHAR(5) NULL,
    [_VIN_Explosion_Make] VARCHAR(14) NULL,
    [_VIN_Explosion_Model] VARCHAR(36) NULL,
    [_VIN_Explosion_Trim] VARCHAR(48) NULL,
    [_VIN_Explosion_Transmission_Type] VARCHAR(7) NULL,
    [_VIN_Explosion_Fuel_Type] VARCHAR(20) NULL,
    [_VIN_Explosion_Engine_Size] VARCHAR(5) NULL,
    [_VIN_Explosion_GVW_Range] VARCHAR(16) NULL,
    [_Trade_1_VIN] VARCHAR(18) NULL,
    [_Trade_1_Year] VARCHAR(5) NULL,
    [_Trade_1_Make] VARCHAR(21) NULL,
    [_Trade_1_Model] VARCHAR(29) NULL,
    [_Trade_1_Odometer] VARCHAR(7) NULL,
    [_Trade_1_Actual_Cash_Value] MONEY NULL,
    [_Trade_1_Gross] MONEY NULL,
    [_Trade_1_Payoff] MONEY NULL,
    [_Trade_2_VIN] VARCHAR(18) NULL,
    [_Trade_2_Year] VARCHAR(5) NULL,
    [_Trade_2_Make] VARCHAR(16) NULL,
    [_Trade_2_Model] VARCHAR(20) NULL,
    [_Trade_2_Odometer] VARCHAR(7) NULL,
    [_Trade_2_Actual_Cash_Value] MONEY NULL,
    [_Trade_2_Gross] MONEY NULL,
    [_Trade_2_Payoff] MONEY NULL,
    [_Salesman_1_Number] VARCHAR(7) NULL,
    [_Salesman_1_Name] VARCHAR(28) NULL,
    [_Salesman_2_Number] VARCHAR(7) NULL,
    [_Salesman_2_Name] VARCHAR(26) NULL,
    [_Salesman_3_Number] VARCHAR(3) NULL,
    [_Salesman_3_Name] VARCHAR(11) NULL,
    [_Closing_Manager_Number] VARCHAR(7) NULL,
    [_Closing_Manager_Name] VARCHAR(28) NULL,
    [_Finance_Manager_Number] VARCHAR(7) NULL,
    [_Finance_Manager_Name] VARCHAR(28) NULL,
    [_Salesman_Manager_Number] VARCHAR(7) NULL,
    [_Salesman_Manager_Name] VARCHAR(21) NULL,
    [_MSRP] MONEY NULL,
    [_List_Price] MONEY NULL,
    [_Sales_Price] MONEY NULL,
    [_Journal_Price] MONEY NULL,
    [_Cost] MONEY NULL,
    [_Journal_Cost] MONEY NULL,
    [_Adjustments] MONEY NULL,
    [_Adjusted_Cost] MONEY NULL,
    [_Incentives] VARCHAR(11) NULL,
    [_Pack_Amount] MONEY NULL,
    [_Sale_Net] MONEY NULL,
    [_Total_Trade_Actual_Cash_Value] MONEY NULL,
    [_Total_Trade_Gross] MONEY NULL,
    [_We_Owe_Front] MONEY NULL,
    [_Total_Front_Fees_Aftermarket_Profit] MONEY NULL,
    [_Total_Front_Commission] MONEY NULL,
    [_Total_Front_Sales] VARCHAR(11) NULL,
    [_Total_Front_Cost] MONEY NULL,
    [_Front_Gross] MONEY NULL,
    [_Finance_Profit] MONEY NULL,
    [_Total_Warranty_Profit] MONEY NULL,
    [_We_Owe_Back] MONEY NULL,
    [_Insurance_Profit] MONEY NULL,
    [_Total_Back_Fees_Aftermarket_Profit] MONEY NULL,
    [_Finance_Reserve] MONEY NULL,
    [_Total_Back_Commission] MONEY NULL,
    [_Total_Back_Sales] VARCHAR(1) NULL,
    [_Total_Back_Cost] MONEY NULL,
    [_Back_Gross] MONEY NULL,
    [_Total_Profit] MONEY NULL,
    [_Gross_Profit] MONEY NULL,
    [_Gross_Payable] MONEY NULL,
    [_Deal_Status] VARCHAR(2) NULL,
    [_Entry_Date] VARCHAR(11) NULL,
    [_Booked_Date] VARCHAR(11) NULL,
    [_Finalized_Date] VARCHAR(11) NULL,
    [_Contract_Date] VARCHAR(11) NULL,
    [_Accounting_Date] VARCHAR(11) NULL,
    [_Status_Change_Date] VARCHAR(11) NULL,
    [_First_Pay_Date] VARCHAR(11) NULL,
    [_Deal_Type] VARCHAR(2) NULL,
    [_Sale_Type] VARCHAR(2) NULL,
    [_Bank_ID] VARCHAR(12) NULL,
    [_Bank_Name] VARCHAR(51) NULL,
    [_Bank_Address] VARCHAR(55) NULL,
    [_Term] INT NULL,
    [_Amount_Financed] MONEY NULL,
    [_APR] VARCHAR(9) NULL,
    [_Monthly_Payment] MONEY NULL,
    [_Payment_Total] MONEY NULL,
    [_Rebates] MONEY NULL,
    [_Deposit] MONEY NULL,
    [_Down_Payment] MONEY NULL,
    [_Total_Net_Trades] MONEY NULL,
    [_Total_Down] MONEY NULL,
    [_Balloon_Amount] MONEY NULL,
    [_Adjusted_Balloon_Amount] MONEY NULL,
    [_Holdback_Amount] MONEY NULL,
    [_Total_Drive_Off_Amount] MONEY NULL,
    [_License_Fee] MONEY NULL,
    [_Registration_Fee] MONEY NULL,
    [_Documentation_Fee] MONEY NULL,
    [_Finance_Charge] MONEY NULL,
    [_Total_Pickup_Payments] MONEY NULL,
    [_Sell_Rate] VARCHAR(9) NULL,
    [_Buy_Rate] VARCHAR(8) NULL,
    [_Residual_Rate] VARCHAR(9) NULL,
    [_Residual_Amount] MONEY NULL,
    [_Allowed_Miles] INT NULL,
    [_Estimated_Miles] INT NULL,
    [_Mileage_Rate] VARCHAR(6) NULL,
    [_Acquisition_Fee] MONEY NULL,
    [_Base_Payment] MONEY NULL,
    [_Security_Deposit] MONEY NULL,
    [_Total_Capital_Reduction] VARCHAR(10) NULL,
    [_Net_Capital_Cost] MONEY NULL,
    [_Lease_Depreciation_Value] MONEY NULL,
    [_Dealer_Fees] MONEY NULL,
    [_Government_Fees] MONEY NULL,
    [_Total_Tax] MONEY NULL,
    [_Registration_State] VARCHAR(3) NULL,
    [_Report_of_Sale_Number] VARCHAR(10) NULL,
    [_Salesman_1_Total_Commission] MONEY NULL,
    [_Salesman_1_Front_Commission] MONEY NULL,
    [_Salesman_1_Back_Commission] MONEY NULL,
    [_Salesman_2_Total_Commission] MONEY NULL,
    [_Salesman_2_Front_Commission] MONEY NULL,
    [_Salesman_2_Back_Commission] MONEY NULL,
    [_Salesman_3_Total_Commission] MONEY NULL,
    [_Salesman_3_Front_Commission] MONEY NULL,
    [_Salesman_3_Back_Commission] MONEY NULL,
    [_Warranty_1_Name] VARCHAR(31) NULL,
    [_Warranty_1_Sale] MONEY NULL,
    [_Warranty_1_Cost] MONEY NULL,
    [_Warranty_1_Miles] INT NULL,
    [_Warranty_1_Term] INT NULL,
    [_Warranty_2_Name] VARCHAR(25) NULL,
    [_Warranty_2_Sale] MONEY NULL,
    [_Warranty_2_Cost] MONEY NULL,
    [_Warranty_2_Miles] INT NULL,
    [_Warranty_2_Term] INT NULL,
    [_Warranty_3_Name] VARCHAR(31) NULL,
    [_Warranty_3_Sale] MONEY NULL,
    [_Warranty_3_Cost] MONEY NULL,
    [_Warranty_3_Miles] INT NULL,
    [_Warranty_3_Term] INT NULL,
    [_Warranty_4_Name] VARCHAR(9) NULL,
    [_Warranty_4_Sale] MONEY NULL,
    [_Warranty_4_Cost] MONEY NULL,
    [_Warranty_4_Miles] INT NULL,
    [_Warranty_4_Term] INT NULL,
    [_Warranty_5_Name] VARCHAR(1) NULL,
    [_Warranty_5_Sale] MONEY NULL,
    [_Warranty_5_Cost] MONEY NULL,
    [_Warranty_5_Miles] INT NULL,
    [_Warranty_5_Term] INT NULL,
    [_Total_Fee_Aftermarket_Sale] MONEY NULL,
    [_Total_Fee_Aftermarket_Cost] MONEY NULL,
    [_Fee_Aftermarket_1_Name] VARCHAR(28) NULL,
    [_Fee_Aftermarket_1_Sale] MONEY NULL,
    [_Fee_Aftermarket_1_Cost] MONEY NULL,
    [_Fee_Aftermarket_1_Profit_Indicator] VARCHAR(2) NULL,
    [_Fee_Aftermarket_2_Name] VARCHAR(29) NULL,
    [_Fee_Aftermarket_2_Sale] MONEY NULL,
    [_Fee_Aftermarket_2_Cost] MONEY NULL,
    [_Fee_Aftermarket_2_Profit_Indicator] VARCHAR(2) NULL,
    [_Fee_Aftermarket_3_Name] VARCHAR(23) NULL,
    [_Fee_Aftermarket_3_Sale] MONEY NULL,
    [_Fee_Aftermarket_3_Cost] MONEY NULL,
    [_Fee_Aftermarket_3_Profit_Indicator] VARCHAR(2) NULL,
    [_Fee_Aftermarket_4_Name] VARCHAR(25) NULL,
    [_Fee_Aftermarket_4_Sale] MONEY NULL,
    [_Fee_Aftermarket_4_Cost] MONEY NULL,
    [_Fee_Aftermarket_4_Profit_Indicator] VARCHAR(2) NULL,
    [_Fee_Aftermarket_5_Name] VARCHAR(30) NULL,
    [_Fee_Aftermarket_5_Sale] MONEY NULL,
    [_Fee_Aftermarket_5_Cost] MONEY NULL,
    [_Fee_Aftermarket_5_Profit_Indicator] VARCHAR(2) NULL,
    [_Fee_Aftermarket_6_Name] VARCHAR(26) NULL,
    [_Fee_Aftermarket_6_Sale] MONEY NULL,
    [_Fee_Aftermarket_6_Cost] MONEY NULL,
    [_Fee_Aftermarket_6_Profit_Indicator] VARCHAR(2) NULL,
    [_Fee_Aftermarket_7_Name] VARCHAR(27) NULL,
    [_Fee_Aftermarket_7_Sale] MONEY NULL,
    [_Fee_Aftermarket_7_Cost] MONEY NULL,
    [_Fee_Aftermarket_7_Profit_Indicator] VARCHAR(2) NULL,
    [_Fee_Aftermarket_8_Name] VARCHAR(25) NULL,
    [_Fee_Aftermarket_8_Sale] MONEY NULL,
    [_Fee_Aftermarket_8_Cost] MONEY NULL,
    [_Fee_Aftermarket_8_Profit_Indicator] VARCHAR(2) NULL,
    [_Fee_Aftermarket_9_Name] VARCHAR(31) NULL,
    [_Fee_Aftermarket_9_Sale] MONEY NULL,
    [_Fee_Aftermarket_9_Cost] MONEY NULL,
    [_Fee_Aftermarket_9_Profit_Indicator] VARCHAR(2) NULL,
    [_Fee_Aftermarket_10_Name] VARCHAR(25) NULL,
    [_Fee_Aftermarket_10_Sale] MONEY NULL,
    [_Fee_Aftermarket_10_Cost] MONEY NULL,
    [_Fee_Aftermarket_10_Profit_Indicator] VARCHAR(2) NULL,
    [_Fee_Aftermarket_11_Name] VARCHAR(29) NULL,
    [_Fee_Aftermarket_11_Sale] MONEY NULL,
    [_Fee_Aftermarket_11_Cost] MONEY NULL,
    [_Fee_Aftermarket_11_Profit_Indicator] VARCHAR(2) NULL,
    [_Fee_Aftermarket_12_Name] VARCHAR(30) NULL,
    [_Fee_Aftermarket_12_Sale] MONEY NULL,
    [_Fee_Aftermarket_12_Cost] MONEY NULL,
    [_Fee_Aftermarket_12_Profit_Indicator] VARCHAR(2) NULL,
    [_Fee_Aftermarket_13_Name] VARCHAR(31) NULL,
    [_Fee_Aftermarket_13_Sale] MONEY NULL,
    [_Fee_Aftermarket_13_Cost] MONEY NULL,
    [_Fee_Aftermarket_13_Profit_Indicator] VARCHAR(2) NULL,
    [_Fee_Aftermarket_14_Name] VARCHAR(19) NULL,
    [_Fee_Aftermarket_14_Sale] MONEY NULL,
    [_Fee_Aftermarket_14_Cost] MONEY NULL,
    [_Fee_Aftermarket_14_Profit_Indicator] VARCHAR(2) NULL,
    [_Fee_Aftermarket_15_Name] VARCHAR(8) NULL,
    [_Fee_Aftermarket_15_Sale] MONEY NULL,
    [_Fee_Aftermarket_15_Cost] MONEY NULL,
    [_Fee_Aftermarket_15_Profit_Indicator] VARCHAR(2) NULL,
    [_Fee_Aftermarket_16_Name] VARCHAR(26) NULL,
    [_Fee_Aftermarket_16_Sale] MONEY NULL,
    [_Fee_Aftermarket_16_Cost] MONEY NULL,
    [_Fee_Aftermarket_16_Profit_Indicator] VARCHAR(2) NULL,
    [_Fee_Aftermarket_17_Name] VARCHAR(24) NULL,
    [_Fee_Aftermarket_17_Sale] MONEY NULL,
    [_Fee_Aftermarket_17_Cost] MONEY NULL,
    [_Fee_Aftermarket_17_Profit_Indicator] VARCHAR(2) NULL,
    [_Fee_Aftermarket_18_Name] VARCHAR(1) NULL,
    [_Fee_Aftermarket_18_Sale] MONEY NULL,
    [_Fee_Aftermarket_18_Cost] MONEY NULL,
    [_Fee_Aftermarket_18_Profit_Indicator] VARCHAR(1) NULL,
    [_Fee_Aftermarket_19_Name] VARCHAR(1) NULL,
    [_Fee_Aftermarket_19_Sale] MONEY NULL,
    [_Fee_Aftermarket_19_Cost] MONEY NULL,
    [_Fee_Aftermarket_19_Profit_Indicator] VARCHAR(1) NULL,
    [_Fee_Aftermarket_20_Name] VARCHAR(1) NULL,
    [_Fee_Aftermarket_20_Sale] MONEY NULL,
    [_Fee_Aftermarket_20_Cost] MONEY NULL,
    [_Fee_Aftermarket_20_Profit_Indicator] VARCHAR(1) NULL,
    [_Insurance_1_Type] VARCHAR(3) NULL,
    [_Insurance_1_Name] VARCHAR(17) NULL,
    [_Insurance_1_Sale] MONEY NULL,
    [_Insurance_1_Cost] MONEY NULL,
    [_Insurance_1_Term] INT NULL,
    [_Insurance_2_Type] VARCHAR(1) NULL,
    [_Insurance_2_Name] VARCHAR(17) NULL,
    [_Insurance_2_Sale] MONEY NULL,
    [_Insurance_2_Cost] MONEY NULL,
    [_Insurance_2_Term] INT NULL,
    [_Insurance_3_Type] VARCHAR(1) NULL,
    [_Insurance_3_Name] VARCHAR(17) NULL,
    [_Insurance_3_Sale] MONEY NULL,
    [_Insurance_3_Cost] MONEY NULL,
    [_Insurance_3_Term] INT NULL,
    [_Accidental_Health_Type] VARCHAR(1) NULL,
    [_Accidental_Health_Name] VARCHAR(1) NULL,
    [_Accidental_Health_Sale] MONEY NULL,
    [_Accidental_Health_Cost] MONEY NULL,
    [_Accidental_Health_Term] INT NULL,
    [_Credit_Life_Type] VARCHAR(2) NULL,
    [_Credit_Life_Name] VARCHAR(20) NULL,
    [_Credit_Life_Sale] MONEY NULL,
    [_Credit_Life_Cost] MONEY NULL,
    [_Credit_Life_Term] INT NULL,
    [_Levelized_Life_Type] VARCHAR(1) NULL,
    [_Levelized_Life_Name] VARCHAR(1) NULL,
    [_Levelized_Life_Sale] MONEY NULL,
    [_Levelized_Life_Cost] MONEY NULL,
    [_Levelized_Life_Term] INT NULL,
    [_Loss_of_Employment_Type] VARCHAR(1) NULL,
    [_Loss_of_Employment_Name] VARCHAR(1) NULL,
    [_Loss_of_Employment_Sale] MONEY NULL,
    [_Loss_of_Employment_Cost] MONEY NULL,
    [_Loss_of_Employment_Term] INT NULL,
    [_Guaranteed_Auto_Protection_Type] VARCHAR(1) NULL,
    [_Guaranteed_Auto_Protection_Name] VARCHAR(26) NULL,
    [_Guaranteed_Auto_Protection_Sale] MONEY NULL,
    [_Guaranteed_Auto_Protection_Cost] MONEY NULL,
    [_Guaranteed_Auto_Protection_Term] INT NULL,
    [_Sale_Comments] VARCHAR(37) NULL,
    [_CASS_STD_LINE1] VARCHAR(33) NULL,
    [_CASS_STD_LINE2] VARCHAR(18) NULL,
    [_CASS_STD_CITY] VARCHAR(21) NULL,
    [_CASS_STD_STATE] VARCHAR(3) NULL,
    [_CASS_STD_ZIP] VARCHAR(6) NULL,
    [_CASS_STD_ZIP4] VARCHAR(5) NULL,
    [_CASS_STD_DPBC] VARCHAR(3) NULL,
    [_CASS_STD_CHKDGT] VARCHAR(2) NULL,
    [_CASS_STD_CART] VARCHAR(5) NULL,
    [_CASS_STD_LOT] VARCHAR(5) NULL,
    [_CASS_STD_LOTORD] VARCHAR(2) NULL,
    [_CASS_STD_URB] VARCHAR(1) NULL,
    [_CASS_STD_FIPS] VARCHAR(1) NULL,
    [_CASS_STD_EWS] VARCHAR(2) NULL,
    [_CASS_STD_LACS] VARCHAR(2) NULL,
    [_CASS_STD_ZIPMOV] VARCHAR(2) NULL,
    [_CASS_STD_Z4LOM] VARCHAR(3) NULL,
    [_CASS_STD_NDIAPT] VARCHAR(2) NULL,
    [_CASS_STD_NDIRR] VARCHAR(1) NULL,
    [_CASS_STD_LACSRT] VARCHAR(3) NULL,
    [_CASS_STD_ERROR_CD] VARCHAR(5) NULL
);

CREATE TABLE [zzz_DealerVault_SL_TEMP] (
    [_File_Type] VARCHAR(6) NULL,
    [_DV_Dealer_ID] VARCHAR(9) NULL,
    [_Vendor_Dealer_ID] VARCHAR(10) NULL,
    [_DMS_Type] VARCHAR(12) NULL,
    [_Deal_Number] VARCHAR(7) NULL,
    [_Customer_Number] VARCHAR(11) NULL,
    [_Full_Name] VARCHAR(51) NULL,
    [_Salutation] VARCHAR(11) NULL,
    [_First_Name] VARCHAR(19) NULL,
    [_Middle_Name] VARCHAR(21) NULL,
    [_Last_Name] VARCHAR(41) NULL,
    [_Suffix] VARCHAR(4) NULL,
    [_Address_Line_1] VARCHAR(41) NULL,
    [_Address_Line_2] VARCHAR(31) NULL,
    [_City] VARCHAR(21) NULL,
    [_State] VARCHAR(3) NULL,
    [_Zip] VARCHAR(11) NULL,
    [_County] VARCHAR(21) NULL,
    [_Home_Phone] VARCHAR(15) NULL,
    [_Cell_Phone] VARCHAR(15) NULL,
    [_Work_Phone] VARCHAR(15) NULL,
    [_Work_Extension] VARCHAR(9) NULL,
    [_Email_1] VARCHAR(43) NULL,
    [_Email_2] VARCHAR(28) NULL,
    [_Email_3] VARCHAR(1) NULL,
    [_Birth_Date] VARCHAR(11) NULL,
    [_Individual_Business_Flag] VARCHAR(2) NULL,
    [_Opt_Out] VARCHAR(4) NULL,
    [_Block_Email] VARCHAR(4) NULL,
    [_Block_Phone] VARCHAR(4) NULL,
    [_Block_Mail] VARCHAR(4) NULL,
    [_Language] VARCHAR(1) NULL,
    [_Customer_Create_Date] VARCHAR(11) NULL,
    [_Customer_Last_Activity_Date] VARCHAR(11) NULL,
    [_Co_Buyer_Customer_Number] VARCHAR(11) NULL,
    [_Co_Buyer_Full_Name] VARCHAR(36) NULL,
    [_Co_Buyer_Salutation] VARCHAR(9) NULL,
    [_Co_Buyer_First_Name] VARCHAR(24) NULL,
    [_Co_Buyer_Middle_Name] VARCHAR(17) NULL,
    [_Co_Buyer_Last_Name] VARCHAR(21) NULL,
    [_Co_Buyer_Suffix] VARCHAR(8) NULL,
    [_Co_Buyer_Address_Line_1] VARCHAR(33) NULL,
    [_Co_Buyer_Address_Line_2] VARCHAR(24) NULL,
    [_Co_Buyer_City] VARCHAR(21) NULL,
    [_Co_Buyer_State] VARCHAR(3) NULL,
    [_Co_Buyer_Zip] VARCHAR(11) NULL,
    [_Co_Buyer_County] VARCHAR(17) NULL,
    [_Co_Buyer_Home_Phone] VARCHAR(15) NULL,
    [_Co_Buyer_Cell_Phone] VARCHAR(15) NULL,
    [_Co_Buyer_Work_Phone] VARCHAR(15) NULL,
    [_Co_Buyer_Work_Extension] VARCHAR(1) NULL,
    [_Co_Buyer_Email_1] VARCHAR(35) NULL,
    [_Co_Buyer_Email_2] VARCHAR(1) NULL,
    [_Co_Buyer_Email_3] VARCHAR(1) NULL,
    [_Co_Buyer_Birth_Date] VARCHAR(11) NULL,
    [_Co_Buyer_Individual_Business_Flag] VARCHAR(1) NULL,
    [_Co_Buyer_Opt_Out] VARCHAR(2) NULL,
    [_Co_Buyer_Block_Email] VARCHAR(1) NULL,
    [_Co_Buyer_Block_Phone] VARCHAR(1) NULL,
    [_Co_Buyer_Block_Mail] VARCHAR(1) NULL,
    [_VIN] VARCHAR(18) NULL,
    [_Year] VARCHAR(5) NULL,
    [_Make] VARCHAR(21) NULL,
    [_Model] VARCHAR(29) NULL,
    [_Model_Number] VARCHAR(19) NULL,
    [_Mileage] INT NULL,
    [_Description] VARCHAR(36) NULL,
    [_Exterior_Color] VARCHAR(42) NULL,
    [_New_Used] VARCHAR(5) NULL,
    [_Stock_Number] VARCHAR(10) NULL,
    [_Transmission] VARCHAR(2) NULL,
    [_Engine_Configuration] VARCHAR(1) NULL,
    [_Trim] VARCHAR(26) NULL,
    [_Engine_Number] VARCHAR(20) NULL,
    [_Chassis_Number] VARCHAR(2) NULL,
    [_License_Plate_Number] VARCHAR(9) NULL,
    [_Delivery_Date] VARCHAR(11) NULL,
    [_Delivery_Mileage] INT NULL,
    [_Inventory_Date] VARCHAR(11) NULL,
    [_In_Service_Date] VARCHAR(11) NULL,
    [_VIN_Explosion_Year] VARCHAR(5) NULL,
    [_VIN_Explosion_Make] VARCHAR(14) NULL,
    [_VIN_Explosion_Model] VARCHAR(36) NULL,
    [_VIN_Explosion_Trim] VARCHAR(48) NULL,
    [_VIN_Explosion_Transmission_Type] VARCHAR(7) NULL,
    [_VIN_Explosion_Fuel_Type] VARCHAR(20) NULL,
    [_VIN_Explosion_Engine_Size] VARCHAR(5) NULL,
    [_VIN_Explosion_GVW_Range] VARCHAR(16) NULL,
    [_Trade_1_VIN] VARCHAR(18) NULL,
    [_Trade_1_Year] VARCHAR(5) NULL,
    [_Trade_1_Make] VARCHAR(21) NULL,
    [_Trade_1_Model] VARCHAR(29) NULL,
    [_Trade_1_Odometer] VARCHAR(7) NULL,
    [_Trade_1_Actual_Cash_Value] MONEY NULL,
    [_Trade_1_Gross] MONEY NULL,
    [_Trade_1_Payoff] MONEY NULL,
    [_Trade_2_VIN] VARCHAR(18) NULL,
    [_Trade_2_Year] VARCHAR(5) NULL,
    [_Trade_2_Make] VARCHAR(16) NULL,
    [_Trade_2_Model] VARCHAR(20) NULL,
    [_Trade_2_Odometer] VARCHAR(7) NULL,
    [_Trade_2_Actual_Cash_Value] MONEY NULL,
    [_Trade_2_Gross] MONEY NULL,
    [_Trade_2_Payoff] MONEY NULL,
    [_Salesman_1_Number] VARCHAR(7) NULL,
    [_Salesman_1_Name] VARCHAR(28) NULL,
    [_Salesman_2_Number] VARCHAR(7) NULL,
    [_Salesman_2_Name] VARCHAR(26) NULL,
    [_Salesman_3_Number] VARCHAR(3) NULL,
    [_Salesman_3_Name] VARCHAR(11) NULL,
    [_Closing_Manager_Number] VARCHAR(7) NULL,
    [_Closing_Manager_Name] VARCHAR(28) NULL,
    [_Finance_Manager_Number] VARCHAR(7) NULL,
    [_Finance_Manager_Name] VARCHAR(28) NULL,
    [_Salesman_Manager_Number] VARCHAR(7) NULL,
    [_Salesman_Manager_Name] VARCHAR(21) NULL,
    [_MSRP] MONEY NULL,
    [_List_Price] MONEY NULL,
    [_Sales_Price] MONEY NULL,
    [_Journal_Price] MONEY NULL,
    [_Cost] MONEY NULL,
    [_Journal_Cost] MONEY NULL,
    [_Adjustments] MONEY NULL,
    [_Adjusted_Cost] MONEY NULL,
    [_Incentives] VARCHAR(11) NULL,
    [_Pack_Amount] MONEY NULL,
    [_Sale_Net] MONEY NULL,
    [_Total_Trade_Actual_Cash_Value] MONEY NULL,
    [_Total_Trade_Gross] MONEY NULL,
    [_We_Owe_Front] MONEY NULL,
    [_Total_Front_Fees_Aftermarket_Profit] MONEY NULL,
    [_Total_Front_Commission] MONEY NULL,
    [_Total_Front_Sales] VARCHAR(11) NULL,
    [_Total_Front_Cost] MONEY NULL,
    [_Front_Gross] MONEY NULL,
    [_Finance_Profit] MONEY NULL,
    [_Total_Warranty_Profit] MONEY NULL,
    [_We_Owe_Back] MONEY NULL,
    [_Insurance_Profit] MONEY NULL,
    [_Total_Back_Fees_Aftermarket_Profit] MONEY NULL,
    [_Finance_Reserve] MONEY NULL,
    [_Total_Back_Commission] MONEY NULL,
    [_Total_Back_Sales] VARCHAR(1) NULL,
    [_Total_Back_Cost] MONEY NULL,
    [_Back_Gross] MONEY NULL,
    [_Total_Profit] MONEY NULL,
    [_Gross_Profit] MONEY NULL,
    [_Gross_Payable] MONEY NULL,
    [_Deal_Status] VARCHAR(2) NULL,
    [_Entry_Date] VARCHAR(11) NULL,
    [_Booked_Date] VARCHAR(11) NULL,
    [_Finalized_Date] VARCHAR(11) NULL,
    [_Contract_Date] VARCHAR(11) NULL,
    [_Accounting_Date] VARCHAR(11) NULL,
    [_Status_Change_Date] VARCHAR(11) NULL,
    [_First_Pay_Date] VARCHAR(11) NULL,
    [_Deal_Type] VARCHAR(2) NULL,
    [_Sale_Type] VARCHAR(2) NULL,
    [_Bank_ID] VARCHAR(12) NULL,
    [_Bank_Name] VARCHAR(51) NULL,
    [_Bank_Address] VARCHAR(55) NULL,
    [_Term] INT NULL,
    [_Amount_Financed] MONEY NULL,
    [_APR] VARCHAR(9) NULL,
    [_Monthly_Payment] MONEY NULL,
    [_Payment_Total] MONEY NULL,
    [_Rebates] MONEY NULL,
    [_Deposit] MONEY NULL,
    [_Down_Payment] MONEY NULL,
    [_Total_Net_Trades] MONEY NULL,
    [_Total_Down] MONEY NULL,
    [_Balloon_Amount] MONEY NULL,
    [_Adjusted_Balloon_Amount] MONEY NULL,
    [_Holdback_Amount] MONEY NULL,
    [_Total_Drive_Off_Amount] MONEY NULL,
    [_License_Fee] MONEY NULL,
    [_Registration_Fee] MONEY NULL,
    [_Documentation_Fee] MONEY NULL,
    [_Finance_Charge] MONEY NULL,
    [_Total_Pickup_Payments] MONEY NULL,
    [_Sell_Rate] VARCHAR(9) NULL,
    [_Buy_Rate] VARCHAR(8) NULL,
    [_Residual_Rate] VARCHAR(9) NULL,
    [_Residual_Amount] MONEY NULL,
    [_Allowed_Miles] INT NULL,
    [_Estimated_Miles] INT NULL,
    [_Mileage_Rate] VARCHAR(6) NULL,
    [_Acquisition_Fee] MONEY NULL,
    [_Base_Payment] MONEY NULL,
    [_Security_Deposit] MONEY NULL,
    [_Total_Capital_Reduction] VARCHAR(10) NULL,
    [_Net_Capital_Cost] MONEY NULL,
    [_Lease_Depreciation_Value] MONEY NULL,
    [_Dealer_Fees] MONEY NULL,
    [_Government_Fees] MONEY NULL,
    [_Total_Tax] MONEY NULL,
    [_Registration_State] VARCHAR(3) NULL,
    [_Report_of_Sale_Number] VARCHAR(10) NULL,
    [_Salesman_1_Total_Commission] MONEY NULL,
    [_Salesman_1_Front_Commission] MONEY NULL,
    [_Salesman_1_Back_Commission] MONEY NULL,
    [_Salesman_2_Total_Commission] MONEY NULL,
    [_Salesman_2_Front_Commission] MONEY NULL,
    [_Salesman_2_Back_Commission] MONEY NULL,
    [_Salesman_3_Total_Commission] MONEY NULL,
    [_Salesman_3_Front_Commission] MONEY NULL,
    [_Salesman_3_Back_Commission] MONEY NULL,
    [_Warranty_1_Name] VARCHAR(31) NULL,
    [_Warranty_1_Sale] MONEY NULL,
    [_Warranty_1_Cost] MONEY NULL,
    [_Warranty_1_Miles] INT NULL,
    [_Warranty_1_Term] INT NULL,
    [_Warranty_2_Name] VARCHAR(25) NULL,
    [_Warranty_2_Sale] MONEY NULL,
    [_Warranty_2_Cost] MONEY NULL,
    [_Warranty_2_Miles] INT NULL,
    [_Warranty_2_Term] INT NULL,
    [_Warranty_3_Name] VARCHAR(31) NULL,
    [_Warranty_3_Sale] MONEY NULL,
    [_Warranty_3_Cost] MONEY NULL,
    [_Warranty_3_Miles] INT NULL,
    [_Warranty_3_Term] INT NULL,
    [_Warranty_4_Name] VARCHAR(9) NULL,
    [_Warranty_4_Sale] MONEY NULL,
    [_Warranty_4_Cost] MONEY NULL,
    [_Warranty_4_Miles] INT NULL,
    [_Warranty_4_Term] INT NULL,
    [_Warranty_5_Name] VARCHAR(1) NULL,
    [_Warranty_5_Sale] MONEY NULL,
    [_Warranty_5_Cost] MONEY NULL,
    [_Warranty_5_Miles] INT NULL,
    [_Warranty_5_Term] INT NULL,
    [_Total_Fee_Aftermarket_Sale] MONEY NULL,
    [_Total_Fee_Aftermarket_Cost] MONEY NULL,
    [_Fee_Aftermarket_1_Name] VARCHAR(28) NULL,
    [_Fee_Aftermarket_1_Sale] MONEY NULL,
    [_Fee_Aftermarket_1_Cost] MONEY NULL,
    [_Fee_Aftermarket_1_Profit_Indicator] VARCHAR(2) NULL,
    [_Fee_Aftermarket_2_Name] VARCHAR(29) NULL,
    [_Fee_Aftermarket_2_Sale] MONEY NULL,
    [_Fee_Aftermarket_2_Cost] MONEY NULL,
    [_Fee_Aftermarket_2_Profit_Indicator] VARCHAR(2) NULL,
    [_Fee_Aftermarket_3_Name] VARCHAR(23) NULL,
    [_Fee_Aftermarket_3_Sale] MONEY NULL,
    [_Fee_Aftermarket_3_Cost] MONEY NULL,
    [_Fee_Aftermarket_3_Profit_Indicator] VARCHAR(2) NULL,
    [_Fee_Aftermarket_4_Name] VARCHAR(25) NULL,
    [_Fee_Aftermarket_4_Sale] MONEY NULL,
    [_Fee_Aftermarket_4_Cost] MONEY NULL,
    [_Fee_Aftermarket_4_Profit_Indicator] VARCHAR(2) NULL,
    [_Fee_Aftermarket_5_Name] VARCHAR(30) NULL,
    [_Fee_Aftermarket_5_Sale] MONEY NULL,
    [_Fee_Aftermarket_5_Cost] MONEY NULL,
    [_Fee_Aftermarket_5_Profit_Indicator] VARCHAR(2) NULL,
    [_Fee_Aftermarket_6_Name] VARCHAR(26) NULL,
    [_Fee_Aftermarket_6_Sale] MONEY NULL,
    [_Fee_Aftermarket_6_Cost] MONEY NULL,
    [_Fee_Aftermarket_6_Profit_Indicator] VARCHAR(2) NULL,
    [_Fee_Aftermarket_7_Name] VARCHAR(27) NULL,
    [_Fee_Aftermarket_7_Sale] MONEY NULL,
    [_Fee_Aftermarket_7_Cost] MONEY NULL,
    [_Fee_Aftermarket_7_Profit_Indicator] VARCHAR(2) NULL,
    [_Fee_Aftermarket_8_Name] VARCHAR(25) NULL,
    [_Fee_Aftermarket_8_Sale] MONEY NULL,
    [_Fee_Aftermarket_8_Cost] MONEY NULL,
    [_Fee_Aftermarket_8_Profit_Indicator] VARCHAR(2) NULL,
    [_Fee_Aftermarket_9_Name] VARCHAR(31) NULL,
    [_Fee_Aftermarket_9_Sale] MONEY NULL,
    [_Fee_Aftermarket_9_Cost] MONEY NULL,
    [_Fee_Aftermarket_9_Profit_Indicator] VARCHAR(2) NULL,
    [_Fee_Aftermarket_10_Name] VARCHAR(25) NULL,
    [_Fee_Aftermarket_10_Sale] MONEY NULL,
    [_Fee_Aftermarket_10_Cost] MONEY NULL,
    [_Fee_Aftermarket_10_Profit_Indicator] VARCHAR(2) NULL,
    [_Fee_Aftermarket_11_Name] VARCHAR(29) NULL,
    [_Fee_Aftermarket_11_Sale] MONEY NULL,
    [_Fee_Aftermarket_11_Cost] MONEY NULL,
    [_Fee_Aftermarket_11_Profit_Indicator] VARCHAR(2) NULL,
    [_Fee_Aftermarket_12_Name] VARCHAR(30) NULL,
    [_Fee_Aftermarket_12_Sale] MONEY NULL,
    [_Fee_Aftermarket_12_Cost] MONEY NULL,
    [_Fee_Aftermarket_12_Profit_Indicator] VARCHAR(2) NULL,
    [_Fee_Aftermarket_13_Name] VARCHAR(31) NULL,
    [_Fee_Aftermarket_13_Sale] MONEY NULL,
    [_Fee_Aftermarket_13_Cost] MONEY NULL,
    [_Fee_Aftermarket_13_Profit_Indicator] VARCHAR(2) NULL,
    [_Fee_Aftermarket_14_Name] VARCHAR(19) NULL,
    [_Fee_Aftermarket_14_Sale] MONEY NULL,
    [_Fee_Aftermarket_14_Cost] MONEY NULL,
    [_Fee_Aftermarket_14_Profit_Indicator] VARCHAR(2) NULL,
    [_Fee_Aftermarket_15_Name] VARCHAR(8) NULL,
    [_Fee_Aftermarket_15_Sale] MONEY NULL,
    [_Fee_Aftermarket_15_Cost] MONEY NULL,
    [_Fee_Aftermarket_15_Profit_Indicator] VARCHAR(2) NULL,
    [_Fee_Aftermarket_16_Name] VARCHAR(26) NULL,
    [_Fee_Aftermarket_16_Sale] MONEY NULL,
    [_Fee_Aftermarket_16_Cost] MONEY NULL,
    [_Fee_Aftermarket_16_Profit_Indicator] VARCHAR(2) NULL,
    [_Fee_Aftermarket_17_Name] VARCHAR(24) NULL,
    [_Fee_Aftermarket_17_Sale] MONEY NULL,
    [_Fee_Aftermarket_17_Cost] MONEY NULL,
    [_Fee_Aftermarket_17_Profit_Indicator] VARCHAR(2) NULL,
    [_Fee_Aftermarket_18_Name] VARCHAR(1) NULL,
    [_Fee_Aftermarket_18_Sale] MONEY NULL,
    [_Fee_Aftermarket_18_Cost] MONEY NULL,
    [_Fee_Aftermarket_18_Profit_Indicator] VARCHAR(1) NULL,
    [_Fee_Aftermarket_19_Name] VARCHAR(1) NULL,
    [_Fee_Aftermarket_19_Sale] MONEY NULL,
    [_Fee_Aftermarket_19_Cost] MONEY NULL,
    [_Fee_Aftermarket_19_Profit_Indicator] VARCHAR(1) NULL,
    [_Fee_Aftermarket_20_Name] VARCHAR(1) NULL,
    [_Fee_Aftermarket_20_Sale] MONEY NULL,
    [_Fee_Aftermarket_20_Cost] MONEY NULL,
    [_Fee_Aftermarket_20_Profit_Indicator] VARCHAR(1) NULL,
    [_Insurance_1_Type] VARCHAR(3) NULL,
    [_Insurance_1_Name] VARCHAR(17) NULL,
    [_Insurance_1_Sale] MONEY NULL,
    [_Insurance_1_Cost] MONEY NULL,
    [_Insurance_1_Term] INT NULL,
    [_Insurance_2_Type] VARCHAR(1) NULL,
    [_Insurance_2_Name] VARCHAR(17) NULL,
    [_Insurance_2_Sale] MONEY NULL,
    [_Insurance_2_Cost] MONEY NULL,
    [_Insurance_2_Term] INT NULL,
    [_Insurance_3_Type] VARCHAR(1) NULL,
    [_Insurance_3_Name] VARCHAR(17) NULL,
    [_Insurance_3_Sale] MONEY NULL,
    [_Insurance_3_Cost] MONEY NULL,
    [_Insurance_3_Term] INT NULL,
    [_Accidental_Health_Type] VARCHAR(1) NULL,
    [_Accidental_Health_Name] VARCHAR(1) NULL,
    [_Accidental_Health_Sale] MONEY NULL,
    [_Accidental_Health_Cost] MONEY NULL,
    [_Accidental_Health_Term] INT NULL,
    [_Credit_Life_Type] VARCHAR(2) NULL,
    [_Credit_Life_Name] VARCHAR(20) NULL,
    [_Credit_Life_Sale] MONEY NULL,
    [_Credit_Life_Cost] MONEY NULL,
    [_Credit_Life_Term] INT NULL,
    [_Levelized_Life_Type] VARCHAR(1) NULL,
    [_Levelized_Life_Name] VARCHAR(1) NULL,
    [_Levelized_Life_Sale] MONEY NULL,
    [_Levelized_Life_Cost] MONEY NULL,
    [_Levelized_Life_Term] INT NULL,
    [_Loss_of_Employment_Type] VARCHAR(1) NULL,
    [_Loss_of_Employment_Name] VARCHAR(1) NULL,
    [_Loss_of_Employment_Sale] MONEY NULL,
    [_Loss_of_Employment_Cost] MONEY NULL,
    [_Loss_of_Employment_Term] INT NULL,
    [_Guaranteed_Auto_Protection_Type] VARCHAR(1) NULL,
    [_Guaranteed_Auto_Protection_Name] VARCHAR(26) NULL,
    [_Guaranteed_Auto_Protection_Sale] MONEY NULL,
    [_Guaranteed_Auto_Protection_Cost] MONEY NULL,
    [_Guaranteed_Auto_Protection_Term] INT NULL,
    [_Sale_Comments] VARCHAR(37) NULL,
    [_CASS_STD_LINE1] VARCHAR(33) NULL,
    [_CASS_STD_LINE2] VARCHAR(18) NULL,
    [_CASS_STD_CITY] VARCHAR(21) NULL,
    [_CASS_STD_STATE] VARCHAR(3) NULL,
    [_CASS_STD_ZIP] VARCHAR(6) NULL,
    [_CASS_STD_ZIP4] VARCHAR(5) NULL,
    [_CASS_STD_DPBC] VARCHAR(3) NULL,
    [_CASS_STD_CHKDGT] VARCHAR(2) NULL,
    [_CASS_STD_CART] VARCHAR(5) NULL,
    [_CASS_STD_LOT] VARCHAR(5) NULL,
    [_CASS_STD_LOTORD] VARCHAR(2) NULL,
    [_CASS_STD_URB] VARCHAR(1) NULL,
    [_CASS_STD_FIPS] VARCHAR(1) NULL,
    [_CASS_STD_EWS] VARCHAR(2) NULL,
    [_CASS_STD_LACS] VARCHAR(2) NULL,
    [_CASS_STD_ZIPMOV] VARCHAR(2) NULL,
    [_CASS_STD_Z4LOM] VARCHAR(3) NULL,
    [_CASS_STD_NDIAPT] VARCHAR(2) NULL,
    [_CASS_STD_NDIRR] VARCHAR(1) NULL,
    [_CASS_STD_LACSRT] VARCHAR(3) NULL,
    [_CASS_STD_ERROR_CD] VARCHAR(5) NULL
);

CREATE TABLE [zzz_DealerVault_SV] (
    [_File_Type] VARCHAR(8) NULL,
    [_DV_Dealer_ID] VARCHAR(9) NULL,
    [_Vendor_Dealer_ID] VARCHAR(10) NULL,
    [_DMS_Type] VARCHAR(12) NULL,
    [_RO_Number] VARCHAR(9) NULL,
    [_Open_Date] VARCHAR(11) NULL,
    [_Close_Date] VARCHAR(11) NULL,
    [_Service_Advisor_Number] VARCHAR(7) NULL,
    [_Service_Advisor_Name] VARCHAR(21) NULL,
    [_RO_Department] VARCHAR(2) NULL,
    [_RO_Store] VARCHAR(9) NULL,
    [_Appointment_Date] VARCHAR(11) NULL,
    [_Appointment_Flag] VARCHAR(2) NULL,
    [_Appointment_Number] VARCHAR(7) NULL,
    [_Appointment_Department] VARCHAR(1) NULL,
    [_Accounting_Make] VARCHAR(3) NULL,
    [_Pickup_Date] VARCHAR(10) NULL,
    [_Pickup_Time] VARCHAR(1) NULL,
    [_Post_Time] VARCHAR(8) NULL,
    [_Promise_Date] VARCHAR(11) NULL,
    [_Promise_Time] VARCHAR(6) NULL,
    [_Payment_Method] VARCHAR(30) NULL,
    [_RO_Status] VARCHAR(9) NULL,
    [_Print_Time] VARCHAR(9) NULL,
    [_Salesman_Name] VARCHAR(21) NULL,
    [_Salesman_Number] VARCHAR(7) NULL,
    [_Service_Contract_Name] VARCHAR(30) NULL,
    [_Service_Contract_Number] VARCHAR(26) NULL,
    [_Tag_Number] VARCHAR(5) NULL,
    [_Warranty_Expiration_Date] VARCHAR(11) NULL,
    [_Warranty_Expiration_Miles] INT NULL,
    [_Total_Cost] MONEY NULL,
    [_Total_Sale] MONEY NULL,
    [_Customer_Total_Cost] MONEY NULL,
    [_Customer_Total_Sale] MONEY NULL,
    [_Customer_Labor_Cost] MONEY NULL,
    [_Customer_Labor_Sale] MONEY NULL,
    [_Customer_Parts_Cost] MONEY NULL,
    [_Customer_Parts_Sale] MONEY NULL,
    [_Customer_Misc_Cost] MONEY NULL,
    [_Customer_Misc_Sale] MONEY NULL,
    [_Customer_Gas_Oil_Grease_Cost] MONEY NULL,
    [_Customer_Gas_Oil_Grease_Sale] MONEY NULL,
    [_Customer_Sublet_Cost] MONEY NULL,
    [_Customer_Sublet_Sale] MONEY NULL,
    [_Warranty_Total_Cost] MONEY NULL,
    [_Warranty_Total_Sale] MONEY NULL,
    [_Warranty_Labor_Cost] MONEY NULL,
    [_Warranty_Labor_Sale] MONEY NULL,
    [_Warranty_Parts_Cost] MONEY NULL,
    [_Warranty_Parts_Sale] MONEY NULL,
    [_Warranty_Misc_Cost] MONEY NULL,
    [_Warranty_Misc_Sale] MONEY NULL,
    [_Warranty_Gas_Oil_Grease_Cost] MONEY NULL,
    [_Warranty_Gas_Oil_Grease_Sale] MONEY NULL,
    [_Warranty_Sublet_Cost] MONEY NULL,
    [_Warranty_Sublet_Sale] MONEY NULL,
    [_Internal_Total_Cost] MONEY NULL,
    [_Internal_Total_Sale] MONEY NULL,
    [_Internal_Labor_Cost] MONEY NULL,
    [_Internal_Labor_Sale] MONEY NULL,
    [_Internal_Parts_Cost] MONEY NULL,
    [_Internal_Parts_Sale] MONEY NULL,
    [_Internal_Misc_Cost] MONEY NULL,
    [_Internal_Misc_Sale] MONEY NULL,
    [_Internal_Gas_Oil_Grease_Cost] MONEY NULL,
    [_Internal_Gas_Oil_Grease_Sale] MONEY NULL,
    [_Internal_Sublet_Cost] MONEY NULL,
    [_Internal_Sublet_Sale] MONEY NULL,
    [_Total_Labor_Cost] MONEY NULL,
    [_Total_Labor_Sale] MONEY NULL,
    [_Total_Parts_Cost] MONEY NULL,
    [_Total_Parts_Sale] MONEY NULL,
    [_Total_Misc_Cost] MONEY NULL,
    [_Total_Misc_Sale] MONEY NULL,
    [_Total_Gas_Oil_Grease_Cost] MONEY NULL,
    [_Total_Gas_Oil_Grease_Sale] MONEY NULL,
    [_Total_Sublet_Cost] MONEY NULL,
    [_Total_Sublet_Sale] MONEY NULL,
    [_Total_Misc_Code_Sale] MONEY NULL,
    [_Total_Tax] MONEY NULL,
    [_Customer_Total_Tax] MONEY NULL,
    [_Warranty_Total_Tax] MONEY NULL,
    [_Internal_Total_Tax] MONEY NULL,
    [_Operation_Codes] VARCHAR(197) NULL,
    [_Operation_Code_Descriptions] VARCHAR(405) NULL,
    [_Tech_Labor_Line] VARCHAR(54) NULL,
    [_Tech_Number] VARCHAR(196) NULL,
    [_Tech_Name] VARCHAR(880) NULL,
    [_Upsell] VARCHAR(340) NULL,
    [_Labor_Cause] VARCHAR(2367) NULL,
    [_Labor_Complaint] VARCHAR(1951) NULL,
    [_Labor_Correction] VARCHAR(1475) NULL,
    [_Labor_Comments] VARCHAR(2344) NULL,
    [_Recommended_Operation_Codes] VARCHAR(183) NULL,
    [_Recommendations] VARCHAR(1950) NULL,
    [_Operation_Line_Number] VARCHAR(54) NULL,
    [_Operation_Sale_Types] VARCHAR(42) NULL,
    [_Operation_Line_Cost] VARCHAR(128) NULL,
    [_Operation_Line_Sale] VARCHAR(138) NULL,
    [_Labor_Cost] VARCHAR(123) NULL,
    [_Labor_Sale] VARCHAR(134) NULL,
    [_Parts_Cost] VARCHAR(297) NULL,
    [_Parts_Sale] VARCHAR(300) NULL,
    [_Misc_Cost] VARCHAR(68) NULL,
    [_Misc_Sale] VARCHAR(75) NULL,
    [_Gas_Oil_Grease_Cost] VARCHAR(37) NULL,
    [_Gas_Oil_Grease_Sale] VARCHAR(39) NULL,
    [_Sublet_Cost] VARCHAR(32) NULL,
    [_Sublet_Sale] VARCHAR(32) NULL,
    [_Labor_Tech_Hours] VARCHAR(246) NULL,
    [_Labor_Bill_Hours] VARCHAR(62) NULL,
    [_Labor_Tech_Rate] VARCHAR(343) NULL,
    [_Labor_Bill_Rate] VARCHAR(146) NULL,
    [_Parts_Labor_Line_Number] VARCHAR(115) NULL,
    [_Parts_Line_Number] VARCHAR(115) NULL,
    [_Parts_Sale_Type] VARCHAR(108) NULL,
    [_Part_Number] VARCHAR(623) NULL,
    [_Part_Description] VARCHAR(658) NULL,
    [_Part_Quantity] VARCHAR(109) NULL,
    [_Parts_Unit_Cost] VARCHAR(297) NULL,
    [_Parts_Unit_Sale] VARCHAR(300) NULL,
    [_VIN] VARCHAR(18) NULL,
    [_Year] VARCHAR(5) NULL,
    [_Make] VARCHAR(21) NULL,
    [_Model] VARCHAR(29) NULL,
    [_Model_Number] VARCHAR(10) NULL,
    [_RO_Mileage] INT NULL,
    [_Mileage_Out] INT NULL,
    [_Description] VARCHAR(33) NULL,
    [_Exterior_Color] VARCHAR(256) NULL,
    [_New_Used] VARCHAR(2) NULL,
    [_Stock_Number] VARCHAR(9) NULL,
    [_Transmission] VARCHAR(2) NULL,
    [_Engine_Configuration] VARCHAR(1) NULL,
    [_Trim] VARCHAR(1) NULL,
    [_Engine_Number] VARCHAR(13) NULL,
    [_Chassis_Number] VARCHAR(5) NULL,
    [_License_Plate_Number] VARCHAR(11) NULL,
    [_Delivery_Date] VARCHAR(11) NULL,
    [_Delivery_Mileage] INT NULL,
    [_In_Service_Date] VARCHAR(11) NULL,
    [_VIN_Explosion_Year] VARCHAR(5) NULL,
    [_VIN_Explosion_Make] VARCHAR(14) NULL,
    [_VIN_Explosion_Model] VARCHAR(51) NULL,
    [_VIN_Explosion_Trim] VARCHAR(48) NULL,
    [_VIN_Explosion_Transmission_Type] VARCHAR(7) NULL,
    [_VIN_Explosion_Fuel_Type] VARCHAR(20) NULL,
    [_VIN_Explosion_Engine_Size] VARCHAR(5) NULL,
    [_VIN_Explosion_GVW_Range] VARCHAR(16) NULL,
    [_Customer_Number] VARCHAR(10) NULL,
    [_Full_Name] VARCHAR(43) NULL,
    [_Salutation] VARCHAR(11) NULL,
    [_First_Name] VARCHAR(24) NULL,
    [_Middle_Name] VARCHAR(16) NULL,
    [_Last_Name] VARCHAR(36) NULL,
    [_Suffix] VARCHAR(5) NULL,
    [_Address_Line_1] VARCHAR(37) NULL,
    [_Address_Line_2] VARCHAR(30) NULL,
    [_City] VARCHAR(21) NULL,
    [_State] VARCHAR(11) NULL,
    [_Zip] VARCHAR(11) NULL,
    [_County] VARCHAR(19) NULL,
    [_Home_Phone] VARCHAR(15) NULL,
    [_Cell_Phone] VARCHAR(15) NULL,
    [_Work_Phone] VARCHAR(15) NULL,
    [_Work_Extension] VARCHAR(9) NULL,
    [_Email_1] VARCHAR(41) NULL,
    [_Email_2] VARCHAR(34) NULL,
    [_Email_3] VARCHAR(1) NULL,
    [_Birth_Date] VARCHAR(11) NULL,
    [_Individual_Business_Flag] VARCHAR(2) NULL,
    [_Opt_Out] VARCHAR(2) NULL,
    [_Block_Email] VARCHAR(2) NULL,
    [_Block_Phone] VARCHAR(2) NULL,
    [_Block_Mail] VARCHAR(2) NULL,
    [_Language] VARCHAR(1) NULL,
    [_Customer_Create_Date] VARCHAR(11) NULL,
    [_Customer_Last_Activity_Date] VARCHAR(11) NULL,
    [_CASS_STD_LINE1] VARCHAR(34) NULL,
    [_CASS_STD_LINE2] VARCHAR(17) NULL,
    [_CASS_STD_CITY] VARCHAR(28) NULL,
    [_CASS_STD_STATE] VARCHAR(3) NULL,
    [_CASS_STD_ZIP] VARCHAR(6) NULL,
    [_CASS_STD_ZIP4] VARCHAR(5) NULL,
    [_CASS_STD_DPBC] VARCHAR(3) NULL,
    [_CASS_STD_CHKDGT] VARCHAR(2) NULL,
    [_CASS_STD_CART] VARCHAR(5) NULL,
    [_CASS_STD_LOT] VARCHAR(5) NULL,
    [_CASS_STD_LOTORD] VARCHAR(2) NULL,
    [_CASS_STD_URB] VARCHAR(1) NULL,
    [_CASS_STD_FIPS] VARCHAR(1) NULL,
    [_CASS_STD_EWS] VARCHAR(2) NULL,
    [_CASS_STD_LACS] VARCHAR(2) NULL,
    [_CASS_STD_ZIPMOV] VARCHAR(2) NULL,
    [_CASS_STD_Z4LOM] VARCHAR(3) NULL,
    [_CASS_STD_NDIAPT] VARCHAR(2) NULL,
    [_CASS_STD_NDIRR] VARCHAR(1) NULL,
    [_CASS_STD_LACSRT] VARCHAR(3) NULL,
    [_CASS_STD_ERROR_CD] VARCHAR(5) NULL
);

CREATE TABLE [zzz_DealerVault_SV_APPT] (
    [_File_Type] VARCHAR(13) NULL,
    [_DV_Dealer_ID] VARCHAR(9) NULL,
    [_Vendor_Dealer_ID] VARCHAR(10) NULL,
    [_DMS_Type] VARCHAR(12) NULL,
    [_Appointment_Number] VARCHAR(7) NULL,
    [_Appointment_Date] VARCHAR(11) NULL,
    [_Appointment_Time] VARCHAR(9) NULL,
    [_Appointment_Create_Date] VARCHAR(11) NULL,
    [_RO_Number] VARCHAR(7) NULL,
    [_Last_RO_Miles] INT NULL,
    [_Last_RO_Date] VARCHAR(11) NULL,
    [_Promise_Date] VARCHAR(11) NULL,
    [_Promise_Time] VARCHAR(8) NULL,
    [_Cause] VARCHAR(1) NULL,
    [_Complaint] VARCHAR(940) NULL,
    [_Comment] VARCHAR(335) NULL,
    [_Operation_Code] VARCHAR(82) NULL,
    [_Operation_Code_Description] VARCHAR(863) NULL,
    [_Recommended_Operation_Code] VARCHAR(174) NULL,
    [_Recommended_Operation_Code_Description] VARCHAR(275) NULL,
    [_Service_Advisor_Number] VARCHAR(7) NULL,
    [_Service_Advisor_Name] VARCHAR(21) NULL,
    [_Sale_Type] VARCHAR(14) NULL,
    [_Waiting_Flag] VARCHAR(1) NULL,
    [_Loaner_Flag] VARCHAR(2) NULL,
    [_Alternate_Transportation] VARCHAR(2) NULL,
    [_Estimate_Time] VARCHAR(28) NULL,
    [_Estimate_Amount] VARCHAR(64) NULL,
    [_Tag_Number] VARCHAR(1) NULL,
    [_VIN] VARCHAR(18) NULL,
    [_Year] VARCHAR(5) NULL,
    [_Make] VARCHAR(21) NULL,
    [_Model] VARCHAR(21) NULL,
    [_Model_Number] VARCHAR(10) NULL,
    [_Appointment_Mileage] INT NULL,
    [_Description] VARCHAR(22) NULL,
    [_Exterior_Color] VARCHAR(256) NULL,
    [_Stock_Number] VARCHAR(9) NULL,
    [_Transmission] VARCHAR(2) NULL,
    [_Engine_Configuration] VARCHAR(1) NULL,
    [_Trim] VARCHAR(1) NULL,
    [_Engine_Number] VARCHAR(4) NULL,
    [_Chassis_Number] VARCHAR(1) NULL,
    [_License_Plate_Number] VARCHAR(9) NULL,
    [_Delivery_Date] VARCHAR(11) NULL,
    [_Delivery_Mileage] INT NULL,
    [_In_Service_Date] VARCHAR(11) NULL,
    [_VIN_Explosion_Year] VARCHAR(5) NULL,
    [_VIN_Explosion_Make] VARCHAR(14) NULL,
    [_VIN_Explosion_Model] VARCHAR(29) NULL,
    [_VIN_Explosion_Trim] VARCHAR(48) NULL,
    [_VIN_Explosion_Transmission_Type] VARCHAR(7) NULL,
    [_VIN_Explosion_Fuel_Type] VARCHAR(20) NULL,
    [_VIN_Explosion_Engine_Size] VARCHAR(5) NULL,
    [_VIN_Explosion_GVW_Range] VARCHAR(16) NULL,
    [_Customer_Number] VARCHAR(10) NULL,
    [_Full_Name] VARCHAR(43) NULL,
    [_Salutation] VARCHAR(11) NULL,
    [_First_Name] VARCHAR(23) NULL,
    [_Middle_Name] VARCHAR(12) NULL,
    [_Last_Name] VARCHAR(36) NULL,
    [_Suffix] VARCHAR(4) NULL,
    [_Address_Line_1] VARCHAR(48) NULL,
    [_Address_Line_2] VARCHAR(31) NULL,
    [_City] VARCHAR(21) NULL,
    [_State] VARCHAR(3) NULL,
    [_Zip] VARCHAR(11) NULL,
    [_County] VARCHAR(17) NULL,
    [_Home_Phone] VARCHAR(15) NULL,
    [_Cell_Phone] VARCHAR(15) NULL,
    [_Work_Phone] VARCHAR(15) NULL,
    [_Work_Extension] VARCHAR(15) NULL,
    [_Email_1] VARCHAR(40) NULL,
    [_Email_2] VARCHAR(1) NULL,
    [_Email_3] VARCHAR(1) NULL,
    [_Birth_Date] VARCHAR(11) NULL,
    [_Individual_Business_Flag] VARCHAR(2) NULL,
    [_Opt_Out] VARCHAR(2) NULL,
    [_Block_Email] VARCHAR(2) NULL,
    [_Block_Phone] VARCHAR(2) NULL,
    [_Block_Mail] VARCHAR(2) NULL,
    [_Language] VARCHAR(1) NULL,
    [_Customer_Create_Date] VARCHAR(11) NULL,
    [_Customer_Last_Activity_Date] VARCHAR(11) NULL,
    [_CASS_STD_LINE1] VARCHAR(40) NULL,
    [_CASS_STD_LINE2] VARCHAR(18) NULL,
    [_CASS_STD_CITY] VARCHAR(28) NULL,
    [_CASS_STD_STATE] VARCHAR(3) NULL,
    [_CASS_STD_ZIP] VARCHAR(6) NULL,
    [_CASS_STD_ZIP4] VARCHAR(5) NULL,
    [_CASS_STD_DPBC] VARCHAR(3) NULL,
    [_CASS_STD_CHKDGT] VARCHAR(2) NULL,
    [_CASS_STD_CART] VARCHAR(5) NULL,
    [_CASS_STD_LOT] VARCHAR(5) NULL,
    [_CASS_STD_LOTORD] VARCHAR(2) NULL,
    [_CASS_STD_URB] VARCHAR(1) NULL,
    [_CASS_STD_FIPS] VARCHAR(1) NULL,
    [_CASS_STD_EWS] VARCHAR(2) NULL,
    [_CASS_STD_LACS] VARCHAR(2) NULL,
    [_CASS_STD_ZIPMOV] VARCHAR(2) NULL,
    [_CASS_STD_Z4LOM] VARCHAR(3) NULL,
    [_CASS_STD_NDIAPT] VARCHAR(2) NULL,
    [_CASS_STD_NDIRR] VARCHAR(1) NULL,
    [_CASS_STD_LACSRT] VARCHAR(3) NULL,
    [_CASS_STD_ERROR_CD] VARCHAR(5) NULL
);

CREATE TABLE [zzz_DealerVault_SV_APPT_TEMP] (
    [_File_Type] VARCHAR(13) NULL,
    [_DV_Dealer_ID] VARCHAR(9) NULL,
    [_Vendor_Dealer_ID] VARCHAR(10) NULL,
    [_DMS_Type] VARCHAR(12) NULL,
    [_Appointment_Number] VARCHAR(7) NULL,
    [_Appointment_Date] VARCHAR(11) NULL,
    [_Appointment_Time] VARCHAR(9) NULL,
    [_Appointment_Create_Date] VARCHAR(11) NULL,
    [_RO_Number] VARCHAR(7) NULL,
    [_Last_RO_Miles] INT NULL,
    [_Last_RO_Date] VARCHAR(11) NULL,
    [_Promise_Date] VARCHAR(11) NULL,
    [_Promise_Time] VARCHAR(8) NULL,
    [_Cause] VARCHAR(1) NULL,
    [_Complaint] VARCHAR(940) NULL,
    [_Comment] VARCHAR(335) NULL,
    [_Operation_Code] VARCHAR(82) NULL,
    [_Operation_Code_Description] VARCHAR(863) NULL,
    [_Recommended_Operation_Code] VARCHAR(174) NULL,
    [_Recommended_Operation_Code_Description] VARCHAR(275) NULL,
    [_Service_Advisor_Number] VARCHAR(7) NULL,
    [_Service_Advisor_Name] VARCHAR(21) NULL,
    [_Sale_Type] VARCHAR(14) NULL,
    [_Waiting_Flag] VARCHAR(1) NULL,
    [_Loaner_Flag] VARCHAR(2) NULL,
    [_Alternate_Transportation] VARCHAR(2) NULL,
    [_Estimate_Time] VARCHAR(28) NULL,
    [_Estimate_Amount] VARCHAR(64) NULL,
    [_Tag_Number] VARCHAR(1) NULL,
    [_VIN] VARCHAR(18) NULL,
    [_Year] VARCHAR(5) NULL,
    [_Make] VARCHAR(21) NULL,
    [_Model] VARCHAR(21) NULL,
    [_Model_Number] VARCHAR(10) NULL,
    [_Appointment_Mileage] INT NULL,
    [_Description] VARCHAR(22) NULL,
    [_Exterior_Color] VARCHAR(256) NULL,
    [_Stock_Number] VARCHAR(9) NULL,
    [_Transmission] VARCHAR(2) NULL,
    [_Engine_Configuration] VARCHAR(1) NULL,
    [_Trim] VARCHAR(1) NULL,
    [_Engine_Number] VARCHAR(4) NULL,
    [_Chassis_Number] VARCHAR(1) NULL,
    [_License_Plate_Number] VARCHAR(9) NULL,
    [_Delivery_Date] VARCHAR(11) NULL,
    [_Delivery_Mileage] INT NULL,
    [_In_Service_Date] VARCHAR(11) NULL,
    [_VIN_Explosion_Year] VARCHAR(5) NULL,
    [_VIN_Explosion_Make] VARCHAR(14) NULL,
    [_VIN_Explosion_Model] VARCHAR(29) NULL,
    [_VIN_Explosion_Trim] VARCHAR(48) NULL,
    [_VIN_Explosion_Transmission_Type] VARCHAR(7) NULL,
    [_VIN_Explosion_Fuel_Type] VARCHAR(20) NULL,
    [_VIN_Explosion_Engine_Size] VARCHAR(5) NULL,
    [_VIN_Explosion_GVW_Range] VARCHAR(16) NULL,
    [_Customer_Number] VARCHAR(10) NULL,
    [_Full_Name] VARCHAR(43) NULL,
    [_Salutation] VARCHAR(11) NULL,
    [_First_Name] VARCHAR(23) NULL,
    [_Middle_Name] VARCHAR(12) NULL,
    [_Last_Name] VARCHAR(36) NULL,
    [_Suffix] VARCHAR(4) NULL,
    [_Address_Line_1] VARCHAR(48) NULL,
    [_Address_Line_2] VARCHAR(31) NULL,
    [_City] VARCHAR(21) NULL,
    [_State] VARCHAR(3) NULL,
    [_Zip] VARCHAR(11) NULL,
    [_County] VARCHAR(17) NULL,
    [_Home_Phone] VARCHAR(15) NULL,
    [_Cell_Phone] VARCHAR(15) NULL,
    [_Work_Phone] VARCHAR(15) NULL,
    [_Work_Extension] VARCHAR(15) NULL,
    [_Email_1] VARCHAR(40) NULL,
    [_Email_2] VARCHAR(1) NULL,
    [_Email_3] VARCHAR(1) NULL,
    [_Birth_Date] VARCHAR(11) NULL,
    [_Individual_Business_Flag] VARCHAR(2) NULL,
    [_Opt_Out] VARCHAR(2) NULL,
    [_Block_Email] VARCHAR(2) NULL,
    [_Block_Phone] VARCHAR(2) NULL,
    [_Block_Mail] VARCHAR(2) NULL,
    [_Language] VARCHAR(1) NULL,
    [_Customer_Create_Date] VARCHAR(11) NULL,
    [_Customer_Last_Activity_Date] VARCHAR(11) NULL,
    [_CASS_STD_LINE1] VARCHAR(40) NULL,
    [_CASS_STD_LINE2] VARCHAR(18) NULL,
    [_CASS_STD_CITY] VARCHAR(28) NULL,
    [_CASS_STD_STATE] VARCHAR(3) NULL,
    [_CASS_STD_ZIP] VARCHAR(6) NULL,
    [_CASS_STD_ZIP4] VARCHAR(5) NULL,
    [_CASS_STD_DPBC] VARCHAR(3) NULL,
    [_CASS_STD_CHKDGT] VARCHAR(2) NULL,
    [_CASS_STD_CART] VARCHAR(5) NULL,
    [_CASS_STD_LOT] VARCHAR(5) NULL,
    [_CASS_STD_LOTORD] VARCHAR(2) NULL,
    [_CASS_STD_URB] VARCHAR(1) NULL,
    [_CASS_STD_FIPS] VARCHAR(1) NULL,
    [_CASS_STD_EWS] VARCHAR(2) NULL,
    [_CASS_STD_LACS] VARCHAR(2) NULL,
    [_CASS_STD_ZIPMOV] VARCHAR(2) NULL,
    [_CASS_STD_Z4LOM] VARCHAR(3) NULL,
    [_CASS_STD_NDIAPT] VARCHAR(2) NULL,
    [_CASS_STD_NDIRR] VARCHAR(1) NULL,
    [_CASS_STD_LACSRT] VARCHAR(3) NULL,
    [_CASS_STD_ERROR_CD] VARCHAR(5) NULL
);

CREATE TABLE [zzz_DealerVault_SV_TEMP] (
    [_File_Type] VARCHAR(8) NULL,
    [_DV_Dealer_ID] VARCHAR(9) NULL,
    [_Vendor_Dealer_ID] VARCHAR(10) NULL,
    [_DMS_Type] VARCHAR(12) NULL,
    [_RO_Number] VARCHAR(9) NULL,
    [_Open_Date] VARCHAR(11) NULL,
    [_Close_Date] VARCHAR(11) NULL,
    [_Service_Advisor_Number] VARCHAR(7) NULL,
    [_Service_Advisor_Name] VARCHAR(21) NULL,
    [_RO_Department] VARCHAR(2) NULL,
    [_RO_Store] VARCHAR(9) NULL,
    [_Appointment_Date] VARCHAR(11) NULL,
    [_Appointment_Flag] VARCHAR(2) NULL,
    [_Appointment_Number] VARCHAR(7) NULL,
    [_Appointment_Department] VARCHAR(1) NULL,
    [_Accounting_Make] VARCHAR(3) NULL,
    [_Pickup_Date] VARCHAR(10) NULL,
    [_Pickup_Time] VARCHAR(1) NULL,
    [_Post_Time] VARCHAR(8) NULL,
    [_Promise_Date] VARCHAR(11) NULL,
    [_Promise_Time] VARCHAR(6) NULL,
    [_Payment_Method] VARCHAR(30) NULL,
    [_RO_Status] VARCHAR(9) NULL,
    [_Print_Time] VARCHAR(9) NULL,
    [_Salesman_Name] VARCHAR(21) NULL,
    [_Salesman_Number] VARCHAR(7) NULL,
    [_Service_Contract_Name] VARCHAR(30) NULL,
    [_Service_Contract_Number] VARCHAR(26) NULL,
    [_Tag_Number] VARCHAR(5) NULL,
    [_Warranty_Expiration_Date] VARCHAR(11) NULL,
    [_Warranty_Expiration_Miles] INT NULL,
    [_Total_Cost] MONEY NULL,
    [_Total_Sale] MONEY NULL,
    [_Customer_Total_Cost] MONEY NULL,
    [_Customer_Total_Sale] MONEY NULL,
    [_Customer_Labor_Cost] MONEY NULL,
    [_Customer_Labor_Sale] MONEY NULL,
    [_Customer_Parts_Cost] MONEY NULL,
    [_Customer_Parts_Sale] MONEY NULL,
    [_Customer_Misc_Cost] MONEY NULL,
    [_Customer_Misc_Sale] MONEY NULL,
    [_Customer_Gas_Oil_Grease_Cost] MONEY NULL,
    [_Customer_Gas_Oil_Grease_Sale] MONEY NULL,
    [_Customer_Sublet_Cost] MONEY NULL,
    [_Customer_Sublet_Sale] MONEY NULL,
    [_Warranty_Total_Cost] MONEY NULL,
    [_Warranty_Total_Sale] MONEY NULL,
    [_Warranty_Labor_Cost] MONEY NULL,
    [_Warranty_Labor_Sale] MONEY NULL,
    [_Warranty_Parts_Cost] MONEY NULL,
    [_Warranty_Parts_Sale] MONEY NULL,
    [_Warranty_Misc_Cost] MONEY NULL,
    [_Warranty_Misc_Sale] MONEY NULL,
    [_Warranty_Gas_Oil_Grease_Cost] MONEY NULL,
    [_Warranty_Gas_Oil_Grease_Sale] MONEY NULL,
    [_Warranty_Sublet_Cost] MONEY NULL,
    [_Warranty_Sublet_Sale] MONEY NULL,
    [_Internal_Total_Cost] MONEY NULL,
    [_Internal_Total_Sale] MONEY NULL,
    [_Internal_Labor_Cost] MONEY NULL,
    [_Internal_Labor_Sale] MONEY NULL,
    [_Internal_Parts_Cost] MONEY NULL,
    [_Internal_Parts_Sale] MONEY NULL,
    [_Internal_Misc_Cost] MONEY NULL,
    [_Internal_Misc_Sale] MONEY NULL,
    [_Internal_Gas_Oil_Grease_Cost] MONEY NULL,
    [_Internal_Gas_Oil_Grease_Sale] MONEY NULL,
    [_Internal_Sublet_Cost] MONEY NULL,
    [_Internal_Sublet_Sale] MONEY NULL,
    [_Total_Labor_Cost] MONEY NULL,
    [_Total_Labor_Sale] MONEY NULL,
    [_Total_Parts_Cost] MONEY NULL,
    [_Total_Parts_Sale] MONEY NULL,
    [_Total_Misc_Cost] MONEY NULL,
    [_Total_Misc_Sale] MONEY NULL,
    [_Total_Gas_Oil_Grease_Cost] MONEY NULL,
    [_Total_Gas_Oil_Grease_Sale] MONEY NULL,
    [_Total_Sublet_Cost] MONEY NULL,
    [_Total_Sublet_Sale] MONEY NULL,
    [_Total_Misc_Code_Sale] MONEY NULL,
    [_Total_Tax] MONEY NULL,
    [_Customer_Total_Tax] MONEY NULL,
    [_Warranty_Total_Tax] MONEY NULL,
    [_Internal_Total_Tax] MONEY NULL,
    [_Operation_Codes] VARCHAR(197) NULL,
    [_Operation_Code_Descriptions] VARCHAR(405) NULL,
    [_Tech_Labor_Line] VARCHAR(54) NULL,
    [_Tech_Number] VARCHAR(196) NULL,
    [_Tech_Name] VARCHAR(880) NULL,
    [_Upsell] VARCHAR(340) NULL,
    [_Labor_Cause] VARCHAR(2367) NULL,
    [_Labor_Complaint] VARCHAR(1951) NULL,
    [_Labor_Correction] VARCHAR(1475) NULL,
    [_Labor_Comments] VARCHAR(2344) NULL,
    [_Recommended_Operation_Codes] VARCHAR(183) NULL,
    [_Recommendations] VARCHAR(1950) NULL,
    [_Operation_Line_Number] VARCHAR(54) NULL,
    [_Operation_Sale_Types] VARCHAR(42) NULL,
    [_Operation_Line_Cost] VARCHAR(128) NULL,
    [_Operation_Line_Sale] VARCHAR(138) NULL,
    [_Labor_Cost] VARCHAR(123) NULL,
    [_Labor_Sale] VARCHAR(134) NULL,
    [_Parts_Cost] VARCHAR(297) NULL,
    [_Parts_Sale] VARCHAR(300) NULL,
    [_Misc_Cost] VARCHAR(68) NULL,
    [_Misc_Sale] VARCHAR(75) NULL,
    [_Gas_Oil_Grease_Cost] VARCHAR(37) NULL,
    [_Gas_Oil_Grease_Sale] VARCHAR(39) NULL,
    [_Sublet_Cost] VARCHAR(32) NULL,
    [_Sublet_Sale] VARCHAR(32) NULL,
    [_Labor_Tech_Hours] VARCHAR(246) NULL,
    [_Labor_Bill_Hours] VARCHAR(62) NULL,
    [_Labor_Tech_Rate] VARCHAR(343) NULL,
    [_Labor_Bill_Rate] VARCHAR(146) NULL,
    [_Parts_Labor_Line_Number] VARCHAR(115) NULL,
    [_Parts_Line_Number] VARCHAR(115) NULL,
    [_Parts_Sale_Type] VARCHAR(108) NULL,
    [_Part_Number] VARCHAR(623) NULL,
    [_Part_Description] VARCHAR(658) NULL,
    [_Part_Quantity] VARCHAR(109) NULL,
    [_Parts_Unit_Cost] VARCHAR(297) NULL,
    [_Parts_Unit_Sale] VARCHAR(300) NULL,
    [_VIN] VARCHAR(18) NULL,
    [_Year] VARCHAR(5) NULL,
    [_Make] VARCHAR(21) NULL,
    [_Model] VARCHAR(29) NULL,
    [_Model_Number] VARCHAR(10) NULL,
    [_RO_Mileage] INT NULL,
    [_Mileage_Out] INT NULL,
    [_Description] VARCHAR(33) NULL,
    [_Exterior_Color] VARCHAR(256) NULL,
    [_New_Used] VARCHAR(2) NULL,
    [_Stock_Number] VARCHAR(9) NULL,
    [_Transmission] VARCHAR(2) NULL,
    [_Engine_Configuration] VARCHAR(1) NULL,
    [_Trim] VARCHAR(1) NULL,
    [_Engine_Number] VARCHAR(13) NULL,
    [_Chassis_Number] VARCHAR(5) NULL,
    [_License_Plate_Number] VARCHAR(11) NULL,
    [_Delivery_Date] VARCHAR(11) NULL,
    [_Delivery_Mileage] INT NULL,
    [_In_Service_Date] VARCHAR(11) NULL,
    [_VIN_Explosion_Year] VARCHAR(5) NULL,
    [_VIN_Explosion_Make] VARCHAR(14) NULL,
    [_VIN_Explosion_Model] VARCHAR(51) NULL,
    [_VIN_Explosion_Trim] VARCHAR(48) NULL,
    [_VIN_Explosion_Transmission_Type] VARCHAR(7) NULL,
    [_VIN_Explosion_Fuel_Type] VARCHAR(20) NULL,
    [_VIN_Explosion_Engine_Size] VARCHAR(5) NULL,
    [_VIN_Explosion_GVW_Range] VARCHAR(16) NULL,
    [_Customer_Number] VARCHAR(10) NULL,
    [_Full_Name] VARCHAR(43) NULL,
    [_Salutation] VARCHAR(11) NULL,
    [_First_Name] VARCHAR(24) NULL,
    [_Middle_Name] VARCHAR(16) NULL,
    [_Last_Name] VARCHAR(36) NULL,
    [_Suffix] VARCHAR(5) NULL,
    [_Address_Line_1] VARCHAR(37) NULL,
    [_Address_Line_2] VARCHAR(30) NULL,
    [_City] VARCHAR(21) NULL,
    [_State] VARCHAR(11) NULL,
    [_Zip] VARCHAR(11) NULL,
    [_County] VARCHAR(19) NULL,
    [_Home_Phone] VARCHAR(15) NULL,
    [_Cell_Phone] VARCHAR(15) NULL,
    [_Work_Phone] VARCHAR(15) NULL,
    [_Work_Extension] VARCHAR(9) NULL,
    [_Email_1] VARCHAR(41) NULL,
    [_Email_2] VARCHAR(34) NULL,
    [_Email_3] VARCHAR(1) NULL,
    [_Birth_Date] VARCHAR(11) NULL,
    [_Individual_Business_Flag] VARCHAR(2) NULL,
    [_Opt_Out] VARCHAR(2) NULL,
    [_Block_Email] VARCHAR(2) NULL,
    [_Block_Phone] VARCHAR(2) NULL,
    [_Block_Mail] VARCHAR(2) NULL,
    [_Language] VARCHAR(1) NULL,
    [_Customer_Create_Date] VARCHAR(11) NULL,
    [_Customer_Last_Activity_Date] VARCHAR(11) NULL,
    [_CASS_STD_LINE1] VARCHAR(34) NULL,
    [_CASS_STD_LINE2] VARCHAR(17) NULL,
    [_CASS_STD_CITY] VARCHAR(28) NULL,
    [_CASS_STD_STATE] VARCHAR(3) NULL,
    [_CASS_STD_ZIP] VARCHAR(6) NULL,
    [_CASS_STD_ZIP4] VARCHAR(5) NULL,
    [_CASS_STD_DPBC] VARCHAR(3) NULL,
    [_CASS_STD_CHKDGT] VARCHAR(2) NULL,
    [_CASS_STD_CART] VARCHAR(5) NULL,
    [_CASS_STD_LOT] VARCHAR(5) NULL,
    [_CASS_STD_LOTORD] VARCHAR(2) NULL,
    [_CASS_STD_URB] VARCHAR(1) NULL,
    [_CASS_STD_FIPS] VARCHAR(1) NULL,
    [_CASS_STD_EWS] VARCHAR(2) NULL,
    [_CASS_STD_LACS] VARCHAR(2) NULL,
    [_CASS_STD_ZIPMOV] VARCHAR(2) NULL,
    [_CASS_STD_Z4LOM] VARCHAR(3) NULL,
    [_CASS_STD_NDIAPT] VARCHAR(2) NULL,
    [_CASS_STD_NDIRR] VARCHAR(1) NULL,
    [_CASS_STD_LACSRT] VARCHAR(3) NULL,
    [_CASS_STD_ERROR_CD] VARCHAR(5) NULL
);

CREATE TABLE [zzz_Dealervault_XLS_Match] (
    [ID] BIGINT NOT NULL,
    [ImportDate] DATETIME NOT NULL,
    [acc_ID] BIGINT NOT NULL,
    [PurchaseNumber] INT NULL,
    [PurchaseDate] DATE NULL,
    [PurchasePrice] MONEY NULL,
    [VIN] VARCHAR(32) NULL,
    [First_Name] VARCHAR(32) NULL,
    [Last_Name] VARCHAR(32) NULL,
    [Cell_Phone] VARCHAR(32) NULL,
    [Email_1] VARCHAR(128) NULL,
    [Email_2] VARCHAR(128) NULL,
    [Home_Phone] VARCHAR(32) NULL,
    [Work_Phone] VARCHAR(32) NULL,
    [Other_Phone] VARCHAR(32) NULL
);

CREATE TABLE [zzz_DealerVaultData] (
    [File_Type] VARCHAR(20) NULL,
    [DV_Dealer_ID] VARCHAR(48) NULL,
    [Delegate_Dealer_ID] VARCHAR(44) NULL,
    [DMS_Type] VARCHAR(43) NULL,
    [Deal_Number] VARCHAR(46) NULL,
    [Customer_Number] VARCHAR(47) NULL,
    [Full_Name] VARCHAR(46) NULL,
    [Salutation] VARCHAR(40) NULL,
    [First_Name] VARCHAR(45) NULL,
    [Middle_Name] VARCHAR(42) NULL,
    [Last_Name] VARCHAR(49) NULL,
    [Suffix] VARCHAR(45) NULL,
    [Address_Line_1] VARCHAR(45) NULL,
    [Address_Line_2] VARCHAR(40) NULL,
    [City] VARCHAR(44) NULL,
    [State] VARCHAR(42) NULL,
    [Zip] VARCHAR(45) NULL,
    [County] VARCHAR(45) NULL,
    [Home_Phone] VARCHAR(44) NULL,
    [Cell_Phone] VARCHAR(44) NULL,
    [Work_Phone] VARCHAR(44) NULL,
    [Work_Extension] VARCHAR(45) NULL,
    [Email_1] VARCHAR(49) NULL,
    [Email_2] VARCHAR(40) NULL,
    [Email_3] VARCHAR(40) NULL,
    [Birth_Date] VARCHAR(45) NULL,
    [Individual_Business_Flag] VARCHAR(41) NULL,
    [Opt_Out] VARCHAR(45) NULL,
    [Block_Email] VARCHAR(45) NULL,
    [Block_Phone] VARCHAR(45) NULL,
    [Block_Mail] VARCHAR(45) NULL,
    [Language] VARCHAR(42) NULL,
    [Customer_Create_Date] VARCHAR(45) NULL,
    [Customer_Last_Activity_Date] VARCHAR(45) NULL,
    [CoBuyer_Customer_Number] VARCHAR(416) NULL,
    [CoBuyer_Full_Name] VARCHAR(49) NULL,
    [CoBuyer_Salutation] VARCHAR(45) NULL,
    [CoBuyer_First_Name] VARCHAR(48) NULL,
    [CoBuyer_Middle_Name] VARCHAR(41) NULL,
    [CoBuyer_Last_Name] VARCHAR(46) NULL,
    [CoBuyer_Suffix] VARCHAR(45) NULL,
    [CoBuyer_Address_Line_1] VARCHAR(45) NULL,
    [CoBuyer_Address_Line_2] VARCHAR(45) NULL,
    [CoBuyer_City] VARCHAR(44) NULL,
    [CoBuyer_State] VARCHAR(42) NULL,
    [CoBuyer_Zip] VARCHAR(45) NULL,
    [CoBuyer_County] VARCHAR(45) NULL,
    [CoBuyer_Home_Phone] VARCHAR(45) NULL,
    [CoBuyer_Cell_Phone] VARCHAR(45) NULL,
    [CoBuyer_Work_Phone] VARCHAR(45) NULL,
    [CoBuyer_Work_Extension] VARCHAR(45) NULL,
    [CoBuyer_Email_1] VARCHAR(45) NULL,
    [CoBuyer_Email_2] VARCHAR(45) NULL,
    [CoBuyer_Email_3] VARCHAR(45) NULL,
    [CoBuyer_Birth_Date] VARCHAR(40) NULL,
    [CoBuyer_Individual_Business_Flag] VARCHAR(45) NULL,
    [CoBuyer_Opt_Out] VARCHAR(60) NULL,
    [CoBuyer_Block_Email] VARCHAR(45) NULL,
    [CoBuyer_Block_Phone] VARCHAR(45) NULL,
    [CoBuyer_Block_Mail] VARCHAR(45) NULL,
    [VIN] VARCHAR(47) NULL,
    [Year] VARCHAR(42) NULL,
    [Make] VARCHAR(44) NULL,
    [Model] VARCHAR(46) NULL,
    [Model_Number] VARCHAR(49) NULL,
    [Mileage] VARCHAR(45) NULL,
    [Description] VARCHAR(47) NULL,
    [Exterior_Color] VARCHAR(48) NULL,
    [New_Used] VARCHAR(44) NULL,
    [Stock_Number] VARCHAR(45) NULL,
    [Transmission] VARCHAR(45) NULL,
    [Engine_Configuration] VARCHAR(45) NULL,
    [Trim] VARCHAR(45) NULL,
    [Engine_Number] VARCHAR(45) NULL,
    [Chassis_Number] VARCHAR(45) NULL,
    [License_Plate_Number] VARCHAR(45) NULL,
    [Delivery_Date] VARCHAR(45) NULL,
    [Delivery_Mileage] VARCHAR(45) NULL,
    [Inventory_Date] VARCHAR(45) NULL,
    [In_Service_Date] VARCHAR(45) NULL,
    [VIN_Explosion_Year] VARCHAR(44) NULL,
    [VIN_Explosion_Make] VARCHAR(49) NULL,
    [VIN_Explosion_Model] VARCHAR(42) NULL,
    [VIN_Explosion_Trim] VARCHAR(46) NULL,
    [VIN_Explosion_Transmission_Type] VARCHAR(44) NULL,
    [VIN_Explosion_Fuel_Type] VARCHAR(48) NULL,
    [VIN_Explosion_Engine_Size] VARCHAR(44) NULL,
    [VIN_Explosion_GVW_Range] VARCHAR(45) NULL,
    [Trade_1_VIN] VARCHAR(47) NULL,
    [Trade_1_Year] VARCHAR(42) NULL,
    [Trade_1_Make] VARCHAR(44) NULL,
    [Trade_1_Model] VARCHAR(48) NULL,
    [Trade_1_Odometer] VARCHAR(46) NULL,
    [Trade_1_Actual_Cash_Value] VARCHAR(45) NULL,
    [Trade_1_Gross] VARCHAR(45) NULL,
    [Trade_1_Payoff] VARCHAR(48) NULL,
    [Trade_2_VIN] VARCHAR(45) NULL,
    [Trade_2_Year] VARCHAR(45) NULL,
    [Trade_2_Make] VARCHAR(45) NULL,
    [Trade_2_Model] VARCHAR(43) NULL,
    [Trade_2_Odometer] VARCHAR(45) NULL,
    [Trade_2_Actual_Cash_Value] VARCHAR(45) NULL,
    [Trade_2_Gross] VARCHAR(45) NULL,
    [Trade_2_Payoff] VARCHAR(45) NULL,
    [Salesman_1_Number] VARCHAR(44) NULL,
    [Salesman_1_Name] VARCHAR(46) NULL,
    [Salesman_2_Number] VARCHAR(44) NULL,
    [Salesman_2_Name] VARCHAR(45) NULL,
    [Salesman_3_Number] VARCHAR(45) NULL,
    [Salesman_3_Name] VARCHAR(45) NULL,
    [Closing_Manager_Number] VARCHAR(45) NULL,
    [Closing_Manager_Name] VARCHAR(42) NULL,
    [Finance_Manager_Number] VARCHAR(45) NULL,
    [Finance_Manager_Name] VARCHAR(45) NULL,
    [Salesman_Manager_Number] VARCHAR(45) NULL,
    [Salesman_Manager_Name] VARCHAR(48) NULL,
    [MSRP] VARCHAR(45) NULL,
    [List_Price] VARCHAR(45) NULL,
    [Sales_Price] VARCHAR(48) NULL,
    [Journal_Price] VARCHAR(45) NULL,
    [Cost] VARCHAR(48) NULL,
    [Journal_Cost] VARCHAR(48) NULL,
    [Adjustments] VARCHAR(45) NULL,
    [Adjusted_Cost] VARCHAR(48) NULL,
    [Incentives] VARCHAR(41) NULL,
    [Pack_Amount] VARCHAR(43) NULL,
    [Sale_Net] VARCHAR(47) NULL,
    [Total_Trade_Actual_Cash_Value] VARCHAR(45) NULL,
    [Total_Trade_Gross] VARCHAR(45) NULL,
    [We_Owe_Front] VARCHAR(46) NULL,
    [Total_Front_Fees_Aftermarket_Profit] VARCHAR(45) NULL,
    [Total_Front_Commission] VARCHAR(45) NULL,
    [Total_Front_Sales] VARCHAR(48) NULL,
    [Total_Front_Cost] VARCHAR(48) NULL,
    [Front_Gross] VARCHAR(48) NULL,
    [Finance_Profit] VARCHAR(47) NULL,
    [Total_Warranty_Profit] VARCHAR(44) NULL,
    [We_Owe_Back] VARCHAR(41) NULL,
    [Insurance_Profit] VARCHAR(44) NULL,
    [Total_Back_Fees_Aftermarket_Profit] VARCHAR(43) NULL,
    [Finance_Reserve] VARCHAR(45) NULL,
    [Total_Back_Commission] VARCHAR(45) NULL,
    [Total_Back_Sales] VARCHAR(45) NULL,
    [Total_Back_Cost] VARCHAR(45) NULL,
    [Back_Gross] VARCHAR(48) NULL,
    [Total_Profit] VARCHAR(47) NULL,
    [Gross_Profit] VARCHAR(47) NULL,
    [Gross_Payable] VARCHAR(48) NULL,
    [Deal_Status] VARCHAR(41) NULL,
    [Entry_Date] VARCHAR(45) NULL,
    [Booked_Date] VARCHAR(45) NULL,
    [Finalized_Date] VARCHAR(45) NULL,
    [Contract_Date] VARCHAR(45) NULL,
    [Accounting_Date] VARCHAR(45) NULL,
    [Status_Change_Date] VARCHAR(45) NULL,
    [First_Pay_Date] VARCHAR(45) NULL,
    [Deal_Type] VARCHAR(41) NULL,
    [Sale_Type] VARCHAR(41) NULL,
    [Bank_ID] VARCHAR(45) NULL,
    [Bank_Name] VARCHAR(44) NULL,
    [Bank_Address] VARCHAR(49) NULL,
    [Term] VARCHAR(42) NULL,
    [Amount_Financed] VARCHAR(48) NULL,
    [APR] VARCHAR(45) NULL,
    [Monthly_Payment] VARCHAR(46) NULL,
    [Payment_Total] VARCHAR(48) NULL,
    [Rebates] VARCHAR(45) NULL,
    [Deposit] VARCHAR(45) NULL,
    [Down_Payment] VARCHAR(44) NULL,
    [Total_Net_Trades] VARCHAR(48) NULL,
    [Total_Down] VARCHAR(48) NULL,
    [Balloon_Amount] VARCHAR(45) NULL,
    [Adjusted_Balloon_Amount] VARCHAR(45) NULL,
    [Holdback_Amount] VARCHAR(45) NULL,
    [Total_Drive_Off_Amount] VARCHAR(44) NULL,
    [License_Fee] VARCHAR(45) NULL,
    [Registration_Fee] VARCHAR(45) NULL,
    [Documentation_Fee] VARCHAR(45) NULL,
    [Finance_Charge] VARCHAR(48) NULL,
    [Total_Pickup_Payments] VARCHAR(41) NULL,
    [Sell_Rate] VARCHAR(47) NULL,
    [Buy_Rate] VARCHAR(47) NULL,
    [Residual_Rate] VARCHAR(42) NULL,
    [Residual_Amount] VARCHAR(48) NULL,
    [Allowed_Miles] VARCHAR(45) NULL,
    [Estimated_Miles] VARCHAR(45) NULL,
    [Mileage_Rate] VARCHAR(44) NULL,
    [Acquisition_Fee] VARCHAR(45) NULL,
    [Base_Payment] VARCHAR(46) NULL,
    [Security_Deposit] VARCHAR(45) NULL,
    [Total_Capital_Reduction] VARCHAR(47) NULL,
    [Net_Capital_Cost] VARCHAR(48) NULL,
    [Lease_Depreciation_Value] VARCHAR(48) NULL,
    [Dealer_Fees] VARCHAR(45) NULL,
    [Government_Fees] VARCHAR(45) NULL,
    [Total_Tax] VARCHAR(47) NULL,
    [Registration_State] VARCHAR(45) NULL,
    [Report_of_Sale_Number] VARCHAR(45) NULL,
    [Salesman_1_Total_Commission] VARCHAR(41) NULL,
    [Salesman_1_Front_Commission] VARCHAR(45) NULL,
    [Salesman_1_Back_Commission] VARCHAR(45) NULL,
    [Salesman_2_Total_Commission] VARCHAR(41) NULL,
    [Salesman_2_Front_Commission] VARCHAR(45) NULL,
    [Salesman_2_Back_Commission] VARCHAR(45) NULL,
    [Salesman_3_Total_Commission] VARCHAR(45) NULL,
    [Salesman_3_Front_Commission] VARCHAR(45) NULL,
    [Salesman_3_Back_Commission] VARCHAR(45) NULL,
    [Warranty_1_Name] VARCHAR(44) NULL,
    [Warranty_1_Sale] VARCHAR(44) NULL,
    [Warranty_1_Cost] VARCHAR(43) NULL,
    [Warranty_1_Miles] VARCHAR(46) NULL,
    [Warranty_1_Term] VARCHAR(42) NULL,
    [Warranty_2_Name] VARCHAR(45) NULL,
    [Warranty_2_Sale] VARCHAR(45) NULL,
    [Warranty_2_Cost] VARCHAR(45) NULL,
    [Warranty_2_Miles] VARCHAR(45) NULL,
    [Warranty_2_Term] VARCHAR(45) NULL,
    [Warranty_3_Name] VARCHAR(45) NULL,
    [Warranty_3_Sale] VARCHAR(45) NULL,
    [Warranty_3_Cost] VARCHAR(45) NULL,
    [Warranty_3_Miles] VARCHAR(45) NULL,
    [Warranty_3_Term] VARCHAR(45) NULL,
    [Warranty_4_Name] VARCHAR(45) NULL,
    [Warranty_4_Sale] VARCHAR(45) NULL,
    [Warranty_4_Cost] VARCHAR(45) NULL,
    [Warranty_4_Miles] VARCHAR(45) NULL,
    [Warranty_4_Term] VARCHAR(45) NULL,
    [Warranty_5_Name] VARCHAR(45) NULL,
    [Warranty_5_Sale] VARCHAR(45) NULL,
    [Warranty_5_Cost] VARCHAR(45) NULL,
    [Warranty_5_Miles] VARCHAR(45) NULL,
    [Warranty_5_Term] VARCHAR(45) NULL,
    [Total_Fee_Aftermarket_Sale] VARCHAR(47) NULL,
    [Total_Fee_Aftermarket_Cost] VARCHAR(46) NULL,
    [Fee_Aftermarket_1_Name] VARCHAR(40) NULL,
    [Fee_Aftermarket_1_Sale] VARCHAR(46) NULL,
    [Fee_Aftermarket_1_Cost] VARCHAR(46) NULL,
    [Fee_Aftermarket_1_Profit_Indicator] VARCHAR(41) NULL,
    [Fee_Aftermarket_2_Name] VARCHAR(41) NULL,
    [Fee_Aftermarket_2_Sale] VARCHAR(43) NULL,
    [Fee_Aftermarket_2_Cost] VARCHAR(41) NULL,
    [Fee_Aftermarket_2_Profit_Indicator] VARCHAR(41) NULL,
    [Fee_Aftermarket_3_Name] VARCHAR(45) NULL,
    [Fee_Aftermarket_3_Sale] VARCHAR(45) NULL,
    [Fee_Aftermarket_3_Cost] VARCHAR(41) NULL,
    [Fee_Aftermarket_3_Profit_Indicator] VARCHAR(41) NULL,
    [Fee_Aftermarket_4_Name] VARCHAR(45) NULL,
    [Fee_Aftermarket_4_Sale] VARCHAR(41) NULL,
    [Fee_Aftermarket_4_Cost] VARCHAR(41) NULL,
    [Fee_Aftermarket_4_Profit_Indicator] VARCHAR(41) NULL,
    [Fee_Aftermarket_5_Name] VARCHAR(41) NULL,
    [Fee_Aftermarket_5_Sale] VARCHAR(43) NULL,
    [Fee_Aftermarket_5_Cost] VARCHAR(43) NULL,
    [Fee_Aftermarket_5_Profit_Indicator] VARCHAR(41) NULL,
    [Fee_Aftermarket_6_Name] VARCHAR(48) NULL,
    [Fee_Aftermarket_6_Sale] VARCHAR(41) NULL,
    [Fee_Aftermarket_6_Cost] VARCHAR(41) NULL,
    [Fee_Aftermarket_6_Profit_Indicator] VARCHAR(41) NULL,
    [Fee_Aftermarket_7_Name] VARCHAR(41) NULL,
    [Fee_Aftermarket_7_Sale] VARCHAR(46) NULL,
    [Fee_Aftermarket_7_Cost] VARCHAR(46) NULL,
    [Fee_Aftermarket_7_Profit_Indicator] VARCHAR(41) NULL,
    [Fee_Aftermarket_8_Name] VARCHAR(48) NULL,
    [Fee_Aftermarket_8_Sale] VARCHAR(43) NULL,
    [Fee_Aftermarket_8_Cost] VARCHAR(45) NULL,
    [Fee_Aftermarket_8_Profit_Indicator] VARCHAR(41) NULL,
    [Fee_Aftermarket_9_Name] VARCHAR(49) NULL,
    [Fee_Aftermarket_9_Sale] VARCHAR(45) NULL,
    [Fee_Aftermarket_9_Cost] VARCHAR(41) NULL,
    [Fee_Aftermarket_9_Profit_Indicator] VARCHAR(41) NULL,
    [Fee_Aftermarket_10_Name] VARCHAR(45) NULL,
    [Fee_Aftermarket_10_Sale] VARCHAR(46) NULL,
    [Fee_Aftermarket_10_Cost] VARCHAR(46) NULL,
    [Fee_Aftermarket_10_Profit_Indicator] VARCHAR(41) NULL,
    [Fee_Aftermarket_11_Name] VARCHAR(45) NULL,
    [Fee_Aftermarket_11_Sale] VARCHAR(45) NULL,
    [Fee_Aftermarket_11_Cost] VARCHAR(45) NULL,
    [Fee_Aftermarket_11_Profit_Indicator] VARCHAR(45) NULL,
    [Fee_Aftermarket_12_Name] VARCHAR(45) NULL,
    [Fee_Aftermarket_12_Sale] VARCHAR(45) NULL,
    [Fee_Aftermarket_12_Cost] VARCHAR(45) NULL,
    [Fee_Aftermarket_12_Profit_Indicator] VARCHAR(45) NULL,
    [Fee_Aftermarket_13_Name] VARCHAR(45) NULL,
    [Fee_Aftermarket_13_Sale] VARCHAR(45) NULL,
    [Fee_Aftermarket_13_Cost] VARCHAR(45) NULL,
    [Fee_Aftermarket_13_Profit_Indicator] VARCHAR(45) NULL,
    [Fee_Aftermarket_14_Name] VARCHAR(45) NULL,
    [Fee_Aftermarket_14_Sale] VARCHAR(45) NULL,
    [Fee_Aftermarket_14_Cost] VARCHAR(45) NULL,
    [Fee_Aftermarket_14_Profit_Indicator] VARCHAR(45) NULL,
    [Fee_Aftermarket_15_Name] VARCHAR(45) NULL,
    [Fee_Aftermarket_15_Sale] VARCHAR(45) NULL,
    [Fee_Aftermarket_15_Cost] VARCHAR(45) NULL,
    [Fee_Aftermarket_15_Profit_Indicator] VARCHAR(45) NULL,
    [Fee_Aftermarket_16_Name] VARCHAR(45) NULL,
    [Fee_Aftermarket_16_Sale] VARCHAR(45) NULL,
    [Fee_Aftermarket_16_Cost] VARCHAR(45) NULL,
    [Fee_Aftermarket_16_Profit_Indicator] VARCHAR(45) NULL,
    [Fee_Aftermarket_17_Name] VARCHAR(45) NULL,
    [Fee_Aftermarket_17_Sale] VARCHAR(45) NULL,
    [Fee_Aftermarket_17_Cost] VARCHAR(45) NULL,
    [Fee_Aftermarket_17_Profit_Indicator] VARCHAR(45) NULL,
    [Fee_Aftermarket_18_Name] VARCHAR(45) NULL,
    [Fee_Aftermarket_18_Sale] VARCHAR(45) NULL,
    [Fee_Aftermarket_18_Cost] VARCHAR(45) NULL,
    [Fee_Aftermarket_18_Profit_Indicator] VARCHAR(45) NULL,
    [Fee_Aftermarket_19_Name] VARCHAR(45) NULL,
    [Fee_Aftermarket_19_Sale] VARCHAR(45) NULL,
    [Fee_Aftermarket_19_Cost] VARCHAR(45) NULL,
    [Fee_Aftermarket_19_Profit_Indicator] VARCHAR(45) NULL,
    [Fee_Aftermarket_20_Name] VARCHAR(45) NULL,
    [Fee_Aftermarket_20_Sale] VARCHAR(45) NULL,
    [Fee_Aftermarket_20_Cost] VARCHAR(45) NULL,
    [Fee_Aftermarket_20_Profit_Indicator] VARCHAR(45) NULL,
    [Insurance_1_Type] VARCHAR(42) NULL,
    [Insurance_1_Name] VARCHAR(44) NULL,
    [Insurance_1_Sale] VARCHAR(43) NULL,
    [Insurance_1_Cost] VARCHAR(42) NULL,
    [Insurance_1_Term] VARCHAR(42) NULL,
    [Insurance_2_Type] VARCHAR(45) NULL,
    [Insurance_2_Name] VARCHAR(44) NULL,
    [Insurance_2_Sale] VARCHAR(43) NULL,
    [Insurance_2_Cost] VARCHAR(42) NULL,
    [Insurance_2_Term] VARCHAR(45) NULL,
    [Insurance_3_Type] VARCHAR(45) NULL,
    [Insurance_3_Name] VARCHAR(45) NULL,
    [Insurance_3_Sale] VARCHAR(43) NULL,
    [Insurance_3_Cost] VARCHAR(43) NULL,
    [Insurance_3_Term] VARCHAR(42) NULL,
    [Accidental_Health_Type] VARCHAR(45) NULL,
    [Accidental_Health_Name] VARCHAR(45) NULL,
    [Accidental_Health_Sale] VARCHAR(45) NULL,
    [Accidental_Health_Cost] VARCHAR(45) NULL,
    [Accidental_Health_Term] VARCHAR(45) NULL,
    [Credit_Life_Type] VARCHAR(45) NULL,
    [Credit_Life_Name] VARCHAR(45) NULL,
    [Credit_Life_Sale] VARCHAR(45) NULL,
    [Credit_Life_Cost] VARCHAR(45) NULL,
    [Credit_Life_Term] VARCHAR(45) NULL,
    [Levelized_Life_Type] VARCHAR(45) NULL,
    [Levelized_Life_Name] VARCHAR(45) NULL,
    [Levelized_Life_Sale] VARCHAR(45) NULL,
    [Levelized_Life_Cost] VARCHAR(45) NULL,
    [Levelized_Life_Term] VARCHAR(45) NULL,
    [Loss_of_Employment_Type] VARCHAR(45) NULL,
    [Loss_of_Employment_Name] VARCHAR(45) NULL,
    [Loss_of_Employment_Sale] VARCHAR(45) NULL,
    [Loss_of_Employment_Cost] VARCHAR(45) NULL,
    [Loss_of_Employment_Term] VARCHAR(45) NULL,
    [Guaranteed_Auto_Protection_Type] VARCHAR(45) NULL,
    [Guaranteed_Auto_Protection_Name] VARCHAR(45) NULL,
    [Guaranteed_Auto_Protection_Sale] VARCHAR(41) NULL,
    [Guaranteed_Auto_Protection_Cost] VARCHAR(45) NULL,
    [Guaranteed_Auto_Protection_Term] VARCHAR(45) NULL,
    [Sale_Comments] VARCHAR(423) NULL,
    [CASS_STD_LINE1] VARCHAR(42) NULL,
    [CASS_STD_LINE2] VARCHAR(47) NULL,
    [CASS_STD_CITY] VARCHAR(44) NULL,
    [CASS_STD_STATE] VARCHAR(42) NULL,
    [CASS_STD_ZIP] VARCHAR(45) NULL,
    [CASS_STD_ZIP4] VARCHAR(44) NULL,
    [CASS_STD_DPBC] VARCHAR(42) NULL,
    [CASS_STD_CHKDGT] VARCHAR(41) NULL,
    [CASS_STD_CART] VARCHAR(44) NULL,
    [CASS_STD_LOT] VARCHAR(43) NULL,
    [CASS_STD_LOTORD] VARCHAR(41) NULL,
    [CASS_STD_URB] VARCHAR(45) NULL,
    [CASS_STD_FIPS] VARCHAR(45) NULL,
    [CASS_STD_EWS] VARCHAR(41) NULL,
    [CASS_STD_LACS] VARCHAR(45) NULL,
    [CASS_STD_ZIPMOV] VARCHAR(41) NULL,
    [CASS_STD_Z4LOM] VARCHAR(42) NULL,
    [CASS_STD_NDIAPT] VARCHAR(41) NULL,
    [CASS_STD_NDIRR] VARCHAR(45) NULL,
    [CASS_STD_LACSRT] VARCHAR(45) NULL,
    [CASS_STD_ERROR_CD] VARCHAR(355) NULL
);

CREATE TABLE [zzz_DealerVaultInfo] (
    [state] NVARCHAR(38) NULL,
    [acc_id] INT NOT NULL,
    [acc_company] VARCHAR(64) NOT NULL,
    [acc_address] VARCHAR(64) NOT NULL,
    [acc_city] VARCHAR(64) NOT NULL,
    [acc_state] VARCHAR(2) NOT NULL,
    [zip_code] VARCHAR(5) NOT NULL,
    [ldq_count] INT NULL,
    [lst_id] INT NOT NULL,
    [ldq_id] INT NOT NULL,
    [ldq_type] VARCHAR(5) NOT NULL,
    [ldq_created] DATETIME NOT NULL,
    [ldq_frommail] VARCHAR(256) NOT NULL,
    [ldq_fromfirstname] VARCHAR(64) NOT NULL,
    [ldq_fromlastname] VARCHAR(64) NOT NULL,
    [ldq_fromzipcode] VARCHAR(5) NOT NULL,
    [ldq_fromphone] VARCHAR(16) NOT NULL,
    [veh_vin] VARCHAR(32) NULL
);

CREATE TABLE [zzz_dealerVaultShort] (
    [File_Type] VARCHAR(32) NULL,
    [DV_Dealer_ID] VARCHAR(32) NULL,
    [First_Name] VARCHAR(32) NULL,
    [Middle_Name] VARCHAR(32) NULL,
    [Last_Name] VARCHAR(32) NULL,
    [Address_Line_1] VARCHAR(32) NULL,
    [Home_Phone] VARCHAR(32) NULL,
    [Cell_Phone] VARCHAR(32) NULL,
    [Work_Phone] VARCHAR(32) NULL,
    [Email_1] VARCHAR(32) NULL,
    [Email_2] VARCHAR(32) NULL,
    [Email_3] VARCHAR(32) NULL,
    [Co_Buyer_First_Name] VARCHAR(32) NULL,
    [Co_Buyer_Middle_Name] VARCHAR(32) NULL,
    [Co_Buyer_Last_Name] VARCHAR(32) NULL,
    [Co_Buyer_Address_Line_1] VARCHAR(32) NULL,
    [Co_Buyer_Home_Phone] VARCHAR(32) NULL,
    [Co_Buyer_Cell_Phone] VARCHAR(32) NULL,
    [Co_Buyer_Work_Phone] VARCHAR(32) NULL,
    [Co_Buyer_Email_1] VARCHAR(32) NULL,
    [Co_Buyer_Email_2] VARCHAR(32) NULL,
    [Co_Buyer_Email_3] VARCHAR(32) NULL,
    [VIN] VARCHAR(32) NULL,
    [Stock_Number] VARCHAR(32) NULL,
    [In_Service_Date] VARCHAR(32) NULL,
    [Trade_1_VIN] VARCHAR(32) NULL,
    [Trade_2_VIN] VARCHAR(32) NULL,
    [MSRP] MONEY NULL,
    [List_Price] MONEY NULL,
    [Sales_Price] MONEY NULL,
    [Delivery_Date] DATE NULL,
    [id] BIGINT NOT NULL
);

CREATE TABLE [zzz_dupevins] (
    [dupevin] VARCHAR(17) NULL
);

CREATE TABLE [zzz_DynamicInventoryColorScheme] (
    [disc_id] INT NOT NULL -- PK,
    [disc_name] VARCHAR(50) NOT NULL,
    [disc_background] VARCHAR(50) NOT NULL,
    [disc_header] VARCHAR(50) NOT NULL,
    [disc_active] BIT NOT NULL
);

CREATE TABLE [zzz_fbAutomotiveCatalog_data_v4_temp_timtest] (
    [vehicle_id] VARCHAR(37) NOT NULL,
    [vin] VARCHAR(32) NULL,
    [make] VARCHAR(64) NULL,
    [model] VARCHAR(64) NULL,
    [year] VARCHAR(4) NULL,
    [body_style] VARCHAR(128) NULL,
    [description] VARCHAR(8000) NULL,
    [exterior_color] VARCHAR(128) NULL,
    [image.tag] VARCHAR(128) NOT NULL,
    [image.url] VARCHAR(512) NULL,
    [mileage.value] VARCHAR(32) NULL,
    [mileage.unit] VARCHAR(2) NOT NULL,
    [url] VARCHAR(105) NOT NULL,
    [title] VARCHAR(128) NOT NULL,
    [price] VARCHAR(8000) NULL,
    [state_of_vehicle] VARCHAR(8000) NULL,
    [address.addr1] VARCHAR(64) NOT NULL,
    [address.city] VARCHAR(64) NOT NULL,
    [address.region] VARCHAR(64) NULL,
    [address.stateid] VARCHAR(2) NOT NULL,
    [address.postal_code] VARCHAR(5) NOT NULL,
    [address.country] VARCHAR(13) NOT NULL,
    [longitude] FLOAT NULL,
    [latitude] FLOAT NULL,
    [transmission] VARCHAR(128) NULL,
    [drivetrain] VARCHAR(128) NULL,
    [fuel_type] VARCHAR(128) NULL,
    [trim] VARCHAR(128) NULL,
    [interior_color] VARCHAR(128) NULL,
    [sale_price] MONEY NOT NULL,
    [availability] VARCHAR(9) NOT NULL,
    [dealer_id] BIGINT NULL,
    [dealer_name] VARCHAR(64) NOT NULL,
    [dealer_phone] VARCHAR(16) NOT NULL,
    [custom_label_0] VARCHAR(128) NULL,
    [lst_id] INT NOT NULL,
    [lst_created] DATETIME NOT NULL,
    [lst_modified] DATETIME NOT NULL,
    [vdp_url] VARCHAR(1024) NOT NULL,
    [sub_id] BIGINT NULL,
    [prd_id] BIGINT NULL,
    [lst_onlinetext] VARCHAR(8000) NOT NULL,
    [sub_status] VARCHAR(16) NULL,
    [prd_type] VARCHAR(128) NULL,
    [sub_name] VARCHAR(256) NULL,
    [LastUpload] DATETIME NOT NULL
);

CREATE TABLE [zzz_FlagReason] (
    [flr_ID] INT NOT NULL -- PK,
    [flr_Name] VARCHAR(64) NOT NULL,
    [flr_Description] VARCHAR(1024) NOT NULL,
    [flr_Active] BIT NOT NULL,
    [flr_Order] INT NOT NULL
);

CREATE TABLE [zzz_FraudFlags] (
    [frd_ID] INT NOT NULL -- PK,
    [frd_Name] VARCHAR(128) NOT NULL,
    [frd_Order] INT NOT NULL
);

CREATE TABLE [zzz_FRAUDIPINFO] (
    [acc_id] INT NOT NULL,
    [acc_login] VARCHAR(128) NOT NULL,
    [acc_lastip] VARCHAR(15) NOT NULL,
    [acc_created] DATETIME NOT NULL,
    [domain] VARCHAR(256) NULL
);

CREATE TABLE [zzz_getRecruiterDrivers] (
    [acc_id] INT NOT NULL,
    [appdate] DATETIME NULL,
    [fname] VARCHAR(128) NOT NULL,
    [lname] VARCHAR(128) NOT NULL,
    [city] VARCHAR(128) NOT NULL,
    [state] VARCHAR(128) NOT NULL,
    [taap_value] INT NOT NULL,
    [oos_name] VARCHAR(15) NOT NULL
);

CREATE TABLE [zzz_GmailAccount] (
    [acc_id] INT NOT NULL,
    [acc_login] VARCHAR(128) NOT NULL,
    [acc_phone] VARCHAR(16) NOT NULL,
    [acc_password] VARCHAR(256) NOT NULL,
    [acc_lastip] VARCHAR(15) NOT NULL,
    [NoPlus] VARCHAR(138) NULL
);

CREATE TABLE [zzz_GMailAccounts] (
    [acc_id] INT NOT NULL,
    [acc_login] VARCHAR(128) NOT NULL,
    [lst_count] INT NULL,
    [NoPlus] VARCHAR(128) NULL
);

CREATE TABLE [zzz_GrouponSubClass] (
    [gsc_ID] INT NOT NULL,
    [scl_ID] INT NOT NULL
);

CREATE TABLE [zzz_HealthCheck] (
    [hc_ID] INT NOT NULL -- PK,
    [hct_ID] INT NOT NULL,
    [hc_Time] SMALLDATETIME NOT NULL,
    [hc_Value] VARCHAR(50) NOT NULL
);

CREATE TABLE [zzz_HealthCheckType] (
    [hct_ID] INT NOT NULL -- PK,
    [hct_Description] VARCHAR(50) NOT NULL
);

CREATE TABLE [zzz_HISTORY_BANNER] (
    [hbn_ID] INT NOT NULL -- PK,
    [ban_ID] INT NOT NULL,
    [bst_ID] INT NOT NULL,
    [bty_ID] INT NOT NULL,
    [bsz_ID] INT NOT NULL,
    [ban_CreatedBy] INT NOT NULL,
    [ban_Created] DATETIME NOT NULL,
    [ban_ModifiedBy] INT NOT NULL,
    [ban_Modified] DATETIME NOT NULL,
    [ban_Name] VARCHAR(256) NOT NULL,
    [ban_Cost] MONEY NOT NULL,
    [ban_RolloverText] VARCHAR(256) NOT NULL,
    [ban_HRef] VARCHAR(512) NOT NULL,
    [ban_Target] VARCHAR(16) NOT NULL,
    [ban_Image] VARCHAR(4096) NOT NULL,
    [ban_Image_LastUpload] DATETIME NOT NULL,
    [ban_Hits] BIGINT NOT NULL,
    [ban_OnSchedule] BIT NOT NULL,
    [ban_StartDate] DATETIME NOT NULL,
    [ban_StopDate] DATETIME NOT NULL,
    [ban_AlertGM] BIT NOT NULL,
    [ban_AlertEmail] VARCHAR(128) NOT NULL,
    [aso_ID] INT NULL,
    [ban_Rep_acc_ID] INT NULL,
    [ban_cusid] INT NULL,
    [acc_ID] INT NULL
);

CREATE TABLE [zzz_HISTORY_BANNERCREATIVE] (
    [hbc_ID] INT NOT NULL -- PK,
    [hbn_ID] INT NOT NULL,
    [banc_ID] INT NOT NULL,
    [ban_ID] INT NOT NULL,
    [banc_InventoryGen] VARCHAR(32) NOT NULL,
    [banc_Color] VARCHAR(32) NOT NULL,
    [banc_DefaultImage] VARCHAR(512) NULL,
    [banc_ShowPhone] BIT NOT NULL,
    [banc_UseKeywords] BIT NULL
);

CREATE TABLE [zzz_HISTORY_BANNERGEODISTANCE] (
    [hbg_ID] INT NOT NULL -- PK,
    [hbn_ID] INT NOT NULL,
    [bng_ID] INT NOT NULL,
    [ban_ID] INT NOT NULL,
    [gdID] INT NOT NULL
);

CREATE TABLE [zzz_HISTORY_BANNERKEYWORD] (
    [hbk_ID] INT NOT NULL -- PK,
    [hbn_ID] INT NOT NULL,
    [bky_ID] INT NOT NULL,
    [ban_ID] INT NOT NULL,
    [bky_Keyword] VARCHAR(32) NOT NULL
);

CREATE TABLE [zzz_HISTORY_BANNERLOCATIONSELECTED] (
    [hbl_ID] INT NOT NULL -- PK,
    [hbn_ID] INT NOT NULL,
    [bls_ID] INT NOT NULL,
    [ban_ID] INT NOT NULL,
    [blo_ID] INT NOT NULL
);

CREATE TABLE [zzz_HISTORY_BANNERSUBCLASS] (
    [hbs_ID] INT NOT NULL -- PK,
    [hbn_ID] INT NOT NULL,
    [bsc_ID] INT NOT NULL,
    [ban_ID] INT NOT NULL,
    [scl_ID] INT NOT NULL
);

CREATE TABLE [zzz_HISTORY_BANNERZIPCODE] (
    [hbz_ID] INT NOT NULL -- PK,
    [hbn_ID] INT NOT NULL,
    [bzc_ID] INT NOT NULL,
    [ban_ID] INT NOT NULL,
    [zip_Code] VARCHAR(5) NOT NULL
);

CREATE TABLE [zzz_HondaofAventura] (
    [ldq_FromPhone] NVARCHAR(255) NULL,
    [ldq_FromFirstName] NVARCHAR(255) NULL,
    [ldq_FromZipCode] NVARCHAR(255) NULL,
    [ldq_Created] DATETIME NULL,
    [Duration] FLOAT NULL,
    [Campaign Name] NVARCHAR(255) NULL,
    [ldq_ProofComment] NVARCHAR(255) NULL,
    [lst_ID] VARCHAR(20) NULL,
    [ldq_lqs_ID] VARCHAR(20) NULL,
    [ldq_FromLastName] VARCHAR(20) NULL,
    [ldq_FromIP] VARCHAR(20) NULL,
    [ldq_FromMail] VARCHAR(20) NULL,
    [ldq_Proofer_acc_ID] VARCHAR(20) NULL,
    [ldq_Sent] VARCHAR(20) NULL,
    [ldq_ADFXML] VARCHAR(20) NULL,
    [ldq_MultiSend] VARCHAR(20) NULL,
    [ldq_Source] VARCHAR(20) NULL,
    [ldq_Message] VARCHAR(2500) NULL
);

CREATE TABLE [zzz_ImageDupes] (
    [lim_url] VARCHAR(512) NULL,
    [img_count] INT NULL
);

CREATE TABLE [zzz_JaneDealers20180209] (
    [sales_channel] NVARCHAR(2048) NULL,
    [sls_rep] NVARCHAR(400) NULL,
    [Source] VARCHAR(128) NOT NULL,
    [Aggregator] VARCHAR(128) NOT NULL,
    [acc_id] INT NULL,
    [acc_company] VARCHAR(128) NOT NULL,
    [acc_email_string] VARCHAR(128) NOT NULL,
    [acc_address] VARCHAR(128) NOT NULL,
    [acc_city] VARCHAR(128) NULL,
    [acc_state] VARCHAR(2) NOT NULL,
    [zip_code] VARCHAR(10) NOT NULL,
    [lst_livecount] FLOAT NOT NULL,
    [lst_lastupload] DATE NULL,
    [id] INT NOT NULL
);

CREATE TABLE [zzz_jc_aso_ratchetaccess] (
    [ase_ID] INT NOT NULL,
    [acc_ID] INT NOT NULL,
    [aso_ID] INT NOT NULL
);

CREATE TABLE [zzz_JO_AllProducts_V2] (
    [cmp_id] BIGINT NULL,
    [ratchet_id] BIGINT NULL,
    [subscription_id] BIGINT NULL,
    [Submit_Date] DATETIME2 NULL,
    [Modified_Date] DATETIME2 NULL,
    [Aggregator] NVARCHAR(255) NULL,
    [Start_Date] NVARCHAR(10) NULL,
    [End_Date] NVARCHAR(10) NULL,
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
    [sub_status] NVARCHAR(8) NOT NULL,
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
    [pl_vehicle_type] NVARCHAR(255) NULL,
    [pl_language] NVARCHAR(255) NULL,
    [utm_code] NVARCHAR(512) NULL,
    [isFacebook] NUMERIC(20,0) NULL,
    [isRetargeting] BIGINT NULL,
    [cmp_Start_Date] NVARCHAR(10) NULL,
    [cmp_End_Date] NVARCHAR(10) NULL
);

CREATE TABLE [zzz_JohnnyTest] (
    [job_domain] VARCHAR(128) NULL,
    [job_lastexecution] DATETIME NULL,
    [veh_vin] VARCHAR(256) NOT NULL,
    [veh_url] VARCHAR(1024) NULL,
    [DataSource] VARCHAR(256) NULL,
    [veh_stock] VARCHAR(32) NOT NULL
);

CREATE TABLE [zzz_JSListings] (
    [acc_id] INT NOT NULL,
    [acc_company] VARCHAR(64) NOT NULL,
    [acc_zip_Code] VARCHAR(5) NOT NULL,
    [zip_code] VARCHAR(5) NOT NULL,
    [dma_name] VARCHAR(256) NULL,
    [acc_LastUpload] DATE NULL,
    [scl_name] VARCHAR(64) NOT NULL,
    [lst_id] INT NOT NULL,
    [veh_year] VARCHAR(4) NULL,
    [veh_make] VARCHAR(64) NULL,
    [veh_model] VARCHAR(64) NULL,
    [veh_vin] VARCHAR(32) NULL,
    [veh_mileage] VARCHAR(32) NULL,
    [lst_price] MONEY NOT NULL,
    [lst_created] DATE NULL,
    [lst_lastupload] DATE NULL,
    [lst_char_count] INT NULL,
    [lst_img_count] INT NULL,
    [ldq_count] INT NULL,
    [MileageScore] VARCHAR(8) NULL
);

CREATE TABLE [zzz_jtest] (
    [RowNum] BIGINT NULL,
    [jobid] INT NOT NULL,
    [accid] INT NOT NULL,
    [jobtitle] VARCHAR(255) NOT NULL,
    [jobdesc] TEXT NOT NULL,
    [States] VARCHAR(8000) NULL,
    [JobType] VARCHAR(8000) NULL,
    [Opportunity] VARCHAR(8000) NULL,
    [JobDriven] VARCHAR(8000) NULL,
    [jobattributes] VARCHAR(4000) NOT NULL
);

CREATE TABLE [zzz_JuneLeadScrum] (
    [ldq_ID] INT NOT NULL,
    [lst_id] INT NOT NULL,
    [aso_name] VARCHAR(128) NULL,
    [fduid] INT NULL,
    [ldq_created] DATETIME NOT NULL,
    [lacc_displayname] VARCHAR(64) NULL,
    [ldq_frommail] VARCHAR(256) NOT NULL,
    [ldq_fromphone] VARCHAR(16) NOT NULL,
    [ldq_message] VARCHAR(512) NOT NULL,
    [lacc_id] INT NULL,
    [Bid] MONEY NULL,
    [Type] VARCHAR(50) NULL
);

CREATE TABLE [zzz_KeywordRedirection] (
    [kwr_ID] INT NOT NULL -- PK,
    [kwr_Desc] VARCHAR(100) NOT NULL,
    [kwr_Active] BIT NOT NULL,
    [kwr_Priority] TINYINT NOT NULL,
    [kwr_Keyword] VARCHAR(50) NOT NULL,
    [kwr_Geo] VARCHAR(50) NOT NULL,
    [kwr_Cls_Name] VARCHAR(50) NOT NULL,
    [kwr_Redirect] VARCHAR(250) NOT NULL
);

CREATE TABLE [zzz_KPI_EndeavorEmployees] (
    [db] VARCHAR(32) NOT NULL,
    [empname] VARCHAR(24) NOT NULL,
    [empfname] VARCHAR(32) NOT NULL,
    [emplname] VARCHAR(32) NOT NULL,
    [empcreated] DATETIME NOT NULL,
    [empactive] BIT NOT NULL,
    [depid] INT NOT NULL,
    [depname] VARCHAR(64) NOT NULL,
    [offid] INT NOT NULL,
    [offname] VARCHAR(64) NOT NULL,
    [file_num] INT NULL
);

CREATE TABLE [zzz_kpi_EndeavorSales] (
    [db] VARCHAR(32) NOT NULL,
    [cusid] INT NOT NULL,
    [cuscompany] VARCHAR(64) NULL,
    [cusphone] VARCHAR(16) NOT NULL,
    [cuszip] VARCHAR(5) NULL,
    [cusmessage] VARCHAR(64) NULL,
    [cusplus4] VARCHAR(4) NULL,
    [cusrep] VARCHAR(24) NOT NULL,
    [slsnumber] INT NOT NULL,
    [adnum] INT NOT NULL,
    [slsrundate] DATETIME NOT NULL,
    [slscost] MONEY NOT NULL,
    [slsrep] VARCHAR(24) NOT NULL,
    [Features] VARCHAR(256) NULL,
    [Product] VARCHAR(5) NOT NULL,
    [sale_adj] MONEY NOT NULL,
    [sale_writeoff] MONEY NOT NULL,
    [payments] MONEY NOT NULL,
    [adtext] VARCHAR(512) NULL
);

CREATE TABLE [zzz_LandingPage] (
    [lp_ID] INT NOT NULL -- PK,
    [lp_pageKey] VARCHAR(30) NOT NULL,
    [lp_pageType] INT NOT NULL,
    [lp_domain] VARCHAR(100) NOT NULL,
    [lp_name] VARCHAR(100) NOT NULL,
    [lp_file] VARCHAR(100) NOT NULL,
    [lp_slogan] VARCHAR(100) NOT NULL,
    [lp_location1] VARCHAR(100) NOT NULL,
    [lp_location2] VARCHAR(100) NOT NULL,
    [lp_locationurl] VARCHAR(100) NOT NULL,
    [lp_image] VARCHAR(100) NOT NULL,
    [lp_description] VARCHAR(MAX) NOT NULL,
    [lp_banner] VARCHAR(100) NOT NULL,
    [lp_title] VARCHAR(250) NOT NULL,
    [lp_keywords] VARCHAR(500) NOT NULL,
    [lp_metadesc] VARCHAR(500) NOT NULL,
    [lp_phone] VARCHAR(100) NOT NULL,
    [lp_address] VARCHAR(50) NOT NULL,
    [lp_city] VARCHAR(50) NOT NULL,
    [lp_state] VARCHAR(2) NOT NULL,
    [lp_zip] VARCHAR(5) NOT NULL,
    [lp_Latitude] FLOAT NULL,
    [lp_Longitude] FLOAT NULL,
    [lp_homebanner] BIT NULL
);

CREATE TABLE [zzz_Leads1000Sample] (
    [ldq_id] INT NOT NULL,
    [ldq_lqs_id] INT NOT NULL,
    [ldq_created] DATETIME NOT NULL,
    [esr_id] INT NOT NULL,
    [esr_name] VARCHAR(50) NULL,
    [ldq_frommail] VARCHAR(256) NOT NULL,
    [ldq_fromfirstname] VARCHAR(64) NOT NULL,
    [ldq_fromlastname] VARCHAR(64) NOT NULL,
    [ldq_fromzipcode] VARCHAR(5) NOT NULL,
    [ldq_fromphone] VARCHAR(16) NOT NULL,
    [ldq_message] VARCHAR(512) NOT NULL,
    [id] INT NOT NULL
);

CREATE TABLE [zzz_ListingApproval] (
    [apr_ID] INT NOT NULL -- PK,
    [cc_ID] INT NOT NULL,
    [rat_ID] INT NOT NULL,
    [approved] BIT NOT NULL,
    [approval_Set] INT NOT NULL
);

CREATE TABLE [zzz_ListingApprovedStuck] (
    [lst_id] INT NOT NULL,
    [lst_modified] DATETIME NOT NULL,
    [lss_id] INT NOT NULL,
    [PushedBack] DATETIME NOT NULL
);

CREATE TABLE [zzz_ListingBypass] (
    [lsb_ID] INT NOT NULL -- PK,
    [lst_ID] INT NOT NULL
);

CREATE TABLE [zzz_ListingContact] (
    [lco_ID] INT NOT NULL -- PK,
    [lst_ID] INT NOT NULL,
    [lco_Company] VARCHAR(64) NOT NULL,
    [lco_FirstName] VARCHAR(32) NOT NULL,
    [lco_LastName] VARCHAR(32) NOT NULL,
    [lco_Email] VARCHAR(128) NOT NULL,
    [lco_URL] VARCHAR(512) NULL,
    [lco_Address] VARCHAR(64) NOT NULL,
    [lco_City] VARCHAR(64) NOT NULL,
    [lco_State] VARCHAR(2) NOT NULL,
    [lco_Image] VARCHAR(512) NULL
);

CREATE TABLE [zzz_ListingFlag] (
    [lfl_ID] INT NOT NULL -- PK,
    [lst_ID] INT NOT NULL,
    [lfl_Created] DATETIME NOT NULL,
    [lfl_From_IP] VARCHAR(16) NOT NULL,
    [lfl_From_acc_ID] INT NULL,
    [lfl_From_Browser] VARCHAR(512) NOT NULL,
    [prr_ID] INT NULL,
    [lfl_Verified_acc_ID] INT NULL,
    [lfl_Verified_Date] DATETIME NULL
);

CREATE TABLE [zzz_ListingFlagReason] (
    [lfr_ID] INT NOT NULL -- PK,
    [lfl_ID] INT NOT NULL,
    [flr_ID] INT NOT NULL
);

CREATE TABLE [zzz_ListingImagesFlat] (
    [lst_id] INT NOT NULL,
    [lss_id] INT NOT NULL,
    [lst_modified] DATETIME NOT NULL,
    [lst_images] VARCHAR(8000) NULL,
    [isDone] BIT NULL
);

CREATE TABLE [zzz_ListingPet] (
    [lst_id] INT NOT NULL -- PK,
    [pet_type] VARCHAR(32) NULL,
    [pet_breed] VARCHAR(64) NULL,
    [pet_age] VARCHAR(32) NULL,
    [pet_color] VARCHAR(32) NULL,
    [pet_size] VARCHAR(32) NULL,
    [pet_last_seen] VARCHAR(32) NULL,
    [pet_date_found] VARCHAR(32) NULL,
    [pet_donation] VARCHAR(32) NULL,
    [pet_supplies] VARCHAR(128) NULL
);

CREATE TABLE [zzz_ListingPrintEditions_Combination] (
    [lpe_ID] INT NOT NULL,
    [lst_ID] INT NOT NULL,
    [ped_ID] INT NOT NULL,
    [ecl_Number] INT NOT NULL,
    [action] VARCHAR(32) NOT NULL
);

CREATE TABLE [zzz_ListingPrintLog] (
    [lpl_ID] INT NOT NULL -- PK,
    [lst_ID] INT NOT NULL,
    [lss_ID] INT NOT NULL,
    [lst_Modified] DATETIME NOT NULL,
    [lst_ModifiedBy] INT NOT NULL,
    [lst_PrintCount] INT NOT NULL
);

CREATE TABLE [zzz_ListingPromoCode] (
    [lpc_ID] INT NOT NULL -- PK,
    [lst_ID] INT NOT NULL,
    [prc_ID] INT NULL,
    [lpc_SubTotal] MONEY NOT NULL,
    [lpc_Discount] MONEY NOT NULL,
    [lpc_Total] MONEY NOT NULL,
    [lpc_Error] VARCHAR(256) NOT NULL,
    [lpc_Applied] DATETIME NOT NULL
);

CREATE TABLE [zzz_ListingProofing] (
    [lpr_ID] INT NOT NULL -- PK,
    [lst_ID] INT NOT NULL,
    [acc_ID] INT NOT NULL,
    [prr_ID] INT NULL,
    [lpr_Created] DATETIME NOT NULL,
    [lss_ID] INT NOT NULL,
    [lpr_Notes] VARCHAR(1024) NOT NULL,
    [lpr_Reason] VARCHAR(1024) NOT NULL,
    [lpr_Sent] DATETIME NULL
);

CREATE TABLE [zzz_ListingRateRegionBackup] (
    [lsr_ID] INT NOT NULL,
    [lst_id] INT NOT NULL,
    [rrg_id] INT NOT NULL,
    [lst_modified] DATETIME NULL
);

CREATE TABLE [zzz_ListingsWithVIN] (
    [acc_ID] INT NULL,
    [lst_ID] INT NOT NULL,
    [lst_Modified] DATETIME NOT NULL,
    [lst_LastUpload] DATETIME NULL,
    [lia_Value] VARCHAR(128) NOT NULL,
    [lst_Created] DATETIME NULL,
    [VinCheck] VARCHAR(1) NULL,
    [VinChecked] BIT NULL
);

CREATE TABLE [zzz_ListingVehicleNew] (
    [lst_id] INT NOT NULL,
    [lst_title] VARCHAR(128) NOT NULL,
    [lst_onlinetext] VARCHAR(8000) NOT NULL,
    [year] VARCHAR(4) NULL,
    [mileage] VARCHAR(32) NULL,
    [condition] VARCHAR(32) NULL
);

CREATE TABLE [zzz_ListingWallPost] (
    [lwp_ID] INT NOT NULL -- PK,
    [lst_ID] INT NOT NULL,
    [lwp_Created] DATETIME NOT NULL,
    [lwp_Post] VARCHAR(512) NOT NULL,
    [lwp_Processed] BIT NOT NULL
);

CREATE TABLE [zzz_ListingWeeksLog] (
    [lwl_ID] INT NOT NULL -- PK,
    [lst_ID] INT NOT NULL,
    [lst_Weeks] INT NOT NULL,
    [lwl_Added] DATETIME NOT NULL
);

CREATE TABLE [zzz_listingweekslog_dupe] (
    [lwl_ID] INT NOT NULL -- PK,
    [lst_ID] INT NOT NULL,
    [lst_Weeks] INT NOT NULL,
    [lwl_Added] DATETIME NOT NULL
);

CREATE TABLE [zzz_MarketingNewsletter_ContactEmails] (
    [acc_ID] INT NULL,
    [contactEmail] VARCHAR(256) NULL
);

CREATE TABLE [zzz_MostBlockedDomains] (
    [acc_id] INT NOT NULL,
    [acc_login] VARCHAR(128) NOT NULL,
    [acc_phone] VARCHAR(16) NOT NULL,
    [domain] VARCHAR(128) NULL,
    [acc_created] DATETIME NOT NULL,
    [acc_lastlogin] DATETIME NOT NULL
);

CREATE TABLE [zzz_O365_Accounts] (
    [acc_id] INT NULL
);

CREATE TABLE [zzz_OnionSales] (
    [Fname] VARCHAR(512) NULL,
    [Lname] VARCHAR(512) NULL,
    [Cell] VARCHAR(512) NULL,
    [Home] VARCHAR(512) NULL,
    [vehYear] VARCHAR(512) NULL,
    [vehMake] VARCHAR(512) NULL,
    [vehModel] VARCHAR(512) NULL,
    [SaleStatus] VARCHAR(512) NULL,
    [PurchaseDate] DATE NULL,
    [id] INT NOT NULL,
    [email1] VARCHAR(40) NULL,
    [email2] VARCHAR(40) NULL
);

CREATE TABLE [zzz_OodleCategories] (
    [OodleKey] VARCHAR(256) NULL,
    [OodleValue] VARCHAR(256) NULL
);

CREATE TABLE [zzz_Options] (
    [option_ID] INT NOT NULL -- PK,
    [option_Desc] VARCHAR(100) NOT NULL,
    [option_GroupID] INT NOT NULL
);

CREATE TABLE [zzz_PagingBinning] (
    [RowNum] BIGINT NULL,
    [jobid] INT NOT NULL,
    [accid] INT NOT NULL,
    [jobtitle] VARCHAR(255) NOT NULL,
    [jobdesc] TEXT NOT NULL,
    [States] VARCHAR(8000) NULL,
    [JobType] VARCHAR(8000) NULL,
    [Opportunity] VARCHAR(8000) NULL,
    [Endorsements] VARCHAR(8000) NULL,
    [JobDriven] VARCHAR(8000) NULL,
    [jobattributes] VARCHAR(4000) NOT NULL
);

CREATE TABLE [zzz_Parked_ContentTypes] (
    [pct_ID] INT NOT NULL -- PK,
    [pct_Name] VARCHAR(64) NOT NULL
);

CREATE TABLE [zzz_parked_CrossLinks] (
    [pcl_ID] INT NOT NULL -- PK,
    [pdm_ID] INT NOT NULL,
    [pcl_Name] VARCHAR(512) NOT NULL,
    [pcl_URL] VARCHAR(512) NOT NULL,
    [pcl_Order] INT NOT NULL,
    [pcl_Created] DATETIME NOT NULL,
    [pcl_CreatedBy] INT NOT NULL,
    [pcl_Modified] DATETIME NOT NULL,
    [pcl_ModifiedBy] INT NOT NULL
);

CREATE TABLE [zzz_parked_Domains] (
    [pdm_ID] INT NOT NULL -- PK,
    [pdm_URL] VARCHAR(512) NOT NULL,
    [pdm_Name] VARCHAR(512) NOT NULL,
    [pdm_Geo] VARCHAR(512) NOT NULL,
    [pdm_Redirect] VARCHAR(512) NOT NULL,
    [pdm_H1Tag] VARCHAR(512) NOT NULL,
    [pdm_Metadata] VARCHAR(1024) NOT NULL,
    [pdm_Created] DATETIME NOT NULL,
    [pdm_CreatedBy] INT NOT NULL,
    [pdm_Modified] DATETIME NOT NULL,
    [pdm_ModifiedBy] INT NOT NULL,
    [pdm_GoogleCode] VARCHAR(2048) NOT NULL,
    [pdm_LogoURL] VARCHAR(512) NOT NULL,
    [pdm_Intro] VARCHAR(1024) NOT NULL,
    [pdm_Email] VARCHAR(64) NULL,
    [pst_ID] INT NOT NULL,
    [pct_ID] INT NOT NULL,
    [pdm_Active] BIT NULL
);

CREATE TABLE [zzz_Parked_SiteTypes] (
    [pst_ID] INT NOT NULL -- PK,
    [pst_Name] VARCHAR(64) NOT NULL
);

CREATE TABLE [zzz_parked_WhatsHot] (
    [pwh_ID] INT NOT NULL -- PK,
    [pwh_Name] VARCHAR(512) NOT NULL,
    [pwh_URL] VARCHAR(512) NOT NULL,
    [pwh_Order] INT NOT NULL,
    [pwh_Created] DATETIME NOT NULL,
    [pwh_CreatedBy] INT NOT NULL,
    [pwh_Modified] DATETIME NOT NULL,
    [pwh_ModifiedBy] INT NOT NULL,
    [pct_ID] INT NOT NULL
);

CREATE TABLE [zzz_PDFGenerated] (
    [pdfID] INT NOT NULL -- PK,
    [rccID] INT NOT NULL,
    [generatedBy] INT NOT NULL,
    [generated] DATETIME NOT NULL,
    [filename] VARCHAR(100) NOT NULL,
    [active] BIT NOT NULL
);

CREATE TABLE [zzz_PDFSearch] (
    [pdf_ID] INT NOT NULL -- PK,
    [ped_ID] INT NOT NULL,
    [pdf_Issue] VARCHAR(16) NOT NULL,
    [pdf_PageNumber] INT NOT NULL,
    [pdf_FileName] VARCHAR(64) NOT NULL,
    [pdf_Thumbnail] VARCHAR(64) NOT NULL,
    [pdf_Title] VARCHAR(128) NOT NULL,
    [pdf_Description] VARCHAR(8000) NOT NULL,
    [pdf_Created] SMALLDATETIME NOT NULL,
    [pdf_CreatedBy] INT NOT NULL,
    [pdf_Modified] SMALLDATETIME NOT NULL,
    [pdf_ModifiedBy] INT NOT NULL,
    [pdf_Active] BIT NOT NULL,
    [pdf_Type] TINYINT NOT NULL
);

CREATE TABLE [zzz_PDFTypes] (
    [pdf_Type] TINYINT NOT NULL -- PK,
    [pdf_TypeName] VARCHAR(64) NOT NULL,
    [pdf_TypeActive] BIT NOT NULL,
    [pdf_TypeOrder] INT NOT NULL
);

CREATE TABLE [zzz_PetHack] (
    [acc_id] INT NOT NULL,
    [acc_phone] VARCHAR(16) NOT NULL,
    [lst_phone] VARCHAR(16) NOT NULL,
    [acc_Email_String] VARCHAR(128) NOT NULL,
    [acc_login] VARCHAR(128) NOT NULL,
    [acc_LastIP] VARCHAR(15) NOT NULL
);

CREATE TABLE [zzz_PetRecommendations] (
    [pfc_zipCode] VARCHAR(5) NULL,
    [rec_zipCode] VARCHAR(5) NULL,
    [rec_Distance] DECIMAL(16,4) NULL
);

CREATE TABLE [zzz_PlatformAuto_Delisted] (
    [car_id] VARCHAR(32) NULL,
    [vin] VARCHAR(32) NULL,
    [date_delisted] DATE NULL,
    [lst_ID] INT NULL,
    [acc_ID] INT NULL
);

CREATE TABLE [zzz_PlatformAuto_Delisted_v2] (
    [car_id] VARCHAR(32) NULL,
    [vin] VARCHAR(32) NULL,
    [date_delisted] DATE NULL
);

CREATE TABLE [zzz_PlatformAuto_Monster_Results] (
    [id] INT NOT NULL -- PK,
    [acc_id] BIGINT NULL,
    [acc_company] VARCHAR(128) NULL,
    [adez_url] NVARCHAR(1024) NULL,
    [adez_utm] NVARCHAR(512) NULL,
    [_master_id] BIGINT NULL,
    [adez_vehicletype] VARCHAR(32) NULL,
    [adez_language] VARCHAR(32) NULL,
    [sub_status] VARCHAR(16) NULL,
    [sc_aso_id] BIGINT NULL,
    [sales_channel] VARCHAR(128) NULL,
    [adez_start_date] DATE NULL,
    [Total_Count] INT NOT NULL,
    [Total_Image] INT NOT NULL,
    [Perc_Image] NUMERIC(26,14) NULL,
    [Total_VDP] INT NOT NULL,
    [Perc_VDP] NUMERIC(26,14) NULL,
    [Total_New] INT NOT NULL,
    [New_Image] INT NOT NULL,
    [New_VDP] INT NOT NULL,
    [New_Usable] INT NOT NULL,
    [Total_Used] INT NOT NULL,
    [Used_Image] INT NOT NULL,
    [Used_VDP] INT NOT NULL,
    [Used_Usable] INT NOT NULL,
    [Used_GoodPrice] INT NOT NULL,
    [Used_GoodPrice_Usable] INT NOT NULL,
    [Total_VIN] INT NOT NULL,
    [Total_Stock] INT NOT NULL,
    [crawler_url] VARCHAR(128) NULL,
    [veh_count] INT NULL,
    [withvin] INT NULL,
    [withstock] INT NULL,
    [job_lastexecution] DATE NULL,
    [Problems] VARCHAR(256) NULL,
    [fmn_date] DATE NULL,
    [fmn_by] VARCHAR(65) NULL,
    [fmn_note] TEXT NULL,
    [msg_url] VARCHAR(90) NULL
);

CREATE TABLE [zzz_PlatformAutoDataForCompare] (
    [dlrName] VARCHAR(90) NULL,
    [dlrID] VARCHAR(16) NULL,
    [businessUnit] VARCHAR(128) NULL,
    [promoType] VARCHAR(16) NULL,
    [dlrCity] VARCHAR(32) NULL,
    [dlrState] VARCHAR(16) NULL,
    [currentStatus] VARCHAR(16) NULL,
    [vdpViews] VARCHAR(16) NULL,
    [vdpMonthlyGoal] VARCHAR(16) NULL,
    [prorated] VARCHAR(16) NULL,
    [maxMonthlyBudget] VARCHAR(16) NULL,
    [mediaCost] VARCHAR(16) NULL,
    [impressions] VARCHAR(16) NULL,
    [uniqueVisitors] VARCHAR(16) NULL,
    [costPerImpression] VARCHAR(16) NULL,
    [costPerUniqueVisitor] VARCHAR(16) NULL,
    [costPerView] VARCHAR(16) NULL,
    [costPerView_14Days] VARCHAR(16) NULL,
    [liveDate] VARCHAR(16) NULL,
    [endDate] VARCHAR(16) NULL,
    [method] VARCHAR(16) NULL,
    [fbPageAccess] VARCHAR(16) NULL,
    [using_TMPi_feed] VARCHAR(16) NULL,
    [TMPi_VDP_URLs] VARCHAR(16) NULL,
    [tmpFeed] VARCHAR(16) NULL,
    [utm_code] VARCHAR(256) NULL
);

CREATE TABLE [zzz_PlatformAutoDataForCompare_OLD] (
    [dlrName] VARCHAR(64) NULL,
    [dlrID] VARCHAR(12) NULL,
    [businessUnit] VARCHAR(10) NULL,
    [promoType] VARCHAR(16) NULL,
    [dlrCity] VARCHAR(32) NULL,
    [dlrState] VARCHAR(4) NULL,
    [currentStatus] VARCHAR(10) NULL,
    [vdpViews] VARCHAR(10) NULL,
    [vdpMonthlyGoal] VARCHAR(10) NULL,
    [prorated] VARCHAR(10) NULL,
    [maxMonthlyBudget] VARCHAR(10) NULL,
    [mediaCost] VARCHAR(16) NULL,
    [impressions] VARCHAR(10) NULL,
    [uniqueVisitors] VARCHAR(10) NULL,
    [costPerImpression] VARCHAR(10) NULL,
    [costPerUniqueVisitor] VARCHAR(10) NULL,
    [costPerView] VARCHAR(10) NULL,
    [costPerView_14Days] VARCHAR(32) NULL,
    [liveDate] VARCHAR(12) NULL,
    [endDate] VARCHAR(12) NULL,
    [method] VARCHAR(5) NULL,
    [fbPageAccess] VARCHAR(10) NULL,
    [inventoryStatus] VARCHAR(24) NULL,
    [plaScrape] VARCHAR(10) NULL,
    [tmpFeed] VARCHAR(10) NULL,
    [utm_code] VARCHAR(128) NULL
);

CREATE TABLE [zzz_PlatformAutoListings] (
    [DEALER_NAME] VARCHAR(256) NULL,
    [CLIENT_ID] INT NULL,
    [INVENTORY_SCRAPE] VARCHAR(256) NULL,
    [PM_SCRAPE_NUM] INT NULL,
    [TMP_FEED_NUM] INT NULL
);

CREATE TABLE [zzz_PlatformAutoNumbers] (
    [name] VARCHAR(256) NULL,
    [client_id] INT NULL,
    [promotion_type] VARCHAR(32) NULL,
    [city] VARCHAR(128) NULL,
    [state] VARCHAR(5) NULL,
    [current_status] VARCHAR(32) NULL,
    [vdp_views] INT NULL,
    [current_vdp_goal_monthly] INT NULL,
    [prorated] VARCHAR(32) NULL,
    [max_monthly_budget] INT NULL,
    [media_cost] MONEY NULL,
    [impressions] INT NULL,
    [unique_srp_visitors] INT NULL,
    [per_impression] MONEY NULL,
    [per_unique_srp_visitor] MONEY NULL,
    [per_vdp_view] MONEY NULL,
    [per_vdp_view_14_days] MONEY NULL,
    [live_date] VARCHAR(32) NULL,
    [end_date] VARCHAR(32) NULL,
    [method] VARCHAR(32) NULL,
    [current_fb_page_access] VARCHAR(32) NULL,
    [inventory_status] VARCHAR(32) NULL,
    [PM_Num] INT NULL,
    [Feed_Num] INT NULL
);

CREATE TABLE [zzz_PLETracker] (
    [PollID] INT NOT NULL -- PK,
    [PollTime] DATETIME NOT NULL,
    [SQLInstance] NVARCHAR(128) NULL,
    [Object] NCHAR(128) NOT NULL,
    [Counter] NCHAR(128) NOT NULL,
    [UptimeMins] INT NULL,
    [PLE_Secs] BIGINT NOT NULL,
    [PLE_Mins] BIGINT NULL,
    [PLE_Hrs] BIGINT NULL,
    [PLE_Days] BIGINT NULL
);

CREATE TABLE [zzz_PowerListing_URL_UTM_BU] (
    [ratchet_id] BIGINT NOT NULL,
    [subscription_id] BIGINT NULL,
    [adv_acc_id] BIGINT NULL,
    [Provider] NVARCHAR(255) NULL,
    [Provider_Id] NVARCHAR(255) NULL,
    [dealer_url] NVARCHAR(1024) NULL,
    [utm_code] NVARCHAR(512) NULL,
    [utm_source] NVARCHAR(32) NULL,
    [modified_date] DATETIME NULL
);

CREATE TABLE [zzz_PowerListingCheckTemp] (
    [adv_acc_id] BIGINT NULL,
    [adv_name] VARCHAR(128) NULL,
    [prd_id] BIGINT NULL,
    [prd_package] VARCHAR(128) NULL,
    [pl_vehicle_type] VARCHAR(32) NULL,
    [pl_language] VARCHAR(32) NULL,
    [ran] INT NOT NULL,
    [isNewVehicle] INT NULL,
    [TotalListings] INT NULL,
    [Have_Prices] INT NULL,
    [Have_Images] INT NULL,
    [Downloaded_Images] INT NULL,
    [Crawl_Matched] INT NULL,
    [Text_Not_Blank] INT NULL,
    [SmartAd_Approved] INT NULL,
    [PowerListing_Approved] INT NULL,
    [minModified] DATETIME NULL,
    [maxModified] DATETIME NULL
);

CREATE TABLE [zzz_PreDefinedImages] (
    [pdi_ID] INT NOT NULL -- PK,
    [pds_ID] INT NOT NULL,
    [pdi_Image] VARCHAR(100) NOT NULL,
    [pdi_Text] VARCHAR(100) NOT NULL,
    [pdi_URL] VARCHAR(500) NOT NULL,
    [pdi_Order] INT NOT NULL
);

CREATE TABLE [zzz_PreDefinedLinks] (
    [pdl_ID] INT NOT NULL -- PK,
    [pds_ID] INT NOT NULL,
    [pdl_Order] INT NOT NULL,
    [pdl_Name] VARCHAR(100) NOT NULL,
    [pdl_Link] VARCHAR(500) NOT NULL,
    [pdl_LinkTarget] VARCHAR(10) NOT NULL,
    [pdl_Level] TINYINT NOT NULL,
    [pdl_LinkSection] INT NOT NULL
);

CREATE TABLE [zzz_PreDefinedSearches] (
    [pds_ID] INT NOT NULL -- PK,
    [pds_Keyword] VARCHAR(50) NOT NULL,
    [pds_Title] VARCHAR(200) NOT NULL,
    [pds_MetaDesc] VARCHAR(200) NOT NULL,
    [pds_MetaKeyword] VARCHAR(200) NOT NULL,
    [pds_Header] VARCHAR(1000) NOT NULL,
    [pds_Footer] VARCHAR(1000) NOT NULL,
    [pds_PublicKeyword] VARCHAR(100) NOT NULL,
    [pds_Target] VARCHAR(100) NOT NULL,
    [pds_H1Title] VARCHAR(200) NOT NULL,
    [pds_BlogCategory] VARCHAR(500) NOT NULL,
    [pds_Order] INT NOT NULL
);

CREATE TABLE [zzz_PreDefinedSearchVariables] (
    [psv_ID] INT NOT NULL -- PK,
    [pds_ID] INT NOT NULL,
    [is_Bin_State] INT NOT NULL,
    [param_Name] VARCHAR(50) NOT NULL,
    [param_Value] VARCHAR(50) NOT NULL
);

CREATE TABLE [zzz_ProgressusPull] (
    [id] VARCHAR(20) NOT NULL -- PK,
    [dealer_name] VARCHAR(100) NOT NULL,
    [zip] VARCHAR(10) NOT NULL,
    [city] VARCHAR(100) NOT NULL,
    [state] VARCHAR(10) NOT NULL,
    [address] VARCHAR(10) NOT NULL,
    [url] VARCHAR(100) NOT NULL,
    [third_party_id_ex] VARCHAR(100) NOT NULL,
    [fb_page_id] VARCHAR(100) NOT NULL,
    [contact_email] VARCHAR(100) NOT NULL,
    [utm_code] VARCHAR(100) NOT NULL,
    [ga_id] VARCHAR(100) NOT NULL,
    [monthly_budget] VARCHAR(10) NOT NULL,
    [first_month_budget] VARCHAR(100) NOT NULL,
    [pilot_date_start] VARCHAR(100) NOT NULL,
    [pilot_date_end] VARCHAR(100) NOT NULL,
    [promotion_type] VARCHAR(10) NOT NULL,
    [language] VARCHAR(10) NOT NULL,
    [contact_phone] VARCHAR(100) NOT NULL,
    [privacy_link] VARCHAR(100) NOT NULL,
    [contact_link] VARCHAR(100) NOT NULL,
    [third_party_dealer_id] VARCHAR(100) NOT NULL
);

CREATE TABLE [zzz_PromoCodes] (
    [prc_ID] INT NOT NULL -- PK,
    [prc_Name] VARCHAR(64) NOT NULL,
    [prc_Start] DATETIME NOT NULL,
    [prc_End] DATETIME NOT NULL,
    [prc_Amount] MONEY NOT NULL,
    [prt_ID] INT NOT NULL,
    [prs_ID] INT NOT NULL,
    [prc_Created] DATETIME NOT NULL,
    [prc_CreatedBy] INT NOT NULL,
    [prc_Modified] DATETIME NOT NULL,
    [prc_ModifiedBy] INT NOT NULL,
    [prc_Account_CreatedAfter] DATETIME NULL,
    [prc_Last_Listing_As_Of] DATETIME NULL
);

CREATE TABLE [zzz_PromoCodesSource] (
    [prc_ID] INT NOT NULL,
    [src_ID] INT NOT NULL
);

CREATE TABLE [zzz_PromoPrintPublications] (
    [prc_ID] INT NOT NULL -- PK,
    [pub_ID] INT NOT NULL -- PK
);

CREATE TABLE [zzz_PromoRates] (
    [prc_ID] INT NOT NULL -- PK,
    [rat_ID] INT NOT NULL -- PK
);

CREATE TABLE [zzz_PromoStatus] (
    [prs_ID] INT NOT NULL -- PK,
    [prs_Name] VARCHAR(64) NOT NULL,
    [prs_Order] INT NOT NULL,
    [prs_Active] BIT NOT NULL
);

CREATE TABLE [zzz_PromoType] (
    [prt_ID] INT NOT NULL -- PK,
    [prt_Name] VARCHAR(64) NOT NULL,
    [prt_Order] INT NOT NULL,
    [prt_Active] BIT NOT NULL
);

CREATE TABLE [zzz_ProofLock] (
    [prl_ID] INT NOT NULL -- PK,
    [acc_ID] INT NOT NULL,
    [lst_ID] INT NOT NULL,
    [prl_Date] DATETIME NOT NULL
);

CREATE TABLE [zzz_ProofQueue] (
    [prq_ID] INT NOT NULL -- PK,
    [prq_Name] VARCHAR(64) NOT NULL,
    [prq_Active] BIT NOT NULL,
    [prq_Order] INT NOT NULL
);

CREATE TABLE [zzz_ProofRejectReason] (
    [prr_ID] INT NOT NULL -- PK,
    [prr_Name] VARCHAR(64) NOT NULL,
    [prr_Description] VARCHAR(1024) NOT NULL,
    [prr_Active] BIT NOT NULL,
    [prr_isReject] INT NOT NULL
);

CREATE TABLE [zzz_ptest] (
    [RowNum] BIGINT NULL,
    [jobid] INT NOT NULL,
    [accid] INT NOT NULL,
    [jobtitle] VARCHAR(255) NOT NULL,
    [jobdesc] TEXT NOT NULL,
    [States] VARCHAR(8000) NULL,
    [JobType] VARCHAR(8000) NULL,
    [Opportunity] VARCHAR(8000) NULL,
    [JobDriven] VARCHAR(8000) NULL,
    [jobattributes] VARCHAR(4000) NOT NULL
);

CREATE TABLE [zzz_PublicationLocations] (
    [plc_ID] INT NOT NULL -- PK,
    [rgn_ID] INT NOT NULL,
    [plc_Name] VARCHAR(256) NOT NULL,
    [plc_Address] VARCHAR(512) NOT NULL,
    [plc_City] VARCHAR(256) NOT NULL,
    [plc_State] VARCHAR(5) NULL,
    [plc_Zip] VARCHAR(10) NOT NULL,
    [plc_Phones] VARCHAR(128) NOT NULL,
    [plc_Sort] INT NOT NULL,
    [plc_Email] VARCHAR(256) NULL,
    [plc_Pdf] VARCHAR(256) NULL
);

CREATE TABLE [zzz_PublicationRegion] (
    [rgn_ID] INT NOT NULL -- PK,
    [rgn_Name] VARCHAR(256) NOT NULL,
    [rgn_Sort] INT NOT NULL
);

CREATE TABLE [zzz_PurgeList] (
    [pgl_ID] INT NOT NULL -- PK,
    [pgl_Source_ID] INT NOT NULL,
    [pgl_Source_Name] VARCHAR(64) NOT NULL
);

CREATE TABLE [zzz_QAImages] (
    [imgName] VARCHAR(512) NULL
);

CREATE TABLE [zzz_Query] (
    [F1] FLOAT NULL,
    [F2] NVARCHAR(255) NULL,
    [F3] FLOAT NULL,
    [F4] NVARCHAR(255) NULL,
    [F5] FLOAT NULL,
    [F6] FLOAT NULL,
    [F7] NVARCHAR(255) NULL,
    [F8] FLOAT NULL,
    [F9] FLOAT NULL,
    [F10] NVARCHAR(255) NULL,
    [F11] BIT NULL,
    [F12] NVARCHAR(255) NULL
);

CREATE TABLE [zzz_RatchetDisplay_PlatformAuto_Mapping_DONT_USE_JO_20180605] (
    [rcd_master_ID] BIGINT NOT NULL -- PK,
    [pla_cmp_ID] BIGINT NOT NULL -- PK
);

CREATE TABLE [zzz_RatchetFulfillmentLog] (
    [rflid] INT NOT NULL -- PK,
    [rcl_ID] INT NOT NULL,
    [fulfiller_acc_id] INT NOT NULL,
    [created] DATETIME NOT NULL
);

CREATE TABLE [zzz_RatchetLocal] (
    [rcl_ID] INT NOT NULL -- PK,
    [rcl_Master_ID] INT NULL,
    [rcc_ID] INT NOT NULL,
    [rcl_Created] DATETIME NOT NULL,
    [rcl_Created_acc_ID] INT NOT NULL,
    [rcl_DateSold] DATETIME NOT NULL,
    [rcl_Cost] MONEY NOT NULL,
    [rcl_rft_ID] INT NOT NULL,
    [rcl_isLive] BIT NOT NULL,
    [rcl_MeteredLine] BIT NOT NULL,
    [rcl_RecordCalls] BIT NOT NULL,
    [rcl_Email] VARCHAR(128) NOT NULL,
    [rcl_TagLine] VARCHAR(140) NOT NULL,
    [rcl_Bullet1] VARCHAR(40) NOT NULL,
    [rcl_Bullet2] VARCHAR(40) NOT NULL,
    [rcl_Bullet3] VARCHAR(40) NOT NULL,
    [rcl_Message] VARCHAR(1024) NOT NULL,
    [rcl_SiteURL] VARCHAR(512) NOT NULL,
    [rcl_DisplayURL] VARCHAR(512) NOT NULL,
    [rcl_FaceBookURL] VARCHAR(512) NOT NULL,
    [rcl_TwitterAccount] VARCHAR(128) NOT NULL,
    [rcl_TwitterPassword] VARCHAR(50) NOT NULL,
    [rcl_ReservationsLink] VARCHAR(256) NOT NULL,
    [rcl_MenuLink] VARCHAR(256) NOT NULL,
    [rcl_AcceptedPayment] VARCHAR(256) NOT NULL,
    [rcl_SponsoredTagLine] VARCHAR(140) NOT NULL,
    [rcl_OwnerImage] VARCHAR(512) NOT NULL,
    [rcl_SponsoredImage] VARCHAR(512) NOT NULL,
    [rcl_LiveDate] DATETIME NULL,
    [rcl_SentToCGDate] DATETIME NULL,
    [rcl_ZipCodes] VARCHAR(500) NOT NULL,
    [rlds_id] INT NULL,
    [rcl_TrackingPhone] VARCHAR(24) NOT NULL,
    [rcl_LocalPhone] VARCHAR(24) NOT NULL,
    [rcl_NoWhosCalling] BIT NOT NULL,
    [rcl_CitySearchOnly] BIT NOT NULL,
    [rcl_OfferSlogan] VARCHAR(50) NOT NULL,
    [rcl_HasCoupon] BIT NOT NULL,
    [rcl_YouTubeURL] VARCHAR(255) NOT NULL,
    [rcl_TaglineURL] VARCHAR(255) NOT NULL,
    [rcl_Location_Name] VARCHAR(64) NOT NULL,
    [rcl_Location_Address1] VARCHAR(64) NOT NULL,
    [rcl_Location_Address2] VARCHAR(64) NOT NULL,
    [rcl_Location_City] VARCHAR(64) NOT NULL,
    [rcl_Location_State] VARCHAR(2) NOT NULL,
    [rcl_Location_Zip] VARCHAR(5) NOT NULL,
    [rcl_CG_Budget] MONEY NULL,
    [rcl_Notes] VARCHAR(1024) NOT NULL,
    [rcl_YextListingManager] BIT NOT NULL,
    [rcl_StartDate] DATETIME NULL,
    [rcl_EndDate] DATETIME NULL
);

CREATE TABLE [zzz_RatchetLocalBusinessHours] (
    [rlbh_id] INT NOT NULL -- PK,
    [rcl_ID] INT NOT NULL,
    [rlbh_label] VARCHAR(50) NOT NULL,
    [rlbh_start] VARCHAR(12) NOT NULL,
    [rlbh_end] VARCHAR(12) NOT NULL,
    [rlbh_select] INT NOT NULL,
    [rlbh_sort] INT NOT NULL
);

CREATE TABLE [zzz_RatchetLocalCategories] (
    [rcl_ID] INT NOT NULL -- PK,
    [cgc_ID] INT NOT NULL -- PK,
    [rlc_Created] DATETIME NOT NULL,
    [sort] INT NOT NULL
);

CREATE TABLE [zzz_RatchetLocalDisplayStatus] (
    [rlds_id] INT NOT NULL -- PK,
    [rlds_name] VARCHAR(50) NOT NULL
);

CREATE TABLE [zzz_RatchetLocalIsLiveExpired] (
    [rcl_ID] INT NOT NULL,
    [rcl_Master_ID] INT NULL,
    [rcc_ID] INT NOT NULL,
    [rcl_Created] DATETIME NOT NULL,
    [rcl_Created_acc_ID] INT NOT NULL,
    [rcl_DateSold] DATETIME NOT NULL,
    [rcl_Cost] MONEY NOT NULL,
    [rcl_rft_ID] INT NOT NULL,
    [rcl_isLive] BIT NOT NULL,
    [rcl_MeteredLine] BIT NOT NULL,
    [rcl_RecordCalls] BIT NOT NULL,
    [rcl_Email] VARCHAR(128) NOT NULL,
    [rcl_TagLine] VARCHAR(140) NOT NULL,
    [rcl_Bullet1] VARCHAR(40) NOT NULL,
    [rcl_Bullet2] VARCHAR(40) NOT NULL,
    [rcl_Bullet3] VARCHAR(40) NOT NULL,
    [rcl_Message] VARCHAR(1024) NOT NULL,
    [rcl_SiteURL] VARCHAR(512) NOT NULL,
    [rcl_DisplayURL] VARCHAR(512) NOT NULL,
    [rcl_FaceBookURL] VARCHAR(512) NOT NULL,
    [rcl_TwitterAccount] VARCHAR(128) NOT NULL,
    [rcl_TwitterPassword] VARCHAR(50) NOT NULL,
    [rcl_ReservationsLink] VARCHAR(256) NOT NULL,
    [rcl_MenuLink] VARCHAR(256) NOT NULL,
    [rcl_AcceptedPayment] VARCHAR(256) NOT NULL,
    [rcl_SponsoredTagLine] VARCHAR(140) NOT NULL,
    [rcl_OwnerImage] VARCHAR(512) NOT NULL,
    [rcl_SponsoredImage] VARCHAR(512) NOT NULL,
    [rcl_LiveDate] DATETIME NULL,
    [rcl_SentToCGDate] DATETIME NULL,
    [rcl_ZipCodes] VARCHAR(500) NOT NULL,
    [rlds_id] INT NULL,
    [rcl_TrackingPhone] VARCHAR(24) NOT NULL,
    [rcl_LocalPhone] VARCHAR(24) NOT NULL,
    [rcl_NoWhosCalling] BIT NOT NULL,
    [rcl_CitySearchOnly] BIT NOT NULL,
    [rcl_OfferSlogan] VARCHAR(50) NOT NULL,
    [rcl_HasCoupon] BIT NOT NULL,
    [rcl_YouTubeURL] VARCHAR(255) NOT NULL,
    [rcl_TaglineURL] VARCHAR(255) NOT NULL,
    [rcl_Location_Name] VARCHAR(64) NOT NULL,
    [rcl_Location_Address1] VARCHAR(64) NOT NULL,
    [rcl_Location_Address2] VARCHAR(64) NOT NULL,
    [rcl_Location_City] VARCHAR(64) NOT NULL,
    [rcl_Location_State] VARCHAR(2) NOT NULL,
    [rcl_Location_Zip] VARCHAR(5) NOT NULL,
    [rcl_CG_Budget] MONEY NULL,
    [rcl_Notes] VARCHAR(1024) NOT NULL,
    [rcl_YextListingManager] BIT NOT NULL,
    [rcl_StartDate] DATETIME NULL,
    [rcl_EndDate] DATETIME NULL
);

CREATE TABLE [zzz_RatchetLocalIsLiveFix] (
    [rcl_ID] INT NOT NULL,
    [rcl_Master_ID] INT NULL,
    [rcc_ID] INT NOT NULL,
    [rcl_Created] DATETIME NOT NULL,
    [rcl_Created_acc_ID] INT NOT NULL,
    [rcl_DateSold] DATETIME NOT NULL,
    [rcl_Cost] MONEY NOT NULL,
    [rcl_rft_ID] INT NOT NULL,
    [rcl_isLive] BIT NOT NULL,
    [rcl_MeteredLine] BIT NOT NULL,
    [rcl_RecordCalls] BIT NOT NULL,
    [rcl_Email] VARCHAR(128) NOT NULL,
    [rcl_TagLine] VARCHAR(140) NOT NULL,
    [rcl_Bullet1] VARCHAR(40) NOT NULL,
    [rcl_Bullet2] VARCHAR(40) NOT NULL,
    [rcl_Bullet3] VARCHAR(40) NOT NULL,
    [rcl_Message] VARCHAR(1024) NOT NULL,
    [rcl_SiteURL] VARCHAR(512) NOT NULL,
    [rcl_DisplayURL] VARCHAR(512) NOT NULL,
    [rcl_FaceBookURL] VARCHAR(512) NOT NULL,
    [rcl_TwitterAccount] VARCHAR(128) NOT NULL,
    [rcl_TwitterPassword] VARCHAR(50) NOT NULL,
    [rcl_ReservationsLink] VARCHAR(256) NOT NULL,
    [rcl_MenuLink] VARCHAR(256) NOT NULL,
    [rcl_AcceptedPayment] VARCHAR(256) NOT NULL,
    [rcl_SponsoredTagLine] VARCHAR(140) NOT NULL,
    [rcl_OwnerImage] VARCHAR(512) NOT NULL,
    [rcl_SponsoredImage] VARCHAR(512) NOT NULL,
    [rcl_LiveDate] DATETIME NULL,
    [rcl_SentToCGDate] DATETIME NULL,
    [rcl_ZipCodes] VARCHAR(500) NOT NULL,
    [rlds_id] INT NULL,
    [rcl_TrackingPhone] VARCHAR(24) NOT NULL,
    [rcl_LocalPhone] VARCHAR(24) NOT NULL,
    [rcl_NoWhosCalling] BIT NOT NULL,
    [rcl_CitySearchOnly] BIT NOT NULL,
    [rcl_OfferSlogan] VARCHAR(50) NOT NULL,
    [rcl_HasCoupon] BIT NOT NULL,
    [rcl_YouTubeURL] VARCHAR(255) NOT NULL,
    [rcl_TaglineURL] VARCHAR(255) NOT NULL,
    [rcl_Location_Name] VARCHAR(64) NOT NULL,
    [rcl_Location_Address1] VARCHAR(64) NOT NULL,
    [rcl_Location_Address2] VARCHAR(64) NOT NULL,
    [rcl_Location_City] VARCHAR(64) NOT NULL,
    [rcl_Location_State] VARCHAR(2) NOT NULL,
    [rcl_Location_Zip] VARCHAR(5) NOT NULL,
    [rcl_CG_Budget] MONEY NULL,
    [rcl_Notes] VARCHAR(1024) NOT NULL,
    [rcl_YextListingManager] BIT NOT NULL,
    [rcl_StartDate] DATETIME NULL,
    [rcl_EndDate] DATETIME NULL
);

CREATE TABLE [zzz_RatchetLocalMigration] (
    [rcl_Master_ID] BIGINT NOT NULL -- PK,
    [ReadyToMigrate] INT NULL,
    [SubscriptionID] BIGINT NULL,
    [DateMigrated] DATETIME NULL,
    [CampaignId] BIGINT NULL
);

CREATE TABLE [zzz_ratchetlocalmigration_yextclientid] (
    [rcc_Master_ID] INT NULL,
    [rcl_master_id] BIGINT NULL,
    [yext_clientid] VARCHAR(100) NULL
);

CREATE TABLE [zzz_RatchetLocalOffer] (
    [rlo_ID] INT NOT NULL -- PK,
    [rcl_ID] INT NOT NULL,
    [rot_ID] INT NOT NULL,
    [rlo_StartDate] DATETIME NOT NULL,
    [rlo_EndDate] DATETIME NULL,
    [rlo_Details] VARCHAR(512) NOT NULL,
    [rlo_TagLine] VARCHAR(100) NOT NULL,
    [rlo_Description] VARCHAR(500) NOT NULL
);

CREATE TABLE [zzz_RatchetLocalOfferType] (
    [rot_ID] INT NOT NULL -- PK,
    [rot_Name] VARCHAR(32) NOT NULL,
    [rot_Sort] INT NOT NULL,
    [rot_Active] BIT NOT NULL
);

CREATE TABLE [zzz_RatchetLocalProfileImages] (
    [rcl_ID] INT NOT NULL -- PK,
    [rlp_Sort] INT NOT NULL -- PK,
    [rlp_URL] VARCHAR(512) NOT NULL,
    [rlp_Description] VARCHAR(512) NOT NULL,
    [rlp_Created] DATETIME NOT NULL
);

CREATE TABLE [zzz_RatchetLocalStartEnd_v2] (
    [rcl_ID] INT NOT NULL,
    [rcl_Master_ID] INT NOT NULL,
    [rcl_LiveDate] DATETIME NULL,
    [DateEnded_Formatted] DATE NULL,
    [rcl_Master_Created] DATETIME NULL
);

CREATE TABLE [zzz_Rate] (
    [rat_ID] INT NOT NULL -- PK,
    [rat_Name] VARCHAR(64) NOT NULL,
    [rat_BusinessOnly] BIT NOT NULL,
    [rat_CreatedBy] VARCHAR(32) NOT NULL,
    [rat_CreatedDate] DATETIME NOT NULL,
    [rat_Modifiedby] VARCHAR(32) NOT NULL,
    [rat_ModifiedDate] DATETIME NOT NULL,
    [rat_PrintPhoto] BIT NULL,
    [rat_Active] BIT NOT NULL,
    [rat_Order] INT NULL,
    [rat_PlacementImage] VARCHAR(512) NULL,
    [rat_PlacementText] VARCHAR(128) NULL
);

CREATE TABLE [zzz_RateOption] (
    [rop_ID] INT NOT NULL -- PK,
    [rog_ID] INT NOT NULL,
    [rop_Name] VARCHAR(64) NOT NULL,
    [rop_PublicLabel] VARCHAR(1024) NOT NULL,
    [rop_Active] BIT NOT NULL
);

CREATE TABLE [zzz_RateOptionEditionTranslate] (
    [rop_ID] INT NOT NULL,
    [edid] INT NOT NULL,
    [isPrint] BIT NULL
);

CREATE TABLE [zzz_RateOptionGroup] (
    [rog_ID] INT NOT NULL -- PK,
    [rgt_ID] INT NOT NULL,
    [rog_Name] VARCHAR(32) NOT NULL,
    [rog_Active] BIT NOT NULL
);

CREATE TABLE [zzz_RateOptionGroupType] (
    [rgt_ID] INT NOT NULL -- PK,
    [rgt_Name] VARCHAR(32) NOT NULL,
    [rgt_Active] BIT NOT NULL
);

CREATE TABLE [zzz_RateOptionStatus] (
    [ros_ID] INT NOT NULL -- PK,
    [ros_Name] VARCHAR(32) NOT NULL,
    [ros_Active] BIT NOT NULL
);

CREATE TABLE [zzz_RateRegion] (
    [rrg_ID] INT NOT NULL -- PK,
    [rat_ID] INT NOT NULL,
    [src_ID] INT NOT NULL,
    [rrg_Name] VARCHAR(128) NOT NULL,
    [rrg_PublicLabel] VARCHAR(1024) NOT NULL,
    [rrg_AdminLabel] VARCHAR(1024) NOT NULL,
    [rrg_AdminNotes] VARCHAR(1024) NOT NULL,
    [rrg_BasePrice] MONEY NOT NULL,
    [rrg_RenewalPrice] MONEY NOT NULL,
    [rrg_BaseWeeks] INT NOT NULL,
    [rrg_RenewalWeeks] INT NOT NULL,
    [rrg_RenewalMaxWeeks] INT NOT NULL,
    [rrg_OnlineMaxCharacters] INT NOT NULL,
    [rrg_OnlineWordCost] MONEY NOT NULL,
    [rrg_OnlineCharacterBlockcount] INT NOT NULL,
    [rrg_OnlineCharacterBlockCost] MONEY NOT NULL,
    [rrg_PrintMaxCharacters] INT NOT NULL,
    [rrg_PrintWordCost] MONEY NOT NULL,
    [rrg_PrintCharacterBlockCount] INT NOT NULL,
    [rrg_PrintCharacterBlockCost] MONEY NOT NULL,
    [rrg_MaxItemPrice] MONEY NOT NULL,
    [rrg_MaxFreeAds] INT NOT NULL,
    [rrg_ExpiredMaxDays] INT NOT NULL,
    [rrg_PicMaxFree] INT NOT NULL,
    [rrg_PicPrice] MONEY NOT NULL,
    [rrg_PicMaxTotal] INT NOT NULL,
    [rrg_Active] BIT NOT NULL,
    [rrg_Features] VARCHAR(2048) NOT NULL
);

CREATE TABLE [zzz_RateRegionOption] (
    [rro_ID] INT NOT NULL -- PK,
    [rrg_ID] INT NOT NULL,
    [rop_ID] INT NOT NULL,
    [ros_ID] INT NOT NULL,
    [rro_BasePrice] MONEY NOT NULL,
    [rro_RenewalPrice] MONEY NOT NULL,
    [rro_Active] BIT NOT NULL
);

CREATE TABLE [zzz_RateRegionPrintEditions] (
    [rpe_ID] INT NOT NULL -- PK,
    [rrg_ID] INT NOT NULL,
    [ped_ID] INT NOT NULL,
    [ros_ID] INT NOT NULL,
    [rpe_BasePrice] MONEY NOT NULL,
    [rpe_RenewalPrice] MONEY NOT NULL,
    [rpe_Active] BIT NOT NULL
);

CREATE TABLE [zzz_RateRegionPrintEditionsDiscount] (
    [rpd_ID] INT NOT NULL -- PK,
    [rrg_ID] INT NOT NULL,
    [rpd_Count] INT NOT NULL,
    [rpd_Discount] MONEY NOT NULL,
    [rpd_Active] BIT NOT NULL
);

CREATE TABLE [zzz_RateRegionSubClass] (
    [rsc_ID] INT NOT NULL -- PK,
    [rrg_ID] INT NOT NULL,
    [scl_ID] INT NOT NULL
);

CREATE TABLE [zzz_RateRegionZip] (
    [rrz_ID] INT NOT NULL -- PK,
    [rrg_ID] INT NOT NULL,
    [zip_Code] VARCHAR(5) NOT NULL
);

CREATE TABLE [zzz_rcd_flydates] (
    [rcd_master_id] INT NOT NULL,
    [l_rcd_id] INT NOT NULL,
    [rcd_startdate] DATE NULL,
    [rcd_enddate] DATE NULL,
    [i_rcd_id] INT NULL
);

CREATE TABLE [zzz_RCY_Data] (
    [adv_acc_id] BIGINT NULL,
    [adv_name] VARCHAR(128) NULL,
    [sales_channel] VARCHAR(128) NULL,
    [amtDate] INT NOT NULL,
    [RCY_SRP] INT NULL,
    [RCY_VDP] INT NULL
);

CREATE TABLE [zzz_Receipt] (
    [rec_ID] INT NOT NULL -- PK,
    [acc_ID] INT NOT NULL,
    [lst_ID] INT NOT NULL,
    [rec_Amount] MONEY NOT NULL,
    [rec_Date] DATETIME NOT NULL,
    [rcs_ID] INT NOT NULL,
    [rec_Note] VARCHAR(512) NOT NULL,
    [rec_CardNumber_Enc] VARCHAR(1024) NOT NULL,
    [rec_CardNumber_Mask] VARCHAR(16) NOT NULL,
    [rec_CardExpiration_Enc] VARCHAR(1024) NOT NULL,
    [rec_CardCVC_Enc] VARCHAR(4) NOT NULL,
    [rec_CardName] VARCHAR(64) NOT NULL,
    [rec_CardAddress] VARCHAR(64) NOT NULL,
    [rec_CardCity] VARCHAR(64) NOT NULL,
    [rec_CardState] VARCHAR(2) NOT NULL,
    [zip_Code] VARCHAR(5) NOT NULL,
    [rec_ProcessorID] VARCHAR(32) NULL,
    [rec_ProcessorDate] DATETIME NULL,
    [rec_ProcessorResult] VARCHAR(512) NULL,
    [rec_ProcessorAVSResponse] VARCHAR(32) NULL,
    [rec_ProcessorCVCResponse] VARCHAR(32) NULL,
    [rec_ProcessorCaptured] MONEY NULL
);

CREATE TABLE [zzz_ReceiptStatus] (
    [rcs_ID] INT NOT NULL -- PK,
    [rcs_Name] VARCHAR(32) NOT NULL,
    [rcs_Active] BIT NOT NULL
);

CREATE TABLE [zzz_Refinement] (
    [r_id] INT NOT NULL,
    [att_id] INT NOT NULL,
    [order_id] INT NULL
);

CREATE TABLE [zzz_Refund] (
    [ref_ID] INT NOT NULL -- PK,
    [rec_ID] INT NOT NULL,
    [ref_Amount] MONEY NOT NULL,
    [ref_RequestedBy] INT NOT NULL,
    [ref_RequestedDate] DATETIME NOT NULL,
    [ref_ProcessedBy] INT NULL,
    [ref_ProcessedDate] DATETIME NULL,
    [ref_Note] VARCHAR(512) NOT NULL,
    [ref_ProcessorID] VARCHAR(32) NULL,
    [ref_ProcessorDate] DATETIME NULL,
    [ref_ProcessorResult] VARCHAR(512) NULL,
    [ref_ProcessorAVSResponse] VARCHAR(32) NULL,
    [ref_ProcessorDesc] VARCHAR(512) NULL,
    [ref_ProcessorErr] VARCHAR(512) NULL,
    [rft_ID] INT NOT NULL
);

CREATE TABLE [zzz_RefundModifyNoteLog] (
    [ID] INT NOT NULL -- PK,
    [ref_ID] INT NOT NULL,
    [ref_Note_Start] VARCHAR(512) NOT NULL,
    [ref_Note_End] VARCHAR(512) NOT NULL,
    [acc_ID] INT NOT NULL,
    [ref_Modify_Date] DATETIME NOT NULL
);

CREATE TABLE [zzz_RefundType] (
    [rft_ID] INT NOT NULL -- PK,
    [rft_Name] VARCHAR(32) NOT NULL,
    [rtf_Active] BIT NOT NULL
);

CREATE TABLE [zzz_RegiftBackUp] (
    [lia_ID] BIGINT NOT NULL,
    [lst_ID] INT NOT NULL,
    [att_ID] INT NOT NULL,
    [ato_ID] INT NULL,
    [lia_Value] VARCHAR(128) NOT NULL
);

CREATE TABLE [zzz_ReplcatedTables_JO] (
    [tname] NVARCHAR(128) NOT NULL
);

CREATE TABLE [zzz_ResellerBilling] (
    [Captured] DATETIME NOT NULL,
    [HostName] VARCHAR(64) NOT NULL,
    [UserName] VARCHAR(64) NOT NULL,
    [YearMonth] INT NOT NULL,
    [Product] VARCHAR(7) NOT NULL,
    [acc_ID] INT NOT NULL,
    [cusID] INT NULL,
    [Reseller] VARCHAR(64) NOT NULL,
    [Division] VARCHAR(64) NOT NULL,
    [StartDate] DATE NOT NULL,
    [EndDate] DATE NULL,
    [Company] VARCHAR(64) NOT NULL,
    [Campaign] VARCHAR(8000) NOT NULL,
    [Cost] MONEY NULL,
    [Master_ID] BIGINT NOT NULL,
    [isLive] INT NOT NULL,
    [subscription_id] BIGINT NULL,
    [rcd_TargetClicks] INT NULL,
    [rcd_TargetImpressions] INT NULL
);

CREATE TABLE [zzz_resellercompanyBK] (
    [rco_ID] INT NOT NULL,
    [rct_ID] INT NOT NULL,
    [rco_CompanyName] VARCHAR(64) NULL,
    [rco_DisplayName] VARCHAR(64) NULL,
    [rco_Logo] VARCHAR(1024) NOT NULL,
    [rco_Created] DATETIME NOT NULL,
    [rco_CreatedBy] INT NOT NULL,
    [rco_Modified] DATETIME NOT NULL,
    [rco_ModifiedBy] INT NOT NULL,
    [rco_CompanyExpires] DATETIME NOT NULL,
    [rco_UsersExpire] DATETIME NOT NULL,
    [rco_Active] BIT NOT NULL,
    [rco_Phone] VARCHAR(16) NOT NULL,
    [rco_SupportEmail] VARCHAR(96) NULL,
    [rco_Domain] VARCHAR(128) NOT NULL
);

CREATE TABLE [zzz_ResellerExpiringEmails] (
    [ree_ID] INT NOT NULL -- PK,
    [acc_ID] INT NOT NULL,
    [exp_Date] DATETIME NOT NULL,
    [ree_ForAccounts] BIT NOT NULL,
    [ree_Sent] DATETIME NULL
);

CREATE TABLE [zzz_ResellerSecurity] (
    [aso_ID] INT NOT NULL -- PK,
    [AdminOnly] BIT NOT NULL
);

CREATE TABLE [zzz_ResellerToRatchetLogin] (
    [rtrid] INT NOT NULL -- PK,
    [uid] UNIQUEIDENTIFIER NOT NULL,
    [accid] INT NOT NULL,
    [createddate] SMALLDATETIME NOT NULL,
    [expireddate] SMALLDATETIME NOT NULL,
    [active] BIT NOT NULL
);

CREATE TABLE [zzz_RiskWordsByCategory] (
    [rwc_ID] INT NOT NULL -- PK,
    [rwc_Word] VARCHAR(128) NOT NULL,
    [rwc_RiskLevel] SMALLINT NOT NULL,
    [rwc_CategoryPipe] VARCHAR(128) NOT NULL,
    [lastmodified] SMALLDATETIME NOT NULL,
    [lastmodifiedby] INT NOT NULL,
    [active] BIT NOT NULL
);

CREATE TABLE [zzz_rptMarketingNewsletter_Log] (
    [captured] DATETIME NOT NULL,
    [rptdateend] DATE NULL,
    [acc_id] INT NULL,
    [acc_company] VARCHAR(64) NULL,
    [acc_email] VARCHAR(128) NULL,
    [acc_state] VARCHAR(2) NULL,
    [zip_code] VARCHAR(5) NULL,
    [pta_promisedtotal] INT NULL,
    [dis_clicks] INT NULL,
    [dis_impressions] INT NULL,
    [lat_total] INT NULL,
    [ldq_calls] INT NULL,
    [ldq_emails] INT NULL,
    [vdp] INT NULL,
    [serp] INT NULL,
    [perc_compl] FLOAT NULL,
    [rep_ID] INT NULL,
    [rep_Email] VARCHAR(128) NULL,
    [rep_VP_Email] VARCHAR(128) NULL,
    [min_Start_Date] DATE NULL,
    [max_End_Date] DATE NULL,
    [problem] VARCHAR(512) NULL
);

CREATE TABLE [zzz_rptMarketingNewsletter_PL_OD] (
    [acc_ID] INT NULL,
    [acc_Company] VARCHAR(64) NULL,
    [acc_Email_String] VARCHAR(128) NULL,
    [rep_ID] VARCHAR(32) NULL,
    [rep_Email] VARCHAR(128) NULL,
    [rep_VP_Email] VARCHAR(128) NULL,
    [Sold] VARCHAR(32) NULL,
    [hasOverdrive] VARCHAR(32) NULL,
    [Calls] VARCHAR(32) NULL,
    [Emails] VARCHAR(32) NULL,
    [hasPowerListing] VARCHAR(32) NULL,
    [Impressions] VARCHAR(32) NULL,
    [SRP_Clicks] VARCHAR(32) NULL,
    [VDP_Views] VARCHAR(32) NULL,
    [Media] VARCHAR(64) NULL,
    [Start_Date] DATE NULL,
    [End_Date] DATE NULL,
    [LastUpload] DATETIME NULL,
    [Problem] VARCHAR(1024) NULL
);

CREATE TABLE [zzz_SearchQueries] (
    [srchID] INT NOT NULL -- PK,
    [webServer] VARCHAR(10) NOT NULL,
    [remoteIP] VARCHAR(20) NOT NULL,
    [remoteBrowser] VARCHAR(200) NOT NULL,
    [webQuery] VARCHAR(400) NOT NULL,
    [viviQuery] VARCHAR(400) NOT NULL,
    [viviQueryTime] FLOAT NOT NULL,
    [captured] SMALLDATETIME NOT NULL
);

CREATE TABLE [zzz_SearchQueries_v2] (
    [srchID] INT NOT NULL -- PK,
    [webServer] VARCHAR(10) NOT NULL,
    [remoteIP] VARCHAR(20) NOT NULL,
    [remoteBrowser] VARCHAR(200) NOT NULL,
    [webQuery] VARCHAR(400) NOT NULL,
    [viviQuery] VARCHAR(1000) NOT NULL,
    [viviQueryTime] FLOAT NOT NULL,
    [captured] SMALLDATETIME NOT NULL
);

CREATE TABLE [zzz_SearchQueries_v3] (
    [randomSeed] BIGINT NOT NULL,
    [startControllerTime] DATETIME NOT NULL,
    [remoteIP] VARCHAR(20) NOT NULL,
    [webQuery] VARCHAR(500) NOT NULL,
    [startQueryTransTime] DATETIME NOT NULL,
    [queryTransTimeMS] FLOAT NOT NULL,
    [startSearchTime] DATETIME NOT NULL,
    [searchTimeMS] FLOAT NOT NULL,
    [startResponseTransTime] DATETIME NOT NULL,
    [responseTransTimeMS] FLOAT NOT NULL,
    [startSearchManagerTime] DATETIME NULL,
    [searchManagerTimeMS] FLOAT NULL,
    [controllerToViewMS] FLOAT NULL
);

CREATE TABLE [zzz_SearchQueriesLogs] (
    [srchID] INT NOT NULL -- PK,
    [server] VARCHAR(10) NOT NULL,
    [remoteIP] VARCHAR(20) NOT NULL,
    [remoteClient] VARCHAR(200) NOT NULL,
    [queryPosted] VARCHAR(500) NOT NULL,
    [fullURL] VARCHAR(500) NOT NULL,
    [searchResultsErrorMessage] VARCHAR(500) NOT NULL,
    [primaryResponseTime] FLOAT NOT NULL,
    [backfillSource] VARCHAR(50) NOT NULL,
    [backfillResponseTime] FLOAT NOT NULL,
    [createdTime] DATETIME NOT NULL
);

CREATE TABLE [zzz_SF_Subscriptions] (
    [ID] VARCHAR(256) NULL,
    [OWNERID] VARCHAR(256) NULL,
    [NAME] VARCHAR(256) NULL,
    [CREATEDDATE] VARCHAR(256) NULL,
    [LASTMODIFIEDDATE] VARCHAR(256) NULL,
    [SYSTEMMODSTAMP] VARCHAR(256) NULL,
    [ZUORA_ACCOUNT] VARCHAR(256) NULL,
    [ZUORA_AUTORENEW] VARCHAR(256) NULL,
    [ZUORAUSTOMERACCOUNT] VARCHAR(256) NULL,
    [ZUORA_EXTERNAL_ID] VARCHAR(256) NULL,
    [ZUORA_INITIALTERM] VARCHAR(256) NULL,
    [ZUORA_NEXTCHARGEDATE] VARCHAR(256) NULL,
    [ZUORA_NEXTRENEWALDATE] VARCHAR(256) NULL,
    [ZUORA_ORIGINALCREATEDDATE] VARCHAR(256) NULL,
    [ZUORA_SERVICEACTIVATIONDATE] VARCHAR(256) NULL,
    [ZUORA_STATUS] VARCHAR(256) NULL,
    [ZUORA_SUBSCRIPTIONENDDATE] VARCHAR(256) NULL,
    [ZUORA_SUBSCRIPTIONSTARTDATE] VARCHAR(256) NULL,
    [ZUORA_TERMENDDATE] VARCHAR(256) NULL,
    [ZUORA_TERMSETTINGTYPE] VARCHAR(256) NULL,
    [ZUORA_TERMSTARTDATE] VARCHAR(256) NULL,
    [ZUORA_VERSION] VARCHAR(256) NULL,
    [ZUORA_ZUORA_ID] VARCHAR(256) NULL,
    [ZUORAANCELLEDDATE] VARCHAR(256) NULL,
    [RATE_PLANS] VARCHAR(4000) NULL,
    [ZUORA_ORIGINALID] VARCHAR(256) NULL,
    [ZUORA_PREVIOUSSUBSCRIPTIONID] VARCHAR(256) NULL,
    [ACCOUNT_18_DIGIT_ID] VARCHAR(256) NULL,
    [RATE_PLAN_NORMAL_TEXT] VARCHAR(4000) NULL,
    [SUBSCRIPTION_PRODUCT_TREE] VARCHAR(4000) NULL
);

CREATE TABLE [zzz_SilverPop_Buyer_Account] (
    [BuyerID] INT NOT NULL -- PK,
    [BuyerEmail] VARCHAR(256) NOT NULL,
    [BuyerFirstName] VARCHAR(64) NOT NULL,
    [BuyerLastName] VARCHAR(64) NOT NULL,
    [BuyerZip] VARCHAR(5) NOT NULL,
    [acc_ID] VARCHAR(32) NULL,
    [BuyerCreated] VARCHAR(32) NOT NULL,
    [NewLetterOptIN] BIT NOT NULL,
    [AnnounceOptIN] BIT NOT NULL,
    [PromosOptIN] BIT NOT NULL
);

CREATE TABLE [zzz_silverpop_buyer_account_restore] (
    [BuyerID] INT NOT NULL,
    [BuyerEmail] VARCHAR(256) NOT NULL,
    [BuyerFirstName] VARCHAR(64) NOT NULL,
    [BuyerLastName] VARCHAR(64) NOT NULL,
    [BuyerZip] VARCHAR(5) NOT NULL,
    [acc_ID] VARCHAR(32) NULL,
    [BuyerCreated] VARCHAR(32) NOT NULL,
    [NewLetterOptIN] BIT NOT NULL,
    [AnnounceOptIN] BIT NOT NULL,
    [PromosOptIN] BIT NOT NULL
);

CREATE TABLE [zzz_SilverPop_Buyer_Leads] (
    [BuyerLeadID] INT NOT NULL -- PK,
    [BuyerID] INT NOT NULL,
    [BuyerLeadCreated] VARCHAR(32) NOT NULL,
    [SellerListingID] INT NOT NULL
);

CREATE TABLE [zzz_SilverPop_Seller_Listing] (
    [SellerListingID] INT NOT NULL -- PK,
    [SellerListingZip] VARCHAR(5) NOT NULL,
    [SellerListingPrice] INT NOT NULL,
    [SellerListingSubClass] INT NOT NULL,
    [SellerListingYear] VARCHAR(128) NULL,
    [SellerListingMake] VARCHAR(128) NULL,
    [SellerListingModel] VARCHAR(128) NULL,
    [SellerListingSubModel] VARCHAR(128) NULL,
    [SellerListingAdded] VARCHAR(32) NOT NULL
);

CREATE TABLE [zzz_SilverPop_TJS_Account] (
    [tjs_id] INT NOT NULL -- PK,
    [acc_id] INT NULL,
    [acc_created] DATETIME NOT NULL,
    [acc_modified] DATETIME NOT NULL,
    [src_id] INT NOT NULL,
    [arl_id] INT NOT NULL,
    [Email] VARCHAR(128) NULL,
    [FName] VARCHAR(128) NULL,
    [LName] VARCHAR(128) NULL,
    [Address] VARCHAR(128) NULL,
    [City] VARCHAR(128) NULL,
    [State] VARCHAR(128) NULL,
    [Zip] VARCHAR(128) NULL,
    [DriverType] VARCHAR(128) NULL,
    [OTRExp] VARCHAR(128) NULL,
    [NewLetterOptIN] BIT NULL,
    [AnnounceOptIN] BIT NULL,
    [PromosOptIN] BIT NULL,
    [VRStatus] VARCHAR(128) NULL
);

CREATE TABLE [zzz_solar_autos] (
    [src_id] INT NULL,
    [lacc_id] INT NULL,
    [llst_id] INT NULL,
    [cls_id] INT NULL,
    [cls_name] VARCHAR(64) NULL,
    [scl_id] INT NULL,
    [scl_name] VARCHAR(64) NULL,
    [clt_id] INT NULL,
    [clt_name] VARCHAR(32) NULL,
    [llst_phone] VARCHAR(16) NULL,
    [llst_extension] VARCHAR(10) NULL,
    [llst_cost] MONEY NULL,
    [llst_price] MONEY NULL,
    [lpt_id] INT NULL,
    [lpt_name] VARCHAR(128) NULL,
    [llst_issale] BIT NULL,
    [llst_headline] VARCHAR(64) NULL,
    [llst_title] VARCHAR(128) NULL,
    [llst_onlinetext] VARCHAR(8000) NULL,
    [zip_code] VARCHAR(5) NULL,
    [stt_id] VARCHAR(2) NULL,
    [zip_city] VARCHAR(32) NULL,
    [lst_imageurl] VARCHAR(8000) NULL,
    [lst_detailsurl] VARCHAR(160) NULL,
    [fduid] INT NULL,
    [lst_allimages] VARCHAR(8000) NULL,
    [lst_alloptions] VARCHAR(8000) NULL,
    [lst_allhighlights] VARCHAR(8000) NULL,
    [lacc_isbusiness] BIT NULL,
    [lacc_displayname] VARCHAR(64) NULL,
    [lacc_email] VARCHAR(128) NULL,
    [_morefromseller] BIT NULL,
    [llst_created] DATETIME NULL,
    [llst_modified] DATETIME NULL,
    [lst_condition] VARCHAR(128) NULL,
    [lst_certified] VARCHAR(128) NULL
);

CREATE TABLE [zzz_SolrCheck] (
    [slrchk_ID] BIGINT NOT NULL -- PK,
    [cls_ID] INT NULL,
    [post_URL] NVARCHAR(4000) NULL,
    [post_Response] TEXT NULL,
    [Published] DATETIME NULL,
    [LastUpload] DATETIME NULL,
    [ServerName] VARCHAR(32) NULL
);

CREATE TABLE [zzz_Spectrum_RollOver_Data] (
    [ID] INT NOT NULL,
    [acc_ID] BIGINT NULL,
    [subscription_id] BIGINT NULL,
    [ratchet_id] BIGINT NULL,
    [prd_type] NVARCHAR(510) NULL,
    [prd_package] NVARCHAR(510) NULL,
    [provider] NVARCHAR(510) NULL,
    [ffExcludeRAN] BIT NULL,
    [ffExcludeRCY] BIT NULL,
    [Region] VARCHAR(64) NULL,
    [Advertiser] NVARCHAR(1024) NULL,
    [Billing_Number] VARCHAR(256) NULL,
    [Campaign_Start_Date] DATE NULL,
    [Campaign_End_Date] DATE NULL,
    [Product] VARCHAR(15) NOT NULL,
    [Actual_Live_Date] DATE NULL,
    [Campaign_Name] NVARCHAR(256) NULL,
    [Days_Completed] NUMERIC(25,3) NULL,
    [Campaign_Status] NVARCHAR(64) NULL,
    [CTR] NUMERIC(25,3) NULL,
    [Percent_Delivered] NUMERIC(25,3) NULL,
    [Campaign_Scheduled_Impressions] INT NULL,
    [Impressions_To_Date] INT NULL,
    [Clicks_To_Date] INT NULL,
    [Rate] MONEY NULL,
    [Emails] INT NULL,
    [Phone_Calls] INT NULL,
    [Profile_Views] INT NULL
);

CREATE TABLE [zzz_SpectrumLocations] (
    [sl_StoreID] INT NULL,
    [sl_Address] VARCHAR(256) NULL,
    [sl_Address2] VARCHAR(256) NULL,
    [sl_City] VARCHAR(256) NULL,
    [sl_State] VARCHAR(2) NULL,
    [sl_Zip] VARCHAR(5) NULL,
    [sl_Phone] VARCHAR(16) NULL,
    [so_Email] VARCHAR(256) NULL,
    [sl_TFN] VARCHAR(16) NULL,
    [order_id] INT NULL,
    [order_item_id] INT NULL,
    [subscription_id] BIGINT NULL
);

CREATE TABLE [zzz_SPFIND] (
    [RowNumber] INT NOT NULL -- PK,
    [EventClass] INT NULL,
    [TextData] NTEXT NULL,
    [DatabaseID] INT NULL,
    [DatabaseName] NVARCHAR(128) NULL,
    [ObjectID] INT NULL,
    [ObjectName] NVARCHAR(128) NULL,
    [ServerName] NVARCHAR(128) NULL,
    [BinaryData] IMAGE NULL,
    [SPID] INT NULL,
    [StartTime] DATETIME NULL
);

CREATE TABLE [zzz_SponsoredGeoDistance] (
    [sg_ID] INT NOT NULL -- PK,
    [gdID] INT NOT NULL,
    [sg_Desc] VARCHAR(100) NOT NULL
);

CREATE TABLE [zzz_SponsoredImage] (
    [spi_ID] INT NOT NULL -- PK,
    [spi_DefaultImage] VARCHAR(100) NOT NULL,
    [spi_CategoryName] VARCHAR(100) NOT NULL,
    [spi_URL] VARCHAR(100) NOT NULL,
    [spi_Category] VARCHAR(100) NOT NULL
);

CREATE TABLE [zzz_SponsoredLog] (
    [spl_ID] INT NOT NULL -- PK,
    [sp_ID] INT NOT NULL,
    [lgt_ID] INT NOT NULL,
    [spl_Month] INT NOT NULL,
    [spl_Day] INT NOT NULL,
    [spl_Hour] INT NOT NULL
);

CREATE TABLE [zzz_SponsoredSearch] (
    [sp_ID] INT NOT NULL -- PK,
    [sg_ID] INT NOT NULL,
    [sp_Image] VARCHAR(512) NULL,
    [spi_ID] INT NOT NULL,
    [sp_Text] VARCHAR(100) NOT NULL,
    [sp_URL] VARCHAR(250) NOT NULL,
    [sp_Target] VARCHAR(10) NOT NULL,
    [sp_Month] INT NOT NULL,
    [sp_Year] INT NOT NULL,
    [sp_Active] BIT NOT NULL
);

CREATE TABLE [zzz_SponsoredZipCode] (
    [szc_ID] INT NOT NULL -- PK,
    [sg_ID] INT NOT NULL,
    [zip_Code] VARCHAR(5) NOT NULL
);

CREATE TABLE [zzz_start_of_performance] (
    [source] VARCHAR(32) NULL,
    [acc_id] BIGINT NULL,
    [ratchet_id] BIGINT NULL,
    [min_date] DATE NULL
);

CREATE TABLE [zzz_Static_ZipCode2PubID] (
    [zip_code] VARCHAR(5) NOT NULL,
    [pub_id] INT NOT NULL,
    [pub_name] VARCHAR(64) NOT NULL
);

CREATE TABLE [zzz_strikezone_numbers] (
    [szn_id] BIGINT NOT NULL,
    [szn_number] VARCHAR(16) NULL,
    [szn_isvalid] BIT NULL,
    [szn_type] VARCHAR(50) NULL,
    [szn_callername] VARCHAR(128) NULL,
    [szn_callerlocation] VARCHAR(128) NULL,
    [szn_created] DATE NULL
);

CREATE TABLE [zzz_StrikeZoneLog] (
    [ldqid] INT NOT NULL,
    [status] VARCHAR(20) NOT NULL,
    [sid] VARCHAR(100) NOT NULL,
    [timestamp] DATETIME NULL
);

CREATE TABLE [zzz_StrikeZoneQueue] (
    [acc_id] BIGINT NULL,
    [acc_company] VARCHAR(128) NULL,
    [adez_phone] VARCHAR(16) NULL,
    [strikezone_phone] VARCHAR(16) NOT NULL,
    [rep_email] VARCHAR(128) NULL,
    [sc_aso_id] BIGINT NULL,
    [Sales_Channel] VARCHAR(128) NULL,
    [ldq_id] INT NOT NULL,
    [ldq_created] DATETIME NOT NULL,
    [esr_id] INT NULL,
    [esr_name] VARCHAR(50) NULL,
    [ldq_FromPhone] VARCHAR(16) NOT NULL,
    [ldq_FromMail] VARCHAR(256) NULL,
    [ldq_FromName] VARCHAR(50) NULL,
    [zip_Code] VARCHAR(5) NOT NULL,
    [zip_TZ] VARCHAR(8) NULL,
    [zip_UTC] INT NULL,
    [lst_title] VARCHAR(128) NULL,
    [szn_status] VARCHAR(16) NULL,
    [szn_retries] INT NOT NULL,
    [szn_local] VARCHAR(16) NOT NULL,
    [szn_modified] DATETIME NULL,
    [szn_type] VARCHAR(10) NULL
);

CREATE TABLE [zzz_SubscriptionSubmit] (
    [subscriptionId] INT NOT NULL,
    [notes] VARCHAR(1000) NOT NULL,
    [submitted] DATETIME NULL,
    [success] BIT NULL
);

CREATE TABLE [zzz_synonyms] (
    [expression] VARCHAR(100) NOT NULL,
    [synonym1] VARCHAR(100) NULL,
    [synonym2] VARCHAR(100) NULL,
    [synonym3] VARCHAR(100) NULL,
    [synonym4] VARCHAR(100) NULL,
    [synonym5] VARCHAR(100) NULL,
    [synonym6] VARCHAR(100) NULL
);

CREATE TABLE [zzz_temp_adez_Business] (
    [acc_id] INT NULL
);

CREATE TABLE [zzz_Temp_PetFinderPets] (
    [pfp_ID] VARCHAR(16) NOT NULL,
    [pfc_ID] INT NOT NULL,
    [pfs_ID] VARCHAR(16) NOT NULL,
    [pfp_ShelterPetID] VARCHAR(16) NULL,
    [pfp_name] VARCHAR(64) NULL,
    [pfp_animal] VARCHAR(16) NULL,
    [pfp_breed] VARCHAR(256) NULL,
    [pfp_mix] VARCHAR(16) NULL,
    [pfp_age] VARCHAR(16) NULL,
    [pfp_sex] VARCHAR(16) NULL,
    [pfp_size] VARCHAR(16) NULL,
    [pfp_highlights] VARCHAR(1024) NULL,
    [pfp_description] VARCHAR(MAX) NULL,
    [pfp_images] VARCHAR(MAX) NULL
);

CREATE TABLE [zzz_Temp_PetFinderShelters] (
    [pfs_ID] VARCHAR(16) NOT NULL,
    [pfs_Name] VARCHAR(64) NULL,
    [pfs_Address1] VARCHAR(64) NULL,
    [pfs_Address2] VARCHAR(64) NULL,
    [pfs_City] VARCHAR(64) NULL,
    [pfs_State] VARCHAR(2) NULL,
    [pfs_Zip] VARCHAR(5) NULL,
    [pfs_Phone] VARCHAR(16) NULL,
    [pfs_Email] VARCHAR(128) NULL
);

CREATE TABLE [zzz_tempcitygridcats] (
    [toplevelcat] VARCHAR(500) NULL,
    [ratecard] VARCHAR(500) NULL,
    [tagid] VARCHAR(24) NULL,
    [primarycat] VARCHAR(500) NULL,
    [catappearence] VARCHAR(50) NULL
);

CREATE TABLE [zzz_TempCurrentADAccounts] (
    [ADLogin] VARCHAR(128) NULL,
    [ADName] VARCHAR(128) NULL,
    [ADEmail] VARCHAR(8000) NULL
);

CREATE TABLE [zzz_tempproofingsummary] (
    [lst_ID] INT NOT NULL,
    [acc_Login] VARCHAR(128) NOT NULL,
    [lsl_Modified] DATETIME NOT NULL,
    [timespan] INT NOT NULL
);

CREATE TABLE [zzz_TempVastPhoneData] (
    [caller_number] VARCHAR(19) NULL,
    [caller_name] VARCHAR(23) NULL,
    [call_id] VARCHAR(20) NULL,
    [inbound_no] VARCHAR(32) NULL,
    [inbound_ext] VARCHAR(32) NULL,
    [keyword] VARCHAR(32) NULL,
    [forward_no] VARCHAR(14) NULL,
    [custom_id] VARCHAR(128) NULL,
    [account_id] VARCHAR(20) NULL,
    [group_id] VARCHAR(20) NULL,
    [campaign_id] VARCHAR(20) NULL,
    [a_name] VARCHAR(128) NULL,
    [g_name] VARCHAR(12) NULL,
    [c_name] VARCHAR(65) NULL,
    [call_s] VARCHAR(128) NULL,
    [duration] VARCHAR(24) NULL,
    [answer_offset] VARCHAR(24) NULL,
    [call_status] VARCHAR(128) NULL,
    [dna_class] VARCHAR(32) NULL,
    [disposition] VARCHAR(32) NULL,
    [rating] VARCHAR(32) NULL,
    [listenedto] VARCHAR(5) NULL,
    [ass_user] VARCHAR(32) NULL,
    [revenue] VARCHAR(32) NULL,
    [custom1] VARCHAR(32) NULL,
    [custom2] VARCHAR(32) NULL,
    [custom3] VARCHAR(32) NULL,
    [custom4] VARCHAR(32) NULL,
    [custom5] VARCHAR(32) NULL,
    [custom6] VARCHAR(32) NULL,
    [custom7] VARCHAR(32) NULL,
    [custom8] VARCHAR(32) NULL,
    [custom9] VARCHAR(32) NULL,
    [custom10] VARCHAR(32) NULL,
    [custom11] VARCHAR(32) NULL,
    [custom12] VARCHAR(32) NULL,
    [custom13] VARCHAR(32) NULL,
    [custom14] VARCHAR(32) NULL,
    [custom15] VARCHAR(32) NULL,
    [custom16] VARCHAR(32) NULL,
    [custom17] VARCHAR(32) NULL,
    [custom18] VARCHAR(32) NULL,
    [custom19] VARCHAR(32) NULL,
    [custom20] VARCHAR(32) NULL,
    [numlookup_name] VARCHAR(32) NULL,
    [numlookup_address] VARCHAR(32) NULL,
    [numlookup_city] VARCHAR(32) NULL,
    [numlookup_state] VARCHAR(32) NULL,
    [numlookup_zip] VARCHAR(32) NULL,
    [note] VARCHAR(32) NULL
);

CREATE TABLE [zzz_The3Rep2TMPi_Accounts] (
    [oldpubid] INT NOT NULL,
    [oldasoid] INT NOT NULL,
    [oldcusid] INT NOT NULL,
    [cuscompany] VARCHAR(64) NULL,
    [cusphone] VARCHAR(16) NOT NULL,
    [newpubid] INT NOT NULL,
    [newasoid] INT NOT NULL,
    [newcusid] INT NULL,
    [acc_ID] INT NOT NULL,
    [acc_Company] VARCHAR(64) NOT NULL,
    [acc_Phone] VARCHAR(24) NOT NULL,
    [acc_State] VARCHAR(2) NOT NULL,
    [zip_Code] VARCHAR(5) NOT NULL,
    [acc_email_XML] VARCHAR(128) NOT NULL,
    [acc_email_String] VARCHAR(128) NOT NULL,
    [aso_ID] INT NULL,
    [aso_Name] VARCHAR(128) NOT NULL,
    [pubid] INT NULL,
    [cusid] INT NULL,
    [rep_ID] INT NOT NULL,
    [rep_Login] VARCHAR(128) NULL,
    [rep_rco_id] INT NOT NULL,
    [rep_arl_ID] INT NOT NULL,
    [rep_reseler_Company] VARCHAR(64) NULL,
    [rep_reseler_Division] VARCHAR(64) NULL,
    [rep_reseller_Admin] INT NOT NULL,
    [prd_ID] INT NOT NULL,
    [Source] VARCHAR(64) NULL,
    [rco_ServiceList] VARCHAR(128) NULL,
    [Channel] VARCHAR(128) NOT NULL,
    [Division] VARCHAR(64) NULL,
    [isLive] BIT NOT NULL,
    [DateStarted_Formatted] DATE NULL,
    [DateEnded_Formatted] DATE NULL,
    [sta_ID] INT NOT NULL,
    [Status] VARCHAR(8) NOT NULL
);

CREATE TABLE [zzz_TimTest] (
    [id] INT NOT NULL,
    [cmp_id] INT NULL,
    [sf_id] BIGINT NULL,
    [showLeads] BIT NULL,
    [Product] VARCHAR(64) NULL,
    [Reseller] VARCHAR(64) NULL,
    [acc_ID] INT NULL,
    [Company] VARCHAR(64) NULL,
    [_Master_ID] BIGINT NULL,
    [Start_Date] DATE NULL,
    [End_Date] DATE NULL,
    [Campaign_Months] INT NULL,
    [Campaign_Status] VARCHAR(32) NULL,
    [Campaign_Name] VARCHAR(128) NULL,
    [prd_id] INT NULL,
    [Campaign_Type] VARCHAR(32) NULL,
    [Monthly_Target_Impressions] BIGINT NULL,
    [Monthly_Target_Clicks] BIGINT NULL,
    [Campaign_Target_Impressions] BIGINT NULL,
    [Campaign_Target_Clicks] BIGINT NULL,
    [provider_id] VARCHAR(128) NULL
);

CREATE TABLE [zzz_timvehicledata] (
    [acc_id] INT NULL,
    [src_ID] INT NOT NULL,
    [fdUID] INT NULL,
    [lst_id] INT NOT NULL,
    [zip_Code] VARCHAR(5) NOT NULL,
    [lst_Price] MONEY NOT NULL,
    [lst_Phone] VARCHAR(16) NOT NULL,
    [lss_ID] INT NOT NULL,
    [lst_Created] DATETIME NOT NULL,
    [lst_Modified] DATETIME NOT NULL,
    [lst_LastUpload] DATETIME NULL,
    [imgCount] INT NULL,
    [image_one] VARCHAR(MAX) NULL,
    [veh_vin] VARCHAR(32) NULL,
    [veh_stock] VARCHAR(32) NULL,
    [veh_mileage] VARCHAR(32) NULL,
    [veh_year] VARCHAR(4) NULL,
    [veh_make] VARCHAR(64) NULL,
    [veh_model] VARCHAR(64) NULL,
    [veh_trim] VARCHAR(128) NULL,
    [veh_bodytype] VARCHAR(64) NULL,
    [veh_status] VARCHAR(32) NULL,
    [Vehicle_Count] INT NULL,
    [lst_Mileage_Score] INT NULL,
    [lst_Price_Score] INT NULL,
    [veh_Score] INT NOT NULL,
    [Hash1] VARBINARY(8000) NULL
);

CREATE TABLE [zzz_TMPAttribution] (
    [acc_ID] INT NULL,
    [lst_ID] INT NULL,
    [lst_Title] VARCHAR(128) NULL,
    [lst_Price] MONEY NULL,
    [lst_Created] DATE NULL,
    [lst_LastUpload] DATE NULL,
    [Leads] INT NULL,
    [Network_VDP] INT NULL,
    [PowerListing_VDP] INT NULL,
    [Calls] INT NULL,
    [Captured] DATETIME NULL
);

CREATE TABLE [zzz_TurboProgram] (
    [trb_ID] INT NOT NULL -- PK,
    [trb_Name] VARCHAR(50) NOT NULL,
    [trb_Dealer] VARCHAR(100) NOT NULL,
    [trb_Phone] VARCHAR(20) NOT NULL,
    [trb_Email] VARCHAR(100) NOT NULL,
    [trb_Message] VARCHAR(500) NOT NULL,
    [trb_IPAddress] VARCHAR(20) NOT NULL,
    [trb_Viewed] BIT NOT NULL
);

CREATE TABLE [zzz_URLChange] (
    [urlc_ID] INT NOT NULL -- PK,
    [urlc_OldString] VARCHAR(256) NOT NULL,
    [urlc_NewString] VARCHAR(256) NOT NULL,
    [urlc_OldURL] VARCHAR(256) NOT NULL,
    [urlc_NewURL] VARCHAR(256) NOT NULL
);

CREATE TABLE [zzz_URLEncodeNumbers] (
    [Num] INT NOT NULL -- PK
);

CREATE TABLE [zzz_URLRedirect] (
    [urlr_ID] INT NOT NULL -- PK,
    [urlr_SourceWildCard] BIT NOT NULL,
    [urlr_SourceDomain] VARCHAR(128) NOT NULL,
    [urlr_SourcePath] VARCHAR(512) NOT NULL,
    [urlr_DestinationDomain] VARCHAR(128) NOT NULL,
    [urlr_DestinationPath] VARCHAR(512) NOT NULL,
    [urlr_Priority] INT NOT NULL,
    [urlr_RedirectType] INT NOT NULL,
    [urlr_Active] BIT NOT NULL
);

CREATE TABLE [zzz_UserAgents] (
    [uaID] INT NOT NULL -- PK,
    [uaIP] VARCHAR(20) NOT NULL,
    [uaBot] VARCHAR(20) NOT NULL,
    [uaWhiteList] BIT NOT NULL,
    [uaBlackList] BIT NOT NULL
);

CREATE TABLE [zzz_UserAlert] (
    [ua_id] INT NOT NULL -- PK,
    [ua_message] TEXT NULL,
    [ua_level] VARCHAR(24) NOT NULL,
    [ua_type] INT NOT NULL,
    [ua_created] DATETIME NOT NULL,
    [ua_last_updated] DATETIME NOT NULL,
    [ua_created_by] INT NOT NULL,
    [ua_last_modified_by] INT NOT NULL,
    [ua_active] BIT NOT NULL
);

CREATE TABLE [zzz_VastExploratory] (
    [esf_ID] BIGINT NOT NULL,
    [esr_ID] INT NOT NULL,
    [esr_Name] VARCHAR(50) NOT NULL,
    [ldq_ID] INT NOT NULL,
    [ldq_Created] DATETIME NOT NULL,
    [fdUID] INT NULL,
    [acc_ID] INT NOT NULL,
    [lst_ID] INT NULL,
    [RejectReasons] VARCHAR(1024) NOT NULL,
    [LeadCost] MONEY NOT NULL,
    [Budget] MONEY NOT NULL,
    [rptYearMonth] INT NOT NULL,
    [RunningBalance] MONEY NOT NULL,
    [ActualLeadCost] MONEY NOT NULL,
    [ActualBudget] MONEY NOT NULL,
    [veh_vin] VARCHAR(64) NULL,
    [ldq_phone] VARCHAR(64) NULL,
    [ldq_email] VARCHAR(64) NULL,
    [NumbersUsed] VARCHAR(64) NULL,
    [EmailDomain] VARCHAR(64) NULL,
    [BothPhoneEmailInvalid] BIT NULL,
    [EmailUsedWithVin] BIT NULL,
    [PhoneUsedWithVin] BIT NULL,
    [EmailOrPhoneUsedWithDealer] BIT NULL,
    [ldq_message] VARCHAR(1024) NULL
);

CREATE TABLE [zzz_vehiclelistings_missing] (
    [veh_id] BIGINT NULL,
    [job_id] INT NULL,
    [veh_url] NVARCHAR(1024) NOT NULL,
    [veh_modified] DATETIME2 NOT NULL,
    [veh_vin] NVARCHAR(256) NOT NULL,
    [veh_stock] NVARCHAR(256) NULL,
    [veh_bodytype] NVARCHAR(256) NULL,
    [veh_price] NVARCHAR(256) NULL,
    [veh_priceType] NVARCHAR(256) NULL,
    [veh_year] NVARCHAR(256) NULL,
    [veh_make] NVARCHAR(256) NULL,
    [veh_model] NVARCHAR(256) NULL,
    [veh_trim] NVARCHAR(256) NULL,
    [veh_title] NVARCHAR(256) NULL,
    [veh_status] NVARCHAR(256) NULL,
    [veh_mileage] NVARCHAR(256) NULL,
    [veh_cylinders] NVARCHAR(256) NULL,
    [veh_displacement] NVARCHAR(256) NULL,
    [veh_induction] NVARCHAR(256) NULL,
    [veh_transmission] NVARCHAR(256) NULL,
    [veh_drivetrain] NVARCHAR(256) NULL,
    [veh_exteriorcolor] NVARCHAR(256) NULL,
    [veh_interiorcolor] NVARCHAR(256) NULL,
    [veh_condition] NVARCHAR(256) NULL,
    [veh_doors] NVARCHAR(256) NULL,
    [veh_fuelcity] NVARCHAR(256) NULL,
    [veh_fuelhighway] NVARCHAR(256) NULL,
    [veh_fuelcombined] NVARCHAR(256) NULL,
    [veh_fueltype] NVARCHAR(45) NULL,
    [veh_carfax] NVARCHAR(256) NULL,
    [veh_comments] NTEXT NULL,
    [veh_images] NTEXT NULL
);

CREATE TABLE [zzz_VerticalResponseMasterList] (
    [email_address] NVARCHAR(512) NULL,
    [optin_status] NVARCHAR(512) NULL
);

CREATE TABLE [zzz_VivisimoChange] (
    [vic_ID] INT NOT NULL -- PK,
    [vic_Search] VARCHAR(512) NULL,
    [vic_Replace] VARCHAR(128) NOT NULL
);

CREATE TABLE [zzz_Voter] (
    [vot_ID] INT NOT NULL -- PK,
    [vtr_ID] INT NOT NULL,
    [llst_ID] INT NOT NULL,
    [vot_Value] INT NOT NULL,
    [vot_Time] SMALLDATETIME NOT NULL,
    [vot_IPAddress] VARCHAR(20) NOT NULL
);

CREATE TABLE [zzz_VoterType] (
    [vtr_ID] INT NOT NULL -- PK,
    [vtr_Description] VARCHAR(100) NOT NULL,
    [vtr_URL] VARCHAR(150) NOT NULL
);

CREATE TABLE [zzz_WhosCallingAccount] (
    [wca_ID] INT NOT NULL,
    [acc_ID] INT NULL,
    [wc_ServiceNumber] VARCHAR(16) NULL,
    [wca_Status] VARCHAR(16) NULL,
    [lst_ID] INT NULL,
    [wca_Source] VARCHAR(32) NULL
);

CREATE TABLE [zzz_WhosCallingCustomerIDs] (
    [wc_CustomerID] INT NOT NULL -- PK,
    [wc_CustomerName] VARCHAR(256) NOT NULL,
    [wc_Active] BIT NULL
);

CREATE TABLE [zzz_WhosCallingRuns] (
    [wcr_ID] INT NOT NULL -- PK,
    [wcr_Start] DATETIME NOT NULL,
    [wcr_End] DATETIME NULL
);

CREATE TABLE [zzz_WhosCalllingMasterCampaign] (
    [wc_ID] INT NOT NULL -- PK,
    [wc_CampaignName] VARCHAR(150) NOT NULL,
    [wc_ServiceNumber] VARCHAR(50) NOT NULL,
    [wc_CampaignID] INT NOT NULL,
    [wc_ExternalID] VARCHAR(150) NOT NULL,
    [wc_Redirect] VARCHAR(50) NOT NULL,
    [wc_IsWhisper] BIT NOT NULL,
    [wc_WhisperID] INT NOT NULL,
    [wc_WhisperName] VARCHAR(150) NOT NULL,
    [wc_IsGreetingSet] BIT NOT NULL,
    [wc_GreetingID] INT NOT NULL,
    [wc_GreetingName] VARCHAR(150) NOT NULL,
    [wc_Status] VARCHAR(50) NOT NULL,
    [wc_CampaignGroups] VARCHAR(255) NOT NULL,
    [wc_CustomerID] INT NOT NULL
);

CREATE TABLE [zzz_x] (
    [_SrcID] INT NOT NULL,
    [_AccID] INT NOT NULL,
    [_FdUID] INT NULL,
    [_Name] VARCHAR(64) NOT NULL,
    [_Address] VARCHAR(64) NOT NULL,
    [_City] VARCHAR(32) NOT NULL,
    [_State] VARCHAR(2) NOT NULL,
    [_Zip] VARCHAR(5) NOT NULL,
    [_Email_String] VARCHAR(128) NOT NULL,
    [_Email_XML] VARCHAR(128) NOT NULL,
    [_Phone] VARCHAR(16) NOT NULL,
    [_URL] VARCHAR(512) NULL,
    [_ImageURL] VARCHAR(512) NOT NULL,
    [_DataSource] VARCHAR(32) NOT NULL,
    [acc_Hash] VARBINARY(8000) NULL
);
