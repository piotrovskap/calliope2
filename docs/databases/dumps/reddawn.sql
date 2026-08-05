-- Reddawn Database — DDL Schema Dump
-- Source: SQL Server 20.51.108.231
-- Generated: 2026-06-11
-- Schema-only; no data. Re-extract to refresh.

CREATE TABLE [BKUPHistory] (
    [hstID] INT NOT NULL -- PK,
    [dbID] INT NOT NULL,
    [stpID] INT NOT NULL,
    [hstStart] SMALLDATETIME NOT NULL,
    [hstEnd] SMALLDATETIME NOT NULL,
    [hstBAKFileSize] BIGINT NULL,
    [hstZIPFileSize] BIGINT NULL
);

CREATE TABLE [BKUPLog] (
    [bulID] INT NOT NULL -- PK,
    [stpID] INT NOT NULL,
    [bulStart] DATETIME NOT NULL
);

CREATE TABLE [BKUPSettings] (
    [dbID] INT NOT NULL -- PK,
    [dbName] NVARCHAR(32) NOT NULL,
    [dbBKUPKeep] SMALLINT NOT NULL,
    [dbBKUPPath] NVARCHAR(256) NOT NULL,
    [dbBKFTPServer] NVARCHAR(32) NOT NULL,
    [dbBKUserName] NVARCHAR(32) NOT NULL,
    [dbBKPassword] NVARCHAR(32) NOT NULL
);

CREATE TABLE [BKUPSteps] (
    [stpID] INT NOT NULL -- PK,
    [stpName] VARCHAR(32) NOT NULL,
    [stpOrder] INT NOT NULL
);

CREATE TABLE [CoreLog] (
    [coreID] INT NOT NULL -- PK,
    [coreCMD] NVARCHAR(4000) NOT NULL,
    [coreDate] DATETIME NOT NULL
);

CREATE TABLE [Crawler_Classification] (
    [domain] VARCHAR(256) NOT NULL -- PK,
    [classification] VARCHAR(10) NOT NULL -- PK
);

CREATE TABLE [Crawler_Cleanup_Log] (
    [timestamp] DATETIME NOT NULL,
    [cil_id] INT NOT NULL,
    [state] VARCHAR(10) NOT NULL
);

CREATE TABLE [Crawler_Container_Issues] (
    [id] INT NOT NULL -- PK,
    [container_name] VARCHAR(100) NOT NULL,
    [scanned] DATETIME NOT NULL,
    [container_state] VARCHAR(100) NOT NULL
);

CREATE TABLE [crawler_count_log] (
    [id] BIGINT NOT NULL,
    [domain] VARCHAR(256) NULL,
    [cil_id] INT NULL,
    [records] INT NULL,
    [log_from] VARCHAR(256) NULL,
    [captured] DATETIME NULL
);

CREATE TABLE [Crawler_Error_Logs] (
    [event_date] DATETIME NOT NULL,
    [cil_id] INT NOT NULL,
    [error_num] INT NULL,
    [error_message] NVARCHAR(4000) NULL,
    [error_state] INT NULL,
    [error_line] INT NULL,
    [error_proc] NVARCHAR(128) NULL
);

CREATE TABLE [Crawler_ImportLog] (
    [cil_id] BIGINT NOT NULL -- PK,
    [domain] VARCHAR(256) NOT NULL,
    [cil_full_file_name] VARCHAR(1024) NOT NULL,
    [cil_crawl_started] DATETIME NOT NULL,
    [cil_imported] DATETIME NULL,
    [cil_sp_completed] DATETIME NULL,
    [notes] VARCHAR(1024) NULL,
    [cil_provisioned] DATETIME NULL,
    [cil_status] VARCHAR(100) NULL,
    [import_status] VARCHAR(10) NULL,
    [import_notes] VARCHAR(1024) NULL,
    [arn] VARCHAR(1024) NULL
);

CREATE TABLE [Crawler_Jobs] (
    [domain] VARCHAR(256) NOT NULL -- PK,
    [title] VARCHAR(500) NOT NULL,
    [crawled] INT NULL,
    [current_crawled] INT NULL,
    [created] DATETIME NOT NULL,
    [modified] DATETIME NULL,
    [execution_start] DATETIME NULL,
    [execution_end] DATETIME NULL,
    [schedule_start] DATETIME NULL,
    [schedule_end] DATETIME NULL,
    [template] VARCHAR(100) NULL,
    [template_file] VARCHAR(100) NULL,
    [crawler_type] VARCHAR(100) NOT NULL,
    [status] INT NOT NULL,
    [cron_schedule] VARCHAR(200) NOT NULL,
    [subnet] VARCHAR(50) NULL,
    [notes] VARCHAR(2000) NULL,
    [fdid_list] VARCHAR(256) NULL,
    [category] VARCHAR(50) NULL,
    [dns_ip] VARCHAR(50) NULL,
    [cpu] DECIMAL(10,2) NULL,
    [memory] DECIMAL(10,2) NULL,
    [memory_reserved] DECIMAL(10,2) NULL,
    [scrapy_version] VARCHAR(10) NULL,
    [custom_schedule] BIT NULL,
    [expected_count] INT NULL,
    [proxy] BIT NULL,
    [priority] BIT NULL,
    [crawl_status] VARCHAR(50) NULL,
    [crawl_trending] VARCHAR(50) NULL,
    [proxy_type] VARCHAR(50) NULL
);

CREATE TABLE [Crawler_Jobs_Group] (
    [domain] VARCHAR(256) NOT NULL,
    [crawled] INT NULL,
    [groupid] INT NULL,
    [created] DATETIME NOT NULL,
    [launchtime] DATETIME NULL,
    [priority] BIT NULL
);

CREATE TABLE [Crawler_Logs] (
    [domain] VARCHAR(100) NOT NULL -- PK,
    [eventtime] DATETIME NOT NULL -- PK,
    [title] VARCHAR(100) NULL,
    [message] VARCHAR(1000) NULL,
    [whom] VARCHAR(100) NULL
);

CREATE TABLE [Crawler_MetaData] (
    [domain] VARCHAR(100) NOT NULL,
    [entered] DATETIME NOT NULL,
    [keyword] VARCHAR(100) NOT NULL,
    [value] VARCHAR(100) NOT NULL
);

CREATE TABLE [Crawler_Proxy_Types] (
    [id] INT NOT NULL -- PK,
    [name] VARCHAR(100) NOT NULL,
    [value] VARCHAR(100) NOT NULL,
    [enabled] BIT NOT NULL
);

CREATE TABLE [Crawler_Results] (
    [cil_id] BIGINT NOT NULL,
    [veh_vin] VARCHAR(256) NOT NULL,
    [veh_stock_no] VARCHAR(256) NOT NULL,
    [veh_url] VARCHAR(1024) NOT NULL,
    [veh_bodytype] VARCHAR(256) NULL,
    [veh_price] VARCHAR(256) NULL,
    [veh_priceType] VARCHAR(256) NULL,
    [veh_year] VARCHAR(256) NULL,
    [veh_make] VARCHAR(256) NULL,
    [veh_model] VARCHAR(1024) NULL,
    [veh_trim] VARCHAR(256) NULL,
    [veh_title] VARCHAR(1024) NULL,
    [veh_status] VARCHAR(256) NULL,
    [veh_mileage] VARCHAR(256) NULL,
    [veh_cylinders] VARCHAR(256) NULL,
    [veh_displacement] VARCHAR(256) NULL,
    [veh_induction] VARCHAR(256) NULL,
    [veh_transmission] VARCHAR(256) NULL,
    [veh_drivetrain] VARCHAR(256) NULL,
    [veh_exteriorcolor] VARCHAR(256) NULL,
    [veh_interiorcolor] VARCHAR(256) NULL,
    [veh_condition] VARCHAR(256) NULL,
    [veh_doors] VARCHAR(256) NULL,
    [veh_fuelcity] VARCHAR(256) NULL,
    [veh_fuelhighway] VARCHAR(256) NULL,
    [veh_fuelcombined] VARCHAR(256) NULL,
    [veh_fueltype] VARCHAR(45) NULL,
    [veh_carfax] VARCHAR(1024) NULL,
    [veh_images] VARCHAR(8000) NULL,
    [veh_description] VARCHAR(4096) NULL,
    [veh_adnum] INT NULL,
    [veh_filter] VARCHAR(256) NULL,
    [price_meta] VARCHAR(1024) NULL,
    [msrp] VARCHAR(24) NULL,
    [veh_engine] VARCHAR(256) NULL,
    [veh_options] VARCHAR(8000) NULL,
    [veh_test] VARCHAR(8000) NULL
);

CREATE TABLE [Crawler_Results_MissingPercent] (
    [cil_id] BIGINT NOT NULL,
    [veh_vin] VARCHAR(256) NOT NULL,
    [veh_stock_no] VARCHAR(256) NOT NULL,
    [veh_url] VARCHAR(1024) NOT NULL,
    [veh_bodytype] VARCHAR(256) NULL,
    [veh_price] VARCHAR(256) NULL,
    [veh_priceType] VARCHAR(256) NULL,
    [veh_year] VARCHAR(256) NULL,
    [veh_make] VARCHAR(256) NULL,
    [veh_model] VARCHAR(256) NULL,
    [veh_trim] VARCHAR(256) NULL,
    [veh_title] VARCHAR(256) NULL,
    [veh_status] VARCHAR(256) NULL,
    [veh_mileage] VARCHAR(256) NULL,
    [veh_cylinders] VARCHAR(256) NULL,
    [veh_displacement] VARCHAR(256) NULL,
    [veh_induction] VARCHAR(256) NULL,
    [veh_transmission] VARCHAR(256) NULL,
    [veh_drivetrain] VARCHAR(256) NULL,
    [veh_exteriorcolor] VARCHAR(256) NULL,
    [veh_interiorcolor] VARCHAR(256) NULL,
    [veh_condition] VARCHAR(256) NULL,
    [veh_doors] VARCHAR(256) NULL,
    [veh_fuelcity] VARCHAR(256) NULL,
    [veh_fuelhighway] VARCHAR(256) NULL,
    [veh_fuelcombined] VARCHAR(256) NULL,
    [veh_fueltype] VARCHAR(45) NULL,
    [veh_carfax] VARCHAR(256) NULL,
    [veh_images] VARCHAR(8000) NULL,
    [veh_description] VARCHAR(4096) NULL,
    [veh_adnum] INT NULL,
    [veh_filter] VARCHAR(256) NULL,
    [price_meta] VARCHAR(1024) NULL,
    [msrp] VARCHAR(24) NULL,
    [veh_engine] VARCHAR(256) NULL,
    [crawl_date] VARCHAR(24) NULL,
    [template] VARCHAR(24) NULL
);

CREATE TABLE [Crawler_Results_RealEstate] (
    [cil_id] BIGINT NULL,
    [domain] VARCHAR(256) NULL,
    [prp_url] VARCHAR(1024) NULL,
    [prp_mls_id] VARCHAR(64) NULL,
    [prp_external_id] VARCHAR(64) NULL,
    [prp_title] VARCHAR(256) NULL,
    [prp_price] DECIMAL(18,0) NULL,
    [prp_pricetype] VARCHAR(32) NULL,
    [prp_agent_name] VARCHAR(64) NULL,
    [prp_agent_id] VARCHAR(64) NULL,
    [prp_agent_phone] VARCHAR(16) NULL,
    [prp_agent_extension] VARCHAR(10) NULL,
    [prp_phone] VARCHAR(16) NULL,
    [prp_extension] VARCHAR(10) NULL,
    [prp_address] VARCHAR(64) NULL,
    [prp_city] VARCHAR(64) NULL,
    [prp_region] VARCHAR(32) NULL,
    [prp_zip_code] VARCHAR(5) NULL,
    [prp_condition] VARCHAR(32) NULL,
    [prp_bedrooms] INT NULL,
    [prp_bathrooms] DECIMAL(18,0) NULL,
    [prp_pet_policy] VARCHAR(32) NULL,
    [prp_type] VARCHAR(32) NULL,
    [prp_square_feet] INT NULL,
    [prp_additional_rooms] INT NULL,
    [prp_style] VARCHAR(32) NULL,
    [prp_parking] VARCHAR(32) NULL,
    [prp_available] DATE NULL,
    [prp_amenities] VARCHAR(1024) NULL,
    [prp_utilities] VARCHAR(1024) NULL,
    [prp_furnishing] VARCHAR(1024) NULL,
    [prp_terms] VARCHAR(1024) NULL,
    [prp_year_built] VARCHAR(4) NULL,
    [prp_highlights] VARCHAR(1024) NULL,
    [prp_comments] VARCHAR(MAX) NULL,
    [prp_images] VARCHAR(MAX) NULL
);

CREATE TABLE [Crawler_Revisions] (
    [revisionkey] VARCHAR(256) NOT NULL -- PK,
    [type] VARCHAR(10) NOT NULL -- PK,
    [modified] DATETIME NOT NULL -- PK,
    [versionId] VARCHAR(50) NULL,
    [author] VARCHAR(100) NOT NULL,
    [changes] TEXT NOT NULL,
    [notes] VARCHAR(MAX) NOT NULL
);

CREATE TABLE [Crawler_Settings] (
    [setting] VARCHAR(140) NOT NULL -- PK,
    [value] VARCHAR(140) NOT NULL
);

CREATE TABLE [Crawler_Stats] (
    [cil_id] INT NOT NULL -- PK,
    [stat_param] VARCHAR(100) NOT NULL -- PK,
    [stat_value] VARCHAR(100) NOT NULL,
    [stat_category] VARCHAR(100) NULL
);

CREATE TABLE [Crawler_Stores] (
    [domain] VARCHAR(256) NOT NULL -- PK,
    [keyword] VARCHAR(256) NOT NULL -- PK,
    [description] VARCHAR(1000) NULL,
    [fdid_list] VARCHAR(100) NOT NULL,
    [crawler_type] VARCHAR(100) NOT NULL -- PK
);

CREATE TABLE [Crawler_Templates] (
    [name] VARCHAR(100) NOT NULL -- PK,
    [keyword] VARCHAR(100) NOT NULL,
    [filename] VARCHAR(100) NULL,
    [created] DATETIME NULL,
    [modified] DATETIME NULL,
    [notes] VARCHAR(1000) NULL,
    [archived] BIT NULL,
    [scrapy_version] VARCHAR(10) NULL
);

CREATE TABLE [Crawler_Templates_Logs] (
    [name] VARCHAR(100) NOT NULL -- PK,
    [eventtime] DATETIME NOT NULL -- PK,
    [whom] VARCHAR(100) NOT NULL,
    [notes] VARCHAR(1000) NOT NULL
);

CREATE TABLE [Crawler_Totals] (
    [date] DATETIME NOT NULL -- PK,
    [type] VARCHAR(50) NOT NULL -- PK,
    [domain] VARCHAR(256) NOT NULL -- PK,
    [total] BIGINT NOT NULL
);

CREATE TABLE [Crawler_Unique_AdNum] (
    [cua_id] BIGINT NOT NULL -- PK,
    [domain] VARCHAR(256) NOT NULL,
    [veh_vin] VARCHAR(256) NOT NULL,
    [veh_stock_no] VARCHAR(256) NOT NULL
);

CREATE TABLE [crosslinked] (
    [adv_name] VARCHAR(128) NULL,
    [website_url] VARCHAR(255) NULL,
    [lst_title] VARCHAR(128) NULL,
    [lst_vdp] VARCHAR(1024) NULL,
    [veh_vin] VARCHAR(32) NULL,
    [lst_id] INT NOT NULL
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

CREATE TABLE [domains_with_dupes] (
    [domain] VARCHAR(64) NULL
);

CREATE TABLE [FacebookPageMapping] (
    [Id] INT NOT NULL -- PK,
    [PageId] VARCHAR(100) NOT NULL,
    [PageUrl] VARCHAR(100) NOT NULL,
    [CampaignName] VARCHAR(500) NOT NULL,
    [BusinessName] VARCHAR(100) NOT NULL,
    [AccountId] INT NOT NULL
);

CREATE TABLE [FBCampaignData] (
    [fbdata_id] INT NOT NULL -- PK,
    [fb_import_id] INT NOT NULL,
    [adaccount_name] VARCHAR(500) NOT NULL,
    [adaccount_id] VARCHAR(50) NOT NULL,
    [adset_id] VARCHAR(50) NOT NULL,
    [ad_id] VARCHAR(50) NOT NULL,
    [name] VARCHAR(500) NOT NULL,
    [preview_link] VARCHAR(500) NOT NULL,
    [effective_status] VARCHAR(50) NOT NULL,
    [status] VARCHAR(50) NOT NULL,
    [demolink_hash] VARCHAR(100) NOT NULL,
    [created_time] DATETIME NULL,
    [updated_time] DATETIME NULL,
    [issue_level] VARCHAR(100) NULL,
    [issue_error_summary] VARCHAR(1000) NULL,
    [issue_error_message] VARCHAR(1000) NULL,
    [issue_error_type] VARCHAR(10) NULL,
    [issue_error_code] INT NULL,
    [learning_status] VARCHAR(100) NULL,
    [learning_conversions] INT NULL,
    [learning_last_edit] INT NULL
);

CREATE TABLE [FBCampaignDatav2] (
    [fbdata_id] INT NOT NULL -- PK,
    [fb_import_id] INT NOT NULL,
    [adaccount_id] VARCHAR(50) NOT NULL,
    [adaccount_name] VARCHAR(500) NOT NULL,
    [adset_id] VARCHAR(50) NOT NULL,
    [adset_name] VARCHAR(500) NOT NULL,
    [ad_id] VARCHAR(50) NOT NULL,
    [ad_name] VARCHAR(500) NOT NULL,
    [preview_link] VARCHAR(500) NOT NULL,
    [effective_status] VARCHAR(50) NOT NULL,
    [status] VARCHAR(50) NOT NULL,
    [demolink_hash] VARCHAR(100) NOT NULL,
    [created_time] DATETIME NULL,
    [updated_time] DATETIME NULL,
    [issue_level] VARCHAR(100) NULL,
    [issue_error_summary] VARCHAR(1000) NULL,
    [issue_error_message] VARCHAR(1000) NULL,
    [issue_error_type] VARCHAR(10) NULL,
    [issue_error_code] INT NULL,
    [learning_status] VARCHAR(100) NULL,
    [learning_conversions] INT NULL,
    [learning_last_edit] INT NULL
);

CREATE TABLE [FBImport] (
    [fb_import_id] INT NOT NULL -- PK,
    [start] DATETIME NOT NULL,
    [finished] DATETIME NULL,
    [status] VARCHAR(50) NOT NULL
);

CREATE TABLE [FoxFactoryAgedRAM] (
    [dlrname] VARCHAR(128) NULL,
    [VIN] VARCHAR(24) NULL,
    [model_package] VARCHAR(128) NULL,
    [VDP] VARCHAR(256) NULL,
    [region] VARCHAR(64) NULL,
    [catlog] VARCHAR(64) NULL,
    [domain] VARCHAR(128) NULL,
    [lastupload] VARCHAR(128) NULL
);

CREATE TABLE [GraftChevyListings] (
    [lst_id] INT NOT NULL,
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

CREATE TABLE [GraftChevyVDP] (
    [job_domain] VARCHAR(256) NOT NULL,
    [job_lastexecution] DATETIME NULL,
    [veh_vin] VARCHAR(256) NOT NULL,
    [veh_url] VARCHAR(1024) NOT NULL,
    [DataSource] VARCHAR(6) NOT NULL,
    [veh_stock] VARCHAR(256) NOT NULL
);

CREATE TABLE [ImageDownloadStatus] (
    [ids_ID] INT NOT NULL -- PK,
    [ids_Name] VARCHAR(64) NOT NULL,
    [ids_Step] INT NOT NULL,
    [ids_Active] BIT NOT NULL
);

CREATE TABLE [ImageStatus] (
    [timestamp] DATETIME NOT NULL -- PK,
    [status] VARCHAR(1000) NOT NULL
);

CREATE TABLE [IntMaxes] (
    [IntMax] INT NULL,
    [TableName] VARCHAR(64) NULL,
    [ColumnName] VARCHAR(64) NULL
);

CREATE TABLE [InventoryTotals] (
    [feedtype] VARCHAR(20) NOT NULL,
    [type] INT NOT NULL,
    [source] VARCHAR(512) NULL,
    [accid] INT NULL,
    [count] INT NULL,
    [lastupload] SMALLDATETIME NULL,
    [updated] DATETIME NOT NULL
);

CREATE TABLE [ListingImageDownload] (
    [llim_ID] BIGINT NOT NULL -- PK,
    [llim_URL] VARCHAR(512) NULL,
    [llst_ID] INT NOT NULL,
    [ids_ID] INT NOT NULL,
    [lid_Created] DATETIME NOT NULL,
    [lid_Modified] DATETIME NOT NULL,
    [lid_FailCount] INT NOT NULL,
    [lid_URL] VARCHAR(512) NULL,
    [lid_FileSize] INT NULL,
    [lid_StockPhoto] BIT NULL
);

CREATE TABLE [ListingImageDownload_Queue] (
    [que_ID] BIGINT NOT NULL -- PK,
    [llim_ID] BIGINT NOT NULL,
    [ids_ID] INT NOT NULL,
    [lid_URL] VARCHAR(512) NULL,
    [lid_FileSize] INT NULL,
    [lid_Received] DATETIME NOT NULL,
    [lid_Processed] DATETIME NULL,
    [Results] VARCHAR(512) NOT NULL
);

CREATE TABLE [ListingImageDownload_Queue_History] (
    [que_ID] BIGINT NOT NULL,
    [llim_ID] BIGINT NOT NULL,
    [ids_ID] INT NOT NULL,
    [lid_URL] VARCHAR(512) NULL,
    [lid_FileSize] INT NULL,
    [lid_Received] DATETIME NOT NULL,
    [lid_Processed] DATETIME NULL,
    [Results] VARCHAR(512) NOT NULL,
    [captured] DATETIME NOT NULL
);

CREATE TABLE [ListingVideoDownload] (
    [llvd_ID] BIGINT NOT NULL -- PK,
    [llst_ID] INT NOT NULL,
    [lvd_SourceURL] NVARCHAR(2048) NOT NULL,
    [lvd_URL] NVARCHAR(2048) NULL,
    [lvd_FileSize] BIGINT NULL,
    [vds_ID] INT NOT NULL,
    [lvd_FailCount] INT NOT NULL,
    [lvd_Created] DATETIME2 NOT NULL,
    [lvd_Modified] DATETIME2 NULL,
    [last_message_id] NVARCHAR(128) NULL,
    [last_result_message_id] NVARCHAR(128) NULL
);

CREATE TABLE [ListingVideoOutput] (
    [llvo_ID] BIGINT NOT NULL -- PK,
    [llvd_ID] BIGINT NOT NULL,
    [width] INT NOT NULL,
    [height] INT NOT NULL,
    [format] NVARCHAR(16) NOT NULL,
    [quality] INT NOT NULL,
    [lvo_ProcessedURL] NVARCHAR(2048) NOT NULL,
    [lvo_FileSize] BIGINT NOT NULL,
    [processing_successful] BIT NOT NULL,
    [lvo_Created] DATETIME2 NOT NULL
);

CREATE TABLE [LogFile] (
    [lfName] VARCHAR(4000) NULL,
    [lfCreated] DATETIME NULL,
    [lfSize] BIGINT NULL
);

CREATE TABLE [LongImageURLs] (
    [domain] VARCHAR(256) NULL
);

CREATE TABLE [MonthlyPriceImageProcessing] (
    [llim_ID] BIGINT NOT NULL,
    [lst_title] VARCHAR(128) NULL,
    [lst_price] DECIMAL(15,2) NULL,
    [monthly_price] DECIMAL(18,0) NULL,
    [veh_make] VARCHAR(64) NULL,
    [veh_model] VARCHAR(64) NULL,
    [veh_year] VARCHAR(4) NULL,
    [lst_image] VARCHAR(512) NULL,
    [llim_URL] VARCHAR(512) NULL,
    [process_state] INT NOT NULL,
    [created] DATETIME NOT NULL,
    [veh_status] VARCHAR(32) NULL,
    [disclaimer] VARCHAR(8000) NULL
);

CREATE TABLE [MonthlyPriceImageProcessingLogs] (
    [acc_id] INT NOT NULL,
    [updated] DATETIME NOT NULL
);

CREATE TABLE [NoPriceOnSite] (
    [domain] VARCHAR(256) NULL
);

CREATE TABLE [SmartPLDListings] (
    [acc_id] INT NULL,
    [lst_id] INT NOT NULL,
    [src_adid] VARCHAR(32) NOT NULL,
    [lst_title] VARCHAR(128) NULL,
    [lst_onlinetext] VARCHAR(8000) NULL,
    [lst_price] DECIMAL(15,2) NULL,
    [lst_vdp] VARCHAR(1024) NULL,
    [lst_image] VARCHAR(512) NULL,
    [lst_created] DATETIME NULL,
    [lst_lastupload] DATETIME NULL,
    [NewURL] VARCHAR(256) NULL,
    [Preferred] INT NULL,
    [veh_make] VARCHAR(64) NULL,
    [veh_model] VARCHAR(64) NULL,
    [veh_year] VARCHAR(4) NULL,
    [veh_mileage] VARCHAR(32) NULL,
    [image_tag] VARCHAR(128) NULL,
    [veh_transmission] VARCHAR(64) NULL,
    [veh_fueltype] VARCHAR(32) NULL,
    [veh_bodytype] VARCHAR(64) NULL,
    [veh_drivetrain] VARCHAR(32) NULL,
    [veh_vin] VARCHAR(32) NULL,
    [veh_condition] VARCHAR(32) NULL,
    [veh_exteriorcolor] VARCHAR(128) NULL,
    [veh_status] VARCHAR(32) NULL,
    [veh_trim] VARCHAR(128) NULL,
    [veh_interior_color] VARCHAR(128) NULL,
    [veh_fluff] VARCHAR(128) NULL,
    [veh_hash] BINARY(20) NULL
);

CREATE TABLE [SmartVDPAccounts] (
    [acc_id] INT NULL,
    [acc_company] VARCHAR(64) NULL,
    [acc_address] VARCHAR(64) NULL,
    [acc_city] VARCHAR(64) NULL,
    [acc_state] VARCHAR(64) NULL,
    [zip_code] VARCHAR(10) NULL,
    [acc_image] VARCHAR(512) NULL,
    [acc_url] VARCHAR(512) NULL,
    [acc_utm] VARCHAR(256) NULL,
    [zip_latitude] FLOAT NULL,
    [zip_longitude] FLOAT NULL,
    [stt_id] VARCHAR(2) NULL
);

CREATE TABLE [SmartVDPBotAgents] (
    [bot_id] INT NOT NULL -- PK,
    [bot_user_agent] NVARCHAR(1024) NOT NULL
);

CREATE TABLE [SmartVDPClicks] (
    [srp_id] INT NOT NULL -- PK,
    [event_date] DATETIME NOT NULL,
    [app_initials] VARCHAR(12) NOT NULL,
    [app_action] INT NOT NULL,
    [user_ipaddress] VARCHAR(45) NULL,
    [http_user_agent] VARCHAR(128) NULL,
    [http_referrer] VARCHAR(128) NULL,
    [is_bot] BIT NULL,
    [acc_id] INT NOT NULL,
    [lst_id] INT NOT NULL,
    [subscription_id] INT NOT NULL,
    [landing_url] VARCHAR(128) NULL,
    [session_id] VARCHAR(32) NOT NULL,
    [is_test] BIT NOT NULL
);

CREATE TABLE [SmartVDPListings] (
    [acc_id] INT NULL,
    [lst_id] INT NOT NULL,
    [src_adid] VARCHAR(32) NOT NULL,
    [lst_title] VARCHAR(128) NULL,
    [lst_onlinetext] VARCHAR(8000) NULL,
    [lst_price] DECIMAL(15,2) NULL,
    [lst_vdp] VARCHAR(1024) NULL,
    [lst_image] VARCHAR(512) NULL,
    [lst_created] DATETIME NULL,
    [lst_lastupload] DATETIME NULL,
    [NewURL] VARCHAR(512) NULL,
    [Preferred] INT NULL,
    [veh_make] VARCHAR(64) NULL,
    [veh_model] VARCHAR(64) NULL,
    [veh_year] VARCHAR(4) NULL,
    [veh_mileage] VARCHAR(32) NULL,
    [image_tag] VARCHAR(128) NULL,
    [veh_transmission] VARCHAR(64) NULL,
    [veh_fueltype] VARCHAR(32) NULL,
    [veh_bodytype] VARCHAR(64) NULL,
    [veh_drivetrain] VARCHAR(32) NULL,
    [veh_vin] VARCHAR(32) NULL,
    [veh_condition] VARCHAR(32) NULL,
    [veh_exteriorcolor] VARCHAR(128) NULL,
    [veh_status] VARCHAR(32) NULL,
    [veh_trim] VARCHAR(128) NULL,
    [veh_interior_color] VARCHAR(128) NULL,
    [veh_fluff] VARCHAR(128) NULL,
    [veh_hash] BINARY(20) NULL,
    [monthly_price] DECIMAL(18,0) NULL,
    [page_id] VARCHAR(100) NULL
);

CREATE TABLE [SmartVDPOptions] (
    [Id] BIGINT NOT NULL,
    [AccountId] BIGINT NULL,
    [Bypass] BIGINT NOT NULL,
    [DealerLogo] VARCHAR(512) NULL,
    [VDPType] VARCHAR(128) NULL,
    [VDPAlgo] INT NULL
);

CREATE TABLE [srp_daily_processing] (
    [app_action] INT NOT NULL,
    [acc_id] INT NULL,
    [lst_id] INT NULL,
    [subscription_id] INT NOT NULL,
    [session_id] VARCHAR(50) NOT NULL
);

CREATE TABLE [SubscriptionMetaData] (
    [Id] INT NOT NULL,
    [Analytics_Id] VARCHAR(256) NULL,
    [Include_Video_Feed] BIT NULL
);

CREATE TABLE [Tickets] (
    [type] VARCHAR(10) NOT NULL,
    [domain] VARCHAR(256) NOT NULL,
    [requestType] VARCHAR(10) NOT NULL,
    [created] DATETIME NOT NULL,
    [ticketId] VARCHAR(10) NOT NULL,
    [resolved] BIT NOT NULL,
    [title] VARCHAR(512) NOT NULL,
    [assigned] VARCHAR(128) NOT NULL
);

CREATE TABLE [TikTokFeedListings] (
    [acc_id] INT NOT NULL,
    [subscription_id] INT NOT NULL,
    [lst_id] INT NOT NULL,
    [vin] VARCHAR(32) NOT NULL,
    [make] VARCHAR(64) NOT NULL,
    [model] VARCHAR(64) NOT NULL,
    [trim] VARCHAR(128) NULL,
    [year] VARCHAR(4) NOT NULL,
    [price] DECIMAL(18,2) NULL,
    [sale_price] DECIMAL(18,2) NULL,
    [monthly_price] DECIMAL(18,2) NULL,
    [state_of_vehicle] VARCHAR(16) NULL,
    [availability] VARCHAR(32) NOT NULL,
    [mileage_value] INT NULL,
    [mileage_unit] VARCHAR(4) NULL,
    [transmission] VARCHAR(64) NULL,
    [fuel_type] VARCHAR(32) NULL,
    [drivetrain] VARCHAR(32) NULL,
    [body_style] VARCHAR(64) NULL,
    [exterior_color] VARCHAR(128) NULL,
    [interior_color] VARCHAR(128) NULL,
    [image_link] VARCHAR(1024) NULL,
    [image_0_url] VARCHAR(1024) NULL,
    [video_link] VARCHAR(1024) NULL,
    [url] VARCHAR(1024) NOT NULL,
    [link] VARCHAR(1024) NOT NULL,
    [title] VARCHAR(256) NOT NULL,
    [description] VARCHAR(8000) NULL,
    [dealer_name] VARCHAR(256) NULL,
    [address] VARCHAR(1024) NULL,
    [city] VARCHAR(128) NULL,
    [region] VARCHAR(64) NULL,
    [postal_code] VARCHAR(16) NULL,
    [country] VARCHAR(64) NULL,
    [latitude] DECIMAL(9,6) NULL,
    [longitude] DECIMAL(9,6) NULL,
    [custom_label_0] VARCHAR(256) NULL,
    [custom_label_1] VARCHAR(256) NULL,
    [custom_label_2] VARCHAR(256) NULL,
    [custom_label_3] VARCHAR(256) NULL,
    [custom_label_4] VARCHAR(256) NULL
);

CREATE TABLE [TimLog] (
    [t] VARCHAR(MAX) NULL
);

CREATE TABLE [VDPAccount_Temp] (
    [acc_id] INT NULL,
    [acc_company] VARCHAR(64) NULL,
    [acc_address] VARCHAR(64) NULL,
    [acc_city] VARCHAR(64) NULL,
    [acc_state] VARCHAR(64) NULL,
    [zip_code] VARCHAR(5) NULL,
    [acc_Image] VARCHAR(512) NULL,
    [acc_URL] VARCHAR(512) NULL,
    [acc_UTM] VARCHAR(256) NULL,
    [zip_lat] FLOAT NULL,
    [zip_long] FLOAT NULL,
    [state_id] VARCHAR(2) NULL
);

CREATE TABLE [VDPDailyTotals] (
    [cmp_id] INT NOT NULL,
    [cost] DECIMAL(19,4) NOT NULL,
    [vdp_views] INT NOT NULL,
    [clicks] INT NOT NULL,
    [impressions] INT NOT NULL
);

CREATE TABLE [VDPDashCostByCampaigns] (
    [cmp_id] BIGINT NULL,
    [cost] FLOAT NOT NULL,
    [impressions] INT NOT NULL,
    [clicks] INT NOT NULL,
    [vdps] INT NOT NULL,
    [costpervdp] FLOAT NULL
);

CREATE TABLE [VDPDashDailyStats] (
    [datatype] VARCHAR(50) NOT NULL,
    [cmp_id] INT NOT NULL,
    [day01] DECIMAL(19,4) NULL,
    [day02] DECIMAL(19,4) NULL,
    [day03] DECIMAL(19,4) NULL,
    [day04] DECIMAL(19,4) NULL,
    [day05] DECIMAL(19,4) NULL,
    [day06] DECIMAL(19,4) NULL,
    [day07] DECIMAL(19,4) NULL,
    [day08] DECIMAL(19,4) NULL,
    [day09] DECIMAL(19,4) NULL,
    [day10] DECIMAL(19,4) NULL,
    [day11] DECIMAL(19,4) NULL,
    [day12] DECIMAL(19,4) NULL,
    [day13] DECIMAL(19,4) NULL,
    [day14] DECIMAL(19,4) NULL,
    [day15] DECIMAL(19,4) NULL,
    [day16] DECIMAL(19,4) NULL,
    [day17] DECIMAL(19,4) NULL,
    [day18] DECIMAL(19,4) NULL,
    [day19] DECIMAL(19,4) NULL,
    [day20] DECIMAL(19,4) NULL,
    [day21] DECIMAL(19,4) NULL,
    [day22] DECIMAL(19,4) NULL,
    [day23] DECIMAL(19,4) NULL,
    [day24] DECIMAL(19,4) NULL,
    [day25] DECIMAL(19,4) NULL,
    [day26] DECIMAL(19,4) NULL,
    [day27] DECIMAL(19,4) NULL,
    [day28] DECIMAL(19,4) NULL,
    [day29] DECIMAL(19,4) NULL,
    [day30] DECIMAL(19,4) NULL,
    [day31] DECIMAL(19,4) NULL
);

CREATE TABLE [VDPDashMonthlyTotals] (
    [month] INT NULL,
    [cost] FLOAT NULL,
    [impressions] INT NULL,
    [clicks] INT NULL,
    [vdps] INT NULL,
    [costpervdp] FLOAT NULL
);

CREATE TABLE [VDPDashPacingCampaign] (
    [days] INT NULL,
    [expected_vdp] NUMERIC(30,2) NULL,
    [current_vdp] INT NOT NULL,
    [pacing_delta] DECIMAL(37,19) NULL,
    [flight_id] BIGINT NULL,
    [cmp_id] BIGINT NULL,
    [acc_id] BIGINT NULL,
    [adv_id] BIGINT NULL
);

CREATE TABLE [VDPListings_Temp] (
    [acc_id] INT NULL,
    [lst_id] INT NULL,
    [src_adid] VARCHAR(32) NULL,
    [lst_title] VARCHAR(128) NULL,
    [lst_onlinetext] VARCHAR(8000) NULL,
    [lst_price] MONEY NULL,
    [lst_vdp] VARCHAR(1024) NULL,
    [lst_image] VARCHAR(512) NULL,
    [lst_created] DATETIME NULL,
    [lst_lastupload] DATETIME NULL,
    [NewURL] VARCHAR(256) NULL,
    [Preferred] INT NULL,
    [veh_make] VARCHAR(64) NULL,
    [veh_model] VARCHAR(64) NULL,
    [veh_year] VARCHAR(4) NULL,
    [veh_mileage] VARCHAR(32) NULL,
    [image_tag] VARCHAR(128) NULL,
    [veh_transmission] VARCHAR(64) NULL,
    [veh_fueltype] VARCHAR(32) NULL,
    [veh_bodytype] VARCHAR(64) NULL,
    [veh_drivetrain] VARCHAR(32) NULL,
    [veh_vin] VARCHAR(32) NULL,
    [veh_condition] VARCHAR(32) NULL,
    [veh_exteriorcolor] VARCHAR(128) NULL,
    [veh_status] VARCHAR(32) NULL,
    [veh_trim] VARCHAR(128) NULL,
    [veh_interior_color] VARCHAR(128) NULL,
    [veh_fluff] VARCHAR(128) NULL,
    [veh_hash] BINARY(20) NULL
);

CREATE TABLE [VehicleFilterLocation] (
    [id] INT NOT NULL -- PK,
    [domain] VARCHAR(128) NOT NULL,
    [veh_filter] VARCHAR(128) NOT NULL,
    [location_name] VARCHAR(256) NOT NULL
);
