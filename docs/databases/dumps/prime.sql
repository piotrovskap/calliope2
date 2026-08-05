-- Prime Database — DDL Schema Dump
-- Source: SQL Server 20.51.108.231
-- Generated: 2026-06-11
-- Schema-only; no data. Re-extract to refresh.

CREATE TABLE [___Legacy_Pipe] (
    [Pipe_Id] VARCHAR(32) NOT NULL -- PK,
    [Pipe] VARCHAR(16) NOT NULL -- PK,
    [Last_Id] BIGINT NOT NULL,
    [State] VARCHAR(5) NOT NULL,
    [End_At] VARCHAR(32) NOT NULL
);

CREATE TABLE [___LegacyInventoryHistory] (
    [ID] BIGINT NOT NULL -- PK,
    [captured] DATETIME NULL,
    [accID] INT NULL,
    [invID] INT NULL,
    [invRank] INT NULL,
    [invText] VARCHAR(128) NULL,
    [invPrice] MONEY NULL,
    [invHiLo] VARCHAR(1) NULL,
    [invSERP] INT NULL,
    [invVDP] INT NULL,
    [invEmails] INT NULL,
    [invNew] BIT NULL,
    [invImages] INT NULL
);

CREATE TABLE [adword_api_location_criteria_20160329] (
    [CriteriaID] VARCHAR(50) NOT NULL,
    [Name] VARCHAR(256) NOT NULL,
    [CanonicalName] VARCHAR(256) NOT NULL,
    [ParentID] VARCHAR(50) NOT NULL,
    [CountryCode] VARCHAR(50) NOT NULL,
    [TargetType] VARCHAR(50) NOT NULL,
    [Status] VARCHAR(100) NOT NULL
);

CREATE TABLE [AdWords_LocationCriterion] (
    [ID] INT NOT NULL -- PK,
    [City] VARCHAR(64) NOT NULL,
    [CriteriaID] VARCHAR(24) NOT NULL,
    [State] VARCHAR(24) NOT NULL,
    [DMARegion] VARCHAR(64) NOT NULL,
    [DMARegionCode] VARCHAR(256) NOT NULL
);

CREATE TABLE [AgeGroups] (
    [AgeGroupID] INT NOT NULL -- PK,
    [AgeGroupName] NVARCHAR(20) NOT NULL,
    [DisplayOrder] INT NOT NULL
);

CREATE TABLE [AllScheduledJobsOnServer] (
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

CREATE TABLE [AmazonOTTData] (
    [Date] DATETIME NOT NULL,
    [Advertiser] VARCHAR(500) NOT NULL,
    [AdvertiserId] VARCHAR(100) NOT NULL,
    [LineItem] VARCHAR(500) NULL,
    [LineItemId] VARCHAR(10) NULL,
    [TotalFee] VARCHAR(50) NOT NULL,
    [TotalCost] VARCHAR(50) NOT NULL,
    [Impressions] BIGINT NOT NULL,
    [VideoStart] BIGINT NOT NULL,
    [VideoFirstQuart] BIGINT NOT NULL,
    [VideoMidPoint] BIGINT NOT NULL,
    [VideoThirdQuart] BIGINT NOT NULL,
    [VideoCompleted] BIGINT NOT NULL,
    [VCR] VARCHAR(50) NOT NULL,
    [eCPVC] VARCHAR(50) NOT NULL,
    [VideoPause] BIGINT NOT NULL,
    [VideoResume] BIGINT NOT NULL,
    [VideoMute] BIGINT NOT NULL,
    [VideoUnmute] BIGINT NOT NULL
);

CREATE TABLE [AppNexusData] (
    [ibpDate] DATE NULL,
    [ibpCampaign] VARCHAR(256) NULL,
    [ibpImpressions] INT NULL,
    [ibpClicks] INT NULL,
    [ibpCTR] FLOAT NULL,
    [ibpCost] MONEY NULL,
    [ibpCostGrossFees] MONEY NULL,
    [rcd_Master_ID] INT NULL,
    [anx_Campaign_ID] INT NULL
);

CREATE TABLE [attrep_truncation_safeguard] (
    [latchTaskName] VARCHAR(128) NOT NULL -- PK,
    [latchMachineGUID] VARCHAR(40) NOT NULL -- PK,
    [LatchKey] CHAR(1) NOT NULL -- PK,
    [latchLocker] DATETIME NOT NULL
);

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

CREATE TABLE [Campaign_Performance_Check] (
    [ratchet_id] BIGINT NULL,
    [dsr_id] INT NULL,
    [perf_date] DATE NULL,
    [target_impressions] INT NULL
);

CREATE TABLE [CampaignGAPropertyMapping] (
    [MappingID] INT NOT NULL -- PK,
    [AccountID] INT NOT NULL,
    [PropertyID] INT NOT NULL,
    [CreatedDate] DATETIME2 NULL,
    [CreatedBy] NVARCHAR(100) NULL,
    [IsActive] BIT NULL,
    [Notes] NVARCHAR(MAX) NULL
);

CREATE TABLE [CampaignGoalOverride] (
    [cmp_id] INT NOT NULL -- PK,
    [year] INT NOT NULL -- PK,
    [month] TINYINT NOT NULL -- PK,
    [goal_value] DECIMAL(18,2) NOT NULL,
    [note] NVARCHAR(500) NULL,
    [created_by_account_id] INT NOT NULL,
    [created_by_name] NVARCHAR(200) NOT NULL,
    [created_at] DATETIME2 NOT NULL,
    [updated_by_account_id] INT NOT NULL,
    [updated_by_name] NVARCHAR(200) NOT NULL,
    [updated_at] DATETIME2 NOT NULL
);

CREATE TABLE [CampaignMetadata] (
    [PlatformId] INT NOT NULL -- PK,
    [CampaignId] BIGINT NOT NULL -- PK,
    [CampaignName] NVARCHAR(255) NULL,
    [CampaignMetadata] NVARCHAR(MAX) NULL,
    [CreatedDate] DATETIME2 NULL,
    [UpdatedDate] DATETIME2 NULL,
    [AdEzCampaignId] INT NULL
);

CREATE TABLE [CampaignMetadata_Staging] (
    [PlatformId] INT NOT NULL,
    [CampaignId] BIGINT NOT NULL,
    [CampaignName] NVARCHAR(255) NULL,
    [CampaignMetadata] NVARCHAR(MAX) NULL
);

CREATE TABLE [CampaignRename] (
    [old_External_Name] VARCHAR(256) NOT NULL -- PK,
    [new_External_Name] VARCHAR(256) NULL
);

CREATE TABLE [CGActive] (
    [CGID] INT NOT NULL -- PK,
    [PLACE_NAME] VARCHAR(255) NULL,
    [PLACE_ID] VARCHAR(50) NULL,
    [EXTERNALCAMPAIGNID] VARCHAR(50) NULL,
    [CAMPAIGN_LISTING_CANCELLED] VARCHAR(50) NULL,
    [acc_ID] INT NULL
);

CREATE TABLE [CityGridPlaces] (
    [adGroupID] INT NOT NULL -- PK,
    [campaignID] INT NOT NULL -- PK,
    [placeID] INT NOT NULL -- PK,
    [externalPlaceID] VARCHAR(500) NULL,
    [externalCampaignID] VARCHAR(500) NULL,
    [placeName] VARCHAR(500) NULL,
    [campaignName] VARCHAR(500) NULL,
    [status] VARCHAR(20) NULL,
    [ignore] BIT NOT NULL,
    [updated] DATETIME NULL
);

CREATE TABLE [ClientFulfillmentEventLog] (
    [cel_id] INT NOT NULL -- PK,
    [rcc_Master_ID] INT NOT NULL,
    [fus_id] INT NOT NULL,
    [cel_optionalMessage] VARCHAR(512) NOT NULL,
    [cel_dateCreated] DATETIME NOT NULL,
    [dsr_id] INT NOT NULL,
    [cel_statusDetail] NVARCHAR(512) NULL
);

CREATE TABLE [CoreLog] (
    [coreID] INT NOT NULL -- PK,
    [coreCMD] NVARCHAR(4000) NOT NULL,
    [coreDate] DATETIME NOT NULL
);

CREATE TABLE [CustomerSavedActions] (
    [acc_ID] INT NOT NULL -- PK,
    [pac_ID_List] VARCHAR(1024) NOT NULL
);

CREATE TABLE [DataSource] (
    [dsr_ID] INT NOT NULL -- PK,
    [dsr_Name] VARCHAR(50) NOT NULL,
    [dsr_PartnerId] INT NOT NULL,
    [dsr_ApiURL] VARCHAR(256) NOT NULL,
    [dsr_ApiKey] NVARCHAR(128) NOT NULL,
    [dsr_ApiUsername] NVARCHAR(128) NOT NULL,
    [dsr_ApiPassword] NVARCHAR(64) NOT NULL,
    [dsa_Id] INT NULL,
    [dsr_TypeId] INT NOT NULL,
    [dsr_ApiRefreshToken] NVARCHAR(128) NULL,
    [dsr_Active] BIT NULL,
    [dsr_Provider] VARCHAR(64) NULL,
    [dsr_ManualUpload] BIT NULL,
    [dsr_PerformanceLag] INT NULL
);

CREATE TABLE [DataSourceAuthenticationType] (
    [dsa_Id] INT NOT NULL -- PK,
    [dsa_Name] VARCHAR(64) NOT NULL
);

CREATE TABLE [DataSourceType] (
    [dsr_TypeId] INT NOT NULL -- PK,
    [dsr_TypeName] VARCHAR(64) NOT NULL
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

CREATE TABLE [DFATemp] (
    [dfa_Campaign_Name] VARCHAR(128) NULL,
    [dfa_Campaign_ID] VARCHAR(32) NULL,
    [dfa_Site] VARCHAR(64) NULL,
    [dfa_Placement] VARCHAR(64) NULL,
    [dfa_Date] VARCHAR(32) NULL,
    [dfa_Creative_Name] VARCHAR(256) NULL,
    [dfa_Creative_ID] VARCHAR(64) NULL,
    [dfa_City] VARCHAR(64) NULL,
    [dfa_State] VARCHAR(32) NULL,
    [dfa_Country] VARCHAR(64) NULL,
    [dfa_Impressions] VARCHAR(32) NULL,
    [dfa_Clicks] VARCHAR(32) NULL,
    [dfa_Click_Rate] VARCHAR(32) NULL,
    [dfa_Total_Conversions] VARCHAR(32) NULL
);

CREATE TABLE [Display] (
    [dis_ID] INT NOT NULL -- PK,
    [iml_ID] INT NOT NULL,
    [dis_Date] DATE NOT NULL,
    [rcd_Master_ID] BIGINT NULL,
    [dis_External_ID] VARCHAR(256) NULL,
    [dis_External_Group] VARCHAR(256) NULL,
    [dis_External_Name] VARCHAR(256) NULL,
    [dis_Clicks] INT NOT NULL,
    [dis_Impressions] INT NOT NULL,
    [dis_CTR] DECIMAL(18,3) NOT NULL,
    [dis_CPC] MONEY NOT NULL,
    [dis_Cost] MONEY NOT NULL,
    [dis_Overwrite_iml_ID] INT NULL
);

CREATE TABLE [display_0imlid] (
    [dis_ID] INT NOT NULL,
    [iml_ID] INT NOT NULL,
    [dis_Date] DATE NOT NULL,
    [rcd_Master_ID] BIGINT NULL,
    [dis_External_ID] VARCHAR(256) NULL,
    [dis_External_Group] VARCHAR(256) NULL,
    [dis_External_Name] VARCHAR(256) NULL,
    [dis_Clicks] INT NOT NULL,
    [dis_Impressions] INT NOT NULL,
    [dis_CTR] DECIMAL(18,3) NOT NULL,
    [dis_CPC] MONEY NOT NULL,
    [dis_Cost] MONEY NOT NULL,
    [dis_Overwrite_iml_ID] INT NULL,
    [dis_External_Extra] VARCHAR(256) NULL
);

CREATE TABLE [Display_Delete] (
    [DIS_ID] INT NOT NULL
);

CREATE TABLE [DisplayAdWordsOverwrite] (
    [dawo_ID] INT NOT NULL,
    [dsr_id] INT NOT NULL,
    [rcd_master_id] BIGINT NULL,
    [dis_external_group] VARCHAR(1024) NULL
);

CREATE TABLE [DisplayGEO] (
    [disgeo_id] BIGINT NOT NULL -- PK,
    [iml_id] INT NULL,
    [rcd_master_id] BIGINT NULL,
    [disgeo_date] DATE NOT NULL,
    [disgeo_client_name] VARCHAR(255) NOT NULL,
    [disgeo_external_id] VARCHAR(50) NOT NULL,
    [disgeo_adgroup_id] VARCHAR(50) NOT NULL,
    [disgeo_adgroup_name] VARCHAR(255) NOT NULL,
    [disgeo_campaign_id] VARCHAR(50) NOT NULL,
    [disgeo_campaign_name] VARCHAR(255) NOT NULL,
    [disgeo_city] VARCHAR(255) NOT NULL,
    [disgeo_metro] VARCHAR(255) NOT NULL,
    [disgeo_region] VARCHAR(255) NOT NULL,
    [disgeo_country] VARCHAR(255) NOT NULL,
    [disgeo_clicks] INT NOT NULL,
    [disgeo_impressions] INT NOT NULL,
    [disgeo_zip] VARCHAR(5) NULL
);

CREATE TABLE [DisplayHardcodedOverwrite] (
    [rcd_Master_ID] BIGINT NULL,
    [dis_External_ID] VARCHAR(256) NOT NULL,
    [dis_External_Group] VARCHAR(256) NOT NULL,
    [dis_External_Name] VARCHAR(256) NULL
);

CREATE TABLE [DisplayImage] (
    [disimg_id] INT NOT NULL -- PK,
    [disimg_extid] BIGINT NOT NULL,
    [iml_id] INT NOT NULL,
    [disimg_date] DATE NOT NULL,
    [disimg_name] VARCHAR(512) NULL,
    [disimg_adgroupid] BIGINT NOT NULL,
    [disimg_width] INT NOT NULL,
    [disimg_height] INT NOT NULL,
    [disimg_displayurl] VARCHAR(512) NULL,
    [disimg_status] VARCHAR(50) NOT NULL
);

CREATE TABLE [DisplayMasterOverwrite] (
    [rcd_Master_ID] BIGINT NULL,
    [IgnoreNULL] BIT NULL,
    [dsr_ID] INT NOT NULL,
    [dis_External_ID] VARCHAR(1024) NULL,
    [dis_External_Group] VARCHAR(1024) NULL,
    [dis_External_Name] VARCHAR(1024) NULL
);

CREATE TABLE [DTCL_Calls] (
    [DealerID] VARCHAR(32) NULL,
    [VehicleID] VARCHAR(32) NULL,
    [VIN] VARCHAR(32) NULL,
    [DealerName] VARCHAR(128) NULL,
    [MarketName] VARCHAR(128) NULL,
    [SessionId] VARCHAR(64) NULL,
    [CallerNumber] VARCHAR(32) NULL,
    [TrackingNumber] VARCHAR(32) NULL,
    [Duration] BIGINT NULL,
    [DurationFormatted] TIME NULL,
    [Created] DATETIME NULL,
    [Vehicle] VARCHAR(64) NULL
);

CREATE TABLE [DTCL_Calls_Temp] (
    [DealerID] VARCHAR(32) NULL,
    [VehicleID] VARCHAR(32) NULL,
    [VIN] VARCHAR(32) NULL,
    [DealerName] VARCHAR(128) NULL,
    [MarketName] VARCHAR(128) NULL,
    [SessionId] VARCHAR(64) NULL,
    [CallerNumber] VARCHAR(32) NULL,
    [TrackingNumber] VARCHAR(32) NULL,
    [Duration] BIGINT NULL,
    [DurationFormatted] TIME NULL,
    [Created] DATETIME NULL,
    [Vehicle] VARCHAR(64) NULL
);

CREATE TABLE [FacebookAdAccounts] (
    [Id] VARCHAR(15) NOT NULL,
    [CampaignId] VARCHAR(15) NOT NULL,
    [BidAmount] INT NULL,
    [BidStrategy] VARCHAR(50) NOT NULL,
    [DailyBudget] INT NULL,
    [Name] VARCHAR(50) NOT NULL,
    [OptimizationGoal] VARCHAR(50) NOT NULL,
    [Status] VARCHAR(50) NULL,
    [ConfiguredStatus] VARCHAR(50) NULL,
    [EffectiveStatus] VARCHAR(50) NULL
);

CREATE TABLE [FB_PL_Cost] (
    [rptDate] INT NULL,
    [cmpID] INT NULL,
    [rptResults] INT NULL,
    [rptImpressions] INT NULL,
    [rptAmount] MONEY NULL,
    [rptClicks] INT NULL,
    [cmpName] VARCHAR(256) NULL
);

CREATE TABLE [Flight_AltId_Mapping] (
    [subscription_id] INT NOT NULL,
    [flight_id] INT NOT NULL,
    [alt_id] VARCHAR(128) NULL
);

CREATE TABLE [FulfillmentState] (
    [fus_id] INT NOT NULL -- PK,
    [fus_name] VARCHAR(64) NOT NULL,
    [fus_description] VARCHAR(128) NULL
);

CREATE TABLE [GAAnalyticsData] (
    [Id] BIGINT NOT NULL -- PK,
    [PropertyId] NVARCHAR(50) NOT NULL,
    [PropertyName] NVARCHAR(255) NULL,
    [ReportDate] DATE NOT NULL,
    [CampaignId] BIGINT NULL,
    [CampaignName] NVARCHAR(512) NULL,
    [Sessions] BIGINT NULL,
    [Users] BIGINT NULL,
    [PageViews] BIGINT NULL,
    [Events] BIGINT NULL,
    [NewUsers] BIGINT NULL,
    [BounceRate] DECIMAL(10,4) NULL,
    [AvgSessionDuration] DECIMAL(10,4) NULL,
    [EngagedSessions] BIGINT NULL,
    [EngagementRate] DECIMAL(10,4) NULL,
    [SessionsPerUser] DECIMAL(10,4) NULL,
    [CreatedDate] DATETIME2 NULL,
    [UpdatedDate] DATETIME2 NULL,
    [AccountId] NVARCHAR(50) NULL,
    [Source] NVARCHAR(255) NULL,
    [Medium] NVARCHAR(255) NULL,
    [Channel] NVARCHAR(255) NULL,
    [AvgEngagementTime] DECIMAL(18,2) NULL,
    [EventsPerSession] DECIMAL(18,2) NULL,
    [KeyEvents] BIGINT NULL,
    [SessionKeyEventRate] DECIMAL(18,2) NULL
);

CREATE TABLE [GAProperties] (
    [PropertyID] INT NOT NULL -- PK,
    [GAPropertyId] NVARCHAR(50) NOT NULL,
    [PropertyName] NVARCHAR(255) NULL,
    [WebsiteURL] NVARCHAR(500) NULL,
    [GAAccountId] NVARCHAR(50) NULL,
    [GAAccountName] NVARCHAR(255) NULL,
    [PropertyType] NVARCHAR(50) NULL,
    [TimeZone] NVARCHAR(100) NULL,
    [CurrencyCode] NVARCHAR(10) NULL,
    [CreatedDate] DATETIME2 NULL,
    [LastSyncDate] DATETIME2 NULL,
    [IsActive] BIT NULL
);

CREATE TABLE [GclIdTracking] (
    [Id] BIGINT NOT NULL -- PK,
    [Gclid] VARCHAR(128) NOT NULL,
    [CustomerId] BIGINT NOT NULL,
    [CampaignId] BIGINT NOT NULL,
    [AdGroupId] BIGINT NULL,
    [ClickDate] DATE NOT NULL,
    [Device] VARCHAR(32) NULL,
    [CampaignName] NVARCHAR(255) NULL,
    [AdGroupName] NVARCHAR(255) NULL,
    [KeywordText] NVARCHAR(255) NULL,
    [KeywordMatchType] NVARCHAR(64) NULL,
    [ResourceName] NVARCHAR(512) NULL,
    [PageNumber] INT NULL,
    [LocationPresenceCountry] NVARCHAR(128) NULL,
    [LocationPresenceRegion] NVARCHAR(128) NULL,
    [LocationPresenceMetro] NVARCHAR(128) NULL,
    [LocationPresenceCity] NVARCHAR(128) NULL,
    [LocationPresenceMostSpecific] NVARCHAR(128) NULL,
    [AreaOfInterestCountry] NVARCHAR(128) NULL,
    [AreaOfInterestRegion] NVARCHAR(128) NULL,
    [AreaOfInterestMetro] NVARCHAR(128) NULL,
    [AreaOfInterestCity] NVARCHAR(128) NULL,
    [AreaOfInterestMostSpecific] NVARCHAR(128) NULL,
    [CampaignLocationTarget] NVARCHAR(256) NULL,
    [AdGroupAdResourceName] NVARCHAR(256) NULL,
    [KeywordResourceName] NVARCHAR(256) NULL,
    [UserListResourceName] NVARCHAR(256) NULL,
    [Clicks] BIGINT NOT NULL,
    [CreatedAt] DATETIME2 NOT NULL,
    [UpdatedAt] DATETIME2 NOT NULL,
    [ClickType] VARCHAR(64) NULL
);

CREATE TABLE [GenderGroups] (
    [GenderGroupID] INT NOT NULL -- PK,
    [GenderGroupName] NVARCHAR(20) NOT NULL,
    [DisplayOrder] INT NOT NULL
);

CREATE TABLE [GoogleAdsCampaigns] (
    [mcc_id] VARCHAR(10) NOT NULL,
    [ad_account_name] VARCHAR(250) NOT NULL,
    [ad_account_id] VARCHAR(10) NOT NULL,
    [adgroup_name] VARCHAR(250) NOT NULL,
    [adgroup_id] VARCHAR(10) NOT NULL,
    [campaign_name] VARCHAR(250) NOT NULL,
    [campaign_id] VARCHAR(10) NOT NULL,
    [campaign_state] VARCHAR(10) NOT NULL,
    [scan_for_campaigns] BIT NOT NULL,
    [adez_campaign_id] INT NOT NULL
);

CREATE TABLE [GoogleAdsMapping] (
    [CriteriaID] BIGINT NOT NULL -- PK,
    [Name] VARCHAR(100) NULL,
    [CanonicalName] VARCHAR(100) NULL,
    [ParentID] INT NULL,
    [CountryCode] VARCHAR(2) NULL,
    [TargetType] VARCHAR(20) NULL,
    [Status] VARCHAR(6) NULL
);

CREATE TABLE [grail_leesburg_fix] (
    [event_date] DATE NOT NULL,
    [acc_id] INT NOT NULL,
    [subscription_id] INT NOT NULL,
    [lst_id] INT NOT NULL,
    [app_action] INT NOT NULL,
    [is_bot] INT NOT NULL,
    [action_count] BIGINT NULL
);

CREATE TABLE [grail_srpactions_daily] (
    [event_date] DATE NOT NULL -- PK,
    [acc_id] INT NOT NULL,
    [subscription_id] INT NOT NULL -- PK,
    [lst_id] INT NOT NULL -- PK,
    [app_action] INT NOT NULL -- PK,
    [is_bot] BIT NOT NULL -- PK,
    [action_count] BIGINT NOT NULL
);

CREATE TABLE [grail_srpactions_daily_Mar2026] (
    [event_date] DATE NOT NULL,
    [acc_id] INT NOT NULL,
    [subscription_id] INT NOT NULL,
    [lst_id] INT NOT NULL,
    [app_action] INT NOT NULL,
    [is_bot] BIT NOT NULL,
    [action_count] BIGINT NOT NULL
);

CREATE TABLE [grail_tim_bk] (
    [event_date] DATE NOT NULL,
    [acc_id] INT NOT NULL,
    [subscription_id] INT NOT NULL,
    [lst_id] INT NOT NULL,
    [app_action] INT NOT NULL,
    [is_bot] BIT NOT NULL,
    [action_count] BIGINT NOT NULL
);

CREATE TABLE [GVACampaignDataset] (
    [rpt_date] DATE NOT NULL,
    [cmp_id] BIGINT NULL,
    [id] VARCHAR(256) NULL,
    [campaign_name] VARCHAR(256) NULL,
    [clicks] INT NOT NULL,
    [impressions] INT NOT NULL,
    [ctr] DECIMAL(18,3) NOT NULL,
    [cpc] MONEY NOT NULL,
    [cost] MONEY NOT NULL,
    [cmp_type] INT NOT NULL,
    [conversions] DECIMAL(10,2) NULL,
    [conversions_value] MONEY NULL
);

CREATE TABLE [GVACampaignMapping] (
    [campaign_id] BIGINT NULL,
    [campaign_name] VARCHAR(1024) NULL,
    [acc_id] INT NOT NULL
);

CREATE TABLE [GVASetup] (
    [subscription_id] INT NOT NULL -- PK,
    [merchant_id] BIGINT NULL,
    [ads_account_id] BIGINT NULL,
    [campaign_name] VARCHAR(500) NULL,
    [claimed] BIT NULL,
    [verified] BIT NULL,
    [pending] INT NULL,
    [disqualified] INT NULL,
    [active] INT NULL,
    [refreshed] DATETIME NULL,
    [domain] VARCHAR(500) NULL
);

CREATE TABLE [GVAVDPData] (
    [gva_date] INT NOT NULL,
    [client_id] BIGINT NULL,
    [client_name] VARCHAR(1024) NULL,
    [campaign_id] BIGINT NULL,
    [campaign_name] VARCHAR(1024) NULL,
    [landing_page] VARCHAR(512) NOT NULL,
    [impressions] INT NOT NULL,
    [clicks] INT NOT NULL,
    [domain] VARCHAR(128) NULL,
    [fauid] INT NULL,
    [veh_vin] VARCHAR(17) NULL,
    [lst_id] INT NULL
);

CREATE TABLE [GVAVDPDatav2] (
    [gva_date] INT NOT NULL,
    [client_id] BIGINT NULL,
    [client_name] VARCHAR(1024) NULL,
    [campaign_id] BIGINT NULL,
    [campaign_name] VARCHAR(1024) NULL,
    [landing_page] VARCHAR(2048) NULL,
    [impressions] INT NOT NULL,
    [clicks] INT NOT NULL,
    [domain] VARCHAR(128) NULL,
    [fauid] INT NULL,
    [veh_vin] VARCHAR(17) NULL,
    [lst_id] INT NULL,
    [conversions] DECIMAL(10,2) NULL,
    [conversions_value] MONEY NULL
);

CREATE TABLE [ImageProxy_By_Date_Account] (
    [acc_id] INT NOT NULL,
    [im_date] INT NOT NULL,
    [im_serp] INT NULL,
    [im_vdp] INT NULL
);

CREATE TABLE [ImageProxy_By_Date_Listing] (
    [acc_id] INT NOT NULL,
    [lst_id] INT NOT NULL,
    [im_date] INT NOT NULL,
    [im_serp] INT NULL,
    [im_vdp] INT NULL
);

CREATE TABLE [ImageProxyRequestAggregated] (
    [imp_id] BIGINT NOT NULL -- PK,
    [iml_id] INT NOT NULL,
    [imp_event_date] INT NOT NULL,
    [dsr_id] INT NOT NULL,
    [lst_id] INT NOT NULL,
    [imp_search_views] INT NOT NULL,
    [imp_vdp_views] INT NOT NULL,
    [imp_key] VARCHAR(50) NOT NULL
);

CREATE TABLE [ImageProxyRequestAggregated_Staging] (
    [imp_id] BIGINT NOT NULL -- PK,
    [iml_id] INT NOT NULL,
    [imp_event_date] INT NOT NULL,
    [dsr_id] INT NOT NULL,
    [lst_id] INT NOT NULL,
    [imp_search_views] INT NOT NULL,
    [imp_vdp_views] INT NOT NULL,
    [imp_key] VARCHAR(50) NOT NULL
);

CREATE TABLE [Impersonate] (
    [imp_GUID] UNIQUEIDENTIFIER NOT NULL -- PK,
    [acc_ID] INT NOT NULL,
    [imp_Created] SMALLDATETIME NOT NULL
);

CREATE TABLE [ImportLog] (
    [iml_ID] INT NOT NULL -- PK,
    [dsr_ID] INT NOT NULL,
    [ims_ID] INT NOT NULL,
    [iml_Created] DATETIME NOT NULL,
    [iml_Completed] DATETIME NULL,
    [iml_Parsed] DATETIME NULL,
    [acc_ID] INT NOT NULL,
    [iml_FileName] VARCHAR(256) NOT NULL,
    [iml_StartDate] DATE NOT NULL,
    [iml_EndDate] DATE NOT NULL,
    [iml_IsOverwrite] BIT NOT NULL,
    [iml_Reason] VARCHAR(512) NOT NULL
);

CREATE TABLE [ImportStatus] (
    [ims_ID] INT NOT NULL -- PK,
    [ims_Name] VARCHAR(64) NOT NULL,
    [ims_Active] BIT NOT NULL,
    [ims_Sort] INT NOT NULL
);

CREATE TABLE [IntMaxes] (
    [IntMax] INT NULL,
    [TableName] VARCHAR(64) NULL,
    [ColumnName] VARCHAR(64) NULL
);

CREATE TABLE [Job_Completion_Display_Alert_Log] (
    [log_ID] INT NOT NULL -- PK,
    [dsr_ID] INT NULL,
    [log_Date] DATETIME NULL,
    [log_Type] INT NULL,
    [log_Body] VARCHAR(8000) NULL,
    [log_Response] VARCHAR(4000) NULL
);

CREATE TABLE [Job_Completion_Display_Alert_LogTypes] (
    [log_Type] INT NOT NULL -- PK,
    [log_Name] VARCHAR(256) NULL
);

CREATE TABLE [JoseVGuys] (
    [dsr_ID] INT NOT NULL,
    [dsr_Name] VARCHAR(50) NOT NULL,
    [rcd_Master_ID] BIGINT NULL,
    [dis_External_Name] VARCHAR(1024) NULL,
    [rcd_Campaign_Name] VARCHAR(8000) NULL,
    [ndate] DATE NULL,
    [xdate] DATE NULL,
    [vimp] INT NULL
);

CREATE TABLE [LocalSearchActionNormalize] (
    [dsr_ID] INT NOT NULL -- PK,
    [lat_ActionOriginal] VARCHAR(128) NOT NULL -- PK,
    [lan_ActionNormalized] VARCHAR(128) NULL,
    [pac_ID] INT NULL
);

CREATE TABLE [LocalSearchActionTotal] (
    [dsr_ID] INT NOT NULL,
    [ext_LocationID] VARCHAR(100) NOT NULL,
    [lat_ActionDate] INT NOT NULL,
    [lat_ActionOriginal] VARCHAR(128) NOT NULL,
    [lat_Total] INT NOT NULL,
    [lat_DateFetched] DATETIME NOT NULL,
    [rcl_Master_ID] INT NULL,
    [lat_ID] BIGINT NOT NULL -- PK,
    [ext_ProviderID] VARCHAR(100) NULL
);

CREATE TABLE [LocationFulfillmentEventLog] (
    [lel_id] INT NOT NULL -- PK,
    [rcl_Master_ID] INT NOT NULL,
    [fus_id] INT NOT NULL,
    [lel_optionalMessage] VARCHAR(512) NOT NULL,
    [lel_dateCreated] DATETIME NOT NULL,
    [dsr_id] INT NOT NULL,
    [lel_statusDetail] NVARCHAR(512) NULL
);

CREATE TABLE [LogFile] (
    [lfName] VARCHAR(4000) NULL,
    [lfCreated] DATETIME NULL,
    [lfSize] BIGINT NULL
);

CREATE TABLE [MAIAMarketplaceData] (
    [report_time] INT NOT NULL,
    [ratchet_id] INT NULL,
    [dealer_id] INT NULL,
    [dealer_name] VARCHAR(250) NOT NULL,
    [zip_code] VARCHAR(10) NULL,
    [vin_count] INT NOT NULL,
    [listing_count] INT NOT NULL,
    [viewed_listing] INT NOT NULL,
    [viewed_dealer] INT NOT NULL,
    [tier] VARCHAR(10) NOT NULL
);

CREATE TABLE [MAIAMarketplaceMapping] (
    [dealer_name] VARCHAR(250) NOT NULL -- PK,
    [zip_code] VARCHAR(10) NOT NULL -- PK,
    [dealer_id] INT NOT NULL
);

CREATE TABLE [MAIAVdpData] (
    [maia_date] INT NOT NULL,
    [client_id] BIGINT NOT NULL,
    [client_name] VARCHAR(150) NOT NULL,
    [campaign_id] BIGINT NOT NULL,
    [campaign_name] VARCHAR(150) NOT NULL,
    [impressions] INT NOT NULL,
    [clicks] INT NOT NULL,
    [subscription_id] INT NULL
);

CREATE TABLE [MappingClient] (
    [mac_ID] BIGINT NOT NULL -- PK,
    [dsr_ID] INT NOT NULL,
    [rcc_Master_ID] INT NOT NULL,
    [rcc_ID] INT NOT NULL,
    [ext_ClientID] VARCHAR(100) NOT NULL,
    [mac_Created] DATETIME NOT NULL,
    [mac_Modified] DATETIME NULL,
    [mac_LastSuccessfulDataFetch] DATETIME NULL,
    [mac_Active] BIT NOT NULL
);

CREATE TABLE [MappingInventoryList] (
    [mai_ID] BIGINT NOT NULL -- PK,
    [dsr_ID] INT NULL,
    [rcc_Master_ID] INT NULL,
    [rcl_Master_ID] INT NULL,
    [ext_InventoryListID] VARCHAR(100) NULL,
    [mai_Active] BIT NULL,
    [mai_LastUpdated] DATETIME NULL
);

CREATE TABLE [MappingLocation] (
    [mal_ID] BIGINT NOT NULL -- PK,
    [dsr_ID] INT NOT NULL,
    [rcl_Master_ID] INT NOT NULL,
    [rcl_ID] INT NOT NULL,
    [ext_LocationID] VARCHAR(100) NOT NULL,
    [mal_Created] DATETIME NOT NULL,
    [mal_Modified] DATETIME NULL,
    [mal_LastSuccessfulDataFetch] DATETIME NULL,
    [mal_Active] BIT NOT NULL
);

CREATE TABLE [MenuFeatureFlag] (
    [MenuFeatureFlagId] INT NOT NULL -- PK,
    [Key] NVARCHAR(100) NOT NULL,
    [Label] NVARCHAR(200) NOT NULL,
    [Description] NVARCHAR(500) NULL,
    [IsEnabled] BIT NOT NULL,
    [Created] DATETIME NOT NULL,
    [Modified] DATETIME NOT NULL
);

CREATE TABLE [MetaCampaignInfo] (
    [business_manager_id] VARCHAR(50) NOT NULL,
    [account_id] VARCHAR(50) NOT NULL,
    [campaign_id] VARCHAR(50) NOT NULL,
    [data_refreshed] DATETIME NULL,
    [account_name] VARCHAR(255) NOT NULL,
    [preview_shareable_link] VARCHAR(1024) NULL,
    [demolink_hash] VARCHAR(1024) NULL,
    [campaign_objective] VARCHAR(100) NULL,
    [campaign_status] VARCHAR(50) NULL,
    [effective_status] VARCHAR(50) NULL,
    [campaign_name] VARCHAR(255) NULL,
    [campaign_created] DATETIME NOT NULL,
    [campaign_updated] DATETIME NULL,
    [campaign_daily_budget] DECIMAL(18,2) NULL,
    [campaign_bid_strategy] VARCHAR(50) NULL,
    [campaign_pacing] VARCHAR(50) NULL,
    [campaign_spend_cap] DECIMAL(18,2) NULL,
    [campaign_start] DATETIME NULL,
    [campaign_end] DATETIME NULL,
    [external_campaign_id] VARCHAR(50) NOT NULL
);

CREATE TABLE [obr_Dates_v6] (
    [StartDate] DATE NULL,
    [EndDate] DATE NULL,
    [StartINT] INT NULL,
    [EndINT] INT NULL,
    [Captured] VARCHAR(32) NULL
);

CREATE TABLE [obr_LocalPerformance] (
    [acc_ID] VARCHAR(32) NULL,
    [Captured] VARCHAR(32) NULL,
    [ShortName] VARCHAR(256) NOT NULL,
    [Total] VARCHAR(32) NULL
);

CREATE TABLE [obr_NetworkPerformance_V7_GH_REMARKETING] (
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

CREATE TABLE [Partner] (
    [pnr_ID] INT NOT NULL -- PK,
    [pnr_Name] NCHAR(128) NOT NULL
);

CREATE TABLE [PendingFulfillments] (
    [pef_ID] BIGINT NOT NULL -- PK,
    [dsr_ID] INT NOT NULL,
    [rcc_Master_ID] INT NOT NULL,
    [rcl_Master_ID] INT NULL,
    [ext_clientID] NCHAR(256) NULL,
    [ext_locationID] NCHAR(256) NULL,
    [pef_Created] DATETIME NOT NULL,
    [ext_pendingRecordID] VARCHAR(100) NOT NULL,
    [pef_pendingStatus] NCHAR(256) NULL,
    [pef_pendingReason] NCHAR(256) NULL,
    [pef_pendingDate] DATETIME NULL,
    [pef_LastStatusCheck] DATETIME NULL
);

CREATE TABLE [PerformanceActions] (
    [pac_ID] INT NOT NULL -- PK,
    [peg_ID] INT NOT NULL,
    [pac_Name] VARCHAR(256) NOT NULL,
    [pac_ShortName] VARCHAR(256) NOT NULL,
    [pac_Description] VARCHAR(1024) NOT NULL,
    [pac_Source] INT NOT NULL,
    [pac_Sort] INT NOT NULL,
    [pac_Active] BIT NOT NULL,
    [pac_Vehicle] BIT NOT NULL,
    [pac_UpsellURL] VARCHAR(256) NOT NULL,
    [pac_RAN] BIT NOT NULL,
    [pac_Local] BIT NOT NULL,
    [pac_Display] BIT NOT NULL
);

CREATE TABLE [PerformanceActionsForServices] (
    [pac_ID] INT NOT NULL -- PK,
    [svc_ID] INT NOT NULL -- PK
);

CREATE TABLE [PerformanceCheckMissing] (
    [acc_id] BIGINT NULL,
    [ratchet_id] BIGINT NULL,
    [sub_id] BIGINT NULL,
    [sub_name] VARCHAR(128) NULL,
    [start_date] DATE NULL,
    [end_date] DATE NULL,
    [chk_date] DATE NULL,
    [dsr_id] INT NOT NULL,
    [dsr_name] VARCHAR(50) NOT NULL,
    [target_imp] INT NULL,
    [Problem] VARCHAR(37) NOT NULL
);

CREATE TABLE [PerformanceGroups] (
    [peg_ID] INT NOT NULL -- PK,
    [peg_Name] VARCHAR(256) NOT NULL,
    [peg_ShortName] VARCHAR(256) NOT NULL,
    [peg_Sort] INT NOT NULL,
    [peg_Active] BIT NOT NULL
);

CREATE TABLE [PerformanceReportingMaximumDate] (
    [pmd_ID] INT NOT NULL -- PK,
    [dsr_ID] INT NOT NULL,
    [pmd_reportingMaxDate] DATE NOT NULL,
    [pmd_lastUpdated] DATETIME NOT NULL
);

CREATE TABLE [PlatformAgeMapping] (
    [MappingID] INT NOT NULL -- PK,
    [PlatformID] INT NOT NULL,
    [PlatformAgeValue] NVARCHAR(50) NOT NULL,
    [AgeGroupID] INT NOT NULL,
    [IsActive] BIT NOT NULL,
    [CreatedDate] DATETIME2 NOT NULL
);

CREATE TABLE [PlatformAuto_Campaign_Flights] (
    [pulldate] DATETIME NOT NULL,
    [id] VARCHAR(20) NOT NULL,
    [third_party_dealer_id] VARCHAR(20) NOT NULL,
    [campaign_id] VARCHAR(20) NOT NULL,
    [flight_id] VARCHAR(20) NOT NULL,
    [promotion_type] NCHAR(10) NULL,
    [vdp_views] INT NOT NULL,
    [fb_clicks] INT NOT NULL,
    [product_views] INT NOT NULL,
    [cost] MONEY NOT NULL,
    [impressions] INT NOT NULL,
    [unique_srp_visitors] INT NOT NULL,
    [unique_vdp_visitors] INT NOT NULL,
    [is_remarketing] BIT NOT NULL
);

CREATE TABLE [PlatformAuto_Campaigns] (
    [plc_id] BIGINT NOT NULL -- PK,
    [acc_id] BIGINT NOT NULL,
    [pla_dlr_id] BIGINT NOT NULL,
    [cmp_id] BIGINT NOT NULL,
    [plc_date] INT NOT NULL,
    [local_views] INT NOT NULL,
    [srp_visits] INT NOT NULL,
    [vdp_views] INT NOT NULL,
    [plc_cost] FLOAT NOT NULL,
    [pcl_type] VARCHAR(64) NOT NULL,
    [iml_id] INT NOT NULL,
    [cmp_name] VARCHAR(255) NULL,
    [is_remarketing] BIT NULL,
    [flight_id] INT NULL,
    [product_views] INT NULL
);

CREATE TABLE [PlatformAuto_Dealers] (
    [acc_id] BIGINT NOT NULL,
    [pla_dlr_id] BIGINT NOT NULL,
    [dlr_name] VARCHAR(128) NOT NULL,
    [dlr_zip] VARCHAR(5) NOT NULL,
    [dlr_city] VARCHAR(128) NOT NULL,
    [dlr_state] VARCHAR(2) NOT NULL,
    [dlr_address] VARCHAR(128) NOT NULL,
    [dlr_url] VARCHAR(128) NOT NULL,
    [iml_id] INT NOT NULL
);

CREATE TABLE [PlatformAuto_Dealers_ExtraInfo] (
    [id] BIGINT NULL,
    [dealer_name] VARCHAR(128) NULL,
    [zip] VARCHAR(64) NULL,
    [city] VARCHAR(128) NULL,
    [state] VARCHAR(64) NULL,
    [address] VARCHAR(255) NULL,
    [url] VARCHAR(255) NULL,
    [third_party_id_ex] VARCHAR(255) NULL,
    [fb_page_id] VARCHAR(255) NULL,
    [contact_email] VARCHAR(255) NULL,
    [utm_code] VARCHAR(255) NULL,
    [ga_id] VARCHAR(255) NULL,
    [monthly_budget] INT NULL,
    [first_month_budget] INT NULL,
    [pilot_date_start] VARCHAR(128) NULL,
    [pilot_date_end] VARCHAR(128) NULL,
    [promotion_type] VARCHAR(64) NULL,
    [language] VARCHAR(64) NULL,
    [contact_phone] VARCHAR(64) NULL,
    [privacy_link] VARCHAR(255) NULL,
    [contact_link] VARCHAR(255) NULL,
    [third_party_dealer_id] VARCHAR(64) NULL
);

CREATE TABLE [PlatformAuto_FlightCampaigns] (
    [acc_id] VARCHAR(50) NOT NULL,
    [pla_dlr_id] VARCHAR(50) NOT NULL,
    [plfc_id] VARCHAR(24) NOT NULL,
    [plfc_date] INT NOT NULL,
    [promotion_type] VARCHAR(50) NOT NULL,
    [vdp_views] INT NOT NULL,
    [product_views] INT NOT NULL,
    [cost] FLOAT NOT NULL,
    [impressions] INT NOT NULL,
    [unique_srp_visitors] INT NOT NULL,
    [unique_vdp_visitors] INT NOT NULL,
    [iml_id] INT NOT NULL
);

CREATE TABLE [PlatformAuto_get_dealers] (
    [dealer_id] VARCHAR(128) NULL,
    [name] VARCHAR(128) NULL,
    [third_party_dealer_id] BIGINT NULL,
    [third_party_id_ex] VARCHAR(128) NULL,
    [address] VARCHAR(128) NULL,
    [city] VARCHAR(128) NULL,
    [state] VARCHAR(128) NULL,
    [zip] VARCHAR(128) NULL,
    [url] VARCHAR(128) NULL,
    [utm_code] VARCHAR(128) NULL,
    [fb_page_id] VARCHAR(128) NULL,
    [ga_id] VARCHAR(128) NULL,
    [pilot_date_start] DATE NULL,
    [pilot_date_end] DATE NULL,
    [monthly_budget] MONEY NULL,
    [first_month_budget] MONEY NULL,
    [promotion_type] VARCHAR(16) NULL,
    [language] VARCHAR(16) NULL,
    [contact_email] VARCHAR(128) NULL,
    [contact_phone] VARCHAR(32) NULL,
    [contact_link] VARCHAR(128) NULL,
    [privacy_link] VARCHAR(128) NULL
);

CREATE TABLE [PlatformAuto_get_stats_by_dealer] (
    [dealer_id] BIGINT NULL,
    [name] VARCHAR(128) NULL,
    [third_party_dealer_id] BIGINT NULL,
    [business_unit] VARCHAR(128) NULL,
    [promotion_type] VARCHAR(64) NULL,
    [city] VARCHAR(64) NULL,
    [utm_code] VARCHAR(256) NULL,
    [current_status] VARCHAR(64) NULL,
    [vdp_views] INT NULL,
    [product_views] INT NULL,
    [current_vdp_goal] INT NULL,
    [prorated] VARCHAR(64) NULL,
    [monthly_budget] MONEY NULL,
    [cost] MONEY NULL,
    [impressions] INT NULL,
    [unique_srp_visitors] INT NULL,
    [per_impression] MONEY NULL,
    [per_unique_srp_visitor] MONEY NULL,
    [per_vdp_view] MONEY NULL,
    [per_vdp_view_14_day] MONEY NULL,
    [tmpi_feed_status] VARCHAR(64) NULL,
    [live_date] DATE NULL,
    [end_date] DATE NULL,
    [method] VARCHAR(64) NULL,
    [current_fb_page_access] VARCHAR(64) NULL,
    [tmpi_feed_status.import_enabled] VARCHAR(64) NULL,
    [tmpi_feed_status.count_date] DATE NULL,
    [tmpi_feed_status.count_usable_vin] INT NULL,
    [tmpi_feed_status.count_has_vdp_url] INT NULL,
    [tmpi_feed_status.count_eligible_rows] INT NULL
);

CREATE TABLE [PlatformAuto_GetActiveCampaignFlight_info] (
    [dealer_id] INT NULL,
    [campaign_id] INT NULL,
    [name] VARCHAR(256) NULL,
    [campaign_type] VARCHAR(256) NULL,
    [start_date] VARCHAR(16) NULL,
    [end_date] VARCHAR(16) NULL,
    [total_budget] MONEY NULL,
    [total_vdp_views] INT NULL,
    [is_remarketing] VARCHAR(16) NULL,
    [status] VARCHAR(16) NULL,
    [active_flight_id] INT NULL,
    [response] VARCHAR(256) NULL,
    [error_message] VARCHAR(256) NULL
);

CREATE TABLE [PlatformAuto_GetFlight_info] (
    [flight_id] NVARCHAR(4000) NULL,
    [dealer_id] NVARCHAR(4000) NULL,
    [start_date] NVARCHAR(4000) NULL,
    [end_date] NVARCHAR(4000) NULL,
    [campaign_type] NVARCHAR(4000) NULL,
    [total_budget] NVARCHAR(4000) NULL,
    [total_vdp_views] NVARCHAR(4000) NULL,
    [use_remarketing] NVARCHAR(4000) NULL,
    [remarketing_vdps] NVARCHAR(4000) NULL,
    [zip_list] NVARCHAR(4000) NULL,
    [city_radius_targeting] NVARCHAR(4000) NULL,
    [targeting_type] NVARCHAR(4000) NULL,
    [radius] NVARCHAR(4000) NULL,
    [cancelled] NVARCHAR(4000) NULL,
    [status] NVARCHAR(4000) NULL,
    [update_pending] NVARCHAR(4000) NULL
);

CREATE TABLE [PlatformAuto_MoveDealerId_Changes] (
    [acc_id] BIGINT NULL,
    [sub_id] BIGINT NULL,
    [adv_name] VARCHAR(128) NULL,
    [old_prov_id] VARCHAR(128) NULL,
    [new_prov_id] VARCHAR(128) NULL,
    [sub_start] VARCHAR(32) NULL,
    [sub_end] VARCHAR(32) NULL,
    [Captured] DATETIME NULL
);

CREATE TABLE [PlatformAuto_Stats] (
    [pls_id] BIGINT NOT NULL -- PK,
    [pls_date] INT NOT NULL,
    [veh_vin] VARCHAR(17) NOT NULL,
    [pla_dlr_id] BIGINT NOT NULL,
    [pla_lst_id] BIGINT NOT NULL,
    [acc_id] BIGINT NOT NULL,
    [srp_impressions] INT NOT NULL,
    [vdp_impressions] INT NOT NULL,
    [iml_id] INT NOT NULL,
    [lst_id] BIGINT NULL,
    [year] INT NULL,
    [make] VARCHAR(100) NULL,
    [model] VARCHAR(100) NULL,
    [campaign_id] INT NULL
);

CREATE TABLE [PlatformAuto_Stats_temp] (
    [pls_id] BIGINT NOT NULL,
    [pls_date] INT NOT NULL,
    [veh_vin] VARCHAR(17) NOT NULL,
    [pla_dlr_id] BIGINT NOT NULL,
    [pla_lst_id] BIGINT NOT NULL,
    [acc_id] BIGINT NOT NULL,
    [srp_impressions] INT NOT NULL,
    [vdp_impressions] INT NOT NULL,
    [iml_id] INT NOT NULL,
    [lst_id] BIGINT NULL,
    [year] INT NULL,
    [make] VARCHAR(100) NULL,
    [model] VARCHAR(100) NULL,
    [campaign_id] INT NULL
);

CREATE TABLE [PlatformAuto_Stats_VKLeeSave] (
    [pls_id] BIGINT NOT NULL,
    [pls_date] INT NOT NULL,
    [veh_vin] VARCHAR(17) NOT NULL,
    [pla_dlr_id] BIGINT NOT NULL,
    [pla_lst_id] BIGINT NOT NULL,
    [acc_id] BIGINT NOT NULL,
    [srp_impressions] INT NOT NULL,
    [vdp_impressions] INT NOT NULL,
    [iml_id] INT NOT NULL,
    [lst_id] BIGINT NULL,
    [year] INT NULL,
    [make] VARCHAR(100) NULL,
    [model] VARCHAR(100) NULL,
    [campaign_id] INT NULL
);

CREATE TABLE [PlatformCampaignMapping] (
    [pcm_ID] INT NOT NULL,
    [platform_ID] INT NOT NULL,
    [pcm_Date] DATETIME NOT NULL,
    [pcm_Advertiser_Name] VARCHAR(256) NULL,
    [pcm_Campaign_Name] VARCHAR(256) NOT NULL,
    [pcm_Campaign_External_ID] VARCHAR(256) NOT NULL,
    [pcm_New_ID] BIGINT NOT NULL,
    [acc_ID] INT NOT NULL,
    [pcm_Created_Date] DATETIME NOT NULL
);

CREATE TABLE [PlatformGenderMapping] (
    [MappingID] INT NOT NULL -- PK,
    [PlatformID] INT NOT NULL,
    [PlatformGenderValue] NVARCHAR(50) NOT NULL,
    [GenderGroupID] INT NOT NULL,
    [IsActive] BIT NOT NULL,
    [CreatedDate] DATETIME2 NOT NULL
);

CREATE TABLE [Platforms] (
    [PlatformID] INT NOT NULL -- PK,
    [PlatformName] NVARCHAR(50) NOT NULL,
    [PlatformCode] NVARCHAR(10) NOT NULL,
    [IsActive] BIT NOT NULL,
    [CreatedDate] DATETIME2 NOT NULL,
    [DataSourceID] INT NULL,
    [Provider] VARCHAR(20) NULL,
    [ProductId] INT NULL
);

CREATE TABLE [Provider_Entity_Mapping] (
    [nav_query] VARCHAR(211) NOT NULL,
    [adv_acc_id] BIGINT NULL,
    [adv_id] BIGINT NULL,
    [pl_language] VARCHAR(32) NULL,
    [latest_pla_dlr_id] INT NULL
);

CREATE TABLE [ReportGenerator] (
    [id] INT NOT NULL -- PK,
    [name] VARCHAR(100) NOT NULL,
    [sendto] VARCHAR(500) NOT NULL,
    [subject] VARCHAR(500) NOT NULL,
    [body] VARCHAR(MAX) NOT NULL,
    [sql] VARCHAR(MAX) NOT NULL,
    [sqltype] INT NOT NULL,
    [enabled] BIT NOT NULL,
    [approvedHash] VARCHAR(32) NULL,
    [cron] VARCHAR(128) NULL,
    [filename] VARCHAR(128) NULL,
    [reporttype] VARCHAR(10) NULL,
    [createdby] INT NOT NULL,
    [modifiedBy] INT NOT NULL,
    [created] DATETIME NOT NULL,
    [modified] DATETIME NOT NULL,
    [category] VARCHAR(100) NULL,
    [cc] VARCHAR(500) NULL,
    [bcc] VARCHAR(500) NULL
);

CREATE TABLE [SegmentedCampaignPerformance] (
    [PerformanceID] BIGINT NOT NULL -- PK,
    [CampaignID] BIGINT NOT NULL,
    [ReportDate] DATE NOT NULL,
    [AgeGroupID] INT NOT NULL,
    [GenderGroupID] INT NOT NULL,
    [Impressions] BIGINT NOT NULL,
    [Clicks] BIGINT NOT NULL,
    [Spend] DECIMAL(15,4) NOT NULL,
    [Conversions] INT NOT NULL,
    [ConversionValue] DECIMAL(15,4) NOT NULL,
    [CTR] DECIMAL(30,26) NULL,
    [CPC] DECIMAL(35,24) NULL,
    [CPM] DECIMAL(38,22) NULL,
    [ConversionRate] DECIMAL(30,26) NULL,
    [CostPerConversion] DECIMAL(26,15) NULL,
    [ROAS] DECIMAL(35,20) NULL,
    [PlatformId] INT NULL,
    [CreatedDate] DATETIME2 NOT NULL,
    [LastUpdated] DATETIME2 NOT NULL
);

CREATE TABLE [SegmentedCampaignPerformance_Staging] (
    [CampaignID] BIGINT NOT NULL,
    [ReportDate] DATE NOT NULL,
    [AgeGroupID] INT NOT NULL,
    [GenderGroupID] INT NOT NULL,
    [Impressions] BIGINT NOT NULL,
    [Clicks] BIGINT NOT NULL,
    [Spend] DECIMAL(15,4) NOT NULL,
    [Conversions] INT NOT NULL,
    [ConversionValue] DECIMAL(15,4) NOT NULL,
    [PlatformId] INT NULL
);

CREATE TABLE [SQLInjectionCheck] (
    [Table_Column] VARCHAR(512) NULL,
    [Rows_Infected] INT NULL
);

CREATE TABLE [sysdiagrams] (
    [name] NVARCHAR(128) NOT NULL,
    [principal_id] INT NOT NULL,
    [diagram_id] INT NOT NULL -- PK,
    [version] INT NULL,
    [definition] VARBINARY(MAX) NULL
);

CREATE TABLE [TikTokCampaignDataset] (
    [external_id] VARCHAR(256) NOT NULL,
    [conversions] INT NULL,
    [results] INT NULL,
    [deep_funnel_results] INT NULL,
    [date] DATE NULL
);

CREATE TABLE [TikTokWebsiteMetrics] (
    [external_id] VARCHAR(256) NOT NULL,
    [event_date] DATE NOT NULL,
    [advertiser_id] VARCHAR(64) NULL,
    [advertiser_name] NVARCHAR(256) NULL,
    [campaign_name] NVARCHAR(256) NULL,
    [page_content_view_events] INT NULL,
    [total_landing_page_view] INT NULL,
    [total_pageview] INT NULL
);

CREATE TABLE [VDPDanburyBackup] (
    [acc_id] BIGINT NOT NULL,
    [dsr_id] INT NOT NULL,
    [vdp_date] INT NOT NULL,
    [impressions] INT NOT NULL,
    [clicks] INT NOT NULL,
    [vdp_views] INT NOT NULL,
    [ctr] FLOAT NULL,
    [cost] FLOAT NOT NULL,
    [type] VARCHAR(64) NOT NULL,
    [iml_id] INT NOT NULL,
    [cmp_name] VARCHAR(255) NULL,
    [is_remarketing] BIT NULL,
    [flight_id] INT NULL
);

CREATE TABLE [VDPHillside] (
    [acc_id] BIGINT NOT NULL,
    [dsr_id] INT NOT NULL,
    [vdp_date] INT NOT NULL,
    [impressions] INT NOT NULL,
    [clicks] INT NOT NULL,
    [vdp_views] INT NOT NULL,
    [ctr] FLOAT NULL,
    [cost] FLOAT NOT NULL,
    [type] VARCHAR(64) NOT NULL,
    [iml_id] INT NOT NULL,
    [cmp_name] VARCHAR(255) NULL,
    [is_remarketing] BIT NULL,
    [flight_id] INT NULL,
    [veh_type] VARCHAR(10) NULL,
    [vdp_new] INT NULL
);

CREATE TABLE [VDPPerformance] (
    [acc_id] BIGINT NOT NULL,
    [dsr_id] INT NOT NULL,
    [vdp_date] INT NOT NULL,
    [impressions] INT NOT NULL,
    [clicks] INT NOT NULL,
    [vdp_views] INT NOT NULL,
    [ctr] FLOAT NULL,
    [cost] FLOAT NOT NULL,
    [type] VARCHAR(64) NOT NULL,
    [iml_id] INT NOT NULL,
    [cmp_name] VARCHAR(255) NULL,
    [is_remarketing] BIT NULL,
    [flight_id] INT NULL
);

CREATE TABLE [VDPPerformanceBackup] (
    [acc_id] BIGINT NOT NULL,
    [dsr_id] INT NOT NULL,
    [vdp_date] INT NOT NULL,
    [impressions] INT NOT NULL,
    [clicks] INT NOT NULL,
    [vdp_views] INT NOT NULL,
    [ctr] FLOAT NULL,
    [cost] FLOAT NOT NULL,
    [type] VARCHAR(64) NOT NULL,
    [iml_id] INT NOT NULL,
    [cmp_name] VARCHAR(255) NULL,
    [is_remarketing] BIT NULL,
    [flight_id] INT NULL,
    [daytotalvdp] INT NULL,
    [daytotalclicks] INT NULL,
    [share] DECIMAL(7,5) NULL,
    [newvdp] INT NULL,
    [numcampaign] INT NULL
);

CREATE TABLE [VDPPerformanceBackupTim] (
    [acc_id] BIGINT NOT NULL,
    [dsr_id] INT NOT NULL,
    [vdp_date] INT NOT NULL,
    [impressions] INT NOT NULL,
    [clicks] INT NOT NULL,
    [vdp_views] INT NOT NULL,
    [ctr] FLOAT NULL,
    [cost] FLOAT NOT NULL,
    [type] VARCHAR(64) NOT NULL,
    [iml_id] INT NOT NULL,
    [cmp_name] VARCHAR(255) NULL,
    [is_remarketing] BIT NULL,
    [flight_id] INT NULL
);

CREATE TABLE [VDPPerformanceBackupv2] (
    [acc_id] BIGINT NOT NULL,
    [dsr_id] INT NOT NULL,
    [vdp_date] INT NOT NULL,
    [impressions] INT NOT NULL,
    [clicks] INT NOT NULL,
    [vdp_views] INT NOT NULL,
    [ctr] FLOAT NULL,
    [cost] FLOAT NOT NULL,
    [type] VARCHAR(64) NOT NULL,
    [iml_id] INT NOT NULL,
    [cmp_name] VARCHAR(255) NULL,
    [is_remarketing] BIT NULL,
    [flight_id] INT NULL,
    [daytotalvdp] INT NULL,
    [daytotalclicks] INT NULL,
    [share] DECIMAL(7,5) NULL,
    [newvdp] INT NULL,
    [numcampaign] INT NULL
);

CREATE TABLE [VDPPerformanceBackupv3] (
    [acc_id] BIGINT NOT NULL,
    [dsr_id] INT NOT NULL,
    [vdp_date] INT NOT NULL,
    [impressions] INT NOT NULL,
    [clicks] INT NOT NULL,
    [vdp_views] INT NOT NULL,
    [ctr] FLOAT NULL,
    [cost] FLOAT NOT NULL,
    [type] VARCHAR(64) NOT NULL,
    [iml_id] INT NOT NULL,
    [cmp_name] VARCHAR(255) NULL,
    [is_remarketing] BIT NULL,
    [flight_id] INT NULL,
    [daytotalvdp] INT NULL,
    [daytotalclicks] INT NULL,
    [share] DECIMAL(7,5) NULL,
    [newvdp] INT NULL,
    [numcampaign] INT NULL
);

CREATE TABLE [VDPSERPPerformance] (
    [vdp_id] BIGINT NOT NULL -- PK,
    [vdp_date] INT NOT NULL,
    [lst_id] BIGINT NULL,
    [lst_vin] VARCHAR(32) NULL,
    [serp_views] INT NOT NULL,
    [vdp_views] INT NOT NULL,
    [iml_id] INT NOT NULL
);

CREATE TABLE [vdptemp] (
    [d] VARCHAR(20) NULL,
    [vin] VARCHAR(20) NULL,
    [vdp] INT NULL,
    [srp] INT NULL
);

CREATE TABLE [vdptempEA] (
    [d] INT NULL,
    [lstid] INT NULL,
    [vin] VARCHAR(20) NULL,
    [dlrid] VARCHAR(20) NULL,
    [srp] INT NULL,
    [vdp] INT NULL
);

CREATE TABLE [VDPVINPerformance] (
    [flight_id] INT NULL,
    [acc_id] INT NOT NULL,
    [vdp_date] DATETIME NOT NULL,
    [lst_id] INT NOT NULL,
    [dsr_id] INT NOT NULL,
    [impressions] INT NOT NULL,
    [clicks] INT NOT NULL,
    [vdp_views] INT NOT NULL
);

CREATE TABLE [VehicleSnapshot] (
    [veh_year] VARCHAR(256) NULL,
    [veh_make] VARCHAR(256) NULL,
    [veh_model] VARCHAR(1024) NULL,
    [veh_trim] VARCHAR(256) NULL,
    [veh_vin] VARCHAR(256) NOT NULL,
    [veh_stock_no] VARCHAR(256) NOT NULL,
    [veh_url] VARCHAR(8000) NULL,
    [insert_date] DATETIME NULL
);

CREATE TABLE [VideoAdCampaignGeoData] (
    [Id] INT NOT NULL -- PK,
    [PlatformID] INT NOT NULL,
    [CampaignId] NVARCHAR(100) NOT NULL,
    [CampaignName] NVARCHAR(500) NOT NULL,
    [ReportDate] DATE NOT NULL,
    [Country] NVARCHAR(100) NOT NULL,
    [State] NVARCHAR(100) NULL,
    [City] NVARCHAR(200) NULL,
    [PostalCode] NVARCHAR(20) NULL,
    [DMACode] NVARCHAR(20) NULL,
    [Impressions] BIGINT NOT NULL,
    [Clicks] BIGINT NOT NULL,
    [CTR] DECIMAL(18,4) NOT NULL,
    [VideoCompletions25] BIGINT NOT NULL,
    [VideoCompletions50] BIGINT NOT NULL,
    [VideoCompletions75] BIGINT NOT NULL,
    [VideoCompletions100] BIGINT NOT NULL,
    [CreatedAt] DATETIME2 NOT NULL,
    [UpdatedAt] DATETIME2 NOT NULL
);

CREATE TABLE [VideoAdCampaignInventoryData] (
    [Id] INT NOT NULL -- PK,
    [PlatformID] INT NOT NULL,
    [CampaignId] NVARCHAR(100) NOT NULL,
    [CampaignName] NVARCHAR(500) NOT NULL,
    [ReportDate] DATE NOT NULL,
    [Site] NVARCHAR(500) NULL,
    [Supply] NVARCHAR(200) NULL,
    [Deal] NVARCHAR(200) NULL,
    [Impressions] BIGINT NOT NULL,
    [Clicks] BIGINT NOT NULL,
    [CTR] DECIMAL(18,4) NOT NULL,
    [VideoCompletions25] BIGINT NOT NULL,
    [VideoCompletions50] BIGINT NOT NULL,
    [VideoCompletions75] BIGINT NOT NULL,
    [VideoCompletions100] BIGINT NOT NULL,
    [CreatedAt] DATETIME2 NOT NULL,
    [UpdatedAt] DATETIME2 NOT NULL
);

CREATE TABLE [VideoAdCampaignReportData] (
    [Id] INT NOT NULL -- PK,
    [PlatformID] INT NOT NULL,
    [CampaignId] NVARCHAR(100) NOT NULL,
    [CampaignName] NVARCHAR(500) NOT NULL,
    [ReportDate] DATE NOT NULL,
    [Impressions] BIGINT NOT NULL,
    [Clicks] BIGINT NOT NULL,
    [CTR] DECIMAL(18,4) NOT NULL,
    [UserAgent] NVARCHAR(500) NOT NULL,
    [DeviceType] NVARCHAR(100) NOT NULL,
    [VideoCompletions25] BIGINT NOT NULL,
    [VideoCompletions50] BIGINT NOT NULL,
    [VideoCompletions75] BIGINT NOT NULL,
    [VideoCompletions100] BIGINT NOT NULL,
    [VideoCompletionRate25] DECIMAL(18,4) NOT NULL,
    [VideoCompletionRate50] DECIMAL(18,4) NOT NULL,
    [VideoCompletionRate75] DECIMAL(18,4) NOT NULL,
    [VideoCompletionRate100] DECIMAL(18,4) NOT NULL,
    [CreatedAt] DATETIME2 NOT NULL,
    [UpdatedAt] DATETIME2 NOT NULL
);

CREATE TABLE [VideoAdCampaignTechnologyData] (
    [Id] INT NOT NULL -- PK,
    [PlatformID] INT NOT NULL,
    [CampaignId] NVARCHAR(100) NOT NULL,
    [CampaignName] NVARCHAR(500) NOT NULL,
    [ReportDate] DATE NOT NULL,
    [OperatingSystem] NVARCHAR(200) NULL,
    [BrowserType] NVARCHAR(200) NULL,
    [BrowserVersion] NVARCHAR(100) NULL,
    [DeviceType] NVARCHAR(100) NULL,
    [EnvironmentType] NVARCHAR(100) NULL,
    [Impressions] BIGINT NOT NULL,
    [Clicks] BIGINT NOT NULL,
    [CTR] DECIMAL(18,4) NOT NULL,
    [VideoCompletions25] BIGINT NOT NULL,
    [VideoCompletions50] BIGINT NOT NULL,
    [VideoCompletions75] BIGINT NOT NULL,
    [VideoCompletions100] BIGINT NOT NULL,
    [CreatedAt] DATETIME2 NOT NULL,
    [UpdatedAt] DATETIME2 NOT NULL
);

CREATE TABLE [VideoAdPlatformTokens] (
    [Id] INT NOT NULL -- PK,
    [PlatformID] INT NOT NULL,
    [AccessToken] NVARCHAR(MAX) NOT NULL,
    [RefreshToken] NVARCHAR(MAX) NOT NULL,
    [ExpiresAt] DATETIME2 NOT NULL,
    [TokenType] NVARCHAR(50) NOT NULL,
    [CreatedAt] DATETIME2 NOT NULL,
    [UpdatedAt] DATETIME2 NOT NULL,
    [IsActive] BIT NOT NULL
);

CREATE TABLE [VINtoURLMapping] (
    [veh_vin] VARCHAR(17) NOT NULL,
    [veh_url] VARCHAR(1024) NOT NULL,
    [created] DATETIME NOT NULL
);

CREATE TABLE [YextBusinessCategories] (
    [tmpId] BIGINT NOT NULL -- PK,
    [id] INT NULL,
    [name] NVARCHAR(MAX) NULL,
    [fullName] NVARCHAR(MAX) NULL,
    [selectable] BIT NULL,
    [parentId] INT NULL
);

CREATE TABLE [YextCustomer] (
    [tmpId] BIGINT NOT NULL -- PK,
    [id] NVARCHAR(MAX) NOT NULL,
    [businessName] NVARCHAR(MAX) NULL,
    [contactFirstName] NVARCHAR(MAX) NULL,
    [contactLastName] NVARCHAR(MAX) NULL,
    [contactPhone] NVARCHAR(MAX) NULL,
    [contactEmail] NVARCHAR(MAX) NULL,
    [loginToken] NVARCHAR(MAX) NULL,
    [_ratchetId] INT NULL,
    [_ignore] BIT NULL
);

CREATE TABLE [YextLocation] (
    [tmpId] BIGINT NOT NULL -- PK,
    [id] NVARCHAR(MAX) NULL,
    [customerId] NVARCHAR(MAX) NULL,
    [locationName] NVARCHAR(MAX) NULL,
    [address] NVARCHAR(MAX) NULL,
    [address2] NVARCHAR(MAX) NULL,
    [suppressAddress] BIT NULL,
    [city] NVARCHAR(MAX) NULL,
    [state] NVARCHAR(MAX) NULL,
    [zip] NVARCHAR(MAX) NULL,
    [phone] NVARCHAR(MAX) NULL,
    [isPhoneTracked] BIT NULL,
    [localPhone] NVARCHAR(MAX) NULL,
    [alternatePhone] NVARCHAR(MAX) NULL,
    [faxPhone] NVARCHAR(MAX) NULL,
    [mobilePhone] NVARCHAR(MAX) NULL,
    [tollFreePhone] NVARCHAR(MAX) NULL,
    [ttyPhone] NVARCHAR(MAX) NULL,
    [yextCategoryIds_array] NVARCHAR(MAX) NULL,
    [partnerCategoryIds_array] NVARCHAR(MAX) NULL,
    [specialOffer] NVARCHAR(MAX) NULL,
    [specialOfferUrl] NVARCHAR(MAX) NULL,
    [specialOfferLinkText] NVARCHAR(MAX) NULL,
    [specialOffersDeal] BIT NULL,
    [websiteUrl] NVARCHAR(MAX) NULL,
    [reservationUrl] NVARCHAR(MAX) NULL,
    [description] NVARCHAR(MAX) NULL,
    [paymentMethods_array] NVARCHAR(MAX) NULL,
    [logo] NVARCHAR(MAX) NULL,
    [hours] NVARCHAR(MAX) NULL,
    [videoUrls_array] NVARCHAR(MAX) NULL,
    [yearEstablished] NVARCHAR(MAX) NULL,
    [displayLat] FLOAT NULL,
    [displayLng] FLOAT NULL,
    [routableLat] FLOAT NULL,
    [routableLng] FLOAT NULL,
    [emails_array] NVARCHAR(MAX) NULL,
    [specialties_array] NVARCHAR(MAX) NULL,
    [services_array] NVARCHAR(MAX) NULL,
    [brands_array] NVARCHAR(MAX) NULL,
    [languages_array] NVARCHAR(MAX) NULL,
    [keywords_array] NVARCHAR(MAX) NULL,
    [photos_array] NVARCHAR(MAX) NULL,
    [bios_array] NVARCHAR(MAX) NULL,
    [promotions_array] NVARCHAR(MAX) NULL
);

CREATE TABLE [YextReportDownloader] (
    [reportKey] VARCHAR(256) NOT NULL -- PK,
    [customerId] VARCHAR(50) NOT NULL,
    [requested] DATETIME NOT NULL,
    [downloaded] DATETIME NULL
);

CREATE TABLE [YextReview] (
    [locationId] NVARCHAR(250) NULL,
    [siteId] NVARCHAR(250) NULL,
    [rating] FLOAT NULL,
    [title] NVARCHAR(250) NULL,
    [content] NVARCHAR(MAX) NULL,
    [authorName] NVARCHAR(250) NULL,
    [url] NVARCHAR(250) NULL,
    [reviewDate] NVARCHAR(250) NULL
);

CREATE TABLE [YextSubscription] (
    [tmpId] BIGINT NOT NULL -- PK,
    [id] BIGINT NULL,
    [customerId] NVARCHAR(MAX) NULL,
    [offerId] INT NULL,
    [locationIds_array] NVARCHAR(MAX) NULL,
    [status] NVARCHAR(MAX) NULL,
    [paidThroughDate] DATE NULL,
    [features_array] NVARCHAR(MAX) NULL
);

CREATE TABLE [YextTmpiCategoryMapping] (
    [tmpiCategoryId] INT NOT NULL -- PK,
    [yextCategoryId] INT NOT NULL -- PK,
    [tpmiCategoryName] VARCHAR(512) NOT NULL,
    [yextCategoryName] VARCHAR(512) NOT NULL
);
