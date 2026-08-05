-- Trax Database — DDL Schema Dump
-- Source: SQL Server 20.51.108.231
-- Generated: 2026-06-11
-- Schema-only; no data. Re-extract to refresh.

CREATE TABLE [__FeedInfoJoined] (
    [mfiID] INT NOT NULL -- PK,
    [aggDate] VARCHAR(16) NULL,
    [pubid] INT NOT NULL,
    [pubname] VARCHAR(64) NOT NULL,
    [edtag] VARCHAR(64) NOT NULL,
    [fdid] VARCHAR(32) NOT NULL,
    [fduid] INT NOT NULL,
    [dlrid] INT NULL,
    [fdname] VARCHAR(64) NOT NULL,
    [fdphone] VARCHAR(16) NOT NULL,
    [fdzip] VARCHAR(5) NULL,
    [fdemail] VARCHAR(96) NOT NULL,
    [adcount] INT NOT NULL,
    [adwithprice] INT NOT NULL,
    [imgsinglecount] INT NOT NULL,
    [imgmulticount] INT NOT NULL,
    [lqOldAutomotive] INT NOT NULL,
    [lqOldLocal] INT NOT NULL,
    [lqNewAutomotive] INT NOT NULL,
    [lqNewLocal] INT NOT NULL,
    [MonthSearch] INT NOT NULL,
    [MonthDetail] INT NOT NULL,
    [MonthPrinted] INT NOT NULL,
    [MonthViewPhotos] INT NOT NULL,
    [MonthDirections] INT NOT NULL,
    [MonthDealer] INT NOT NULL,
    [MonthWebsite] INT NOT NULL,
    [OldMonthSearch] INT NOT NULL,
    [OldMonthDetail] INT NOT NULL,
    [OldMonthPrinted] INT NOT NULL,
    [OldMonthViewPhotos] INT NOT NULL,
    [OldMonthDirections] INT NOT NULL,
    [OldMonthDealer] INT NOT NULL,
    [OldMonthWebsite] INT NOT NULL,
    [lqNewVast] INT NOT NULL,
    [lqNewDealix] INT NOT NULL,
    [lqNewWhosCalling] INT NOT NULL,
    [lqWeb2Carz] INT NOT NULL,
    [lqCarDomain] INT NOT NULL,
    [lqCarsDirect] INT NOT NULL,
    [lqWeb2CarzPaid] INT NULL,
    [lqiSeeCars] INT NULL,
    [lqOodlePaid] INT NULL,
    [lqGetAuto] INT NULL,
    [lqeDriveAuto] INT NULL,
    [lqLemonFree] INT NULL,
    [lqCarGurus] INT NULL,
    [lqAutoByTel] INT NULL,
    [lqHighGear] INT NULL,
    [lqWantAdDigest] INT NULL,
    [lqCGEnhanced] INT NULL,
    [lqDXEnhanced] INT NULL,
    [lqLendingTree] INT NULL,
    [lqMerchantCircle] INT NULL,
    [lqAutoList] INT NULL,
    [lqAutabuy] INT NULL,
    [lqEveryAuto] INT NULL,
    [lqDealSea] INT NULL,
    [lqDetroitTrading] INT NULL,
    [lqCraigsListDT] INT NULL,
    [lqDominionVDP] INT NULL,
    [lqTEN] INT NULL,
    [lqDealerCMO] INT NULL,
    [lqPlatformAuto] INT NULL,
    [lqPromolisity] INT NULL,
    [lqTMP_CL] INT NULL,
    [lqMarchex] INT NULL,
    [lqAutoMarketingDirect] INT NULL,
    [lqRentus] INT NULL,
    [lqTapClassifieds] INT NULL,
    [lqAuction123] INT NULL,
    [lqResponseLogix] INT NULL,
    [lqResponsePath] INT NULL,
    [lqFacebook] INT NULL,
    [lqBestRide.com] INT NULL,
    [lqBRcomFree] INT NULL,
    [lqYouTubeLV] INT NULL,
    [lqInstaVid360] INT NULL,
    [lqCraigsListLV] INT NULL,
    [lqeBayMotorsLV] INT NULL,
    [lqCreditLogix] INT NULL,
    [lqGoogleAds] INT NULL,
    [lqMicrosoftAds] INT NULL
);

CREATE TABLE [acc_id_lst_ID] (
    [acc_id] INT NOT NULL -- PK,
    [lst_id] INT NOT NULL -- PK
);

CREATE TABLE [Actions] (
    [actID] INT NOT NULL -- PK,
    [actName] VARCHAR(128) NOT NULL,
    [actSort] INT NOT NULL,
    [actSection] INT NOT NULL,
    [actForAds] BIT NOT NULL
);

CREATE TABLE [AdCapture_Bot] (
    [adcID] BIGINT NOT NULL -- PK,
    [actID] INT NOT NULL,
    [adcDate] INT NOT NULL,
    [lstID] INT NOT NULL,
    [isBot] BIT NOT NULL,
    [logkey] VARCHAR(32) NOT NULL
);

CREATE TABLE [AdCapture_DailyTotal] (
    [adtID] BIGINT NOT NULL -- PK,
    [actID] INT NOT NULL,
    [adtDate] INT NOT NULL,
    [lstID] INT NOT NULL,
    [adtTotalNonBot] INT NOT NULL,
    [adtTotalBot] INT NOT NULL
);

CREATE TABLE [AdCapture_MonthlyTotal] (
    [amtID] BIGINT NOT NULL -- PK,
    [actID] INT NOT NULL,
    [amtDate] INT NOT NULL,
    [lstID] INT NOT NULL,
    [amtTotalNonBot] INT NOT NULL,
    [amtTotalBot] INT NOT NULL
);

CREATE TABLE [addmulticapture] (
    [lstID_List] VARCHAR(4000) NULL,
    [actID] INT NULL
);

CREATE TABLE [AdTotal] (
    [adtID] INT NOT NULL -- PK,
    [actID] INT NOT NULL,
    [adtMonthYear] INT NOT NULL,
    [lstID] INT NOT NULL,
    [adtTotal] INT NOT NULL
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

CREATE TABLE [DealerCapture] (
    [dlcID] INT NOT NULL -- PK,
    [actID] INT NOT NULL,
    [dlcDate] INT NOT NULL,
    [accID] INT NOT NULL,
    [isBot] BIT NOT NULL,
    [logkey] VARCHAR(32) NOT NULL
);

CREATE TABLE [DealerCapture_DailyTotal] (
    [ddtID] BIGINT NOT NULL -- PK,
    [actID] INT NOT NULL,
    [ddtDate] INT NOT NULL,
    [accID] INT NOT NULL,
    [ddtTotalNonBot] INT NOT NULL,
    [ddtTotalBot] INT NOT NULL
);

CREATE TABLE [DealerCapture_MonthlyTotal] (
    [dmtID] BIGINT NOT NULL -- PK,
    [actID] INT NOT NULL,
    [dmtDate] INT NOT NULL,
    [accID] INT NOT NULL,
    [dmtTotalNonBot] INT NOT NULL,
    [dmtTotalBot] INT NOT NULL
);

CREATE TABLE [DealerOptions] (
    [dloID] INT NOT NULL -- PK,
    [accID] INT NOT NULL,
    [dloOptions] VARCHAR(128) NOT NULL,
    [dloGrab] INT NOT NULL
);

CREATE TABLE [DealerTotal] (
    [dltID] INT NOT NULL -- PK,
    [actID] INT NOT NULL,
    [dltMonthYear] INT NOT NULL,
    [accID] INT NOT NULL,
    [dltTotal] INT NOT NULL
);

CREATE TABLE [dsrestore] (
    [dsid] INT NULL,
    [adid_old] INT NULL,
    [adid_new] INT NULL
);

CREATE TABLE [imageproxy_blanks] (
    [acc_ID] INT NOT NULL,
    [lst_ID] INT NOT NULL
);

CREATE TABLE [IntMaxes] (
    [IntMax] INT NULL,
    [TableName] VARCHAR(64) NULL,
    [ColumnName] VARCHAR(64) NULL
);

CREATE TABLE [InvalidCapture] (
    [ic_id] BIGINT NOT NULL -- PK,
    [actID] INT NOT NULL,
    [ic_Date] SMALLDATETIME NOT NULL,
    [lstID] INT NOT NULL,
    [accID] INT NOT NULL,
    [ic_reason] VARCHAR(2048) NOT NULL,
    [tfk_id] INT NOT NULL,
    [ic_ip] VARCHAR(50) NOT NULL
);

CREATE TABLE [LogFile] (
    [lfName] VARCHAR(4000) NULL,
    [lfCreated] DATETIME NULL,
    [lfSize] BIGINT NULL
);

CREATE TABLE [MagnetoFeedInfo] (
    [mfiID] INT NOT NULL -- PK,
    [aggDate] VARCHAR(16) NULL,
    [pubid] INT NOT NULL,
    [pubname] VARCHAR(64) NOT NULL,
    [edtag] VARCHAR(64) NOT NULL,
    [fdid] VARCHAR(32) NOT NULL,
    [fduid] INT NOT NULL,
    [dlrid] INT NULL,
    [fdname] VARCHAR(64) NOT NULL,
    [fdphone] VARCHAR(16) NOT NULL,
    [fdzip] VARCHAR(5) NULL,
    [fdemail] VARCHAR(96) NOT NULL,
    [adcount] INT NULL,
    [adwithprice] INT NULL,
    [imgsinglecount] INT NULL,
    [imgmulticount] INT NULL,
    [lqOldAutomotive] INT NULL,
    [lqOldLocal] INT NULL
);

CREATE TABLE [myreturn] (
    [acc_ID] INT NOT NULL,
    [acc_Company] VARCHAR(64) NOT NULL,
    [acc_displayname] VARCHAR(64) NULL,
    [acc_Phone] VARCHAR(16) NOT NULL,
    [acc_email_XML] VARCHAR(128) NOT NULL,
    [acc_email_String] VARCHAR(128) NOT NULL,
    [aso_Value] VARCHAR(128) NOT NULL,
    [aso_id] INT NOT NULL,
    [acc_id_rep] INT NULL,
    [acc_login_rep] VARCHAR(128) NULL
);

CREATE TABLE [ProcessLog] (
    [prlID] INT NOT NULL -- PK,
    [dteProcess] INT NOT NULL,
    [Step] INT NOT NULL,
    [prlDate] SMALLDATETIME NOT NULL
);

CREATE TABLE [Report] (
    [repID] INT NOT NULL -- PK,
    [repName] VARCHAR(32) NOT NULL,
    [repURL] VARCHAR(512) NOT NULL,
    [repDescription] VARCHAR(512) NOT NULL
);

CREATE TABLE [ReportUser] (
    [rusID] INT NOT NULL -- PK,
    [repID] INT NOT NULL,
    [usrID] INT NOT NULL
);

CREATE TABLE [SmartAd_Performance] (
    [adv_acc_id] BIGINT NULL,
    [adv_name] NVARCHAR(512) NULL,
    [sales_channel] NVARCHAR(1024) NULL,
    [prd_package] NVARCHAR(255) NULL,
    [cmp_id] BIGINT NOT NULL,
    [subscription_id] BIGINT NULL,
    [ratchet_id] BIGINT NULL,
    [adunitid] BIGINT NULL,
    [size] NVARCHAR(10) NULL,
    [DateOfEvent] NVARCHAR(10) NULL,
    [Impressions] NUMERIC(20,0) NULL,
    [Clicks] NUMERIC(20,0) NULL
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

CREATE TABLE [TrafficFilterIP] (
    [tfip_id] INT NOT NULL -- PK,
    [tfip_value] VARCHAR(50) NOT NULL,
    [tfiip_active] BIT NOT NULL
);

CREATE TABLE [TrafficFilterKeyword] (
    [tfk_id] INT NOT NULL -- PK,
    [tfk_value] VARCHAR(512) NOT NULL,
    [tfk_active] BIT NOT NULL
);

CREATE TABLE [User] (
    [usrID] INT NOT NULL -- PK,
    [usrADAccount] VARCHAR(32) NOT NULL,
    [usrFirstName] VARCHAR(32) NOT NULL,
    [usrLastName] VARCHAR(32) NOT NULL,
    [ofcID] INT NOT NULL
);
