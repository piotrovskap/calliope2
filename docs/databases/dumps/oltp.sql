-- =============================================================================
-- DATABASE: oltp (Response Logix Production)
-- SERVER:   20.65.216.199:49577
-- EXTRACTED: 2026-06-14 (schema-only, no data)
-- RESEARCHER: Alicia Salazar
-- SCHEMAS:  dbo (239 tables), Cleanup (1 table)
-- TOTAL ROWS: ~1.1 billion
-- TOTAL SIZE: ~196 GB (oltp), +225 GB archive (oltp_Archive)
-- =============================================================================
-- NOTE: Schema-only. No row data extracted.
-- NOTE: SQL Server 2012 Standard Edition.
-- =============================================================================

USE [oltp];
GO

-- =============================================================================
-- Cleanup.IndexFragmentation
-- =============================================================================
CREATE TABLE [Cleanup].[IndexFragmentation] (

    [DatabaseName] sysname NULL,
    [SchemaName] sysname NULL,
    [ObjectName] sysname NULL,
    [IndexName] sysname NULL,
    [ObjectType] nvarchar(60) NULL,
    [IndexType] nvarchar(60) NULL,
    [PageCount] bigint NULL,
    [AvgFragmentationInPercent] float NULL,
    [TimeStamp] datetime NULL,
);

GO

-- =============================================================================
-- dbo._FOR_DELETE_accounts
-- =============================================================================
CREATE TABLE [dbo].[_FOR_DELETE_accounts] (

    [CustomerGuid] uniqueidentifier NULL,
    [RLName] varchar(255) NULL,
    [NewSFDCId] varchar(18) NULL,
    [OldSFDCId] varchar(18) NULL,
    [AccountId] int NOT NULL,
    [ownerId] int NULL,
    [PostalCode] varchar(20) NULL,
    [id] int NULL,
    [SFDCId] varchar(18) NULL,
    [FirstName] varchar(40) NULL,
    [LastName] varchar(80) NULL,
    [Title] varchar(80) NULL,
    [Phone] varchar(40) NULL,
    [MobilePhone] varchar(40) NULL,
    [Email] varchar(80) NULL,
    [user_id] varchar(20) NULL,
);

GO

-- =============================================================================
-- dbo._FOR_DELETE_campaign_txn
-- =============================================================================
CREATE TABLE [dbo].[_FOR_DELETE_campaign_txn] (

    [lead_id] uniqueidentifier NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [txn] xml NOT NULL,
);

GO

-- =============================================================================
-- dbo._FOR_DELETE_franchise_consumer_txn_tracking
-- =============================================================================
CREATE TABLE [dbo].[_FOR_DELETE_franchise_consumer_txn_tracking] (

    [franchise_consumer_txn_tracking_id] bigint NOT NULL,
    [txn_id] uniqueidentifier NOT NULL,
    [created_date] datetime NOT NULL,
    [description] varchar(50) NOT NULL,
    [guid] uniqueidentifier NOT NULL,
    [is_activated] bit NOT NULL,
    [activation_date] datetime NULL,
);

GO

-- =============================================================================
-- dbo._FOR_DELETE_lead_history_campaign_tracking
-- =============================================================================
CREATE TABLE [dbo].[_FOR_DELETE_lead_history_campaign_tracking] (

    [lead_history_campaign_tracking_id] bigint NOT NULL,
    [lead_history_id] uniqueidentifier NOT NULL,
    [description] varchar(50) NOT NULL,
    [guid] uniqueidentifier NOT NULL,
    [is_activated] bit NOT NULL,
);

GO

-- =============================================================================
-- dbo._FOR_DELETE_SF_emails_data3
-- =============================================================================
CREATE TABLE [dbo].[_FOR_DELETE_SF_emails_data3] (

    [lead_id] uniqueidentifier NOT NULL,
    [subject] nvarchar(256) NULL,
    [Address] nvarchar(320) NOT NULL,
    [nums] int NULL,
    [customer_id] int NULL,
    [customer_name] varchar(128) NULL,
);

GO

-- =============================================================================
-- dbo._FOR_DELETE_SFMirrorProduct2
-- =============================================================================
CREATE TABLE [dbo].[_FOR_DELETE_SFMirrorProduct2] (

    [CreatedById] nvarchar(18) NULL,
    [CreatedDate] datetime NULL,
    [Description] nvarchar(MAX) NULL,
    [Family] nvarchar(40) NULL,
    [Id] nvarchar(18) NULL,
    [Ignore_Surcharge__c] bit NULL,
    [IsActive] bit NULL,
    [IsDeleted] bit NULL,
    [LastModifiedById] nvarchar(18) NULL,
    [LastModifiedDate] datetime NULL,
    [Medium_Sales_Person_Price__c] numeric(18,2) NULL,
    [Minimum_PC_Fee__c] numeric(18,2) NULL,
    [Minimum_Sales_Person_Price__c] numeric(18,2) NULL,
    [Name] nvarchar(255) NULL,
    [OEM_Specialty_PC_Fee__c] numeric(18,2) NULL,
    [PC_Fee__c] numeric(18,2) NULL,
    [ProductCode] nvarchar(255) NULL,
    [ProductID__c] nvarchar(1300) NULL,
    [RecordTypeId] nvarchar(18) NULL,
    [Start_of_Service__c] nvarchar(MAX) NULL,
    [SystemModstamp] datetime NULL,
    [Wholesale_Price__c] numeric(18,2) NULL,
);

GO

-- =============================================================================
-- dbo._FOR_DELETE_smart_quote_override
-- =============================================================================
CREATE TABLE [dbo].[_FOR_DELETE_smart_quote_override] (

    [id] int NOT NULL,
    [smart_quote_id] uniqueidentifier NOT NULL,
    [created_date] datetime NOT NULL,
    [browser] varchar(250) NULL,
    [ip_address] varchar(16) NULL,
    [is_updated] bit NOT NULL,
    [action] tinyint NOT NULL,
    [action_time] datetime NOT NULL,
);

GO

-- =============================================================================
-- dbo._TMP_smart_follow_performance_report
-- =============================================================================
CREATE TABLE [dbo].[_TMP_smart_follow_performance_report] (

    [txt] varchar(256) NULL,
);

GO

-- =============================================================================
-- dbo.AIS_Makes
-- =============================================================================
CREATE TABLE [dbo].[AIS_Makes] (

    [id] int NOT NULL,
    [Name] varchar(50) NOT NULL,
    [ManufacturerId] int NOT NULL,
    [ManufacturerName] varchar(50) NOT NULL,
    [Hashcode] varchar(64) NULL,
);

GO

-- =============================================================================
-- dbo.AIS_VehicleCodes
-- =============================================================================
CREATE TABLE [dbo].[AIS_VehicleCodes] (

    [id] int NOT NULL,
    [StyleId] int NOT NULL,
    [Year] int NULL,
    [MakeId] int NOT NULL,
    [ACode] varchar(15) NOT NULL,
    [ModelCode] varchar(128) NOT NULL,
);

GO

-- =============================================================================
-- dbo.AIS_VehicleGroups
-- =============================================================================
CREATE TABLE [dbo].[AIS_VehicleGroups] (

    [id] int NOT NULL,
    [AisGroupId] varchar(12) NULL,
    [Name] varchar(128) NULL,
    [Year] int NOT NULL,
    [MakeId] int NOT NULL,
    [RegionId] int NOT NULL,
    [HashCode] varchar(64) NULL,
    [Hints] varchar(512) NULL,
    [HintsForExclusion] varchar(512) NULL,
);

GO

-- =============================================================================
-- dbo.announcement
-- =============================================================================
CREATE TABLE [dbo].[announcement] (

    [announcement_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [expiration_date] datetime NULL,
    [type] varchar(10) NOT NULL,
    [announcement] varchar(2000) NOT NULL,
    [status] varchar(30) NOT NULL,
);

GO

-- =============================================================================
-- dbo.AzureStorageWriteData
-- =============================================================================
CREATE TABLE [dbo].[AzureStorageWriteData] (

    [id] int NOT NULL,
    [Data] varchar(MAX) NOT NULL,
);

GO

-- =============================================================================
-- dbo.AzureStorageWriteJournal
-- =============================================================================
CREATE TABLE [dbo].[AzureStorageWriteJournal] (

    [Id] int NOT NULL,
    [Created] datetime NOT NULL,
    [Reserved] datetime NULL,
    [Reprocessed] tinyint NULL,
    [Status] tinyint NOT NULL,
    [Type] tinyint NOT NULL,
    [Label] varchar(25) NULL,
    [Name] varchar(512) NOT NULL,
    [Context] varchar(512) NULL,
    [ContextLenght] int NULL,
);

GO

-- =============================================================================
-- dbo.bmw_dealer_map
-- =============================================================================
CREATE TABLE [dbo].[bmw_dealer_map] (

    [bmw_dealer_map_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [dealer_code] varchar(100) NOT NULL,
    [dealer_name] varchar(100) NULL,
    [dealer_city] varchar(100) NULL,
    [dealer_state] varchar(2) NULL,
    [dealer_zip] varchar(10) NULL,
    [dealer_phone] varchar(20) NULL,
);

GO

-- =============================================================================
-- dbo.cache_campaign_action
-- =============================================================================
CREATE TABLE [dbo].[cache_campaign_action] (

    [cache_campaign_action_id] bigint NOT NULL,
    [created_date] datetime NULL,
    [franchise_campaign_action_id] int NULL,
    [lead_id] uniqueidentifier NULL,
    [lead_date] datetime NULL,
    [campaign_type] varchar(20) NULL,
    [action_type] varchar(20) NULL,
    [action_name] varchar(50) NULL,
    [subject] varchar(1000) NULL,
);

GO

-- =============================================================================
-- dbo.cdr
-- =============================================================================
CREATE TABLE [dbo].[cdr] (

    [cdr_id] bigint NOT NULL,
    [calldate] datetime NULL,
    [clid] varchar(80) NULL,
    [src] varchar(80) NULL,
    [dst] varchar(80) NULL,
    [dcontext] varchar(80) NULL,
    [channel] varchar(80) NULL,
    [dstchannel] varchar(80) NULL,
    [lastapp] varchar(80) NULL,
    [lastdata] varchar(80) NULL,
    [duration] bigint NULL,
    [billsec] bigint NULL,
    [disposition] varchar(45) NULL,
    [amaflags] bigint NULL,
    [accountcode] varchar(20) NULL,
    [uniqueid] varchar(40) NULL,
    [userfield] varchar(255) NULL,
    [status] varchar(10) NOT NULL,
);

GO

-- =============================================================================
-- dbo.ChatStatistics
-- =============================================================================
CREATE TABLE [dbo].[ChatStatistics] (

    [lead_number] int NOT NULL,
    [lead_date] datetime NOT NULL,
    [customer_id] int NOT NULL,
    [noQuote] bit NOT NULL,
    [status] smallint NULL,
    [adviserId] int NULL,
    [processingTime] datetime NULL,
    [reviewingTime] datetime NULL,
    [logon] varchar(80) NULL,
    [statusText] varchar(50) NULL,
    [excluded] bit NOT NULL,
);

GO

-- =============================================================================
-- dbo.component
-- =============================================================================
CREATE TABLE [dbo].[component] (

    [component_id] int NOT NULL,
    [app_server] varchar(20) NOT NULL,
    [name] varchar(50) NOT NULL,
    [library] varchar(200) NOT NULL,
    [class] varchar(100) NOT NULL,
    [method] varchar(50) NOT NULL,
    [runs_per_instance] smallint NOT NULL,
    [arg_1] varchar(100) NULL,
    [arg_2] varchar(100) NULL,
    [arg_3] varchar(100) NULL,
    [status] varchar(10) NOT NULL,
);

GO

-- =============================================================================
-- dbo.consumer
-- =============================================================================
CREATE TABLE [dbo].[consumer] (

    [consumer_id] uniqueidentifier NOT NULL,
    [created_date] datetime NOT NULL,
    [email] varchar(100) NOT NULL,
    [subscribed_to_campaign] bit NULL,
);

GO

-- =============================================================================
-- dbo.consumer_response_item
-- =============================================================================
CREATE TABLE [dbo].[consumer_response_item] (

    [consumer_response_item_id] int NOT NULL,
    [name] varchar(100) NOT NULL,
);

GO

-- =============================================================================
-- dbo.consumer_subscription_history
-- =============================================================================
CREATE TABLE [dbo].[consumer_subscription_history] (

    [consumer_subscription_history_id] uniqueidentifier NOT NULL,
    [consumer_id] uniqueidentifier NOT NULL,
    [history_date] datetime NOT NULL,
    [type] varchar(50) NOT NULL,
    [description_1] varchar(900) NULL,
    [description_2] varchar(900) NULL,
    [description_3] varchar(MAX) NULL,
    [description_4] varchar(MAX) NULL,
    [created_date] datetime NOT NULL,
);

GO

-- =============================================================================
-- dbo.contact
-- =============================================================================
CREATE TABLE [dbo].[contact] (

    [contact_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [email] varchar(100) NOT NULL,
    [first] varchar(50) NULL,
    [last] varchar(50) NULL,
    [full_name] varchar(100) NULL,
    [title] varchar(100) NULL,
    [business_phone] varchar(20) NULL,
    [business_extension] varchar(10) NULL,
    [mobile_phone] varchar(20) NULL,
    [fax] varchar(20) NULL,
    [photo_url] varchar(500) NULL,
);

GO

-- =============================================================================
-- dbo.contact_schedule
-- =============================================================================
CREATE TABLE [dbo].[contact_schedule] (

    [id] int NOT NULL,
    [contact_id] int NOT NULL,
    [customer_id] int NULL,
    [Schedule] varchar(150) NOT NULL,
    [TimeZone] int NULL,
);

GO

-- =============================================================================
-- dbo.crm_response_item
-- =============================================================================
CREATE TABLE [dbo].[crm_response_item] (

    [crm_response_item_id] int NOT NULL,
    [name] varchar(100) NOT NULL,
);

GO

-- =============================================================================
-- dbo.customer
-- =============================================================================
CREATE TABLE [dbo].[customer] (

    [customer_id] int NOT NULL,
    [name] varchar(50) NOT NULL,
    [address_1] varchar(100) NULL,
    [address_2] varchar(100) NULL,
    [city] varchar(100) NULL,
    [state] varchar(2) NULL,
    [zip] varchar(10) NOT NULL,
    [country] varchar(3) NULL,
    [website] varchar(100) NULL,
    [status] varchar(10) NOT NULL,
    [customer_guid] uniqueidentifier NOT NULL,
    [last_updated_date] datetime NULL,
    [last_updated_by] varchar(128) NULL,
    [top_alias_number] int NULL,
    [reseller_id] int NOT NULL,
    [AccountId] int NULL,
    [ClientId] uniqueidentifier NULL,
    [NewClientId] int NULL,
);

GO

-- =============================================================================
-- dbo.customer_billing_group
-- =============================================================================
CREATE TABLE [dbo].[customer_billing_group] (

    [customer_billing_group_id] int NOT NULL,
    [billing_cycle] datetime NOT NULL,
    [fee_structure] varchar(20) NOT NULL,
);

GO

-- =============================================================================
-- dbo.customer_billing_group_invoice
-- =============================================================================
CREATE TABLE [dbo].[customer_billing_group_invoice] (

    [customer_billing_group_invoice_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [customer_billing_group_id] int NOT NULL,
    [billing_period_start] datetime NOT NULL,
    [billing_period_end] datetime NOT NULL,
    [invoice_number] varchar(20) NOT NULL,
    [billing_group_name] varchar(50) NOT NULL,
);

GO

-- =============================================================================
-- dbo.customer_billing_group_invoice_detail
-- =============================================================================
CREATE TABLE [dbo].[customer_billing_group_invoice_detail] (

    [customer_billing_group_invoice_detail_id] bigint NOT NULL,
    [customer_billing_group_invoice_id] int NOT NULL,
    [product_id] int NOT NULL,
    [txn_id] uniqueidentifier NOT NULL,
    [txn_date] datetime NOT NULL,
    [lead_number] bigint NOT NULL,
    [first] varchar(50) NULL,
    [last] varchar(50) NULL,
    [email] varchar(100) NOT NULL,
    [list_price] money NOT NULL,
    [final_price] money NOT NULL,
    [non_billable_type] varchar(20) NULL,
    [txn_sub_id] uniqueidentifier NOT NULL,
    [franchise_id] int NOT NULL,
    [txn_status] varchar(30) NOT NULL,
    [lp_make] varchar(50) NULL,
    [lp_year] varchar(10) NULL,
    [lp_model] varchar(100) NULL,
    [lp_trim] varchar(200) NULL,
    [alias_1] int NOT NULL,
    [alias_2] int NOT NULL,
    [home_phone] varchar(20) NULL,
    [customer_id] int NOT NULL,
    [matched_vehicle_id] int NULL,
    [matched_make] varchar(50) NULL,
    [matched_year] varchar(10) NULL,
    [matched_model] varchar(100) NULL,
    [matched_trim] varchar(200) NULL,
    [product_class] varchar(20) NULL,
);

GO

-- =============================================================================
-- dbo.customer_contact
-- =============================================================================
CREATE TABLE [dbo].[customer_contact] (

    [customer_contact_id] int NOT NULL,
    [customer_id] int NOT NULL,
    [contact_id] int NOT NULL,
    [type] varchar(30) NOT NULL,
    [created_date] datetime NOT NULL,
    [customer_contact_number] smallint NOT NULL,
    [crm_lead_forwarding_email] varchar(500) NULL,
    [external_id] varchar(50) NULL,
);

GO

-- =============================================================================
-- dbo.customer_group
-- =============================================================================
CREATE TABLE [dbo].[customer_group] (

    [customer_group_id] int NOT NULL,
    [type] varchar(20) NOT NULL,
    [name] varchar(50) NOT NULL,
    [address_1] varchar(100) NULL,
    [address_2] varchar(100) NULL,
    [city] varchar(100) NULL,
    [state] varchar(2) NULL,
    [zip] varchar(10) NULL,
    [country] varchar(3) NULL,
    [status] varchar(10) NOT NULL,
    [customer_group_guid] uniqueidentifier NOT NULL,
);

GO

-- =============================================================================
-- dbo.customer_group_contact
-- =============================================================================
CREATE TABLE [dbo].[customer_group_contact] (

    [customer_group_contact_id] int NOT NULL,
    [customer_group_id] int NOT NULL,
    [contact_id] int NOT NULL,
    [type] varchar(10) NOT NULL,
    [created_date] datetime NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
);

GO

-- =============================================================================
-- dbo.customer_group_detail
-- =============================================================================
CREATE TABLE [dbo].[customer_group_detail] (

    [customer_group_detail_id] int NOT NULL,
    [customer_group_id] int NOT NULL,
    [customer_id] int NOT NULL,
);

GO

-- =============================================================================
-- dbo.customer_homenet_sale_rooftop
-- =============================================================================
CREATE TABLE [dbo].[customer_homenet_sale_rooftop] (

    [customer_homenet_sale_rooftop_id] int NOT NULL,
    [rooftop_name] varchar(100) NOT NULL,
    [customer_id] int NOT NULL,
);

GO

-- =============================================================================
-- dbo.customer_inventory_calculated
-- =============================================================================
CREATE TABLE [dbo].[customer_inventory_calculated] (

    [customer_inventory_calculated_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [customer_id] int NOT NULL,
    [type] varchar(10) NOT NULL,
    [vin] varchar(20) NULL,
    [stock_number] varchar(20) NULL,
    [year] varchar(10) NULL,
    [make] varchar(50) NULL,
    [model] varchar(100) NULL,
    [trim] varchar(200) NULL,
    [manufacturer_code] varchar(30) NULL,
    [vehicle_id] int NULL,
    [date_in_stock] datetime NULL,
    [body_style] varchar(50) NULL,
    [mileage] varchar(110) NULL,
    [invoice] money NULL,
    [msrp] money NULL,
    [final_price_money] money NULL,
    [final_price_display] varchar(50) NULL,
    [cash_back] money NULL,
    [cash_back_expiration_date] datetime NULL,
    [incentive_rate_36] real NULL,
    [incentive_rate_48] real NULL,
    [incentive_rate_60] real NULL,
    [incentive_rate_72] real NULL,
    [incentive_expiration_date] datetime NULL,
);

GO

-- =============================================================================
-- dbo.customer_inventory_calculated_ex
-- =============================================================================
CREATE TABLE [dbo].[customer_inventory_calculated_ex] (

    [customer_inventory_calculated_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [customer_id] int NOT NULL,
    [type] varchar(10) NOT NULL,
    [vin] varchar(20) NULL,
    [stock_number] varchar(20) NULL,
    [year] varchar(10) NULL,
    [make] varchar(50) NULL,
    [model] varchar(100) NULL,
    [trim] varchar(200) NULL,
    [manufacturer_code] varchar(30) NULL,
    [vehicle_id] int NULL,
    [date_in_stock] datetime NULL,
    [body_style] varchar(50) NULL,
    [mileage] varchar(110) NULL,
    [invoice] money NULL,
    [msrp] money NULL,
    [final_price_money] money NULL,
    [final_price_display] varchar(50) NULL,
);

GO

-- =============================================================================
-- dbo.customer_inventory_copy
-- =============================================================================
CREATE TABLE [dbo].[customer_inventory_copy] (

    [customer_inventory_copy_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [copy_from_customer_id] int NOT NULL,
    [copy_to_customer_id] int NOT NULL,
    [type] varchar(20) NOT NULL,
    [copy_only_related_new_inventory] bit NOT NULL,
);

GO

-- =============================================================================
-- dbo.customer_inventory_source
-- =============================================================================
CREATE TABLE [dbo].[customer_inventory_source] (

    [customer_inventory_source_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [customer_id] int NOT NULL,
    [source] varchar(50) NOT NULL,
    [source_reference] varchar(100) NOT NULL,
    [status] varchar(20) NOT NULL,
    [import_only_related_new_inventory] bit NOT NULL,
    [customer_inventory_source_guid] uniqueidentifier NOT NULL,
    [quoted_price_mapped_column_new] varchar(30) NOT NULL,
    [quoted_price_mapped_column_used] varchar(30) NOT NULL,
    [msrp_mapped_column] varchar(30) NOT NULL,
    [book_value_mapped_column] varchar(30) NOT NULL,
    [auto_mapped] bit NULL,
);

GO

-- =============================================================================
-- dbo.customer_inventory_source_map
-- =============================================================================
CREATE TABLE [dbo].[customer_inventory_source_map] (

    [customer_inventory_source_map_guid] uniqueidentifier NOT NULL,
    [reason] varchar(50) NOT NULL,
    [source] varchar(50) NOT NULL,
    [source_reference] varchar(100) NOT NULL,
    [date_added] datetime NULL,
);

GO

-- =============================================================================
-- dbo.customer_rapid_touch
-- =============================================================================
CREATE TABLE [dbo].[customer_rapid_touch] (

    [customer_rapid_touch_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [customer_id] int NOT NULL,
    [dme_customer_code] varchar(50) NULL,
    [max_phone_calls_per_month] smallint NULL,
    [minutes_delay_before_lead_sent_to_bdc] smallint NULL,
    [send_after_hours_email] bit NULL,
    [status] varchar(20) NOT NULL,
    [package] varchar(100) NULL,
    [free_phone_calls_expiration_date] datetime NULL,
    [next_month_package] varchar(100) NULL,
    [free_phone_calls_effective_date] datetime NULL,
    [call_next_day_after_hours] bit NOT NULL,
    [free_phone_calls] smallint NULL,
    [cancellation_request_date] datetime NULL,
    [cancellation_effective_date] datetime NULL,
);

GO

-- =============================================================================
-- dbo.customer_rapid_touch_up_schedule
-- =============================================================================
CREATE TABLE [dbo].[customer_rapid_touch_up_schedule] (

    [customer_rapid_touch_up_schedule_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [customer_rapid_touch_id] int NOT NULL,
    [day_of_week] smallint NULL,
    [start_time] datetime NOT NULL,
    [end_time] datetime NOT NULL,
    [type] varchar(20) NOT NULL,
    [action] varchar(50) NOT NULL,
);

GO

-- =============================================================================
-- dbo.D1Trim
-- =============================================================================
CREATE TABLE [dbo].[D1Trim] (

    [id] int NOT NULL,
    [Created] datetime NOT NULL,
    [Updated] datetime NULL,
    [TrimId] int NOT NULL,
    [Market] varchar(20) NOT NULL,
    [SampleVIN] varchar(20) NULL,
    [HashCode] varchar(64) NULL,
    [TrimNameOverride] varchar(128) NULL,
    [ACode] char(13) NULL,
    [ACodeType] tinyint NULL,
    [MapType] tinyint NULL,
    [vehicle_id] int NULL,
    [ModelNumber] varchar(40) NULL,
);

GO

-- =============================================================================
-- dbo.D1TrimUpdate
-- =============================================================================
CREATE TABLE [dbo].[D1TrimUpdate] (

    [id] int NOT NULL,
    [Created] datetime NOT NULL,
    [Reserved] datetime NULL,
    [VehicleId] int NOT NULL,
    [VIN] varchar(20) NULL,
    [Status] smallint NOT NULL,
    [Reprocessed] smallint NULL,
    [Info] varchar(256) NULL,
);

GO

-- =============================================================================
-- dbo.dealer_daily_incentive_rollup
-- =============================================================================
CREATE TABLE [dbo].[dealer_daily_incentive_rollup] (

    [dealer_daily_incentive_rollup_id] int NOT NULL,
    [model_id] int NOT NULL,
    [available_trim] varchar(1000) NULL,
    [cash_back] money NULL,
    [incentive_24] varchar(50) NULL,
    [incentive_36] varchar(50) NULL,
    [incentive_48] varchar(50) NULL,
    [incentive_60] varchar(50) NULL,
    [incentive_expiration_date] datetime NULL,
);

GO

-- =============================================================================
-- dbo.dealer_daily_model
-- =============================================================================
CREATE TABLE [dbo].[dealer_daily_model] (

    [model_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [make_id] int NOT NULL,
    [model_number] varchar(10) NULL,
    [year] varchar(4) NOT NULL,
    [name] varchar(50) NOT NULL,
    [model_image_html] varchar(500) NOT NULL,
    [status] varchar(20) NOT NULL,
);

GO

-- =============================================================================
-- dbo.dealer_daily_vehicle
-- =============================================================================
CREATE TABLE [dbo].[dealer_daily_vehicle] (

    [vehicle_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [model_id] int NOT NULL,
    [vehicle_number] varchar(10) NOT NULL,
    [name] varchar(100) NOT NULL,
    [trim] varchar(100) NOT NULL,
    [vin] varchar(20) NULL,
    [stock_number] varchar(20) NULL,
    [rank] varchar(10) NULL,
    [invoice] money NULL,
    [msrp] money NULL,
    [cash_back] money NULL,
    [incentive_rate_24] real NULL,
    [incentive_rate_36] real NULL,
    [incentive_rate_48] real NULL,
    [incentive_rate_60] real NULL,
    [incentive_expiration_date] datetime NULL,
    [exterior_color] varchar(100) NULL,
    [interior_color] varchar(100) NULL,
    [exterior_color_code] varchar(10) NULL,
    [interior_color_code] varchar(10) NULL,
    [days_in_stock] int NULL,
    [dealer_trade] varchar(1) NULL,
    [rental_car] varchar(1) NULL,
    [damage_indicator] varchar(1) NULL,
    [pdi] varchar(1) NULL,
    [vehicle_option] xml NULL,
    [status] varchar(30) NOT NULL,
);

GO

-- =============================================================================
-- dbo.dealer_sf
-- =============================================================================
CREATE TABLE [dbo].[dealer_sf] (

    [dealer_sf_id] int NOT NULL,
    [zip] varchar(10) NULL,
    [name] varchar(1000) NULL,
    [make] varchar(100) NULL,
    [dealer_id] int NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [dealer_last_updated_date] datetime NULL,
    [address_1] varchar(1000) NULL,
    [address_2] varchar(500) NULL,
    [city] varchar(1000) NULL,
    [state] varchar(2) NULL,
    [country] varchar(10) NULL,
    [phone] varchar(20) NULL,
    [website] varchar(100) NULL,
    [first_name] varchar(100) NULL,
    [last_name] varchar(100) NULL,
    [title] varchar(100) NULL,
    [metro_area] varchar(1000) NULL,
    [county] varchar(100) NULL,
    [dma] varchar(100) NULL,
    [source] varchar(100) NULL,
);

GO

-- =============================================================================
-- dbo.dealer_track
-- =============================================================================
CREATE TABLE [dbo].[dealer_track] (

    [id] int NOT NULL,
    [customer_id] int NOT NULL,
    [dealer_track_id] int NULL,
    [new_vehicles] bit NULL,
    [used_vehicles] bit NULL,
    [status] int NOT NULL,
    [processed] bit NOT NULL,
    [provisioned] datetime NULL,
    [activated] datetime NULL,
    [use_cox_payment_services] bit NOT NULL,
);

GO

-- =============================================================================
-- dbo.dynamic_view_sys
-- =============================================================================
CREATE TABLE [dbo].[dynamic_view_sys] (

    [dynamic_view_sys_id] int NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [dynamic_view_name] varchar(100) NULL,
    [context] varchar(100) NULL,
    [type] varchar(50) NULL,
    [name] varchar(100) NULL,
    [value_1] varchar(MAX) NULL,
    [value_2] varchar(MAX) NULL,
    [value_3] varchar(MAX) NULL,
    [validation] varchar(1000) NULL,
    [watermark] varchar(100) NULL,
    [help] varchar(MAX) NULL,
    [tool_tip] varchar(1000) NULL,
    [is_read_only] bit NOT NULL,
    [is_hidden] bit NOT NULL,
    [is_required] bit NOT NULL,
    [is_insert_key] bit NOT NULL,
    [width] smallint NOT NULL,
);

GO

-- =============================================================================
-- dbo.email_template
-- =============================================================================
CREATE TABLE [dbo].[email_template] (

    [email_template_id] int NOT NULL,
    [name] varchar(100) NOT NULL,
    [subject] varchar(1000) NOT NULL,
    [body] varchar(MAX) NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [franchise_id] int NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [super_email_template_name] varchar(100) NOT NULL,
);

GO

-- =============================================================================
-- dbo.extranet_franchise_inventory_pricing_markup_audit_logs
-- =============================================================================
CREATE TABLE [dbo].[extranet_franchise_inventory_pricing_markup_audit_logs] (

    [id] int NOT NULL,
    [change_date] datetime NOT NULL,
    [logon] nvarchar(100) NOT NULL,
    [franchise_guid] uniqueidentifier NOT NULL,
    [vehicle_id] int NOT NULL,
    [quoted_price_markup] nvarchar(50) NULL,
    [final_price_markup] nvarchar(50) NULL,
    [msrp_markup] nvarchar(50) NULL,
    [quoted_price_markup_pct] nvarchar(50) NULL,
    [final_price_markup_pct] nvarchar(50) NULL,
    [msrp_markup_pct] nvarchar(50) NULL,
    [use_quoted_price] bit NULL,
    [call_for_price] bit NULL,
);

GO

-- =============================================================================
-- dbo.extranet_vehicle_pricing_audit_logs
-- =============================================================================
CREATE TABLE [dbo].[extranet_vehicle_pricing_audit_logs] (

    [id] int NOT NULL,
    [franchise_guid] uniqueidentifier NOT NULL,
    [vehicle_id] int NOT NULL,
    [date_changed] datetime NOT NULL,
    [user_email] nvarchar(255) NOT NULL,
    [field] varchar(25) NOT NULL,
    [old_value] varchar(50) NULL,
    [new_value] varchar(50) NULL,
);

GO

-- =============================================================================
-- dbo.extranet_vehicle_pricing_audit_logs_dev
-- =============================================================================
CREATE TABLE [dbo].[extranet_vehicle_pricing_audit_logs_dev] (

    [id] int NOT NULL,
    [franchise_id] int NOT NULL,
    [vehicle_id] int NOT NULL,
    [date_changed] datetime NOT NULL,
    [user_email] nvarchar(100) NOT NULL,
    [field] varchar(25) NOT NULL,
    [old_value] varchar(50) NULL,
    [new_value] varchar(50) NULL,
);

GO

-- =============================================================================
-- dbo.franchise
-- =============================================================================
CREATE TABLE [dbo].[franchise] (

    [franchise_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [customer_id] int NOT NULL,
    [alias_business_phone] varchar(20) NULL,
    [alias_mobile_phone] varchar(20) NULL,
    [lead_delivery_email] varchar(100) NULL,
    [status] varchar(50) NULL,
    [alias_consumer_phone] varchar(20) NULL,
    [alias_email_domain] varchar(100) NULL,
    [make_id] int NOT NULL,
    [business_phone] varchar(20) NULL,
    [lead_format] varchar(10) NOT NULL,
    [lead_crm] varchar(50) NULL,
    [multi_franchise_alias_creation] bit NOT NULL,
    [website] varchar(100) NULL,
    [greeting_consumer_phone] varchar(50) NULL,
    [franchise_guid] uniqueidentifier NOT NULL,
    [sales_force_url] varchar(100) NULL,
    [oem_vehicle_locator_logon] varchar(128) NULL,
    [oem_vehicle_locator_password] varchar(50) NULL,
    [oem_vehicle_locator_reference] varchar(50) NULL,
    [non_aliased_campaigning] bit NOT NULL,
    [campaigning_url] varchar(100) NULL,
    [status_reset_date] datetime NULL,
    [oem_franchise_code] varchar(20) NULL,
    [facebook_url] varchar(500) NULL,
    [twitter_url] varchar(500) NULL,
    [youtube_url] varchar(500) NULL,
    [send_quote_notification] bit NOT NULL,
    [product_class] varchar(20) NOT NULL,
    [send_no_quote_notification] bit NULL,
    [last_updated_date] datetime NULL,
    [last_updated_by] varchar(128) NULL,
    [send_quote_open_notification] bit NOT NULL,
    [send_smart_follow_activation_notification] bit NOT NULL,
    [send_quote_preview_notification] bit NOT NULL,
    [smart_quote_schedule] varchar(50) NOT NULL,
    [smart_quote_review_schedule] varchar(50) NOT NULL,
    [do_not_quote_non_quoting_hour_leads] bit NOT NULL,
    [do_not_follow_non_quoting_hour_leads] bit NOT NULL,
    [disable_price_edit] bit NOT NULL,
    [core_account_guid] uniqueidentifier NULL,
    [send_smart_follow_email_notification] bit NOT NULL,
    [smart_follow_sent_notification_api] bit NULL,
    [vdp_fallback_url] varchar(MAX) NULL,
    [reactivation_crm_lead_address] varchar(MAX) NULL,
);

GO

-- =============================================================================
-- dbo.franchise_announcement
-- =============================================================================
CREATE TABLE [dbo].[franchise_announcement] (

    [franchise_announcement_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [expiration_date] datetime NULL,
    [franchise_id] int NOT NULL,
    [type] varchar(10) NOT NULL,
    [announcement] varchar(2000) NOT NULL,
    [status] varchar(30) NOT NULL,
);

GO

-- =============================================================================
-- dbo.franchise_business_hour
-- =============================================================================
CREATE TABLE [dbo].[franchise_business_hour] (

    [franchise_business_hour_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [franchise_id] int NOT NULL,
    [day_of_week] smallint NOT NULL,
    [start_time] datetime NOT NULL,
    [end_time] datetime NOT NULL,
);

GO

-- =============================================================================
-- dbo.franchise_campaign
-- =============================================================================
CREATE TABLE [dbo].[franchise_campaign] (

    [franchise_campaign_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [franchise_id] int NOT NULL,
    [type] varchar(30) NOT NULL,
    [status] varchar(10) NOT NULL,
);

GO

-- =============================================================================
-- dbo.franchise_campaign_action
-- =============================================================================
CREATE TABLE [dbo].[franchise_campaign_action] (

    [franchise_campaign_action_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [franchise_campaign_id] int NOT NULL,
    [type] varchar(20) NOT NULL,
    [name] varchar(50) NOT NULL,
    [rank] smallint NOT NULL,
    [trigger_on_lead_arrival] bit NOT NULL,
    [trigger_query] varchar(4000) NULL,
    [status] varchar(10) NOT NULL,
    [alternate_from_date] datetime NULL,
    [alternate_to_date] datetime NULL,
);

GO

-- =============================================================================
-- dbo.franchise_campaign_email
-- =============================================================================
CREATE TABLE [dbo].[franchise_campaign_email] (

    [franchise_campaign_action_id] int NOT NULL,
    [email_template_id] int NULL,
    [custom_query] varchar(4000) NULL,
    [email_from] varchar(100) NULL,
    [discard_duplicates] bit NOT NULL,
    [forward_email] varchar(500) NULL,
    [alternate_email_template_id] int NULL,
);

GO

-- =============================================================================
-- dbo.franchise_campaign_email_template
-- =============================================================================
CREATE TABLE [dbo].[franchise_campaign_email_template] (

    [franchise_campaign_email_template_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [franchise_id] int NOT NULL,
    [name] varchar(100) NOT NULL,
    [campaign_type] varchar(30) NOT NULL,
    [email_from] varchar(500) NULL,
    [subject] varchar(1000) NULL,
    [forward_email] varchar(500) NULL,
    [html_master_email_template_id] int NULL,
    [text_master_email_template_id] int NULL,
    [web_master_email_template_id] int NULL,
    [status] varchar(10) NOT NULL,
    [sms_master_email_template_id] int NULL,
);

GO

-- =============================================================================
-- dbo.franchise_campaign_email_template_item
-- =============================================================================
CREATE TABLE [dbo].[franchise_campaign_email_template_item] (

    [franchise_campaign_email_template_item_id] bigint NOT NULL,
    [created_date] datetime NOT NULL,
    [franchise_campaign_action_id] int NOT NULL,
    [name] varchar(100) NOT NULL,
    [value] varchar(MAX) NULL,
);

GO

-- =============================================================================
-- dbo.franchise_campaign_email_template_param
-- =============================================================================
CREATE TABLE [dbo].[franchise_campaign_email_template_param] (

    [franchise_campaign_email_template_param_id] int NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [franchise_campaign_email_template_id] int NOT NULL,
    [master_email_template_param_id] int NOT NULL,
    [value] varchar(MAX) NULL,
);

GO

-- =============================================================================
-- dbo.franchise_consumer
-- =============================================================================
CREATE TABLE [dbo].[franchise_consumer] (

    [id] int NOT NULL,
    [franchise_consumer_id] uniqueidentifier NOT NULL,
    [created_date] datetime NOT NULL,
    [franchise_id] int NOT NULL,
    [subscribed_to_all_campaigns] bit NOT NULL,
    [subscribed_to_smart_follow] bit NOT NULL,
    [first] varchar(50) NOT NULL,
    [last] varchar(50) NOT NULL,
    [address_1] varchar(100) NULL,
    [city] varchar(100) NULL,
    [state] varchar(2) NULL,
    [zip] varchar(10) NULL,
    [country] varchar(3) NOT NULL,
    [franchise_consumer_alias_id] bigint NULL,
    [franchise_rep_id] int NULL,
    [franchise_consumer_vehicle_id] bigint NULL,
    [is_generic_franchise_rep] bit NOT NULL,
    [franchise_reference] varchar(50) NULL,
    [subscribed_to_all_campaigns_txn_id] uniqueidentifier NULL,
    [pause_smart_follow_until_date] datetime NULL,
    [pause_smart_follow_txn_id] uniqueidentifier NULL,
    [smart_follow_txn_id] uniqueidentifier NULL,
    [last_contact_txn_id] uniqueidentifier NULL,
    [last_contact_date] datetime NULL,
    [status] varchar(30) NOT NULL,
    [consumer_purchased_txn_id] uniqueidentifier NULL,
    [consumer_purchased] bit NOT NULL,
    [franchise_rep_update_txn_id] uniqueidentifier NULL,
    [crm_reference] varchar(1000) NULL,
    [crm_reply_to] varchar(254) NULL,
    [crm_reply_from] varchar(254) NULL,
    [crm_reply_subject] varchar(200) NULL,
    [last_updated_date] datetime NULL,
    [last_updated_by] varchar(128) NULL,
);

GO

-- =============================================================================
-- dbo.franchise_consumer_alias
-- =============================================================================
CREATE TABLE [dbo].[franchise_consumer_alias] (

    [franchise_consumer_alias_id] bigint NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [franchise_id] int NOT NULL,
    [franchise_consumer_id] uniqueidentifier NOT NULL,
    [txn_id] uniqueidentifier NOT NULL,
    [alias_1] int NOT NULL,
    [alias_1_email] varchar(100) NOT NULL,
    [alias_2] int NOT NULL,
    [alias_2_email] varchar(100) NOT NULL,
    [email] varchar(100) NOT NULL,
    [phone_1] varchar(20) NULL,
    [phone_2] varchar(20) NULL,
    [phone_3] varchar(20) NULL,
);

GO

-- =============================================================================
-- dbo.franchise_consumer_txn
-- =============================================================================
CREATE TABLE [dbo].[franchise_consumer_txn] (

    [txn_id] uniqueidentifier NOT NULL,
    [franchise_consumer_id] uniqueidentifier NOT NULL,
    [created_date] datetime NOT NULL,
    [txn_date] datetime NOT NULL,
    [type] varchar(100) NOT NULL,
    [logon] varchar(128) NOT NULL,
    [alias_1] int NULL,
    [alias_2] int NULL,
    [description_1] varchar(900) NULL,
    [description_2] varchar(900) NULL,
    [description_3] varchar(MAX) NULL,
    [description_4] varchar(MAX) NULL,
    [status] varchar(20) NULL,
    [Id] int NOT NULL,
);

GO

-- =============================================================================
-- dbo.franchise_consumer_vehicle
-- =============================================================================
CREATE TABLE [dbo].[franchise_consumer_vehicle] (

    [franchise_consumer_vehicle_id] bigint NOT NULL,
    [created_date] datetime NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [franchise_consumer_id] uniqueidentifier NOT NULL,
    [txn_id] uniqueidentifier NULL,
    [type] varchar(10) NOT NULL,
    [vehicle_id] int NOT NULL,
    [make] varchar(50) NOT NULL,
    [year] varchar(10) NULL,
    [model] varchar(100) NULL,
    [trim] varchar(200) NULL,
    [vin] varchar(20) NULL,
    [stock_number] varchar(20) NULL,
    [new_vehicle_xml_url] varchar(1000) NULL,
    [used_vehicle_xml_url] varchar(1000) NULL,
);

GO

-- =============================================================================
-- dbo.franchise_dealer_track
-- =============================================================================
CREATE TABLE [dbo].[franchise_dealer_track] (

    [id] int NOT NULL,
    [franchise_id] int NOT NULL,
    [price_source] varchar(50) NULL,
    [display_flag] int NULL,
    [lease_price_source] varchar(50) NULL,
);

GO

-- =============================================================================
-- dbo.franchise_dmn_response_report
-- =============================================================================
CREATE TABLE [dbo].[franchise_dmn_response_report] (

    [franchise_dmn_response_report_id] int NOT NULL,
    [customer_id] int NOT NULL,
    [franchise_id] int NULL,
    [date_start] datetime NOT NULL,
    [date_end] datetime NOT NULL,
    [report_url] varchar(500) NOT NULL,
    [created_date] datetime NOT NULL,
);

GO

-- =============================================================================
-- dbo.franchise_email_template_param
-- =============================================================================
CREATE TABLE [dbo].[franchise_email_template_param] (

    [franchise_email_template_param_id] bigint NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [email_template_id] int NOT NULL,
    [name] varchar(100) NOT NULL,
    [value] varchar(MAX) NULL,
);

GO

-- =============================================================================
-- dbo.franchise_excluded_lead_sources
-- =============================================================================
CREATE TABLE [dbo].[franchise_excluded_lead_sources] (

    [id] int NOT NULL,
    [franchise_id] int NOT NULL,
    [lead_source] varchar(100) NOT NULL,
    [processing_action] varchar(50) NOT NULL,
    [date_created] datetime NOT NULL,
    [creator] varchar(50) NOT NULL,
);

GO

-- =============================================================================
-- dbo.franchise_excluded_lead_sources_deleted
-- =============================================================================
CREATE TABLE [dbo].[franchise_excluded_lead_sources_deleted] (

    [excluded_lead_source_id] int NOT NULL,
    [franchise_id] int NOT NULL,
    [lead_source] nvarchar(100) NOT NULL,
    [date_deleted] datetime NOT NULL,
    [deleter] nvarchar(50) NOT NULL,
);

GO

-- =============================================================================
-- dbo.franchise_excluded_lead_sources_papertrail
-- =============================================================================
CREATE TABLE [dbo].[franchise_excluded_lead_sources_papertrail] (

    [id] int NOT NULL,
    [excluded_lead_source_id] int NOT NULL,
    [before_source] varchar(100) NOT NULL,
    [after_source] varchar(100) NOT NULL,
    [before_processing_action] varchar(50) NOT NULL,
    [after_processing_action] varchar(50) NOT NULL,
    [modification_date] datetime NOT NULL,
    [modifier] varchar(50) NOT NULL,
);

GO

-- =============================================================================
-- dbo.franchise_excluded_lead_sources_settings
-- =============================================================================
CREATE TABLE [dbo].[franchise_excluded_lead_sources_settings] (

    [franchise_id] int NOT NULL,
    [only_quote_sources] bit NOT NULL,
    [only_quote_sources_processing_action] varchar(50) NOT NULL,
);

GO

-- =============================================================================
-- dbo.franchise_identifier
-- =============================================================================
CREATE TABLE [dbo].[franchise_identifier] (

    [franchise_identifier_id] int NOT NULL,
    [franchise_id] int NOT NULL,
    [identifier] varchar(100) NOT NULL,
);

GO

-- =============================================================================
-- dbo.franchise_image
-- =============================================================================
CREATE TABLE [dbo].[franchise_image] (

    [franchise_image_id] int NOT NULL,
    [franchise_id] int NOT NULL,
    [name] varchar(100) NOT NULL,
    [url] varchar(MAX) NULL,
    [value] varchar(MAX) NULL,
    [created_date] datetime NOT NULL,
);

GO

-- =============================================================================
-- dbo.franchise_inventory_pricing
-- =============================================================================
CREATE TABLE [dbo].[franchise_inventory_pricing] (

    [franchise_inventory_pricing_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [franchise_id] int NOT NULL,
    [vehicle_id] int NOT NULL,
    [use_quoted_price] bit NOT NULL,
    [quoted_price_markup] money NULL,
    [final_price_markup] money NULL,
    [msrp_markup] money NULL,
    [quoted_price_markup_pct] real NULL,
    [final_price_markup_pct] real NULL,
    [msrp_markup_pct] real NULL,
    [call_for_price] bit NOT NULL,
    [quote_lease_offer] bit NOT NULL,
    [lease_type] varchar(10) NOT NULL,
    [monthly_lease_amount] money NULL,
    [lease_down_payment] money NULL,
    [acquisition_fee] money NULL,
    [money_factor] real NULL,
    [residual_value_pct] real NULL,
    [residual_value_amount] money NULL,
    [rebate] money NULL,
    [annual_mileage] int NULL,
    [excess_mileage_fee] money NULL,
    [lease_offer_expiration_date] datetime NULL,
    [lease_term_months] smallint NULL,
    [lease_disclaimer] varchar(2000) NULL,
);

GO

-- =============================================================================
-- dbo.franchise_lead_provider
-- =============================================================================
CREATE TABLE [dbo].[franchise_lead_provider] (

    [franchise_lead_provider_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [franchise_id] int NOT NULL,
    [lead_provider_id] int NOT NULL,
    [status] varchar(20) NOT NULL,
);

GO

-- =============================================================================
-- dbo.franchise_logon
-- =============================================================================
CREATE TABLE [dbo].[franchise_logon] (

    [franchise_logon_id] int NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [franchise_id] int NOT NULL,
    [logon_id] int NOT NULL,
);

GO

-- =============================================================================
-- dbo.franchise_logon_group
-- =============================================================================
CREATE TABLE [dbo].[franchise_logon_group] (

    [franchise_logon_group_id] int NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [franchise_logon_id] int NOT NULL,
    [name] varchar(50) NOT NULL,
);

GO

-- =============================================================================
-- dbo.franchise_model_incentive_rollup
-- =============================================================================
CREATE TABLE [dbo].[franchise_model_incentive_rollup] (

    [franchise_model_incentive_rollup_id] int NOT NULL,
    [franchise_id] int NOT NULL,
    [model_id] int NOT NULL,
    [available_trim] varchar(2000) NULL,
    [cash_back] money NULL,
    [incentive_24] varchar(50) NULL,
    [incentive_36] varchar(50) NULL,
    [incentive_48] varchar(50) NULL,
    [incentive_60] varchar(50) NULL,
    [effective_start_date] datetime NULL,
    [effective_end_date] datetime NULL,
);

GO

-- =============================================================================
-- dbo.franchise_non_business_day
-- =============================================================================
CREATE TABLE [dbo].[franchise_non_business_day] (

    [franchise_non_business_day_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [franchise_id] int NOT NULL,
    [non_business_day] datetime NOT NULL,
);

GO

-- =============================================================================
-- dbo.franchise_options
-- =============================================================================
CREATE TABLE [dbo].[franchise_options] (

    [id] int NOT NULL,
    [franchise_id] int NOT NULL,
    [gm_chat_enabled] bit NULL,
    [gm_chat_customer_url] varchar(255) NULL,
    [no_inventory_quote_enabled] bit NULL,
    [no_gm_chat_in_work_hours] bit NULL,
    [service_lead_response] bit NULL,
    [auto_text_response] bit NULL,
    [manual_text_response] bit NULL,
    [capital_one_enabled] bit NULL,
    [capital_one_dealer_token] varchar(255) NULL,
    [capital_one_sf_enabled] bit NULL,
    [capital_one_sf_dealer_token] varchar(255) NULL,
    [stop_clock] bit NULL,
    [no_voi_no_quote_disabled] bit NOT NULL,
    [quotes_sent_per_vin_threshold] int NULL,
);

GO

-- =============================================================================
-- dbo.franchise_parse_lead
-- =============================================================================
CREATE TABLE [dbo].[franchise_parse_lead] (

    [franchise_parse_lead_id] int NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [franchise_id] int NOT NULL,
    [parse_lead_id] int NOT NULL,
    [processing_action] varchar(30) NOT NULL,
);

GO

-- =============================================================================
-- dbo.franchise_performance_report
-- =============================================================================
CREATE TABLE [dbo].[franchise_performance_report] (

    [franchise_performance_report_id] int NOT NULL,
    [customer_id] int NOT NULL,
    [franchise_id] int NULL,
    [last_updated] datetime NOT NULL,
    [lead_count] smallint NULL,
    [qualified_leads] int NULL,
    [pass_through_leads] smallint NULL,
    [crm_email_count] smallint NULL,
    [crm_emails_per_lead] real NULL,
    [crm_phone_count] smallint NULL,
    [crm_phones_per_lead] real NULL,
    [crm_phone_duration_avg] real NULL,
    [lead_delivery_to_crm_email_time_avg] real NULL,
    [lead_delivery_to_crm_phone_time_avg] real NULL,
    [leads_closed] smallint NULL,
    [leads_closed_alias_only] smallint NULL,
    [qualified_new_car_leads] int NULL,
    [qualified_used_car_leads] int NULL,
    [lead_delivery_to_crm_contact_time_avg] real NULL,
    [qualified_leads_contacted] int NULL,
    [qualified_new_car_leads_contacted] int NULL,
    [qualified_used_car_leads_contacted] int NULL,
    [report_date] datetime NOT NULL,
    [type] varchar(10) NOT NULL,
    [qualified_leads_contacted_in_30_mins] int NULL,
    [qualified_leads_contacted_in_30_to_120_mins] int NULL,
    [qualified_leads_contacted_in_120_to_480_mins] int NULL,
    [qualified_leads_contacted_in_over_480_mins] int NULL,
    [lead_delivery_to_crm_contact_time_median] real NULL,
    [lead_delivery_to_crm_email_time_median] real NULL,
    [lead_delivery_to_crm_phone_time_median] real NULL,
    [extranet_logon_count] smallint NULL,
    [extranet_price_update_count] smallint NULL,
    [crm_email_count_fct] smallint NULL,
    [crm_phone_count_fct] smallint NULL,
    [lead_delivery_to_crm_email_time_avg_fct] real NULL,
    [crm_phone_duration_avg_fct] real NULL,
    [lead_delivery_to_crm_phone_time_avg_fct] real NULL,
    [qualified_leads1] int NULL,
);

GO

-- =============================================================================
-- dbo.franchise_pixel_tracking
-- =============================================================================
CREATE TABLE [dbo].[franchise_pixel_tracking] (

    [franchise_pixel_tracking_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [franchise_id] int NOT NULL,
    [provider_name] varchar(50) NOT NULL,
    [provider_id] varchar(50) NOT NULL,
    [status] varchar(50) NOT NULL,
);

GO

-- =============================================================================
-- dbo.franchise_pl
-- =============================================================================
CREATE TABLE [dbo].[franchise_pl] (

    [franchise_pl_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [franchise_id] int NOT NULL,
    [site] varchar(100) NOT NULL,
    [name] varchar(100) NOT NULL,
    [value] varchar(MAX) NULL,
);

GO

-- =============================================================================
-- dbo.franchise_priceing
-- =============================================================================
CREATE TABLE [dbo].[franchise_priceing] (

    [id] int NOT NULL,
    [FranchiseId] int NOT NULL,
    [Direction] int NOT NULL,
    [Difference] money NULL,
    [TemplateId] int NULL,
    [IsActive] bit NOT NULL,
);

GO

-- =============================================================================
-- dbo.franchise_rapid_contact
-- =============================================================================
CREATE TABLE [dbo].[franchise_rapid_contact] (

    [franchise_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [gm_email_enabled] bit NOT NULL,
    [gm_customer_contact_id] int NULL,
    [initial_email_enabled] bit NOT NULL,
);

GO

-- =============================================================================
-- dbo.franchise_region
-- =============================================================================
CREATE TABLE [dbo].[franchise_region] (

    [franchise_region_id] uniqueidentifier NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [franchise_id] int NULL,
    [name] varchar(50) NOT NULL,
    [markup_adjustment] money NULL,
    [call_for_price] bit NULL,
    [created_date] datetime NOT NULL,
);

GO

-- =============================================================================
-- dbo.franchise_region_zip
-- =============================================================================
CREATE TABLE [dbo].[franchise_region_zip] (

    [franchise_region_zip_id] int NOT NULL,
    [franchise_region_id] uniqueidentifier NOT NULL,
    [zip] varchar(10) NOT NULL,
);

GO

-- =============================================================================
-- dbo.franchise_rep
-- =============================================================================
CREATE TABLE [dbo].[franchise_rep] (

    [franchise_rep_id] int NOT NULL,
    [franchise_id] int NOT NULL,
    [contact_id] int NOT NULL,
    [store] varchar(30) NULL,
    [email] varchar(100) NOT NULL,
    [full_name] varchar(100) NULL,
    [customer_contact_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [last_updated_date] datetime NULL,
    [last_updated_by] varchar(128) NULL,
    [send_rep_notification] bit NOT NULL,
);

GO

-- =============================================================================
-- dbo.franchise_rep_notification_subscriptions
-- =============================================================================
CREATE TABLE [dbo].[franchise_rep_notification_subscriptions] (

    [id] int NOT NULL,
    [description_short] nvarchar(50) NOT NULL,
    [description_long] nvarchar(500) NOT NULL,
);

GO

-- =============================================================================
-- dbo.franchise_rep_notifications
-- =============================================================================
CREATE TABLE [dbo].[franchise_rep_notifications] (

    [id] int NOT NULL,
    [franchise_rep_id] int NOT NULL,
    [subscription_id] int NOT NULL,
    [sms_enabled] bit NOT NULL,
);

GO

-- =============================================================================
-- dbo.franchise_responselogix_region
-- =============================================================================
CREATE TABLE [dbo].[franchise_responselogix_region] (

    [franchise_responselogix_region_id] int NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [franchise_id] int NOT NULL,
    [responselogix_region_id] int NOT NULL,
);

GO

-- =============================================================================
-- dbo.franchise_salesforce
-- =============================================================================
CREATE TABLE [dbo].[franchise_salesforce] (

    [franchise_id] int NOT NULL,
    [sf_id] varchar(18) NULL,
    [sf_old_id] varchar(18) NULL,
    [comments] varchar(50) NULL,
);

GO

-- =============================================================================
-- dbo.franchise_sample_data
-- =============================================================================
CREATE TABLE [dbo].[franchise_sample_data] (

    [franchise_sample_data_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [expiration_date] datetime NOT NULL,
    [franchise_id] int NOT NULL,
    [name] varchar(100) NOT NULL,
    [value] varchar(MAX) NOT NULL,
);

GO

-- =============================================================================
-- dbo.franchise_smart_facts
-- =============================================================================
CREATE TABLE [dbo].[franchise_smart_facts] (

    [franchise_smart_facts_id] uniqueidentifier NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [report_date] datetime NOT NULL,
    [type] varchar(10) NOT NULL,
    [customer_id] int NOT NULL,
    [franchise_id] int NULL,
    [is_processing] bit NOT NULL,
    [created_date] datetime NOT NULL,
    [last_report_status] varchar(100) NOT NULL,
    [report_name] varchar(255) NULL,
    [send_report_status] smallint NULL,
);

GO

-- =============================================================================
-- dbo.franchise_smart_follow_v3_campaign_settings
-- =============================================================================
CREATE TABLE [dbo].[franchise_smart_follow_v3_campaign_settings] (

    [franchise_id] int NOT NULL,
    [smart_follow_new] bit NOT NULL,
    [smart_follow_used] bit NOT NULL,
    [is_quote_opened_stop_requote] bit NULL,
);

GO

-- =============================================================================
-- dbo.franchise_smart_follow_v3_defaults
-- =============================================================================
CREATE TABLE [dbo].[franchise_smart_follow_v3_defaults] (

    [franchise_id] int NOT NULL,
    [template_values_id] uniqueidentifier NOT NULL,
);

GO

-- =============================================================================
-- dbo.franchise_smart_follow_v3_schedule
-- =============================================================================
CREATE TABLE [dbo].[franchise_smart_follow_v3_schedule] (

    [franchise_id] int NOT NULL,
    [day] int NOT NULL,
    [new_active] bit NOT NULL,
    [new_template_values_id] uniqueidentifier NULL,
    [new_delivery_method] nvarchar(20) NULL,
    [used_active] bit NOT NULL,
    [used_template_values_id] uniqueidentifier NULL,
    [used_delivery_method] nvarchar(20) NULL,
);

GO

-- =============================================================================
-- dbo.franchise_smart_follow_v3_settings
-- =============================================================================
CREATE TABLE [dbo].[franchise_smart_follow_v3_settings] (

    [franchise_id] int NOT NULL,
    [header_image_url] nvarchar(250) NULL,
    [header_image_redirect_url] nvarchar(250) NULL,
    [greeting_text] nvarchar(MAX) NULL,
    [intro_text] nvarchar(MAX) NULL,
    [outro_text] nvarchar(MAX) NULL,
    [signature_image_url_override] nvarchar(250) NULL,
    [signature_name_override] nvarchar(100) NULL,
    [signature_title_override] nvarchar(100) NULL,
    [signature_mobile_number_override] nvarchar(15) NULL,
    [signature_office_number_override] nvarchar(15) NULL,
    [signature_email_override] nvarchar(150) NULL,
    [signature_text_color_hex] nvarchar(10) NULL,
    [signature_accent_color_hex] nvarchar(10) NULL,
    [disclaimer_text] nvarchar(MAX) NULL,
    [border_color_hex] nvarchar(10) NULL,
    [link_color_hex] nvarchar(10) NULL,
    [link_visited_color_hex] nvarchar(10) NULL,
    [link_hover_color_hex] nvarchar(10) NULL,
    [link_active_color_hex] nvarchar(10) NULL,
    [button_color_hex] nvarchar(10) NULL,
    [button_text_color_hex] nvarchar(10) NULL,
);

GO

-- =============================================================================
-- dbo.franchise_smart_follow_v3_template_values
-- =============================================================================
CREATE TABLE [dbo].[franchise_smart_follow_v3_template_values] (

    [template_values_id] uniqueidentifier NOT NULL,
    [is_global] bit NOT NULL,
    [franchise_id] int NOT NULL,
    [name] nvarchar(100) NOT NULL,
    [subject] nvarchar(500) NULL,
    [created] datetime NOT NULL,
    [creator] nvarchar(150) NOT NULL,
    [header_image_url] nvarchar(250) NULL,
    [header_image_redirect_url] nvarchar(250) NULL,
    [greeting_text] nvarchar(MAX) NULL,
    [intro_text] nvarchar(MAX) NULL,
    [outro_text] nvarchar(MAX) NULL,
    [signature_image_url_override] nvarchar(250) NULL,
    [signature_name_override] nvarchar(100) NULL,
    [signature_title_override] nvarchar(100) NULL,
    [signature_mobile_number_override] nvarchar(15) NULL,
    [signature_office_number_override] nvarchar(15) NULL,
    [signature_email_override] nvarchar(150) NULL,
    [signature_text_color_hex] nvarchar(10) NULL,
    [signature_accent_color_hex] nvarchar(10) NULL,
    [disclaimer_text] nvarchar(MAX) NULL,
    [border_color_hex] nvarchar(10) NULL,
    [link_color_hex] nvarchar(10) NULL,
    [link_visited_color_hex] nvarchar(10) NULL,
    [link_hover_color_hex] nvarchar(10) NULL,
    [link_active_color_hex] nvarchar(10) NULL,
    [button_color_hex] nvarchar(10) NULL,
    [button_text_color_hex] nvarchar(10) NULL,
    [show_mobile_number] bit NULL,
);

GO

-- =============================================================================
-- dbo.franchise_sms_template_param
-- =============================================================================
CREATE TABLE [dbo].[franchise_sms_template_param] (

    [franchise_sms_template_param_id] int NOT NULL,
    [last_updated_date] datetime NULL,
    [last_updated_by] varchar(128) NULL,
    [email_template_id] int NULL,
    [name] varchar(100) NULL,
    [value] varchar(MAX) NULL,
);

GO

-- =============================================================================
-- dbo.franchise_subscription
-- =============================================================================
CREATE TABLE [dbo].[franchise_subscription] (

    [franchise_subscription_id] int NOT NULL,
    [franchise_id] int NOT NULL,
    [customer_contact_id] int NOT NULL,
    [email_format] varchar(10) NOT NULL,
    [subscription] varchar(50) NOT NULL,
);

GO

-- =============================================================================
-- dbo.franchise_up_schedule
-- =============================================================================
CREATE TABLE [dbo].[franchise_up_schedule] (

    [franchise_up_schedule_id] int NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [franchise_id] int NOT NULL,
    [day_of_week] smallint NULL,
    [start_time] datetime NOT NULL,
    [end_time] datetime NOT NULL,
    [do_not_quote] bit NULL,
    [do_not_follow] bit NULL,
);

GO

-- =============================================================================
-- dbo.franchise_vehicle
-- =============================================================================
CREATE TABLE [dbo].[franchise_vehicle] (

    [franchise_vehicle_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [franchise_id] int NOT NULL,
    [vehicle_id] int NOT NULL,
    [invoice_markup] money NULL,
    [msrp_markup] money NULL,
    [status] varchar(10) NOT NULL,
    [invoice] money NOT NULL,
    [msrp] money NOT NULL,
    [cash_back] money NULL,
    [incentive_rate_24] real NULL,
    [incentive_rate_36] real NULL,
    [incentive_rate_48] real NULL,
    [incentive_rate_60] real NULL,
    [incentive_expiration_date] datetime NULL,
    [invoice_markup_pct] real NULL,
    [msrp_markup_pct] real NULL,
    [quote_template] varchar(50) NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [incentive_rate_72] real NULL,
    [cash_back_override] money NULL,
    [incentive_rate_24_override] real NULL,
    [incentive_rate_36_override] real NULL,
    [incentive_rate_48_override] real NULL,
    [incentive_rate_60_override] real NULL,
    [incentive_rate_72_override] real NULL,
    [incentive_expiration_date_override] datetime NULL,
    [use_employee_price] bit NOT NULL,
    [incentive_effective_date_override] datetime NULL,
    [show_incentive_expiration_msg_until] datetime NULL,
    [cash_back_effective_date] datetime NULL,
    [cash_back_expiration_date] datetime NULL,
    [incentive_effective_date] datetime NULL,
    [cash_back_effective_date_override] datetime NULL,
    [cash_back_expiration_date_override] datetime NULL,
    [is_pinned] bit NOT NULL,
    [selection_url] varchar(500) NULL,
    [last_selection_date] datetime NULL,
);

GO

-- =============================================================================
-- dbo.franchise_vehicle_config_client
-- =============================================================================
CREATE TABLE [dbo].[franchise_vehicle_config_client] (

    [franchise_vehicle_config_client_id] int NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [franchise_id] int NOT NULL,
    [vehicle_config_client_id] uniqueidentifier NOT NULL,
    [fetches_interval_seconds] int NOT NULL,
    [vehicle_locator_type] varchar(50) NULL,
    [status] varchar(30) NULL,
    [search_parameter_xml] xml NULL,
    [responselogix_subregion_id] int NULL,
);

GO

-- =============================================================================
-- dbo.franchise_vehicle_default_pricing
-- =============================================================================
CREATE TABLE [dbo].[franchise_vehicle_default_pricing] (

    [franchise_vehicle_default_pricing_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [franchise_id] int NOT NULL,
    [invoice_markup] money NULL,
    [msrp_markup] money NULL,
    [invoice_markup_pct] real NULL,
    [msrp_markup_pct] real NULL,
    [call_for_price] bit NULL,
    [monthly_lease_amount] money NULL,
);

GO

-- =============================================================================
-- dbo.franchise_vehicle_map
-- =============================================================================
CREATE TABLE [dbo].[franchise_vehicle_map] (

    [franchise_vehicle_map_id] bigint NOT NULL,
    [created_date] datetime NOT NULL,
    [franchise_id] int NULL,
    [make] varchar(50) NOT NULL,
    [year] varchar(10) NOT NULL,
    [model] varchar(100) NOT NULL,
    [trim] varchar(200) NOT NULL,
    [mapped_vehicle_id] int NULL,
    [manual_match_count] smallint NOT NULL,
    [manual_match_last_updated] datetime NOT NULL,
    [status] varchar(10) NOT NULL,
);

GO

-- =============================================================================
-- dbo.franchise_vehicle_option
-- =============================================================================
CREATE TABLE [dbo].[franchise_vehicle_option] (

    [franchise_vehicle_option_id] bigint NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [franchise_id] int NOT NULL,
    [vehicle_id] int NOT NULL,
    [code] varchar(20) NOT NULL,
    [description] varchar(2000) NOT NULL,
    [display_level] smallint NOT NULL,
);

GO

-- =============================================================================
-- dbo.franchise_vehicle_pricing_2
-- =============================================================================
CREATE TABLE [dbo].[franchise_vehicle_pricing_2] (

    [franchise_vehicle_pricing_2_id] int NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [franchise_id] int NOT NULL,
    [vehicle_number] varchar(20) NOT NULL,
    [dealer_invoice] money NULL,
    [invoice_markup] money NULL,
    [msrp_markup] money NULL,
    [invoice_markup_pct] real NULL,
    [msrp_markup_pct] real NULL,
    [status] varchar(10) NOT NULL,
    [vehicle_id] int NOT NULL,
    [call_for_price] bit NULL,
    [monthly_lease_amount] money NULL,
    [is_default_pricing] bit NOT NULL,
    [lease_type] varchar(10) NULL,
    [lease_down_payment] money NULL,
    [acquisition_fee] money NULL,
    [money_factor] real NULL,
    [residual_value_pct] real NULL,
    [annual_mileage] int NULL,
    [excess_mileage_fee] money NULL,
    [lease_offer_expiration_date] datetime NULL,
    [lease_term_months] smallint NULL,
    [lease_disclaimer] varchar(2000) NULL,
    [quote_lease_offer] bit NULL,
    [rebate] money NULL,
    [residual_value_amount] money NULL,
    [last_updated_by] varchar(128) NULL,
);

GO

-- =============================================================================
-- dbo.franchise_vehicle_quote
-- =============================================================================
CREATE TABLE [dbo].[franchise_vehicle_quote] (

    [franchise_vehicle_quote_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [franchise_vehicle_id] int NOT NULL,
    [franchise_id] int NOT NULL,
    [source_vehicle_id] int NOT NULL,
    [vehicle_id] int NOT NULL,
    [vin] varchar(40) NULL,
    [ordinal] smallint NOT NULL,
    [invoice] money NOT NULL,
    [msrp] money NOT NULL,
    [dealer_invoice] money NULL,
    [cash_back] money NULL,
    [incentive_rate_24] real NULL,
    [incentive_rate_36] real NULL,
    [incentive_rate_48] real NULL,
    [incentive_rate_60] real NULL,
    [incentive_expiration_date] datetime NULL,
    [invoice_markup] money NULL,
    [msrp_markup] money NULL,
    [invoice_markup_pct] real NULL,
    [msrp_markup_pct] real NULL,
    [price_after_markup] money NULL,
    [final_price] money NULL,
    [status] varchar(20) NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [dealer_invoice_1] money NULL,
    [dealer_invoice_2] money NULL,
    [dealer_invoice_3] money NULL,
    [incentive_rate_72] real NULL,
    [invoice_markup_override] money NULL,
    [msrp_markup_override] money NULL,
    [invoice_markup_pct_override] real NULL,
    [msrp_markup_pct_override] real NULL,
    [cash_back_override] money NULL,
    [incentive_rate_24_override] real NULL,
    [incentive_rate_36_override] real NULL,
    [incentive_rate_48_override] real NULL,
    [incentive_rate_60_override] real NULL,
    [incentive_rate_72_override] real NULL,
    [incentive_expiration_date_override] datetime NULL,
    [incentive_effective_date_override] datetime NULL,
    [show_incentive_expiration_msg_until] datetime NULL,
    [cash_back_effective_date_override] datetime NULL,
    [cash_back_expiration_date_override] datetime NULL,
    [cash_back_effective_date] datetime NULL,
    [cash_back_expiration_date] datetime NULL,
    [incentive_effective_date] datetime NULL,
    [call_for_price_override] bit NULL,
    [monthly_lease_amount_override] money NULL,
    [call_for_price] bit NULL,
    [monthly_lease_amount] money NULL,
    [lease_down_payment] money NULL,
    [annual_mileage] int NULL,
    [excess_mileage_fee] money NULL,
    [lease_offer_expiration_date] datetime NULL,
    [lease_term_months] smallint NULL,
    [lease_disclaimer] varchar(2000) NULL,
);

GO

-- =============================================================================
-- dbo.franchise_vehicle_quote_option
-- =============================================================================
CREATE TABLE [dbo].[franchise_vehicle_quote_option] (

    [franchise_vehicle_quote_option_id] int NOT NULL,
    [franchise_vehicle_quote_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [option_code] varchar(10) NULL,
    [option_desc] varchar(2000) NULL,
    [status] varchar(10) NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
);

GO

-- =============================================================================
-- dbo.franchise_vehicle_test
-- =============================================================================
CREATE TABLE [dbo].[franchise_vehicle_test] (

    [franchise_vehicle_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [franchise_id] int NOT NULL,
    [vehicle_id] int NOT NULL,
    [invoice_markup] money NULL,
    [msrp_markup] money NULL,
    [status] varchar(10) NOT NULL,
    [invoice] money NOT NULL,
    [msrp] money NOT NULL,
    [cash_back] money NULL,
    [incentive_rate_24] real NULL,
    [incentive_rate_36] real NULL,
    [incentive_rate_48] real NULL,
    [incentive_rate_60] real NULL,
    [incentive_expiration_date] datetime NULL,
    [invoice_markup_pct] real NULL,
    [msrp_markup_pct] real NULL,
    [quote_template] varchar(50) NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [incentive_rate_72] real NULL,
    [cash_back_override] money NULL,
    [incentive_rate_24_override] real NULL,
    [incentive_rate_36_override] real NULL,
    [incentive_rate_48_override] real NULL,
    [incentive_rate_60_override] real NULL,
    [incentive_rate_72_override] real NULL,
    [incentive_expiration_date_override] datetime NULL,
    [use_employee_price] bit NOT NULL,
    [incentive_effective_date_override] datetime NULL,
    [show_incentive_expiration_msg_until] datetime NULL,
    [cash_back_effective_date] datetime NULL,
    [cash_back_expiration_date] datetime NULL,
    [incentive_effective_date] datetime NULL,
    [cash_back_effective_date_override] datetime NULL,
    [cash_back_expiration_date_override] datetime NULL,
    [is_pinned] bit NOT NULL,
    [selection_url] varchar(500) NULL,
    [last_selection_date] datetime NULL,
);

GO

-- =============================================================================
-- dbo.homenet_sale
-- =============================================================================
CREATE TABLE [dbo].[homenet_sale] (

    [homenet_sale_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [customer_id] int NOT NULL,
    [rooftop_name] varchar(110) NULL,
    [deal_number] varchar(110) NULL,
    [customer_number] varchar(110) NULL,
    [customer_first_name] varchar(110) NULL,
    [customer_last_name] varchar(110) NULL,
    [customer_home_phone] varchar(110) NULL,
    [customer_work_phone] varchar(110) NULL,
    [customer_cell_phone] varchar(110) NULL,
    [customer_email_address] varchar(110) NULL,
    [co_first_name] varchar(110) NULL,
    [co_last_name] varchar(110) NULL,
    [co_address] varchar(110) NULL,
    [co_home_phone] varchar(110) NULL,
    [co_work_phone] varchar(110) NULL,
    [entry_date] varchar(110) NULL,
    [deal_book_date] varchar(110) NULL,
    [vehicle_vin] varchar(110) NULL,
    [customer_comments] varchar(110) NULL,
    [status] varchar(10) NOT NULL,
    [close_date] varchar(110) NULL,
    [vehicle_make] varchar(50) NULL,
    [vehicle_year] varchar(10) NULL,
    [vehicle_type] varchar(10) NULL,
    [vehicle_model] varchar(110) NULL,
    [last_updated_date] datetime NULL,
    [last_updated_by_file] varchar(100) NULL,
);

GO

-- =============================================================================
-- dbo.job_posting
-- =============================================================================
CREATE TABLE [dbo].[job_posting] (

    [job_posting_id] int NOT NULL,
    [header] varchar(900) NOT NULL,
    [sub_header] varchar(1000) NULL,
    [release_date] datetime NOT NULL,
    [value] varchar(MAX) NOT NULL,
    [status] varchar(10) NOT NULL,
);

GO

-- =============================================================================
-- dbo.lead
-- =============================================================================
CREATE TABLE [dbo].[lead] (

    [lead_number] int NOT NULL,
    [lead_id] uniqueidentifier NOT NULL,
    [created_date] datetime NOT NULL,
    [lead_date] datetime NOT NULL,
    [lp_lead_number] varchar(100) NULL,
    [lp_lead_date] varchar(30) NULL,
    [first] varchar(50) NULL,
    [last] varchar(50) NULL,
    [email] varchar(100) NOT NULL,
    [home_phone] varchar(20) NULL,
    [mobile_phone] varchar(20) NULL,
    [address_1] varchar(100) NULL,
    [city] varchar(100) NULL,
    [state] varchar(2) NULL,
    [zip] varchar(10) NULL,
    [country] varchar(3) NOT NULL,
    [comments] varchar(1000) NULL,
    [contact_method] varchar(20) NULL,
    [best_time_to_call] varchar(20) NULL,
    [time_frame] varchar(30) NULL,
    [payment_method] varchar(20) NULL,
    [down_payment] varchar(10) NULL,
    [has_trade_in] bit NULL,
    [trade_in_make] varchar(50) NULL,
    [trade_in_model] varchar(50) NULL,
    [trade_in_year] varchar(4) NULL,
    [trade_in_mileage] varchar(6) NULL,
    [lp_customer_name] varchar(50) NULL,
    [lp_franchise_contact_name] varchar(50) NULL,
    [lp_franchise_email] varchar(100) NULL,
    [lp_make] varchar(50) NULL,
    [lp_year] varchar(10) NULL,
    [lp_model] varchar(100) NULL,
    [lp_trim] varchar(200) NULL,
    [lp_exterior_color] varchar(100) NULL,
    [lp_interior_color] varchar(100) NULL,
    [lp_vin] varchar(20) NULL,
    [lp_stock_number] varchar(20) NULL,
    [customer_id] int NOT NULL,
    [customer_name] varchar(50) NOT NULL,
    [franchise_id] int NULL,
    [franchise_email] varchar(100) NULL,
    [franchise_rep_name] varchar(50) NULL,
    [franchise_rep_title] varchar(100) NULL,
    [franchise_rep_business_phone] varchar(20) NULL,
    [franchise_rep_mobile_phone] varchar(20) NULL,
    [franchise_rep_photo_url] varchar(100) NULL,
    [lead_provider_id] int NULL,
    [lead_provider_name] varchar(50) NULL,
    [alias_email] varchar(100) NULL,
    [alias_home_phone] varchar(20) NULL,
    [alias_home_extension] varchar(10) NULL,
    [alias_mobile_phone] varchar(20) NULL,
    [alias_mobile_extension] varchar(10) NULL,
    [alias_franchise_email] varchar(100) NULL,
    [alias_franchise_rep_business_phone] varchar(20) NULL,
    [alias_franchise_rep_business_extension] varchar(10) NULL,
    [alias_franchise_rep_mobile_phone] varchar(20) NULL,
    [alias_franchise_rep_mobile_extension] varchar(10) NULL,
    [am_history_id] uniqueidentifier NULL,
    [am_vehicle_id_1] int NULL,
    [am_vehicle_id_2] int NULL,
    [mm_history_id] uniqueidentifier NULL,
    [mm_vehicle_id_1] int NULL,
    [mm_vehicle_id_2] int NULL,
    [is_pass] bit NULL,
    [last_contact_history_id] uniqueidentifier NULL,
    [last_contact_date] datetime NULL,
    [inactive_history_id] uniqueidentifier NULL,
    [inactive_status] varchar(30) NULL,
    [subscribed_to_campaign] bit NOT NULL,
    [lead_closed] bit NOT NULL,
    [status] varchar(30) NOT NULL,
    [franchise_rep_email] varchar(100) NULL,
    [type] varchar(10) NOT NULL,
    [franchise_rep_store] varchar(30) NULL,
    [next_contact_date] datetime NULL,
    [last_contact_sender_name] varchar(100) NULL,
    [last_contact_sender_email] varchar(100) NULL,
    [franchise_reference] varchar(50) NULL,
    [alias_franchise_rep_email] varchar(100) NULL,
    [is_generic_franchise_rep] bit NOT NULL,
    [comments_for_consumer] varchar(500) NULL,
    [comments_for_dealer] varchar(500) NULL,
    [comments_for_qa] varchar(500) NULL,
    [is_test] bit NOT NULL,
    [lp_customer_number] varchar(50) NULL,
    [lp_provider_service] varchar(100) NULL,
    [parse_lead_name] varchar(100) NULL,
    [document_name] varchar(1000) NULL,
    [lp_vehicle_option] varchar(MAX) NULL,
    [lp_prospect_id_source] varchar(100) NULL,
    [forwarding_source] varchar(20) NOT NULL,
    [crm_reference] varchar(1000) NULL,
    [crm_reply_to] varchar(254) NULL,
    [lead_consolidate_history_id] uniqueidentifier NULL,
    [lead_consolidate_sister_lead_id] uniqueidentifier NULL,
    [crm_reply_from] varchar(254) NULL,
    [crm_reply_subject] varchar(200) NULL,
    [lp_provider_name] varchar(1000) NULL,
    [lp_mileage] varchar(6) NULL,
    [lp_prospect_id] varchar(100) NULL,
);

GO

-- =============================================================================
-- dbo.lead_history
-- =============================================================================
CREATE TABLE [dbo].[lead_history] (

    [id] int NOT NULL,
    [lead_history_id] uniqueidentifier NOT NULL,
    [lead_id] uniqueidentifier NOT NULL,
    [history_date] datetime NOT NULL,
    [type] varchar(100) NOT NULL,
    [logon] varchar(50) NULL,
    [description_1] varchar(900) NULL,
    [description_2] varchar(900) NULL,
    [description_3] varchar(MAX) NULL,
    [description_4] varchar(MAX) NULL,
    [created_date] datetime NOT NULL,
);

GO

-- =============================================================================
-- dbo.lead_homenet_sale
-- =============================================================================
CREATE TABLE [dbo].[lead_homenet_sale] (

    [lead_homenet_sale_id] int NOT NULL,
    [lead_id] uniqueidentifier NOT NULL,
    [homenet_sale_id] int NOT NULL,
    [is_alias_join] bit NOT NULL,
);

GO

-- =============================================================================
-- dbo.lead_item
-- =============================================================================
CREATE TABLE [dbo].[lead_item] (

    [lead_item_id] int NOT NULL,
    [name] varchar(100) NOT NULL,
);

GO

-- =============================================================================
-- dbo.lead_provider
-- =============================================================================
CREATE TABLE [dbo].[lead_provider] (

    [lead_provider_id] int NOT NULL,
    [name] varchar(50) NOT NULL,
    [status] varchar(10) NOT NULL,
    [lead_format] varchar(10) NOT NULL,
    [lead_provider_guid] uniqueidentifier NOT NULL,
    [auth_data] varchar(32) NULL,
    [notify_flags] tinyint NULL,
    [last_updated_date] datetime NOT NULL,
);

GO

-- =============================================================================
-- dbo.lead_provider_contact
-- =============================================================================
CREATE TABLE [dbo].[lead_provider_contact] (

    [lead_provider_contact_id] int NOT NULL,
    [lead_provider_id] int NOT NULL,
    [contact_id] int NOT NULL,
    [type] varchar(10) NOT NULL,
    [status] varchar(10) NOT NULL,
);

GO

-- =============================================================================
-- dbo.lead_sms_history
-- =============================================================================
CREATE TABLE [dbo].[lead_sms_history] (

    [id] int NOT NULL,
    [lead_history_id] uniqueidentifier NOT NULL,
    [lead_id] uniqueidentifier NOT NULL,
    [history_date] datetime NOT NULL,
    [created_date] datetime NOT NULL,
    [direction] varchar(8) NOT NULL,
    [type] varchar(900) NULL,
    [content] varchar(900) NULL,
    [comment] varchar(MAX) NULL,
    [from] varchar(50) NULL,
    [to] varchar(50) NULL,
    [logon] varchar(50) NULL,
);

GO

-- =============================================================================
-- dbo.lead_test_email
-- =============================================================================
CREATE TABLE [dbo].[lead_test_email] (

    [lead_test_email_id] int NOT NULL,
    [email] varchar(100) NOT NULL,
);

GO

-- =============================================================================
-- dbo.lead_vehicle_option
-- =============================================================================
CREATE TABLE [dbo].[lead_vehicle_option] (

    [lead_vehicle_option_id] bigint NOT NULL,
    [created_date] datetime NOT NULL,
    [lead_id] uniqueidentifier NOT NULL,
    [manufacturer_code] varchar(20) NULL,
    [description] varchar(500) NOT NULL,
);

GO

-- =============================================================================
-- dbo.local_virtual_vehicle_config_client
-- =============================================================================
CREATE TABLE [dbo].[local_virtual_vehicle_config_client] (

    [virtual_vehicle_config_client_id] uniqueidentifier NOT NULL,
    [vehicle_locator_type] varchar(50) NOT NULL,
);

GO

-- =============================================================================
-- dbo.logix_monitor
-- =============================================================================
CREATE TABLE [dbo].[logix_monitor] (

    [logix_monitor_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [name] varchar(50) NOT NULL,
    [type] varchar(10) NOT NULL,
    [test_server] varchar(100) NULL,
    [test] varchar(1000) NOT NULL,
    [fail_if_present] varchar(100) NULL,
    [fail_if_not_present] varchar(100) NULL,
    [alert_from] varchar(100) NULL,
    [alert_to] varchar(1000) NULL,
    [alert_bcc] varchar(1000) NULL,
    [alert_subject] varchar(200) NULL,
    [alert_body] varchar(4000) NULL,
    [show_alert_body_only] bit NOT NULL,
    [status] varchar(10) NOT NULL,
);

GO

-- =============================================================================
-- dbo.logix_monitor_alert_recipient
-- =============================================================================
CREATE TABLE [dbo].[logix_monitor_alert_recipient] (

    [logix_monitor_alert_recipient_id] int NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [logix_monitor_id] int NOT NULL,
    [logix_monitor_recipient_id] int NOT NULL,
    [status] varchar(20) NOT NULL,
);

GO

-- =============================================================================
-- dbo.logix_monitor_recipient
-- =============================================================================
CREATE TABLE [dbo].[logix_monitor_recipient] (

    [logix_monitor_recipient_id] int NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [type] varchar(10) NOT NULL,
    [first] varchar(50) NOT NULL,
    [last] varchar(50) NOT NULL,
    [email] varchar(100) NOT NULL,
    [status] varchar(20) NOT NULL,
);

GO

-- =============================================================================
-- dbo.logix_monitor_schedule
-- =============================================================================
CREATE TABLE [dbo].[logix_monitor_schedule] (

    [logix_monitor_schedule_id] int NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [logix_monitor_id] int NOT NULL,
    [name] varchar(50) NOT NULL,
    [month_of_year] smallint NULL,
    [day_of_month] smallint NULL,
    [day_of_week] smallint NULL,
    [hour_of_day] smallint NULL,
    [minute_of_hour] smallint NULL,
    [status] varchar(10) NOT NULL,
);

GO

-- =============================================================================
-- dbo.logon
-- =============================================================================
CREATE TABLE [dbo].[logon] (

    [logon_id] int NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [contact_id] int NOT NULL,
    [password] varbinary NULL,
    [is_super_user] bit NOT NULL,
    [logon_guid] uniqueidentifier NOT NULL,
);

GO

-- =============================================================================
-- dbo.logon_group
-- =============================================================================
CREATE TABLE [dbo].[logon_group] (

    [logon_group_id] int NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [logon_id] int NOT NULL,
    [name] varchar(50) NOT NULL,
);

GO

-- =============================================================================
-- dbo.mailbox
-- =============================================================================
CREATE TABLE [dbo].[mailbox] (

    [id] int NOT NULL,
    [mailbox_id] uniqueidentifier NOT NULL,
    [created_date] datetime NOT NULL,
    [lifespan] int NOT NULL,
    [email_received_date] datetime NOT NULL,
    [email_from] varchar(100) NULL,
    [email_to] varchar(500) NULL,
    [email_cc] varchar(500) NULL,
    [subject] varchar(900) NULL,
    [raw_email] varchar(1) NULL,
    [server_name] varchar(20) NOT NULL,
    [type] varchar(50) NULL,
    [email_file] varchar(50) NOT NULL,
    [document_identity] varchar(100) NULL,
    [is_test] bit NOT NULL,
    [txn_id] varchar(100) NULL,
    [priority] smallint NULL,
    [raw_email_url] varchar(1000) NULL,
    [spam_weight] smallint NULL,
    [email_from_domain] varchar(100) NULL,
    [email_to_domain] varchar(100) NULL,
    [spam_header] varchar(500) NULL,
);

GO

-- =============================================================================
-- dbo.make
-- =============================================================================
CREATE TABLE [dbo].[make] (

    [make_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [name] varchar(50) NOT NULL,
    [plural] varchar(50) NOT NULL,
    [status] varchar(10) NOT NULL,
    [make] varchar(50) NOT NULL,
    [code] char(2) NULL,
);

GO

-- =============================================================================
-- dbo.master_email_template
-- =============================================================================
CREATE TABLE [dbo].[master_email_template] (

    [master_email_template_id] int NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [type] varchar(100) NOT NULL,
    [name] varchar(100) NOT NULL,
    [subject] varchar(1000) NOT NULL,
    [body] varchar(MAX) NOT NULL,
    [sample_url] varchar(1000) NULL,
    [version] int NOT NULL,
    [has_requested_vehicle] bit NOT NULL,
);

GO

-- =============================================================================
-- dbo.master_email_template_param
-- =============================================================================
CREATE TABLE [dbo].[master_email_template_param] (

    [master_email_template_param_id] int NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [master_email_template_id] int NOT NULL,
    [name] varchar(100) NOT NULL,
    [ordinal] smallint NOT NULL,
    [replace_type] varchar(20) NOT NULL,
    [default_value] varchar(MAX) NULL,
    [group_name] varchar(100) NULL,
    [list_values] varchar(1000) NULL,
);

GO

-- =============================================================================
-- dbo.matching_comment
-- =============================================================================
CREATE TABLE [dbo].[matching_comment] (

    [matching_comment_id] int NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [type] varchar(20) NOT NULL,
    [display_comment] varchar(100) NOT NULL,
    [comment] varchar(500) NOT NULL,
);

GO

-- =============================================================================
-- dbo.MessageQueue
-- =============================================================================
CREATE TABLE [dbo].[MessageQueue] (

    [MessageQueueId] int NOT NULL,
    [MessageBody] xml NOT NULL,
    [MessageSource] varchar(255) NOT NULL,
    [CreatedDate] datetime NOT NULL,
    [isProcessed] tinyint NOT NULL,
    [Reserved] datetime NULL,
    [Reprocessed] smallint NULL,
);

GO

-- =============================================================================
-- dbo.MessageQueueInUse
-- =============================================================================
CREATE TABLE [dbo].[MessageQueueInUse] (

    [MessageQueueInUseId] int NOT NULL,
    [MessageSource] varchar(255) NOT NULL,
    [CreatedDate] datetime NOT NULL,
);

GO

-- =============================================================================
-- dbo.model
-- =============================================================================
CREATE TABLE [dbo].[model] (

    [model_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [make_id] int NOT NULL,
    [status] varchar(10) NOT NULL,
    [year] varchar(10) NULL,
    [name] varchar(100) NOT NULL,
    [model] varchar(100) NOT NULL,
    [model_image_html] varchar(500) NULL,
);

GO

-- =============================================================================
-- dbo.ndr_code
-- =============================================================================
CREATE TABLE [dbo].[ndr_code] (

    [ndr_code_id] int NOT NULL,
    [code] varchar(10) NOT NULL,
    [description] varchar(500) NOT NULL,
    [action] varchar(20) NOT NULL,
    [description_ex] varchar(500) NOT NULL,
);

GO

-- =============================================================================
-- dbo.ndr_log
-- =============================================================================
CREATE TABLE [dbo].[ndr_log] (

    [ndr_log_id] bigint NOT NULL,
    [document_name] varchar(100) NULL,
    [email_received_date] datetime NULL,
    [email_from] varchar(100) NULL,
    [email_to] varchar(100) NULL,
    [email_subject] varchar(1000) NULL,
    [delivery_status] varchar(MAX) NULL,
    [final_recipient] varchar(100) NULL,
    [action] varchar(500) NULL,
    [ndr_code] varchar(10) NULL,
    [diagnostic_code] varchar(1000) NULL,
    [status] varchar(20) NOT NULL,
);

GO

-- =============================================================================
-- dbo.new_lead_delivery
-- =============================================================================
CREATE TABLE [dbo].[new_lead_delivery] (

    [new_lead_delivery_id] int NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [franchise_id] int NOT NULL,
    [forward_email] varchar(500) NOT NULL,
    [lead_format] varchar(50) NOT NULL,
    [swap_consumer_phone] bit NOT NULL,
    [swap_consumer_email] bit NOT NULL,
    [swap_franchise_phone] bit NOT NULL,
    [swap_franchise_email] bit NOT NULL,
    [include_original_phone] bit NOT NULL,
    [include_original_email] bit NOT NULL,
);

GO

-- =============================================================================
-- dbo.news_coverage
-- =============================================================================
CREATE TABLE [dbo].[news_coverage] (

    [news_coverage_id] int NOT NULL,
    [query_string_id] int NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [header] varchar(900) NOT NULL,
    [sub_header] varchar(1000) NULL,
    [release_date] datetime NOT NULL,
    [value] varchar(MAX) NOT NULL,
    [is_external_link] bit NULL,
    [status] varchar(10) NOT NULL,
);

GO

-- =============================================================================
-- dbo.oem_vehicle_locator_build
-- =============================================================================
CREATE TABLE [dbo].[oem_vehicle_locator_build] (

    [oem_vehicle_locator_build_id] uniqueidentifier NOT NULL,
    [last_summary_updated_date] datetime NULL,
    [last_updated_by_summary_file] varchar(255) NULL,
    [last_updated_by_detail_file] varchar(255) NULL,
    [vin] varchar(40) NOT NULL,
    [make] varchar(50) NOT NULL,
    [year] varchar(10) NOT NULL,
    [model] varchar(100) NOT NULL,
    [manufacturer_code] varchar(30) NOT NULL,
    [trim] varchar(200) NULL,
    [series] varchar(100) NULL,
    [engine] varchar(200) NULL,
    [transmission] varchar(200) NULL,
    [dealer_number] varchar(20) NULL,
    [dealer_name] varchar(100) NULL,
    [dealer_phone] varchar(20) NULL,
    [dealer_zip] varchar(10) NULL,
    [region_name] varchar(100) NULL,
    [msrp] money NULL,
    [dealer_invoice_1] money NULL,
    [dealer_invoice_2] money NULL,
    [dealer_invoice_3] money NULL,
    [order_number] varchar(30) NULL,
    [vehicle_option_code_list] varchar(MAX) NULL,
    [vehicle_option] xml NULL,
    [days_in_inventory] smallint NULL,
    [status] varchar(30) NOT NULL,
    [last_detail_updated_date] datetime NULL,
    [window_sticker_url] varchar(200) NULL,
    [additional_info] varchar(900) NULL,
    [order_code] varchar(30) NULL,
    [base_feature] varchar(900) NULL,
    [build_trim] varchar(200) NULL,
    [oem_build_number] varchar(40) NOT NULL,
);

GO

-- =============================================================================
-- dbo.oem_vehicle_locator_build_responselogix_region
-- =============================================================================
CREATE TABLE [dbo].[oem_vehicle_locator_build_responselogix_region] (

    [oem_vehicle_locator_build_responselogix_region_id] bigint NOT NULL,
    [last_summary_updated_date] datetime NOT NULL,
    [last_updated_by_summary_file] varchar(300) NOT NULL,
    [last_detail_updated_date] datetime NULL,
    [last_updated_by_detail_file] varchar(300) NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [last_updated_by_logon] varchar(50) NOT NULL,
    [oem_vehicle_locator_build_id] uniqueidentifier NOT NULL,
    [responselogix_region_id] int NOT NULL,
    [search_parameter_xml] xml NULL,
    [is_processing] bit NOT NULL,
    [status] varchar(30) NOT NULL,
    [distance_from_logon_dealer] int NULL,
    [next_detail_processing_date] datetime NULL,
    [oem_vehicle_locator_search_key_2_id] bigint NULL,
    [last_updated_by_franchise_vehicle_config_client_id] int NOT NULL,
    [oem_vehicle_locator_search_key_subregion_id] bigint NULL,
);

GO

-- =============================================================================
-- dbo.oem_vehicle_locator_search_key_1
-- =============================================================================
CREATE TABLE [dbo].[oem_vehicle_locator_search_key_1] (

    [oem_vehicle_locator_search_key_1_id] int NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [franchise_vehicle_config_client_id] int NOT NULL,
    [responselogix_region_id] int NOT NULL,
    [search_make] varchar(50) NOT NULL,
    [search_zip] varchar(10) NULL,
    [search_radius] smallint NULL,
    [search_area_code] varchar(3) NULL,
    [is_processing] bit NOT NULL,
    [status] varchar(10) NOT NULL,
    [next_processing_date] datetime NULL,
    [search_parameter_xml] xml NULL,
    [search_state] varchar(2) NULL,
);

GO

-- =============================================================================
-- dbo.oem_vehicle_locator_search_key_subregion
-- =============================================================================
CREATE TABLE [dbo].[oem_vehicle_locator_search_key_subregion] (

    [oem_vehicle_locator_search_key_subregion_id] bigint NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [last_processing_date] datetime NULL,
    [next_processing_date] datetime NULL,
    [last_updated_by_franchise_vehicle_config_client_id] int NOT NULL,
    [oem_vehicle_locator_search_key_1_id] int NOT NULL,
    [year] varchar(10) NOT NULL,
    [model] varchar(100) NULL,
    [manufacturer_code] varchar(30) NULL,
    [trim] varchar(200) NULL,
    [search_parameter_xml] xml NULL,
    [subregion_id] int NOT NULL,
    [is_processing] bit NOT NULL,
    [status] varchar(10) NOT NULL,
    [last_updated_by_file] varchar(300) NULL,
);

GO

-- =============================================================================
-- dbo.oem_vehicle_locator_subregion
-- =============================================================================
CREATE TABLE [dbo].[oem_vehicle_locator_subregion] (

    [oem_vehicle_locator_subregion_id] bigint NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by_file] varchar(300) NULL,
    [last_processing_date] datetime NULL,
    [next_processing_date] datetime NULL,
    [last_updated_by_franchise_vehicle_config_client_id] int NOT NULL,
    [responselogix_subregion_id] int NOT NULL,
    [year] varchar(10) NOT NULL,
    [model] varchar(100) NULL,
    [manufacturer_code] varchar(30) NULL,
    [trim] varchar(200) NULL,
    [search_parameter_xml] xml NULL,
    [is_processing] bit NOT NULL,
    [status] varchar(10) NOT NULL,
);

GO

-- =============================================================================
-- dbo.ou
-- =============================================================================
CREATE TABLE [dbo].[ou] (

    [ou_id] int NOT NULL,
    [created_date] datetime NOT NULL,
);

GO

-- =============================================================================
-- dbo.ou_audit_trail
-- =============================================================================
CREATE TABLE [dbo].[ou_audit_trail] (

    [ou_audit_trail_id] bigint NOT NULL,
    [created_date] datetime NOT NULL,
    [logon] varchar(50) NOT NULL,
    [table_name] varchar(100) NOT NULL,
    [ou_id] int NOT NULL,
    [field_name] varchar(100) NOT NULL,
    [old_value] varchar(MAX) NULL,
    [new_value] varchar(MAX) NULL,
    [related_value_1] varchar(1000) NULL,
    [related_value_2] varchar(1000) NULL,
    [related_value_3] varchar(1000) NULL,
    [is_insert] bit NOT NULL,
    [is_delete] bit NOT NULL,
    [ou_audit_trail_guid] uniqueidentifier NOT NULL,
);

GO

-- =============================================================================
-- dbo.ou_vehicle_audit_trail
-- =============================================================================
CREATE TABLE [dbo].[ou_vehicle_audit_trail] (

    [ou_vehicle_audit_trail_id] bigint NOT NULL,
    [created_date] datetime NOT NULL,
    [logon] varchar(50) NOT NULL,
    [table_name] varchar(100) NOT NULL,
    [ou_id] int NOT NULL,
    [vehicle_id] int NOT NULL,
    [field_name] varchar(100) NOT NULL,
    [old_value] varchar(MAX) NULL,
    [new_value] varchar(MAX) NULL,
    [related_value_1] varchar(1000) NULL,
    [related_value_2] varchar(1000) NULL,
    [related_value_3] varchar(1000) NULL,
    [is_insert] bit NOT NULL,
    [is_delete] bit NOT NULL,
    [ou_vehicle_audit_trail_guid] uniqueidentifier NOT NULL,
);

GO

-- =============================================================================
-- dbo.Packages
-- =============================================================================
CREATE TABLE [dbo].[Packages] (

    [Id] int NOT NULL,
    [CustomerId] int NOT NULL,
    [PackageName] varchar(200) NULL,
    [StartDate] datetime NULL,
    [CancellationDate] datetime NULL,
    [Status] varchar(50) NULL,
    [MRR] decimal(18,2) NULL,
);

GO

-- =============================================================================
-- dbo.parse_consumer_response
-- =============================================================================
CREATE TABLE [dbo].[parse_consumer_response] (

    [parse_consumer_response_id] int NOT NULL,
    [franchise_id] int NOT NULL,
    [name] varchar(100) NOT NULL,
    [type] varchar(20) NOT NULL,
);

GO

-- =============================================================================
-- dbo.parse_consumer_response_item_expression
-- =============================================================================
CREATE TABLE [dbo].[parse_consumer_response_item_expression] (

    [parse_consumer_response_item_expression_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [parse_consumer_response_id] int NOT NULL,
    [consumer_response_item_id] int NOT NULL,
    [scope] varchar(100) NOT NULL,
    [reg_ex] varchar(6000) NOT NULL,
    [replace_string] varchar(1000) NOT NULL,
    [status] varchar(10) NOT NULL,
    [ordinal] int NOT NULL,
);

GO

-- =============================================================================
-- dbo.parse_consumer_response_item_expression_translation
-- =============================================================================
CREATE TABLE [dbo].[parse_consumer_response_item_expression_translation] (

    [parse_consumer_response_item_expression_translation_id] int NOT NULL,
    [parse_consumer_response_item_expression_id] int NOT NULL,
    [from_value] varchar(2000) NOT NULL,
    [to_value] varchar(2000) NOT NULL,
);

GO

-- =============================================================================
-- dbo.parse_crm_response
-- =============================================================================
CREATE TABLE [dbo].[parse_crm_response] (

    [parse_crm_response_id] int NOT NULL,
    [franchise_id] int NOT NULL,
    [name] varchar(100) NOT NULL,
    [type] varchar(20) NOT NULL,
);

GO

-- =============================================================================
-- dbo.parse_crm_response_item_expression
-- =============================================================================
CREATE TABLE [dbo].[parse_crm_response_item_expression] (

    [parse_crm_response_item_expression_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [parse_crm_response_id] int NOT NULL,
    [crm_response_item_id] int NOT NULL,
    [scope] varchar(100) NOT NULL,
    [reg_ex] varchar(6000) NOT NULL,
    [replace_string] varchar(1000) NOT NULL,
    [status] varchar(10) NOT NULL,
    [ordinal] int NOT NULL,
);

GO

-- =============================================================================
-- dbo.parse_crm_response_item_expression_translation
-- =============================================================================
CREATE TABLE [dbo].[parse_crm_response_item_expression_translation] (

    [parse_crm_response_item_expression_translation_id] int NOT NULL,
    [parse_crm_response_item_expression_id] int NOT NULL,
    [from_value] varchar(2000) NOT NULL,
    [to_value] varchar(2000) NOT NULL,
);

GO

-- =============================================================================
-- dbo.parse_lead
-- =============================================================================
CREATE TABLE [dbo].[parse_lead] (

    [parse_lead_id] int NOT NULL,
    [name] varchar(100) NOT NULL,
    [type] varchar(20) NOT NULL,
    [lead_provider_id] int NOT NULL,
    [ordinal] smallint NOT NULL,
    [processing_action] varchar(30) NOT NULL,
    [description] varchar(1000) NULL,
);

GO

-- =============================================================================
-- dbo.parse_lead_item_expression
-- =============================================================================
CREATE TABLE [dbo].[parse_lead_item_expression] (

    [parse_lead_item_expression_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [parse_lead_id] int NOT NULL,
    [lead_item_id] int NOT NULL,
    [scope] varchar(100) NOT NULL,
    [reg_ex] varchar(6000) NOT NULL,
    [replace_string] varchar(1000) NOT NULL,
    [status] varchar(10) NOT NULL,
    [ordinal] int NOT NULL,
);

GO

-- =============================================================================
-- dbo.parse_lead_item_expression_translation
-- =============================================================================
CREATE TABLE [dbo].[parse_lead_item_expression_translation] (

    [parse_lead_item_expression_translation_id] int NOT NULL,
    [parse_lead_item_expression_id] int NOT NULL,
    [from_value] varchar(2000) NOT NULL,
    [to_value] varchar(2000) NOT NULL,
);

GO

-- =============================================================================
-- dbo.PaymentHistory
-- =============================================================================
CREATE TABLE [dbo].[PaymentHistory] (

    [id] int NOT NULL,
    [Created] datetime2 NOT NULL,
    [EventTime] datetime2 NOT NULL,
    [LeadId] uniqueidentifier NOT NULL,
    [VIN] varchar(20) NOT NULL,
    [Position] int NULL,
    [LookingFor] tinyint NOT NULL,
    [CreditScore] int NOT NULL,
    [EstFinance] decimal(18,2) NOT NULL,
    [EstLease] decimal(18,2) NOT NULL,
    [DownPayment] decimal(18,2) NULL,
    [TradeIn] decimal(18,2) NULL,
    [Months] int NOT NULL,
    [LeaseMiles] int NULL,
    [TotalIncentives] decimal(18,2) NULL,
    [NotificationSent] datetime2 NULL,
);

GO

-- =============================================================================
-- dbo.PaymentNotification
-- =============================================================================
CREATE TABLE [dbo].[PaymentNotification] (

    [id] int NOT NULL,
    [Created] datetime2 NOT NULL,
    [LeadId] uniqueidentifier NOT NULL,
    [VIN] varchar(20) NOT NULL,
    [Status] tinyint NULL,
    [Processed] datetime2 NULL,
    [Count] int NULL,
);

GO

-- =============================================================================
-- dbo.pbs_leads
-- =============================================================================
CREATE TABLE [dbo].[pbs_leads] (

    [id] int NOT NULL,
    [Created] datetime NOT NULL,
    [LeadDate] datetime NOT NULL,
    [ExternalId] uniqueidentifier NOT NULL,
    [First] varchar(50) NULL,
    [Last] varchar(50) NULL,
    [Email] varchar(50) NULL,
    [VIN] varchar(20) NULL,
    [Stock] varchar(30) NULL,
    [Notes] varchar(MAX) NULL,
    [LeadSource] varchar(80) NULL,
    [VendorId] varchar(6) NOT NULL,
    [Status] int NOT NULL,
    [LeadId] uniqueidentifier NULL,
);

GO

-- =============================================================================
-- dbo.pm_procedure
-- =============================================================================
CREATE TABLE [dbo].[pm_procedure] (

    [pm_procedure_id] int NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [procedure_name] sysname NOT NULL,
    [description] varchar(1000) NULL,
    [usage] xml NULL,
    [help] nvarchar(145) NOT NULL,
);

GO

-- =============================================================================
-- dbo.press_release
-- =============================================================================
CREATE TABLE [dbo].[press_release] (

    [press_release_id] int NOT NULL,
    [query_string_id] int NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [header] varchar(900) NOT NULL,
    [sub_header] varchar(1000) NULL,
    [release_date] datetime NOT NULL,
    [value] varchar(MAX) NOT NULL,
    [is_external_link] bit NULL,
    [status] varchar(10) NOT NULL,
);

GO

-- =============================================================================
-- dbo.process
-- =============================================================================
CREATE TABLE [dbo].[process] (

    [process_id] int NOT NULL,
    [name] varchar(50) NOT NULL,
    [value] varchar(MAX) NULL,
);

GO

-- =============================================================================
-- dbo.process_log
-- =============================================================================
CREATE TABLE [dbo].[process_log] (

    [process_log_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [type] varchar(10) NOT NULL,
    [server] varchar(100) NOT NULL,
    [component] varchar(100) NOT NULL,
    [subject] varchar(100) NOT NULL,
    [message_text] varchar(MAX) NULL,
    [message_xml] xml NULL,
    [txn_id_1] varchar(500) NULL,
    [txn_id_2] varchar(500) NULL,
    [txn_id_3] varchar(500) NULL,
    [txn_id_4] varchar(500) NULL,
    [txn_id_5] varchar(500) NULL,
    [retain_until_date] datetime NULL,
);

GO

-- =============================================================================
-- dbo.process_log_20260404T23
-- =============================================================================
CREATE TABLE [dbo].[process_log_20260404T23] (

    [process_log_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [type] varchar(10) NOT NULL,
    [server] varchar(100) NOT NULL,
    [component] varchar(100) NOT NULL,
    [subject] varchar(100) NOT NULL,
    [message_text] varchar(MAX) NULL,
    [message_xml] xml NULL,
    [txn_id_1] varchar(500) NULL,
    [txn_id_2] varchar(500) NULL,
    [txn_id_3] varchar(500) NULL,
    [txn_id_4] varchar(500) NULL,
    [txn_id_5] varchar(500) NULL,
    [retain_until_date] datetime NULL,
);

GO

-- =============================================================================
-- dbo.process_log_20260411T23
-- =============================================================================
CREATE TABLE [dbo].[process_log_20260411T23] (

    [process_log_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [type] varchar(10) NOT NULL,
    [server] varchar(100) NOT NULL,
    [component] varchar(100) NOT NULL,
    [subject] varchar(100) NOT NULL,
    [message_text] varchar(MAX) NULL,
    [message_xml] xml NULL,
    [txn_id_1] varchar(500) NULL,
    [txn_id_2] varchar(500) NULL,
    [txn_id_3] varchar(500) NULL,
    [txn_id_4] varchar(500) NULL,
    [txn_id_5] varchar(500) NULL,
    [retain_until_date] datetime NULL,
);

GO

-- =============================================================================
-- dbo.process_log_20260418T23
-- =============================================================================
CREATE TABLE [dbo].[process_log_20260418T23] (

    [process_log_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [type] varchar(10) NOT NULL,
    [server] varchar(100) NOT NULL,
    [component] varchar(100) NOT NULL,
    [subject] varchar(100) NOT NULL,
    [message_text] varchar(MAX) NULL,
    [message_xml] xml NULL,
    [txn_id_1] varchar(500) NULL,
    [txn_id_2] varchar(500) NULL,
    [txn_id_3] varchar(500) NULL,
    [txn_id_4] varchar(500) NULL,
    [txn_id_5] varchar(500) NULL,
    [retain_until_date] datetime NULL,
);

GO

-- =============================================================================
-- dbo.process_log_20260425T23
-- =============================================================================
CREATE TABLE [dbo].[process_log_20260425T23] (

    [process_log_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [type] varchar(10) NOT NULL,
    [server] varchar(100) NOT NULL,
    [component] varchar(100) NOT NULL,
    [subject] varchar(100) NOT NULL,
    [message_text] varchar(MAX) NULL,
    [message_xml] xml NULL,
    [txn_id_1] varchar(500) NULL,
    [txn_id_2] varchar(500) NULL,
    [txn_id_3] varchar(500) NULL,
    [txn_id_4] varchar(500) NULL,
    [txn_id_5] varchar(500) NULL,
    [retain_until_date] datetime NULL,
);

GO

-- =============================================================================
-- dbo.process_log_20260502T23
-- =============================================================================
CREATE TABLE [dbo].[process_log_20260502T23] (

    [process_log_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [type] varchar(10) NOT NULL,
    [server] varchar(100) NOT NULL,
    [component] varchar(100) NOT NULL,
    [subject] varchar(100) NOT NULL,
    [message_text] varchar(MAX) NULL,
    [message_xml] xml NULL,
    [txn_id_1] varchar(500) NULL,
    [txn_id_2] varchar(500) NULL,
    [txn_id_3] varchar(500) NULL,
    [txn_id_4] varchar(500) NULL,
    [txn_id_5] varchar(500) NULL,
    [retain_until_date] datetime NULL,
);

GO

-- =============================================================================
-- dbo.process_log_20260509T23
-- =============================================================================
CREATE TABLE [dbo].[process_log_20260509T23] (

    [process_log_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [type] varchar(10) NOT NULL,
    [server] varchar(100) NOT NULL,
    [component] varchar(100) NOT NULL,
    [subject] varchar(100) NOT NULL,
    [message_text] varchar(MAX) NULL,
    [message_xml] xml NULL,
    [txn_id_1] varchar(500) NULL,
    [txn_id_2] varchar(500) NULL,
    [txn_id_3] varchar(500) NULL,
    [txn_id_4] varchar(500) NULL,
    [txn_id_5] varchar(500) NULL,
    [retain_until_date] datetime NULL,
);

GO

-- =============================================================================
-- dbo.process_log_20260516T23
-- =============================================================================
CREATE TABLE [dbo].[process_log_20260516T23] (

    [process_log_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [type] varchar(10) NOT NULL,
    [server] varchar(100) NOT NULL,
    [component] varchar(100) NOT NULL,
    [subject] varchar(100) NOT NULL,
    [message_text] varchar(MAX) NULL,
    [message_xml] xml NULL,
    [txn_id_1] varchar(500) NULL,
    [txn_id_2] varchar(500) NULL,
    [txn_id_3] varchar(500) NULL,
    [txn_id_4] varchar(500) NULL,
    [txn_id_5] varchar(500) NULL,
    [retain_until_date] datetime NULL,
);

GO

-- =============================================================================
-- dbo.process_log_20260523T23
-- =============================================================================
CREATE TABLE [dbo].[process_log_20260523T23] (

    [process_log_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [type] varchar(10) NOT NULL,
    [server] varchar(100) NOT NULL,
    [component] varchar(100) NOT NULL,
    [subject] varchar(100) NOT NULL,
    [message_text] varchar(MAX) NULL,
    [message_xml] xml NULL,
    [txn_id_1] varchar(500) NULL,
    [txn_id_2] varchar(500) NULL,
    [txn_id_3] varchar(500) NULL,
    [txn_id_4] varchar(500) NULL,
    [txn_id_5] varchar(500) NULL,
    [retain_until_date] datetime NULL,
);

GO

-- =============================================================================
-- dbo.process_log_20260530T23
-- =============================================================================
CREATE TABLE [dbo].[process_log_20260530T23] (

    [process_log_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [type] varchar(10) NOT NULL,
    [server] varchar(100) NOT NULL,
    [component] varchar(100) NOT NULL,
    [subject] varchar(100) NOT NULL,
    [message_text] varchar(MAX) NULL,
    [message_xml] xml NULL,
    [txn_id_1] varchar(500) NULL,
    [txn_id_2] varchar(500) NULL,
    [txn_id_3] varchar(500) NULL,
    [txn_id_4] varchar(500) NULL,
    [txn_id_5] varchar(500) NULL,
    [retain_until_date] datetime NULL,
);

GO

-- =============================================================================
-- dbo.process_log_20260606T23
-- =============================================================================
CREATE TABLE [dbo].[process_log_20260606T23] (

    [process_log_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [type] varchar(10) NOT NULL,
    [server] varchar(100) NOT NULL,
    [component] varchar(100) NOT NULL,
    [subject] varchar(100) NOT NULL,
    [message_text] varchar(MAX) NULL,
    [message_xml] xml NULL,
    [txn_id_1] varchar(500) NULL,
    [txn_id_2] varchar(500) NULL,
    [txn_id_3] varchar(500) NULL,
    [txn_id_4] varchar(500) NULL,
    [txn_id_5] varchar(500) NULL,
    [retain_until_date] datetime NULL,
);

GO

-- =============================================================================
-- dbo.process_log_20260613T23
-- =============================================================================
CREATE TABLE [dbo].[process_log_20260613T23] (

    [process_log_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [type] varchar(10) NOT NULL,
    [server] varchar(100) NOT NULL,
    [component] varchar(100) NOT NULL,
    [subject] varchar(100) NOT NULL,
    [message_text] varchar(MAX) NULL,
    [message_xml] xml NULL,
    [txn_id_1] varchar(500) NULL,
    [txn_id_2] varchar(500) NULL,
    [txn_id_3] varchar(500) NULL,
    [txn_id_4] varchar(500) NULL,
    [txn_id_5] varchar(500) NULL,
    [retain_until_date] datetime NULL,
);

GO

-- =============================================================================
-- dbo.ProcsInUse
-- =============================================================================
CREATE TABLE [dbo].[ProcsInUse] (

    [ProcsInUseId] int NOT NULL,
    [ProcedureName] varchar(100) NOT NULL,
    [CreatedDate] datetime NOT NULL,
);

GO

-- =============================================================================
-- dbo.product
-- =============================================================================
CREATE TABLE [dbo].[product] (

    [product_id] int NOT NULL,
    [name] varchar(50) NOT NULL,
    [status] varchar(10) NOT NULL,
);

GO

-- =============================================================================
-- dbo.queue_stat
-- =============================================================================
CREATE TABLE [dbo].[queue_stat] (

    [queue_stat_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [name] varchar(100) NULL,
    [is_receive_enabled] bit NULL,
    [is_activation_enabled] bit NULL,
    [activation_procedure] varchar(100) NULL,
    [message_count] int NULL,
    [full_message_count] int NULL,
    [min_created_date] datetime NULL,
    [max_created_date] datetime NULL,
);

GO

-- =============================================================================
-- dbo.QueueMonitorData
-- =============================================================================
CREATE TABLE [dbo].[QueueMonitorData] (

    [id] int NOT NULL,
    [Name] varchar(127) NOT NULL,
    [Descriprion] varchar(1024) NULL,
    [Threshold] int NOT NULL,
    [LastCount] int NULL,
    [LastChecked] datetime NOT NULL,
    [IssueStarted] datetime NULL,
    [IssueCycles] int NULL,
    [Iteration] int NOT NULL,
);

GO

-- =============================================================================
-- dbo.reactivation
-- =============================================================================
CREATE TABLE [dbo].[reactivation] (

    [id] int NOT NULL,
    [reactivation_id] uniqueidentifier NOT NULL,
    [created_date] datetime NOT NULL,
    [type] varchar(20) NOT NULL,
    [franchise_rep_id] int NULL,
    [franchise_rep_name] varchar(50) NULL,
    [franchise_rep_title] varchar(100) NULL,
    [franchise_rep_email] varchar(100) NULL,
    [is_generic_franchise_rep] bit NOT NULL,
    [franchise_reference] varchar(50) NULL,
    [email] varchar(100) NOT NULL,
    [home_phone] varchar(20) NULL,
    [mobile_phone] varchar(20) NULL,
    [alias_email] varchar(100) NULL,
    [alias_home_phone] varchar(20) NULL,
    [alias_home_extension] varchar(10) NULL,
    [alias_mobile_phone] varchar(20) NULL,
    [alias_mobile_extension] varchar(10) NULL,
    [vehicle_id] int NULL,
    [make] varchar(50) NULL,
    [year] varchar(10) NULL,
    [model] varchar(100) NULL,
    [trim] varchar(200) NULL,
    [vin] varchar(20) NULL,
    [stock_number] varchar(20) NULL,
    [category] varchar(100) NULL,
    [other_stated_interest] varchar(500) NULL,
    [next_step] varchar(500) NULL,
    [requested_appointment_day] varchar(20) NULL,
    [requested_appointment_time] varchar(20) NULL,
    [satisfaction_level] smallint NULL,
    [non_satisfaction_reason] varchar(50) NULL,
    [raw_email] varchar(MAX) NULL,
    [email_template_name] varchar(50) NULL,
    [is_billable] bit NOT NULL,
    [reactivation_date] datetime NOT NULL,
    [smart_follow_txn_id] uniqueidentifier NOT NULL,
    [non_billable_type] varchar(20) NULL,
    [non_billable_logon] varchar(128) NULL,
    [raw_email_url] varchar(1000) NULL,
);

GO

-- =============================================================================
-- dbo.redirect_email
-- =============================================================================
CREATE TABLE [dbo].[redirect_email] (

    [redirect_email_id] int NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [email_from] varchar(100) NULL,
    [email_to] varchar(100) NULL,
    [redirect_to] varchar(1000) NULL,
    [status] varchar(20) NOT NULL,
    [customer_id] int NULL,
);

GO

-- =============================================================================
-- dbo.resellers
-- =============================================================================
CREATE TABLE [dbo].[resellers] (

    [reseller_id] int NOT NULL,
    [reseller_name] varchar(255) NOT NULL,
    [reseller_name_img] varchar(MAX) NULL,
    [reseller_logo_img] varchar(MAX) NULL,
    [reseller_report_name] varchar(255) NULL,
    [reseller_contact_info] varchar(255) NULL,
    [TemplateName] varchar(80) NULL,
);

GO

-- =============================================================================
-- dbo.responselogix_region
-- =============================================================================
CREATE TABLE [dbo].[responselogix_region] (

    [responselogix_region_id] int NOT NULL,
    [name] varchar(100) NULL,
    [status] varchar(10) NOT NULL,
    [days_to_next_rebuild] smallint NOT NULL,
    [make_id] int NULL,
    [next_extraction_start_date] datetime NOT NULL,
    [created_date] datetime NOT NULL,
    [last_updated_date] datetime NULL,
    [last_updated_by] varchar(128) NULL,
    [is_processing] bit NOT NULL,
    [selection_algorithm_stage] varchar(50) NOT NULL,
    [last_export_date] datetime NULL,
    [last_extraction_start_date] datetime NULL,
);

GO

-- =============================================================================
-- dbo.responselogix_subregion
-- =============================================================================
CREATE TABLE [dbo].[responselogix_subregion] (

    [responselogix_subregion_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [responselogix_region_id] int NOT NULL,
    [subregion_number] int NOT NULL,
    [search_parameter_xml] xml NULL,
    [status] varchar(30) NOT NULL,
);

GO

-- =============================================================================
-- dbo.rl_lead_history_report_data
-- =============================================================================
CREATE TABLE [dbo].[rl_lead_history_report_data] (

    [id] int NOT NULL,
    [lead_id] uniqueidentifier NOT NULL,
    [history_date] datetime NOT NULL,
    [history_type] varchar(100) NOT NULL,
);

GO

-- =============================================================================
-- dbo.rl_performance_report_data
-- =============================================================================
CREATE TABLE [dbo].[rl_performance_report_data] (

    [id] int NOT NULL,
    [lead_id] uniqueidentifier NOT NULL,
    [lead_date] datetime NOT NULL,
    [customer_id] int NOT NULL,
    [dealer_name] varchar(100) NOT NULL,
    [lead_status] varchar(100) NOT NULL,
    [dealer_oem] varchar(50) NOT NULL,
    [email_address] varchar(100) NULL,
    [email_template_html_name] varchar(100) NULL,
    [lead_source] varchar(MAX) NULL,
);

GO

-- =============================================================================
-- dbo.sales_force_account
-- =============================================================================
CREATE TABLE [dbo].[sales_force_account] (

    [AccountId] int NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [name] varchar(500) NULL,
    [OwnerId] int NULL,
    [user_id] varchar(100) NULL,
    [id] varchar(100) NOT NULL,
    [zip] varchar(20) NULL,
    [account_manager_name] varchar(100) NULL,
    [websystem_url] varchar(500) NULL,
    [status] varchar(50) NULL,
    [status_stage] varchar(50) NULL,
    [rl_customer_id] int NULL,
);

GO

-- =============================================================================
-- dbo.sales_force_account_manager
-- =============================================================================
CREATE TABLE [dbo].[sales_force_account_manager] (

    [sales_force_account_manager_id] int NOT NULL,
    [user_id] varchar(100) NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [email] varchar(100) NOT NULL,
    [first] varchar(50) NULL,
    [last] varchar(50) NULL,
    [title] varchar(250) NULL,
    [business_phone] varchar(20) NULL,
    [mobile_phone] varchar(20) NULL,
);

GO

-- =============================================================================
-- dbo.sandbox_template_param
-- =============================================================================
CREATE TABLE [dbo].[sandbox_template_param] (

    [sandbox_template_param_id] int NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [session_id] uniqueidentifier NOT NULL,
    [master_email_template_param_id] int NOT NULL,
    [value] varchar(MAX) NULL,
);

GO

-- =============================================================================
-- dbo.send_email_log
-- =============================================================================
CREATE TABLE [dbo].[send_email_log] (

    [send_email_log_id] uniqueidentifier NOT NULL,
    [created_date] datetime NOT NULL,
    [queue_number] smallint NULL,
    [campaign_header] varchar(100) NULL,
    [email_from] varchar(1000) NULL,
    [email_to] varchar(MAX) NULL,
    [email_cc] varchar(MAX) NULL,
    [email_bcc] varchar(MAX) NULL,
    [email_reply_to] varchar(1000) NULL,
    [email_subject] varchar(1000) NULL,
    [email_body_text] varchar(MAX) NULL,
    [email_body_html] varchar(MAX) NULL,
    [email_body_html_url] varchar(1000) NULL,
    [email_body_text_url] varchar(1000) NULL,
);

GO

-- =============================================================================
-- dbo.smart_data_franchise
-- =============================================================================
CREATE TABLE [dbo].[smart_data_franchise] (

    [franchise_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [status] varchar(20) NOT NULL,
);

GO

-- =============================================================================
-- dbo.smart_facts_report_data
-- =============================================================================
CREATE TABLE [dbo].[smart_facts_report_data] (

    [id] int NOT NULL,
    [lead_id] uniqueidentifier NOT NULL,
    [lead_date] datetime NOT NULL,
    [customer_id] int NOT NULL,
    [franchise_id] int NULL,
    [first] varchar(50) NULL,
    [last] varchar(50) NULL,
    [email] varchar(100) NOT NULL,
    [home_phone] varchar(20) NOT NULL,
    [zip] varchar(10) NULL,
    [type] varchar(10) NOT NULL,
    [status] varchar(30) NOT NULL,
    [lp_make] varchar(50) NULL,
    [lp_year] varchar(10) NULL,
    [lp_model] varchar(100) NULL,
    [lead_provider_name] varchar(50) NULL,
);

GO

-- =============================================================================
-- dbo.smart_facts_report_events
-- =============================================================================
CREATE TABLE [dbo].[smart_facts_report_events] (

    [id] int NOT NULL,
    [EventType] smallint NOT NULL,
    [ReportId] uniqueidentifier NOT NULL,
    [Time] datetime NOT NULL,
    [IpAddress] varchar(50) NULL,
    [Data] varchar(80) NULL,
);

GO

-- =============================================================================
-- dbo.smart_follow
-- =============================================================================
CREATE TABLE [dbo].[smart_follow] (

    [smart_follow_id] uniqueidentifier NOT NULL,
    [created_date] datetime NOT NULL,
    [type] varchar(20) NOT NULL,
    [franchise_rep_id] int NULL,
    [franchise_rep_name] varchar(50) NULL,
    [franchise_rep_title] varchar(100) NULL,
    [franchise_rep_email] varchar(100) NULL,
    [franchise_rep_business_phone] varchar(20) NULL,
    [franchise_rep_mobile_phone] varchar(20) NULL,
    [franchise_rep_photo_url] varchar(100) NULL,
    [franchise_rep_store] varchar(30) NULL,
    [alias_franchise_rep_email] varchar(100) NULL,
    [alias_franchise_rep_business_phone] varchar(20) NULL,
    [alias_franchise_rep_business_extension] varchar(10) NULL,
    [alias_franchise_rep_mobile_phone] varchar(20) NULL,
    [alias_franchise_rep_mobile_extension] varchar(10) NULL,
    [is_generic_franchise_rep] bit NOT NULL,
    [franchise_reference] varchar(50) NULL,
    [email] varchar(100) NOT NULL,
    [home_phone] varchar(20) NULL,
    [mobile_phone] varchar(20) NULL,
    [alias_email] varchar(100) NULL,
    [alias_home_phone] varchar(20) NULL,
    [alias_home_extension] varchar(10) NULL,
    [alias_mobile_phone] varchar(20) NULL,
    [alias_mobile_extension] varchar(10) NULL,
    [vehicle_id] int NULL,
    [make] varchar(50) NULL,
    [year] varchar(10) NULL,
    [model] varchar(100) NULL,
    [trim] varchar(200) NULL,
    [vin] varchar(20) NULL,
    [stock_number] varchar(20) NULL,
    [is_opened] bit NOT NULL,
    [raw_email] varchar(MAX) NULL,
    [email_template_name] varchar(50) NULL,
    [smart_follow_date] datetime NOT NULL,
    [smart_follow_txn_id] uniqueidentifier NOT NULL,
    [email_template_text_name] varchar(100) NULL,
    [email_template_html_name] varchar(100) NULL,
    [web_template_name] varchar(100) NULL,
    [crm_reference] varchar(500) NULL,
    [crm_reply_to] varchar(100) NULL,
);

GO

-- =============================================================================
-- dbo.smart_follow_franchise
-- =============================================================================
CREATE TABLE [dbo].[smart_follow_franchise] (

    [franchise_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [status] varchar(30) NOT NULL,
    [days_before_initial_contact] smallint NOT NULL,
    [is_automatic_smart_follow] bit NOT NULL,
    [version] real NOT NULL,
    [days_to_restart_smart_follow] smallint NULL,
    [hyper_retargeting_base_image_url] varchar(1000) NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [smart_follow_new_vehicle] bit NOT NULL,
    [smart_follow_used_vehicle] bit NOT NULL,
);

GO

-- =============================================================================
-- dbo.smart_follow_individual_contact_analysis_by_email_name_report
-- =============================================================================
CREATE TABLE [dbo].[smart_follow_individual_contact_analysis_by_email_name_report] (

    [smart_follow_individual_contact_analysis_by_email_name_report_id] int NOT NULL,
    [report_date] datetime NOT NULL,
    [type] varchar(10) NOT NULL,
    [customer_id] int NULL,
    [franchise_id] int NULL,
    [franchise_rep_email] varchar(100) NULL,
    [franchise_rep_name] varchar(100) NULL,
    [last_updated] datetime NOT NULL,
    [lead_count] smallint NULL,
    [crm_email_count] smallint NULL,
    [crm_emails_per_lead] real NULL,
    [crm_phone_count] smallint NULL,
    [crm_phones_per_lead] real NULL,
    [crm_phone_duration_avg] real NULL,
    [lead_delivery_to_crm_email_time_avg] real NULL,
    [lead_delivery_to_crm_phone_time_avg] real NULL,
    [status] varchar(10) NOT NULL,
    [qualified_leads] int NULL,
    [lead_delivery_to_crm_email_time_median] real NULL,
    [lead_delivery_to_crm_phone_time_median] real NULL,
    [crm_emails_per_qualified_lead] real NULL,
    [crm_phones_per_qualified_lead] real NULL,
);

GO

-- =============================================================================
-- dbo.smart_follow_individual_contact_analysis_by_name_report
-- =============================================================================
CREATE TABLE [dbo].[smart_follow_individual_contact_analysis_by_name_report] (

    [smart_follow_individual_contact_analysis_by_name_report_id] int NOT NULL,
    [lead_month] varchar(7) NULL,
    [customer_id] int NULL,
    [franchise_id] int NULL,
    [franchise_rep_name] varchar(100) NULL,
    [franchise_rep_email] varchar(100) NULL,
    [lead_count] smallint NULL,
    [crm_email_count] smallint NULL,
    [crm_emails_per_lead] real NULL,
    [crm_phone_count] smallint NULL,
    [crm_phones_per_lead] real NULL,
    [crm_phone_duration_avg] real NULL,
    [lead_delivery_to_crm_email_time_avg] real NULL,
    [lead_delivery_to_crm_phone_time_avg] real NULL,
    [status] varchar(10) NOT NULL,
    [cars_sold_by_smart_follow] smallint NULL,
    [qualified_leads] smallint NULL,
    [fraction_crm_email_count] real NULL,
    [fraction_crm_phone_count] real NULL,
);

GO

-- =============================================================================
-- dbo.smart_follow_individual_contact_analysis_report
-- =============================================================================
CREATE TABLE [dbo].[smart_follow_individual_contact_analysis_report] (

    [smart_follow_individual_contact_analysis_report_id] int NOT NULL,
    [lead_month] varchar(7) NULL,
    [customer_id] int NULL,
    [franchise_id] int NULL,
    [franchise_rep_name] varchar(100) NULL,
    [franchise_rep_email] varchar(100) NULL,
    [lead_count] smallint NULL,
    [crm_email_count] smallint NULL,
    [crm_emails_per_lead] real NULL,
    [crm_phone_count] smallint NULL,
    [crm_phones_per_lead] real NULL,
    [crm_phone_duration_avg] real NULL,
    [lead_delivery_to_crm_email_time_avg] real NULL,
    [lead_delivery_to_crm_phone_time_avg] real NULL,
    [status] varchar(10) NOT NULL,
    [cars_sold_by_smart_follow] smallint NULL,
    [qualified_leads] smallint NULL,
    [fraction_crm_email_count] real NULL,
    [fraction_crm_phone_count] real NULL,
);

GO

-- =============================================================================
-- dbo.smart_follow_performance_by_state_make_report
-- =============================================================================
CREATE TABLE [dbo].[smart_follow_performance_by_state_make_report] (

    [smart_follow_performance_by_state_make_report_id] int NOT NULL,
    [state] varchar(2) NULL,
    [make_id] int NULL,
    [last_updated_date] datetime NOT NULL,
    [lead_count] int NULL,
    [qualified_leads] int NULL,
    [pass_through_leads] int NULL,
    [crm_email_count] int NULL,
    [crm_phone_count] int NULL,
    [crm_phone_duration_avg] real NULL,
    [lead_delivery_to_crm_email_time_avg] real NULL,
    [lead_delivery_to_crm_phone_time_avg] real NULL,
    [leads_closed] int NULL,
    [leads_closed_alias_only] int NULL,
    [report_date] datetime NOT NULL,
    [type] varchar(10) NOT NULL,
    [crm_emails_per_lead] real NULL,
    [crm_phones_per_lead] real NULL,
    [qualified_leads_contacted_in_30_mins] int NULL,
    [qualified_leads_contacted_in_30_to_120_mins] int NULL,
    [qualified_leads_contacted_in_120_to_480_mins] int NULL,
    [qualified_leads_contacted_in_over_480_mins] int NULL,
    [qualified_leads_contacted] int NULL,
    [lead_delivery_to_crm_email_time_median] real NULL,
    [lead_delivery_to_crm_phone_time_median] real NULL,
    [lead_delivery_to_crm_contact_time_median] real NULL,
    [reactivation_to_crm_contact_time_median] real NULL,
);

GO

-- =============================================================================
-- dbo.smart_follow_performance_report
-- =============================================================================
CREATE TABLE [dbo].[smart_follow_performance_report] (

    [smart_follow_performance_report_id] int NOT NULL,
    [customer_id] int NULL,
    [franchise_id] int NULL,
    [leads_being_worked] smallint NULL,
    [smart_follow_emails_sent] smallint NULL,
    [smart_follow_emails_opened] smallint NULL,
    [smart_follow_reactivations] smallint NULL,
    [now_in_market_reactivations] smallint NULL,
    [now_interested_in_another_model_reactivations] smallint NULL,
    [scheduled_test_drive_reactivations] smallint NULL,
    [incentive_contact_me_reactivations] smallint NULL,
    [phone_reactivations] smallint NULL,
    [consumer_closed_after_5_days] smallint NULL,
    [cars_sold_by_smart_follow] smallint NULL,
    [cars_sold_by_smart_follow_alias_only] smallint NULL,
    [report_date] datetime NOT NULL,
    [type] varchar(10) NOT NULL,
    [last_updated] datetime NOT NULL,
    [reactivation_to_crm_contact_time_avg] real NULL,
    [reactivated_leads_contacted] int NULL,
    [reactivated_leads_contacted_in_30_mins] int NULL,
    [reactivated_leads_contacted_in_30_to_120_mins] int NULL,
    [reactivated_leads_contacted_in_120_to_480_mins] int NULL,
    [reactivated_leads_contacted_in_over_480_mins] int NULL,
    [reactivation_to_crm_contact_time_median] real NULL,
    [leads_being_worked_fct] smallint NULL,
    [smart_follow_emails_sent_fct] smallint NULL,
    [now_in_market_reactivations_fct] smallint NULL,
    [now_interested_in_another_model_reactivations_fct] smallint NULL,
    [scheduled_test_drive_reactivations_fct] smallint NULL,
    [incentive_contact_me_reactivations_fct] smallint NULL,
    [phone_reactivations_fct] smallint NULL,
    [smart_follow_reactivations_fct] smallint NULL,
    [created_date] datetime NOT NULL,
);

GO

-- =============================================================================
-- dbo.smart_follow_v3_base_defaults
-- =============================================================================
CREATE TABLE [dbo].[smart_follow_v3_base_defaults] (

    [default_template_values_id] uniqueidentifier NOT NULL,
    [version] nvarchar(10) NULL,
    [subject] nvarchar(500) NULL,
    [header_image_url] nvarchar(250) NULL,
    [header_image_redirect_url] nvarchar(250) NULL,
    [greeting_text] nvarchar(MAX) NULL,
    [intro_text] nvarchar(MAX) NULL,
    [outro_text] nvarchar(MAX) NULL,
    [signature_image_url_override] nvarchar(250) NULL,
    [signature_name_override] nvarchar(100) NULL,
    [signature_title_override] nvarchar(100) NULL,
    [signature_mobile_number_override] nvarchar(15) NULL,
    [signature_office_number_override] nvarchar(15) NULL,
    [signature_email_override] nvarchar(150) NULL,
    [signature_text_color_hex] nvarchar(10) NULL,
    [signature_accent_color_hex] nvarchar(10) NULL,
    [disclaimer_text] nvarchar(MAX) NULL,
    [border_color_hex] nvarchar(10) NULL,
    [link_color_hex] nvarchar(10) NULL,
    [link_visited_color_hex] nvarchar(10) NULL,
    [link_hover_color_hex] nvarchar(10) NULL,
    [link_active_color_hex] nvarchar(10) NULL,
    [button_color_hex] nvarchar(10) NULL,
    [button_text_color_hex] nvarchar(10) NULL,
);

GO

-- =============================================================================
-- dbo.smart_follow_v3_manual_run_log
-- =============================================================================
CREATE TABLE [dbo].[smart_follow_v3_manual_run_log] (

    [id] int NOT NULL,
    [run_id] uniqueidentifier NOT NULL,
    [processed_date] datetime NOT NULL,
    [user_email] nvarchar(150) NOT NULL,
    [first] nvarchar(50) NULL,
    [last] nvarchar(50) NULL,
    [email] nvarchar(100) NOT NULL,
);

GO

-- =============================================================================
-- dbo.smart_quote
-- =============================================================================
CREATE TABLE [dbo].[smart_quote] (

    [smart_quote_id] uniqueidentifier NOT NULL,
    [created_date] datetime NOT NULL,
    [lead_id] uniqueidentifier NULL,
    [type] varchar(20) NOT NULL,
    [franchise_rep_id] int NULL,
    [franchise_rep_name] varchar(50) NULL,
    [franchise_rep_title] varchar(100) NULL,
    [franchise_rep_email] varchar(100) NULL,
    [franchise_rep_business_phone] varchar(20) NULL,
    [franchise_rep_mobile_phone] varchar(20) NULL,
    [franchise_rep_photo_url] varchar(100) NULL,
    [franchise_rep_store] varchar(30) NULL,
    [alias_franchise_rep_email] varchar(100) NULL,
    [alias_franchise_rep_business_phone] varchar(20) NULL,
    [alias_franchise_rep_business_extension] varchar(10) NULL,
    [alias_franchise_rep_mobile_phone] varchar(20) NULL,
    [alias_franchise_rep_mobile_extension] varchar(10) NULL,
    [is_generic_franchise_rep] bit NOT NULL,
    [franchise_reference] varchar(50) NULL,
    [email] varchar(100) NOT NULL,
    [home_phone] varchar(20) NULL,
    [mobile_phone] varchar(20) NULL,
    [alias_email] varchar(100) NULL,
    [alias_home_phone] varchar(20) NULL,
    [alias_home_extension] varchar(10) NULL,
    [alias_mobile_phone] varchar(20) NULL,
    [alias_mobile_extension] varchar(10) NULL,
    [vehicle_id] int NULL,
    [make] varchar(50) NULL,
    [year] varchar(10) NULL,
    [model] varchar(100) NULL,
    [trim] varchar(200) NULL,
    [vin] varchar(20) NULL,
    [stock_number] varchar(20) NULL,
    [email_template_name] varchar(50) NULL,
    [quote_vehicle_xml] xml NULL,
    [used_vehicle_xml] xml NULL,
    [is_opened] bit NOT NULL,
    [raw_email] varchar(MAX) NULL,
    [is_billable] bit NOT NULL,
    [smart_quote_date] datetime NOT NULL,
    [non_billable_type] varchar(20) NULL,
    [non_billable_logon] varchar(128) NULL,
    [raw_email_url] varchar(1000) NULL,
    [new_vehicle_xml_url] varchar(1000) NULL,
    [used_vehicle_xml_url] varchar(1000) NULL,
    [email_template_text_name] varchar(100) NULL,
    [email_template_html_name] varchar(100) NULL,
    [web_template_name] varchar(100) NULL,
    [crm_reference] varchar(500) NULL,
    [crm_reply_to] varchar(100) NULL,
    [id] int NOT NULL,
);

GO

-- =============================================================================
-- dbo.smart_quote_price_drop
-- =============================================================================
CREATE TABLE [dbo].[smart_quote_price_drop] (

    [id] int NOT NULL,
    [lead_id] uniqueidentifier NOT NULL,
    [last_quoted_vin] nvarchar(25) NOT NULL,
    [original_price] int NOT NULL,
    [new_price] int NOT NULL,
    [price_drop_amount] int NOT NULL,
    [date] datetime NOT NULL,
);

GO

-- =============================================================================
-- dbo.smart_quote_template_preset
-- =============================================================================
CREATE TABLE [dbo].[smart_quote_template_preset] (

    [id] int NOT NULL,
    [name] varchar(100) NOT NULL,
    [sq_new_html_master_email_template_name] varchar(100) NOT NULL,
    [sq_new_web_master_email_template_name] varchar(100) NOT NULL,
    [sq_new_text_master_email_template_name] varchar(100) NOT NULL,
    [sq_new_sms_master_email_template_name] varchar(100) NOT NULL,
    [sq_used_html_master_email_template_name] varchar(100) NOT NULL,
    [sq_used_web_master_email_template_name] varchar(100) NOT NULL,
    [sq_used_text_master_email_template_name] varchar(100) NOT NULL,
    [sq_used_sms_master_email_template_name] varchar(100) NOT NULL,
);

GO

-- =============================================================================
-- dbo.smart_quote_test
-- =============================================================================
CREATE TABLE [dbo].[smart_quote_test] (

    [smart_quote_test_id] uniqueidentifier NOT NULL,
    [created_date] datetime NOT NULL,
    [smart_quote_date] datetime NOT NULL,
    [type] varchar(20) NOT NULL,
    [franchise_rep_name] varchar(50) NULL,
    [franchise_rep_title] varchar(100) NULL,
    [franchise_rep_email] varchar(100) NULL,
    [franchise_rep_business_phone] varchar(20) NULL,
    [franchise_rep_mobile_phone] varchar(20) NULL,
    [franchise_rep_photo_url] varchar(100) NULL,
    [franchise_rep_store] varchar(30) NULL,
    [alias_franchise_rep_email] varchar(100) NULL,
    [alias_franchise_rep_business_phone] varchar(20) NULL,
    [alias_franchise_rep_business_extension] varchar(10) NULL,
    [alias_franchise_rep_mobile_phone] varchar(20) NULL,
    [alias_franchise_rep_mobile_extension] varchar(10) NULL,
    [is_generic_franchise_rep] bit NOT NULL,
    [franchise_reference] varchar(50) NULL,
    [email] varchar(100) NOT NULL,
    [home_phone] varchar(20) NULL,
    [mobile_phone] varchar(20) NULL,
    [alias_email] varchar(100) NULL,
    [alias_home_phone] varchar(20) NULL,
    [alias_home_extension] varchar(10) NULL,
    [alias_mobile_phone] varchar(20) NULL,
    [alias_mobile_extension] varchar(10) NULL,
    [vehicle_id] int NULL,
    [make] varchar(50) NULL,
    [year] varchar(10) NULL,
    [model] varchar(100) NULL,
    [trim] varchar(200) NULL,
    [vin] varchar(20) NULL,
    [stock_number] varchar(20) NULL,
    [email_template_name] varchar(50) NULL,
    [quote_vehicle_xml] xml NULL,
    [used_vehicle_xml] xml NULL,
    [raw_email_url] varchar(1000) NULL,
    [new_vehicle_xml_url] varchar(1000) NULL,
    [used_vehicle_xml_url] varchar(1000) NULL,
);

GO

-- =============================================================================
-- dbo.smart_quote_used_franchise
-- =============================================================================
CREATE TABLE [dbo].[smart_quote_used_franchise] (

    [franchise_id] int NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [version] real NOT NULL,
    [generic_quote_franchise_rep_name] varchar(50) NULL,
    [generic_quote_franchise_rep_title] varchar(100) NULL,
    [generic_quote_franchise_rep_email] varchar(100) NULL,
    [generic_quote_franchise_rep_corporate_email] varchar(100) NULL,
    [generic_quote_franchise_rep_business_phone] varchar(20) NULL,
    [generic_quote_franchise_rep_mobile_phone] varchar(20) NULL,
    [generic_quote_franchise_rep_photo_url] varchar(100) NULL,
    [generic_quote_franchise_rep_store] varchar(30) NULL,
    [is_generic_quoting] bit NOT NULL,
    [generic_quote_wait_minutes] smallint NOT NULL,
    [used_vehicles_shown_max] smallint NOT NULL,
    [used_year_min] varchar(10) NOT NULL,
    [pass_on_no_vin] bit NOT NULL,
    [status] varchar(20) NOT NULL,
    [used_days_in_stock] smallint NOT NULL,
);

GO

-- =============================================================================
-- dbo.smart_quote_vehicle
-- =============================================================================
CREATE TABLE [dbo].[smart_quote_vehicle] (

    [id] int NOT NULL,
    [SmartQuoteId] int NOT NULL,
    [SeqId] tinyint NOT NULL,
    [QuotedAs] tinyint NOT NULL,
    [Status] tinyint NOT NULL,
    [VehicleId] int NOT NULL,
    [VIN] varchar(20) NULL,
    [StockId] varchar(20) NULL,
    [Price] money NULL,
);

GO

-- =============================================================================
-- dbo.smart_start_franchise
-- =============================================================================
CREATE TABLE [dbo].[smart_start_franchise] (

    [franchise_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [status] varchar(20) NOT NULL,
    [generic_quote_franchise_rep_name] varchar(50) NULL,
    [generic_quote_franchise_rep_title] varchar(100) NULL,
    [generic_quote_franchise_rep_email] varchar(100) NULL,
    [generic_quote_franchise_rep_corporate_email] varchar(100) NULL,
    [generic_quote_franchise_rep_business_phone] varchar(20) NULL,
    [generic_quote_franchise_rep_mobile_phone] varchar(20) NULL,
    [generic_quote_franchise_rep_photo_url] varchar(100) NULL,
    [generic_quote_franchise_rep_store] varchar(30) NULL,
    [is_generic_quoting] bit NOT NULL,
    [generic_quote_wait_minutes] smallint NOT NULL,
    [version] real NOT NULL,
    [used_vehicles_shown_max] smallint NOT NULL,
    [used_year_min] varchar(10) NOT NULL,
    [use_employee_price] bit NOT NULL,
    [pass_on_vin] bit NOT NULL,
    [selection_algorithm] varchar(50) NOT NULL,
    [next_rebuild_processing_date] datetime NULL,
    [last_rebuild_processing_date] datetime NULL,
    [used_days_in_stock] smallint NOT NULL,
    [selection_zip] varchar(10) NULL,
    [selection_radius] smallint NULL,
    [selection_state_list] varchar(100) NULL,
    [use_default_pricing] bit NOT NULL,
    [invoice_markup_default] money NULL,
    [msrp_markup_default] money NULL,
    [invoice_markup_pct_default] real NULL,
    [msrp_markup_pct_default] real NULL,
    [call_for_price_default] bit NULL,
    [selection_algorithm_stage] varchar(30) NULL,
    [lease_disclaimer_default] varchar(2000) NULL,
    [quote_vehicle_source] varchar(20) NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [quote_delay_minutes] int NULL,
    [dealer_inventory_incentives] bit NULL,
    [incentives_cash_scenario] smallint NULL,
    [new_vehicle_alternative_setting] tinyint NOT NULL,
    [used_vehicle_alternative_setting] tinyint NOT NULL,
    [multi_make_new_alternatives] bit NOT NULL,
    [smart_follow_disclaimer] varchar(2000) NULL,
);

GO

-- =============================================================================
-- dbo.smart_start_performance_report
-- =============================================================================
CREATE TABLE [dbo].[smart_start_performance_report] (

    [smart_start_performance_report_id] int NOT NULL,
    [customer_id] int NOT NULL,
    [franchise_id] int NULL,
    [last_updated] datetime NOT NULL,
    [quotes_sent] smallint NULL,
    [report_date] datetime NOT NULL,
    [type] varchar(10) NOT NULL,
    [quotes_opened] smallint NULL,
    [quotes_sent_fct] smallint NULL,
);

GO

-- =============================================================================
-- dbo.smtp_code
-- =============================================================================
CREATE TABLE [dbo].[smtp_code] (

    [smtp_code_id] int NOT NULL,
    [code] varchar(10) NOT NULL,
    [description] varchar(500) NOT NULL,
    [action] varchar(20) NOT NULL,
    [description_ex] varchar(500) NOT NULL,
);

GO

-- =============================================================================
-- dbo.smtp_domain
-- =============================================================================
CREATE TABLE [dbo].[smtp_domain] (

    [smtp_domain_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [server] varchar(30) NOT NULL,
    [domain] varchar(100) NOT NULL,
);

GO

-- =============================================================================
-- dbo.super_email_template
-- =============================================================================
CREATE TABLE [dbo].[super_email_template] (

    [super_email_template_id] int NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [name] varchar(100) NOT NULL,
    [subject] varchar(1000) NOT NULL,
    [body] varchar(MAX) NOT NULL,
);

GO

-- =============================================================================
-- dbo.sysdiagrams
-- =============================================================================
CREATE TABLE [dbo].[sysdiagrams] (

    [name] sysname NOT NULL,
    [principal_id] int NOT NULL,
    [diagram_id] int NOT NULL,
    [version] int NULL,
    [definition] varbinary NULL,
);

GO

-- =============================================================================
-- dbo.SystemLog
-- =============================================================================
CREATE TABLE [dbo].[SystemLog] (

    [id] int NOT NULL,
    [Created] datetime NOT NULL,
    [EventType] tinyint NOT NULL,
    [EventTime] datetime NOT NULL,
    [EventId] int NOT NULL,
    [Reporter] varchar(50) NOT NULL,
    [MessageTemplate] varchar(128) NULL,
    [Data] varchar(512) NULL,
);

GO

-- =============================================================================
-- dbo.temp_results_table
-- =============================================================================
CREATE TABLE [dbo].[temp_results_table] (

    [id] int NOT NULL,
    [AccountId] int NULL,
    [AccountName] varchar(255) NULL,
    [Make] varchar(100) NULL,
    [MonthStart] datetime NULL,
    [MonthEnd] datetime NULL,
    [MonthName] varchar(100) NULL,
    [MonthYear] varchar(100) NULL,
    [MonthYearShort] varchar(100) NULL,
    [SmartQuoteSent] int NULL,
    [Reactivation] int NULL,
    [GrossProfit] int NULL,
    [TimeSaved] int NULL,
);

GO

-- =============================================================================
-- dbo.toyota_incentive
-- =============================================================================
CREATE TABLE [dbo].[toyota_incentive] (

    [toyota_incentive_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(50) NOT NULL,
    [year] smallint NOT NULL,
    [vehicle_number] varchar(20) NOT NULL,
    [cash_back] money NULL,
    [incentive_rate_36] real NULL,
    [incentive_rate_48] real NULL,
    [incentive_rate_60] real NULL,
    [incentive_expiration_date] datetime NOT NULL,
);

GO

-- =============================================================================
-- dbo.txn
-- =============================================================================
CREATE TABLE [dbo].[txn] (

    [txn_id] uniqueidentifier NOT NULL,
    [created_date] datetime NOT NULL,
);

GO

-- =============================================================================
-- dbo.used_lead_delivery
-- =============================================================================
CREATE TABLE [dbo].[used_lead_delivery] (

    [used_lead_delivery_id] int NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [franchise_id] int NOT NULL,
    [forward_email] varchar(500) NOT NULL,
    [lead_format] varchar(50) NOT NULL,
    [swap_consumer_phone] bit NOT NULL,
    [swap_consumer_email] bit NOT NULL,
    [swap_franchise_phone] bit NOT NULL,
    [swap_franchise_email] bit NOT NULL,
    [include_original_phone] bit NOT NULL,
    [include_original_email] bit NOT NULL,
);

GO

-- =============================================================================
-- dbo.user_interactions_simple
-- =============================================================================
CREATE TABLE [dbo].[user_interactions_simple] (

    [id] int NOT NULL,
    [txn_id] uniqueidentifier NOT NULL,
    [type] nvarchar(50) NOT NULL,
    [date] datetime NOT NULL,
);

GO

-- =============================================================================
-- dbo.vehicle
-- =============================================================================
CREATE TABLE [dbo].[vehicle] (

    [vehicle_id] int NOT NULL,
    [created_date] datetime NOT NULL,
    [model_id] int NOT NULL,
    [status] varchar(10) NOT NULL,
    [source] varchar(2) NOT NULL,
    [vehicle_number] varchar(20) NOT NULL,
    [name] varchar(200) NOT NULL,
    [trim] varchar(200) NOT NULL,
    [vin] varchar(20) NULL,
    [stock_number] varchar(20) NULL,
    [invoice] money NOT NULL,
    [msrp] money NOT NULL,
    [vehicle_image_html] varchar(500) NULL,
    [manufacturer_code] varchar(30) NOT NULL,
    [body_style] varchar(50) NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [use_employee_price] bit NOT NULL,
    [image_url] varchar(200) NULL,
    [vehicle_segment] varchar(50) NULL,
    [duty_type] varchar(50) NULL,
    [vehicle_option] xml NULL,
    [vehicle_option_code_list] varchar(200) NULL,
    [photo_url] varchar(200) NULL,
    [photo_1_url] varchar(200) NULL,
    [photo_2_url] varchar(200) NULL,
    [DestinationCharge] money NULL,
    [transmission] nvarchar(250) NULL,
);

GO

-- =============================================================================
-- dbo.vehicle_config_client
-- =============================================================================
CREATE TABLE [dbo].[vehicle_config_client] (

    [vehicle_config_client_id] uniqueidentifier NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [server_poll_interval_seconds] int NOT NULL,
    [last_contacted_date] datetime NULL,
    [version] varchar(20) NULL,
    [client_host_ip] varchar(20) NULL,
    [client_host_name] varchar(200) NULL,
    [location] varchar(10) NOT NULL,
    [status] varchar(10) NOT NULL,
    [last_work_item_type] varchar(30) NULL,
    [last_work_item_batch_count] smallint NULL,
    [last_work_is_error] bit NULL,
    [last_work_item_result_type] varchar(30) NULL,
    [last_work_item_result_page_count] smallint NULL,
    [last_work_item_result_count] smallint NULL,
    [last_work_item_result_update_date] datetime NULL,
);

GO

-- =============================================================================
-- dbo.vehicle_fuel_economy
-- =============================================================================
CREATE TABLE [dbo].[vehicle_fuel_economy] (

    [vehicle_id] int NOT NULL,
    [CityMPG] int NULL,
    [HighwayMPG] int NULL,
    [CombinedMPG] int NULL,
);

GO

-- =============================================================================
-- dbo.vehicle_image
-- =============================================================================
CREATE TABLE [dbo].[vehicle_image] (

    [id] int NOT NULL,
    [image_category] varchar(25) NULL,
    [image_desc] varchar(100) NULL,
    [image_path] varchar(128) NULL,
    [IsFile] bit NOT NULL,
);

GO

-- =============================================================================
-- dbo.vehicle_image_trim
-- =============================================================================
CREATE TABLE [dbo].[vehicle_image_trim] (

    [id] int NOT NULL,
    [vehicle_id] int NOT NULL,
    [image_id] int NOT NULL,
);

GO

-- =============================================================================
-- dbo.vehicle_number_log
-- =============================================================================
CREATE TABLE [dbo].[vehicle_number_log] (

    [id] int NOT NULL,
    [VehicleId] int NOT NULL,
    [ACode] varchar(20) NOT NULL,
    [Updated] datetime NOT NULL,
);

GO

-- =============================================================================
-- dbo.vehicle_oem_vehicle_map
-- =============================================================================
CREATE TABLE [dbo].[vehicle_oem_vehicle_map] (

    [vehicle_oem_vehicle_map_id] bigint NOT NULL,
    [created_date] datetime NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [vehicle_id] int NULL,
    [oem_make] varchar(50) NOT NULL,
    [oem_year] varchar(10) NOT NULL,
    [oem_model] varchar(100) NOT NULL,
    [oem_manufacturer_code] varchar(30) NOT NULL,
    [oem_trim] varchar(400) NOT NULL,
    [map_count] smallint NOT NULL,
);

GO

-- =============================================================================
-- dbo.vehicle_option
-- =============================================================================
CREATE TABLE [dbo].[vehicle_option] (

    [vehicle_option_id] bigint NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [last_updated_by] varchar(128) NOT NULL,
    [vehicle_id] int NOT NULL,
    [source] varchar(2) NOT NULL,
    [code] varchar(20) NOT NULL,
    [description] varchar(2000) NOT NULL,
    [invoice] money NOT NULL,
    [msrp] money NOT NULL,
    [status] varchar(10) NOT NULL,
    [display_level] smallint NOT NULL,
);

GO

-- =============================================================================
-- dbo.vehicle_option_oem_vehicle_option_map
-- =============================================================================
CREATE TABLE [dbo].[vehicle_option_oem_vehicle_option_map] (

    [vehicle_option_oem_vehicle_option_map_id] bigint NOT NULL,
    [created_date] datetime NOT NULL,
    [last_updated_by] varchar(100) NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [vehicle_option_id] bigint NULL,
    [vehicle_id] int NOT NULL,
    [oem_option_code] varchar(10) NOT NULL,
    [oem_option_desc] varchar(500) NOT NULL,
    [oem_option_invoice] money NOT NULL,
    [oem_option_msrp] money NOT NULL,
    [status] varchar(20) NOT NULL,
);

GO

-- =============================================================================
-- dbo.vehicle_safety_data
-- =============================================================================
CREATE TABLE [dbo].[vehicle_safety_data] (

    [id] int NOT NULL,
    [vehicle_id] int NOT NULL,
    [type] varchar(64) NOT NULL,
    [value] varchar(32) NULL,
);

GO

-- =============================================================================
-- dbo.vehicle_style
-- =============================================================================
CREATE TABLE [dbo].[vehicle_style] (

    [vehicle_id] int NOT NULL,
    [model] varchar(50) NOT NULL,
    [trim] varchar(50) NOT NULL,
    [style] varchar(128) NOT NULL,
    [vehicle_type] varchar(10) NULL,
    [drive_type] varchar(10) NULL,
    [body_type] varchar(25) NULL,
    [body_subtype] varchar(50) NULL,
    [oem_body_style] varchar(128) NULL,
    [mfr_package_code] varchar(25) NULL,
);

GO

-- =============================================================================
-- dbo.vehicle_vin_reference
-- =============================================================================
CREATE TABLE [dbo].[vehicle_vin_reference] (

    [id] int NOT NULL,
    [vehicle_id] int NOT NULL,
    [vin_pattern] varchar(10) NOT NULL,
    [rear_axle] varchar(10) NULL,
    [bed_length] decimal(18,0) NULL,
    [wheelbase] decimal(18,0) NULL,
);

GO

-- =============================================================================
-- dbo.zip_code
-- =============================================================================
CREATE TABLE [dbo].[zip_code] (

    [zip_code_id] int NOT NULL,
    [last_updated_date] datetime NOT NULL,
    [zip] varchar(5) NULL,
    [primary_record] varchar(1) NULL,
    [population] int NULL,
    [households_per_zipcode] int NULL,
    [white_population] int NULL,
    [black_population] int NULL,
    [hispanic_population] int NULL,
    [asian_population] int NULL,
    [hawaiian_population] int NULL,
    [indian_population] int NULL,
    [other_population] int NULL,
    [male_population] int NULL,
    [female_population] int NULL,
    [persons_per_household] decimal(4,2) NULL,
    [average_house_value] int NULL,
    [income_per_household] int NULL,
    [latitude] decimal(12,6) NULL,
    [longitude] decimal(12,6) NULL,
    [elevation] int NULL,
    [state] varchar(2) NULL,
    [state_full_name] varchar(35) NULL,
    [city_type] varchar(1) NULL,
    [city_alias_abbreviation] varchar(13) NULL,
    [area_code] varchar(55) NULL,
    [city] varchar(35) NULL,
    [city_alias_name] varchar(35) NULL,
    [county_name] varchar(45) NULL,
    [county_fips] varchar(5) NULL,
    [state_fips] varchar(2) NULL,
    [time_zone] varchar(2) NULL,
    [time_zone_hours_past_utc] smallint NULL,
    [day_light_saving] varchar(1) NULL,
    [msa] varchar(35) NULL,
    [pmsa] varchar(4) NULL,
    [csa] varchar(3) NULL,
    [cbsa] varchar(5) NULL,
    [cbsa_div] varchar(5) NULL,
    [cbsa_type] varchar(5) NULL,
    [cbsa_name] varchar(150) NULL,
    [msa_name] varchar(150) NULL,
    [pmsa_name] varchar(150) NULL,
    [region] varchar(10) NULL,
    [division] varchar(20) NULL,
    [mailing_name] varchar(1) NULL,
    [preferred_last_line_key] varchar(10) NULL,
    [classification_code] varchar(1) NULL,
    [multi_county] varchar(1) NULL,
    [csa_name] varchar(255) NULL,
    [cbsa_div_name] varchar(255) NULL,
    [city_state_key] varchar(6) NULL,
    [city_alias_code] varchar(5) NULL,
    [city_mixed_case] varchar(35) NULL,
    [city_alias_mixed_case] varchar(35) NULL,
);

GO

-- =============================================================================
-- dbo.zip_dma
-- =============================================================================
CREATE TABLE [dbo].[zip_dma] (

    [zip] varchar(10) NOT NULL,
    [dma] varchar(50) NULL,
);

GO
