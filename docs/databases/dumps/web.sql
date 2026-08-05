-- Web Database — DDL Schema Dump
-- Source: SQL Server 20.51.108.231
-- Generated: 2026-06-11
-- Schema-only; no data. Re-extract to refresh.

CREATE TABLE [_FolderContentKeeper] (
    [fckID] INT NOT NULL -- PK,
    [fcmID] INT NULL,
    [fckName] VARCHAR(4000) NULL,
    [fckType] VARCHAR(32) NULL,
    [fckSize] INT NULL,
    [fckModified] DATETIME NULL,
    [Adnum] VARCHAR(128) NULL,
    [LastUpload] DATETIME NULL
);

CREATE TABLE [_FolderContentManager] (
    [fcmID] INT NOT NULL -- PK,
    [fcmPath] VARCHAR(4000) NOT NULL,
    [fcmPattern] VARCHAR(1024) NOT NULL,
    [fcmDate] DATETIME NOT NULL,
    [pubID] INT NULL
);

CREATE TABLE [_MonthlyInternet] (
    [Office] VARCHAR(8000) NULL,
    [dbname] NVARCHAR(128) NULL,
    [cusid] INT NOT NULL,
    [cusName] VARCHAR(132) NULL,
    [cusphone] VARCHAR(16) NOT NULL,
    [cusrep] VARCHAR(24) NOT NULL,
    [adnum] INT NOT NULL,
    [adtype] INT NOT NULL,
    [description] VARCHAR(64) NOT NULL,
    [slsnumber] INT NOT NULL,
    [edid] INT NOT NULL,
    [edname] VARCHAR(32) NOT NULL,
    [slsrundate] DATETIME NOT NULL,
    [slsrep] VARCHAR(24) NOT NULL,
    [slscost] MONEY NOT NULL,
    [features] VARCHAR(1024) NULL,
    [depid] INT NOT NULL,
    [depname] VARCHAR(64) NOT NULL
);

CREATE TABLE [_PubMapping] (
    [Info] VARCHAR(11) NOT NULL,
    [pubID] INT NOT NULL,
    [pubName] VARCHAR(64) NOT NULL,
    [pubIP] VARCHAR(32) NOT NULL,
    [pubDB] VARCHAR(16) NOT NULL,
    [pubWebPic] VARCHAR(512) NULL,
    [pubImgURL] VARCHAR(8000) NULL,
    [dns_domain] VARCHAR(255) NULL,
    [dns_value] VARCHAR(255) NULL,
    [srv_Name] VARCHAR(64) NULL,
    [sip_address] VARCHAR(64) NULL,
    [pix_open_ports] VARCHAR(1024) NULL
);

CREATE TABLE [_Steven_Activates] (
    [DateLive] DATETIME NULL,
    [DlrName] VARCHAR(128) NULL,
    [Price] VARCHAR(64) NULL,
    [DateCancel] DATETIME NULL,
    [Notes] VARCHAR(4096) NULL,
    [Office] VARCHAR(64) NULL,
    [RepName] VARCHAR(64) NULL,
    [AccountID] VARCHAR(20) NOT NULL -- PK
);

CREATE TABLE [_Steven_Deactivates] (
    [DateLive] DATETIME NULL,
    [DlrName] VARCHAR(128) NULL,
    [Price] VARCHAR(64) NULL,
    [DateCancel] DATETIME NULL,
    [Notes] VARCHAR(4096) NULL,
    [Office] VARCHAR(64) NULL,
    [RepName] VARCHAR(64) NULL,
    [AccountID] VARCHAR(20) NOT NULL -- PK
);

CREATE TABLE [abdataTest] (
    [CUSTID] VARCHAR(18) NULL,
    [SCLID] VARCHAR(16) NULL,
    [ADNUM] VARCHAR(12) NULL,
    [ADTEXT] VARCHAR(4096) NULL,
    [ADYEAR] VARCHAR(4) NULL,
    [ADMAKE] VARCHAR(64) NULL,
    [ADMODEL] VARCHAR(64) NULL,
    [ADSUBMODEL] VARCHAR(32) NULL,
    [ADPRICE] VARCHAR(12) NULL,
    [ADVIN] VARCHAR(32) NULL,
    [ADMILES] VARCHAR(7) NULL,
    [ADPHONE] VARCHAR(16) NULL,
    [ADPIC1] VARCHAR(512) NULL,
    [ADPIC2] VARCHAR(512) NULL,
    [ADPIC3] VARCHAR(512) NULL,
    [ADPIC4] VARCHAR(512) NULL,
    [ADPREF] VARCHAR(21) NULL,
    [ADTHUMB] VARCHAR(256) NULL,
    [ADSTOCK] VARCHAR(16) NULL,
    [id2] INT NOT NULL,
    [x] INT NULL
);

CREATE TABLE [accextras] (
    [acc_id] INT NOT NULL -- PK,
    [pub_id] INT NOT NULL,
    [fduid] INT NOT NULL,
    [aso_id] INT NOT NULL,
    [acc_id_rep] VARCHAR(1) NOT NULL,
    [fdid] VARCHAR(32) NOT NULL,
    [fdedid] INT NOT NULL,
    [fdimg4] VARCHAR(512) NULL
);

CREATE TABLE [AccountBackground] (
    [acc_ID] INT NOT NULL -- PK,
    [abg_Name] VARCHAR(255) NULL
);

CREATE TABLE [AccountClassification] (
    [acc_id] BIGINT NOT NULL -- PK,
    [classification] VARCHAR(50) NOT NULL,
    [tfn] VARCHAR(10) NOT NULL,
    [cl_exclude] BIT NOT NULL,
    [cl_no_price] BIT NOT NULL,
    [cl_no_email] BIT NOT NULL,
    [modified] DATETIME NULL,
    [cl_no_phone] BIT NULL,
    [textn] VARCHAR(10) NULL,
    [has_overlay] BIT NULL,
    [exclude_single_photo] BIT NULL,
    [show_demo] BIT NULL
);

CREATE TABLE [accountclassification_20170626] (
    [acc_id] BIGINT NOT NULL,
    [classification] VARCHAR(50) NOT NULL,
    [tfn] VARCHAR(10) NOT NULL,
    [cl_exclude] BIT NOT NULL,
    [cl_no_price] BIT NOT NULL,
    [cl_no_email] BIT NOT NULL,
    [modified] DATETIME NULL,
    [cl_no_phone] BIT NULL,
    [textn] VARCHAR(10) NULL
);

CREATE TABLE [ActionGroup] (
    [ActionGroupID] INT NOT NULL -- PK,
    [ActionGroupName] VARCHAR(50) NOT NULL
);

CREATE TABLE [Actions] (
    [ActionID] INT NOT NULL -- PK,
    [ActionName] VARCHAR(50) NOT NULL,
    [ActionGroupID] INT NOT NULL
);

CREATE TABLE [acxAds] (
    [dlrid] VARCHAR(32) NULL,
    [adid] VARCHAR(50) NULL,
    [adstock] VARCHAR(64) NULL,
    [advin] VARCHAR(20) NULL,
    [adtype] VARCHAR(64) NULL,
    [admake] VARCHAR(32) NULL,
    [admodel] VARCHAR(128) NULL,
    [adtrim] VARCHAR(36) NULL,
    [adyear] INT NULL,
    [admiles] INT NULL,
    [adheadline] VARCHAR(32) NULL,
    [adtext] VARCHAR(3084) NULL,
    [adprice] VARCHAR(6) NULL,
    [adphone] VARCHAR(16) NULL,
    [adextcolor] VARCHAR(128) NULL,
    [adintcolor] VARCHAR(128) NULL,
    [adpic1] VARCHAR(512) NULL,
    [adpic2] VARCHAR(512) NULL,
    [adpic3] VARCHAR(512) NULL,
    [adpic4] VARCHAR(512) NULL,
    [adpic5] VARCHAR(512) NULL,
    [adpic6] VARCHAR(512) NULL,
    [adpic7] VARCHAR(512) NULL,
    [adpic8] VARCHAR(512) NULL,
    [adpic9] VARCHAR(512) NULL,
    [adpic10] VARCHAR(512) NULL,
    [adpic11] VARCHAR(512) NULL,
    [adpic12] VARCHAR(512) NULL,
    [adpic13] VARCHAR(512) NULL,
    [adpic14] VARCHAR(512) NULL,
    [adpic15] VARCHAR(512) NULL,
    [adpic16] VARCHAR(512) NULL,
    [adpic17] VARCHAR(512) NULL,
    [adpic18] VARCHAR(512) NULL,
    [adpic19] VARCHAR(512) NULL,
    [adpic20] VARCHAR(512) NULL,
    [adpic21] VARCHAR(512) NULL,
    [adpic22] VARCHAR(512) NULL,
    [adpic23] VARCHAR(512) NULL,
    [adpic24] VARCHAR(512) NULL,
    [adpic25] VARCHAR(512) NULL,
    [adpic26] VARCHAR(512) NULL,
    [adpics] VARCHAR(2048) NULL,
    [adcertified] BIT NULL,
    [adnewused] VARCHAR(8) NULL
);

CREATE TABLE [acxAds_Import_wURL] (
    [edid] INT NULL,
    [dlrid] INT NULL,
    [adid] VARCHAR(8) NULL,
    [adstock] VARCHAR(64) NULL,
    [advin] VARCHAR(20) NULL,
    [adtype] VARCHAR(64) NULL,
    [admake] VARCHAR(32) NULL,
    [admodel] VARCHAR(128) NULL,
    [adtrim] VARCHAR(128) NULL,
    [adyear] INT NULL,
    [admiles] INT NULL,
    [adheadline] VARCHAR(32) NULL,
    [adtext] VARCHAR(8000) NULL,
    [adprice] VARCHAR(512) NULL,
    [adphone] VARCHAR(32) NULL,
    [adextcolor] VARCHAR(64) NULL,
    [adintcolor] VARCHAR(64) NULL,
    [adpic1] VARCHAR(256) NULL,
    [adpic2] VARCHAR(256) NULL,
    [adpic3] VARCHAR(256) NULL,
    [adpic4] VARCHAR(256) NULL,
    [adpic5] VARCHAR(256) NULL,
    [adpic6] VARCHAR(256) NULL,
    [adpic7] VARCHAR(256) NULL,
    [adpic8] VARCHAR(256) NULL,
    [adpic9] VARCHAR(256) NULL,
    [adpic10] VARCHAR(256) NULL,
    [adpic11] VARCHAR(256) NULL,
    [adpic12] VARCHAR(256) NULL,
    [adpic13] VARCHAR(256) NULL,
    [adpic14] VARCHAR(256) NULL,
    [adpic15] VARCHAR(256) NULL,
    [adpic16] VARCHAR(256) NULL,
    [adpic17] VARCHAR(256) NULL,
    [adpic18] VARCHAR(256) NULL,
    [adpic19] VARCHAR(256) NULL,
    [adpic20] VARCHAR(256) NULL,
    [adpic21] VARCHAR(256) NULL,
    [adpic22] VARCHAR(256) NULL,
    [adpic23] VARCHAR(256) NULL,
    [adpic24] VARCHAR(256) NULL,
    [adpic25] VARCHAR(256) NULL,
    [adpic26] VARCHAR(256) NULL,
    [certified] VARCHAR(8) NULL,
    [newused] VARCHAR(8) NULL,
    [adURL] VARCHAR(256) NULL,
    [adpics] VARCHAR(2048) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [acxDealers] (
    [dlrid] VARCHAR(32) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAdd1] VARCHAR(128) NULL,
    [dlrAdd2] VARCHAR(128) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrUrl] VARCHAR(512) NULL,
    [dlrPhone] VARCHAR(16) NULL,
    [dlrZip] INT NULL,
    [dlrCity] VARCHAR(32) NULL,
    [dlrState] VARCHAR(2) NULL,
    [dlrCusid] INT NULL
);

CREATE TABLE [acxDealers_Import_wURL] (
    [edid] INT NULL,
    [dlrid] INT NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAdd1] VARCHAR(128) NULL,
    [dlrAdd2] VARCHAR(128) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrUrl] VARCHAR(128) NULL,
    [dlrPhone] VARCHAR(20) NULL,
    [dlrZip] INT NULL,
    [dlrCity] VARCHAR(32) NULL,
    [dlrState] VARCHAR(2) NULL,
    [dlrCusid] INT NULL
);

CREATE TABLE [ad_deleted] (
    [adid] INT NULL,
    [edid] INT NULL,
    [deldate] DATETIME NULL
);

CREATE TABLE [ad_inserted] (
    [adid] INT NULL,
    [edid] INT NULL,
    [deldate] DATETIME NULL
);

CREATE TABLE [ad_updated] (
    [adid] INT NULL,
    [edid] INT NULL,
    [deldate] DATETIME NULL
);

CREATE TABLE [ADDETAIL] (
    [ADID] INT NOT NULL -- PK,
    [ADTEXT] VARCHAR(4096) NOT NULL,
    [ADHTML] TEXT NULL,
    [ADHEADLINE] VARCHAR(128) NULL,
    [ADBOXED] BIT NULL,
    [ADYEAR] SMALLINT NULL,
    [ADMAKE] VARCHAR(32) NULL,
    [ADMODEL] VARCHAR(128) NULL,
    [ADSUBMODEL] VARCHAR(128) NULL,
    [ADPRICE] MONEY NULL,
    [ADPHONE] VARCHAR(16) NULL,
    [ADPIC1] VARCHAR(512) NULL,
    [ADPIC2] VARCHAR(512) NULL,
    [ADPIC3] VARCHAR(512) NULL,
    [ADPIC4] VARCHAR(512) NULL
);

CREATE TABLE [AdExclude] (
    [aeID] INT NOT NULL -- PK,
    [PubID] INT NOT NULL,
    [AdID] INT NOT NULL
);

CREATE TABLE [adez_feed] (
    [ffID] INT NOT NULL,
    [acc_ID_Submitted] INT NULL,
    [acc_ID_Submitted_Event] INT NULL,
    [ffDateSubmitted] DATETIME NULL,
    [aso_ID] INT NULL,
    [ftID] INT NULL,
    [ftName] VARCHAR(32) NULL,
    [ffDateSold] DATETIME NULL,
    [ffIDMaster] INT NOT NULL,
    [ffCusID] INT NULL,
    [ffwName] VARCHAR(64) NULL,
    [acc_ID_Rep] INT NULL,
    [ffwAddress1] VARCHAR(64) NULL,
    [ffwAddress2] VARCHAR(64) NULL,
    [ffwCity] VARCHAR(32) NULL,
    [ffwState] VARCHAR(2) NULL,
    [ffwZip] VARCHAR(10) NULL,
    [ffwPhone] VARCHAR(16) NULL,
    [ffwURL] VARCHAR(512) NULL,
    [ffwEmail_String] VARCHAR(96) NULL,
    [ffwEmail_XML] VARCHAR(96) NULL,
    [ffwEmail_Contact] VARCHAR(96) NULL,
    [ffbCompany] VARCHAR(64) NULL,
    [ffbContact] VARCHAR(64) NULL,
    [ffbAddress1] VARCHAR(64) NULL,
    [ffbAddress2] VARCHAR(64) NULL,
    [ffbCity] VARCHAR(32) NULL,
    [ffbState] VARCHAR(2) NULL,
    [ffbZip] VARCHAR(10) NULL,
    [ffbPhone] VARCHAR(16) NULL,
    [ffbEmail] VARCHAR(96) NULL,
    [ffPrice] MONEY NULL,
    [fiID] INT NULL,
    [fiName] VARCHAR(32) NULL,
    [ffAggregatorName] VARCHAR(64) NULL,
    [ffAggregatorContact] VARCHAR(64) NULL,
    [ffAggregatorAddress] VARCHAR(64) NULL,
    [ffAggregatorPhone] VARCHAR(16) NULL,
    [ffAggregatorEmail] VARCHAR(96) NULL,
    [ffNotes] VARCHAR(8000) NULL,
    [ffDateOfEvent] DATETIME NULL,
    [ffDateAggregatorContact] DATETIME NULL,
    [ffDateAggregatorETAConnect] DATETIME NULL,
    [ffDateLive] DATETIME NULL,
    [ffDateOFReqSent] DATETIME NULL,
    [ffDateOFLive] DATETIME NULL,
    [ffDateSalesLiveQA] DATETIME NULL,
    [ffDateSalesOFQA] DATETIME NULL,
    [fsID] INT NULL,
    [fsName] VARCHAR(32) NULL,
    [wmtID] INT NULL,
    [wmtName] VARCHAR(64) NULL,
    [fduid] INT NULL,
    [ffTrackingNumber] VARCHAR(16) NULL,
    [ffwContact_Name] VARCHAR(255) NULL,
    [ffFirstMonthPrice] MONEY NULL,
    [ffLastMonthPrice] MONEY NULL,
    [rdg_ID] INT NOT NULL,
    [ffExcludeRAN] BIT NULL,
    [ffExcludeRCY] BIT NULL,
    [ffoHeader] VARCHAR(256) NULL,
    [ffoFooter] VARCHAR(256) NULL,
    [ffaActive] FLOAT NULL,
    [ffaLastModified] DATETIME NULL
);

CREATE TABLE [ADHISTORY] (
    [AHID] INT NOT NULL -- PK,
    [SUBID] INT NOT NULL,
    [AHSTART] SMALLDATETIME NOT NULL,
    [AHEND] SMALLDATETIME NOT NULL,
    [AHACTIVE] BIT NOT NULL,
    [AHINSERTS] INT NOT NULL
);

CREATE TABLE [ADIMAGES] (
    [ADID] INT NOT NULL -- PK,
    [IMGURL] VARCHAR(512) NOT NULL -- PK,
    [IMGSORT] TINYINT NOT NULL
);

CREATE TABLE [AdminDomains] (
    [DOMID] INT NOT NULL -- PK,
    [DOMAIN] VARCHAR(50) NOT NULL
);

CREATE TABLE [AdRates] (
    [rID] INT NOT NULL -- PK,
    [EdID] INT NOT NULL,
    [rCost] MONEY NOT NULL,
    [rInsertions] SMALLINT NOT NULL,
    [rInsertionsRenewal] SMALLINT NOT NULL,
    [rMinWords] SMALLINT NOT NULL,
    [rMaxCharacters] INT NOT NULL,
    [rWordCost] MONEY NOT NULL,
    [rBoxCost] MONEY NOT NULL,
    [rBoxShow] BIT NOT NULL,
    [rHeadlineCost] MONEY NOT NULL,
    [rHeadlineShow] BIT NOT NULL,
    [rPhotoAd] BIT NOT NULL,
    [rRTIS] BIT NOT NULL,
    [rLabel] VARCHAR(768) NOT NULL,
    [rShow] BIT NOT NULL,
    [rDefault] BIT NOT NULL,
    [rVC] BIT NOT NULL,
    [rEditions] INT NULL,
    [rOrder] INT NOT NULL,
    [rDealers] BIT NOT NULL,
    [rPreferredCost] MONEY NOT NULL,
    [rPreferredShow] BIT NOT NULL,
    [rOnlineOnly] BIT NOT NULL,
    [rMaxPrice] MONEY NOT NULL,
    [rMaxFreeAds] INT NOT NULL,
    [rMaxRenewalsDays] INT NOT NULL,
    [rMaxDeadDays] VARCHAR(20) NULL,
    [rDestinations] VARCHAR(128) NULL,
    [rComboEdID] INT NULL,
    [rAdminLabel] VARCHAR(512) NOT NULL,
    [rAdminNotes] VARCHAR(512) NOT NULL,
    [rGroup] INT NOT NULL,
    [rUseCounterforAll] BIT NULL,
    [rPrintPhoto] BIT NULL,
    [rMaxOnlineCharacters] INT NOT NULL,
    [rMaxOnlineWord] INT NOT NULL,
    [rMaxOnlineWordCost] MONEY NOT NULL,
    [rPicMaxFree] INT NOT NULL,
    [rPicCost] MONEY NULL,
    [rPicMaxTotal] INT NOT NULL
);

CREATE TABLE [ADS] (
    [ADID] INT NOT NULL -- PK,
    [EDID] INT NOT NULL,
    [SCLID] INT NOT NULL,
    [DLRID] INT NOT NULL,
    [MEMID] INT NOT NULL,
    [ADNUM] INT NOT NULL,
    [ADTYPE] TINYINT NOT NULL,
    [ADCOST] MONEY NULL,
    [ADSPECIAL] TINYINT NOT NULL,
    [ADTOP] TINYINT NULL
);

CREATE TABLE [AdvantageCheck] (
    [memid] INT NOT NULL,
    [adcount] INT NULL,
    [maxads] INT NOT NULL,
    [cusid] INT NULL,
    [dlname] VARCHAR(64) NULL,
    [dlphone] VARCHAR(16) NULL,
    [dlsalesrep] VARCHAR(64) NULL,
    [pubid] INT NULL,
    [pubdb] VARCHAR(16) NOT NULL,
    [pubname] VARCHAR(64) NOT NULL,
    [rid] INT NOT NULL,
    [rlabel] VARCHAR(768) NOT NULL
);

CREATE TABLE [Advertisers] (
    [aID] INT NOT NULL -- PK,
    [aBook] VARCHAR(1) NOT NULL,
    [cusID] INT NOT NULL,
    [aPage] VARCHAR(64) NOT NULL,
    [cusName] VARCHAR(64) NOT NULL,
    [cusPhone] VARCHAR(32) NOT NULL,
    [aURL] VARCHAR(512) NULL,
    [aShowURL] BIT NOT NULL,
    [aShowAd] BIT NOT NULL,
    [aClass] INT NOT NULL,
    [aClassName] VARCHAR(64) NOT NULL
);

CREATE TABLE [AdvNotifyTable] (
    [ant_ID] INT NOT NULL -- PK,
    [ant_ADID] INT NOT NULL,
    [ant_mlt_ID] INT NOT NULL,
    [ant_Added] DATETIME NOT NULL,
    [ant_Sent] DATETIME NULL
);

CREATE TABLE [Aggregator] (
    [EDTAG] VARCHAR(64) NOT NULL -- PK,
    [atID] INT NULL,
    [Active] BIT NULL,
    [OverlayRemoved] BIT NULL
);

CREATE TABLE [AggregatorTier] (
    [atID] INT NOT NULL -- PK,
    [atDescription] VARCHAR(64) NULL,
    [slaOfficeNotify_dsold_dsub] TINYINT NULL,
    [slaAggConnect_dlive_daggcontact] TINYINT NULL,
    [slaLiveOnTMP_dlive_dlive] TINYINT NULL,
    [slaTTR1_dlive_dsold] TINYINT NULL,
    [slaLiveOnPS_dOFLive_dOFReqSent] TINYINT NULL,
    [slaTTR2_dlive_dsold] TINYINT NULL
);

CREATE TABLE [AlexClassification] (
    [Classification] VARCHAR(72) NULL,
    [aso_name] VARCHAR(72) NOT NULL -- PK
);

CREATE TABLE [AlexFridayReport] (
    [afr_ID] INT NOT NULL -- PK,
    [Week] INT NULL,
    [acc_id] VARCHAR(16) NULL,
    [aso_Name] VARCHAR(64) NOT NULL,
    [Client] VARCHAR(128) NOT NULL,
    [Sales_Rep] VARCHAR(64) NOT NULL,
    [Display] INT NOT NULL,
    [Local] INT NOT NULL,
    [RAN] INT NOT NULL,
    [Date_Modified] DATETIME NOT NULL
);

CREATE TABLE [AlexsCallList] (
    [dealer_id] VARCHAR(32) NULL,
    [dealer_name] NCHAR(128) NULL,
    [from_phone] NCHAR(32) NULL,
    [to_phone] NCHAR(32) NULL,
    [caller_name] NCHAR(128) NULL,
    [start_time] NCHAR(128) NULL,
    [end_time] NCHAR(128) NULL,
    [call_duration] NCHAR(128) NULL,
    [call_status] NCHAR(128) NULL
);

CREATE TABLE [AlexTurboChange] (
    [atc_ID] INT NOT NULL -- PK,
    [Insert_Date] DATETIME NOT NULL,
    [fduid] VARCHAR(32) NOT NULL,
    [Lead_Number] INT NOT NULL,
    [DestID] VARCHAR(2) NULL
);

CREATE TABLE [AllAutoNetworkAds] (
    [dlrID] VARCHAR(32) NULL,
    [adID] VARCHAR(32) NULL,
    [adStock] VARCHAR(32) NULL,
    [adVin] VARCHAR(32) NULL,
    [adSection] VARCHAR(32) NULL,
    [adCondition] VARCHAR(32) NULL,
    [adCertified] VARCHAR(8) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(64) NULL,
    [adSubModel] VARCHAR(64) NULL,
    [adYear] VARCHAR(8) NULL,
    [adMiles] VARCHAR(8) NULL,
    [adColor] VARCHAR(64) NULL,
    [adType] VARCHAR(24) NULL,
    [adHeadline] VARCHAR(1024) NULL,
    [adText] VARCHAR(8000) NULL,
    [adCrap] VARCHAR(8000) NULL,
    [adPrice] VARCHAR(16) NULL,
    [adPhone] VARCHAR(16) NULL,
    [adpic1t] VARCHAR(1024) NULL,
    [adPic1] VARCHAR(1024) NULL,
    [adPic2] VARCHAR(1024) NULL,
    [adPic3] VARCHAR(1024) NULL,
    [adPic4] VARCHAR(1024) NULL,
    [adPics] VARCHAR(8000) NULL,
    [adThumbs] VARCHAR(8000) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [AllAutoNetworkDealers] (
    [dlrID] VARCHAR(32) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(32) NULL,
    [dlrCity] VARCHAR(32) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZIP] VARCHAR(32) NULL,
    [dlrEmail] VARCHAR(64) NULL,
    [dlrURL] VARCHAR(64) NULL,
    [dlrPhone] VARCHAR(16) NULL
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

CREATE TABLE [AMData] (
    [dlrID] VARCHAR(32) NULL,
    [adID] VARCHAR(32) NULL,
    [adStock] VARCHAR(32) NULL,
    [adVin] VARCHAR(32) NULL,
    [adSection] VARCHAR(32) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(64) NULL,
    [adSubModel] VARCHAR(64) NULL,
    [adYear] VARCHAR(16) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adHeadline] VARCHAR(600) NULL,
    [adText] VARCHAR(6000) NULL,
    [adPrice] VARCHAR(16) NULL,
    [adPhone] VARCHAR(32) NULL,
    [adPics] VARCHAR(8000) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [AMDealers] (
    [dlrID] VARCHAR(32) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(128) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZip] VARCHAR(16) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrURL] VARCHAR(128) NULL,
    [dlrPhone] VARCHAR(32) NULL
);

CREATE TABLE [AREACODE] (
    [AREACODE] INT NOT NULL,
    [PREFIX] INT NOT NULL,
    [LOCATION] VARCHAR(50) NOT NULL
);

CREATE TABLE [AreGood] (
    [ffid] INT NULL,
    [ffidmaster] INT NULL,
    [jNotes] VARCHAR(32) NULL,
    [FDUID] INT NULL
);

CREATE TABLE [ARIAds] (
    [dlrID] VARCHAR(64) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(124) NULL,
    [dlrCity] VARCHAR(32) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZIP] VARCHAR(10) NULL,
    [dlrPhone] VARCHAR(16) NULL,
    [dlremail] VARCHAR(100) NULL,
    [dlrURL] VARCHAR(256) NULL,
    [adid] VARCHAR(64) NULL,
    [adtitle] VARCHAR(124) NULL,
    [adVIN] VARCHAR(64) NULL,
    [adStock] VARCHAR(17) NULL,
    [adyear] VARCHAR(24) NULL,
    [adMake] VARCHAR(128) NULL,
    [adModel] VARCHAR(128) NULL,
    [adtrim] VARCHAR(128) NULL,
    [adcat] VARCHAR(128) NULL,
    [adcatstyle] VARCHAR(128) NULL,
    [adcondition] VARCHAR(128) NULL,
    [adexteriorcolor] VARCHAR(128) NULL,
    [adtrimcolor] VARCHAR(128) NULL,
    [adlength] VARCHAR(64) NULL,
    [adprice] VARCHAR(64) NULL,
    [adpricetype] VARCHAR(64) NULL,
    [admiles] VARCHAR(64) NULL,
    [adusage] VARCHAR(64) NULL,
    [adupdated] VARCHAR(64) NULL,
    [admvdp] VARCHAR(256) NULL,
    [addescription] VARCHAR(8000) NULL,
    [adimages] VARCHAR(MAX) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [ariphotos] (
    [adid] VARCHAR(64) NULL,
    [imgurl] VARCHAR(8000) NULL,
    [imgsort] VARCHAR(8) NULL
);

CREATE TABLE [Auction123_Ads] (
    [CUSTID] VARCHAR(12) NULL,
    [ADVIN] VARCHAR(18) NULL,
    [ADSTOCK] VARCHAR(60) NULL,
    [ADCONDITION] VARCHAR(20) NULL,
    [ADCATEGORY] VARCHAR(36) NULL,
    [ADMAKE] VARCHAR(64) NULL,
    [ADMODEL] VARCHAR(128) NULL,
    [ADSUBMODEL] VARCHAR(64) NULL,
    [ADYEAR] VARCHAR(4) NULL,
    [ADENGINE] VARCHAR(60) NULL,
    [ADTRANS] VARCHAR(128) NULL,
    [ADEXTERIOR] VARCHAR(255) NULL,
    [ADINTERIOR] VARCHAR(255) NULL,
    [ADMILES] VARCHAR(7) NULL,
    [ADHEAD] VARCHAR(8000) NULL,
    [ADTEXT] VARCHAR(8000) NULL,
    [ADPRICE] VARCHAR(12) NULL,
    [ADPHONE] VARCHAR(32) NULL,
    [ADPIC1T] VARCHAR(8000) NULL,
    [ADPIC1] VARCHAR(8000) NULL,
    [ADPIC2] VARCHAR(1048) NULL,
    [ADPIC3] VARCHAR(1048) NULL,
    [ADPIC4] VARCHAR(1048) NULL,
    [ADPIC5] VARCHAR(1048) NULL,
    [ADPIC6] VARCHAR(1048) NULL,
    [ADPIC7] VARCHAR(1048) NULL,
    [ADPIC8] VARCHAR(1048) NULL,
    [ADPIC9] VARCHAR(1048) NULL,
    [ADPIC10] VARCHAR(1048) NULL,
    [ADPIC11] VARCHAR(1048) NULL,
    [ADPIC12] VARCHAR(1048) NULL,
    [ADPIC13] VARCHAR(1048) NULL,
    [ADPIC14] VARCHAR(4096) NULL,
    [ADPIC15] VARCHAR(1048) NULL,
    [ADPIC16] VARCHAR(1048) NULL,
    [ADPIC17] VARCHAR(4096) NULL,
    [ADPIC18] VARCHAR(1048) NULL,
    [ADPIC19] VARCHAR(1048) NULL,
    [ADPIC20] VARCHAR(4096) NULL,
    [ADPIC21] VARCHAR(4096) NULL,
    [ADPIC22] VARCHAR(4096) NULL,
    [ADPIC23] VARCHAR(4096) NULL,
    [ADPIC24] VARCHAR(4096) NULL,
    [ADPIC25] VARCHAR(8000) NULL,
    [ADPIC26] VARCHAR(8000) NULL,
    [DlrName] VARCHAR(64) NULL,
    [DlrAddress] VARCHAR(64) NULL,
    [DlrCity] VARCHAR(21) NULL,
    [Dlrstate] VARCHAR(2) NULL,
    [Dlrzip] VARCHAR(5) NULL,
    [DlrEmail] VARCHAR(64) NULL,
    [DlrURL] VARCHAR(256) NULL,
    [DlrPhone] VARCHAR(20) NULL,
    [adid] VARCHAR(32) NULL,
    [adgenericcolor] VARCHAR(32) NULL,
    [adinvoice] VARCHAR(10) NULL,
    [adMSRP] VARCHAR(10) NULL,
    [admodelcode] VARCHAR(32) NULL,
    [addateinstock] VARCHAR(12) NULL,
    [addoors] VARCHAR(1) NULL,
    [addrivetype] VARCHAR(32) NULL,
    [adfueltype] VARCHAR(32) NULL,
    [adEPACity] VARCHAR(4) NULL,
    [adEPAHighway] VARCHAR(4) NULL
);

CREATE TABLE [Auction123_Dealers] (
    [CUSTID] VARCHAR(12) NULL,
    [DLRNAME] VARCHAR(64) NULL,
    [DLRADDR] VARCHAR(64) NULL,
    [DLRCITY] VARCHAR(32) NULL,
    [DLRSTATE] VARCHAR(2) NULL,
    [DLRZIP] VARCHAR(10) NULL,
    [DLREMAIL] VARCHAR(128) NULL,
    [DLRURL] VARCHAR(512) NULL,
    [DLRPHONE] VARCHAR(32) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [AutaBuyAds] (
    [dlrID] VARCHAR(16) NULL,
    [adID] VARCHAR(16) NULL,
    [adStock] VARCHAR(64) NULL,
    [adVIN] VARCHAR(64) NULL,
    [adSection] VARCHAR(32) NULL,
    [adMake] VARCHAR(64) NULL,
    [adModel] VARCHAR(64) NULL,
    [adSubModel] VARCHAR(128) NULL,
    [adYear] VARCHAR(64) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adColor] VARCHAR(64) NULL,
    [adHeadline] VARCHAR(256) NULL,
    [adText] VARCHAR(8000) NULL,
    [adPrice] VARCHAR(8000) NULL,
    [adDoors] VARCHAR(16) NULL,
    [adintColor] VARCHAR(64) NULL,
    [adEngineSize] VARCHAR(32) NULL,
    [adTransmission] VARCHAR(64) NULL,
    [adPics] VARCHAR(8000) NULL,
    [adThumbs] VARCHAR(8000) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [AutaBuyDealers] (
    [dlrID] VARCHAR(16) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(32) NULL,
    [dlrState] VARCHAR(16) NULL,
    [dlrZipCode] VARCHAR(16) NULL,
    [dlrEmail] VARCHAR(64) NULL,
    [dlrURL] VARCHAR(512) NULL,
    [dlrPhone] VARCHAR(64) NULL,
    [dlrBidAmount] VARCHAR(16) NULL
);

CREATE TABLE [AutoAdManagerAds] (
    [dlrid] VARCHAR(16) NULL,
    [vin] VARCHAR(24) NULL,
    [stocknumber] VARCHAR(64) NULL,
    [condition] VARCHAR(12) NULL,
    [year] VARCHAR(4) NULL,
    [make] VARCHAR(64) NULL,
    [model] VARCHAR(64) NULL,
    [modelnumber] VARCHAR(32) NULL,
    [bodytype] VARCHAR(128) NULL,
    [transmission] VARCHAR(100) NULL,
    [trim] VARCHAR(64) NULL,
    [doors] VARCHAR(16) NULL,
    [miles] VARCHAR(12) NULL,
    [cylinders] VARCHAR(64) NULL,
    [displacement] VARCHAR(32) NULL,
    [drivetrain] VARCHAR(32) NULL,
    [extcolor] VARCHAR(128) NULL,
    [intcolor] VARCHAR(128) NULL,
    [invoice] VARCHAR(12) NULL,
    [msrp] VARCHAR(12) NULL,
    [bookvalue] VARCHAR(12) NULL,
    [sellingprice] VARCHAR(12) NULL,
    [dateinstock] VARCHAR(32) NULL,
    [certified] VARCHAR(12) NULL,
    [description] VARCHAR(8000) NULL,
    [options] VARCHAR(8000) NULL,
    [images] VARCHAR(8000) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [AutoBaseCustomers] (
    [DLRNAME] VARCHAR(64) NULL,
    [DLRADDR] VARCHAR(64) NULL,
    [DLRCITY] VARCHAR(32) NULL,
    [DLRSTATE] VARCHAR(2) NULL,
    [DLRZIP] VARCHAR(5) NULL,
    [DLRPHONE] VARCHAR(16) NULL,
    [DLREMAIL] VARCHAR(128) NULL,
    [DLRURL] VARCHAR(512) NULL,
    [CUSTID] VARCHAR(12) NULL
);

CREATE TABLE [AutoBaseCustomersNew] (
    [DLRNAME] VARCHAR(64) NULL,
    [DLRADDR] VARCHAR(64) NULL,
    [DLRCITY] VARCHAR(36) NULL,
    [DLRSTATE] VARCHAR(2) NULL,
    [DLRZIP] VARCHAR(5) NULL,
    [DLRPHONE] VARCHAR(36) NULL,
    [DLREMAIL] VARCHAR(128) NULL,
    [DLRURL] VARCHAR(128) NULL,
    [CUSTID] VARCHAR(12) NULL
);

CREATE TABLE [AutoBaseData] (
    [DLRID] VARCHAR(64) NULL,
    [DLRNAME] VARCHAR(64) NULL,
    [DLRADDR] VARCHAR(64) NULL,
    [DLRCITY] VARCHAR(36) NULL,
    [DLRSTATE] VARCHAR(10) NULL,
    [DLRZIP] VARCHAR(8) NULL,
    [DLREMAIL] VARCHAR(128) NULL,
    [DLRURL] VARCHAR(128) NULL,
    [DLRPHONE] VARCHAR(36) NULL,
    [ADNUM] VARCHAR(12) NULL,
    [ADSTOCK] VARCHAR(32) NULL,
    [ADVIN] VARCHAR(32) NULL,
    [SCLID] VARCHAR(32) NULL,
    [ADNEWUSED] VARCHAR(8) NULL,
    [ADCERTIFIED] VARCHAR(12) NULL,
    [ADYEAR] VARCHAR(8) NULL,
    [ADMAKE] VARCHAR(64) NULL,
    [ADMODEL] VARCHAR(64) NULL,
    [ADSUBMODEL] VARCHAR(32) NULL,
    [ADSTYLE] VARCHAR(32) NULL,
    [ADMILES] VARCHAR(10) NULL,
    [ADEXTCOLOR] VARCHAR(255) NULL,
    [ADEXTCOLORGeneric] VARCHAR(255) NULL,
    [ADINTCOLOR] VARCHAR(255) NULL,
    [ADHEADLINE] VARCHAR(100) NULL,
    [ADTEXT] VARCHAR(8000) NULL,
    [ADCOMMENTS] VARCHAR(8000) NULL,
    [ADPRICE] VARCHAR(12) NULL,
    [ADINVOICE] VARCHAR(12) NULL,
    [ADMSRP] VARCHAR(12) NULL,
    [ADPRICEMISC1] VARCHAR(16) NULL,
    [ADPRICEMISC2] VARCHAR(16) NULL,
    [ADMODELCODE] VARCHAR(255) NULL,
    [ADDATEINSTOCK] VARCHAR(36) NULL,
    [ADWHEELBASE] VARCHAR(36) NULL,
    [ADDOORS] VARCHAR(10) NULL,
    [ADTRANSMISSION] VARCHAR(64) NULL,
    [ADDRIVETYPE] VARCHAR(64) NULL,
    [ADENGINEDESCRIPTION] VARCHAR(64) NULL,
    [ADENGINECYCLINDERS] VARCHAR(255) NULL,
    [ADENGINEDISPLACEMENT] VARCHAR(36) NULL,
    [ADFUELTYPE] VARCHAR(36) NULL,
    [ADEPACITY] VARCHAR(36) NULL,
    [ADEPAHIGHWAY] VARCHAR(36) NULL,
    [ADPICS] VARCHAR(MAX) NULL,
    [ADTHUMB] VARCHAR(MAX) NULL,
    [ADVDP] VARCHAR(MAX) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [AutoBaseDataNew] (
    [CUSTID] VARCHAR(18) NULL,
    [SCLID] VARCHAR(16) NULL,
    [ADNUM] VARCHAR(12) NULL,
    [ADTEXT] VARCHAR(8000) NULL,
    [ADYEAR] VARCHAR(4) NULL,
    [ADMAKE] VARCHAR(64) NULL,
    [ADMODEL] VARCHAR(64) NULL,
    [ADSUBMODEL] VARCHAR(32) NULL,
    [ADPRICE] VARCHAR(12) NULL,
    [ADVIN] VARCHAR(32) NULL,
    [ADMILES] VARCHAR(7) NULL,
    [ADEXTCOLOR] VARCHAR(255) NULL,
    [ADPHONE] VARCHAR(36) NULL,
    [ADPIC1] VARCHAR(555) NULL,
    [ADPIC2] VARCHAR(555) NULL,
    [ADPIC3] VARCHAR(555) NULL,
    [ADPIC4] VARCHAR(555) NULL,
    [ADPIC5] VARCHAR(555) NULL,
    [ADPIC6] VARCHAR(555) NULL,
    [ADPIC7] VARCHAR(555) NULL,
    [ADPIC8] VARCHAR(555) NULL,
    [ADPIC9] VARCHAR(555) NULL,
    [ADPIC10] VARCHAR(555) NULL,
    [ADPIC11] VARCHAR(555) NULL,
    [ADPIC12] VARCHAR(555) NULL,
    [ADPIC13] VARCHAR(555) NULL,
    [ADPIC14] VARCHAR(555) NULL,
    [ADPIC15] VARCHAR(555) NULL,
    [ADPIC16] VARCHAR(555) NULL,
    [ADPIC17] VARCHAR(555) NULL,
    [ADPIC18] VARCHAR(555) NULL,
    [ADPIC19] VARCHAR(555) NULL,
    [ADPIC20] VARCHAR(555) NULL,
    [ADPIC21] VARCHAR(555) NULL,
    [ADPIC22] VARCHAR(555) NULL,
    [ADPIC23] VARCHAR(555) NULL,
    [ADPIC24] VARCHAR(555) NULL,
    [ADPIC25] VARCHAR(555) NULL,
    [ADPIC26] VARCHAR(555) NULL,
    [ADPREF] VARCHAR(21) NULL,
    [ADTHUMB] VARCHAR(555) NULL,
    [ADSTOCK] VARCHAR(16) NULL,
    [ADNEWUSED] VARCHAR(8) NULL,
    [ADCOMMENTS] VARCHAR(8000) NULL,
    [ADCERTIFIED] VARCHAR(4) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [AutoConX2Endeavor] (
    [xfrID] INT NOT NULL -- PK,
    [adCODE] VARCHAR(32) NOT NULL,
    [adnum] INT NOT NULL,
    [adphoto] VARCHAR(512) NULL,
    [adsent] SMALLDATETIME NOT NULL,
    [adverified] BIT NOT NULL,
    [PubID] INT NULL
);

CREATE TABLE [AutoConXAutomation] (
    [ACid] INT NOT NULL,
    [AClocationname] VARCHAR(128) NULL,
    [ACadtype] VARCHAR(64) NULL,
    [ACSeller] VARCHAR(128) NULL,
    [ACSubClass] VARCHAR(64) NULL,
    [ACEntryDate] DATETIME NULL,
    [ACstocknumber] VARCHAR(64) NULL,
    [ACadcode] VARCHAR(64) NULL,
    [ACVIN] VARCHAR(32) NULL,
    [ACyear] VARCHAR(4) NULL,
    [ACmake] VARCHAR(64) NULL,
    [ACmodel] VARCHAR(64) NULL,
    [ACtrim] VARCHAR(64) NULL,
    [ACequipment] VARCHAR(128) NULL,
    [ACmiles] VARCHAR(16) NULL,
    [ACtransmission] VARCHAR(32) NULL,
    [ACcylinders] VARCHAR(4) NULL,
    [ACfueltype] VARCHAR(16) NULL,
    [ACdrive] VARCHAR(32) NULL,
    [ACinteriorcolor] VARCHAR(32) NULL,
    [ACexteriorcolor] VARCHAR(32) NULL,
    [ACprintdesc] VARCHAR(2048) NULL,
    [ACprice] VARCHAR(32) NULL,
    [ACcity] VARCHAR(64) NULL,
    [ACstate] VARCHAR(4) NULL,
    [ACzip] VARCHAR(16) NULL,
    [ACphone] VARCHAR(32) NULL,
    [ACimgurl] VARCHAR(1024) NULL,
    [ACJPGFileName] VARCHAR(512) NULL,
    [ACNewUsed] VARCHAR(32) NULL,
    [ACOptional1] VARCHAR(1024) NULL,
    [ModifiedAt] DATETIME NULL,
    [FileName] VARCHAR(100) NULL
);

CREATE TABLE [AutoConXKey] (
    [ACXKEYID] INT NOT NULL -- PK,
    [ACXDLRID] VARCHAR(50) NOT NULL,
    [ACXADID] VARCHAR(20) NOT NULL,
    [ACXVIN] VARCHAR(20) NOT NULL,
    [ACXYEAR] INT NOT NULL,
    [ACXMAKE] VARCHAR(32) NOT NULL,
    [ACXMODEL] VARCHAR(128) NOT NULL,
    [ACXINSERTDATE] DATETIME NOT NULL
);

CREATE TABLE [AutoConXKey2] (
    [ACXKEYID] INT NOT NULL,
    [ACXDLRID] VARCHAR(50) NOT NULL,
    [ACXADID] VARCHAR(20) NOT NULL,
    [ACXVIN] VARCHAR(20) NOT NULL,
    [ACXYEAR] INT NOT NULL,
    [ACXMAKE] VARCHAR(32) NOT NULL,
    [ACXMODEL] VARCHAR(32) NOT NULL,
    [ACXINSERTDATE] DATETIME NOT NULL
);

CREATE TABLE [AutoCornerAds] (
    [DLRID] VARCHAR(18) NULL,
    [ADID] VARCHAR(24) NULL,
    [ADSTOCK] VARCHAR(16) NULL,
    [ADVIN] VARCHAR(32) NULL,
    [ADSECTION] VARCHAR(32) NULL,
    [ADMAKE] VARCHAR(64) NULL,
    [ADMODEL] VARCHAR(64) NULL,
    [ADSUBMODEL] VARCHAR(64) NULL,
    [ADYEAR] VARCHAR(4) NULL,
    [ADMILES] VARCHAR(10) NULL,
    [ADEXTCOLOR] VARCHAR(255) NULL,
    [ADNEWUSED] VARCHAR(8) NULL,
    [ADHEADLINE] VARCHAR(1000) NULL,
    [ADTEXT] VARCHAR(8000) NULL,
    [ADCUSTOMTEXT] VARCHAR(8000) NULL,
    [ADPRICE] VARCHAR(12) NULL,
    [ADPHONE] VARCHAR(36) NULL,
    [ADPIC1T] VARCHAR(555) NULL,
    [ADPIC1] VARCHAR(555) NULL,
    [ADPIC2] VARCHAR(555) NULL,
    [ADPIC3] VARCHAR(555) NULL,
    [ADPIC4] VARCHAR(8000) NULL,
    [ADPICS] VARCHAR(8000) NULL,
    [ADTHUMBS] VARCHAR(8000) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [AutoCornerDealers] (
    [DLRID] VARCHAR(12) NULL,
    [DLRNAME] VARCHAR(64) NULL,
    [DLRADDR] VARCHAR(64) NULL,
    [DLRCITY] VARCHAR(36) NULL,
    [DLRSTATE] VARCHAR(2) NULL,
    [DLRZIP] VARCHAR(5) NULL,
    [DLREMAIL] VARCHAR(128) NULL,
    [DLRURL] VARCHAR(128) NULL,
    [DLRPHONE] VARCHAR(36) NULL
);

CREATE TABLE [AutoExactCustomers] (
    [dlrID] VARCHAR(32) NULL,
    [dlrName] VARCHAR(32) NULL,
    [dlrAddr] VARCHAR(128) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZip] VARCHAR(10) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrURL] VARCHAR(128) NULL,
    [dlrPhone] VARCHAR(18) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [AutoExactData] (
    [dlrID] VARCHAR(32) NULL,
    [adID] VARCHAR(32) NULL,
    [adStock] VARCHAR(32) NULL,
    [adVIN] VARCHAR(32) NULL,
    [adSection] VARCHAR(32) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(128) NULL,
    [adSubModel] VARCHAR(64) NULL,
    [adYear] VARCHAR(4) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adColor] VARCHAR(64) NULL,
    [adHeadline] VARCHAR(3200) NULL,
    [adText] VARCHAR(6500) NULL,
    [adPrice] VARCHAR(24) NULL,
    [adPics] VARCHAR(4096) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [autoexplorerdata] (
    [source] VARCHAR(32) NULL,
    [serviceid] VARCHAR(32) NULL,
    [dealernum] VARCHAR(64) NULL,
    [locationid] VARCHAR(32) NULL,
    [vin] VARCHAR(20) NULL,
    [stockno] VARCHAR(32) NULL,
    [vehicletype] VARCHAR(32) NULL,
    [year] VARCHAR(4) NULL,
    [make] VARCHAR(32) NULL,
    [model] VARCHAR(8000) NULL,
    [color] VARCHAR(32) NULL,
    [trimcolor] VARCHAR(32) NULL,
    [interiorcolor] VARCHAR(32) NULL,
    [mileagein] VARCHAR(10) NULL,
    [transmission] VARCHAR(32) NULL,
    [askingprice] VARCHAR(10) NULL,
    [wholesaleasking] VARCHAR(10) NULL,
    [webprice] VARCHAR(10) NULL,
    [equipments] VARCHAR(1200) NULL,
    [webcomments] VARCHAR(8000) NULL,
    [imagespath] VARCHAR(1200) NULL,
    [images] VARCHAR(8000) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [AutoFundsAds] (
    [DlrID] VARCHAR(16) NULL,
    [Company_Name] VARCHAR(32) NULL,
    [Company_Address] VARCHAR(64) NULL,
    [Company_City] VARCHAR(32) NULL,
    [Company_State] VARCHAR(32) NULL,
    [Company_Zip] VARCHAR(16) NULL,
    [Company_Phone] VARCHAR(16) NULL,
    [Company_Website] VARCHAR(128) NULL,
    [Company_Email] VARCHAR(256) NULL,
    [VIN_No] VARCHAR(32) NULL,
    [Car_Status] VARCHAR(16) NULL,
    [Stock_No] VARCHAR(16) NULL,
    [Year] VARCHAR(16) NULL,
    [Make] VARCHAR(32) NULL,
    [Model] VARCHAR(64) NULL,
    [Body_Style] VARCHAR(64) NULL,
    [Trim] VARCHAR(128) NULL,
    [Veh_Type] VARCHAR(16) NULL,
    [Doors] VARCHAR(16) NULL,
    [Wheels] VARCHAR(16) NULL,
    [Seating_Capacity] VARCHAR(16) NULL,
    [Ext_Color] VARCHAR(256) NULL,
    [Int_Color] VARCHAR(256) NULL,
    [Int_Material] VARCHAR(128) NULL,
    [Engine] VARCHAR(64) NULL,
    [Cylinders] VARCHAR(12) NULL,
    [Fuel] VARCHAR(16) NULL,
    [Transmission] VARCHAR(64) NULL,
    [Mileage] VARCHAR(16) NULL,
    [Internet_Price] VARCHAR(16) NULL,
    [Options] VARCHAR(8000) NULL,
    [Description] VARCHAR(8000) NULL,
    [Photo_URLs] VARCHAR(8000) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [AutoFusionDealers] (
    [dlrID] VARCHAR(32) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(32) NULL,
    [dlrState] VARCHAR(2) NULL,
    [dlrZip] VARCHAR(10) NULL,
    [dlrEmail] VARCHAR(96) NULL,
    [dlrURL] VARCHAR(512) NULL,
    [dlrPhone] VARCHAR(16) NULL
);

CREATE TABLE [AutoJiniCustomers] (
    [dlrID] VARCHAR(32) NULL,
    [dlrName] VARCHAR(32) NULL,
    [dlrAddr] VARCHAR(128) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZip] VARCHAR(10) NULL,
    [dlrURL] VARCHAR(512) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrPhone] VARCHAR(18) NULL
);

CREATE TABLE [AutoJiniData] (
    [dlrID] VARCHAR(32) NULL,
    [dlrName] VARCHAR(32) NULL,
    [dlrAddr] VARCHAR(128) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZip] VARCHAR(10) NULL,
    [dlrURL] VARCHAR(128) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrPhone] VARCHAR(18) NULL,
    [adID] VARCHAR(32) NULL,
    [adStock] VARCHAR(32) NULL,
    [adVIN] VARCHAR(32) NULL,
    [adBodyType] VARCHAR(32) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(32) NULL,
    [adSubModel] VARCHAR(64) NULL,
    [adYear] VARCHAR(4) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adColor] VARCHAR(64) NULL,
    [adHeadline] VARCHAR(1024) NULL,
    [adText] VARCHAR(6500) NULL,
    [adPrice] VARCHAR(16) NULL,
    [adPhone] VARCHAR(18) NULL,
    [adPics] VARCHAR(6500) NULL,
    [adthumbs] VARCHAR(6500) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [AutoManagerData] (
    [dlrID] VARCHAR(32) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(128) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZip] VARCHAR(16) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrPhone] VARCHAR(32) NULL,
    [adStock] VARCHAR(32) NULL,
    [adVin] VARCHAR(32) NULL,
    [adSection] VARCHAR(32) NULL,
    [adType] VARCHAR(32) NULL,
    [adCertified] VARCHAR(32) NULL,
    [adYear] VARCHAR(16) NULL,
    [adMake] VARCHAR(64) NULL,
    [adModel] VARCHAR(128) NULL,
    [adSubModel] VARCHAR(64) NULL,
    [adMiles] VARCHAR(10) NULL,
    [adExtColor] VARCHAR(128) NULL,
    [adIntColor] VARCHAR(128) NULL,
    [adHeadline] VARCHAR(100) NULL,
    [adText] VARCHAR(6000) NULL,
    [adPrice] VARCHAR(10) NULL,
    [adInvoice] VARCHAR(10) NULL,
    [adMSRP] VARCHAR(16) NULL,
    [adDateInStock] VARCHAR(24) NULL,
    [adDoors] VARCHAR(10) NULL,
    [adTransmission] VARCHAR(64) NULL,
    [adDriveType] VARCHAR(64) NULL,
    [adEngineDescription] VARCHAR(64) NULL,
    [adEngineCyclinders] VARCHAR(64) NULL,
    [adFuelType] VARCHAR(24) NULL,
    [adPics] VARCHAR(8000) NULL,
    [adVDP] VARCHAR(255) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [AutoMarkSolutionsAds] (
    [dlrid] VARCHAR(32) NULL,
    [adVIN] VARCHAR(32) NULL,
    [adStock] VARCHAR(32) NULL,
    [adCondition] VARCHAR(12) NULL,
    [adCertified] VARCHAR(24) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adYear] VARCHAR(4) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(32) NULL,
    [adBody] VARCHAR(32) NULL,
    [adDoors] VARCHAR(8) NULL,
    [adEngine] VARCHAR(32) NULL,
    [adTransmission] VARCHAR(32) NULL,
    [adExtColor] VARCHAR(64) NULL,
    [adIntColor] VARCHAR(64) NULL,
    [adTrim] VARCHAR(64) NULL,
    [adRetailPrice] VARCHAR(10) NULL,
    [adSalePrice] VARCHAR(10) NULL,
    [adText] VARCHAR(6500) NULL,
    [adOptions] VARCHAR(6500) NULL,
    [adPhotosThumb] VARCHAR(6500) NULL,
    [adPhotosNormal] VARCHAR(6500) NULL,
    [adPhotosLarge] VARCHAR(6500) NULL,
    [adURL] VARCHAR(512) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [automarksolutionsdealers] (
    [dlrID] VARCHAR(32) NULL,
    [dlrName] VARCHAR(32) NULL,
    [dlrAddr] VARCHAR(128) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZip] VARCHAR(10) NULL,
    [dlrURL] VARCHAR(512) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrPhone] VARCHAR(18) NULL
);

CREATE TABLE [AutoMatrixAds] (
    [dlrid] VARCHAR(24) NULL,
    [adid] VARCHAR(24) NULL,
    [adstock] VARCHAR(8) NULL,
    [advin] VARCHAR(24) NULL,
    [adsection] VARCHAR(64) NULL,
    [adtype] VARCHAR(10) NULL,
    [adcertified] VARCHAR(8) NULL,
    [admake] VARCHAR(16) NULL,
    [admodel] VARCHAR(36) NULL,
    [adsubmodel] VARCHAR(64) NULL,
    [adyear] VARCHAR(8) NULL,
    [admiles] VARCHAR(8) NULL,
    [adcolor] VARCHAR(64) NULL,
    [adcondition] VARCHAR(12) NULL,
    [adheadline] VARCHAR(128) NULL,
    [adtext] VARCHAR(4096) NULL,
    [adcustom] VARCHAR(MAX) NULL,
    [adprice] VARCHAR(12) NULL,
    [adphone] VARCHAR(16) NULL,
    [adpic1t] VARCHAR(8000) NULL,
    [adpics] VARCHAR(8000) NULL
);

CREATE TABLE [AutoMatrixDealers] (
    [dlrid] VARCHAR(24) NULL,
    [dlrname] VARCHAR(64) NULL,
    [dlraddress] VARCHAR(64) NULL,
    [dlrcity] VARCHAR(32) NULL,
    [dlrstate] VARCHAR(8) NULL,
    [dlrzip] VARCHAR(8) NULL,
    [dlremail] VARCHAR(64) NULL,
    [dlrurl] VARCHAR(512) NULL,
    [dlrphone] VARCHAR(20) NULL
);

CREATE TABLE [AutoNetCustomers] (
    [dlrID] VARCHAR(32) NULL,
    [dlrName] VARCHAR(32) NULL,
    [dlrAddr] VARCHAR(128) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZip] VARCHAR(10) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrURL] VARCHAR(512) NULL,
    [dlrPhone] VARCHAR(18) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [AutoNetData] (
    [dlrID] VARCHAR(32) NULL,
    [adVIN] VARCHAR(32) NULL,
    [adBodyType] VARCHAR(12) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(32) NULL,
    [adTrim] VARCHAR(64) NULL,
    [adYear] VARCHAR(4) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adComments] VARCHAR(6500) NULL,
    [adOptions] VARCHAR(6500) NULL,
    [dlrPhone] VARCHAR(18) NULL,
    [adPics] VARCHAR(4096) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [AutoNetUSAAds] (
    [DlrID] VARCHAR(16) NULL,
    [advin] VARCHAR(32) NULL,
    [adcategory] VARCHAR(32) NULL,
    [admake] VARCHAR(32) NULL,
    [admodel] VARCHAR(32) NULL,
    [adtrim] VARCHAR(32) NULL,
    [adyear] VARCHAR(4) NULL,
    [admiles] VARCHAR(8) NULL,
    [adtext] VARCHAR(256) NULL,
    [adopt] VARCHAR(4096) NULL,
    [adphone] VARCHAR(32) NULL,
    [adpics] VARCHAR(4096) NULL,
    [adimgcnt] INT NULL
);

CREATE TABLE [AutoNetUSADealers] (
    [DlrID] VARCHAR(16) NULL,
    [DlrName] VARCHAR(32) NULL,
    [DlrAddress] VARCHAR(32) NULL,
    [DlrCity] VARCHAR(32) NULL,
    [DlrState] VARCHAR(2) NULL,
    [DlrZip] VARCHAR(5) NULL,
    [DlrEmail] VARCHAR(32) NULL,
    [DlrURL] VARCHAR(64) NULL,
    [DlrPhone] VARCHAR(18) NULL
);

CREATE TABLE [AutoNexusfeed] (
    [DLRID] VARCHAR(25) NULL,
    [DLRNAME] VARCHAR(255) NULL,
    [DLRADDRESS] VARCHAR(100) NULL,
    [DLRCITY] VARCHAR(100) NULL,
    [DLRSTATE] VARCHAR(50) NULL,
    [DLRZIP] VARCHAR(10) NULL,
    [DLREMAIL] VARCHAR(255) NULL,
    [DLRURL] VARCHAR(512) NULL,
    [DLRPHONE] VARCHAR(255) NULL,
    [ADID] VARCHAR(25) NULL,
    [ADVIN] VARCHAR(25) NULL,
    [ADSECTION] VARCHAR(25) NULL,
    [ADMAKE] VARCHAR(32) NULL,
    [ADMODEL] VARCHAR(128) NULL,
    [ADSUBMODEL] VARCHAR(32) NULL,
    [ADYEAR] VARCHAR(4) NULL,
    [ADMILES] VARCHAR(10) NULL,
    [ADHEADLINE] VARCHAR(4096) NULL,
    [ADTEXT] VARCHAR(4096) NULL,
    [ADPRICE] VARCHAR(8) NULL,
    [ADPHONE] VARCHAR(100) NULL,
    [ADPICS] VARCHAR(8000) NULL
);

CREATE TABLE [AutoPlusNetAds] (
    [DLRNAME] VARCHAR(32) NULL,
    [DLRADDR] VARCHAR(128) NULL,
    [DLRCITY] VARCHAR(64) NULL,
    [DLRSTATE] VARCHAR(32) NULL,
    [DLRZIP] VARCHAR(10) NULL,
    [DLRPHONE] VARCHAR(18) NULL,
    [ADSTOCK] VARCHAR(32) NULL,
    [ADYEAR] VARCHAR(8) NULL,
    [ADMAKE] VARCHAR(32) NULL,
    [ADMODEL] VARCHAR(32) NULL,
    [ADTRIM] VARCHAR(64) NULL,
    [ADVIN] VARCHAR(17) NULL,
    [ADMILES] VARCHAR(16) NULL,
    [ADPRICE] VARCHAR(10) NULL,
    [ADEXTCOLOR] VARCHAR(64) NULL,
    [ADINTCOLOR] VARCHAR(64) NULL,
    [ADCERTIFIED] VARCHAR(24) NULL,
    [ADCONDITION] VARCHAR(24) NULL,
    [ADTRANS] VARCHAR(128) NULL,
    [ADPICS] VARCHAR(5000) NULL,
    [ADOPTIONS] VARCHAR(5000) NULL,
    [ADDESCRIPTION] VARCHAR(6500) NULL,
    [id] INT NOT NULL,
    [adSection] VARCHAR(256) NULL
);

CREATE TABLE [AutoPlusNetDealers] (
    [DlrID] VARCHAR(16) NULL,
    [DlrName] VARCHAR(32) NULL,
    [DlrAddress] VARCHAR(32) NULL,
    [DlrCity] VARCHAR(32) NULL,
    [DlrState] VARCHAR(2) NULL,
    [DlrZip] VARCHAR(5) NULL,
    [DlrEmail] VARCHAR(32) NULL,
    [DlrURL] VARCHAR(64) NULL,
    [DlrPhone] VARCHAR(18) NULL
);

CREATE TABLE [AutoRevCustomers] (
    [MatchID] VARCHAR(44) NULL,
    [DlrID] VARCHAR(32) NULL,
    [DlrName] VARCHAR(64) NULL,
    [DlrContact] VARCHAR(64) NULL,
    [DlrPhone] VARCHAR(32) NULL,
    [DlrAddress] VARCHAR(64) NULL,
    [DlrCity] VARCHAR(32) NULL,
    [DlrState] VARCHAR(2) NULL,
    [DlrCountry] VARCHAR(2) NULL,
    [DlrZip] VARCHAR(5) NULL,
    [DlrFax] VARCHAR(32) NULL,
    [DlrEmail] VARCHAR(128) NULL,
    [DlrURL] VARCHAR(128) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [AutoRevData] (
    [adMatchID] VARCHAR(64) NULL,
    [DlrID] VARCHAR(34) NULL,
    [adNewCar] BIT NULL,
    [adVIN] VARCHAR(17) NULL,
    [adNumber] VARCHAR(15) NULL,
    [adCategory] VARCHAR(32) NULL,
    [adType] VARCHAR(32) NULL,
    [adYear] VARCHAR(4) NULL,
    [adMake] VARCHAR(30) NULL,
    [adModel] VARCHAR(50) NULL,
    [adTrim] VARCHAR(64) NULL,
    [adDoors] VARCHAR(1) NULL,
    [adExterior] VARCHAR(128) NULL,
    [adInterior] VARCHAR(128) NULL,
    [adEngine] VARCHAR(75) NULL,
    [adFuel] VARCHAR(30) NULL,
    [adTransmission] VARCHAR(100) NULL,
    [adCylinder] VARCHAR(100) NULL,
    [adDriveType] VARCHAR(128) NULL,
    [adMiles] INT NULL,
    [adRetail] MONEY NULL,
    [adWholesale] INT NULL,
    [adCertified] BIT NULL,
    [adimage] SMALLINT NULL,
    [adNotes] VARCHAR(4096) NULL,
    [adOptions] VARCHAR(3072) NULL,
    [adImages] VARCHAR(MAX) NULL,
    [adgenericext] VARCHAR(64) NULL,
    [adinvoice] VARCHAR(10) NULL,
    [adMSRP] VARCHAR(10) NULL,
    [adMiscPrice1] VARCHAR(10) NULL,
    [adMiscPrice2] VARCHAR(10) NULL,
    [adModelCode] VARCHAR(200) NULL,
    [adDaysInStock] VARCHAR(8) NULL,
    [adEPACity] VARCHAR(8) NULL,
    [adEPAHwy] VARCHAR(8) NULL,
    [adVDP] VARCHAR(MAX) NULL,
    [adPhone] VARCHAR(128) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [AutoRevoData] (
    [dlrID] VARCHAR(24) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(32) NULL,
    [dlrState] VARCHAR(24) NULL,
    [dlrZip] VARCHAR(12) NULL,
    [dlrEmail] VARCHAR(64) NULL,
    [dlrUrl] VARCHAR(100) NULL,
    [dlrPhone] VARCHAR(100) NULL,
    [adVin] VARCHAR(32) NULL,
    [adStock] VARCHAR(64) NULL,
    [adYear] VARCHAR(16) NULL,
    [adMake] VARCHAR(64) NULL,
    [adModel] VARCHAR(128) NULL,
    [adSubModel] VARCHAR(64) NULL,
    [adSection] VARCHAR(32) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adPrice] VARCHAR(16) NULL,
    [adPriceRet] VARCHAR(16) NULL,
    [adCertified] VARCHAR(32) NULL,
    [adColorExt] VARCHAR(255) NULL,
    [adColorGen] VARCHAR(64) NULL,
    [adColorInt] VARCHAR(255) NULL,
    [adText] VARCHAR(MAX) NULL,
    [adOptions] VARCHAR(MAX) NULL,
    [adPics] VARCHAR(MAX) NULL,
    [adIntType] VARCHAR(64) NULL,
    [adCylinders] VARCHAR(12) NULL,
    [adDriveTrain] VARCHAR(32) NULL,
    [adDoors] VARCHAR(32) NULL,
    [adTransmission] VARCHAR(64) NULL,
    [adNew] VARCHAR(32) NULL,
    [adVDP] VARCHAR(MAX) NULL,
    [adID] VARCHAR(32) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [AutoRevXlate] (
    [DlrID] VARCHAR(6) NOT NULL,
    [PubID] INT NOT NULL,
    [EdID] INT NOT NULL
);

CREATE TABLE [AutoSearchAds] (
    [dlrid] VARCHAR(32) NULL,
    [location_id] VARCHAR(24) NULL,
    [adstock] VARCHAR(24) NULL,
    [advin] VARCHAR(24) NULL,
    [adyear] VARCHAR(12) NULL,
    [admake] VARCHAR(64) NULL,
    [admodel] VARCHAR(64) NULL,
    [adtrim] VARCHAR(64) NULL,
    [adprice] VARCHAR(12) NULL,
    [special_price] VARCHAR(12) NULL,
    [minimum_price] VARCHAR(12) NULL,
    [admiles] VARCHAR(12) NULL,
    [exterior_color] VARCHAR(64) NULL,
    [interior_color] VARCHAR(64) NULL,
    [transmission] VARCHAR(256) NULL,
    [drive_type] VARCHAR(128) NULL,
    [engine] VARCHAR(128) NULL,
    [fuel_type] VARCHAR(128) NULL,
    [adtext] VARCHAR(MAX) NULL,
    [estMPG_hwy] VARCHAR(12) NULL,
    [estMPG_city] VARCHAR(12) NULL,
    [num_doors] VARCHAR(12) NULL,
    [num_passengers] VARCHAR(12) NULL,
    [body_type] VARCHAR(128) NULL,
    [features] VARCHAR(MAX) NULL,
    [new_used] VARCHAR(12) NULL,
    [adpics] VARCHAR(MAX) NULL,
    [dlrname] VARCHAR(128) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [AutoSoftAds] (
    [dlrid] VARCHAR(32) NULL,
    [adStyle] VARCHAR(32) NULL,
    [adStock] VARCHAR(32) NULL,
    [adVIN] VARCHAR(32) NULL,
    [adYear] VARCHAR(4) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(40) NULL,
    [adSubModel] VARCHAR(64) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adPrice] VARCHAR(10) NULL,
    [adExtColor] VARCHAR(64) NULL,
    [adIntColor] VARCHAR(64) NULL,
    [adEngine] VARCHAR(64) NULL,
    [adTransmission] VARCHAR(64) NULL,
    [adFuelType] VARCHAR(64) NULL,
    [adDriveTrain] VARCHAR(64) NULL,
    [adOptions] VARCHAR(6500) NULL,
    [adText] VARCHAR(6500) NULL,
    [adPics] VARCHAR(8000) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [autosoftdealers] (
    [dlrID] VARCHAR(32) NULL,
    [dlrName] VARCHAR(32) NULL,
    [dlrAddr] VARCHAR(128) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZip] VARCHAR(10) NULL,
    [dlrURL] VARCHAR(512) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrPhone] VARCHAR(18) NULL
);

CREATE TABLE [AutoStarAds] (
    [dlrid] VARCHAR(32) NULL,
    [dlrName] VARCHAR(32) NULL,
    [lotid] VARCHAR(32) NULL,
    [dlrAddr] VARCHAR(128) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZip] VARCHAR(10) NULL,
    [adPrice] VARCHAR(10) NULL,
    [adPriceType] VARCHAR(32) NULL,
    [isNew] VARCHAR(32) NULL,
    [adStock] VARCHAR(32) NULL,
    [adVIN] VARCHAR(32) NULL,
    [adYear] VARCHAR(4) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(32) NULL,
    [adSubModel] VARCHAR(64) NULL,
    [adBookValueHi] VARCHAR(10) NULL,
    [adBookValueLo] VARCHAR(10) NULL,
    [adMPGCity] VARCHAR(10) NULL,
    [adMPGHighWay] VARCHAR(10) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adExtColor] VARCHAR(64) NULL,
    [adIntColor] VARCHAR(64) NULL,
    [adBodyStyle] VARCHAR(64) NULL,
    [adDoors] VARCHAR(64) NULL,
    [adEngine] VARCHAR(100) NULL,
    [adFuel] VARCHAR(64) NULL,
    [adTransmission] VARCHAR(100) NULL,
    [adDriveTrain] VARCHAR(100) NULL,
    [adOptions] VARCHAR(6000) NULL,
    [adDescription] VARCHAR(6000) NULL,
    [adPics] VARCHAR(6500) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [AutoSweetAds] (
    [DlrID] VARCHAR(16) NULL,
    [DlrID2] VARCHAR(16) NULL,
    [adstock] VARCHAR(20) NULL,
    [advin] VARCHAR(32) NULL,
    [adyear] VARCHAR(4) NULL,
    [admake] VARCHAR(32) NULL,
    [admodel] VARCHAR(64) NULL,
    [adtrim] VARCHAR(64) NULL,
    [admiles] VARCHAR(8) NULL,
    [adextclr] VARCHAR(128) NULL,
    [adintclr] VARCHAR(64) NULL,
    [adnew] VARCHAR(2) NULL,
    [adcert] VARCHAR(3) NULL,
    [adcerttype] VARCHAR(16) NULL,
    [adcertid] VARCHAR(16) NULL,
    [adprice] VARCHAR(10) NULL,
    [adprice2] VARCHAR(10) NULL,
    [adprice3] VARCHAR(10) NULL,
    [adMSRP] VARCHAR(10) NULL,
    [adbody] VARCHAR(128) NULL,
    [adtext] VARCHAR(2048) NULL,
    [adonlotdate] VARCHAR(16) NULL,
    [addaysinstock] VARCHAR(16) NULL,
    [adMfgNum] VARCHAR(24) NULL,
    [adtrans] VARCHAR(512) NULL,
    [adengine] VARCHAR(512) NULL,
    [addtrain] VARCHAR(64) NULL,
    [adsolddate] VARCHAR(16) NULL,
    [adcusttxt] VARCHAR(4096) NULL,
    [adOptions] VARCHAR(MAX) NULL,
    [adtechspec] VARCHAR(16) NULL,
    [admfgmpg] VARCHAR(16) NULL,
    [adpics] VARCHAR(MAX) NULL,
    [adstyleID] VARCHAR(128) NULL,
    [adstyleIDs] VARCHAR(128) NULL,
    [adimgcnt] INT NULL,
    [id] INT NOT NULL
);

CREATE TABLE [AutoSweetCustomers] (
    [DlrID] VARCHAR(16) NULL,
    [DlrName] VARCHAR(64) NULL,
    [DlrState] VARCHAR(10) NULL,
    [DlrZip] VARCHAR(10) NULL,
    [DlrEmail] VARCHAR(64) NULL
);

CREATE TABLE [AutoUplinkUSAData] (
    [dlrID] VARCHAR(16) NULL,
    [dlrName] VARCHAR(36) NULL,
    [dlrAddress] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(24) NULL,
    [dlrState] VARCHAR(8) NULL,
    [dlrZIP] VARCHAR(8) NULL,
    [dlrEmail] VARCHAR(64) NULL,
    [dlrURL] VARCHAR(500) NULL,
    [dlrPhone] VARCHAR(16) NULL,
    [adID] VARCHAR(20) NULL,
    [adStock] VARCHAR(32) NULL,
    [adVIN] VARCHAR(20) NULL,
    [adSection] VARCHAR(50) NULL,
    [adType] VARCHAR(16) NULL,
    [adCertified] VARCHAR(16) NULL,
    [adYear] VARCHAR(8) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(64) NULL,
    [adSubModel] VARCHAR(64) NULL,
    [adStyle] VARCHAR(256) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adExteriorColor] VARCHAR(64) NULL,
    [adGenericExteriorColor] VARCHAR(16) NULL,
    [adInteriorColor] VARCHAR(64) NULL,
    [adHeadline] VARCHAR(100) NULL,
    [adText] VARCHAR(8000) NULL,
    [adCustomText] VARCHAR(8000) NULL,
    [adPrice] VARCHAR(16) NULL,
    [adInvoice] VARCHAR(16) NULL,
    [adMSRP] VARCHAR(16) NULL,
    [adMiscPrice1] VARCHAR(16) NULL,
    [adMiscPrice2] VARCHAR(16) NULL,
    [adModelCode] VARCHAR(24) NULL,
    [adDateInStock] VARCHAR(16) NULL,
    [adWheelbase] VARCHAR(16) NULL,
    [adDoors] VARCHAR(16) NULL,
    [adTransmission] VARCHAR(36) NULL,
    [adDriveType] VARCHAR(24) NULL,
    [adEngineDescription] VARCHAR(300) NULL,
    [adEngineCylinders] VARCHAR(16) NULL,
    [adEngineDisplacement] VARCHAR(16) NULL,
    [adFuelType] VARCHAR(64) NULL,
    [adEPACity] VARCHAR(16) NULL,
    [adEPAHighway] VARCHAR(16) NULL,
    [adPics] VARCHAR(8000) NULL,
    [adVDP] VARCHAR(255) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [AutoWebExpAds] (
    [dlrID] VARCHAR(12) NULL,
    [adID] VARCHAR(25) NULL,
    [adStock] VARCHAR(16) NULL,
    [adVIN] VARCHAR(25) NULL,
    [adSection] VARCHAR(23) NULL,
    [adSCLID] VARCHAR(9) NULL,
    [adCertified] VARCHAR(9) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(32) NULL,
    [adSubModel] VARCHAR(128) NULL,
    [adYear] VARCHAR(12) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adColor] VARCHAR(32) NULL,
    [adCondition] VARCHAR(16) NULL,
    [adHeadline] VARCHAR(32) NULL,
    [adText] VARCHAR(4096) NULL,
    [adCustomText] VARCHAR(4096) NULL,
    [adPrice] VARCHAR(16) NULL,
    [adPhone] VARCHAR(16) NULL,
    [adPic1] VARCHAR(4096) NULL,
    [adPic2] VARCHAR(4096) NULL,
    [adPic3] VARCHAR(4096) NULL,
    [adPic4] VARCHAR(4096) NULL,
    [adPic5] VARCHAR(4096) NULL,
    [adPic6] VARCHAR(4096) NULL,
    [adPic7] VARCHAR(4096) NULL,
    [adPic8] VARCHAR(4096) NULL,
    [adPic9] VARCHAR(4096) NULL,
    [adPic10] VARCHAR(4096) NULL,
    [adPics] VARCHAR(8000) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [AutoWebExpDealers] (
    [dlrID] VARCHAR(12) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(43) NULL,
    [dlrState] VARCHAR(8) NULL,
    [dlrZIP] VARCHAR(8) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrURL] VARCHAR(128) NULL,
    [dlrphone] VARCHAR(16) NULL
);

CREATE TABLE [AutoXlooAds] (
    [stock] VARCHAR(12) NULL,
    [title] VARCHAR(32) NULL,
    [advin] VARCHAR(17) NULL,
    [year] VARCHAR(4) NULL,
    [make] VARCHAR(64) NULL,
    [model] VARCHAR(64) NULL,
    [trim] VARCHAR(64) NULL,
    [free_text] VARCHAR(MAX) NULL,
    [type] VARCHAR(32) NULL,
    [body] VARCHAR(128) NULL,
    [mileage] VARCHAR(12) NULL,
    [price_current] VARCHAR(8) NULL,
    [price_wholesale] VARCHAR(8) NULL,
    [price_cost] VARCHAR(8) NULL,
    [InternetPrice] VARCHAR(8) NULL,
    [MSRP] VARCHAR(8) NULL,
    [BookValue] VARCHAR(8) NULL,
    [exterior] VARCHAR(128) NULL,
    [interior] VARCHAR(128) NULL,
    [doors] VARCHAR(24) NULL,
    [engine] VARCHAR(64) NULL,
    [transmission] VARCHAR(100) NULL,
    [drive_type] VARCHAR(64) NULL,
    [fuel_type] VARCHAR(128) NULL,
    [warranty] VARCHAR(30) NULL,
    [warranty_description] VARCHAR(8000) NULL,
    [description] VARCHAR(5000) NULL,
    [pics] VARCHAR(5000) NULL,
    [condition] VARCHAR(32) NULL,
    [options] VARCHAR(8000) NULL,
    [URL_YouTube] VARCHAR(512) NULL,
    [URL_MAS] VARCHAR(512) NULL,
    [date_in_stock] VARCHAR(24) NULL,
    [DealerName] VARCHAR(64) NULL,
    [DealerContactPerson] VARCHAR(64) NULL,
    [DealerPhone] VARCHAR(24) NULL,
    [DealerEmail] VARCHAR(128) NULL,
    [DealerAddress] VARCHAR(128) NULL,
    [DealerCity] VARCHAR(32) NULL,
    [DealerState] VARCHAR(32) NULL,
    [DealerZIP] VARCHAR(32) NULL,
    [DealerCountry] VARCHAR(32) NULL,
    [DealerID] VARCHAR(32) NULL,
    [DealerLOT] VARCHAR(32) NULL,
    [DealerGroup] VARCHAR(32) NULL,
    [Certified] VARCHAR(24) NULL,
    [CategorizedOptions] VARCHAR(32) NULL,
    [MarketClass] VARCHAR(32) NULL,
    [User_price1] VARCHAR(32) NULL,
    [User_price2] VARCHAR(32) NULL,
    [User_price3] VARCHAR(32) NULL,
    [Comment1] VARCHAR(5000) NULL,
    [Comment2] VARCHAR(5000) NULL,
    [Comment3] VARCHAR(5000) NULL,
    [VIDEO_URL_1] VARCHAR(512) NULL,
    [VIDEO_URL_2] VARCHAR(512) NULL,
    [VIDEO_URL_3] VARCHAR(512) NULL,
    [VehicleID] VARCHAR(50) NULL,
    [DetailURL] VARCHAR(512) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [AutoXloodata] (
    [type] VARCHAR(128) NULL,
    [stock] VARCHAR(32) NULL,
    [vin] VARCHAR(32) NULL,
    [year] VARCHAR(8) NULL,
    [make] VARCHAR(32) NULL,
    [model] VARCHAR(64) NULL,
    [trim] VARCHAR(64) NULL,
    [free_text] VARCHAR(1000) NULL,
    [body] VARCHAR(32) NULL,
    [mileage] VARCHAR(8) NULL,
    [price_current] VARCHAR(16) NULL,
    [reserved] VARCHAR(32) NULL,
    [price_wholesale] VARCHAR(32) NULL,
    [price_cost] VARCHAR(32) NULL,
    [title] VARCHAR(32) NULL,
    [condition] VARCHAR(32) NULL,
    [exterior] VARCHAR(128) NULL,
    [interior] VARCHAR(128) NULL,
    [doors] VARCHAR(128) NULL,
    [engine] VARCHAR(128) NULL,
    [transmission] VARCHAR(32) NULL,
    [fuel_type] VARCHAR(32) NULL,
    [drive_type] VARCHAR(128) NULL,
    [options] VARCHAR(4096) NULL,
    [warranty] VARCHAR(12) NULL,
    [description] VARCHAR(4096) NULL,
    [pics] VARCHAR(8000) NULL,
    [date_in_stock] VARCHAR(32) NULL,
    [dlrid] VARCHAR(12) NULL
);

CREATE TABLE [AutoXloodealers] (
    [dlrID] VARCHAR(32) NULL,
    [dlrName] VARCHAR(32) NULL,
    [dlrAddr] VARCHAR(128) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZip] VARCHAR(10) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrURL] VARCHAR(512) NULL,
    [dlrPhone] VARCHAR(18) NULL,
    [dlrFileName] VARCHAR(128) NULL,
    [active] BIT NOT NULL
);

CREATE TABLE [AutoXplorerDealers] (
    [DealerID] VARCHAR(50) NOT NULL,
    [LocationID] VARCHAR(50) NOT NULL,
    [Dlrname] VARCHAR(256) NOT NULL,
    [FDID] VARCHAR(32) NOT NULL
);

CREATE TABLE [Bad_MSRP] (
    [VIN] VARCHAR(20) NULL,
    [Title] VARCHAR(64) NULL,
    [URL] VARCHAR(300) NULL,
    [Date] VARCHAR(24) NULL
);

CREATE TABLE [BADIPS] (
    [BIID] INT NOT NULL -- PK,
    [IPSTART] INT NOT NULL,
    [IPEND] INT NOT NULL,
    [REASON] VARCHAR(100) NOT NULL,
    [AUTHBY] VARCHAR(50) NOT NULL,
    [PUBID] INT NOT NULL
);

CREATE TABLE [BadWords] (
    [BadWords] VARCHAR(20) NOT NULL -- PK
);

CREATE TABLE [BANINTERVAL] (
    [BANIID] SMALLINT NOT NULL -- PK,
    [BANINTERVAL] VARCHAR(32) NOT NULL,
    [BANHOURS] TINYINT NOT NULL,
    [BANPURGETIME] TINYINT NOT NULL -- PK
);

CREATE TABLE [BANKEYWORD] (
    [bankeyid] INT NOT NULL -- PK,
    [banid] INT NOT NULL,
    [bankeyword] CHAR(20) NOT NULL,
    [bankeyhits] INT NOT NULL
);

CREATE TABLE [BANLOCATION] (
    [BANLOCID] SMALLINT NOT NULL -- PK,
    [BANLOCNAME] VARCHAR(50) NOT NULL
);

CREATE TABLE [BANLOCSIZE] (
    [BANLOCID] INT NOT NULL -- PK,
    [BANSIZEID] SMALLINT NOT NULL -- PK,
    [PUBID] INT NOT NULL -- PK
);

CREATE TABLE [BannerCategory] (
    [banid] INT NOT NULL -- PK,
    [clsid] INT NOT NULL -- PK,
    [sclid] INT NOT NULL -- PK
);

CREATE TABLE [BANNERLOG] (
    [banlid] BIGINT NOT NULL -- PK,
    [banid] INT NOT NULL,
    [banlday] SMALLDATETIME NOT NULL,
    [banlhour] SMALLINT NOT NULL,
    [banlclick] BIT NOT NULL,
    [banlip1] INT NOT NULL,
    [banlip2] INT NOT NULL,
    [banlip3] INT NOT NULL,
    [banlip4] INT NOT NULL,
    [banlpubid] INT NOT NULL
);

CREATE TABLE [BANNERS] (
    [BANID] INT NOT NULL -- PK,
    [BANSTATE] INT NOT NULL,
    [BANNAME] VARCHAR(150) NOT NULL,
    [BANTEXT] VARCHAR(150) NULL,
    [BANTYPE] INT NOT NULL,
    [BANHREF] VARCHAR(300) NULL,
    [BANTARGET] VARCHAR(10) NULL,
    [BANIMG] VARCHAR(768) NOT NULL,
    [BANWIDTH] INT NOT NULL,
    [BANHEIGHT] INT NOT NULL,
    [BANSTART] BIGINT NOT NULL,
    [BANHITS] BIGINT NOT NULL,
    [BANCLICKS] INT NOT NULL,
    [BANWEIGHT] INT NOT NULL,
    [BANISSCHEDULE] BIT NOT NULL,
    [BANSTARTDATE] SMALLDATETIME NOT NULL,
    [BANENDDATE] SMALLDATETIME NOT NULL,
    [PUBID] TINYINT NOT NULL,
    [BANGROUP] INT NULL,
    [CUSID] INT NULL
);

CREATE TABLE [BANNERSIZES] (
    [BANSID] INT NOT NULL -- PK,
    [BANWIDTH] INT NOT NULL,
    [BANHEIGHT] INT NOT NULL,
    [PUBID] INT NOT NULL
);

CREATE TABLE [BANNERSTATE] (
    [STATEID] INT NOT NULL,
    [STATE] VARCHAR(50) NOT NULL
);

CREATE TABLE [BANNERTOTAL] (
    [bantid] INT NOT NULL -- PK,
    [banid] INT NOT NULL,
    [bantday] SMALLDATETIME NOT NULL,
    [banhits] INT NOT NULL,
    [banclicks] INT NOT NULL,
    [pubid] INT NOT NULL
);

CREATE TABLE [BANNERTYPE] (
    [BANTYPE] INT NOT NULL,
    [BANTYPEDESC] VARCHAR(50) NOT NULL,
    [BANFORMATSTRING] VARCHAR(512) NOT NULL
);

CREATE TABLE [BANSIZE] (
    [BANSIZEID] SMALLINT NOT NULL -- PK,
    [BANSIZENAME] VARCHAR(30) NOT NULL,
    [BANWIDTH] SMALLINT NOT NULL,
    [BANHEIGHT] SMALLINT NOT NULL
);

CREATE TABLE [BANSIZES] (
    [HEIGHT] INT NOT NULL -- PK,
    [WIDTH] INT NOT NULL -- PK,
    [PUBID] INT NOT NULL -- PK,
    [DESCRIPTION] VARCHAR(50) NULL
);

CREATE TABLE [BANTYPE] (
    [BANTYPEID] SMALLINT NOT NULL -- PK,
    [BANTYPENAME] VARCHAR(50) NOT NULL,
    [BANTYPEFORMAT] VARCHAR(750) NOT NULL
);

CREATE TABLE [BANTYPELOC] (
    [BANTYPEID] INT NOT NULL -- PK,
    [BANLOCID] SMALLINT NOT NULL -- PK,
    [PUBID] SMALLINT NOT NULL -- PK
);

CREATE TABLE [BestRideAds] (
    [dlrID] VARCHAR(16) NULL,
    [adStock] VARCHAR(64) NULL,
    [adInventoryDate] VARCHAR(16) NULL,
    [adCondition] VARCHAR(16) NULL,
    [adPrice] VARCHAR(16) NULL,
    [adText] VARCHAR(5000) NULL,
    [adCertified] VARCHAR(8) NULL,
    [adVIN] VARCHAR(64) NULL,
    [adMake] VARCHAR(64) NULL,
    [adModel] VARCHAR(64) NULL,
    [adYear] VARCHAR(64) NULL,
    [admodelcode] VARCHAR(64) NULL,
    [adSubModel] VARCHAR(128) NULL,
    [adSubModelLevel] VARCHAR(64) NULL,
    [adSection] VARCHAR(64) NULL,
    [adSectionCode] VARCHAR(8) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adPayload] VARCHAR(8) NULL,
    [adSeating] VARCHAR(30) NULL,
    [adWheelBase] VARCHAR(8) NULL,
    [adBody] VARCHAR(128) NULL,
    [adDoors] VARCHAR(16) NULL,
    [adDriveTrain] VARCHAR(64) NULL,
    [adEngineSize] VARCHAR(64) NULL,
    [adCylinders] VARCHAR(64) NULL,
    [adTransmission] VARCHAR(128) NULL,
    [adTransmissionType] VARCHAR(128) NULL,
    [adExtColor] VARCHAR(150) NULL,
    [adExtColorBase] VARCHAR(64) NULL,
    [adIntColor] VARCHAR(128) NULL,
    [adIntExtras] VARCHAR(128) NULL,
    [adStandardFeatures] VARCHAR(MAX) NULL,
    [adDealerFeatures] VARCHAR(4000) NULL,
    [adCreatedDate] VARCHAR(16) NULL,
    [adRadius] VARCHAR(8) NULL,
    [adNumberImages] VARCHAR(8) NULL,
    [adPic1] VARCHAR(600) NULL,
    [adPics] VARCHAR(MAX) NULL,
    [admsrp] VARCHAR(12) NULL,
    [adinvoice_price] VARCHAR(12) NULL,
    [admisc_price] VARCHAR(12) NULL,
    [admisc_price2] VARCHAR(16) NULL,
    [adstyle] VARCHAR(128) NULL,
    [adengine_displacement] VARCHAR(16) NULL,
    [adfuel_type] VARCHAR(12) NULL,
    [adepa_city] VARCHAR(12) NULL,
    [adepa_highway] VARCHAR(12) NULL,
    [adVDP] VARCHAR(255) NULL,
    [id] INT NOT NULL,
    [adid] VARCHAR(12) NULL
);

CREATE TABLE [BestRideDealers] (
    [dlrID] VARCHAR(16) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(32) NULL,
    [dlrState] VARCHAR(8) NULL,
    [dlrZipCode] VARCHAR(8) NULL,
    [dlrPhone] VARCHAR(16) NULL,
    [dlrURL] VARCHAR(128) NULL
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

CREATE TABLE [Blacklisted] (
    [PUBID] INT NOT NULL -- PK,
    [CUSPHONE] VARCHAR(10) NOT NULL -- PK,
    [CUSMESSAGE] VARCHAR(64) NOT NULL
);

CREATE TABLE [BlinkerAds] (
    [dlrID] VARCHAR(12) NULL,
    [adID] VARCHAR(25) NULL,
    [adStock] VARCHAR(32) NULL,
    [adVIN] VARCHAR(25) NULL,
    [adSection] VARCHAR(23) NULL,
    [adSCLID] VARCHAR(9) NULL,
    [adCertified] VARCHAR(9) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(32) NULL,
    [adSubModel] VARCHAR(128) NULL,
    [adYear] VARCHAR(12) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adColor] VARCHAR(32) NULL,
    [adCondition] VARCHAR(16) NULL,
    [adHeadline] VARCHAR(125) NULL,
    [adDetail] VARCHAR(4096) NULL,
    [adText] VARCHAR(4096) NULL,
    [adCustomText] VARCHAR(4096) NULL,
    [adPrice] VARCHAR(16) NULL,
    [adPhone] VARCHAR(16) NULL,
    [adPic1t] VARCHAR(4096) NULL,
    [adPic1] VARCHAR(4096) NULL,
    [adPic2] VARCHAR(4096) NULL,
    [adPic3] VARCHAR(4096) NULL,
    [adPic4] VARCHAR(4096) NULL,
    [adPics] VARCHAR(8000) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [BlinkerDealers] (
    [dlrID] VARCHAR(12) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(43) NULL,
    [dlrState] VARCHAR(8) NULL,
    [dlrZIP] VARCHAR(8) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrURL] VARCHAR(512) NULL,
    [dlrphone] VARCHAR(16) NULL
);

CREATE TABLE [BoostLogicAds] (
    [dlrid] VARCHAR(24) NULL,
    [adid] VARCHAR(24) NULL,
    [adstock] VARCHAR(8) NULL,
    [advin] VARCHAR(17) NULL,
    [adsection] VARCHAR(64) NULL,
    [adtype] VARCHAR(10) NULL,
    [adcertified] VARCHAR(8) NULL,
    [admake] VARCHAR(16) NULL,
    [admodel] VARCHAR(36) NULL,
    [adsubmodel] VARCHAR(64) NULL,
    [adyear] VARCHAR(4) NULL,
    [admiles] VARCHAR(8) NULL,
    [adcolor] VARCHAR(64) NULL,
    [adcondition] VARCHAR(12) NULL,
    [adheadline] VARCHAR(128) NULL,
    [adtext] VARCHAR(4096) NULL,
    [adcustom] VARCHAR(MAX) NULL,
    [adprice] VARCHAR(8) NULL,
    [adphone] VARCHAR(10) NULL,
    [adpics] VARCHAR(8000) NULL
);

CREATE TABLE [BoostLogicDealers] (
    [dlrid] VARCHAR(24) NULL,
    [dlrname] VARCHAR(64) NULL,
    [dlraddress] VARCHAR(64) NULL,
    [dlrcity] VARCHAR(32) NULL,
    [dlrstate] VARCHAR(8) NULL,
    [dlrzip] VARCHAR(5) NULL,
    [dlremail] VARCHAR(64) NULL,
    [dlrurl] VARCHAR(512) NULL,
    [dlrphone] VARCHAR(12) NULL
);

CREATE TABLE [brdads] (
    [dlrID] VARCHAR(16) NULL,
    [adStock] VARCHAR(64) NULL,
    [adInventoryDate] VARCHAR(16) NULL,
    [adCondition] VARCHAR(16) NULL,
    [adPrice] VARCHAR(16) NULL,
    [adText] VARCHAR(5000) NULL,
    [adCertified] VARCHAR(8) NULL,
    [adVIN] VARCHAR(64) NULL,
    [adMake] VARCHAR(64) NULL,
    [adModel] VARCHAR(64) NULL,
    [adYear] VARCHAR(64) NULL,
    [admodelcode] VARCHAR(64) NULL,
    [adSubModel] VARCHAR(128) NULL,
    [adSubModelLevel] VARCHAR(64) NULL,
    [adSection] VARCHAR(64) NULL,
    [adSectionCode] VARCHAR(8) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adPayload] VARCHAR(8) NULL,
    [adSeating] VARCHAR(30) NULL,
    [adWheelBase] VARCHAR(8) NULL,
    [adBody] VARCHAR(128) NULL,
    [adDoors] VARCHAR(16) NULL,
    [adDriveTrain] VARCHAR(64) NULL,
    [adEngineSize] VARCHAR(64) NULL,
    [adCylinders] VARCHAR(8) NULL,
    [adTransmission] VARCHAR(128) NULL,
    [adTransmissionType] VARCHAR(128) NULL,
    [adExtColor] VARCHAR(64) NULL,
    [adExtColorBase] VARCHAR(64) NULL,
    [adIntColor] VARCHAR(128) NULL,
    [adIntExtras] VARCHAR(128) NULL,
    [adStandardFeatures] VARCHAR(MAX) NULL,
    [adDealerFeatures] VARCHAR(4000) NULL,
    [adCreatedDate] VARCHAR(16) NULL,
    [adRadius] VARCHAR(8) NULL,
    [adNumberImages] VARCHAR(8) NULL,
    [adPic1] VARCHAR(600) NULL,
    [adPics] VARCHAR(MAX) NULL,
    [admsrp] VARCHAR(12) NULL,
    [adinvoice_price] VARCHAR(12) NULL,
    [admisc_price] VARCHAR(12) NULL,
    [admisc_price2] VARCHAR(16) NULL,
    [adstyle] VARCHAR(128) NULL,
    [adengine_displacement] VARCHAR(16) NULL,
    [adfuel_type] VARCHAR(12) NULL,
    [adepa_city] VARCHAR(12) NULL,
    [adepa_highway] VARCHAR(12) NULL,
    [adid] VARCHAR(16) NULL
);

CREATE TABLE [BRDDealers] (
    [dlrID] VARCHAR(19) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(32) NULL,
    [dlrState] VARCHAR(8) NULL,
    [dlrZipCode] VARCHAR(8) NULL,
    [dlrPhone] VARCHAR(16) NULL,
    [dlrURL] VARCHAR(512) NULL
);

CREATE TABLE [BUSNEWSCHEDULE] (
    [bnsID] INT NOT NULL -- PK,
    [bscID] INT NOT NULL,
    [bnsDayOfWeek] INT NOT NULL,
    [bnsHour] INT NOT NULL,
    [bnsMinute] INT NOT NULL
);

CREATE TABLE [BUSQUEUES] (
    [bscID] INT NOT NULL -- PK,
    [bsqStatus] VARCHAR(100) NOT NULL,
    [bsqUpdate] SMALLDATETIME NULL,
    [bsqID] VARCHAR(100) NULL
);

CREATE TABLE [BUSSCHEDULE] (
    [bscID] INT NOT NULL -- PK,
    [bscWorkType] INT NOT NULL,
    [bscScheduleType] INT NOT NULL,
    [bscName] VARCHAR(64) NOT NULL,
    [bscRunDayOfWeek] VARCHAR(32) NULL,
    [bscRunHour] INT NOT NULL,
    [bscRunMinute] INT NOT NULL,
    [bscImportSP] VARCHAR(128) NULL,
    [bscSecondSP] VARCHAR(128) NULL,
    [bscFeed2LiveSP] VARCHAR(128) NULL,
    [bscNewImageURL] VARCHAR(512) NULL,
    [bscNewImageFolder] VARCHAR(512) NULL,
    [bscEmailOnComplete] VARCHAR(256) NOT NULL,
    [bscActive] BIT NOT NULL,
    [pubID] INT NULL,
    [worker] VARCHAR(10) NULL
);

CREATE TABLE [BUSSCHEDULEHISTORY] (
    [bshID] INT NOT NULL -- PK,
    [bscID] INT NOT NULL,
    [bshLogged] DATETIME NOT NULL,
    [bshCompleted] BIT NOT NULL,
    [bshError] VARCHAR(512) NULL
);

CREATE TABLE [BUSSTEPS] (
    [bssID] INT NOT NULL -- PK,
    [bscID] INT NOT NULL,
    [bssStepIndex] INT NOT NULL,
    [bssStep] VARCHAR(200) NOT NULL,
    [bssIsDotNet] BIT NOT NULL
);

CREATE TABLE [BUSSTOPS] (
    [bstID] INT NOT NULL -- PK,
    [bscID] INT NOT NULL,
    [bstOriginalURL] VARCHAR(512) NULL,
    [bstNewURL] VARCHAR(512) NULL,
    [bst_Adnum] VARCHAR(512) NULL,
    [xfr_ID] INT NULL
);

CREATE TABLE [CaptiveLeadAds] (
    [dlrid] VARCHAR(32) NULL,
    [dlrname] VARCHAR(64) NULL,
    [adstatus] VARCHAR(12) NULL,
    [adstock] VARCHAR(12) NULL,
    [advin] VARCHAR(17) NULL,
    [adyear] VARCHAR(8) NULL,
    [admake] VARCHAR(32) NULL,
    [admodel] VARCHAR(32) NULL,
    [adbody] VARCHAR(32) NULL,
    [adtrim] VARCHAR(64) NULL,
    [adextcolor] VARCHAR(128) NULL,
    [adintcolor] VARCHAR(256) NULL,
    [adcylinders] VARCHAR(12) NULL,
    [adenginesize] VARCHAR(12) NULL,
    [adengine] VARCHAR(64) NULL,
    [adtransmission] VARCHAR(64) NULL,
    [admiles] VARCHAR(12) NULL,
    [adprice] VARCHAR(12) NULL,
    [admsrp] VARCHAR(12) NULL,
    [adbookvalue] VARCHAR(12) NULL,
    [adinvoiceprice] VARCHAR(12) NULL,
    [adcomments] VARCHAR(5000) NULL,
    [adoptions] VARCHAR(5000) NULL,
    [adpics] VARCHAR(MAX) NULL,
    [id] INT NOT NULL,
    [adtext] VARCHAR(5000) NULL
);

CREATE TABLE [CarBaseAds] (
    [dlrid] VARCHAR(32) NULL,
    [advin] VARCHAR(32) NULL,
    [adstock] VARCHAR(16) NULL,
    [adnew] VARCHAR(8) NULL,
    [adyear] VARCHAR(4) NULL,
    [admake] VARCHAR(32) NULL,
    [admodel] VARCHAR(64) NULL,
    [adbody] VARCHAR(128) NULL,
    [adtrans] VARCHAR(512) NULL,
    [adtrim] VARCHAR(64) NULL,
    [addoors] VARCHAR(16) NULL,
    [admiles] VARCHAR(8) NULL,
    [adengine] VARCHAR(512) NULL,
    [addrivetrain] VARCHAR(64) NULL,
    [adextclr] VARCHAR(128) NULL,
    [adintclr] VARCHAR(64) NULL,
    [adprice] VARCHAR(10) NULL,
    [stockdate] VARCHAR(32) NULL,
    [adcert] VARCHAR(16) NULL,
    [adtext] VARCHAR(4096) NULL,
    [adpics] VARCHAR(MAX) NULL,
    [veh_location] VARCHAR(32) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [CarDaddyData] (
    [dlrID] VARCHAR(32) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddr] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZip] VARCHAR(12) NULL,
    [dlrPhone] VARCHAR(32) NULL,
    [adCondition] VARCHAR(32) NULL,
    [adStock] VARCHAR(32) NULL,
    [adYear] VARCHAR(32) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(32) NULL,
    [adTrim] VARCHAR(64) NULL,
    [adCertified] VARCHAR(32) NULL,
    [adVin] VARCHAR(32) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adPrice] VARCHAR(32) NULL,
    [adExtColor] VARCHAR(128) NULL,
    [adIntColor] VARCHAR(128) NULL,
    [adTransmission] VARCHAR(64) NULL,
    [adPics] VARCHAR(8000) NULL,
    [adDescription] VARCHAR(8000) NULL,
    [adBodyStyle] VARCHAR(64) NULL,
    [adCylinders] VARCHAR(64) NULL,
    [adDriveLine] VARCHAR(64) NULL,
    [adEngineType] VARCHAR(64) NULL,
    [adOptions] VARCHAR(8000) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [CARDS] (
    [CARDID] INT NOT NULL -- PK,
    [MEMID] INT NOT NULL,
    [CARDMASK] VARBINARY(50) NOT NULL,
    [CARDNUM] VARCHAR(20) NOT NULL,
    [EXPMO] TINYINT NOT NULL,
    [EXPYEAR] SMALLINT NOT NULL,
    [CARDNAME] VARCHAR(64) NULL,
    [CARDADDR] VARCHAR(64) NULL,
    [CARDCITY] VARCHAR(32) NULL,
    [CARDSTATE] VARCHAR(2) NULL,
    [CARDZIP] VARCHAR(10) NULL,
    [CARDADDED] SMALLDATETIME NULL
);

CREATE TABLE [CarGigiAds] (
    [Dlrid] VARCHAR(24) NULL,
    [DealerName] VARCHAR(128) NULL,
    [VIN] VARCHAR(24) NULL,
    [StockID] VARCHAR(24) NULL,
    [NewUsed] VARCHAR(4) NULL,
    [Year] VARCHAR(4) NULL,
    [Make] VARCHAR(32) NULL,
    [Model] VARCHAR(64) NULL,
    [ModelNumber] VARCHAR(12) NULL,
    [Body] VARCHAR(128) NULL,
    [Tranmission] VARCHAR(100) NULL,
    [Trim] VARCHAR(64) NULL,
    [Doors] VARCHAR(16) NULL,
    [Mileage] VARCHAR(10) NULL,
    [Cylinders] VARCHAR(64) NULL,
    [Displacement] VARCHAR(32) NULL,
    [DriveTrain] VARCHAR(64) NULL,
    [ExtColor] VARCHAR(128) NULL,
    [IntColor] VARCHAR(128) NULL,
    [Invoice] VARCHAR(10) NULL,
    [MSRP] VARCHAR(10) NULL,
    [BookValue] VARCHAR(10) NULL,
    [WebPrice] VARCHAR(10) NULL,
    [DateInStock] VARCHAR(12) NULL,
    [IsCertified] VARCHAR(10) NULL,
    [Description] VARCHAR(MAX) NULL,
    [Options] VARCHAR(MAX) NULL,
    [PhotoURLs] VARCHAR(MAX) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [CarGurusCalls] (
    [leadtype] VARCHAR(32) NULL,
    [aso_name] VARCHAR(64) NULL,
    [dealerbid] VARCHAR(32) NULL,
    [dealerbudget] VARCHAR(32) NULL,
    [caller_number] VARCHAR(32) NULL,
    [caller_name] VARCHAR(128) NULL,
    [c_name] VARCHAR(128) NULL,
    [fduid] VARCHAR(128) NULL,
    [fdname] VARCHAR(32) NULL,
    [call_s] VARCHAR(32) NULL,
    [ldq_ID] VARCHAR(32) NULL,
    [lst_id] VARCHAR(32) NULL,
    [ldq_frommail] VARCHAR(128) NULL,
    [acc_id] VARCHAR(32) NULL
);

CREATE TABLE [CarGurusCalls2] (
    [leadtype] VARCHAR(32) NULL,
    [aso_name] VARCHAR(64) NULL,
    [dealerbid] VARCHAR(32) NULL,
    [dealerbudget] VARCHAR(32) NULL,
    [caller_number] VARCHAR(32) NULL,
    [caller_name] VARCHAR(128) NULL,
    [c_name] VARCHAR(128) NULL,
    [fduid] VARCHAR(128) NULL,
    [fdname] VARCHAR(128) NULL,
    [call_s] VARCHAR(32) NULL,
    [ldq_ID] VARCHAR(32) NULL,
    [lst_id] VARCHAR(32) NULL,
    [ldq_frommail] VARCHAR(128) NULL,
    [acc_id] VARCHAR(32) NULL
);

CREATE TABLE [CarsForSaleAds] (
    [dlrID] VARCHAR(16) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(128) NULL,
    [dlrCity] VARCHAR(32) NULL,
    [dlrState] VARCHAR(16) NULL,
    [dlrZip] VARCHAR(10) NULL,
    [dlrEmail] VARCHAR(255) NULL,
    [dlrURL] VARCHAR(255) NULL,
    [dlrPhone] VARCHAR(32) NULL,
    [adVehicleID] VARCHAR(10) NULL,
    [adStock] VARCHAR(32) NULL,
    [adVIN] VARCHAR(32) NULL,
    [adBodyStyle] VARCHAR(128) NULL,
    [adMake] VARCHAR(128) NULL,
    [adModel] VARCHAR(128) NULL,
    [adTrim] VARCHAR(256) NULL,
    [adYear] VARCHAR(4) NULL,
    [adMileage] VARCHAR(16) NULL,
    [adColor] VARCHAR(255) NULL,
    [adDescription] VARCHAR(MAX) NULL,
    [adPrice] VARCHAR(10) NULL,
    [adPics] VARCHAR(MAX) NULL,
    [adCondition] VARCHAR(64) NULL,
    [adVDP] VARCHAR(256) NULL,
    [adExteriorColor] VARCHAR(64) NULL,
    [adInteriorColor] VARCHAR(64) NULL,
    [adCustomText] VARCHAR(8000) NULL,
    [adCreated_Date] VARCHAR(24) NULL,
    [adTransmission] VARCHAR(64) NULL,
    [adDriveTrain] VARCHAR(64) NULL,
    [adEngineDescription] VARCHAR(255) NULL,
    [adEngine] VARCHAR(64) NULL,
    [adFuelType] VARCHAR(24) NULL,
    [adEPACity] VARCHAR(16) NULL,
    [adEPAHighway] VARCHAR(16) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [CarsForSaleVerified] (
    [fduid] INT NOT NULL -- PK,
    [fdname] VARCHAR(64) NOT NULL,
    [fdurl] VARCHAR(512) NULL,
    [fdcity] VARCHAR(32) NOT NULL,
    [fdstate] VARCHAR(2) NOT NULL
);

CREATE TABLE [CarSpot] (
    [dlrID] VARCHAR(32) NULL,
    [adID] VARCHAR(32) NULL,
    [adVIN] VARCHAR(32) NULL,
    [adSection] VARCHAR(32) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(100) NULL,
    [adSubModel] VARCHAR(100) NULL,
    [adYear] VARCHAR(10) NULL,
    [adMiles] VARCHAR(50) NULL,
    [adHeadline] VARCHAR(200) NULL,
    [adExtColor] VARCHAR(50) NULL,
    [adIntColor] VARCHAR(50) NULL,
    [adText] VARCHAR(3000) NULL,
    [adPrice] VARCHAR(32) NULL,
    [adPhone] VARCHAR(32) NULL,
    [adPic1] VARCHAR(512) NULL,
    [adPics] VARCHAR(6000) NULL
);

CREATE TABLE [CarSpotDealers] (
    [dlrID] VARCHAR(32) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(100) NULL,
    [dlrCity] VARCHAR(50) NULL,
    [dlrState] VARCHAR(10) NULL,
    [dlrZip] VARCHAR(32) NULL,
    [dlrEmail] VARCHAR(50) NULL,
    [dlrURL] VARCHAR(50) NULL,
    [dlrPhone] VARCHAR(32) NULL
);

CREATE TABLE [CART] (
    [CARTID] INT NOT NULL -- PK,
    [PUBID] INT NOT NULL,
    [MEMID] INT NOT NULL,
    [WEBCLASS] INT NULL,
    [PRINTCLASS] INT NULL,
    [ADPKG] INT NOT NULL,
    [ADYEAR] SMALLINT NULL,
    [ADMAKE] VARCHAR(32) NULL,
    [ADMODEL] VARCHAR(64) NULL,
    [ADTRIM] VARCHAR(32) NULL,
    [ADTEXT] VARCHAR(4096) NULL,
    [ADPRICE] MONEY NULL,
    [EMAIL] VARCHAR(64) NULL,
    [PHONE] VARCHAR(32) NULL,
    [NOPHONE] BIT NOT NULL,
    [HEADLINE] VARCHAR(64) NOT NULL,
    [BORDER] BIT NOT NULL,
    [PREFERRED] BIT NOT NULL,
    [RTIS] BIT NOT NULL,
    [PHOTOAD] BIT NOT NULL,
    [PIC1] VARCHAR(512) NULL,
    [PIC2] VARCHAR(512) NULL,
    [PIC3] VARCHAR(512) NULL,
    [PIC4] VARCHAR(512) NULL,
    [PRICEQUOTE] SMALLMONEY NOT NULL,
    [SUBID] INT NOT NULL,
    [CARTTIME] DATETIME NOT NULL,
    [CARTSTATE] TINYINT NOT NULL,
    [PHOTOSRC] TINYINT NULL,
    [VIN] VARCHAR(17) NULL,
    [THUMB] VARCHAR(255) NULL,
    [STOCKNO] VARCHAR(32) NULL,
    [ZIP] VARCHAR(10) NULL,
    [EXPIREDATE] DATETIME NULL,
    [EXPIREWEEKS] INT NULL
);

CREATE TABLE [CarThinkData] (
    [dlrID] VARCHAR(32) NULL,
    [adID] VARCHAR(32) NULL,
    [adVIN] VARCHAR(32) NULL,
    [adSection] VARCHAR(256) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(64) NULL,
    [adSubModel] VARCHAR(126) NULL,
    [adYear] VARCHAR(32) NULL,
    [adMiles] VARCHAR(32) NULL,
    [adHeadline] VARCHAR(128) NULL,
    [adText] VARCHAR(3000) NULL,
    [adPrice] VARCHAR(32) NULL,
    [dlrPhone] VARCHAR(32) NULL,
    [adPics] VARCHAR(6000) NULL,
    [id] INT NOT NULL,
    [adPicCnt] INT NULL
);

CREATE TABLE [CarThinkDealer] (
    [dlrID] VARCHAR(32) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(32) NULL,
    [dlrCity] VARCHAR(32) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZip] VARCHAR(32) NULL,
    [dlrEmail] VARCHAR(32) NULL,
    [dlrURL] VARCHAR(64) NULL,
    [dlrPhone] VARCHAR(32) NULL
);

CREATE TABLE [CARTIMAGES] (
    [CARTID] INT NOT NULL -- PK,
    [IMGURL] VARCHAR(255) NOT NULL -- PK,
    [IMGSORT] TINYINT NOT NULL
);

CREATE TABLE [CARTYPES] (
    [CTID] TINYINT NOT NULL -- PK,
    [CTNAME] VARCHAR(64) NOT NULL,
    [scl_id] INT NULL
);

CREATE TABLE [CarWeekData] (
    [dlrID] VARCHAR(16) NULL,
    [adID] VARCHAR(32) NULL,
    [adSection] VARCHAR(64) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(128) NULL,
    [adSubModel] VARCHAR(64) NULL,
    [adYear] VARCHAR(4) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adHeadline] VARCHAR(128) NULL,
    [adText] VARCHAR(5000) NULL,
    [adPrice] VARCHAR(16) NULL,
    [adPhone] VARCHAR(16) NULL,
    [adpic] VARCHAR(MAX) NULL,
    [adExtColor] VARCHAR(128) NULL,
    [adIntColor] VARCHAR(128) NULL,
    [adCondition] VARCHAR(16) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [CDM] (
    [DlrID] VARCHAR(16) NULL,
    [DlrName] VARCHAR(64) NULL,
    [DlrEmail] VARCHAR(64) NULL,
    [DlrURL] VARCHAR(64) NULL,
    [DlrPhone] VARCHAR(32) NULL,
    [DlrZip] VARCHAR(10) NULL,
    [AdID] VARCHAR(64) NULL,
    [AdSection] VARCHAR(20) NULL,
    [AdMake] VARCHAR(32) NULL,
    [AdModel] VARCHAR(128) NULL,
    [AdSubModel] VARCHAR(128) NULL,
    [AdYear] VARCHAR(8) NULL,
    [AdMiles] VARCHAR(8) NULL,
    [AdHeadline] VARCHAR(4096) NULL,
    [AdText] VARCHAR(MAX) NULL,
    [AdPrice] VARCHAR(8) NULL,
    [AdPhone] VARCHAR(32) NULL,
    [AdPic1t] VARCHAR(MAX) NULL,
    [AdPic1] VARCHAR(MAX) NULL,
    [AdIsUsed] BIT NULL,
    [AdExteriorColor] VARCHAR(64) NULL,
    [AdInteriorColor] VARCHAR(64) NULL,
    [AdCertified] VARCHAR(4) NULL,
    [AdStock] VARCHAR(32) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [CerritosAds] (
    [id] VARCHAR(32) NULL,
    [name] VARCHAR(64) NULL,
    [phone] VARCHAR(32) NULL,
    [zip] VARCHAR(5) NULL,
    [condition] VARCHAR(16) NULL,
    [stocknumber] VARCHAR(32) NULL,
    [vin] VARCHAR(64) NULL,
    [year] SMALLINT NULL,
    [make] VARCHAR(32) NULL,
    [model] VARCHAR(128) NULL,
    [price] MONEY NULL,
    [mileage] INT NULL,
    [engine] VARCHAR(64) NULL,
    [drive] VARCHAR(16) NULL,
    [transmission] VARCHAR(100) NULL,
    [interiorcolor] VARCHAR(128) NULL,
    [exteriorcolor] VARCHAR(128) NULL,
    [citympg] INT NULL,
    [highwaympg] INT NULL,
    [comments] VARCHAR(2400) NULL,
    [options] VARCHAR(4096) NULL,
    [imageurl] VARCHAR(8000) NULL,
    [cartype] INT NULL,
    [sclid] INT NULL
);

CREATE TABLE [CerritosDealers] (
    [id] VARCHAR(32) NULL,
    [name] VARCHAR(64) NULL,
    [phone] VARCHAR(32) NULL,
    [leademail] VARCHAR(96) NULL,
    [website] VARCHAR(128) NULL,
    [street] VARCHAR(64) NULL,
    [city] VARCHAR(32) NULL,
    [state] VARCHAR(2) NULL,
    [zip] VARCHAR(5) NULL
);

CREATE TABLE [ChapmanCustomers] (
    [dlrID] VARCHAR(12) NULL
);

CREATE TABLE [ChapmanData] (
    [dlrID] VARCHAR(12) NULL,
    [adStock] VARCHAR(10) NULL,
    [adVIN] VARCHAR(32) NULL,
    [adYear] VARCHAR(4) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(32) NULL,
    [adTrim] VARCHAR(64) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adPrice] VARCHAR(10) NULL,
    [adMSRP] VARCHAR(10) NULL,
    [adDealerPrice] VARCHAR(10) NULL,
    [adExtColor] VARCHAR(128) NULL,
    [adIntColor] VARCHAR(128) NULL,
    [adTransmission] VARCHAR(64) NULL,
    [adBodyType] VARCHAR(64) NULL,
    [adEngineType] VARCHAR(64) NULL,
    [adDriveType] VARCHAR(64) NULL,
    [adFuelType] VARCHAR(32) NULL,
    [adPics] VARCHAR(8000) NULL,
    [adOptions] VARCHAR(6500) NULL,
    [adDescription] VARCHAR(6500) NULL
);

CREATE TABLE [chapmandatatemp] (
    [dlrID] VARCHAR(12) NULL,
    [adStock] VARCHAR(10) NULL,
    [adVIN] VARCHAR(32) NULL,
    [adYear] VARCHAR(4) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(32) NULL,
    [adTrim] VARCHAR(64) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adPrice] VARCHAR(10) NULL,
    [adMSRP] VARCHAR(10) NULL,
    [adDealerPrice] VARCHAR(10) NULL,
    [adExtColor] VARCHAR(128) NULL,
    [adIntColor] VARCHAR(128) NULL,
    [adTransmission] VARCHAR(64) NULL,
    [adBodyType] VARCHAR(64) NULL,
    [adEngineType] VARCHAR(64) NULL,
    [adDriveType] VARCHAR(64) NULL,
    [adFuelType] VARCHAR(32) NULL,
    [adPics] VARCHAR(8000) NULL,
    [adOptions] VARCHAR(6500) NULL,
    [adDescription] VARCHAR(6500) NULL
);

CREATE TABLE [ChapmanDealers] (
    [chapid] INT NOT NULL -- PK,
    [dlrid] VARCHAR(50) NOT NULL,
    [dlrname] VARCHAR(50) NOT NULL,
    [dlrphone] VARCHAR(50) NULL,
    [dlraddress] VARCHAR(50) NULL,
    [dlrcity] VARCHAR(50) NULL,
    [dlrstate] VARCHAR(50) NULL,
    [dlrzip] VARCHAR(50) NULL,
    [created] SMALLDATETIME NOT NULL,
    [active] BIT NOT NULL
);

CREATE TABLE [CharterDupeBestRideFeed] (
    [dlrid] VARCHAR(16) NOT NULL -- PK,
    [dlrname] VARCHAR(64) NOT NULL,
    [dupeCreated] DATETIME NOT NULL,
    [dupeUpdated] DATETIME NOT NULL,
    [dupeActive] BIT NOT NULL
);

CREATE TABLE [CharterFeed] (
    [ADNUM] INT NOT NULL,
    [PUBID] INT NOT NULL,
    [FIRSTUPLOAD] DATETIME NULL,
    [LASTUPLOAD] DATETIME NULL,
    [Active] BIT NULL,
    [SCLID] INT NULL,
    [CUSID] INT NULL,
    [ADYEAR] INT NULL,
    [ADMAKE] VARCHAR(32) NULL,
    [ADMODEL] VARCHAR(50) NULL,
    [ADTEXT] VARCHAR(512) NULL,
    [ADPHONE] VARCHAR(16) NULL,
    [ADPRICE] INT NULL,
    [DLRZIP] INT NULL,
    [ADID] INT NULL
);

CREATE TABLE [ChromacarsCustomers] (
    [dlrID] VARCHAR(32) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddr] VARCHAR(128) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZip] VARCHAR(10) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrURL] VARCHAR(128) NULL,
    [dlrPhone] VARCHAR(18) NULL
);

CREATE TABLE [ChromacarsData] (
    [dlrID] VARCHAR(32) NULL,
    [adID] VARCHAR(32) NULL,
    [adStock] VARCHAR(32) NULL,
    [adVIN] VARCHAR(32) NULL,
    [adSection] VARCHAR(64) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(128) NULL,
    [adSubModel] VARCHAR(128) NULL,
    [adYear] VARCHAR(8) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adColor] VARCHAR(128) NULL,
    [adHeadline] VARCHAR(1024) NULL,
    [adText] VARCHAR(MAX) NULL,
    [adPrice] VARCHAR(MAX) NULL,
    [adPhone] VARCHAR(18) NULL,
    [adPics] VARCHAR(6500) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [CiberTraxTemp] (
    [id] VARCHAR(10) NULL,
    [secondary_source] VARCHAR(64) NULL,
    [year] VARCHAR(32) NULL,
    [make] VARCHAR(32) NULL,
    [model] VARCHAR(32) NULL,
    [title] VARCHAR(256) NULL,
    [url] VARCHAR(512) NULL,
    [image_url] VARCHAR(512) NULL,
    [price] VARCHAR(12) NULL,
    [create_time] VARCHAR(16) NULL,
    [expire_time] VARCHAR(16) NULL,
    [description] VARCHAR(4096) NULL,
    [category] VARCHAR(64) NULL,
    [zip_code] VARCHAR(10) NULL,
    [country] VARCHAR(8) NULL
);

CREATE TABLE [CirrusSolutions_ads] (
    [dlrID] VARCHAR(22) NULL,
    [adID] VARCHAR(64) NULL,
    [adStock] VARCHAR(15) NULL,
    [adVIN] VARCHAR(64) NULL,
    [adSection] VARCHAR(64) NULL,
    [adMake] VARCHAR(64) NULL,
    [adModel] VARCHAR(128) NULL,
    [adSubmodel] VARCHAR(255) NULL,
    [adYear] VARCHAR(12) NULL,
    [adcolor] VARCHAR(64) NULL,
    [adCondition] VARCHAR(9) NULL,
    [adHeadline] VARCHAR(MAX) NULL,
    [adText] VARCHAR(8000) NULL,
    [adCustomText] VARCHAR(8000) NULL,
    [adPrice] VARCHAR(16) NULL,
    [adVDP] VARCHAR(MAX) NULL,
    [adpic1] VARCHAR(MAX) NULL,
    [adpic2] VARCHAR(MAX) NULL,
    [adpic3] VARCHAR(MAX) NULL,
    [adpic4] VARCHAR(MAX) NULL,
    [adpic5] VARCHAR(MAX) NULL,
    [adpic6] VARCHAR(MAX) NULL,
    [adpic7] VARCHAR(MAX) NULL,
    [adpic8] VARCHAR(MAX) NULL,
    [adpic9] VARCHAR(MAX) NULL,
    [adpic10] VARCHAR(MAX) NULL,
    [adpic11] VARCHAR(MAX) NULL,
    [adpic12] VARCHAR(MAX) NULL,
    [adpic13] VARCHAR(MAX) NULL,
    [adpic14] VARCHAR(MAX) NULL,
    [adpic15] VARCHAR(MAX) NULL,
    [adpic16] VARCHAR(MAX) NULL,
    [adpic17] VARCHAR(MAX) NULL,
    [adpic18] VARCHAR(MAX) NULL,
    [adpic19] VARCHAR(MAX) NULL,
    [adpic20] VARCHAR(MAX) NULL,
    [adpic21] VARCHAR(MAX) NULL,
    [adpic22] VARCHAR(MAX) NULL,
    [adpic23] VARCHAR(MAX) NULL,
    [adpic24] VARCHAR(MAX) NULL,
    [adpic25] VARCHAR(MAX) NULL,
    [adpic26] VARCHAR(MAX) NULL,
    [id] INT NOT NULL,
    [adPics] VARCHAR(8000) NULL
);

CREATE TABLE [CLASS] (
    [CLSID] INT NOT NULL -- PK,
    [PUBID] INT NOT NULL,
    [CLSNAME] VARCHAR(64) NOT NULL,
    [CLSORDER] INT NOT NULL,
    [CLSSEARCH] INT NULL
);

CREATE TABLE [ClassicCarsCustomers] (
    [DlrID] VARCHAR(16) NULL,
    [DlrName] VARCHAR(48) NULL,
    [DlrPhone] VARCHAR(12) NULL,
    [DlrAltPhone] VARCHAR(12) NULL,
    [DlrFax] VARCHAR(12) NULL,
    [DlrAddress] VARCHAR(64) NULL,
    [DlrCity] VARCHAR(32) NULL,
    [DlrState] VARCHAR(2) NULL,
    [DlrZip] VARCHAR(10) NULL,
    [DlrEmail] VARCHAR(64) NULL,
    [DlrURL] VARCHAR(64) NULL
);

CREATE TABLE [ClassicCarsData] (
    [DlrID] VARCHAR(16) NULL,
    [adID] INT NULL,
    [adVIN] VARCHAR(17) NULL,
    [adType] VARCHAR(16) NULL,
    [adYear] VARCHAR(4) NULL,
    [adMake] VARCHAR(30) NULL,
    [adModel] VARCHAR(40) NULL,
    [adSubmodel] VARCHAR(32) NULL,
    [adPhone] VARCHAR(12) NULL,
    [adPrice] INT NULL,
    [adHeadline] VARCHAR(128) NULL,
    [adPic1] VARCHAR(512) NULL,
    [adPic2] VARCHAR(512) NULL,
    [adPic3] VARCHAR(512) NULL,
    [adPic4] VARCHAR(512) NULL,
    [adText] VARCHAR(3072) NULL,
    [adImage] VARCHAR(512) NULL,
    [adImages] VARCHAR(3072) NULL,
    [adStock] VARCHAR(128) NULL
);

CREATE TABLE [ClassificationList] (
    [Classification] VARCHAR(50) NOT NULL -- PK,
    [CPL] MONEY NULL
);

CREATE TABLE [CobaltCustomers] (
    [DLRID] VARCHAR(12) NULL,
    [DLRCODE] VARCHAR(12) NULL,
    [DLRNAME] VARCHAR(128) NULL,
    [DLRTITLE] VARCHAR(64) NULL,
    [DLRADDR] VARCHAR(64) NULL,
    [DLRCITY] VARCHAR(32) NULL,
    [DLRSTATE] VARCHAR(2) NULL,
    [DLRZIP] VARCHAR(10) NULL,
    [DLRPHONE] VARCHAR(16) NULL,
    [DLRFAX] VARCHAR(20) NULL,
    [DLREMAIL] VARCHAR(128) NULL,
    [DLRCONTACT] VARCHAR(128) NULL,
    [DLRURL] VARCHAR(128) NULL
);

CREATE TABLE [CobaltData] (
    [DLRID] VARCHAR(12) NULL,
    [ADVIN] VARCHAR(32) NULL,
    [ADSTOCK] VARCHAR(32) NULL,
    [ADMAKE] VARCHAR(64) NULL,
    [ADMODEL] VARCHAR(64) NULL,
    [ADSUBMODEL] VARCHAR(128) NULL,
    [ADYEAR] VARCHAR(4) NULL,
    [ADPRICE] MONEY NULL,
    [ADPRICE2] VARCHAR(10) NULL,
    [MSRP] VARCHAR(10) NULL,
    [INVOICE] VARCHAR(12) NULL,
    [ADMILES] VARCHAR(8) NULL,
    [ADEXTCOLOR] VARCHAR(128) NULL,
    [ADINTCOLOR] VARCHAR(200) NULL,
    [ADTEXT] VARCHAR(5000) NULL,
    [ADAMENITIES] VARCHAR(5000) NULL,
    [ADCERTIFIED] VARCHAR(24) NULL,
    [TRANSMISSION] VARCHAR(2) NULL,
    [ADSECTION] VARCHAR(32) NULL,
    [BODYSTYLE] VARCHAR(64) NULL,
    [ADSPEEDS] VARCHAR(64) NULL,
    [ADDOORS] VARCHAR(12) NULL,
    [ADCYLINDERS] VARCHAR(64) NULL,
    [ADENGINE] VARCHAR(256) NULL,
    [ADCLASS] VARCHAR(128) NULL,
    [TRANSTEXT] VARCHAR(1200) NULL,
    [ENGPOWER] VARCHAR(512) NULL,
    [ENGCONFIG] VARCHAR(512) NULL,
    [DISPLACEMENT] VARCHAR(512) NULL,
    [INDUCTION] VARCHAR(100) NULL,
    [FUELTYPE] VARCHAR(128) NULL,
    [WARRANTY] VARCHAR(2000) NULL,
    [LASTMODIFIED] VARCHAR(32) NULL,
    [ADNUM] VARCHAR(32) NULL,
    [ADPIC1] VARCHAR(MAX) NULL,
    [ADdrivetrain] VARCHAR(32) NULL,
    [oem_model_code] VARCHAR(64) NULL,
    [lot_date] VARCHAR(20) NULL,
    [adVDP] VARCHAR(256) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [ConnTest2] (
    [acc_id] INT NULL,
    [fdUID] INT NULL,
    [ffIDMaster] INT NULL,
    [cusID] INT NULL,
    [fdName] VARCHAR(256) NULL,
    [fdPhone] VARCHAR(16) NULL,
    [fdAddress] VARCHAR(64) NULL,
    [fdCity] VARCHAR(32) NULL,
    [fdState] VARCHAR(2) NULL,
    [fdZip] VARCHAR(5) NULL,
    [DateLive] DATE NULL,
    [DateCancelled] DATE NULL,
    [ffPrice] MONEY NULL,
    [hadFeed] BIT NULL,
    [hadLocal] BIT NULL,
    [hadDisplay] BIT NULL,
    [Source] VARCHAR(256) NULL,
    [Rep] VARCHAR(256) NULL
);

CREATE TABLE [CoreLog] (
    [coreID] INT NOT NULL -- PK,
    [coreCMD] NVARCHAR(4000) NOT NULL,
    [coreDate] DATETIME NOT NULL
);

CREATE TABLE [CrawlVSFeed] (
    [max_captured] DATETIME NULL,
    [job_domain] VARCHAR(128) NOT NULL,
    [max_veh_count] INT NULL,
    [Acc_id] INT NULL,
    [Products] VARCHAR(8000) NULL
);

CREATE TABLE [CROPWORKSPACE] (
    [MEMID] INT NOT NULL,
    [UID] VARCHAR(50) NOT NULL,
    [FILENAME] VARCHAR(50) NOT NULL
);

CREATE TABLE [CSAds] (
    [dlrID] VARCHAR(16) NULL,
    [adID] VARCHAR(32) NULL,
    [adVin] VARCHAR(32) NULL,
    [adSection] VARCHAR(32) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(64) NULL,
    [adSubModel] VARCHAR(64) NULL,
    [adYear] VARCHAR(16) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adHeadline] VARCHAR(600) NULL,
    [adExtColor] VARCHAR(500) NULL,
    [adIntColor] VARCHAR(500) NULL,
    [adText] VARCHAR(4096) NULL,
    [adPrice] VARCHAR(16) NULL,
    [adPhone] VARCHAR(32) NULL,
    [adPics] VARCHAR(4096) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [CSAutoNationAds] (
    [dlrID] VARCHAR(16) NULL,
    [adVIN] VARCHAR(32) NULL,
    [adStock] VARCHAR(32) NULL,
    [adNewUsed] VARCHAR(10) NULL,
    [adYear] VARCHAR(4) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(32) NULL,
    [adTransmission] VARCHAR(32) NULL,
    [adTrim] VARCHAR(64) NULL,
    [adMileage] VARCHAR(16) NULL,
    [adColor] VARCHAR(64) NULL,
    [adIntColor] VARCHAR(64) NULL,
    [adPrice] VARCHAR(10) NULL,
    [adCertified] VARCHAR(8) NULL,
    [adBodyStyle] VARCHAR(8000) NULL,
    [adDescription] VARCHAR(4096) NULL,
    [adVehicleID] VARCHAR(64) NULL,
    [adPics] VARCHAR(8000) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [CSAutoNationDealers] (
    [dlrID] VARCHAR(16) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(32) NULL,
    [dlrState] VARCHAR(16) NULL,
    [dlrZip] VARCHAR(10) NULL,
    [dlrEmail] VARCHAR(255) NULL,
    [dlrURL] VARCHAR(512) NULL,
    [dlrPhone] VARCHAR(32) NULL
);

CREATE TABLE [CSDealers] (
    [dlrID] VARCHAR(16) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(128) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZip] VARCHAR(16) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrURL] VARCHAR(512) NULL,
    [dlrPhone] VARCHAR(32) NULL
);

CREATE TABLE [CSSummitAds] (
    [dlrName] VARCHAR(128) NULL,
    [adVIN] VARCHAR(64) NULL,
    [adNewUsed] VARCHAR(8) NULL,
    [adStock] VARCHAR(64) NULL,
    [adYear] VARCHAR(8) NULL,
    [adMake] VARCHAR(64) NULL,
    [adModel] VARCHAR(128) NULL,
    [adTrim] VARCHAR(64) NULL,
    [adTransmission] VARCHAR(64) NULL,
    [adMileage] VARCHAR(32) NULL,
    [adEngine] VARCHAR(64) NULL,
    [adDescription] VARCHAR(4096) NULL,
    [adColor] VARCHAR(64) NULL,
    [adIntColor] VARCHAR(64) NULL,
    [adNotUsed1] VARCHAR(16) NULL,
    [adVehicleID] VARCHAR(17) NULL,
    [adPrice] VARCHAR(16) NULL,
    [adCertified] VARCHAR(16) NULL,
    [adCarFax] VARCHAR(16) NULL,
    [adNotes] VARCHAR(6000) NULL,
    [adPics] VARCHAR(8000) NULL,
    [adBodyStyle] VARCHAR(64) NULL,
    [id] INT NOT NULL,
    [dlrID] INT NULL
);

CREATE TABLE [CSSummitDealers] (
    [dlrID] INT NOT NULL -- PK,
    [dlrFileName] VARCHAR(256) NOT NULL,
    [dlrName] VARCHAR(256) NOT NULL,
    [dlrAddress] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(32) NULL,
    [dlrState] VARCHAR(16) NULL,
    [dlrZip] VARCHAR(10) NULL,
    [dlrEmail] VARCHAR(255) NULL,
    [dlrURL] VARCHAR(512) NULL,
    [dlrPhone] VARCHAR(32) NULL
);

CREATE TABLE [DataOneCustomers] (
    [dlrID] VARCHAR(16) NULL,
    [dlrName] VARCHAR(16) NULL,
    [dlrEmail] VARCHAR(32) NULL,
    [dlrURL] VARCHAR(32) NULL,
    [dlrPhone] VARCHAR(16) NULL,
    [dlrZip] VARCHAR(5) NULL
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

CREATE TABLE [DCSData] (
    [dlrID] VARCHAR(16) NULL,
    [dlrName] VARCHAR(128) NULL,
    [dlrAddress] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(32) NULL,
    [dlrState] VARCHAR(8) NULL,
    [dlrZip] VARCHAR(16) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrURL] VARCHAR(300) NULL,
    [dlrPhone] VARCHAR(32) NULL,
    [adID] VARCHAR(32) NULL,
    [adStock] VARCHAR(32) NULL,
    [adVin] VARCHAR(32) NULL,
    [adSection] VARCHAR(32) NULL,
    [adCondition] VARCHAR(32) NULL,
    [adCertified] VARCHAR(32) NULL,
    [adYear] VARCHAR(16) NULL,
    [adMake] VARCHAR(64) NULL,
    [adModel] VARCHAR(128) NULL,
    [adSubmodel] VARCHAR(32) NULL,
    [adStyle] VARCHAR(100) NULL,
    [adMiles] VARCHAR(12) NULL,
    [adColorExt] VARCHAR(128) NULL,
    [adColorExtGeneric] VARCHAR(64) NULL,
    [adColorInt] VARCHAR(64) NULL,
    [adText] VARCHAR(MAX) NULL,
    [adOptions] VARCHAR(MAX) NULL,
    [adPrice] VARCHAR(16) NULL,
    [adInvoice] VARCHAR(32) NULL,
    [adMSRP] VARCHAR(32) NULL,
    [adMiscPrice1] VARCHAR(32) NULL,
    [adMiscPrice2] VARCHAR(32) NULL,
    [adModelCode] VARCHAR(32) NULL,
    [adPurchaseDate] VARCHAR(32) NULL,
    [adWheelbase] VARCHAR(32) NULL,
    [adDoors] VARCHAR(32) NULL,
    [adTransmission] VARCHAR(100) NULL,
    [adDriveType] VARCHAR(100) NULL,
    [adEngine] VARCHAR(100) NULL,
    [adCylinders] VARCHAR(12) NULL,
    [adDisplacement] VARCHAR(100) NULL,
    [adFuelType] VARCHAR(32) NULL,
    [adMPGCity] VARCHAR(32) NULL,
    [adMPGHighway] VARCHAR(32) NULL,
    [adPics] VARCHAR(MAX) NULL,
    [adVDP] VARCHAR(800) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [DCSDealer] (
    [dlrID] VARCHAR(16) NULL,
    [dlrName] VARCHAR(128) NULL,
    [dlrPhone] VARCHAR(32) NULL,
    [dlrCity] VARCHAR(32) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZip] VARCHAR(16) NULL,
    [dlrURL] VARCHAR(300) NULL,
    [dlrEmail] VARCHAR(128) NULL
);

CREATE TABLE [DCTempCus] (
    [dlrPubID] INT NULL,
    [dlrID] VARCHAR(16) NULL,
    [dlrCompany] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(32) NULL,
    [dlrState] VARCHAR(2) NULL,
    [dlrZip] VARCHAR(10) NULL,
    [dlrEmail] VARCHAR(96) NULL,
    [dlrPhone] VARCHAR(16) NULL,
    [dlrURL] VARCHAR(512) NULL,
    [dlrFax] VARCHAR(16) NULL
);

CREATE TABLE [dealer123] (
    [DlrName] VARCHAR(128) NULL,
    [DlrAddress] VARCHAR(128) NULL,
    [DlrCity] VARCHAR(32) NULL,
    [DlrState] VARCHAR(2) NULL,
    [DlrZip] VARCHAR(16) NULL,
    [DlrPhone] VARCHAR(18) NULL,
    [DlrEmail] VARCHAR(32) NULL,
    [DlrURL] VARCHAR(64) NULL,
    [DlrAggr] VARCHAR(32) NULL,
    [DlrCreated] VARCHAR(32) NULL,
    [DlrID] VARCHAR(16) NULL,
    [advin] VARCHAR(32) NULL,
    [adstock] VARCHAR(16) NULL,
    [adnew] VARCHAR(16) NULL,
    [adyear] VARCHAR(4) NULL,
    [admake] VARCHAR(32) NULL,
    [admodel] VARCHAR(64) NULL,
    [admodelnumber] VARCHAR(32) NULL,
    [adcategory] VARCHAR(32) NULL,
    [adtrans] VARCHAR(100) NULL,
    [adtrim] VARCHAR(225) NULL,
    [addoorss] VARCHAR(16) NULL,
    [admiles] VARCHAR(8) NULL,
    [adcylinders] VARCHAR(32) NULL,
    [addisp] VARCHAR(16) NULL,
    [addrvtrn] VARCHAR(24) NULL,
    [adextclr] VARCHAR(128) NULL,
    [adintclr] VARCHAR(64) NULL,
    [adinvoice] VARCHAR(2) NULL,
    [admsrp] VARCHAR(2) NULL,
    [adbkval] VARCHAR(2) NULL,
    [adprice] VARCHAR(12) NULL,
    [addisc] VARCHAR(8) NULL,
    [adcertified] VARCHAR(4) NULL,
    [adtext] VARCHAR(MAX) NULL,
    [adopt] VARCHAR(MAX) NULL,
    [adpics] VARCHAR(8000) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [DealerActiveAds] (
    [dlrid] VARCHAR(32) NULL,
    [adID] VARCHAR(32) NULL,
    [adStock] VARCHAR(32) NULL,
    [adVIN] VARCHAR(32) NULL,
    [adSection] VARCHAR(32) NULL,
    [adType] VARCHAR(32) NULL,
    [adCertified] VARCHAR(24) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(32) NULL,
    [adSubModel] VARCHAR(64) NULL,
    [adYear] VARCHAR(4) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adColor] VARCHAR(64) NULL,
    [adCondition] VARCHAR(32) NULL,
    [adHeadline] VARCHAR(1024) NULL,
    [adText] VARCHAR(6500) NULL,
    [adCustomText] VARCHAR(6500) NULL,
    [adPrice] VARCHAR(10) NULL,
    [adPhone] VARCHAR(18) NULL,
    [adPics] VARCHAR(6500) NULL,
    [adThumbs] VARCHAR(6500) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [DealerActiveDealers] (
    [dlrid] VARCHAR(256) NULL,
    [dlrName] VARCHAR(256) NULL,
    [dlrAddr] VARCHAR(256) NULL,
    [dlrCity] VARCHAR(256) NULL,
    [dlrState] VARCHAR(256) NULL,
    [dlrZip] VARCHAR(256) NULL,
    [dlrEmail] VARCHAR(256) NULL,
    [dlrURL] VARCHAR(512) NULL,
    [dlrPhone] VARCHAR(256) NULL
);

CREATE TABLE [dealercarsearch] (
    [DLRID] VARCHAR(25) NULL,
    [DLRNAME] VARCHAR(255) NULL,
    [DLRPHONE] VARCHAR(255) NULL,
    [DLRCITY] VARCHAR(100) NULL,
    [DLRSTATE] VARCHAR(50) NULL,
    [DLRZIP] VARCHAR(10) NULL,
    [DLRURL] VARCHAR(512) NULL,
    [DLREMAIL] VARCHAR(255) NULL,
    [ADVIN] VARCHAR(25) NULL,
    [ADSTOCKNUM] VARCHAR(25) NULL,
    [ADPRICE] VARCHAR(50) NULL,
    [ADMILES] VARCHAR(10) NULL,
    [ADCOLOR] VARCHAR(25) NULL,
    [ADINTCOLOR] VARCHAR(25) NULL,
    [ADENGINE] VARCHAR(10) NULL,
    [ADTRANS] VARCHAR(25) NULL,
    [ADYEAR] VARCHAR(4) NULL,
    [ADMAKE] VARCHAR(100) NULL,
    [ADMODEL] VARCHAR(100) NULL,
    [ADNOTES] VARCHAR(2500) NULL,
    [ADOPTIONS] VARCHAR(8000) NULL,
    [ADPICS] VARCHAR(8000) NULL
);

CREATE TABLE [DealerCenterAds] (
    [dlrID] VARCHAR(12) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(128) NULL,
    [dlrCity] VARCHAR(32) NULL,
    [dlrState] VARCHAR(4) NULL,
    [dlrZip] VARCHAR(7) NULL,
    [dlrPhone] VARCHAR(12) NULL,
    [adStock] VARCHAR(64) NULL,
    [adVIN] VARCHAR(MAX) NULL,
    [adYear] VARCHAR(6) NULL,
    [adMake] VARCHAR(64) NULL,
    [adModel] VARCHAR(64) NULL,
    [adSubModel] VARCHAR(128) NULL,
    [adMiles] VARCHAR(10) NULL,
    [adPrice] VARCHAR(10) NULL,
    [adExtColor] VARCHAR(64) NULL,
    [adIntColor] VARCHAR(64) NULL,
    [adTransmission] VARCHAR(100) NULL,
    [adPics] VARCHAR(MAX) NULL,
    [adText] VARCHAR(MAX) NULL,
    [adCustomText] VARCHAR(MAX) NULL,
    [adPhotoModified] VARCHAR(32) NULL,
    [adSection] VARCHAR(23) NULL,
    [adCondition] VARCHAR(16) NULL,
    [Certified] VARCHAR(23) NULL,
    [Style] VARCHAR(23) NULL,
    [Invoice] VARCHAR(23) NULL,
    [MSRP] VARCHAR(23) NULL,
    [MiscPrice1] VARCHAR(23) NULL,
    [MiscPrice2] VARCHAR(23) NULL,
    [ModelCode] VARCHAR(23) NULL,
    [DateInStock] VARCHAR(23) NULL,
    [WheelBase] VARCHAR(23) NULL,
    [Doors] VARCHAR(23) NULL,
    [DriveType] VARCHAR(23) NULL,
    [EngineDescription] VARCHAR(100) NULL,
    [EngineCylinders] VARCHAR(23) NULL,
    [EngineDisplacement] VARCHAR(23) NULL,
    [FuelType] VARCHAR(23) NULL,
    [EPACity] VARCHAR(23) NULL,
    [EPAHighway] VARCHAR(23) NULL,
    [adPic1] VARCHAR(255) NULL,
    [id] INT NOT NULL,
    [AdVDP] VARCHAR(256) NULL,
    [adID] VARCHAR(16) NULL
);

CREATE TABLE [DealerClickData] (
    [dlrID] VARCHAR(32) NULL,
    [adID] VARCHAR(32) NULL,
    [adStock] VARCHAR(32) NULL,
    [adVin] VARCHAR(32) NULL,
    [adSection] VARCHAR(32) NULL,
    [adCertified] VARCHAR(12) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(32) NULL,
    [adSubModel] VARCHAR(128) NULL,
    [adYear] VARCHAR(4) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adColor] VARCHAR(256) NULL,
    [adCondition] VARCHAR(24) NULL,
    [adHeadline] VARCHAR(1028) NULL,
    [adText] VARCHAR(4000) NULL,
    [adCustomText] VARCHAR(4000) NULL,
    [adPrice] VARCHAR(32) NULL,
    [adPhone] VARCHAR(32) NULL,
    [adPict] VARCHAR(512) NULL,
    [adPic1] VARCHAR(6000) NULL,
    [adPic2] VARCHAR(512) NULL,
    [adPic3] VARCHAR(512) NULL,
    [adPic4] VARCHAR(512) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [DealerClickDealers] (
    [dlrID] VARCHAR(32) NULL,
    [dlrName] VARCHAR(96) NULL,
    [dlrAddr] VARCHAR(128) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZip] VARCHAR(10) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrURL] VARCHAR(512) NULL,
    [dlrPhone] VARCHAR(18) NULL
);

CREATE TABLE [dealercom_ads] (
    [dlrID] VARCHAR(40) NULL,
    [AdStock] VARCHAR(32) NULL,
    [adVin] VARCHAR(32) NULL,
    [adSection] VARCHAR(64) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(64) NULL,
    [adSubModel] VARCHAR(64) NULL,
    [adYear] VARCHAR(16) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adHeadline] VARCHAR(MAX) NULL,
    [adText] VARCHAR(MAX) NULL,
    [adPrice] VARCHAR(16) NULL,
    [adPics] VARCHAR(MAX) NULL,
    [adtype] VARCHAR(16) NULL,
    [Certified] VARCHAR(16) NULL,
    [Dealership] VARCHAR(64) NULL,
    [Dealership_address1] VARCHAR(64) NULL,
    [Dealership_address2] VARCHAR(64) NULL,
    [Dealership_city] VARCHAR(64) NULL,
    [Dealership_state] VARCHAR(64) NULL,
    [Dealership_postalcode] VARCHAR(64) NULL,
    [Dealership_country] VARCHAR(64) NULL,
    [Dealership_phone] VARCHAR(64) NULL,
    [Dealership_url] VARCHAR(64) NULL,
    [Dealer_id] VARCHAR(64) NULL,
    [interior_color] VARCHAR(128) NULL,
    [adGenericExteriorColor] VARCHAR(128) NULL,
    [adCustomText] VARCHAR(4000) NULL,
    [adInvoice] VARCHAR(8) NULL,
    [adMSRP] VARCHAR(8) NULL,
    [adMiscPrice1] VARCHAR(12) NULL,
    [adMiscPrice2] VARCHAR(20) NULL,
    [adModelCode] VARCHAR(64) NULL,
    [adDateInStock] VARCHAR(32) NULL,
    [adWheelbase] VARCHAR(8) NULL,
    [adDoors] VARCHAR(16) NULL,
    [adTransmission] VARCHAR(64) NULL,
    [adDriveType] VARCHAR(24) NULL,
    [adEngineDescription] VARCHAR(200) NULL,
    [adEngineCylinders] VARCHAR(4) NULL,
    [adEngineDisplacement] VARCHAR(64) NULL,
    [adFuelType] VARCHAR(64) NULL,
    [adEPACity] VARCHAR(8) NULL,
    [adEPAHighway] VARCHAR(8) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [dealercom_customers] (
    [dlrID] VARCHAR(30) NULL,
    [dlrCompany] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(32) NULL,
    [dlrState] VARCHAR(2) NULL,
    [dlrZip] VARCHAR(10) NULL,
    [dlrEmail] VARCHAR(96) NULL,
    [dlrPhone] VARCHAR(16) NULL,
    [dlrURL] VARCHAR(512) NULL,
    [dlrFax] VARCHAR(16) NULL
);

CREATE TABLE [DealerDirectory] (
    [DDid] INT NOT NULL -- PK,
    [cusid] INT NULL,
    [dlrname] VARCHAR(64) NOT NULL,
    [dlrphone] VARCHAR(16) NOT NULL,
    [dlraddr] VARCHAR(64) NOT NULL,
    [dlrcity] VARCHAR(32) NOT NULL,
    [dlrstate] VARCHAR(2) NOT NULL,
    [dlrzip] VARCHAR(10) NOT NULL,
    [dlrurl] VARCHAR(512) NULL,
    [activeurl] BIT NOT NULL,
    [section] VARCHAR(50) NULL,
    [pubid] INT NOT NULL,
    [region] INT NULL
);

CREATE TABLE [dealerdnaData] (
    [fileid] VARCHAR(64) NULL,
    [dlrid] VARCHAR(64) NULL,
    [advin] VARCHAR(17) NULL,
    [adstock] VARCHAR(32) NULL,
    [adyear] VARCHAR(100) NULL,
    [admake] VARCHAR(32) NULL,
    [admodel] VARCHAR(128) NULL,
    [adtrim] VARCHAR(64) NULL,
    [addoors] VARCHAR(32) NULL,
    [adbodystyle] VARCHAR(64) NULL,
    [adtransmission] VARCHAR(64) NULL,
    [admiles] VARCHAR(100) NULL,
    [adextcolor] VARCHAR(64) NULL,
    [adextcolorcode] VARCHAR(64) NULL,
    [adintcolor] VARCHAR(64) NULL,
    [adintcolorcode] VARCHAR(64) NULL,
    [adengine] VARCHAR(200) NULL,
    [adenginesize] VARCHAR(64) NULL,
    [admodelcode] VARCHAR(64) NULL,
    [adcertified] VARCHAR(35) NULL,
    [retailvalue] VARCHAR(100) NULL,
    [invoiceprice] VARCHAR(100) NULL,
    [askingprice] VARCHAR(100) NULL,
    [wholesaleprice] VARCHAR(100) NULL,
    [MSRPprice] VARCHAR(100) NULL,
    [adprice] VARCHAR(100) NULL,
    [adcondition] VARCHAR(64) NULL,
    [adtext] VARCHAR(MAX) NULL,
    [adoptioncodes] VARCHAR(MAX) NULL,
    [adcomment] VARCHAR(MAX) NULL,
    [adpics] VARCHAR(8000) NULL,
    [adpackagecode] VARCHAR(MAX) NULL,
    [adfueltype] VARCHAR(64) NULL,
    [addriveline] VARCHAR(64) NULL,
    [adwheelbase] VARCHAR(64) NULL,
    [adreceiptdate] VARCHAR(MAX) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [DealerEBiz_Ads] (
    [dlrID] VARCHAR(32) NULL,
    [adID] VARCHAR(32) NULL,
    [adSection] VARCHAR(32) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(32) NULL,
    [adSubModel] VARCHAR(32) NULL,
    [adYear] VARCHAR(8) NULL,
    [adMiles] VARCHAR(8) NULL,
    [adHeadline] VARCHAR(64) NULL,
    [adText] VARCHAR(4096) NULL,
    [adPrice] VARCHAR(16) NULL,
    [adPhone] VARCHAR(16) NULL,
    [AdColorExterior] VARCHAR(32) NULL,
    [Certified] VARCHAR(8) NULL,
    [Condition] VARCHAR(8) NULL,
    [adPics] VARCHAR(1024) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [DealerEBiz_Dealers] (
    [dlrID] VARCHAR(32) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(32) NULL,
    [dlrState] VARCHAR(2) NULL,
    [dlrZIP] VARCHAR(5) NULL,
    [dlrEmail] VARCHAR(64) NULL,
    [dlrURL] VARCHAR(512) NULL,
    [dlrphone] VARCHAR(16) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [DealerEProcessData] (
    [dlrid] VARCHAR(64) NULL,
    [adstock] VARCHAR(10) NULL,
    [advin] VARCHAR(17) NULL,
    [adyear] VARCHAR(100) NULL,
    [admake] VARCHAR(32) NULL,
    [admodel] VARCHAR(128) NULL,
    [modelnumber] VARCHAR(64) NULL,
    [adsection] VARCHAR(32) NULL,
    [bodystyle] VARCHAR(64) NULL,
    [adsubmodel] VARCHAR(64) NULL,
    [adprice] VARCHAR(32) NULL,
    [msrp] VARCHAR(20) NULL,
    [admileage] VARCHAR(16) NULL,
    [addoors] VARCHAR(32) NULL,
    [adcolor] VARCHAR(64) NULL,
    [extcolorhex] VARCHAR(64) NULL,
    [interior] VARCHAR(64) NULL,
    [intcolorhex] VARCHAR(64) NULL,
    [adcondition] VARCHAR(24) NULL,
    [adcertified] VARCHAR(24) NULL,
    [photodate] VARCHAR(64) NULL,
    [adengine] VARCHAR(64) NULL,
    [enginecylinders] VARCHAR(20) NULL,
    [displacement] VARCHAR(128) NULL,
    [adfuel_type] VARCHAR(128) NULL,
    [adtransmission] VARCHAR(64) NULL,
    [adtype] VARCHAR(64) NULL,
    [gears] VARCHAR(8) NULL,
    [adpics] VARCHAR(MAX) NULL,
    [adtext] VARCHAR(MAX) NULL,
    [retailprice] VARCHAR(16) NULL,
    [comments] VARCHAR(4000) NULL,
    [custom1] VARCHAR(4000) NULL,
    [custom2] VARCHAR(4000) NULL,
    [custom3] VARCHAR(4000) NULL,
    [custom4] VARCHAR(4000) NULL,
    [custom5] VARCHAR(8000) NULL,
    [invoice] VARCHAR(16) NULL,
    [price] VARCHAR(16) NULL,
    [daysonline] VARCHAR(MAX) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [DealerFireAds] (
    [dlrID] VARCHAR(12) NULL,
    [adID] VARCHAR(25) NULL,
    [adStock] VARCHAR(16) NULL,
    [adVIN] VARCHAR(25) NULL,
    [adSection] VARCHAR(64) NULL,
    [adSCLID] VARCHAR(64) NULL,
    [adCertified] VARCHAR(9) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(32) NULL,
    [adSubModel] VARCHAR(128) NULL,
    [adYear] VARCHAR(12) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adColor] VARCHAR(64) NULL,
    [adCondition] VARCHAR(16) NULL,
    [adHeadline] VARCHAR(32) NULL,
    [adText] VARCHAR(4096) NULL,
    [adCustomText] VARCHAR(4096) NULL,
    [adPrice] VARCHAR(16) NULL,
    [adPhone] VARCHAR(16) NULL,
    [adPict] VARCHAR(8000) NULL,
    [adPics] VARCHAR(8000) NULL,
    [adPic1] VARCHAR(4000) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [DealerFireDealers] (
    [dlrID] VARCHAR(12) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(43) NULL,
    [dlrState] VARCHAR(8) NULL,
    [dlrZIP] VARCHAR(8) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrURL] VARCHAR(128) NULL,
    [dlrphone] VARCHAR(16) NULL
);

CREATE TABLE [DealerFrontData] (
    [dlrID] VARCHAR(32) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(32) NULL,
    [dlrState] VARCHAR(4) NULL,
    [dlrZIP] VARCHAR(5) NULL,
    [dlrEmail] VARCHAR(64) NULL,
    [dlrURL] VARCHAR(128) NULL,
    [dlrPhone] VARCHAR(32) NULL,
    [dlrID2] VARCHAR(32) NULL,
    [adID] VARCHAR(32) NULL,
    [adVIN] VARCHAR(32) NULL,
    [adSection] VARCHAR(32) NULL,
    [adMake] VARCHAR(64) NULL,
    [adModel] VARCHAR(128) NULL,
    [adSubModel] VARCHAR(128) NULL,
    [adYear] VARCHAR(16) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adHeadline] VARCHAR(4096) NULL,
    [adText] VARCHAR(MAX) NULL,
    [adPrice] VARCHAR(16) NULL,
    [adPhone] VARCHAR(16) NULL,
    [adPics] VARCHAR(MAX) NULL,
    [adextcolor] VARCHAR(128) NULL,
    [adintcolor] VARCHAR(128) NULL,
    [adtransmission] VARCHAR(100) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [DealerFusionAds] (
    [DealerID] VARCHAR(6) NULL,
    [AdYear] VARCHAR(6) NULL,
    [Make] VARCHAR(32) NULL,
    [Model] VARCHAR(128) NULL,
    [Stock] VARCHAR(32) NULL,
    [VIN] VARCHAR(32) NULL,
    [Engine] VARCHAR(64) NULL,
    [Transmission] VARCHAR(64) NULL,
    [Miles] VARCHAR(10) NULL,
    [Price] VARCHAR(10) NULL,
    [Color] VARCHAR(64) NULL,
    [StandardModel] VARCHAR(48) NULL,
    [Dealership] VARCHAR(64) NULL,
    [DealerAddress] VARCHAR(64) NULL,
    [DealerCity] VARCHAR(32) NULL,
    [DealerState] VARCHAR(2) NULL,
    [DealerZipcode] VARCHAR(6) NULL,
    [DealerPhone] VARCHAR(16) NULL,
    [DealerPhoneExt] VARCHAR(6) NULL,
    [DealerEmail] VARCHAR(64) NULL,
    [Certified] VARCHAR(6) NULL,
    [AdDescription] VARCHAR(MAX) NULL,
    [Options] VARCHAR(6400) NULL,
    [Preferred] VARCHAR(6) NULL,
    [HighOctaneURL] VARCHAR(512) NULL,
    [DisplayPhone] VARCHAR(500) NULL,
    [ImageURLs] VARCHAR(6400) NULL,
    [id] INT NOT NULL,
    [ctid] INT NULL
);

CREATE TABLE [DealerHDCustomers] (
    [dlrID] VARCHAR(32) NULL,
    [dlrName] VARCHAR(32) NULL,
    [dlrAddr] VARCHAR(128) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZip] VARCHAR(10) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrURL] VARCHAR(512) NULL,
    [dlrPhone] VARCHAR(18) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [DealerHDData] (
    [dlrID] VARCHAR(32) NULL,
    [adID] VARCHAR(32) NULL,
    [adStock] VARCHAR(32) NULL,
    [adVin] VARCHAR(32) NULL,
    [adSection] VARCHAR(32) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(32) NULL,
    [adTrim] VARCHAR(64) NULL,
    [adYear] VARCHAR(4) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adColor] VARCHAR(64) NULL,
    [adHeadline] VARCHAR(1024) NULL,
    [adText] VARCHAR(MAX) NULL,
    [adPrice] VARCHAR(32) NULL,
    [dlrPhone] VARCHAR(18) NULL,
    [adPics] VARCHAR(MAX) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [DealerHostsAds] (
    [dlrID] VARCHAR(16) NULL,
    [adID] VARCHAR(16) NULL,
    [adStock] VARCHAR(16) NULL,
    [adVIN] VARCHAR(18) NULL,
    [adSection] VARCHAR(32) NULL,
    [adMake] VARCHAR(64) NULL,
    [adModel] VARCHAR(64) NULL,
    [adSubModel] VARCHAR(64) NULL,
    [adYear] VARCHAR(8) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adColor] VARCHAR(64) NULL,
    [adCondition] VARCHAR(24) NULL,
    [adHeadline] VARCHAR(4000) NULL,
    [adText] VARCHAR(4000) NULL,
    [adCustomText] VARCHAR(4000) NULL,
    [adPrice] VARCHAR(16) NULL,
    [adPhone] VARCHAR(16) NULL,
    [adPic1t] VARCHAR(5000) NULL,
    [adPics] VARCHAR(5000) NULL,
    [adThumbs] VARCHAR(5000) NULL,
    [id] INT NOT NULL,
    [cat] INT NULL
);

CREATE TABLE [dealerimages_copied] (
    [imgurl] VARCHAR(512) NULL
);

CREATE TABLE [DealerImpactData] (
    [dlrID] VARCHAR(32) NULL,
    [dlrName] VARCHAR(32) NULL,
    [dlrAddr] VARCHAR(128) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZip] VARCHAR(10) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrURL] VARCHAR(512) NULL,
    [dlrPhone] VARCHAR(18) NULL,
    [adID] VARCHAR(32) NULL,
    [adStock] VARCHAR(32) NULL,
    [adVIN] VARCHAR(32) NULL,
    [adSection] VARCHAR(32) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(32) NULL,
    [adSubmodel] VARCHAR(64) NULL,
    [adYear] VARCHAR(4) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adColor] VARCHAR(64) NULL,
    [adHeadline] VARCHAR(4096) NULL,
    [adText] VARCHAR(6500) NULL,
    [adPrice] VARCHAR(12) NULL,
    [adPhone] VARCHAR(12) NULL,
    [adPics] VARCHAR(MAX) NULL,
    [adThumb] VARCHAR(8000) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [DealerInspireAds] (
    [AdStock] VARCHAR(MAX) NULL,
    [AdVIN] VARCHAR(17) NULL,
    [AdCondition] VARCHAR(24) NULL,
    [AdYear] VARCHAR(MAX) NULL,
    [AdMake] VARCHAR(64) NULL,
    [AdModel] VARCHAR(32) NULL,
    [AdTrim] VARCHAR(32) NULL,
    [AdMiles] VARCHAR(10) NULL,
    [AdColorExt] VARCHAR(64) NULL,
    [AdColorInt] VARCHAR(64) NULL,
    [AdFuelType] VARCHAR(64) NULL,
    [AdDriveTrain] VARCHAR(64) NULL,
    [AdEngineSize] VARCHAR(MAX) NULL,
    [AdTransmission] VARCHAR(64) NULL,
    [AdDoors] VARCHAR(12) NULL,
    [AdCylinder] VARCHAR(2) NULL,
    [AdPrice] VARCHAR(8) NULL,
    [AdOptions] VARCHAR(8000) NULL,
    [AdText] VARCHAR(8000) NULL,
    [AdFinancingAvail] VARCHAR(12) NULL,
    [AdManufactureProgram] VARCHAR(12) NULL,
    [AdWarranty] VARCHAR(12) NULL,
    [AdWarrantyDescription] VARCHAR(12) NULL,
    [AdPic1] VARCHAR(300) NULL,
    [AdPic1Date] VARCHAR(12) NULL,
    [AdImages] VARCHAR(MAX) NULL,
    [AdImagesDate] VARCHAR(12) NULL,
    [AdCat] VARCHAR(12) NULL,
    [ADVDPURL] VARCHAR(255) NULL,
    [AdModelCode] VARCHAR(300) NULL,
    [dlrid] VARCHAR(24) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [DealerInspireDealers] (
    [Dlrfilename] VARCHAR(64) NULL,
    [Dlrid] VARCHAR(64) NULL,
    [DlrName] VARCHAR(64) NULL,
    [DlrAddress] VARCHAR(100) NULL,
    [DlrCity] VARCHAR(32) NULL,
    [DlrState] VARCHAR(10) NULL,
    [DlrZip] VARCHAR(12) NULL,
    [DlrEmail] VARCHAR(64) NULL,
    [DlrVRP] VARCHAR(20) NULL,
    [DlrPhone] VARCHAR(20) NULL
);

CREATE TABLE [DealerLocation] (
    [PUBID] INT NOT NULL -- PK,
    [CODE] INT NOT NULL -- PK,
    [LOCATION] VARCHAR(50) NOT NULL
);

CREATE TABLE [DealerLogin_Log] (
    [memID] INT NULL,
    [pubID_Old] INT NULL,
    [pubID_New] INT NULL,
    [cusID_Old] INT NULL,
    [cusID_New] INT NULL,
    [UserName] VARCHAR(2048) NULL,
    [ChangeDate] DATETIME NULL
);

CREATE TABLE [DealerLogin_MailLog] (
    [emlid] INT NOT NULL -- PK,
    [memid] INT NOT NULL,
    [dlexpiration] DATETIME NULL,
    [package] INT NOT NULL,
    [mailed] INT NOT NULL,
    [mltid] INT NOT NULL,
    [sentmail] DATETIME NULL,
    [dlrid] INT NOT NULL
);

CREATE TABLE [DealerLoginExpiration] (
    [dle_ID] INT NOT NULL -- PK,
    [memid] INT NOT NULL,
    [dlname] VARCHAR(64) NOT NULL,
    [acc_id_rep] INT NOT NULL,
    [dlexpiration] DATETIME NOT NULL,
    [MailSent] DATETIME NULL
);

CREATE TABLE [DealerLogosTT] (
    [dlid] INT NOT NULL,
    [dlrid] VARCHAR(50) NOT NULL,
    [dlrname] VARCHAR(255) NULL,
    [dlrlogo] VARCHAR(255) NULL
);

CREATE TABLE [DealerMadeAds] (
    [dlrid] VARCHAR(64) NULL,
    [advin] VARCHAR(24) NULL,
    [is_new] VARCHAR(8) NULL,
    [adyear] VARCHAR(8) NULL,
    [admake] VARCHAR(64) NULL,
    [admodel] VARCHAR(64) NULL,
    [adbody] VARCHAR(6500) NULL,
    [color_code_ext1] VARCHAR(64) NULL,
    [color_code_int] VARCHAR(64) NULL,
    [color_exterior] VARCHAR(64) NULL,
    [color_interior] VARCHAR(64) NULL,
    [date_entered] VARCHAR(64) NULL,
    [doors] VARCHAR(24) NULL,
    [engine_configuration] VARCHAR(32) NULL,
    [engine_cylinders] VARCHAR(32) NULL,
    [engine_displacement] VARCHAR(32) NULL,
    [engine_string] VARCHAR(64) NULL,
    [fuel] VARCHAR(32) NULL,
    [adpics] VARCHAR(6800) NULL,
    [is_certified] VARCHAR(8) NULL,
    [admiles] VARCHAR(24) NULL,
    [option_codes] VARCHAR(6500) NULL,
    [option_list] VARCHAR(6500) NULL,
    [price_apr] VARCHAR(128) NULL,
    [price_cost] VARCHAR(24) NULL,
    [price_invoice] VARCHAR(24) NULL,
    [price_msrp] VARCHAR(24) NULL,
    [price_msrp_adj] VARCHAR(24) NULL,
    [price_msrp_adj_description] VARCHAR(24) NULL,
    [price_retail] VARCHAR(24) NULL,
    [price_special] VARCHAR(24) NULL,
    [price_term] VARCHAR(24) NULL,
    [service_contract_available] VARCHAR(24) NULL,
    [stock] VARCHAR(24) NULL,
    [title] VARCHAR(128) NULL,
    [trans_string] VARCHAR(64) NULL,
    [adtrim] VARCHAR(64) NULL,
    [warranty_coverage_labor] VARCHAR(12) NULL,
    [warranty_coverage_parts] VARCHAR(12) NULL,
    [warranty_coverage_text] VARCHAR(2000) NULL,
    [warranty_deductable_text] VARCHAR(2000) NULL,
    [warranty_duration_text] VARCHAR(2000) NULL,
    [warranty_ftc_full] VARCHAR(2000) NULL,
    [warranty_type] VARCHAR(64) NULL,
    [wheelbase] VARCHAR(32) NULL,
    [id] INT NOT NULL,
    [adsection] VARCHAR(32) NULL
);

CREATE TABLE [DealerOnAds] (
    [dlrID] VARCHAR(12) NULL,
    [aggID] VARCHAR(12) NULL,
    [adID] VARCHAR(25) NULL,
    [adStock] VARCHAR(20) NULL,
    [adVIN] VARCHAR(25) NULL,
    [adSection] VARCHAR(64) NULL,
    [adSCLID] VARCHAR(64) NULL,
    [VehicleType] VARCHAR(4) NULL,
    [adCertified] VARCHAR(9) NULL,
    [adCertified2] VARCHAR(9) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(64) NULL,
    [adSubModel] VARCHAR(128) NULL,
    [adYear] VARCHAR(12) NULL,
    [adMiles] VARCHAR(16) NULL,
    [color] VARCHAR(64) NULL,
    [adColor] VARCHAR(128) NULL,
    [interiorColor] VARCHAR(128) NULL,
    [condition] VARCHAR(MAX) NULL,
    [adHeadline] VARCHAR(MAX) NULL,
    [adCondition] VARCHAR(16) NULL,
    [adText] VARCHAR(MAX) NULL,
    [adPrice] VARCHAR(16) NULL,
    [adPic1] VARCHAR(4096) NULL,
    [PicDate] VARCHAR(32) NULL,
    [Images] VARCHAR(4) NULL,
    [CarFax] VARCHAR(8) NULL,
    [CertifiedCarTrue] VARCHAR(8) NULL,
    [CityMPG] VARCHAR(4) NULL,
    [CreatedDate] VARCHAR(24) NULL,
    [Currency] VARCHAR(4) NULL,
    [DaysInInv] VARCHAR(6) NULL,
    [DealerCert] VARCHAR(4) NULL,
    [VDP] VARCHAR(256) NULL,
    [Doors] VARCHAR(4) NULL,
    [DriveTrain] VARCHAR(48) NULL,
    [DriveType] VARCHAR(48) NULL,
    [Engine] VARCHAR(200) NULL,
    [EngineCylinder] VARCHAR(16) NULL,
    [EngineCylinderToString] VARCHAR(20) NULL,
    [EngineDisplacement] VARCHAR(4) NULL,
    [ExteriorColorCode] VARCHAR(24) NULL,
    [FuelType] VARCHAR(60) NULL,
    [FuelTypeCode] VARCHAR(4) NULL,
    [FuelTypeShort] VARCHAR(24) NULL,
    [HasWarranty] VARCHAR(4) NULL,
    [HighwayMPG] VARCHAR(4) NULL,
    [HoursOfOperation] VARCHAR(128) NULL,
    [ImageDate] VARCHAR(MAX) NULL,
    [ImagesEncode] VARCHAR(MAX) NULL,
    [ImageIsColorMatch] VARCHAR(8) NULL,
    [ImageIsStock] VARCHAR(8) NULL,
    [ImagesUpdatedDate] VARCHAR(24) NULL,
    [InternetPrice] VARCHAR(12) NULL,
    [InventoryDate] DATE NULL,
    [Invoice] VARCHAR(8) NULL,
    [IsCpo] VARCHAR(8) NULL,
    [IsDmsIndicatedSpecial] VARCHAR(8) NULL,
    [IsPlatformSpecial] VARCHAR(8) NULL,
    [ModelCode] VARCHAR(64) NULL,
    [MSRP] VARCHAR(12) NULL,
    [adPics] VARCHAR(MAX) NULL,
    [PriceChangeDate] VARCHAR(24) NULL,
    [Today] VARCHAR(24) NULL,
    [TransmissionNumber] VARCHAR(4) NULL,
    [TransmissionType] VARCHAR(200) NULL,
    [UpdatedDate] VARCHAR(24) NULL,
    [VideoFeed] VARCHAR(128) NULL,
    [VinProviderID] VARCHAR(32) NULL,
    [Warranty] VARCHAR(4096) NULL,
    [adPhone] VARCHAR(12) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [DealerOnDealers] (
    [dlrID] VARCHAR(12) NULL,
    [aggID] VARCHAR(12) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(43) NULL,
    [dlrState] VARCHAR(8) NULL,
    [dlrZIP] VARCHAR(8) NULL,
    [dlrEmail] VARCHAR(250) NULL,
    [dlrURL] VARCHAR(128) NULL,
    [dlrPhone] VARCHAR(16) NULL
);

CREATE TABLE [DEALERS] (
    [DLRID] INT NOT NULL -- PK,
    [DLRNAME] VARCHAR(64) NULL,
    [DLRADDR] VARCHAR(64) NULL,
    [DLRCITY] VARCHAR(32) NULL,
    [DLRSTATE] VARCHAR(2) NOT NULL,
    [DLRZIP] VARCHAR(10) NULL,
    [DLRPHONE] VARCHAR(16) NOT NULL,
    [DLRALTPHONE] VARCHAR(16) NULL,
    [DLRFAX] VARCHAR(16) NULL,
    [DLREMAIL_STRING] VARCHAR(96) NULL,
    [DLREMAIL_XML] VARCHAR(96) NULL,
    [DLRURL] VARCHAR(512) NULL,
    [CUSID] INT NOT NULL,
    [PUBID] INT NOT NULL,
    [DLRPROFILE] TINYINT NOT NULL,
    [IMG1] VARCHAR(512) NULL,
    [IMG2] VARCHAR(512) NULL,
    [IMG3] VARCHAR(512) NULL,
    [IMG4] VARCHAR(512) NULL,
    [DLRSHOWOTHER] BIT NULL,
    [DLRCAO] BIT NOT NULL
);

CREATE TABLE [DealersByMake] (
    [ddid] INT NOT NULL -- PK,
    [make] VARCHAR(32) NOT NULL -- PK,
    [stockCnt] INT NOT NULL
);

CREATE TABLE [DealerServicesConstructionEquipmentInventory] (
    [DSLookupID] VARCHAR(50) NULL,
    [DisplayName] VARCHAR(50) NULL,
    [Status] VARCHAR(50) NULL,
    [OwnershipType] VARCHAR(50) NULL,
    [Manufacturer] VARCHAR(50) NULL,
    [Model] VARCHAR(50) NULL,
    [Location] VARCHAR(50) NULL,
    [LocationAddress] VARCHAR(50) NULL,
    [LocationCity] VARCHAR(50) NULL,
    [LocationState] VARCHAR(50) NULL,
    [LocationCountry] VARCHAR(50) NULL,
    [Zip Postal Code] VARCHAR(50) NULL,
    [RetailContactName] VARCHAR(50) NULL,
    [RetailContactPhoneNumber] VARCHAR(50) NULL,
    [RetailContactPhoneExtension] VARCHAR(50) NULL,
    [WholesaleContactName] VARCHAR(50) NULL,
    [WholesaleContactPhoneNumber] VARCHAR(50) NULL,
    [RentalContactPhoneNumber] VARCHAR(50) NULL,
    [RentalContactPhoneExtension] VARCHAR(50) NULL,
    [RetailLeadGroupID] VARCHAR(50) NULL,
    [Year] VARCHAR(50) NULL,
    [Condition] VARCHAR(50) NULL,
    [Serial Number] VARCHAR(50) NULL,
    [Stock Number] VARCHAR(50) NULL,
    [Description] VARCHAR(4000) NULL,
    [Display To Public] VARCHAR(50) NULL,
    [DisplayOnFastTrackIron] VARCHAR(50) NULL,
    [CertifiedUsed] VARCHAR(50) NULL,
    [ForSale] VARCHAR(50) NULL,
    [List Price] VARCHAR(50) NULL,
    [ForRent] VARCHAR(50) NULL,
    [AcquisitionDate] VARCHAR(50) NULL,
    [Equipment Status] VARCHAR(50) NULL,
    [ForLease] VARCHAR(50) NULL,
    [ForFractionalOwnership] VARCHAR(50) NULL,
    [ForCharter] VARCHAR(50) NULL,
    [Pictures] VARCHAR(4000) NULL,
    [Currency] VARCHAR(50) NULL,
    [OwnerName] VARCHAR(50) NULL,
    [DSBusinessUnitName] VARCHAR(50) NULL,
    [DataExchangeListingLookupID] VARCHAR(50) NULL,
    [OnAuction] VARCHAR(50) NULL,
    [ExportStatus] VARCHAR(50) NULL,
    [ExportedOn] VARCHAR(50) NULL,
    [ExportMessage] VARCHAR(50) NULL,
    [drive] VARCHAR(50) NULL,
    [Horse Power] VARCHAR(50) NULL,
    [hours] VARCHAR(50) NULL,
    [DataVersion] VARCHAR(50) NULL,
    [InternalNotes] VARCHAR(50) NULL,
    [ConstructionEquipment ID] VARCHAR(50) NULL,
    [Category] VARCHAR(50) NULL,
    [differentiallock] VARCHAR(50) NULL,
    [ropstype] VARCHAR(50) NULL,
    [airconditioning] VARCHAR(50) NULL,
    [heater] VARCHAR(50) NULL,
    [operatingweight] VARCHAR(50) NULL,
    [enginemake] VARCHAR(50) NULL,
    [tracktype] VARCHAR(50) NULL,
    [capacity] VARCHAR(50) NULL,
    [cruisespeed] VARCHAR(50) NULL,
    [fuelcapacity] VARCHAR(50) NULL,
    [height] VARCHAR(50) NULL,
    [length] VARCHAR(50) NULL,
    [lengthwithbucket] VARCHAR(50) NULL,
    [width] VARCHAR(50) NULL,
    [hydrhighflow] VARCHAR(50) NULL,
    [shippingweight] VARCHAR(50) NULL,
    [trackshoewidth] VARCHAR(50) NULL,
    [bucketsize] VARCHAR(50) NULL,
    [hydraux] VARCHAR(50) NULL,
    [quickattach] VARCHAR(50) NULL,
    [accondition] VARCHAR(50) NULL,
    [thumb] VARCHAR(50) NULL,
    [thumbtype] VARCHAR(50) NULL,
    [bucket] VARCHAR(50) NULL,
    [headlightswork] VARCHAR(50) NULL,
    [operatorcontrols] VARCHAR(50) NULL,
    [turbo] VARCHAR(50) NULL,
    [twospeed] VARCHAR(50) NULL,
    [buckettype] VARCHAR(50) NULL,
    [extendahoe] VARCHAR(50) NULL,
    [outriggers] VARCHAR(50) NULL,
    [transmissiontype] VARCHAR(50) NULL
);

CREATE TABLE [DealershipIDSAds] (
    [dlrid] VARCHAR(10) NULL,
    [adid] VARCHAR(50) NULL,
    [adstock] VARCHAR(50) NULL,
    [advin] VARCHAR(50) NULL,
    [adSection] VARCHAR(50) NULL,
    [admake] VARCHAR(50) NULL,
    [admodel] VARCHAR(50) NULL,
    [adyear] VARCHAR(50) NULL,
    [admiles] VARCHAR(50) NULL,
    [adcolor] VARCHAR(256) NULL,
    [adcondition] VARCHAR(500) NULL,
    [adheadline] VARCHAR(2000) NULL,
    [adtext] VARCHAR(5000) NULL,
    [adcustomtext] VARCHAR(5000) NULL,
    [adprice] VARCHAR(50) NULL,
    [adphone] VARCHAR(50) NULL,
    [adthumbs] VARCHAR(8000) NULL,
    [adpics] VARCHAR(8000) NULL,
    [adbodystyle] VARCHAR(50) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [DealershipIDSDealers] (
    [dlrid] VARCHAR(50) NULL,
    [dlrname] VARCHAR(100) NULL,
    [dlraddress] VARCHAR(100) NULL,
    [dlrcity] VARCHAR(50) NULL,
    [dlrstate] VARCHAR(50) NULL,
    [dlrzip] VARCHAR(50) NULL,
    [dlremail] VARCHAR(100) NULL,
    [dlrurl] VARCHAR(100) NULL,
    [dlrphone] VARCHAR(50) NULL
);

CREATE TABLE [DealersLinkAds] (
    [dlrID] VARCHAR(24) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(32) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZIP] VARCHAR(12) NULL,
    [dlrEmail] VARCHAR(64) NULL,
    [dlrURL] VARCHAR(64) NULL,
    [dlrPhone] VARCHAR(24) NULL,
    [adid] VARCHAR(50) NULL,
    [adstock] VARCHAR(50) NULL,
    [advin] VARCHAR(50) NULL,
    [adsection] VARCHAR(255) NULL,
    [adtype] VARCHAR(50) NULL,
    [adcertified] VARCHAR(50) NULL,
    [admake] VARCHAR(32) NULL,
    [admodel] VARCHAR(128) NULL,
    [adsubmodel] VARCHAR(255) NULL,
    [adyear] VARCHAR(50) NULL,
    [admiles] VARCHAR(8) NULL,
    [adcolor] VARCHAR(256) NULL,
    [adcondition] VARCHAR(50) NULL,
    [adheadline] VARCHAR(128) NULL,
    [adtext] VARCHAR(MAX) NULL,
    [adcustomtext] VARCHAR(MAX) NULL,
    [adprice] VARCHAR(50) NULL,
    [adphone] VARCHAR(50) NULL,
    [adpics] VARCHAR(MAX) NULL,
    [adStyle] VARCHAR(50) NULL,
    [adGenericExteriorColor] VARCHAR(50) NULL,
    [adInteriorColor] VARCHAR(50) NULL,
    [adInvoice] VARCHAR(50) NULL,
    [adMSRP] VARCHAR(50) NULL,
    [adMiscPrice1] VARCHAR(50) NULL,
    [adMiscPrice2] VARCHAR(50) NULL,
    [adModelCode] VARCHAR(50) NULL,
    [adDateInStock] VARCHAR(50) NULL,
    [adDoors] VARCHAR(50) NULL,
    [adTransmission] VARCHAR(50) NULL,
    [adDriveType] VARCHAR(50) NULL,
    [adEngineDescription] VARCHAR(50) NULL,
    [adEngineCylinders] VARCHAR(50) NULL,
    [adEngineDisplacement] VARCHAR(50) NULL,
    [adFuelType] VARCHAR(50) NULL,
    [adEPACity] VARCHAR(50) NULL,
    [adEPAHighway] VARCHAR(50) NULL,
    [addealername] VARCHAR(50) NULL,
    [addealerlocation] VARCHAR(MAX) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [DealerSpikeAds] (
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(32) NULL,
    [dlrState] VARCHAR(10) NULL,
    [dlrZIP] VARCHAR(5) NULL,
    [dlrPhone] VARCHAR(16) NULL,
    [dlrEmail] VARCHAR(64) NULL,
    [adid] VARCHAR(64) NULL,
    [admvdp] VARCHAR(256) NULL,
    [adVIN] VARCHAR(17) NULL,
    [adStock] VARCHAR(50) NULL,
    [adcat] VARCHAR(128) NULL,
    [adtype] VARCHAR(128) NULL,
    [adcattype] VARCHAR(128) NULL,
    [adyear] VARCHAR(64) NULL,
    [adMake] VARCHAR(128) NULL,
    [adModel] VARCHAR(128) NULL,
    [adcondition] VARCHAR(128) NULL,
    [adexteriorcolor] VARCHAR(128) NULL,
    [adprice] VARCHAR(64) NULL,
    [admiles] VARCHAR(64) NULL,
    [addescription] VARCHAR(8000) NULL,
    [adimages] VARCHAR(MAX) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [DealerSpikePhotos] (
    [adid] VARCHAR(64) NULL,
    [imgurl] VARCHAR(512) NULL,
    [imgsort] VARCHAR(512) NULL
);

CREATE TABLE [DEALERSUBMIT2] (
    [DSUBID] INT NOT NULL -- PK,
    [MEMID] INT NOT NULL,
    [PUBID] INT NOT NULL,
    [SCLID] INT NOT NULL,
    [ECLSNUMBER] INT NULL,
    [DSUBYEAR] SMALLINT NOT NULL,
    [DSUBMAKE] VARCHAR(32) NOT NULL,
    [DSUBMODEL] VARCHAR(64) NOT NULL,
    [DSUBSMODEL] VARCHAR(128) NULL,
    [DSUBADTEXT] VARCHAR(2048) NOT NULL,
    [DSUBHEADLINE] VARCHAR(255) NULL,
    [DSUBBOXED] BIT NULL,
    [DSUBINS] TINYINT NOT NULL,
    [DSUBPRICE] MONEY NOT NULL,
    [DSUBENTERED] SMALLDATETIME NOT NULL,
    [DSUBSTATUS] TINYINT NOT NULL,
    [DSUBADTYPE] TINYINT NOT NULL,
    [DSUBEMAIL] VARCHAR(64) NULL,
    [DSUBPHONE] VARCHAR(12) NOT NULL,
    [DSUBNOPHONE] BIT NOT NULL,
    [DSUBPREFERRED] BIT NOT NULL,
    [ADID] INT NULL,
    [DSUBPACKAGE] INT NULL,
    [DSUBVIN] VARCHAR(17) NULL,
    [DSUBREASON] VARCHAR(255) NULL,
    [DSUBTHUMB] VARCHAR(255) NULL,
    [DSUBSTOCKNO] VARCHAR(32) NULL
);

CREATE TABLE [DealerSubmitWithReturns] (
    [adid] INT NOT NULL
);

CREATE TABLE [DealerSyncAds] (
    [dlrid] VARCHAR(32) NULL,
    [adID] VARCHAR(32) NULL,
    [adStock] VARCHAR(32) NULL,
    [adVIN] VARCHAR(32) NULL,
    [adSection] VARCHAR(32) NULL,
    [adType] VARCHAR(32) NULL,
    [adCertified] VARCHAR(24) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(64) NULL,
    [adSubModel] VARCHAR(64) NULL,
    [adYear] VARCHAR(4) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adColor] VARCHAR(64) NULL,
    [adCondition] VARCHAR(32) NULL,
    [adHeadline] VARCHAR(1024) NULL,
    [adText] VARCHAR(6500) NULL,
    [adCustomText] VARCHAR(6500) NULL,
    [adPrice] VARCHAR(16) NULL,
    [adPhone] VARCHAR(18) NULL,
    [adPic1t] VARCHAR(256) NULL,
    [adPic1] VARCHAR(256) NULL,
    [adPic2] VARCHAR(256) NULL,
    [adPic3] VARCHAR(256) NULL,
    [adPic4] VARCHAR(256) NULL,
    [adPics] VARCHAR(MAX) NULL,
    [adThumb] VARCHAR(MAX) NULL,
    [adStyle] VARCHAR(64) NULL,
    [adGenericExteriorColor] VARCHAR(64) NULL,
    [adInteriorColor] VARCHAR(64) NULL,
    [adDoors] VARCHAR(8) NULL,
    [adTransmission] VARCHAR(64) NULL,
    [adDriveType] VARCHAR(64) NULL,
    [adEngineDescription] VARCHAR(100) NULL,
    [adEngineCylinders] VARCHAR(64) NULL,
    [adFuelType] VARCHAR(64) NULL,
    [adEPACity] VARCHAR(8) NULL,
    [adEPAHighway] VARCHAR(12) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [DealerSyncDealers] (
    [dlrid] VARCHAR(32) NULL,
    [dlrName] VARCHAR(32) NULL,
    [dlrAddr] VARCHAR(128) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZip] VARCHAR(10) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrURL] VARCHAR(128) NULL,
    [dlrPhone] VARCHAR(18) NULL
);

CREATE TABLE [DealerTrackAds] (
    [dlrID] VARCHAR(12) NULL,
    [adID] VARCHAR(25) NULL,
    [adVIN] VARCHAR(25) NULL,
    [adStock] VARCHAR(16) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adYear] VARCHAR(12) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(32) NULL,
    [adSubModel] VARCHAR(128) NULL,
    [adSection] VARCHAR(23) NULL,
    [adTransmission] VARCHAR(23) NULL,
    [adEngine] VARCHAR(100) NULL,
    [adIntColor] VARCHAR(64) NULL,
    [adColor] VARCHAR(64) NULL,
    [adIntColorgen] VARCHAR(32) NULL,
    [adColorgen] VARCHAR(32) NULL,
    [adPrice] VARCHAR(16) NULL,
    [adPriceRetail] VARCHAR(16) NULL,
    [adPriceDealer] VARCHAR(16) NULL,
    [adModelCode] VARCHAR(9) NULL,
    [adExtColorCode] VARCHAR(9) NULL,
    [adIntColorCode] VARCHAR(9) NULL,
    [adCertified] VARCHAR(9) NULL,
    [adCondition] VARCHAR(16) NULL,
    [adInDate] VARCHAR(16) NULL,
    [adComments] VARCHAR(4096) NULL,
    [adPics] VARCHAR(MAX) NULL,
    [adOptions] VARCHAR(4096) NULL,
    [adText] VARCHAR(MAX) NULL,
    [adOptionsCodes] VARCHAR(200) NULL,
    [adMPGCity] VARCHAR(8) NULL,
    [adMPGHWY] VARCHAR(8) NULL,
    [adDoors] VARCHAR(9) NULL,
    [adDrivetrain] VARCHAR(64) NULL,
    [adCabType] VARCHAR(32) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [DealerTrendAds] (
    [DlrID] VARCHAR(16) NULL,
    [advin] VARCHAR(32) NULL,
    [adsection] VARCHAR(32) NULL,
    [admake] VARCHAR(32) NULL,
    [admodel] VARCHAR(128) NULL,
    [adsubmodel] VARCHAR(128) NULL,
    [adyear] VARCHAR(4) NULL,
    [admiles] VARCHAR(8) NULL,
    [adheadline] VARCHAR(2000) NULL,
    [adtext] VARCHAR(8000) NULL,
    [adprice] VARCHAR(16) NULL,
    [adphone] VARCHAR(24) NULL,
    [adpict] VARCHAR(512) NULL,
    [adpics] VARCHAR(8000) NULL,
    [id] INT NOT NULL,
    [adimgcnt] INT NULL
);

CREATE TABLE [DealerTrendData] (
    [DLRID] VARCHAR(12) NULL,
    [DLRNAME] VARCHAR(64) NULL,
    [DLRADDR] VARCHAR(64) NULL,
    [DLRCITY] VARCHAR(36) NULL,
    [DLRSTATE] VARCHAR(100) NULL,
    [DLRZIP] VARCHAR(128) NULL,
    [DLREMAIL] VARCHAR(128) NULL,
    [DLRURL] VARCHAR(128) NULL,
    [DLRPHONE] VARCHAR(256) NULL,
    [ADID] VARCHAR(20) NULL,
    [ADSTOCK] VARCHAR(32) NULL,
    [ADVIN] VARCHAR(20) NULL,
    [ADSECTION] VARCHAR(64) NULL,
    [ADTYPE] VARCHAR(16) NULL,
    [ADYEAR] VARCHAR(8) NULL,
    [ADMAKE] VARCHAR(32) NULL,
    [ADMODEL] VARCHAR(64) NULL,
    [ADSUBMODEL] VARCHAR(64) NULL,
    [ADSTYLE] VARCHAR(100) NULL,
    [ADMILES] VARCHAR(10) NULL,
    [ADEXTCOLOR] VARCHAR(128) NULL,
    [ADGENEXTCOLOR] VARCHAR(128) NULL,
    [ADINTCOLOR] VARCHAR(128) NULL,
    [ADHEADLINE] VARCHAR(64) NULL,
    [ADTEXT] VARCHAR(8000) NULL,
    [ADCUSTOMTEXT] VARCHAR(8000) NULL,
    [ADPRICE] VARCHAR(10) NULL,
    [ADINVOICE] VARCHAR(10) NULL,
    [ADMSRP] VARCHAR(10) NULL,
    [ADMODELCODE] VARCHAR(100) NULL,
    [ADDATEINSTOCK] VARCHAR(64) NULL,
    [ADDOORS] VARCHAR(10) NULL,
    [ADTRANSMISSION] VARCHAR(64) NULL,
    [ADDRIVETYPE] VARCHAR(64) NULL,
    [ADENGINEDESCRIPTION] VARCHAR(256) NULL,
    [ADFUELTYPE] VARCHAR(32) NULL,
    [ADPICS] VARCHAR(MAX) NULL,
    [ADACodeList] VARCHAR(255) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [DealerTrendDealers] (
    [DlrID] VARCHAR(16) NULL,
    [DlrName] VARCHAR(32) NULL,
    [DlrAddress] VARCHAR(32) NULL,
    [DlrCity] VARCHAR(32) NULL,
    [DlrState] VARCHAR(2) NULL,
    [DlrZip] VARCHAR(5) NULL,
    [DlrEmail] VARCHAR(64) NULL,
    [DlrURL] VARCHAR(64) NULL,
    [DlrPhone] VARCHAR(18) NULL
);

CREATE TABLE [DealerVaultData] (
    [adFileType] VARCHAR(10) NULL,
    [DV_DlrID] VARCHAR(9) NULL,
    [DlrId] VARCHAR(15) NULL,
    [adDMS_Type] VARCHAR(12) NULL,
    [adStock] VARCHAR(15) NULL,
    [adcondition] VARCHAR(5) NULL,
    [adstatus] VARCHAR(9) NULL,
    [adInventoryDate] VARCHAR(11) NULL,
    [adPurchaseDate] VARCHAR(11) NULL,
    [adSoldDate] VARCHAR(10) NULL,
    [adVIN] VARCHAR(18) NULL,
    [adYear] VARCHAR(5) NULL,
    [adMake] VARCHAR(16) NULL,
    [adModel] VARCHAR(24) NULL,
    [adModelNumber] VARCHAR(10) NULL,
    [adMiles] VARCHAR(7) NULL,
    [adExteriorColor] VARCHAR(54) NULL,
    [adExteriorColorCode] VARCHAR(27) NULL,
    [adInteriorColor] VARCHAR(51) NULL,
    [adInteriorColorCode] VARCHAR(5) NULL,
    [adSubModel] VARCHAR(45) NULL,
    [adTransmission] VARCHAR(20) NULL,
    [adCyclinder] VARCHAR(4) NULL,
    [adWeight] VARCHAR(8) NULL,
    [adText] VARCHAR(MAX) NULL,
    [adSection] VARCHAR(33) NULL,
    [adEngine] VARCHAR(64) NULL,
    [adFuelType] VARCHAR(24) NULL,
    [adMPG] VARCHAR(10) NULL,
    [adStandardEquipment] VARCHAR(8) NULL,
    [adFactoryAccessoryCode] VARCHAR(MAX) NULL,
    [adFactoryAccessoryDescription] VARCHAR(MAX) NULL,
    [adFactoryAccessoryCost] VARCHAR(8) NULL,
    [adFactoryAccessoryRetail] VARCHAR(8) NULL,
    [adAccessoryCode] VARCHAR(MAX) NULL,
    [adAccessoryDescription] VARCHAR(MAX) NULL,
    [adAccessoryCost] VARCHAR(220) NULL,
    [adAccessoryRetail] VARCHAR(40) NULL,
    [adAccessoryInvoice] VARCHAR(8) NULL,
    [adPackageCode] VARCHAR(MAX) NULL,
    [adLocation] VARCHAR(20) NULL,
    [adCertified] VARCHAR(10) NULL,
    [adCertificationNumber] VARCHAR(12) NULL,
    [adSalesCode] VARCHAR(10) NULL,
    [adWholesale] VARCHAR(12) NULL,
    [adAccountingMake] VARCHAR(24) NULL,
    [adOpenRONumber] VARCHAR(64) NULL,
    [adLicenseFee] VARCHAR(10) NULL,
    [adCategory] VARCHAR(20) NULL,
    [adInvoice] VARCHAR(12) NULL,
    [adCostPack] VARCHAR(24) NULL,
    [adCost] VARCHAR(12) NULL,
    [adHoldback] VARCHAR(12) NULL,
    [adListPrice] VARCHAR(12) NULL,
    [adMSRP] VARCHAR(12) NULL,
    [adPrice] VARCHAR(12) NULL,
    [adVINExplosionYear] VARCHAR(5) NULL,
    [adVINExplosionMake] VARCHAR(24) NULL,
    [adVINExplosionModel] VARCHAR(36) NULL,
    [adVINExplosionTrim] VARCHAR(1000) NULL,
    [adVINExplosionTransmission] VARCHAR(10) NULL,
    [adVINExplosionFuelType] VARCHAR(20) NULL,
    [adVINExplosionEngine] VARCHAR(8) NULL,
    [adVINExplosionGVWRange] VARCHAR(20) NULL,
    [adVINExplosionVehicleOptions] VARCHAR(4000) NULL,
    [adImage_location_URL] VARCHAR(MAX) NULL,
    [adListing_URL] VARCHAR(2000) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [DealerWebsitesAds] (
    [advin] VARCHAR(24) NULL,
    [adyear] VARCHAR(4) NULL,
    [admake] VARCHAR(64) NULL,
    [admodel] VARCHAR(64) NULL,
    [stock] VARCHAR(24) NULL,
    [adprice] VARCHAR(10) NULL,
    [mileage] VARCHAR(10) NULL,
    [exteriorcolor] VARCHAR(32) NULL,
    [interiorcolor] VARCHAR(32) NULL,
    [imageurl] VARCHAR(5000) NULL,
    [trans] VARCHAR(64) NULL,
    [comments] VARCHAR(5000) NULL,
    [valueaddedoptions] VARCHAR(5000) NULL,
    [condition] VARCHAR(128) NULL,
    [dlrid] VARCHAR(24) NULL,
    [id] INT NOT NULL,
    [adSection] VARCHAR(12) NULL
);

CREATE TABLE [DealerWebsitesAdstemp] (
    [advin] VARCHAR(24) NULL,
    [adyear] VARCHAR(4) NULL,
    [admake] VARCHAR(64) NULL,
    [admodel] VARCHAR(64) NULL,
    [stock] VARCHAR(24) NULL,
    [adprice] VARCHAR(10) NULL,
    [mileage] VARCHAR(10) NULL,
    [exteriorcolor] VARCHAR(32) NULL,
    [interiorcolor] VARCHAR(32) NULL,
    [imageurl] VARCHAR(5000) NULL,
    [trans] VARCHAR(64) NULL,
    [comments] VARCHAR(5000) NULL,
    [valueaddedoptions] VARCHAR(5000) NULL,
    [condition] VARCHAR(128) NULL
);

CREATE TABLE [DealerWebsitesDealers] (
    [dlrid] VARCHAR(24) NULL,
    [dlrname] VARCHAR(64) NULL,
    [dlrfilename] VARCHAR(128) NULL,
    [active] BIT NULL
);

CREATE TABLE [DealixVast] (
    [dlrname] VARCHAR(128) NULL,
    [fduid] VARCHAR(50) NULL,
    [office] VARCHAR(128) NULL,
    [cost] INT NULL,
    [source] VARCHAR(50) NULL
);

CREATE TABLE [Destination] (
    [DESTID] INT NOT NULL -- PK,
    [DESTNAME] VARCHAR(50) NOT NULL,
    [ACTIVE] BIT NOT NULL,
    [LEADCOST] MONEY NULL,
    [esrID] INT NULL,
    [esrShortName] VARCHAR(16) NULL,
    [esrSort] INT NULL
);

CREATE TABLE [DestinationRules] (
    [dst_ID] INT NOT NULL -- PK,
    [rule_ID] INT NOT NULL -- PK,
    [active] BIT NOT NULL
);

CREATE TABLE [DF_ADS] (
    [DF_ADID] INT NOT NULL -- PK,
    [DF_DLRID] VARCHAR(8) NOT NULL,
    [DF_ADYEAR] SMALLINT NOT NULL,
    [DF_ADMAKE] VARCHAR(64) NOT NULL,
    [DF_ADMODEL] VARCHAR(128) NOT NULL,
    [DF_ADPRICE] MONEY NULL,
    [DF_ADMILES] INT NOT NULL,
    [DF_CERT] BIT NOT NULL,
    [DF_FEATURED] BIT NOT NULL,
    [DF_VIN] VARCHAR(32) NULL,
    [DF_STOCK] VARCHAR(32) NOT NULL,
    [DF_ENGINE] VARCHAR(64) NULL,
    [DF_TRANS] VARCHAR(64) NULL,
    [DF_DESC] TEXT NULL,
    [DF_CONTACT] VARCHAR(255) NULL,
    [DF_DATE] SMALLDATETIME NOT NULL,
    [DF_IMG1] VARCHAR(512) NULL,
    [DF_IMG2] VARCHAR(512) NULL,
    [DF_IMG3] VARCHAR(512) NULL,
    [DF_IMG4] VARCHAR(512) NULL,
    [DF_IMGURL] VARCHAR(8000) NULL,
    [CTID] TINYINT NULL,
    [DF_DEST] TINYINT NULL,
    [DF_MSG] TEXT NULL,
    [DF_TEXT] VARCHAR(8000) NULL,
    [df_COLOR] VARCHAR(256) NULL
);

CREATE TABLE [DF_DEALERS] (
    [DF_DLRID] VARCHAR(8) NOT NULL -- PK,
    [DF_DLRNAME] VARCHAR(128) NOT NULL,
    [DF_DLRADDR] VARCHAR(128) NOT NULL,
    [DF_DLRCITY] VARCHAR(64) NOT NULL,
    [DF_DLRSTATE] VARCHAR(2) NOT NULL,
    [DF_DLRZIP] VARCHAR(10) NOT NULL,
    [DF_DLRPHONE] VARCHAR(16) NOT NULL,
    [DF_EMAIL] VARCHAR(128) NULL,
    [DF_DLRTAG] VARCHAR(500) NULL
);

CREATE TABLE [diamondAds] (
    [dlrid] INT NULL,
    [advin] VARCHAR(20) NULL,
    [adtype] VARCHAR(64) NULL,
    [admake] VARCHAR(32) NULL,
    [admodel] VARCHAR(32) NULL,
    [adtrim] VARCHAR(64) NULL,
    [adyear] INT NULL,
    [admiles] INT NULL,
    [adheadline] VARCHAR(32) NULL,
    [adtext] VARCHAR(8000) NULL,
    [adprice] VARCHAR(10) NULL,
    [adphone] VARCHAR(16) NULL,
    [adthumbs] VARCHAR(8000) NULL,
    [adpics] VARCHAR(8000) NULL,
    [adcomments] VARCHAR(3000) NULL,
    [adexteriorcolor] VARCHAR(64) NULL,
    [adimgcnt] INT NULL,
    [id] INT NOT NULL
);

CREATE TABLE [diamondDealers] (
    [dlrid] INT NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrUrl] VARCHAR(64) NULL,
    [dlrPhone] VARCHAR(32) NULL,
    [dlrAddr] VARCHAR(128) NULL,
    [dlrCity] VARCHAR(32) NULL,
    [dlrState] VARCHAR(2) NULL,
    [dlrZip] INT NULL,
    [dlrCusid] INT NULL
);

CREATE TABLE [DigitalMagazine] (
    [dmid] INT NOT NULL -- PK,
    [dmurl] VARCHAR(512) NULL,
    [dmcreated] DATETIME NOT NULL,
    [dmactive] BIT NOT NULL
);

CREATE TABLE [digitalmotor] (
    [DealerID] VARCHAR(30) NULL,
    [StockNumber] VARCHAR(20) NULL,
    [InventoryDate] VARCHAR(10) NULL,
    [Type] VARCHAR(10) NULL,
    [Status] VARCHAR(20) NULL,
    [InvoicePrice] VARCHAR(13) NULL,
    [PackAmount] VARCHAR(13) NULL,
    [Cost] VARCHAR(13) NULL,
    [ListPrice] VARCHAR(13) NULL,
    [MSRP] VARCHAR(13) NULL,
    [LotLocation] VARCHAR(256) NULL,
    [Condition] VARCHAR(256) NULL,
    [Tagline] VARCHAR(8000) NULL,
    [IsCertified] VARCHAR(1) NULL,
    [CertificationNumber] VARCHAR(50) NULL,
    [VIN] VARCHAR(17) NULL,
    [Make] VARCHAR(50) NULL,
    [Model] VARCHAR(50) NULL,
    [Year] VARCHAR(4) NULL,
    [ModelCode] VARCHAR(50) NULL,
    [TrimLevel] VARCHAR(80) NULL,
    [SubTrimLevel] VARCHAR(80) NULL,
    [Classification] VARCHAR(50) NULL,
    [VehicleTypeCode] VARCHAR(20) NULL,
    [Odometer] VARCHAR(20) NULL,
    [PayloadCapacity] VARCHAR(20) NULL,
    [SeatingCapacity] VARCHAR(20) NULL,
    [WheelBase] VARCHAR(10) NULL,
    [BodyDescription] VARCHAR(256) NULL,
    [BodyDoorCount] VARCHAR(2) NULL,
    [DriveTrainDescription] VARCHAR(256) NULL,
    [EngineDescription] VARCHAR(256) NULL,
    [CylinderCount] VARCHAR(2) NULL,
    [TransmissionDescription] VARCHAR(256) NULL,
    [TransmissionType] VARCHAR(256) NULL,
    [ExteriorColorDescription] VARCHAR(256) NULL,
    [ExteriorBaseColor] VARCHAR(256) NULL,
    [InteriorDescription] VARCHAR(256) NULL,
    [InteriorColor] VARCHAR(256) NULL,
    [StandardFeatures] VARCHAR(8000) NULL,
    [DealerAddedFeatures] VARCHAR(8000) NULL,
    [CreatedDate] VARCHAR(10) NULL,
    [LastModifiedDate] VARCHAR(10) NULL,
    [ModifiedFlag] VARCHAR(1) NULL,
    [Dealername] VARCHAR(256) NULL,
    [DealerAddress] VARCHAR(256) NULL,
    [DealerCity] VARCHAR(60) NULL,
    [DealerState] VARCHAR(60) NULL,
    [DealerZip] VARCHAR(60) NULL,
    [DealerPhone] VARCHAR(60) NULL,
    [MediaID] VARCHAR(20) NULL,
    [ImageURL] VARCHAR(8000) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [DlrComCustomers] (
    [dlrPubID] INT NULL,
    [dlrID] VARCHAR(16) NULL,
    [dlrCompany] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(32) NULL,
    [dlrState] VARCHAR(2) NULL,
    [dlrZip] VARCHAR(10) NULL,
    [dlrEmail] VARCHAR(96) NULL,
    [dlrPhone] VARCHAR(16) NULL,
    [dlrURL] VARCHAR(512) NULL,
    [dlrFax] VARCHAR(16) NULL
);

CREATE TABLE [DlrComData] (
    [dlrID] VARCHAR(16) NULL,
    [adID] VARCHAR(32) NULL,
    [adVin] VARCHAR(32) NULL,
    [adSection] VARCHAR(64) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(64) NULL,
    [adSubModel] VARCHAR(64) NULL,
    [adYear] VARCHAR(16) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adHeadline] VARCHAR(4096) NULL,
    [adText] VARCHAR(5096) NULL,
    [adPrice] VARCHAR(16) NULL,
    [adPics] VARCHAR(8000) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [DlrIDRep] (
    [dlrid] INT NOT NULL,
    [acc_id_rep] INT NULL
);

CREATE TABLE [DlrMapping] (
    [OLDDLRID] INT NOT NULL -- PK,
    [OLDDLRURL] VARCHAR(512) NULL
);

CREATE TABLE [DlrPeakCustomers] (
    [dlrID] VARCHAR(16) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(128) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrZip] VARCHAR(16) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrPhone] VARCHAR(32) NULL
);

CREATE TABLE [DlrPeakData] (
    [dlrID] VARCHAR(16) NULL,
    [adID] VARCHAR(32) NULL,
    [adVin] VARCHAR(32) NULL,
    [adSection] VARCHAR(32) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(64) NULL,
    [adSubModel] VARCHAR(64) NULL,
    [adYear] VARCHAR(16) NULL,
    [adHeadline] VARCHAR(600) NULL,
    [adText] VARCHAR(4096) NULL,
    [adPrice] VARCHAR(16) NULL,
    [adPhone] VARCHAR(32) NULL,
    [adPics] VARCHAR(4096) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [dlrsource] (
    [DLRID] VARCHAR(25) NULL,
    [CSTOCKNUM] VARCHAR(25) NULL,
    [CVIN] VARCHAR(20) NULL,
    [CYEAR] VARCHAR(4) NULL,
    [CMAKE] VARCHAR(100) NULL,
    [CMODEL] VARCHAR(100) NULL,
    [CTRIM] VARCHAR(100) NULL,
    [CBODYTYPE] VARCHAR(255) NULL,
    [CEXTERIOR] VARCHAR(255) NULL,
    [CINTERIOR] VARCHAR(255) NULL,
    [CMILES] VARCHAR(50) NULL,
    [CPRICE] VARCHAR(255) NULL,
    [CCERTIFIED] VARCHAR(12) NULL,
    [CPHOTOURL] VARCHAR(8000) NULL,
    [CTRANSMISS] VARCHAR(100) NULL,
    [CDESCRIPTION] VARCHAR(4000) NULL,
    [COPTIONS] VARCHAR(8000) NULL,
    [CNEWUSED] VARCHAR(32) NULL,
    [DLRNAME] VARCHAR(255) NULL,
    [DLRPHONE] VARCHAR(255) NULL,
    [DLRADDRESS] VARCHAR(100) NULL,
    [DLRCITY] VARCHAR(100) NULL,
    [DLRSTATE] VARCHAR(50) NULL,
    [DLRZIP] VARCHAR(10) NULL,
    [DLRURL] VARCHAR(512) NULL,
    [DLREMAIL] VARCHAR(255) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [Dlrxlate] (
    [DlrXID] INT NOT NULL -- PK,
    [FID] VARCHAR(50) NOT NULL,
    [DlrID] INT NULL,
    [DlrName] VARCHAR(255) NOT NULL,
    [PubID] INT NOT NULL,
    [EdID] INT NOT NULL
);

CREATE TABLE [DMAtoZIP] (
    [JobState] VARCHAR(12) NULL,
    [DMA] VARCHAR(128) NULL,
    [CenterZip] VARCHAR(5) NULL,
    [JobStates] VARCHAR(128) NULL
);

CREATE TABLE [dsCarParts] (
    [CIDCARP] VARCHAR(4) NULL,
    [CCATEGORY] VARCHAR(12) NULL,
    [CDESCRIPTION] VARCHAR(27) NULL,
    [ASCIILEFT] INT NOT NULL -- PK,
    [ASCIIRIGHT] INT NOT NULL -- PK
);

CREATE TABLE [DSEXPORT] (
    [dlpubid] INT NULL,
    [memid] INT NOT NULL,
    [cusid] INT NULL,
    [acc_id_rep] INT NULL,
    [dlname] VARCHAR(64) NULL,
    [dladdr] VARCHAR(64) NULL,
    [dlcity] VARCHAR(32) NULL,
    [dlstate] VARCHAR(2) NULL,
    [dlzip] VARCHAR(10) NULL,
    [dlphone] VARCHAR(16) NULL,
    [dlemail] VARCHAR(96) NULL,
    [dlxmlemail] BIT NULL,
    [dlurl] VARCHAR(512) NULL,
    [dlimg1] VARCHAR(512) NULL,
    [dsid] INT NULL,
    [dspubid] INT NULL,
    [adid] INT NULL,
    [sclid] INT NULL,
    [dsyear] SMALLINT NULL,
    [dsmake] VARCHAR(32) NULL,
    [dsmodel] VARCHAR(32) NULL,
    [dssmodel] VARCHAR(32) NULL,
    [dsvin] VARCHAR(17) NULL,
    [dsstockno] VARCHAR(32) NULL,
    [dsheadline] VARCHAR(255) NULL,
    [dsadtext] VARCHAR(4610) NULL,
    [dsprice] NUMERIC(10,0) NULL,
    [dsemail] VARCHAR(64) NULL,
    [dszip] VARCHAR(10) NULL,
    [dsphone] VARCHAR(12) NULL,
    [dsnophone] BIT NULL,
    [dsboxed] BIT NULL,
    [dspreferred] BIT NULL,
    [dsstatus] NUMERIC(3,0) NULL,
    [dsimages] NTEXT NULL
);

CREATE TABLE [dslinksnew] (
    [DLRID] VARCHAR(25) NULL,
    [CVIN] VARCHAR(17) NULL,
    [CVEVO] VARCHAR(512) NULL,
    [CALTVIDEO] VARCHAR(255) NULL,
    [CPHOTOURLS] VARCHAR(8000) NULL,
    [CWINDOWSTICKER] VARCHAR(255) NULL,
    [CBUYERSGUIDE] VARCHAR(255) NULL,
    [CAUCTIONLINK] VARCHAR(255) NULL,
    [CVEHHISTREPORT] VARCHAR(255) NULL,
    [CRESERVED1] VARCHAR(255) NULL,
    [CRESERVED2] VARCHAR(255) NULL,
    [CRESERVED3] VARCHAR(255) NULL,
    [CRESERVED4] VARCHAR(255) NULL,
    [CRESERVED5] VARCHAR(255) NULL,
    [CRESERVED6] VARCHAR(255) NULL
);

CREATE TABLE [dslinksnewrev] (
    [DLRID] VARCHAR(25) NULL,
    [CVIN] VARCHAR(17) NULL,
    [CVEVO] VARCHAR(255) NULL,
    [CALTVIDEO] VARCHAR(255) NULL,
    [CPHOTOURLS] VARCHAR(8000) NULL,
    [CWINDOWSTICKER] VARCHAR(255) NULL,
    [CBUYERSGUIDE] VARCHAR(255) NULL,
    [CAUCTIONLINK] VARCHAR(255) NULL,
    [CVEHHISTREPORT] VARCHAR(255) NULL,
    [CRESERVED1] VARCHAR(255) NULL,
    [CRESERVED2] VARCHAR(255) NULL,
    [CRESERVED3] VARCHAR(255) NULL,
    [CRESERVED4] VARCHAR(255) NULL,
    [CRESERVED5] VARCHAR(255) NULL,
    [CRESERVED6] VARCHAR(255) NULL
);

CREATE TABLE [dsLotData] (
    [CIDLOTD] VARCHAR(7) NULL,
    [CIDLICE] VARCHAR(12) NULL,
    [CLOTNUMBER] VARCHAR(10) NULL,
    [CNAME] VARCHAR(104) NULL,
    [CADDRESS1] VARCHAR(32) NULL,
    [CADDRESS2] VARCHAR(32) NULL,
    [CCITY] VARCHAR(32) NULL,
    [CSTATE] VARCHAR(2) NULL,
    [CZIP] VARCHAR(10) NULL,
    [CFIPS] VARCHAR(5) NULL,
    [CPHONE] VARCHAR(50) NULL,
    [CMAINTAINI] VARCHAR(1) NULL,
    [CWARRANTYT] VARCHAR(1) NULL,
    [CPC_LABOR] VARCHAR(3) NULL,
    [CPC_PARTS] VARCHAR(3) NULL,
    [CWARRMONTH] VARCHAR(2) NULL,
    [IWARRMILES] VARCHAR(6) NULL,
    [CSERVICEAG] VARCHAR(1) NULL,
    [CPRINTCONT] VARCHAR(30) NULL,
    [CPRICEPERC] VARCHAR(5) NULL,
    [WEBPAGE1] VARCHAR(100) NULL,
    [WEBPAGE2] VARCHAR(100) NULL,
    [WEBPAGE3] VARCHAR(100) NULL,
    [WEBPAGE4] VARCHAR(100) NULL,
    [WEBPAGE5] VARCHAR(100) NULL,
    [WEBPAGE6] VARCHAR(100) NULL,
    [WEBPAGE7] VARCHAR(100) NULL,
    [LOTEMAIL] VARCHAR(100) NULL,
    [LOTSTATUS] VARCHAR(10) NULL,
    [LOTURL] VARCHAR(100) NULL,
    [LASTUPDATE] DATETIME NULL,
    [CONTACT] VARCHAR(50) NULL,
    [FAXNUM] VARCHAR(16) NULL,
    [LOTSTATUS2] VARCHAR(12) NULL,
    [maxCarsInInventory] SMALLINT NULL,
    [carFaxID] VARCHAR(10) NULL,
    [mileageCheck] VARCHAR(8) NULL,
    [IsAutoNa] VARCHAR(1) NULL,
    [usedCarMgrName] VARCHAR(32) NULL,
    [lotGroupId] VARCHAR(10) NULL,
    [lastUpdateDate] DATETIME NULL,
    [lastTransmissionDate] DATETIME NULL,
    [nadaRegion] VARCHAR(2) NULL,
    [FranchisesRepresented] VARCHAR(32) NULL
);

CREATE TABLE [dslotdatanew] (
    [DLRID] VARCHAR(25) NULL,
    [ALTID] VARCHAR(25) NULL,
    [DLRNAME] VARCHAR(255) NULL,
    [DLRADDRESS1] VARCHAR(100) NULL,
    [DLRADDRESS2] VARCHAR(100) NULL,
    [DLRCITY] VARCHAR(100) NULL,
    [DLRSTATE] VARCHAR(50) NULL,
    [DLRZIP] VARCHAR(10) NULL,
    [DLRPHONE] VARCHAR(255) NULL,
    [DLRFAXNUM] VARCHAR(255) NULL,
    [DLREMAIL] VARCHAR(255) NULL,
    [DLRCONTACT] VARCHAR(100) NULL,
    [DLRCOMMENTS] VARCHAR(8000) NULL,
    [DLRWEBSITE] VARCHAR(255) NULL,
    [DLRBRAND] VARCHAR(500) NULL,
    [DLRVIDEO] VARCHAR(255) NULL,
    [DLRALTVIDEO] VARCHAR(255) NULL,
    [DLRAMENTITIES] VARCHAR(500) NULL,
    [DLRSHOWROOMHOURS] VARCHAR(500) NULL,
    [DLRSERVICEHOURS] VARCHAR(500) NULL,
    [DLRPARTSHOURS] VARCHAR(500) NULL,
    [DLRADMINHOURS] VARCHAR(500) NULL,
    [DLRRESERVED1] VARCHAR(255) NULL,
    [DLRRESERVED2] VARCHAR(255) NULL,
    [DLRRESERVED3] VARCHAR(255) NULL,
    [DLRRESERVED4] VARCHAR(255) NULL,
    [DLRRESERVED5] VARCHAR(255) NULL,
    [DLRRESERVED6] VARCHAR(255) NULL
);

CREATE TABLE [dslotdatanewrev] (
    [DLRID] VARCHAR(25) NULL,
    [DLRNAME] VARCHAR(255) NULL,
    [DLRADDRESS1] VARCHAR(100) NULL,
    [DLRADDRESS2] VARCHAR(100) NULL,
    [DLRCITY] VARCHAR(100) NULL,
    [DLRSTATE] VARCHAR(50) NULL,
    [DLRZIP] VARCHAR(10) NULL,
    [DLRPHONE] VARCHAR(255) NULL,
    [DLRFAXNUM] VARCHAR(255) NULL,
    [DLREMAIL] VARCHAR(255) NULL,
    [DLRCONTACT] VARCHAR(100) NULL,
    [DLRCOMMENTS] VARCHAR(500) NULL,
    [DLRWEBSITE] VARCHAR(255) NULL,
    [DLRBRAND] VARCHAR(500) NULL,
    [DLRVIDEO] VARCHAR(255) NULL,
    [DLRAMENTITIES] VARCHAR(500) NULL,
    [DLRSHOWROOMHOURS] VARCHAR(500) NULL,
    [DLRSERVICEHOURS] VARCHAR(500) NULL,
    [DLRPARTSHOURS] VARCHAR(500) NULL,
    [DLRADMINHOURS] VARCHAR(500) NULL,
    [DLRRESERVED1] VARCHAR(255) NULL,
    [DLRRESERVED2] VARCHAR(255) NULL,
    [DLRRESERVED3] VARCHAR(255) NULL,
    [DLRRESERVED4] VARCHAR(255) NULL,
    [DLRRESERVED5] VARCHAR(255) NULL,
    [DLRRESERVED6] VARCHAR(255) NULL
);

CREATE TABLE [dsrestore] (
    [dsid] INT NULL,
    [adid_old] INT NULL,
    [adid_new] INT NULL
);

CREATE TABLE [dsVehicles] (
    [CIDLOTD] VARCHAR(7) NULL,
    [CVIN] VARCHAR(17) NULL,
    [CSTOCKNUM] VARCHAR(16) NULL,
    [CDISPOSITI] VARCHAR(1) NULL,
    [CMAKE] VARCHAR(2) NULL,
    [CMODEL] VARCHAR(25) NULL,
    [CYEAR] VARCHAR(4) NULL,
    [CMILEAGE] VARCHAR(32) NULL,
    [CBODYTYPE] VARCHAR(2) NULL,
    [CENGINE] VARCHAR(2) NULL,
    [CENGINESIZ] VARCHAR(5) NULL,
    [CINDUCTION] VARCHAR(2) NULL,
    [CTRANSMISS] VARCHAR(2) NULL,
    [CCOLOR] VARCHAR(19) NULL,
    [CPRICE] VARCHAR(25) NULL,
    [CCOST] VARCHAR(10) NULL,
    [CWARRANTY] VARCHAR(1) NULL,
    [CWARRANTYT] VARCHAR(12) NULL,
    [FWARRANTY] VARCHAR(2) NULL,
    [FWARRANTYT] VARCHAR(12) NULL,
    [sclid] VARCHAR(4) NULL,
    [CPC_LABOR] VARCHAR(6) NULL,
    [CPC_PARTS] VARCHAR(6) NULL,
    [CWARRMONTH] VARCHAR(3) NULL,
    [CWARRMILES] VARCHAR(6) NULL,
    [CMANUF_MON] VARCHAR(2) NULL,
    [CMANUF_YEA] VARCHAR(4) NULL,
    [CSERVICEAG] VARCHAR(1) NULL,
    [DDATE_IN] SMALLDATETIME NULL,
    [DDATE_REMO] SMALLDATETIME NULL,
    [O1] VARCHAR(2) NULL,
    [O2] VARCHAR(2) NULL,
    [O3] VARCHAR(2) NULL,
    [O4] VARCHAR(2) NULL,
    [O5] VARCHAR(2) NULL,
    [O6] VARCHAR(2) NULL,
    [O7] VARCHAR(2) NULL,
    [O8] VARCHAR(2) NULL,
    [O9] VARCHAR(2) NULL,
    [O10] VARCHAR(2) NULL,
    [O11] VARCHAR(2) NULL,
    [O12] VARCHAR(2) NULL,
    [O13] VARCHAR(2) NULL,
    [O14] VARCHAR(2) NULL,
    [O15] VARCHAR(2) NULL,
    [O16] VARCHAR(2) NULL,
    [O17] VARCHAR(2) NULL,
    [O18] VARCHAR(2) NULL,
    [O19] VARCHAR(2) NULL,
    [O20] VARCHAR(2) NULL,
    [O21] VARCHAR(2) NULL,
    [O22] VARCHAR(2) NULL,
    [O23] VARCHAR(2) NULL,
    [O24] VARCHAR(2) NULL,
    [O25] VARCHAR(2) NULL,
    [O26] VARCHAR(2) NULL,
    [O27] VARCHAR(2) NULL,
    [O28] VARCHAR(2) NULL,
    [O29] VARCHAR(2) NULL,
    [O30] VARCHAR(2) NULL,
    [O31] VARCHAR(2) NULL,
    [O32] VARCHAR(2) NULL,
    [O33] VARCHAR(2) NULL,
    [O34] VARCHAR(2) NULL,
    [O35] VARCHAR(2) NULL,
    [DUPDATED] SMALLDATETIME NULL,
    [DCREATED] SMALLDATETIME NULL,
    [CPRICING] VARCHAR(8) NULL,
    [DateOnLot] SMALLDATETIME NULL,
    [Freehand] TEXT NULL,
    [recordFlags] VARCHAR(80) NULL,
    [maketxt] VARCHAR(25) NULL,
    [modeltxt] VARCHAR(25) NULL,
    [bodytxt] VARCHAR(25) NULL,
    [enginetxt] VARCHAR(25) NULL,
    [inductiontxt] VARCHAR(25) NULL,
    [transtxt] VARCHAR(25) NULL,
    [externalColor] VARCHAR(50) NULL,
    [internalColor] VARCHAR(50) NULL,
    [laborCost] MONEY NULL,
    [laborPrice] MONEY NULL,
    [internetCost] MONEY NULL,
    [internetPrice] MONEY NULL,
    [manufactureDate] SMALLDATETIME NULL,
    [dateFirstSeen] SMALLDATETIME NULL,
    [nadaID] VARCHAR(8) NULL,
    [certificationNum] VARCHAR(20) NULL,
    [certificationDate] SMALLDATETIME NULL,
    [inServiceDate] SMALLDATETIME NULL,
    [trimLevel] VARCHAR(48) NULL,
    [systemWarrantyNum] SMALLINT NULL,
    [lastInventoryDate] SMALLDATETIME NULL,
    [Options] VARCHAR(8000) NULL,
    [adtext] VARCHAR(8000) NULL,
    [CustOpt] VARCHAR(8000) NULL,
    [img1] VARCHAR(512) NULL,
    [img2] VARCHAR(512) NULL,
    [img3] VARCHAR(512) NULL,
    [img4] VARCHAR(512) NULL
);

CREATE TABLE [dsvehiclesnew] (
    [DLRID] VARCHAR(25) NULL,
    [CVIN] VARCHAR(17) NULL,
    [CSTOCKNUM] VARCHAR(25) NULL,
    [CSTATUS] VARCHAR(2) NULL,
    [CVEHICLETYPE] VARCHAR(4) NULL,
    [CYEAR] VARCHAR(4) NULL,
    [CMAKE] VARCHAR(128) NULL,
    [CMODEL] VARCHAR(128) NULL,
    [CTRIM] VARCHAR(100) NULL,
    [CBODY] VARCHAR(255) NULL,
    [CVEHICLECLASS] VARCHAR(50) NULL,
    [CVEHICLECAT] VARCHAR(50) NULL,
    [CMILEAGE] VARCHAR(50) NULL,
    [CTRANSMISS] VARCHAR(100) NULL,
    [CENGINEDISP] VARCHAR(64) NULL,
    [CENGINESIZE] VARCHAR(100) NULL,
    [CINDUCTION] VARCHAR(100) NULL,
    [CDRIVETRAIN] VARCHAR(60) NULL,
    [CFUELTYPE] VARCHAR(255) NULL,
    [CFUELECONCITY] VARCHAR(100) NULL,
    [CFUELECONHWY] VARCHAR(100) NULL,
    [CFUELECONCOMB] VARCHAR(100) NULL,
    [CDOORS] VARCHAR(10) NULL,
    [COEMCOLORCODEEXTERIOR] VARCHAR(50) NULL,
    [COEMCOLORCODEINTERIOR] VARCHAR(50) NULL,
    [COEMCOLORNAMEEXTERIOR] VARCHAR(50) NULL,
    [COEMCOLORNAMEINTERIOR] VARCHAR(50) NULL,
    [CGENERICCOLOREXTERIOR] VARCHAR(255) NULL,
    [CGENERICCOLORINTERIOR] VARCHAR(255) NULL,
    [CINTERNETPRICE] MONEY NULL,
    [CCOMPARPRICE] MONEY NULL,
    [CWHOLESALEPRICE] MONEY NULL,
    [CMSRP] MONEY NULL,
    [CINTERNETSPECIAL] VARCHAR(1) NULL,
    [COEMMODELCODE] VARCHAR(32) NULL,
    [CWARRANTY] VARCHAR(1) NULL,
    [CCERTWARRANTY] VARCHAR(25) NULL,
    [CWARRMONTH] VARCHAR(3) NULL,
    [CWARRMILES] VARCHAR(10) NULL,
    [CCERTNUMBER] VARCHAR(25) NULL,
    [CSERVICECONTRACT] VARCHAR(2) NULL,
    [DINSERVICE] VARCHAR(255) NULL,
    [DCERTIFICATION] VARCHAR(255) NULL,
    [DMANUFACTURED] VARCHAR(255) NULL,
    [DCREATED] VARCHAR(255) NULL,
    [DUPDATED] VARCHAR(255) NULL,
    [DREMOVED] VARCHAR(255) NULL,
    [DATEPHOTOSUPDATED] VARCHAR(255) NULL,
    [CPHOTOS] VARCHAR(10) NULL,
    [CSSPHOTOS] VARCHAR(10) NULL,
    [CADDENDETAILS] VARCHAR(2000) NULL,
    [CDEPARTCOMMENTS] VARCHAR(255) NULL,
    [CVEHICLECOMMENTS] VARCHAR(4000) NULL,
    [COPTIONS] VARCHAR(8000) NULL,
    [CPURCHPAYMENT] VARCHAR(24) NULL,
    [CPURCHDOWNPAY] MONEY NULL,
    [CPURCHTERM] VARCHAR(24) NULL,
    [CPURCHDISC] VARCHAR(500) NULL,
    [CPURCHRATE] VARCHAR(6) NULL,
    [CLEASEPAYMENT] VARCHAR(24) NULL,
    [CLEASEDOWNPAY] MONEY NULL,
    [CLEASETERM] VARCHAR(24) NULL,
    [CLEASEDISCLOSURE] VARCHAR(500) NULL,
    [CLEASERATE] VARCHAR(24) NULL,
    [CLEASERESIDUAL] VARCHAR(24) NULL,
    [INVOICE] VARCHAR(24) NULL,
    [ACV] VARCHAR(24) NULL,
    [SPECIAL] VARCHAR(24) NULL,
    [DISCOUNT] VARCHAR(24) NULL,
    [OPTIONCODES] VARCHAR(2000) NULL,
    [PACKAGECODES] VARCHAR(2000) NULL,
    [ADID] VARCHAR(24) NULL,
    [STYLE] VARCHAR(80) NULL,
    [WHEELBASE] VARCHAR(10) NULL,
    [MISCPRICE1] VARCHAR(10) NULL,
    [MISCPRICE2] VARCHAR(10) NULL,
    [SCLID] VARCHAR(24) NULL,
    [adtext] VARCHAR(8000) NULL,
    [PhotosURL] VARCHAR(8000) NULL,
    [adphone] VARCHAR(255) NULL,
    [img1] VARCHAR(255) NULL,
    [img2] VARCHAR(255) NULL,
    [img3] VARCHAR(2048) NULL,
    [img4] VARCHAR(255) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [dsvehiclesnewrev] (
    [DLRID] VARCHAR(25) NULL,
    [CVIN] VARCHAR(17) NULL,
    [CSTOCKNUM] VARCHAR(25) NULL,
    [CSTATUS] VARCHAR(2) NULL,
    [CVEHICLETYPE] VARCHAR(4) NULL,
    [CYEAR] VARCHAR(4) NULL,
    [CMAKE] VARCHAR(100) NULL,
    [CMODEL] VARCHAR(100) NULL,
    [CTRIM] VARCHAR(100) NULL,
    [CBODY] VARCHAR(255) NULL,
    [CVEHICLECLASS] VARCHAR(50) NULL,
    [CVEHICLECAT] VARCHAR(50) NULL,
    [CMILEAGE] VARCHAR(50) NULL,
    [CTRANSMISS] VARCHAR(100) NULL,
    [CENGINEDISP] VARCHAR(64) NULL,
    [CENGINESIZE] VARCHAR(32) NULL,
    [CINDUCTION] VARCHAR(100) NULL,
    [CDRIVETRAIN] VARCHAR(10) NULL,
    [CFUELTYPE] VARCHAR(255) NULL,
    [CFUELECONCITY] VARCHAR(100) NULL,
    [CFUELECONHWY] VARCHAR(100) NULL,
    [CFUELECONCOMB] VARCHAR(100) NULL,
    [CDOORS] VARCHAR(10) NULL,
    [OEMCOLORCODEEXTERIOR] VARCHAR(50) NULL,
    [OEMCOLORCODEINTERIOR] VARCHAR(50) NULL,
    [COEMCOLORNAMEEXTERIOR] VARCHAR(50) NULL,
    [COEMCOLORNAMEINTERIOR] VARCHAR(50) NULL,
    [CGENERICCOLOREXTERIOR] VARCHAR(255) NULL,
    [CGENERICCOLORINTERIOR] VARCHAR(255) NULL,
    [CINTERNETPRICE] MONEY NULL,
    [CCOMPARPRICE] MONEY NULL,
    [CWHOLESALEPRICE] MONEY NULL,
    [CMSRP] MONEY NULL,
    [CINTERNETSPECIAL] VARCHAR(1) NULL,
    [COEMMODELCODE] VARCHAR(32) NULL,
    [CWARRANTY] VARCHAR(1) NULL,
    [CCERTWARRANTY] VARCHAR(25) NULL,
    [CWARRMONTH] VARCHAR(3) NULL,
    [CWARRMILES] VARCHAR(10) NULL,
    [CCERTNUMBER] VARCHAR(25) NULL,
    [CSERVICECONTRACT] VARCHAR(2) NULL,
    [DINSERVICE] VARCHAR(255) NULL,
    [DCERTIFICATION] VARCHAR(255) NULL,
    [DMANUFACTURED] VARCHAR(255) NULL,
    [DCREATED] VARCHAR(255) NULL,
    [DUPDATED] VARCHAR(255) NULL,
    [DREMOVED] VARCHAR(255) NULL,
    [DATEPHOTOSUPDATED] VARCHAR(512) NULL,
    [CPHOTOS] VARCHAR(10) NULL,
    [CSSPHOTOS] VARCHAR(10) NULL,
    [CADDENDETAILS] VARCHAR(2000) NULL,
    [CDEPARTCOMMENTS] VARCHAR(255) NULL,
    [CVEHICLECOMMENTS] VARCHAR(4000) NULL,
    [COPTIONS] VARCHAR(8000) NULL,
    [CPURCHPAYMENT] VARCHAR(24) NULL,
    [CPURCHDOWNPAY] MONEY NULL,
    [CPURCHTERM] VARCHAR(24) NULL,
    [CPURCHDISC] VARCHAR(500) NULL,
    [CPURCHRATE] VARCHAR(6) NULL,
    [CLEASEPAYMENT] VARCHAR(24) NULL,
    [CLEASEDOWNPAY] MONEY NULL,
    [CLEASETERM] VARCHAR(24) NULL,
    [CLEASEDISCLOSURE] VARCHAR(500) NULL,
    [sclid] VARCHAR(500) NULL,
    [adtext] VARCHAR(8000) NULL,
    [CustOpt] VARCHAR(8000) NULL,
    [cwarrantyt] VARCHAR(255) NULL,
    [img1] VARCHAR(512) NULL,
    [img2] VARCHAR(512) NULL,
    [img3] VARCHAR(512) NULL,
    [img4] VARCHAR(512) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [DSVIDEO] (
    [DSID] INT NOT NULL -- PK,
    [DSVTHUMBURL] VARCHAR(512) NOT NULL,
    [DSVEXIST] BIT NOT NULL,
    [DSVKEY] VARCHAR(64) NOT NULL,
    [DSVIP] VARCHAR(16) NOT NULL,
    [DSVCREATED] DATETIME NOT NULL,
    [DSVUPDATED] DATETIME NOT NULL
);

CREATE TABLE [DSVKEYERRORS] (
    [DKEID] INT NOT NULL -- PK,
    [DSID] INT NOT NULL,
    [DSVTHUMBURL] VARCHAR(512) NOT NULL,
    [DSVEXIST] BIT NOT NULL,
    [DSVKEY] VARCHAR(64) NOT NULL,
    [DSVIP] VARCHAR(16) NOT NULL,
    [DSVCREATED] DATETIME NOT NULL,
    [DSV_ERROR_ID] INT NOT NULL
);

CREATE TABLE [DSVKEYS] (
    [DSVKEY] VARCHAR(64) NOT NULL -- PK,
    [DSVKNAME] VARCHAR(64) NOT NULL
);

CREATE TABLE [dsxlate] (
    [XLID] INT NOT NULL -- PK,
    [FdID] VARCHAR(50) NOT NULL,
    [DlrID] INT NULL,
    [DlrName] VARCHAR(255) NOT NULL,
    [PubID] INT NOT NULL,
    [EdID] INT NOT NULL
);

CREATE TABLE [dsxlatefeedid] (
    [XLFEEDID] INT NOT NULL -- PK,
    [PubID] INT NOT NULL,
    [EdID] INT NOT NULL,
    [FeedID] VARCHAR(50) NOT NULL,
    [NewDlrID] VARCHAR(50) NULL
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
    [Duration] VARCHAR(32) NULL,
    [DurationFormatted] VARCHAR(32) NULL,
    [Created] VARCHAR(32) NULL,
    [Vehicle] VARCHAR(64) NULL
);

CREATE TABLE [dtproperties] (
    [id] INT NOT NULL -- PK,
    [objectid] INT NULL,
    [property] VARCHAR(64) NOT NULL -- PK,
    [value] VARCHAR(255) NULL,
    [uvalue] NVARCHAR(255) NULL,
    [lvalue] IMAGE NULL,
    [version] INT NOT NULL
);

CREATE TABLE [DupeFFID] (
    [ffid] INT NOT NULL,
    [ffid_kill] INT NOT NULL,
    [ffidmaster] INT NULL,
    [ffidmaster_kill] INT NULL
);

CREATE TABLE [dx_AccountRep] (
    [dlrid] INT NOT NULL,
    [pubid] INT NOT NULL,
    [aso_id] INT NULL,
    [acc_id_rep] INT NULL
);

CREATE TABLE [dx_HashLog] (
    [adid] INT NULL,
    [Hash1] VARBINARY(8000) NULL,
    [Hash2] VARBINARY(8000) NULL,
    [Hash3] VARBINARY(8000) NULL,
    [LastUpload] DATETIME NOT NULL
);

CREATE TABLE [dx_images] (
    [adid] INT NULL,
    [imgurl] VARCHAR(512) NULL,
    [IMGSORT] TINYINT NOT NULL
);

CREATE TABLE [dx_ListingCount_Log] (
    [lsm_action] CHAR(3) NOT NULL,
    [dx_count] INT NULL,
    [QueryDate] DATETIME NOT NULL
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
    [dlrurl] VARCHAR(512) NULL,
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

CREATE TABLE [dx_listings_list2] (
    [lsm_id] INT NOT NULL,
    [lst_id] INT NULL,
    [HP] BIT NULL
);

CREATE TABLE [DX_LiveSyncManager] (
    [lsm_ID] INT NOT NULL -- PK,
    [ADID] INT NOT NULL,
    [ADNUM] INT NULL,
    [lsm_Table] VARCHAR(25) NULL,
    [lsm_Action] CHAR(3) NOT NULL,
    [lsm_Timestamp] TIMESTAMP NOT NULL,
    [lsm_DateTime] DATETIME NOT NULL
);

CREATE TABLE [DX_MemberSyncManager] (
    [msm_ID] INT NOT NULL -- PK,
    [MEMID] INT NOT NULL,
    [MEMUID] VARCHAR(64) NOT NULL,
    [msm_Action] VARCHAR(3) NOT NULL,
    [msm_Timestamp] TIMESTAMP NOT NULL,
    [msm_updated] VARCHAR(150) NULL
);

CREATE TABLE [dx_NoChangeAds] (
    [adid] INT NOT NULL
);

CREATE TABLE [DX1Ads] (
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(32) NULL,
    [dlrState] VARCHAR(2) NULL,
    [dlrZIP] VARCHAR(5) NULL,
    [dlrPhone] VARCHAR(12) NULL,
    [dlrEmail] VARCHAR(64) NULL,
    [adid] VARCHAR(64) NULL,
    [admvdp] VARCHAR(256) NULL,
    [adVIN] VARCHAR(17) NULL,
    [adStock] VARCHAR(50) NULL,
    [adcat] VARCHAR(128) NULL,
    [adtype] VARCHAR(128) NULL,
    [adcattype] VARCHAR(128) NULL,
    [adyear] VARCHAR(64) NULL,
    [adMake] VARCHAR(128) NULL,
    [adModel] VARCHAR(128) NULL,
    [adcondition] VARCHAR(128) NULL,
    [adexteriorcolor] VARCHAR(128) NULL,
    [adprice] VARCHAR(64) NULL,
    [admiles] VARCHAR(64) NULL,
    [addescription] VARCHAR(8000) NULL,
    [adimages] VARCHAR(MAX) NULL
);

CREATE TABLE [DX1Photos] (
    [adid] VARCHAR(64) NULL,
    [imgurl] VARCHAR(512) NULL,
    [imgsort] VARCHAR(512) NULL
);

CREATE TABLE [eBiz2Endeavor] (
    [xfrID] INT NOT NULL -- PK,
    [adVIN] VARCHAR(32) NOT NULL,
    [adnum] INT NOT NULL,
    [adphoto] VARCHAR(512) NULL,
    [adsent] SMALLDATETIME NOT NULL,
    [adverified] BIT NOT NULL
);

CREATE TABLE [eBizAutosData] (
    [DLRID] VARCHAR(12) NULL,
    [DLRNAME] VARCHAR(64) NULL,
    [DLRADDR] VARCHAR(64) NULL,
    [DLRCITY] VARCHAR(64) NULL,
    [DLRSTATE] VARCHAR(2) NULL,
    [DLRZIP] VARCHAR(5) NULL,
    [DLRPHONE] VARCHAR(16) NULL,
    [ADID] VARCHAR(8) NULL,
    [ADVIN] VARCHAR(32) NULL,
    [ADNEW] VARCHAR(8) NULL,
    [ADSTOCKNO] VARCHAR(30) NULL,
    [ADYEAR] VARCHAR(4) NULL,
    [ADMAKE] VARCHAR(64) NULL,
    [ADMODEL] VARCHAR(64) NULL,
    [ADVEHTYPE] VARCHAR(32) NULL,
    [ADDOORS] VARCHAR(2) NULL,
    [ADSUBMODEL] VARCHAR(96) NULL,
    [ADEXTCOLOR] VARCHAR(128) NULL,
    [ADINTCOLOR] VARCHAR(128) NULL,
    [ADINTSURFACE] VARCHAR(32) NULL,
    [ADENGINE] VARCHAR(64) NULL,
    [ADFUEL] VARCHAR(16) NULL,
    [ADDRIVETRAIN] VARCHAR(32) NULL,
    [ADTRANSMISSION] VARCHAR(32) NULL,
    [ADMILEAGE] INT NULL,
    [ADPRICE] MONEY NULL,
    [ADIMAGES] VARCHAR(2) NULL,
    [ADOPTIONS] VARCHAR(MAX) NULL,
    [ADESCRIPTION] VARCHAR(MAX) NULL,
    [ADPHOTOURLS] VARCHAR(8000) NULL,
    [ADDATEIN] SMALLDATETIME NULL,
    [DLREMAIL] VARCHAR(64) NULL,
    [DLRURL] VARCHAR(64) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [eBizAutosNewDealers] (
    [EBANID] INT NOT NULL,
    [FdID] VARCHAR(50) NOT NULL,
    [DlrID] INT NULL,
    [DlrName] VARCHAR(255) NOT NULL,
    [PubID] INT NOT NULL,
    [EdID] INT NOT NULL
);

CREATE TABLE [ECarList_Temp] (
    [AggId] VARCHAR(MAX) NULL,
    [Dlrid] VARCHAR(MAX) NULL,
    [adVIN] VARCHAR(MAX) NULL,
    [adstock] VARCHAR(MAX) NULL,
    [admiles] VARCHAR(MAX) NULL,
    [adyear] VARCHAR(MAX) NULL,
    [admake] VARCHAR(MAX) NULL,
    [admodel] VARCHAR(MAX) NULL,
    [adtrim] VARCHAR(MAX) NULL,
    [adcat] VARCHAR(MAX) NULL,
    [adtransmission] VARCHAR(MAX) NULL,
    [adengine] VARCHAR(MAX) NULL,
    [adintcolor] VARCHAR(MAX) NULL,
    [adextcolor] VARCHAR(MAX) NULL,
    [adintcolor_generic] VARCHAR(MAX) NULL,
    [adextcolor_generic] VARCHAR(MAX) NULL,
    [price] VARCHAR(MAX) NULL,
    [adprice] VARCHAR(MAX) NULL,
    [addealerprice] VARCHAR(MAX) NULL,
    [admodelcode] VARCHAR(MAX) NULL,
    [adextcolorcode] VARCHAR(MAX) NULL,
    [adintcolorcode] VARCHAR(MAX) NULL,
    [adcertified] VARCHAR(MAX) NULL,
    [adcondition] VARCHAR(MAX) NULL,
    [adstartdate] VARCHAR(MAX) NULL,
    [adcomment] TEXT NULL,
    [adimageURLs] TEXT NULL,
    [adoptions] TEXT NULL,
    [adtext] TEXT NULL,
    [adoptioncodes] VARCHAR(MAX) NULL,
    [admpgcity] VARCHAR(MAX) NULL,
    [admpghighway] VARCHAR(MAX) NULL,
    [addoors] VARCHAR(MAX) NULL,
    [addrivetrain] VARCHAR(MAX) NULL,
    [adcabtype] VARCHAR(MAX) NULL,
    [adcustomprice] VARCHAR(MAX) NULL
);

CREATE TABLE [ECarlistData] (
    [AggId] VARCHAR(MAX) NULL,
    [Dlrid] VARCHAR(MAX) NULL,
    [adVIN] VARCHAR(MAX) NULL,
    [adstock] VARCHAR(MAX) NULL,
    [admiles] VARCHAR(MAX) NULL,
    [adyear] VARCHAR(MAX) NULL,
    [admake] VARCHAR(MAX) NULL,
    [admodel] VARCHAR(MAX) NULL,
    [adtrim] VARCHAR(MAX) NULL,
    [adcat] VARCHAR(MAX) NULL,
    [adtransmission] VARCHAR(MAX) NULL,
    [adengine] VARCHAR(MAX) NULL,
    [adintcolor] VARCHAR(MAX) NULL,
    [adextcolor] VARCHAR(MAX) NULL,
    [adintcolor_generic] VARCHAR(MAX) NULL,
    [adextcolor_generic] VARCHAR(MAX) NULL,
    [price] VARCHAR(MAX) NULL,
    [adprice] VARCHAR(MAX) NULL,
    [addealerprice] VARCHAR(MAX) NULL,
    [admodelcode] VARCHAR(MAX) NULL,
    [adextcolorcode] VARCHAR(MAX) NULL,
    [adintcolorcode] VARCHAR(MAX) NULL,
    [adcertified] VARCHAR(MAX) NULL,
    [adcondition] VARCHAR(MAX) NULL,
    [adstartdate] VARCHAR(MAX) NULL,
    [adcomment] VARCHAR(MAX) NULL,
    [adimageURLs] VARCHAR(MAX) NULL,
    [adoptions] VARCHAR(MAX) NULL,
    [adtext] VARCHAR(MAX) NULL,
    [adoptioncodes] VARCHAR(MAX) NULL,
    [admpgcity] VARCHAR(MAX) NULL,
    [admpghighway] VARCHAR(MAX) NULL,
    [addoors] VARCHAR(MAX) NULL,
    [addrivetrain] VARCHAR(MAX) NULL,
    [adcabtype] VARCHAR(MAX) NULL,
    [adcustomprice] VARCHAR(MAX) NULL,
    [adVDPURL] VARCHAR(256) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [ECarListDealers] (
    [dlrID] VARCHAR(32) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddr] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(32) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZip] VARCHAR(16) NULL,
    [dlrEmail] VARCHAR(64) NULL,
    [dlrURL] VARCHAR(64) NULL,
    [dlrPhone] VARCHAR(64) NULL
);

CREATE TABLE [EDesignAds] (
    [matchid] VARCHAR(32) NULL,
    [dlrid] VARCHAR(32) NULL,
    [adCondition] VARCHAR(32) NULL,
    [adVIN] VARCHAR(32) NULL,
    [adStock] VARCHAR(32) NULL,
    [adCategory] VARCHAR(64) NULL,
    [adType] VARCHAR(32) NULL,
    [adYear] VARCHAR(4) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(128) NULL,
    [adSubModel] VARCHAR(64) NULL,
    [adDoors] VARCHAR(10) NULL,
    [adExtColor] VARCHAR(128) NULL,
    [adIntColor] VARCHAR(128) NULL,
    [adEngine] VARCHAR(64) NULL,
    [adFuel] VARCHAR(64) NULL,
    [adTransmission] VARCHAR(100) NULL,
    [adCylinders] VARCHAR(10) NULL,
    [adDriveType] VARCHAR(64) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adRetail] VARCHAR(16) NULL,
    [adWholesale] VARCHAR(16) NULL,
    [adCertified] VARCHAR(24) NULL,
    [adSpecial] VARCHAR(6500) NULL,
    [adNotes] VARCHAR(6500) NULL,
    [adOptions] VARCHAR(6500) NULL,
    [adPics] VARCHAR(6500) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [EDesignDealers] (
    [matchid] VARCHAR(32) NULL,
    [dlrid] VARCHAR(32) NULL,
    [dlrName] VARCHAR(32) NULL,
    [contactname] VARCHAR(64) NULL,
    [dlrPhone] VARCHAR(18) NULL,
    [dlrAddr] VARCHAR(128) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrCountry] VARCHAR(64) NULL,
    [dlrZip] VARCHAR(10) NULL,
    [dlrFax] VARCHAR(24) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrURL] VARCHAR(512) NULL
);

CREATE TABLE [EDITIONS] (
    [EDID] INT NOT NULL -- PK,
    [EDNAME] VARCHAR(64) NOT NULL,
    [EDINITIALS] VARCHAR(16) NOT NULL,
    [EDPUBDATE] SMALLDATETIME NOT NULL,
    [EDTYPE] BIT NOT NULL,
    [EDEMAIL] VARCHAR(92) NOT NULL,
    [EDPHONE] VARCHAR(16) NOT NULL,
    [EDFAX] VARCHAR(16) NOT NULL,
    [EDADDRESS] VARCHAR(32) NOT NULL,
    [EDCITY] VARCHAR(32) NOT NULL,
    [EDSTATE] VARCHAR(2) NOT NULL,
    [EDZIP] VARCHAR(5) NOT NULL,
    [ENDEDID] INT NOT NULL,
    [EDSHOW] BIT NULL,
    [EDRATE] SMALLMONEY NULL,
    [EdGroup] VARCHAR(32) NULL,
    [EdInternal] BIT NULL
);

CREATE TABLE [eLeadsAds] (
    [dlrID] VARCHAR(12) NULL,
    [adID] VARCHAR(25) NULL,
    [adStock] VARCHAR(16) NULL,
    [adVIN] VARCHAR(25) NULL,
    [adSection] VARCHAR(23) NULL,
    [adSCLID] VARCHAR(9) NULL,
    [adCertified] VARCHAR(9) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(32) NULL,
    [adSubModel] VARCHAR(128) NULL,
    [adYear] VARCHAR(12) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adColor] VARCHAR(32) NULL,
    [adCondition] VARCHAR(16) NULL,
    [adHeadline] VARCHAR(16) NULL,
    [adText] VARCHAR(4096) NULL,
    [adPic1] VARCHAR(4096) NULL,
    [adPrice] VARCHAR(16) NULL,
    [adPhone] VARCHAR(16) NULL,
    [adPics] VARCHAR(MAX) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [eLeadsDealers] (
    [dlrID] VARCHAR(12) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(43) NULL,
    [dlrState] VARCHAR(8) NULL,
    [dlrZIP] VARCHAR(8) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrURL] VARCHAR(128) NULL,
    [dlrPhone] VARCHAR(16) NULL
);

CREATE TABLE [ELMAH_Error] (
    [ErrorId] UNIQUEIDENTIFIER NOT NULL -- PK,
    [Application] NVARCHAR(60) NOT NULL,
    [Host] NVARCHAR(50) NOT NULL,
    [Type] NVARCHAR(100) NOT NULL,
    [Source] NVARCHAR(60) NOT NULL,
    [Message] NVARCHAR(500) NOT NULL,
    [User] NVARCHAR(50) NOT NULL,
    [StatusCode] INT NOT NULL,
    [TimeUtc] DATETIME NOT NULL,
    [Sequence] INT NOT NULL,
    [AllXml] NTEXT NOT NULL
);

CREATE TABLE [EndeavorBilling201901] (
    [CUSTOMER] VARCHAR(12) NOT NULL,
    [reseller] VARCHAR(128) NULL,
    [aso_name] VARCHAR(128) NULL,
    [aso_id] INT NOT NULL,
    [cusid] INT NULL,
    [acc_ID] INT NULL,
    [company] VARCHAR(64) NULL,
    [FEED] VARCHAR(8) NOT NULL,
    [Aggregator] VARCHAR(64) NULL,
    [feed_Cost] MONEY NULL,
    [feed_LastUpload] DATE NULL,
    [RecentAdCount] INT NULL,
    [LOCAL] VARCHAR(9) NOT NULL,
    [rcl_Cost] MONEY NULL,
    [rcl_EndDate] DATE NULL,
    [DISPLAY] VARCHAR(11) NOT NULL,
    [rcd_Cost] MONEY NULL,
    [rcd_EndDate] DATE NULL,
    [ENDEAVOR] VARCHAR(12) NOT NULL,
    [end_Sum_Cost] MONEY NULL,
    [end_Max_Cost] MONEY NULL,
    [end_RepName] VARCHAR(128) NULL,
    [end_LastUpload] DATE NULL,
    [billingtype] VARCHAR(10) NULL,
    [ebilladdress] VARCHAR(64) NULL,
    [aging_cost] MONEY NULL,
    [aging_payments] MONEY NULL,
    [aging_curr] MONEY NULL,
    [aging_curr_date] VARCHAR(16) NULL,
    [aging_30] MONEY NULL,
    [aging_30_date] VARCHAR(16) NULL,
    [aging_60] MONEY NULL,
    [aging_60_date] VARCHAR(16) NULL,
    [aging_90plus] MONEY NULL,
    [FED] MONEY NULL,
    [LCL] MONEY NULL,
    [BAN] MONEY NULL,
    [PKG] MONEY NULL,
    [TOTALENDEAVOR] MONEY NULL,
    [TOTALRATCHET] MONEY NULL,
    [r] VARCHAR(128) NOT NULL,
    [a] VARCHAR(128) NULL,
    [c] VARCHAR(64) NULL,
    [i] INT NULL,
    [LiveDate] DATE NULL
);

CREATE TABLE [EndeavorInternetSales] (
    [pubDB] VARCHAR(32) NULL,
    [Office] VARCHAR(64) NULL,
    [InternetAssigned] INT NULL,
    [cusid] INT NULL,
    [adnum] INT NULL,
    [slscost] MONEY NULL,
    [slsrundate] DATETIME NULL,
    [slsdesc] VARCHAR(255) NULL,
    [edid] INT NULL,
    [edname] VARCHAR(32) NULL,
    [slsNumber] INT NULL,
    [Features] VARCHAR(512) NULL,
    [OnlineEnlargedPhoto] BIT NULL,
    [InstapostTrackingOnly] BIT NULL,
    [EnhancedListing] BIT NULL,
    [InternetPhotoOnly] BIT NULL,
    [HomePageShowcases] BIT NULL,
    [PreferredListing] BIT NULL,
    [AllCustomerSales] MONEY NULL,
    [LastCharge] DATETIME NULL
);

CREATE TABLE [EndMap] (
    [pubid] INT NOT NULL,
    [edphotoonly] BIT NOT NULL,
    [clsnumber] INT NOT NULL,
    [clsname] VARCHAR(255) NOT NULL,
    [clscode] VARCHAR(12) NULL
);

CREATE TABLE [EndNoParts] (
    [pubname] VARCHAR(64) NOT NULL,
    [dlrid] INT NULL,
    [dlrname] VARCHAR(64) NOT NULL,
    [sCat] VARCHAR(64) NULL,
    [eCat] VARCHAR(64) NULL,
    [adcount] INT NULL,
    [feedstatus] VARCHAR(8) NOT NULL
);

CREATE TABLE [EndWithParts] (
    [pubname] VARCHAR(64) NOT NULL,
    [dlrid] INT NULL,
    [dlrname] VARCHAR(64) NOT NULL,
    [sCat] VARCHAR(64) NULL,
    [eCat] VARCHAR(64) NULL,
    [adcount] INT NULL,
    [feedstatus] VARCHAR(8) NOT NULL
);

CREATE TABLE [event_capture] (
    [event_id] BIGINT NOT NULL,
    [event_date] DATETIME NULL,
    [app_initials] VARCHAR(3) NULL,
    [app_action] INT NULL,
    [user_ipaddress] VARCHAR(32) NULL,
    [http_user_agent] VARCHAR(256) NULL,
    [is_bot] BIT NULL,
    [acc_id] BIGINT NULL,
    [lst_id] BIGINT NULL,
    [subscription_id] BIGINT NULL,
    [campaign_id] BIGINT NULL,
    [flight_id] BIGINT NULL,
    [external_id] BIGINT NULL,
    [external_name] VARCHAR(128) NULL,
    [extra_type] INT NULL,
    [extra_info] TEXT NULL
);

CREATE TABLE [Exclude_ffidMaster] (
    [ffidmaster] VARCHAR(8) NULL,
    [Acc_Name] VARCHAR(64) NULL
);

CREATE TABLE [ExcludeCrawl] (
    [acc_id] VARCHAR(15) NULL,
    [acc_company] VARCHAR(128) NULL
);

CREATE TABLE [ExistingListings] (
    [adid] INT NULL
);

CREATE TABLE [FEATURES] (
    [FEAID] INT NOT NULL -- PK,
    [PUBID] INT NOT NULL -- PK,
    [DESCRIPTION] VARCHAR(255) NOT NULL,
    [RATE] SMALLMONEY NOT NULL,
    [FACTIVE] BIT NOT NULL,
    [FSORT] SMALLINT NOT NULL
);

CREATE TABLE [Feed2LiveLog] (
    [TimeStamp] DATETIME NOT NULL,
    [EdTag] VARCHAR(100) NOT NULL
);

CREATE TABLE [feedadaddress] (
    [fauid] INT NOT NULL -- PK,
    [pubid] INT NOT NULL,
    [adnum] INT NOT NULL,
    [adaddress] VARCHAR(64) NOT NULL,
    [adzip] VARCHAR(5) NOT NULL
);

CREATE TABLE [FeedAdCount] (
    [facid] INT NOT NULL -- PK,
    [facpubid] INT NULL,
    [facaggregator] VARCHAR(128) NULL,
    [facdlrid] INT NULL,
    [facdlrname] VARCHAR(64) NULL,
    [facadcount] INT NULL,
    [facactivedate] DATETIME NULL,
    [fdUID] INT NULL
);

CREATE TABLE [FEEDADS] (
    [faUID] INT NOT NULL -- PK,
    [fdPUBID] INT NOT NULL,
    [fdEDID] INT NOT NULL,
    [faVIN] VARCHAR(64) NOT NULL,
    [faADNUM] INT NOT NULL,
    [faCAT] VARCHAR(255) NOT NULL,
    [faSCLID] INT NOT NULL,
    [faTYPE] TINYINT NOT NULL,
    [faSPECIAL] TINYINT NOT NULL,
    [faTOP] TINYINT NOT NULL,
    [faTEXT] VARCHAR(4096) NOT NULL,
    [faHTML] TEXT NULL,
    [faHEADLINE] VARCHAR(128) NULL,
    [faBOXED] BIT NOT NULL,
    [faYEAR] SMALLINT NULL,
    [faMAKE] VARCHAR(32) NULL,
    [faMODEL] VARCHAR(128) NULL,
    [faSUBMODEL] VARCHAR(32) NULL,
    [faPRICE] MONEY NULL,
    [faPHONE] VARCHAR(16) NULL,
    [faPIC1] VARCHAR(512) NULL,
    [faPIC2] VARCHAR(512) NULL,
    [faPIC3] VARCHAR(512) NULL,
    [faPIC4] VARCHAR(512) NULL,
    [faPICS] VARCHAR(8000) NOT NULL,
    [faCOST] MONEY NOT NULL,
    [faCREATED] SMALLDATETIME NOT NULL,
    [faLASTUPLOAD] SMALLDATETIME NOT NULL,
    [faACTIVE] BIT NOT NULL,
    [adID] INT NULL,
    [faSTOCK] VARCHAR(32) NULL,
    [fdUID] INT NULL,
    [faVDP] VARCHAR(256) NULL,
    [faRadius] INT NULL
);

CREATE TABLE [feedads_transition] (
    [faUID] INT NOT NULL,
    [fdPUBID] INT NOT NULL,
    [fdEDID] INT NOT NULL,
    [faVIN] VARCHAR(64) NOT NULL,
    [faADNUM] INT NOT NULL,
    [faCAT] VARCHAR(255) NOT NULL,
    [faSCLID] INT NOT NULL,
    [faTYPE] TINYINT NOT NULL,
    [faSPECIAL] TINYINT NOT NULL,
    [faTOP] TINYINT NOT NULL,
    [faTEXT] VARCHAR(4096) NOT NULL,
    [faHTML] TEXT NULL,
    [faHEADLINE] VARCHAR(128) NULL,
    [faBOXED] BIT NOT NULL,
    [faYEAR] SMALLINT NULL,
    [faMAKE] VARCHAR(32) NULL,
    [faMODEL] VARCHAR(128) NULL,
    [faSUBMODEL] VARCHAR(32) NULL,
    [faPRICE] MONEY NULL,
    [faPHONE] VARCHAR(16) NULL,
    [faPIC1] VARCHAR(512) NULL,
    [faPIC2] VARCHAR(512) NULL,
    [faPIC3] VARCHAR(512) NULL,
    [faPIC4] VARCHAR(512) NULL,
    [faPICS] VARCHAR(8000) NOT NULL,
    [faCOST] MONEY NOT NULL,
    [faCREATED] SMALLDATETIME NOT NULL,
    [faLASTUPLOAD] SMALLDATETIME NOT NULL,
    [faACTIVE] BIT NOT NULL,
    [adID] INT NULL,
    [faSTOCK] VARCHAR(32) NULL,
    [fdUID] INT NULL,
    [faVDP] VARCHAR(256) NULL,
    [faRadius] INT NULL
);

CREATE TABLE [FeedAdsBCP] (
    [fauid] INT NOT NULL
);

CREATE TABLE [FeedCategoryTranslations] (
    [FeedID] INT NOT NULL,
    [PubID] INT NOT NULL,
    [sclid] INT NOT NULL,
    [clsid] INT NULL,
    [sclname] VARCHAR(64) NOT NULL,
    [feedCatID] INT NOT NULL,
    [feedCatName] VARCHAR(64) NOT NULL,
    [sclsearch] TINYINT NULL
);

CREATE TABLE [FeedCheck] (
    [pubid] INT NOT NULL,
    [pubdb] VARCHAR(16) NOT NULL,
    [pubname] VARCHAR(64) NOT NULL,
    [fduid] INT NOT NULL,
    [dlrid] INT NULL,
    [cusid] INT NOT NULL,
    [cusname] VARCHAR(64) NOT NULL,
    [cusphone] VARCHAR(16) NOT NULL,
    [edtag] VARCHAR(128) NOT NULL,
    [adcount] INT NULL,
    [currcount] FLOAT NULL,
    [lastupload] SMALLDATETIME NULL,
    [ffprice] MONEY NULL,
    [acc_name_rep] VARCHAR(128) NULL
);

CREATE TABLE [FEEDDEALERS] (
    [fdUID] INT NOT NULL -- PK,
    [fdID] VARCHAR(32) NOT NULL,
    [fdPUBID] INT NOT NULL,
    [fdEDID] INT NOT NULL,
    [fdCUSID] INT NOT NULL,
    [fdNAME] VARCHAR(64) NOT NULL,
    [fdADDR] VARCHAR(64) NOT NULL,
    [fdCITY] VARCHAR(32) NULL,
    [fdSTATE] VARCHAR(2) NOT NULL,
    [fdZIP] VARCHAR(10) NOT NULL,
    [fdPHONE] VARCHAR(16) NOT NULL,
    [fdALTPHONE] VARCHAR(16) NOT NULL,
    [fdFAX] VARCHAR(16) NOT NULL,
    [fdEMAIL_STRING] VARCHAR(96) NOT NULL,
    [fdEMAIL_XML] VARCHAR(96) NOT NULL,
    [fdURL] VARCHAR(512) NULL,
    [fdPROFILE] TINYINT NOT NULL,
    [fdIMG1] VARCHAR(512) NULL,
    [fdIMG2] VARCHAR(512) NULL,
    [fdIMG3] VARCHAR(512) NULL,
    [fdIMG4] VARCHAR(512) NULL,
    [fdSHOWOTHER] BIT NOT NULL,
    [fdCAO] BIT NOT NULL,
    [dlrID] INT NULL,
    [fdUIDMaster] INT NULL
);

CREATE TABLE [FeedDealers_NotUsed_20161118] (
    [fdUID] INT NOT NULL,
    [fdID] VARCHAR(32) NOT NULL,
    [fdPUBID] INT NOT NULL,
    [fdEDID] INT NOT NULL,
    [fdCUSID] INT NOT NULL,
    [fdNAME] VARCHAR(64) NOT NULL,
    [fdADDR] VARCHAR(64) NOT NULL,
    [fdCITY] VARCHAR(32) NULL,
    [fdSTATE] VARCHAR(2) NOT NULL,
    [fdZIP] VARCHAR(10) NOT NULL,
    [fdPHONE] VARCHAR(16) NOT NULL,
    [fdALTPHONE] VARCHAR(16) NOT NULL,
    [fdFAX] VARCHAR(16) NOT NULL,
    [fdEMAIL_STRING] VARCHAR(96) NOT NULL,
    [fdEMAIL_XML] VARCHAR(96) NOT NULL,
    [fdURL] VARCHAR(512) NULL,
    [fdPROFILE] TINYINT NOT NULL,
    [fdIMG1] VARCHAR(512) NULL,
    [fdIMG2] VARCHAR(512) NULL,
    [fdIMG3] VARCHAR(512) NULL,
    [fdIMG4] VARCHAR(512) NULL,
    [fdSHOWOTHER] BIT NOT NULL,
    [fdCAO] BIT NOT NULL,
    [dlrID] INT NULL,
    [fdUIDMaster] INT NULL
);

CREATE TABLE [feeddealers_transition] (
    [fdUID] INT NOT NULL,
    [fdID] VARCHAR(32) NOT NULL,
    [fdPUBID] INT NOT NULL,
    [fdEDID] INT NOT NULL,
    [fdCUSID] INT NOT NULL,
    [fdNAME] VARCHAR(64) NOT NULL,
    [fdADDR] VARCHAR(64) NOT NULL,
    [fdCITY] VARCHAR(32) NULL,
    [fdSTATE] VARCHAR(2) NOT NULL,
    [fdZIP] VARCHAR(10) NOT NULL,
    [fdPHONE] VARCHAR(16) NOT NULL,
    [fdALTPHONE] VARCHAR(16) NOT NULL,
    [fdFAX] VARCHAR(16) NOT NULL,
    [fdEMAIL_STRING] VARCHAR(96) NOT NULL,
    [fdEMAIL_XML] VARCHAR(96) NOT NULL,
    [fdURL] VARCHAR(512) NULL,
    [fdPROFILE] TINYINT NOT NULL,
    [fdIMG1] VARCHAR(512) NULL,
    [fdIMG2] VARCHAR(512) NULL,
    [fdIMG3] VARCHAR(512) NULL,
    [fdIMG4] VARCHAR(512) NULL,
    [fdSHOWOTHER] BIT NOT NULL,
    [fdCAO] BIT NOT NULL,
    [dlrID] INT NULL,
    [fdUIDMaster] INT NULL
);

CREATE TABLE [FeedDealersDeactivates] (
    [fduid] INT NOT NULL -- PK,
    [deactived] DATETIME NOT NULL,
    [deactivedBy] VARCHAR(32) NOT NULL
);

CREATE TABLE [FEEDDESTINATION] (
    [FEEDDESTID] INT NOT NULL -- PK,
    [DESTID] INT NOT NULL,
    [FDNAME] VARCHAR(255) NOT NULL,
    [FDUID] INT NOT NULL,
    [INSERTDATE] DATETIME NOT NULL,
    [FOREIGNKEY] VARCHAR(64) NULL,
    [ACTIVE] BIT NOT NULL,
    [DEALERRANGE] INT NULL,
    [DEALERBID] MONEY NULL,
    [DEALERBUDGET] MONEY NULL,
    [MODIFYDATE] DATETIME NOT NULL,
    [DEALERCAP] INT NULL
);

CREATE TABLE [FeedDestination_AggChange_Log] (
    [fduid_old] INT NULL,
    [fduid_new] INT NULL,
    [CheckFirst] BIT NULL
);

CREATE TABLE [feeddestinations_removed] (
    [fduid] INT NULL,
    [ffdatelive] DATETIME NULL,
    [ffprice] MONEY NULL,
    [acc_id] INT NULL,
    [Automotive] INT NOT NULL,
    [Dealix] INT NOT NULL,
    [Vast] INT NOT NULL,
    [VastBudget] MONEY NOT NULL,
    [VastBid] MONEY NOT NULL,
    [CarDomain] INT NOT NULL,
    [CarsDirect] INT NOT NULL,
    [Web2CarzPaid] INT NOT NULL,
    [wc_servicenumber] VARCHAR(50) NULL
);

CREATE TABLE [FeedDupeCheck] (
    [dlrID] INT NULL,
    [fdNAME] VARCHAR(64) NOT NULL,
    [fdADDR] VARCHAR(64) NOT NULL,
    [fdCITY] VARCHAR(32) NULL,
    [fdSTATE] VARCHAR(2) NOT NULL,
    [fdZIP] VARCHAR(10) NOT NULL,
    [fdPHONE] VARCHAR(16) NOT NULL,
    [fdALTPHONE] VARCHAR(16) NOT NULL,
    [fdFAX] VARCHAR(16) NOT NULL,
    [fdEMAIL_STRING] VARCHAR(96) NOT NULL,
    [fdEMAIL_XML] VARCHAR(96) NOT NULL,
    [fdURL] VARCHAR(512) NULL,
    [fdCUSID] INT NOT NULL,
    [fdPUBID] INT NOT NULL,
    [fdPROFILE] TINYINT NOT NULL,
    [fdIMG1] VARCHAR(512) NULL,
    [fdIMG2] VARCHAR(512) NULL,
    [fdIMG3] VARCHAR(512) NULL,
    [fdIMG4] VARCHAR(512) NULL,
    [fdSHOWOTHER] BIT NOT NULL,
    [fdCAO] BIT NOT NULL,
    [fmactive] BIT NULL,
    [lastupload] SMALLDATETIME NULL
);

CREATE TABLE [FEEDEXTRAS] (
    [faUID] INT NOT NULL -- PK,
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
    [fxGenericIntColor] VARCHAR(32) NULL,
    [fxInvoice] VARCHAR(24) NULL
);

CREATE TABLE [FeedFTP] (
    [ftp_Path] VARCHAR(256) NOT NULL
);

CREATE TABLE [FEEDLOGS] (
    [flID] INT NOT NULL -- PK,
    [flEDID] INT NOT NULL,
    [ADCOUNT] INT NOT NULL,
    [DLRCOUNT] INT NOT NULL,
    [FEATCOUNT] INT NOT NULL,
    [IMGCOUNT] INT NOT NULL,
    [flDATE] DATETIME NOT NULL,
    [flFILE] VARCHAR(256) NOT NULL
);

CREATE TABLE [FeedManager] (
    [fmID] INT NOT NULL -- PK,
    [PUBID] INT NOT NULL,
    [EDID] INT NOT NULL,
    [FDID] VARCHAR(32) NOT NULL,
    [FDNAME] VARCHAR(512) NOT NULL,
    [FDPHONE] VARCHAR(32) NOT NULL,
    [EDTAG] VARCHAR(64) NOT NULL,
    [fmActive] BIT NOT NULL,
    [fmCreated] SMALLDATETIME NOT NULL,
    [fmKeepNew] BIT NOT NULL,
    [fmCusID] INT NULL,
    [fmDeactivateOn] DATE NULL
);

CREATE TABLE [feedmanagerlog] (
    [fmlID] INT NOT NULL -- PK,
    [fmID] INT NOT NULL,
    [fmlChange] VARCHAR(1024) NOT NULL,
    [fmlUser] VARCHAR(64) NOT NULL,
    [fmlDate] SMALLDATETIME NOT NULL,
    [fmCusID] INT NULL,
    [fmDeactivateOn] DATE NULL
);

CREATE TABLE [FeedMultipleVIN] (
    [fmvID] INT NOT NULL,
    [fmvVIN] VARCHAR(32) NOT NULL,
    [fmvVINcount] INT NOT NULL,
    [fmvfname] VARCHAR(32) NOT NULL,
    [fmvtimestamp] DATETIME NOT NULL
);

CREATE TABLE [Feeds] (
    [FeedID] INT NOT NULL -- PK,
    [FeedName] VARCHAR(36) NOT NULL,
    [FeedRef] VARCHAR(128) NULL,
    [FeedUser] VARCHAR(32) NULL,
    [FeedPass] VARCHAR(32) NULL,
    [FeedFTP] VARCHAR(64) NULL,
    [FeedFile] VARCHAR(32) NULL,
    [FeedActive] BIT NULL
);

CREATE TABLE [FEEDTRANSLATE] (
    [ftUID] INT NOT NULL -- PK,
    [fdPUBID] INT NOT NULL,
    [fdEDID] INT NOT NULL,
    [ftSTRING] VARCHAR(255) NOT NULL,
    [SCLID] INT NOT NULL,
    [ftDEFAULT] BIT NOT NULL
);

CREATE TABLE [FEEDUPDATE] (
    [FUUID] INT NOT NULL -- PK,
    [fdUID] INT NULL,
    [fuCUSID] INT NULL,
    [fuNAME] VARCHAR(64) NULL,
    [fuADDR] VARCHAR(64) NULL,
    [fuCITY] VARCHAR(32) NULL,
    [fuSTATE] VARCHAR(2) NULL,
    [fuZIP] VARCHAR(10) NULL,
    [fuPHONE] VARCHAR(16) NULL,
    [fuALTPHONE] VARCHAR(16) NULL,
    [fuFAX] VARCHAR(16) NULL,
    [fuEMAIL_STRING] VARCHAR(96) NULL,
    [fuEMAIL_XML] VARCHAR(96) NULL,
    [fuURL] VARCHAR(512) NULL,
    [fuPROFILE] TINYINT NULL,
    [fuIMG1] VARCHAR(512) NULL,
    [fuIMG2] VARCHAR(512) NULL,
    [fuIMG3] VARCHAR(512) NULL,
    [fuIMG4] VARCHAR(512) NULL,
    [fuSHOWOTHER] BIT NULL,
    [fuCAO] BIT NULL,
    [fuAdStart] VARCHAR(256) NULL,
    [fuAdEnd] VARCHAR(256) NULL,
    [fuAllPreferred] BIT NULL,
    [fuAllBoxed] BIT NULL,
    [fuUIDMaster] INT NULL
);

CREATE TABLE [FEEDUPSELLS] (
    [faUID] INT NOT NULL -- PK,
    [isHomePage] BIT NOT NULL,
    [isPreferred] BIT NOT NULL,
    [isEnlarged] BIT NOT NULL
);

CREATE TABLE [FeedXMLDealers] (
    [fxdid] INT NOT NULL -- PK,
    [fxdlrid] VARCHAR(50) NOT NULL,
    [fxdname] VARCHAR(100) NULL,
    [fxdurl] VARCHAR(100) NULL,
    [fxsid] INT NOT NULL,
    [active] BIT NOT NULL
);

CREATE TABLE [FeedXMLSource] (
    [fxsid] INT NOT NULL -- PK,
    [fxsname] VARCHAR(100) NOT NULL,
    [active] BIT NOT NULL
);

CREATE TABLE [FinanceExpressData] (
    [dlrID] VARCHAR(10) NULL,
    [dlrName] VARCHAR(32) NULL,
    [dlrAddress] VARCHAR(32) NULL,
    [dlrCity] VARCHAR(32) NULL,
    [dlrState] VARCHAR(2) NULL,
    [dlrZIP] VARCHAR(5) NULL,
    [dlrEmail] VARCHAR(42) NULL,
    [dlrURL] VARCHAR(32) NULL,
    [dlrPhone] VARCHAR(12) NULL,
    [dlrSting] VARCHAR(6) NULL,
    [adVIN] VARCHAR(18) NULL,
    [adStock] VARCHAR(50) NULL,
    [adVIN1] VARCHAR(18) NULL,
    [adSection] VARCHAR(42) NULL,
    [adMake] VARCHAR(30) NULL,
    [adModel] VARCHAR(40) NULL,
    [adSubModel] VARCHAR(86) NULL,
    [adYear] VARCHAR(4) NULL,
    [adMiles] INT NULL,
    [adHeadline] VARCHAR(3072) NULL,
    [adText] VARCHAR(4096) NULL,
    [adPrice] INT NULL,
    [adPhone] VARCHAR(10) NULL,
    [adPics] VARCHAR(MAX) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [FirstLookData] (
    [dlrID] VARCHAR(64) NULL,
    [adID] VARCHAR(20) NULL,
    [adBodyType] VARCHAR(64) NULL,
    [adMake] VARCHAR(64) NULL,
    [adModel] VARCHAR(64) NULL,
    [adSubModel] VARCHAR(128) NULL,
    [adYear] VARCHAR(4) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adHeadline] VARCHAR(6500) NULL,
    [adText] VARCHAR(7500) NULL,
    [adPrice] VARCHAR(10) NULL,
    [adPhone] VARCHAR(32) NULL,
    [adPics] VARCHAR(MAX) NULL,
    [adCondition] VARCHAR(16) NULL,
    [adComments] VARCHAR(6500) NULL,
    [adOptions] VARCHAR(6500) NULL,
    [adExtColor] VARCHAR(128) NULL,
    [adStock] VARCHAR(20) NULL,
    [adVIN] VARCHAR(20) NULL,
    [adSection] VARCHAR(64) NULL,
    [adCertified] VARCHAR(12) NULL,
    [adStyle] VARCHAR(100) NULL,
    [adGenericExteriorColor] VARCHAR(64) NULL,
    [adInteriorColor] VARCHAR(64) NULL,
    [adMSRP] VARCHAR(32) NULL,
    [adModelCode] VARCHAR(32) NULL,
    [adDateInStock] VARCHAR(32) NULL,
    [adTransmission] VARCHAR(32) NULL,
    [adDriveType] VARCHAR(32) NULL,
    [adEngineCylinders] VARCHAR(12) NULL,
    [adEngineDescription] VARCHAR(64) NULL,
    [adEngineDisplacement] VARCHAR(20) NULL,
    [adFuelType] VARCHAR(12) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(64) NULL,
    [dlrZip] VARCHAR(64) NULL,
    [adinvoice] VARCHAR(64) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [FirstLookDealers] (
    [dlrID] VARCHAR(64) NULL,
    [ContactFName] VARCHAR(20) NULL,
    [ContactLName] VARCHAR(64) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(16) NULL,
    [dlrCountry] VARCHAR(16) NULL,
    [dlrZip] VARCHAR(16) NULL,
    [dlrPhone] VARCHAR(16) NULL,
    [dlrEmail] VARCHAR(64) NULL,
    [dlrURL] VARCHAR(128) NULL
);

CREATE TABLE [FixDupeVIN] (
    [VIN] VARCHAR(20) NOT NULL -- PK,
    [PUBID] INT NOT NULL -- PK,
    [FDID] VARCHAR(20) NOT NULL -- PK,
    [EDID] INT NOT NULL -- PK,
    [Old] INT NOT NULL -- PK,
    [New] INT NOT NULL -- PK
);

CREATE TABLE [FormDealerLocation] (
    [ffID] INT NOT NULL -- PK,
    [PubID] INT NOT NULL -- PK,
    [Code] INT NOT NULL -- PK
);

CREATE TABLE [FormFeedPhoneTracking] (
    [pht_ID] INT NOT NULL -- PK,
    [src_ID] INT NOT NULL,
    [cusID] INT NOT NULL,
    [pht_CampaignName] VARCHAR(128) NOT NULL,
    [pht_800Number] VARCHAR(16) NOT NULL,
    [pht_RedirectTo] VARCHAR(16) NOT NULL,
    [pht_ccEmail] VARCHAR(128) NOT NULL,
    [pht_Option1] BIT NOT NULL,
    [pht_Option2] BIT NOT NULL,
    [pht_Option3] INT NOT NULL,
    [pht_Option4] INT NOT NULL,
    [pht_Option5] INT NOT NULL
);

CREATE TABLE [FormInventory] (
    [fiID] INT NOT NULL -- PK,
    [fiName] VARCHAR(32) NOT NULL,
    [fiValue] INT NOT NULL,
    [fiSort] INT NOT NULL,
    [fiActive] BIT NOT NULL
);

CREATE TABLE [FormPublications] (
    [ffID] INT NOT NULL -- PK,
    [PubID] INT NOT NULL -- PK,
    [CusID] INT NULL
);

CREATE TABLE [FormStatus] (
    [fsID] INT NOT NULL -- PK,
    [fsName] VARCHAR(32) NULL,
    [fsSort] INT NULL,
    [fsActive] BIT NULL
);

CREATE TABLE [FormTypes] (
    [ftID] INT NOT NULL -- PK,
    [ftName] VARCHAR(32) NOT NULL,
    [ftSort] INT NOT NULL,
    [ftActive] BIT NOT NULL
);

CREATE TABLE [FraudUsers] (
    [FraudUID] VARCHAR(64) NOT NULL -- PK,
    [FraudEntered] SMALLDATETIME NOT NULL
);

CREATE TABLE [FrazerData] (
    [dlrID] VARCHAR(32) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddr] VARCHAR(128) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZip] VARCHAR(10) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrURL] VARCHAR(128) NULL,
    [dlrPhone] VARCHAR(18) NULL,
    [adID] VARCHAR(17) NULL,
    [adStock] VARCHAR(17) NULL,
    [adVin] VARCHAR(32) NULL,
    [adSection] VARCHAR(32) NULL,
    [adType] VARCHAR(32) NULL,
    [adCertified] VARCHAR(32) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(32) NULL,
    [adSubModel] VARCHAR(64) NULL,
    [adYear] VARCHAR(4) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adColor] VARCHAR(64) NULL,
    [adCondition] VARCHAR(32) NULL,
    [adHeadline] VARCHAR(64) NULL,
    [adText] VARCHAR(4000) NULL,
    [adCustomText] VARCHAR(2000) NULL,
    [adPrice] VARCHAR(64) NULL,
    [adPhone] VARCHAR(64) NULL,
    [adPics] VARCHAR(MAX) NULL,
    [adStyle] VARCHAR(64) NULL,
    [adExteriorColor] VARCHAR(64) NULL,
    [adInteriorColor] VARCHAR(64) NULL,
    [adInvoice] VARCHAR(64) NULL,
    [adMSRP] VARCHAR(64) NULL,
    [adMiscPrice1] VARCHAR(64) NULL,
    [adMiscPrice2] VARCHAR(64) NULL,
    [adModelCode] VARCHAR(64) NULL,
    [adDateInStock] VARCHAR(64) NULL,
    [adWheelbase] VARCHAR(64) NULL,
    [adDoors] VARCHAR(64) NULL,
    [adTransmission] VARCHAR(64) NULL,
    [adEngineDescription] VARCHAR(64) NULL,
    [adEngineCylinders] VARCHAR(64) NULL,
    [adEngineDisplacement] VARCHAR(64) NULL,
    [adFuelType] VARCHAR(64) NULL,
    [adEPACity] VARCHAR(64) NULL,
    [adEPAHighway] VARCHAR(64) NULL,
    [adVDP] VARCHAR(MAX) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [FreeClass] (
    [PubID] INT NOT NULL,
    [clsNumber] INT NOT NULL
);

CREATE TABLE [FridaySystemsAds] (
    [dlrid] VARCHAR(32) NULL,
    [dlrName] VARCHAR(32) NULL,
    [adVIN] VARCHAR(32) NULL,
    [adStock] VARCHAR(32) NULL,
    [adCondition] VARCHAR(32) NULL,
    [adYear] VARCHAR(4) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(32) NULL,
    [adSubModel] VARCHAR(64) NULL,
    [adSection] VARCHAR(32) NULL,
    [adExtColor] VARCHAR(64) NULL,
    [adIntColor] VARCHAR(64) NULL,
    [adPrice] VARCHAR(10) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adTransmission] VARCHAR(255) NULL,
    [adEngine] VARCHAR(255) NULL,
    [adFuelType] VARCHAR(255) NULL,
    [adDescription] VARCHAR(6500) NULL,
    [adOptions] VARCHAR(6500) NULL,
    [adCylinders] VARCHAR(100) NULL,
    [adLiters] VARCHAR(100) NULL,
    [adDoors] VARCHAR(24) NULL,
    [adPics] VARCHAR(6500) NULL,
    [adVideos] VARCHAR(6500) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [fsnAds] (
    [dlrID] VARCHAR(32) NULL,
    [adID] VARCHAR(32) NULL,
    [adStock] VARCHAR(512) NULL,
    [adVIN] VARCHAR(64) NULL,
    [adSection] VARCHAR(255) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(128) NULL,
    [adSubModel] VARCHAR(128) NULL,
    [adYear] VARCHAR(64) NULL,
    [adMiles] VARCHAR(50) NULL,
    [adColor] VARCHAR(255) NULL,
    [adPic1] VARCHAR(1024) NULL,
    [adText] VARCHAR(MAX) NULL,
    [adPrice] VARCHAR(32) NULL,
    [adPhone] VARCHAR(16) NULL,
    [adPics] VARCHAR(MAX) NULL,
    [adType] VARCHAR(128) NULL,
    [adCertified] VARCHAR(32) NULL,
    [adInteriorColor] VARCHAR(64) NULL,
    [adMSRP] VARCHAR(12) NULL,
    [adInvoice] VARCHAR(12) NULL,
    [adModelCode] VARCHAR(255) NULL,
    [adDriveType] VARCHAR(32) NULL,
    [adTransmission] VARCHAR(100) NULL,
    [adEngineDescription] VARCHAR(102) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [FusionZoneAds] (
    [dlrid] VARCHAR(32) NULL,
    [dlrCRM] VARCHAR(16) NULL,
    [vin] VARCHAR(24) NULL,
    [stocknumber] VARCHAR(64) NULL,
    [condition] VARCHAR(12) NULL,
    [adyear] VARCHAR(4) NULL,
    [make] VARCHAR(64) NULL,
    [model] VARCHAR(64) NULL,
    [bodytype] VARCHAR(128) NULL,
    [trim] VARCHAR(64) NULL,
    [bookvalue] VARCHAR(16) NULL,
    [carfaxhistory] VARCHAR(128) NULL,
    [carfaxowner] VARCHAR(64) NULL,
    [certified] VARCHAR(12) NULL,
    [comment1] VARCHAR(4000) NULL,
    [comment2] VARCHAR(64) NULL,
    [comment3] VARCHAR(64) NULL,
    [comment4] VARCHAR(64) NULL,
    [comment5] VARCHAR(512) NULL,
    [datamodifieddate] VARCHAR(32) NULL,
    [datecreated] VARCHAR(32) NULL,
    [dateinstock] VARCHAR(32) NULL,
    [daysinstock] VARCHAR(4) NULL,
    [dlraddress] VARCHAR(128) NULL,
    [dlrcity] VARCHAR(64) NULL,
    [dlrcontact] VARCHAR(64) NULL,
    [dlremail] VARCHAR(64) NULL,
    [dlrname] VARCHAR(64) NULL,
    [dlrphone] VARCHAR(16) NULL,
    [dlrstate] VARCHAR(2) NULL,
    [dlrurl] VARCHAR(128) NULL,
    [dlrzip] VARCHAR(5) NULL,
    [descriptionx] VARCHAR(8000) NULL,
    [options] VARCHAR(8000) NULL,
    [doors] VARCHAR(16) NULL,
    [drivetrain] VARCHAR(32) NULL,
    [engaspiration] VARCHAR(32) NULL,
    [engblock] VARCHAR(4) NULL,
    [engcubicin] VARCHAR(12) NULL,
    [cylinders] VARCHAR(64) NULL,
    [engdescription] VARCHAR(64) NULL,
    [displacement] VARCHAR(64) NULL,
    [citymi] VARCHAR(4) NULL,
    [classtype] VARCHAR(64) NULL,
    [hwymi] VARCHAR(4) NULL,
    [evoxcolor1] VARCHAR(64) NULL,
    [evoxcolor2] VARCHAR(64) NULL,
    [evoxcolor3] VARCHAR(64) NULL,
    [evoxsend] VARCHAR(16) NULL,
    [evoxvif] VARCHAR(16) NULL,
    [extcolor] VARCHAR(128) NULL,
    [extcolorcode] VARCHAR(24) NULL,
    [extcolorgeneric] VARCHAR(128) NULL,
    [extcolorhex] VARCHAR(12) NULL,
    [extdescription] VARCHAR(8000) NULL,
    [friendlystype] VARCHAR(64) NULL,
    [fueltype] VARCHAR(24) NULL,
    [imagecount] VARCHAR(4) NULL,
    [images] VARCHAR(MAX) NULL,
    [imgmodifieddate] VARCHAR(64) NULL,
    [intcolorcode] VARCHAR(24) NULL,
    [intcolorgeneric] VARCHAR(24) NULL,
    [intcolor] VARCHAR(128) NULL,
    [intcolorhex] VARCHAR(12) NULL,
    [interior] VARCHAR(8000) NULL,
    [internetprice] VARCHAR(12) NULL,
    [intupholstry] VARCHAR(24) NULL,
    [invoice] VARCHAR(12) NULL,
    [iolmedialink] VARCHAR(5000) NULL,
    [iolvideolink] VARCHAR(500) NULL,
    [ishomepagespecial] VARCHAR(4) NULL,
    [issspecial] VARCHAR(4) NULL,
    [marketclass] VARCHAR(64) NULL,
    [miles] VARCHAR(12) NULL,
    [miscprice1] VARCHAR(12) NULL,
    [miscprice2] VARCHAR(12) NULL,
    [miscprice3] VARCHAR(12) NULL,
    [modelnumber] VARCHAR(24) NULL,
    [msrp] VARCHAR(12) NULL,
    [optionalequipment] VARCHAR(8000) NULL,
    [optionalequipmentshort] VARCHAR(3000) NULL,
    [addescription] VARCHAR(8000) NULL,
    [passenger] VARCHAR(4) NULL,
    [safetyequipment] VARCHAR(5000) NULL,
    [sellingprice] VARCHAR(12) NULL,
    [soldflag] VARCHAR(4) NULL,
    [specialprice] VARCHAR(12) NULL,
    [specialsdisclaimer] VARCHAR(450) NULL,
    [specialenddate] VARCHAR(24) NULL,
    [specialmontlypayment] VARCHAR(10) NULL,
    [specialsstartdate] VARCHAR(24) NULL,
    [standardbody] VARCHAR(100) NULL,
    [standardequipment] VARCHAR(MAX) NULL,
    [standardmake] VARCHAR(24) NULL,
    [standardmodel] VARCHAR(40) NULL,
    [standardstyle] VARCHAR(64) NULL,
    [standardtrim] VARCHAR(64) NULL,
    [standardyear] VARCHAR(4) NULL,
    [stockimage] VARCHAR(20) NULL,
    [styledescription] VARCHAR(64) NULL,
    [techspecs] VARCHAR(8000) NULL,
    [transmission] VARCHAR(64) NULL,
    [transdescription] VARCHAR(64) NULL,
    [transspeed] VARCHAR(4) NULL,
    [vehicletitle] VARCHAR(256) NULL,
    [wheelbase] VARCHAR(8) NULL,
    [testvideo] VARCHAR(20) NULL,
    [pkgdescriptions] VARCHAR(64) NULL,
    [acode] VARCHAR(64) NULL,
    [Chrome1] VARCHAR(4) NULL,
    [Chrome2] VARCHAR(64) NULL,
    [Chrome3] VARCHAR(4) NULL,
    [Chrome4] VARCHAR(4) NULL,
    [Chrome5] VARCHAR(4) NULL,
    [Chrome6] VARCHAR(4) NULL,
    [Chrome7] VARCHAR(128) NULL,
    [Chrome8] VARCHAR(4) NULL,
    [Chrome9] VARCHAR(4) NULL,
    [Chrome10] VARCHAR(4) NULL,
    [Chrome11] VARCHAR(128) NULL,
    [country] VARCHAR(12) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [FVLOG] (
    [fvlid] INT NOT NULL -- PK,
    [adid] INT NOT NULL,
    [fvlday] SMALLDATETIME NOT NULL,
    [fvlhour] INT NOT NULL,
    [fvlclick] BIT NOT NULL,
    [fvlpubid] INT NOT NULL
);

CREATE TABLE [FVTOTALS] (
    [fvtid] INT NOT NULL -- PK,
    [adid] INT NOT NULL,
    [fvtotal] INT NOT NULL,
    [fvtday] SMALLDATETIME NOT NULL,
    [fvthour] INT NOT NULL,
    [fvtclick] INT NOT NULL,
    [fvtpubid] INT NOT NULL
);

CREATE TABLE [Geebo_Inbound] (
    [adID] INT NULL,
    [adVIN] VARCHAR(32) NULL,
    [adSection] VARCHAR(64) NULL,
    [adMake] VARCHAR(128) NULL,
    [adModel] VARCHAR(128) NULL,
    [adYear] VARCHAR(14) NULL,
    [adHeadline] VARCHAR(256) NULL,
    [adText] VARCHAR(MAX) NULL,
    [adPrice] MONEY NULL,
    [adPhone] VARCHAR(32) NULL,
    [adPics] VARCHAR(4096) NULL,
    [dlrName] VARCHAR(256) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZIP] VARCHAR(5) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrPhone] VARCHAR(32) NULL
);

CREATE TABLE [Gensystemads] (
    [dlrID] VARCHAR(10) NULL,
    [adID] VARCHAR(20) NULL,
    [adStock] VARCHAR(24) NULL,
    [adVIN] VARCHAR(24) NULL,
    [adSection] VARCHAR(24) NULL,
    [adMake] VARCHAR(64) NULL,
    [adModel] VARCHAR(64) NULL,
    [adSubModel] VARCHAR(64) NULL,
    [adYear] VARCHAR(10) NULL,
    [adMiles] VARCHAR(10) NULL,
    [adColor] VARCHAR(64) NULL,
    [adCondition] VARCHAR(10) NULL,
    [adHeadline] VARCHAR(6400) NULL,
    [adText] VARCHAR(6400) NULL,
    [adCustomText] VARCHAR(6400) NULL,
    [adPrice] VARCHAR(24) NULL,
    [adPhone] VARCHAR(20) NULL,
    [adPic1t] VARCHAR(512) NULL,
    [adPic1] VARCHAR(512) NULL,
    [adPic2] VARCHAR(512) NULL,
    [adPic3] VARCHAR(512) NULL,
    [adPic4] VARCHAR(512) NULL,
    [adPics] VARCHAR(6400) NULL,
    [adThumbs] VARCHAR(6400) NULL
);

CREATE TABLE [Gensystemadstemp] (
    [dlrID] VARCHAR(10) NULL,
    [adID] VARCHAR(20) NULL,
    [adStock] VARCHAR(24) NULL,
    [adVIN] VARCHAR(24) NULL,
    [adSection] VARCHAR(24) NULL,
    [adMake] VARCHAR(64) NULL,
    [adModel] VARCHAR(64) NULL,
    [adSubModel] VARCHAR(64) NULL,
    [adYear] VARCHAR(10) NULL,
    [adMiles] VARCHAR(10) NULL,
    [adColor] VARCHAR(64) NULL,
    [adCondition] VARCHAR(10) NULL,
    [adHeadline] VARCHAR(6400) NULL,
    [adText] VARCHAR(6400) NULL,
    [adCustomText] VARCHAR(6400) NULL,
    [adPrice] VARCHAR(24) NULL,
    [adPhone] VARCHAR(20) NULL,
    [adPic1t] VARCHAR(512) NULL,
    [adPic1] VARCHAR(512) NULL,
    [adPic2] VARCHAR(512) NULL,
    [adPic3] VARCHAR(512) NULL,
    [adPic4] VARCHAR(512) NULL,
    [adPics] VARCHAR(6400) NULL,
    [adThumbs] VARCHAR(6400) NULL
);

CREATE TABLE [GensystemDealers] (
    [dlrid] VARCHAR(50) NOT NULL,
    [dlrname] VARCHAR(100) NOT NULL,
    [dlraddress] VARCHAR(50) NOT NULL,
    [dlrcity] VARCHAR(50) NOT NULL,
    [dlrstate] VARCHAR(50) NOT NULL,
    [dlrzip] VARCHAR(10) NOT NULL,
    [dlremail] VARCHAR(50) NULL,
    [dlrphone] VARCHAR(15) NOT NULL,
    [dlrurl] VARCHAR(50) NOT NULL,
    [active] BIT NOT NULL,
    [created] SMALLDATETIME NOT NULL
);

CREATE TABLE [GEOCC] (
    [ci] INT NOT NULL -- PK,
    [cc] CHAR(2) NOT NULL,
    [cn] VARCHAR(50) NOT NULL
);

CREATE TABLE [GEOIP] (
    [ipstart] BIGINT NOT NULL -- PK,
    [ipend] BIGINT NOT NULL -- PK,
    [ci] INT NOT NULL
);

CREATE TABLE [GlobalScopeAds] (
    [dlrid] VARCHAR(16) NULL,
    [stocknumber] VARCHAR(64) NULL,
    [year] VARCHAR(4) NULL,
    [make] VARCHAR(64) NULL,
    [model] VARCHAR(64) NULL,
    [trim] VARCHAR(64) NULL,
    [vin] VARCHAR(24) NULL,
    [miles] VARCHAR(12) NULL,
    [price] VARCHAR(10) NULL,
    [extcolor] VARCHAR(64) NULL,
    [intcolor] VARCHAR(64) NULL,
    [transmission] VARCHAR(64) NULL,
    [images] VARCHAR(5000) NULL,
    [description] VARCHAR(4000) NULL,
    [bodytype] VARCHAR(128) NULL,
    [enginetype] VARCHAR(128) NULL,
    [drivetype] VARCHAR(128) NULL,
    [fueltype] VARCHAR(128) NULL,
    [id] INT NOT NULL,
    [catid] INT NULL
);

CREATE TABLE [GlobalScopecustomers] (
    [dlrID] VARCHAR(32) NULL,
    [dlrName] VARCHAR(32) NULL,
    [dlrAddr] VARCHAR(128) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZip] VARCHAR(10) NULL,
    [dlrURL] VARCHAR(512) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrPhone] VARCHAR(18) NULL
);

CREATE TABLE [GoAuto] (
    [dlrname] VARCHAR(48) NULL,
    [advin] VARCHAR(32) NULL,
    [adstock] VARCHAR(16) NULL,
    [adnew] VARCHAR(8) NULL,
    [adyear] VARCHAR(4) NULL,
    [admake] VARCHAR(32) NULL,
    [admodel] VARCHAR(64) NULL,
    [admodelnumber] VARCHAR(4) NULL,
    [adbody] VARCHAR(4) NULL,
    [adtransmission] VARCHAR(16) NULL,
    [adtrim] VARCHAR(64) NULL,
    [addoors] VARCHAR(2) NULL,
    [admiles] VARCHAR(12) NULL,
    [adcylinders] VARCHAR(8) NULL,
    [addisplacement] VARCHAR(64) NULL,
    [addrivetrain] VARCHAR(32) NULL,
    [adextcolor] VARCHAR(32) NULL,
    [adintcolor] VARCHAR(32) NULL,
    [adinvoice] VARCHAR(12) NULL,
    [admsrp] VARCHAR(12) NULL,
    [adbookvalue] VARCHAR(12) NULL,
    [adsellingprice] VARCHAR(12) NULL,
    [adstockdate] VARCHAR(12) NULL,
    [adcertified] VARCHAR(4) NULL,
    [addescription] VARCHAR(512) NULL,
    [adtext] VARCHAR(1024) NULL,
    [adpics] VARCHAR(1024) NULL
);

CREATE TABLE [GoAutoAds] (
    [dlrName] VARCHAR(34) NULL,
    [dlrAddress] VARCHAR(32) NULL,
    [dlrCity] VARCHAR(32) NULL,
    [dlrState] VARCHAR(8) NULL,
    [dlrZip] VARCHAR(10) NULL,
    [dlrPhone] VARCHAR(16) NULL,
    [dlrSource] VARCHAR(16) NULL,
    [adCreated] VARCHAR(16) NULL,
    [adVIN] VARCHAR(32) NULL,
    [adUSED] VARCHAR(8) NULL,
    [adCertified] VARCHAR(8) NULL,
    [dlrID] VARCHAR(8) NULL,
    [adStock] VARCHAR(32) NULL,
    [adMileage] VARCHAR(16) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(128) NULL,
    [adYear] VARCHAR(4) NULL,
    [sclid] VARCHAR(64) NULL,
    [adsubmodel] VARCHAR(64) NULL,
    [adEngine] VARCHAR(64) NULL,
    [adTransmission] VARCHAR(32) NULL,
    [adInterior] VARCHAR(255) NULL,
    [adExterior] VARCHAR(255) NULL,
    [dlrComment] VARCHAR(128) NULL,
    [adComment] VARCHAR(4000) NULL,
    [adPrice] VARCHAR(16) NULL,
    [adCost] VARCHAR(16) NULL,
    [adText] VARCHAR(MAX) NULL,
    [adPics] VARCHAR(8000) NULL,
    [adDriveTrain] VARCHAR(100) NULL,
    [adImageModDate] VARCHAR(24) NULL,
    [adVideoPlayer] VARCHAR(200) NULL,
    [adYouTubeVideo] VARCHAR(200) NULL
);

CREATE TABLE [GoogleBase] (
    [publication_name] VARCHAR(64) NULL,
    [year] VARCHAR(32) NULL,
    [make] VARCHAR(32) NULL,
    [model] VARCHAR(32) NULL,
    [title] VARCHAR(64) NULL,
    [link] VARCHAR(256) NULL,
    [image_link] VARCHAR(512) NULL,
    [price] VARCHAR(12) NULL,
    [publish_date] VARCHAR(16) NULL,
    [expiration_date] VARCHAR(16) NULL,
    [description] VARCHAR(1024) NULL,
    [Location] VARCHAR(10) NULL,
    [Quantity] VARCHAR(16) NULL,
    [vehicle_type] VARCHAR(32) NULL,
    [color] VARCHAR(16) NULL,
    [condition] VARCHAR(16) NULL,
    [mileage] VARCHAR(16) NULL,
    [vin] VARCHAR(32) NULL
);

CREATE TABLE [GroverAds] (
    [dlrID] VARCHAR(12) NULL,
    [adID] VARCHAR(25) NULL,
    [adStock] VARCHAR(16) NULL,
    [adVIN] VARCHAR(25) NULL,
    [adSection] VARCHAR(23) NULL,
    [adSCLID] VARCHAR(9) NULL,
    [adCertified] VARCHAR(9) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(32) NULL,
    [adSubModel] VARCHAR(128) NULL,
    [adYear] VARCHAR(12) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adColor] VARCHAR(32) NULL,
    [adCondition] VARCHAR(16) NULL,
    [adHeadline] VARCHAR(32) NULL,
    [adText] VARCHAR(4096) NULL,
    [adCustomText] VARCHAR(4096) NULL,
    [adPrice] VARCHAR(16) NULL,
    [adPhone] VARCHAR(16) NULL,
    [adPics] VARCHAR(MAX) NULL,
    [adPicThumb] VARCHAR(MAX) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [GroverDealers] (
    [dlrID] VARCHAR(128) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(128) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(20) NULL,
    [dlrZIP] VARCHAR(10) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrURL] VARCHAR(512) NULL,
    [dlrPhone] VARCHAR(20) NULL
);

CREATE TABLE [GWMarketingAds] (
    [dlrid] VARCHAR(12) NULL,
    [adStock] VARCHAR(12) NULL,
    [adVIN] VARCHAR(17) NULL,
    [adYear] VARCHAR(4) NULL,
    [adMake] VARCHAR(128) NULL,
    [adModel] VARCHAR(128) NULL,
    [adMiles] VARCHAR(8) NULL,
    [adPrice] VARCHAR(8) NULL,
    [adCondition] VARCHAR(8) NULL,
    [adColor] VARCHAR(64) NULL,
    [adIntColor] VARCHAR(64) NULL,
    [adTrans] VARCHAR(128) NULL,
    [adOptions] VARCHAR(8000) NULL,
    [adComments] VARCHAR(8000) NULL,
    [adPics] VARCHAR(8000) NULL,
    [cat] INT NULL
);

CREATE TABLE [GWMarketingCustomers] (
    [DLRID] VARCHAR(12) NULL,
    [DLRNAME] VARCHAR(64) NULL,
    [DLRADDR] VARCHAR(64) NULL,
    [DLRCITY] VARCHAR(36) NULL,
    [DLRSTATE] VARCHAR(2) NULL,
    [DLRZIP] VARCHAR(5) NULL,
    [DLRPHONE] VARCHAR(36) NULL,
    [DLREMAIL] VARCHAR(128) NULL,
    [DLRURL] VARCHAR(512) NULL
);

CREATE TABLE [HanleesData] (
    [dlrID] VARCHAR(32) NULL,
    [adID] VARCHAR(32) NULL,
    [adStock] VARCHAR(32) NULL,
    [adVin] VARCHAR(32) NULL,
    [adSection] VARCHAR(32) NULL,
    [isUsed] VARCHAR(12) NULL,
    [isCertified] VARCHAR(12) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(32) NULL,
    [adSubModel] VARCHAR(32) NULL,
    [adYear] VARCHAR(4) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adColor] VARCHAR(64) NULL,
    [isUsed2] VARCHAR(12) NULL,
    [adText] VARCHAR(4000) NULL,
    [adPrice] VARCHAR(32) NULL,
    [adPics] VARCHAR(4000) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [HanleesDealers] (
    [dlrID] VARCHAR(32) NULL,
    [dlrName] VARCHAR(32) NULL,
    [dlrAddr] VARCHAR(128) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZip] VARCHAR(10) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrURL] VARCHAR(512) NULL,
    [dlrPhone] VARCHAR(18) NULL
);

CREATE TABLE [HealyBrosAds] (
    [dlrid] VARCHAR(32) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddr] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZip] VARCHAR(24) NULL,
    [dlrPhone] VARCHAR(24) NULL,
    [adNew] VARCHAR(2) NULL,
    [adCertified] VARCHAR(10) NULL,
    [adVIN] VARCHAR(32) NULL,
    [adStock] VARCHAR(24) NULL,
    [adYear] VARCHAR(4) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(32) NULL,
    [adTrim] VARCHAR(64) NULL,
    [eng_cylinders] VARCHAR(24) NULL,
    [eng_displacement] VARCHAR(64) NULL,
    [transmission] VARCHAR(64) NULL,
    [odometer] VARCHAR(12) NULL,
    [adExtColor] VARCHAR(32) NULL,
    [adIntColor] VARCHAR(128) NULL,
    [adBodyStyle] VARCHAR(64) NULL,
    [vehicle_Length] VARCHAR(8) NULL,
    [vehicle_Width] VARCHAR(8) NULL,
    [vehicle_Height] VARCHAR(8) NULL,
    [vehicle_WheelBase] VARCHAR(8) NULL,
    [vehicle_Drivetrain] VARCHAR(8) NULL,
    [vehicle_SeatingCap] VARCHAR(8) NULL,
    [vehicle_FuelCap] VARCHAR(8) NULL,
    [vehicle_CityEPA] VARCHAR(12) NULL,
    [vehicle_HwyEPA] VARCHAR(12) NULL,
    [MSRP] VARCHAR(8) NULL,
    [DealerCost] VARCHAR(12) NULL,
    [BookValue] VARCHAR(12) NULL,
    [DealerPrice] VARCHAR(12) NULL,
    [InternetPrice] VARCHAR(12) NULL,
    [InventoryDate] VARCHAR(12) NULL,
    [adComments] VARCHAR(5000) NULL,
    [adEquipment] VARCHAR(MAX) NULL,
    [adPics] VARCHAR(8000) NULL,
    [id] INT NOT NULL,
    [adsection] VARCHAR(64) NULL
);

CREATE TABLE [HNPaidData] (
    [dlrid] VARCHAR(100) NULL,
    [adCondition] VARCHAR(24) NULL,
    [adStock] VARCHAR(64) NULL,
    [adVIN] VARCHAR(24) NULL,
    [adYear] VARCHAR(24) NULL,
    [adMake] VARCHAR(64) NULL,
    [adModel] VARCHAR(64) NULL,
    [adBody] VARCHAR(64) NULL,
    [adTrim] VARCHAR(MAX) NULL,
    [adModelNumber] VARCHAR(24) NULL,
    [adDoors] VARCHAR(12) NULL,
    [adExteriorColor] VARCHAR(100) NULL,
    [adInteriorColor] VARCHAR(100) NULL,
    [adEngineCylinders] VARCHAR(24) NULL,
    [adEngineDisplacement] VARCHAR(MAX) NULL,
    [adTransmission] VARCHAR(MAX) NULL,
    [adMiles] VARCHAR(12) NULL,
    [adSellingPrice] VARCHAR(12) NULL,
    [adMSRP] VARCHAR(12) NULL,
    [adBookValue] VARCHAR(12) NULL,
    [adInvoice] VARCHAR(12) NULL,
    [adCertified] VARCHAR(12) NULL,
    [adDateInStock] VARCHAR(12) NULL,
    [adDescription] VARCHAR(MAX) NULL,
    [adOptions] VARCHAR(MAX) NULL,
    [adCategorizedOptions] VARCHAR(MAX) NULL,
    [DlrAddress] VARCHAR(MAX) NULL,
    [DlrCity] VARCHAR(64) NULL,
    [DlrState] VARCHAR(12) NULL,
    [DlrZip] VARCHAR(12) NULL,
    [DlrPhone] VARCHAR(16) NULL,
    [DlrFax] VARCHAR(16) NULL,
    [Comment1] VARCHAR(MAX) NULL,
    [Comment2] VARCHAR(MAX) NULL,
    [Comment3] VARCHAR(MAX) NULL,
    [Comment4] VARCHAR(MAX) NULL,
    [adPhotoURL] VARCHAR(MAX) NULL,
    [adStyle] VARCHAR(MAX) NULL,
    [adGenericExteriorColor] VARCHAR(MAX) NULL,
    [adGenericInteriorColor] VARCHAR(MAX) NULL,
    [adEngineBlockType] VARCHAR(36) NULL,
    [adAspirationType] VARCHAR(36) NULL,
    [adEngineDescription] VARCHAR(100) NULL,
    [adTransmissionSpeed] VARCHAR(64) NULL,
    [adTransmissionDescription] VARCHAR(MAX) NULL,
    [adDriveTrain] VARCHAR(36) NULL,
    [adFuelType] VARCHAR(64) NULL,
    [adEPACity] VARCHAR(36) NULL,
    [adEPAHighway] VARCHAR(36) NULL,
    [adWheelbase] VARCHAR(36) NULL,
    [adNADARetail] VARCHAR(36) NULL,
    [adInternetPrice] VARCHAR(36) NULL,
    [adMiscPrice1] VARCHAR(36) NULL,
    [adMiscPrice2] VARCHAR(36) NULL,
    [adMiscPrice3] VARCHAR(36) NULL,
    [adInternetSpecialsFlag] VARCHAR(36) NULL,
    [adInternetSpecialsPrice] VARCHAR(36) NULL,
    [adInternetSpecialsStartDate] VARCHAR(36) NULL,
    [adInternetSpecialsEndDate] VARCHAR(36) NULL,
    [adInternetSpecialsPayment] VARCHAR(36) NULL,
    [adInternetSpecialsDisclaimer] VARCHAR(64) NULL,
    [Comment5] VARCHAR(MAX) NULL,
    [adStandardMake] VARCHAR(36) NULL,
    [adStandardModel] VARCHAR(36) NULL,
    [adStandardModelCode] VARCHAR(36) NULL,
    [adStandardTrim] VARCHAR(36) NULL,
    [adStandardBody] VARCHAR(36) NULL,
    [adStandardYear] VARCHAR(36) NULL,
    [adStandardStyleDescription] VARCHAR(64) NULL,
    [adGenericOptions] VARCHAR(MAX) NULL,
    [adDateCreated] VARCHAR(36) NULL,
    [adDateModified] VARCHAR(36) NULL,
    [adStockPhotoFLag] VARCHAR(36) NULL,
    [adLastImported] VARCHAR(36) NULL,
    [adInventorySource] VARCHAR(100) NULL,
    [adPassengerCapacity] VARCHAR(MAX) NULL,
    [adMarketClassification] VARCHAR(36) NULL,
    [adStyleWithoutTrim] VARCHAR(MAX) NULL,
    [adEngineDisplacementCubicInches] VARCHAR(36) NULL,
    [adSecondaryChromeBodyStyle] VARCHAR(36) NULL,
    [adHomeNetStyleList] VARCHAR(MAX) NULL,
    [adStockPhotoName] VARCHAR(64) NULL,
    [adValidVIN] VARCHAR(36) NULL,
    [adFTPImageNames] VARCHAR(MAX) NULL,
    [adDateImagesModified] VARCHAR(64) NULL,
    [adChromeModelID] VARCHAR(36) NULL,
    [adACodeList] VARCHAR(MAX) NULL
);

CREATE TABLE [HNPaidDealers] (
    [dlrNAME] VARCHAR(128) NULL,
    [dlrID] VARCHAR(200) NULL
);

CREATE TABLE [HomeNetCustomers] (
    [dlrID] VARCHAR(32) NULL,
    [dlrNAME] VARCHAR(128) NULL,
    [dlrPhone] VARCHAR(36) NULL,
    [dlrURL] VARCHAR(128) NULL
);

CREATE TABLE [HomeNetData] (
    [dlrID] VARCHAR(64) NULL,
    [adType] VARCHAR(8) NULL,
    [adStock] VARCHAR(64) NULL,
    [adVIN] VARCHAR(20) NULL,
    [adYear] VARCHAR(6) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(128) NULL,
    [adBody] VARCHAR(64) NULL,
    [adTrim] VARCHAR(128) NULL,
    [adModelNumber] VARCHAR(128) NULL,
    [adDoors] VARCHAR(16) NULL,
    [adExteriorColor] VARCHAR(128) NULL,
    [adInterior] VARCHAR(256) NULL,
    [adCylinders] VARCHAR(24) NULL,
    [adEngine] VARCHAR(64) NULL,
    [adTransmission] VARCHAR(100) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adSellingPrice] VARCHAR(16) NULL,
    [adMSRP] VARCHAR(16) NULL,
    [adBookValue] VARCHAR(16) NULL,
    [adInvoice] VARCHAR(16) NULL,
    [adCertified] VARCHAR(8) NULL,
    [adDateInStock] VARCHAR(32) NULL,
    [adDescription] VARCHAR(MAX) NULL,
    [adOptions] VARCHAR(MAX) NULL,
    [dlrNAME] VARCHAR(128) NULL,
    [dlrPhone] VARCHAR(32) NULL,
    [dlrURL] VARCHAR(128) NULL,
    [adPics] VARCHAR(MAX) NULL,
    [Style_Description] VARCHAR(128) NULL,
    [Exterior_Generic_Color] VARCHAR(12) NULL,
    [Misc_Price_1] VARCHAR(12) NULL,
    [Misc_Price_2] VARCHAR(12) NULL,
    [Drive_Type] VARCHAR(64) NULL,
    [Engine_Description] VARCHAR(128) NULL,
    [fuel_type] VARCHAR(100) NULL,
    [EPA_City] VARCHAR(12) NULL,
    [EPA_Highway] VARCHAR(12) NULL,
    [Wheelbase] VARCHAR(200) NULL,
    [A_Code_List] VARCHAR(1000) NULL,
    [dlraddress] VARCHAR(100) NULL,
    [dlrcity] VARCHAR(100) NULL,
    [dlrstate] VARCHAR(100) NULL,
    [dlrzipcode] VARCHAR(100) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [HomeNetDealers] (
    [HNDID] INT NOT NULL -- PK,
    [FdID] VARCHAR(50) NOT NULL,
    [DlrID] INT NULL,
    [DlrName] VARCHAR(255) NOT NULL,
    [PubID] INT NOT NULL,
    [EdID] INT NOT NULL
);

CREATE TABLE [HousingWords] (
    [hwID] INT NOT NULL -- PK,
    [hwPhrase] VARCHAR(128) NOT NULL
);

CREATE TABLE [IDealerdata] (
    [dlrid] VARCHAR(32) NULL,
    [stock] VARCHAR(32) NULL,
    [adyear] VARCHAR(12) NULL,
    [make] VARCHAR(64) NULL,
    [model] VARCHAR(64) NULL,
    [trim] VARCHAR(64) NULL,
    [vin] VARCHAR(32) NULL,
    [mileage] VARCHAR(12) NULL,
    [iprice] VARCHAR(10) NULL,
    [ecolor] VARCHAR(64) NULL,
    [icolor] VARCHAR(64) NULL,
    [transtype] VARCHAR(64) NULL,
    [images] VARCHAR(5000) NULL,
    [comments] VARCHAR(4000) NULL,
    [certified] VARCHAR(12) NULL,
    [reserved1] VARCHAR(500) NULL,
    [reserved2] VARCHAR(500) NULL,
    [reserved3] VARCHAR(500) NULL
);

CREATE TABLE [IDealerdealers] (
    [dlrID] VARCHAR(32) NULL,
    [dlrName] VARCHAR(32) NULL,
    [dlrAddr] VARCHAR(128) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZip] VARCHAR(10) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrURL] VARCHAR(512) NULL,
    [dlrPhone] VARCHAR(18) NULL,
    [dlrFileName] VARCHAR(128) NULL,
    [active] BIT NOT NULL
);

CREATE TABLE [ImagicLabAds] (
    [dlrid] VARCHAR(10) NULL,
    [adid] VARCHAR(50) NULL,
    [adstock] VARCHAR(50) NULL,
    [advin] VARCHAR(50) NULL,
    [adsection] VARCHAR(50) NULL,
    [admake] VARCHAR(50) NULL,
    [admodel] VARCHAR(50) NULL,
    [adsubmodel] VARCHAR(50) NULL,
    [adyear] VARCHAR(50) NULL,
    [admiles] VARCHAR(50) NULL,
    [adcolor] VARCHAR(256) NULL,
    [adcondition] VARCHAR(50) NULL,
    [adheadline] VARCHAR(2000) NULL,
    [adtext] VARCHAR(5000) NULL,
    [adcustomtext] VARCHAR(5000) NULL,
    [adprice] VARCHAR(50) NULL,
    [adphone] VARCHAR(50) NULL,
    [adpics] VARCHAR(8000) NULL,
    [adthumbs] VARCHAR(8000) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [ImagicLabDealers] (
    [dlrid] VARCHAR(50) NULL,
    [dlrname] VARCHAR(100) NULL,
    [dlraddress] VARCHAR(100) NULL,
    [dlrcity] VARCHAR(50) NULL,
    [dlrstate] VARCHAR(50) NULL,
    [dlrzip] VARCHAR(50) NULL,
    [dlremail] VARCHAR(100) NULL,
    [dlrphone] VARCHAR(50) NULL
);

CREATE TABLE [InstaAddress] (
    [pubid] INT NOT NULL,
    [adnum] INT NOT NULL,
    [adaddress] VARCHAR(64) NOT NULL,
    [adzip] VARCHAR(5) NOT NULL
);

CREATE TABLE [InstaAds] (
    [PUBID] INT NOT NULL,
    [ADNUM] INT NOT NULL,
    [CUSID] INT NOT NULL,
    [EDID] INT NOT NULL,
    [SCLID] INT NOT NULL,
    [ADTYPE] TINYINT NOT NULL,
    [ADSPECIAL] TINYINT NOT NULL,
    [ADTOP] TINYINT NULL,
    [ADTEXT] VARCHAR(4096) NOT NULL,
    [ADHTML] TEXT NULL,
    [ADHEADLINE] VARCHAR(255) NULL,
    [ADBOXED] BIT NULL,
    [ADYEAR] SMALLINT NULL,
    [ADMAKE] VARCHAR(32) NULL,
    [ADMODEL] VARCHAR(128) NULL,
    [ADSUBMODEL] VARCHAR(32) NULL,
    [ADPRICE] MONEY NULL,
    [ADPHONE] VARCHAR(16) NULL,
    [ADPIC1] VARCHAR(512) NULL,
    [ADCOST] MONEY NULL
);

CREATE TABLE [InstaDealers] (
    [PUBID] INT NOT NULL,
    [CUSID] INT NOT NULL,
    [DLRNAME] VARCHAR(64) NULL,
    [DLRADDR] VARCHAR(64) NULL,
    [DLRCITY] VARCHAR(32) NULL,
    [DLRSTATE] VARCHAR(2) NOT NULL,
    [DLRZIP] VARCHAR(10) NULL,
    [DLRPHONE] VARCHAR(16) NOT NULL,
    [DLRALTPHONE] VARCHAR(16) NULL,
    [DLRFAX] VARCHAR(16) NULL,
    [DLREMAIL] VARCHAR(96) NULL,
    [DLRURL] VARCHAR(512) NULL,
    [IMG1] VARCHAR(512) NULL,
    [IMG2] VARCHAR(512) NULL,
    [IMG3] VARCHAR(512) NULL,
    [DLRCAO] BIT NOT NULL
);

CREATE TABLE [InstaFeatures] (
    [wfID] INT NOT NULL,
    [pubID] INT NOT NULL,
    [wftID] INT NOT NULL,
    [wfSourceID] INT NOT NULL,
    [wfSouceFeatureValue] VARCHAR(128) NOT NULL
);

CREATE TABLE [InteractRV_ads] (
    [adID] VARCHAR(22) NULL,
    [adClass] VARCHAR(255) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(128) NULL,
    [adYear] VARCHAR(12) NULL,
    [adPrice] VARCHAR(14) NULL,
    [adSection] VARCHAR(32) NULL,
    [adCondition] VARCHAR(9) NULL,
    [ItemDetailURL] VARCHAR(526) NULL,
    [SleepingCapacity] VARCHAR(10) NULL,
    [notused2] VARCHAR(8) NULL,
    [EngineModel] VARCHAR(100) NULL,
    [FuelType] VARCHAR(14) NULL,
    [rvLength] VARCHAR(10) NULL,
    [WaterCapacity] VARCHAR(11) NULL,
    [notused3] VARCHAR(9) NULL,
    [notused4] VARCHAR(8) NULL,
    [notused5] VARCHAR(8) NULL,
    [notused6] VARCHAR(12) NULL,
    [adMiles] VARCHAR(13) NULL,
    [adStock] VARCHAR(15) NULL,
    [adText] VARCHAR(8000) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrPhone] VARCHAR(20) NULL,
    [dlrCity] VARCHAR(21) NULL,
    [dlrState] VARCHAR(10) NULL,
    [dlrZip] VARCHAR(13) NULL,
    [adpic1] VARCHAR(256) NULL,
    [adpic2] VARCHAR(256) NULL,
    [adpic3] VARCHAR(256) NULL,
    [adpic4] VARCHAR(256) NULL,
    [adpic5] VARCHAR(256) NULL,
    [adpic6] VARCHAR(256) NULL,
    [adpic7] VARCHAR(256) NULL,
    [adpic8] VARCHAR(256) NULL,
    [adpic9] VARCHAR(256) NULL,
    [adpic10] VARCHAR(256) NULL,
    [adpic11] VARCHAR(256) NULL,
    [adpic12] VARCHAR(256) NULL,
    [adpic13] VARCHAR(256) NULL,
    [adpic14] VARCHAR(256) NULL,
    [adpic15] VARCHAR(256) NULL,
    [adpic16] VARCHAR(256) NULL,
    [adpic17] VARCHAR(256) NULL,
    [adpic18] VARCHAR(256) NULL,
    [adpic19] VARCHAR(256) NULL,
    [adpic20] VARCHAR(256) NULL,
    [adpic21] VARCHAR(256) NULL,
    [adpic22] VARCHAR(256) NULL,
    [adpic23] VARCHAR(256) NULL,
    [adpic24] VARCHAR(256) NULL,
    [adpic25] VARCHAR(256) NULL,
    [adpic26] VARCHAR(256) NULL,
    [adpic27] VARCHAR(256) NULL,
    [adpic28] VARCHAR(256) NULL,
    [adpic29] VARCHAR(256) NULL,
    [adpic30] VARCHAR(256) NULL,
    [adpic31] VARCHAR(256) NULL,
    [adpic32] VARCHAR(256) NULL,
    [adpic33] VARCHAR(256) NULL,
    [adpic34] VARCHAR(256) NULL,
    [adpic35] VARCHAR(256) NULL,
    [adpic36] VARCHAR(256) NULL,
    [adpic37] VARCHAR(256) NULL,
    [adpic38] VARCHAR(256) NULL,
    [adpic39] VARCHAR(256) NULL,
    [adpic40] VARCHAR(256) NULL,
    [adpic41] VARCHAR(256) NULL,
    [adpic42] VARCHAR(256) NULL,
    [adpic43] VARCHAR(256) NULL,
    [adpic44] VARCHAR(256) NULL,
    [adpic45] VARCHAR(256) NULL,
    [adpic46] VARCHAR(256) NULL,
    [adpic47] VARCHAR(256) NULL,
    [adpic48] VARCHAR(256) NULL,
    [adpic49] VARCHAR(256) NULL,
    [adpic50] VARCHAR(256) NULL,
    [adpic51] VARCHAR(256) NULL,
    [adpic52] VARCHAR(256) NULL,
    [adpic53] VARCHAR(256) NULL,
    [adpic54] VARCHAR(256) NULL,
    [adpic55] VARCHAR(256) NULL,
    [adpic56] VARCHAR(256) NULL,
    [adpic57] VARCHAR(256) NULL,
    [adpic58] VARCHAR(256) NULL,
    [adpic59] VARCHAR(256) NULL,
    [adpic60] VARCHAR(256) NULL,
    [adpic61] VARCHAR(256) NULL,
    [adpic62] VARCHAR(256) NULL,
    [adpic63] VARCHAR(256) NULL,
    [adpic64] VARCHAR(256) NULL,
    [adpic65] VARCHAR(256) NULL,
    [adpic66] VARCHAR(256) NULL,
    [adpic67] VARCHAR(256) NULL,
    [adpic68] VARCHAR(256) NULL,
    [adpic69] VARCHAR(256) NULL,
    [adpic70] VARCHAR(256) NULL,
    [dlrID] VARCHAR(256) NULL,
    [adpics] VARCHAR(8000) NULL,
    [SlideOuts] VARCHAR(9) NULL,
    [adVIN] VARCHAR(64) NULL,
    [YouTubeUrl] VARCHAR(128) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [InteractRV_customers] (
    [dlrID] VARCHAR(256) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrPhone] VARCHAR(20) NULL,
    [dlrCity] VARCHAR(21) NULL,
    [dlrState] VARCHAR(10) NULL,
    [dlrZip] VARCHAR(13) NULL
);

CREATE TABLE [internetrecon_combine] (
    [office] VARCHAR(8000) NULL,
    [db] NVARCHAR(128) NULL,
    [cusid] INT NOT NULL,
    [cuscompany] VARCHAR(64) NULL,
    [cusphone] VARCHAR(16) NOT NULL,
    [EmpName] VARCHAR(65) NULL,
    [eBillAddress] VARCHAR(64) NULL,
    [BillingType] VARCHAR(10) NOT NULL,
    [sum_slscost] MONEY NULL,
    [max_slscost] MONEY NULL,
    [min_slscost] MONEY NULL,
    [cnt_slsrundate] INT NULL,
    [max_slsrundate] DATETIME NULL,
    [min_slsrundate] DATETIME NULL,
    [aging_cusid] INT NULL,
    [description] VARCHAR(64) NULL,
    [aging_cost] MONEY NULL,
    [aging_payments] MONEY NULL,
    [aging_curr] MONEY NULL,
    [aging_curr_date] VARCHAR(16) NULL,
    [aging_30] MONEY NULL,
    [aging_30_date] VARCHAR(16) NULL,
    [aging_60] MONEY NULL,
    [aging_60_date] VARCHAR(16) NULL,
    [aging_90plus] MONEY NULL
);

CREATE TABLE [InterUsers] (
    [xID] INT NOT NULL -- PK,
    [memEmail] VARCHAR(128) NOT NULL,
    [memPWD] VARCHAR(128) NOT NULL,
    [memName] VARCHAR(128) NOT NULL,
    [memPhone] VARCHAR(128) NOT NULL,
    [memIP] VARCHAR(16) NOT NULL,
    [memEntered] SMALLDATETIME NOT NULL
);

CREATE TABLE [Inventory_counts] (
    [prdname] VARCHAR(24) NULL,
    [inv_count] VARCHAR(24) NULL,
    [prior_day_count] VARCHAR(24) NULL,
    [inv_date] VARCHAR(24) NULL,
    [Count_Diff] VARCHAR(24) NULL,
    [InvID] INT NOT NULL
);

CREATE TABLE [Inventory_Counts_crawler] (
    [cil_id] INT NOT NULL,
    [domain] VARCHAR(256) NOT NULL,
    [inv_count] INT NULL,
    [prior_day_count] INT NULL,
    [count_diff] INT NULL,
    [inv_date] DATE NOT NULL
);

CREATE TABLE [InventoryCC_Ads] (
    [DLRID] VARCHAR(18) NULL,
    [ADID] VARCHAR(20) NULL,
    [ADSTOCK] VARCHAR(36) NULL,
    [ADVIN] VARCHAR(32) NULL,
    [ADSECTION] VARCHAR(64) NULL,
    [ADTYPE] VARCHAR(32) NULL,
    [ADCERTIFIED] VARCHAR(32) NULL,
    [ADMAKE] VARCHAR(64) NULL,
    [ADMODEL] VARCHAR(64) NULL,
    [ADSUBMODEL] VARCHAR(64) NULL,
    [ADYEAR] VARCHAR(8) NULL,
    [ADMILES] VARCHAR(12) NULL,
    [ADEXTCOLOR] VARCHAR(255) NULL,
    [ADCONDITION] VARCHAR(12) NULL,
    [ADHEADLINE] VARCHAR(64) NULL,
    [ADTEXT] VARCHAR(8000) NULL,
    [ADCUSTOMTEXT] VARCHAR(8000) NULL,
    [ADPRICE] VARCHAR(12) NULL,
    [ADPHONE] VARCHAR(36) NULL,
    [ADPICS] VARCHAR(MAX) NULL,
    [ADVDP] VARCHAR(256) NULL,
    [DLRNAME] VARCHAR(64) NULL,
    [DLRADDR] VARCHAR(64) NULL,
    [DLRCITY] VARCHAR(36) NULL,
    [DLRSTATE] VARCHAR(8) NULL,
    [DLRZIP] VARCHAR(128) NULL,
    [DLRURL] VARCHAR(128) NULL,
    [DLRPHONE] VARCHAR(256) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [InventoryCC_Dealers] (
    [DLRID] VARCHAR(12) NULL,
    [DLRNAME] VARCHAR(64) NULL,
    [DLRADDR] VARCHAR(64) NULL,
    [DLRCITY] VARCHAR(36) NULL,
    [DLRSTATE] VARCHAR(8) NULL,
    [DLRZIP] VARCHAR(128) NULL,
    [DLREMAIL] VARCHAR(128) NULL,
    [DLRURL] VARCHAR(128) NULL,
    [DLRPHONE] VARCHAR(256) NULL
);

CREATE TABLE [InventoryCCData] (
    [DLRID] VARCHAR(12) NULL,
    [DLRNAME] VARCHAR(64) NULL,
    [DLRADDR] VARCHAR(64) NULL,
    [DLRCITY] VARCHAR(36) NULL,
    [DLRSTATE] VARCHAR(100) NULL,
    [DLRZIP] VARCHAR(128) NULL,
    [DLRURL] VARCHAR(128) NULL,
    [DLRPHONE] VARCHAR(256) NULL,
    [ADID] VARCHAR(20) NULL,
    [ADSTOCK] VARCHAR(20) NULL,
    [ADVIN] VARCHAR(20) NULL,
    [ADSECTION] VARCHAR(64) NULL,
    [ADTYPE] VARCHAR(16) NULL,
    [ADCERTIFIED] VARCHAR(10) NULL,
    [ADYEAR] VARCHAR(8) NULL,
    [ADMAKE] VARCHAR(32) NULL,
    [ADMODEL] VARCHAR(64) NULL,
    [ADSUBMODEL] VARCHAR(64) NULL,
    [ADSTYLE] VARCHAR(100) NULL,
    [ADMILES] VARCHAR(10) NULL,
    [ADEXTCOLOR] VARCHAR(128) NULL,
    [ADGENEXTCOLOR] VARCHAR(128) NULL,
    [ADINTCOLOR] VARCHAR(128) NULL,
    [ADHEADLINE] VARCHAR(64) NULL,
    [ADTEXT] VARCHAR(8000) NULL,
    [ADCUSTOMTEXT] VARCHAR(8000) NULL,
    [ADPRICE] VARCHAR(10) NULL,
    [ADINVOICE] VARCHAR(10) NULL,
    [ADMSRP] VARCHAR(10) NULL,
    [ADMISCPRICE1] VARCHAR(10) NULL,
    [ADMISCPRICE2] VARCHAR(10) NULL,
    [ADMODELCODE] VARCHAR(100) NULL,
    [ADDATEINSTOCK] VARCHAR(64) NULL,
    [ADWHEELS] VARCHAR(10) NULL,
    [ADDOORS] VARCHAR(10) NULL,
    [ADTRANSMISSION] VARCHAR(64) NULL,
    [ADDRIVETYPE] VARCHAR(64) NULL,
    [ADENGINEDESCRIPTION] VARCHAR(64) NULL,
    [ADENGINECYCLINDERS] VARCHAR(64) NULL,
    [ADENGINEDISPLACEMENT] VARCHAR(64) NULL,
    [ADFUELTYPE] VARCHAR(32) NULL,
    [ADEPACITY] VARCHAR(10) NULL,
    [ADEPAHIGHWAY] VARCHAR(10) NULL,
    [ADPICS] VARCHAR(MAX) NULL,
    [ADVDP] VARCHAR(255) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [InventrueData] (
    [dlrid] VARCHAR(64) NULL,
    [adCondition] VARCHAR(24) NULL,
    [adVehicleID] VARCHAR(12) NULL,
    [adStock] VARCHAR(24) NULL,
    [adVIN] VARCHAR(17) NULL,
    [adYear] VARCHAR(MAX) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(128) NULL,
    [adBody] VARCHAR(32) NULL,
    [adTrim] VARCHAR(128) NULL,
    [adDoors] VARCHAR(MAX) NULL,
    [adExteriorColor] VARCHAR(64) NULL,
    [adExt_Color_Generic] VARCHAR(16) NULL,
    [adInt_Color_Generic] VARCHAR(16) NULL,
    [adEngineCylinders] VARCHAR(16) NULL,
    [adEngine_Description] VARCHAR(100) NULL,
    [adMiles] VARCHAR(12) NULL,
    [adSellingPrice] VARCHAR(MAX) NULL,
    [adDescription] VARCHAR(8000) NULL,
    [adOptions] VARCHAR(8000) NULL,
    [adTransmission_Speed] VARCHAR(24) NULL,
    [adTransmission_Description] VARCHAR(MAX) NULL,
    [adDrivetrain] VARCHAR(64) NULL,
    [adPics] VARCHAR(8000) NULL,
    [adEPA_City] VARCHAR(12) NULL,
    [adEPA_Highway] VARCHAR(MAX) NULL,
    [adVideo_Link] VARCHAR(255) NULL,
    [adVDPURL] VARCHAR(255) NULL,
    [adnumber_of_axles] VARCHAR(12) NULL,
    [adlength] VARCHAR(12) NULL,
    [adwidth] VARCHAR(12) NULL,
    [adheight] VARCHAR(12) NULL,
    [adweight] VARCHAR(12) NULL,
    [adtrailer_pull_type] VARCHAR(64) NULL,
    [adtrailer_construction] VARCHAR(64) NULL,
    [adtrailer_living_quarters] VARCHAR(32) NULL,
    [adtrailer_ramps] VARCHAR(32) NULL,
    [adhorse_trailer_stalls] VARCHAR(32) NULL,
    [adhorse_trailer_configuration] VARCHAR(32) NULL,
    [adhorse_trailer_midtack] VARCHAR(32) NULL,
    [adsleeping_capacity] VARCHAR(12) NULL,
    [adwater_capacity] VARCHAR(MAX) NULL,
    [adleveling_jacks] VARCHAR(12) NULL,
    [adengine_type] VARCHAR(32) NULL,
    [adengine_hours] VARCHAR(MAX) NULL,
    [adbeam] VARCHAR(MAX) NULL,
    [adhull_material] VARCHAR(32) NULL,
    [adtrailer_included] VARCHAR(100) NULL,
    [adPostingCategoryID] VARCHAR(32) NULL,
    [dlrname] VARCHAR(MAX) NULL
);

CREATE TABLE [InvMasterData] (
    [DLRID] VARCHAR(64) NULL,
    [adid] VARCHAR(24) NULL,
    [advehicle_hash_id] VARCHAR(64) NULL,
    [adaltid] VARCHAR(24) NULL,
    [adtitle] VARCHAR(500) NULL,
    [advin] VARCHAR(24) NULL,
    [adyear] VARCHAR(8) NULL,
    [admake] VARCHAR(64) NULL,
    [admodel] VARCHAR(64) NULL,
    [admodel_code] VARCHAR(100) NULL,
    [adsubmodel] VARCHAR(124) NULL,
    [adengine_description] VARCHAR(200) NULL,
    [adengine_cc] VARCHAR(64) NULL,
    [adtransmission_description] VARCHAR(200) NULL,
    [adtransmission_type] VARCHAR(64) NULL,
    [adstock] VARCHAR(64) NULL,
    [adbodytype] VARCHAR(124) NULL,
    [adcylinders] VARCHAR(64) NULL,
    [addrivetrain] VARCHAR(200) NULL,
    [admiles] VARCHAR(64) NULL,
    [adcondition] VARCHAR(64) NULL,
    [addoors] VARCHAR(64) NULL,
    [adintcolor] VARCHAR(124) NULL,
    [adextcolorgeneric] VARCHAR(124) NULL,
    [adtext] VARCHAR(MAX) NULL,
    [adoptions] VARCHAR(MAX) NULL,
    [adwarranty] VARCHAR(64) NULL,
    [addata_provider_id] VARCHAR(64) NULL,
    [adextcolor] VARCHAR(64) NULL,
    [adinterior_type] VARCHAR(64) NULL,
    [advideoURL] VARCHAR(255) NULL,
    [adpics] VARCHAR(MAX) NULL,
    [adprice] VARCHAR(24) NULL,
    [msrp] VARCHAR(24) NULL,
    [adinvoiceprice] VARCHAR(24) NULL,
    [admisc_price_1] VARCHAR(24) NULL,
    [admisc_price_2] VARCHAR(24) NULL,
    [adfueltype] VARCHAR(64) NULL,
    [adepacity] VARCHAR(64) NULL,
    [adepahwy] VARCHAR(64) NULL,
    [adepacombined] VARCHAR(64) NULL,
    [advdpurl] VARCHAR(255) NULL,
    [adaxles] VARCHAR(24) NULL,
    [adlength] VARCHAR(64) NULL,
    [adwidth] VARCHAR(64) NULL,
    [adheight] VARCHAR(64) NULL,
    [adweight] VARCHAR(64) NULL,
    [adwater_capacity] VARCHAR(24) NULL,
    [adleveling_jacks] VARCHAR(64) NULL,
    [adengine_hours] VARCHAR(64) NULL,
    [adengine_type] VARCHAR(64) NULL,
    [adhull_material] VARCHAR(64) NULL,
    [adwheelbase] VARCHAR(64) NULL,
    [adfuel_capacity] VARCHAR(124) NULL,
    [advehicle_type_id] VARCHAR(64) NULL,
    [adsleeping_capacity] VARCHAR(64) NULL,
    [adcarfax_url] VARCHAR(255) NULL,
    [adfilter] VARCHAR(64) NULL,
    [DlrName] VARCHAR(150) NULL,
    [DlrAddress] VARCHAR(150) NULL,
    [DlrCity] VARCHAR(64) NULL,
    [DlrState] VARCHAR(24) NULL,
    [DlrZip] VARCHAR(12) NULL,
    [DlrCountry] VARCHAR(24) NULL,
    [DlrURL] VARCHAR(255) NULL,
    [DlrLat] VARCHAR(64) NULL,
    [DlrLong] VARCHAR(64) NULL,
    [adbodystyle] VARCHAR(124) NULL,
    [adcategory] VARCHAR(124) NULL,
    [advehicletype] VARCHAR(124) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [IOcom_ads] (
    [dlrID] VARCHAR(24) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(64) NULL,
    [dlrZip] VARCHAR(64) NULL,
    [dlrEmail] VARCHAR(64) NULL,
    [dlrURL] VARCHAR(124) NULL,
    [dlrPhone] VARCHAR(64) NULL,
    [adID] VARCHAR(64) NULL,
    [AdStock] VARCHAR(32) NULL,
    [adVin] VARCHAR(32) NULL,
    [adSection] VARCHAR(64) NULL,
    [adtype] VARCHAR(16) NULL,
    [adcertified] VARCHAR(16) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(64) NULL,
    [adSubModel] VARCHAR(64) NULL,
    [adYear] VARCHAR(16) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adExtColor] VARCHAR(128) NULL,
    [adCondition] VARCHAR(16) NULL,
    [adHeadline] VARCHAR(MAX) NULL,
    [adText] VARCHAR(MAX) NULL,
    [adCustom] VARCHAR(MAX) NULL,
    [adPrice] VARCHAR(16) NULL,
    [adPhone] VARCHAR(16) NULL,
    [adPics] VARCHAR(MAX) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [IOcom_customers] (
    [dlrid] VARCHAR(24) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(64) NULL,
    [dlrZip] VARCHAR(64) NULL,
    [dlrPhone] VARCHAR(64) NULL,
    [dlremail] VARCHAR(64) NULL,
    [dlrurl] VARCHAR(512) NULL
);

CREATE TABLE [IocomData] (
    [Dlrid] VARCHAR(16) NULL,
    [Dlrname] VARCHAR(64) NULL,
    [DlrAddr] VARCHAR(64) NULL,
    [DlrCity] VARCHAR(64) NULL,
    [DlrState] VARCHAR(64) NULL,
    [DlrZip] VARCHAR(10) NULL,
    [DlrPhone] VARCHAR(32) NULL,
    [DlrEmail] VARCHAR(64) NULL,
    [UnitNo] VARCHAR(128) NULL,
    [AdStock] VARCHAR(32) NULL,
    [AdYear] VARCHAR(8) NULL,
    [AdMake] VARCHAR(32) NULL,
    [AdModel] VARCHAR(64) NULL,
    [AdSubmodel] VARCHAR(64) NULL,
    [AdVin] VARCHAR(64) NULL,
    [AdMileage] VARCHAR(8) NULL,
    [AdPrice] VARCHAR(8) NULL,
    [AdExterior] VARCHAR(64) NULL,
    [AdInterior] VARCHAR(64) NULL,
    [AdEngine] VARCHAR(64) NULL,
    [AdTransmission] VARCHAR(64) NULL,
    [AdBodyType] VARCHAR(64) NULL,
    [AdOptions] VARCHAR(4096) NULL,
    [DlrUrl] VARCHAR(64) NULL,
    [AdImages] VARCHAR(8000) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [IpublisherAds] (
    [DlrID] VARCHAR(30) NULL,
    [VIN] VARCHAR(20) NULL,
    [StockNumber] VARCHAR(32) NULL,
    [Make] VARCHAR(32) NULL,
    [Model] VARCHAR(128) NULL,
    [Year] VARCHAR(4) NULL,
    [TrimStyle] VARCHAR(32) NULL,
    [Body] VARCHAR(64) NULL,
    [NewUsed] VARCHAR(16) NULL,
    [CertifiedUsed] BIT NULL,
    [VehicleType] VARCHAR(64) NULL,
    [Miles] VARCHAR(32) NULL,
    [Engine] VARCHAR(128) NULL,
    [EngineDisplacement] VARCHAR(128) NULL,
    [Transmission] VARCHAR(128) NULL,
    [DriveType] VARCHAR(128) NULL,
    [ExtColor] VARCHAR(128) NULL,
    [IntColor] VARCHAR(128) NULL,
    [SellingPrice] VARCHAR(8) NULL,
    [MSRP] VARCHAR(64) NULL,
    [BookValue] VARCHAR(512) NULL,
    [Rebate] VARCHAR(512) NULL,
    [PhotoURL] VARCHAR(8000) NULL,
    [Comments] VARCHAR(8000) NULL,
    [Options] VARCHAR(8000) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [JTZDealers] (
    [dlrID] VARCHAR(32) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(32) NULL,
    [dlrCity] VARCHAR(32) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZIP] VARCHAR(32) NULL,
    [dlrEmail] VARCHAR(64) NULL,
    [dlrURL] VARCHAR(64) NULL,
    [dlrPhone] VARCHAR(20) NULL
);

CREATE TABLE [KGISolutionsAds] (
    [dlrID] VARCHAR(12) NULL,
    [adID] VARCHAR(25) NULL,
    [adStock] VARCHAR(16) NULL,
    [adVIN] VARCHAR(25) NULL,
    [adSection] VARCHAR(23) NULL,
    [adSCLID] VARCHAR(9) NULL,
    [adCertified] VARCHAR(9) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(64) NULL,
    [adSubModel] VARCHAR(128) NULL,
    [adYear] VARCHAR(12) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adColor] VARCHAR(40) NULL,
    [adCondition] VARCHAR(16) NULL,
    [adHeadline] VARCHAR(128) NULL,
    [adText] VARCHAR(4096) NULL,
    [adPic1] VARCHAR(4096) NULL,
    [adPrice] VARCHAR(16) NULL,
    [adPhone] VARCHAR(16) NULL,
    [adPics] VARCHAR(4096) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [KGISolutionsDealers] (
    [dlrID] VARCHAR(12) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(43) NULL,
    [dlrState] VARCHAR(8) NULL,
    [dlrZIP] VARCHAR(8) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrURL] VARCHAR(512) NULL,
    [dealerPhone] VARCHAR(16) NULL
);

CREATE TABLE [KrytenAds] (
    [dlrName] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(32) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZIP] VARCHAR(10) NULL,
    [dlrPhone] VARCHAR(16) NULL,
    [admvdp] VARCHAR(256) NULL,
    [adVIN] VARCHAR(17) NULL,
    [adid] VARCHAR(17) NULL,
    [adcat] VARCHAR(128) NULL,
    [adyear] VARCHAR(24) NULL,
    [adMake] VARCHAR(128) NULL,
    [adModel] VARCHAR(128) NULL,
    [adcondition] VARCHAR(128) NULL,
    [adinteriorcolor] VARCHAR(128) NULL,
    [adprice] VARCHAR(64) NULL,
    [admiles] VARCHAR(64) NULL,
    [adlength] VARCHAR(64) NULL,
    [adjacks] VARCHAR(256) NULL,
    [adselfcontained] VARCHAR(128) NULL,
    [adslideouts] VARCHAR(128) NULL,
    [adwatercapacity] VARCHAR(128) NULL,
    [addescription] VARCHAR(8000) NULL,
    [adimages] VARCHAR(MAX) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [KrytenPhotos] (
    [adid] VARCHAR(64) NULL,
    [imgurl] VARCHAR(512) NULL,
    [imgsort] VARCHAR(512) NULL
);

CREATE TABLE [LAPD091506739] (
    [memid] INT NOT NULL,
    [email] VARCHAR(64) NOT NULL,
    [phone] VARCHAR(16) NULL
);

CREATE TABLE [LeadQStatus] (
    [lqStatusID] INT NOT NULL -- PK,
    [lqStatusName] VARCHAR(16) NOT NULL
);

CREATE TABLE [LeadQueue] (
    [lqID] INT NOT NULL -- PK,
    [AdID] INT NOT NULL,
    [lqStatusID] INT NOT NULL,
    [lqCreated] SMALLDATETIME NOT NULL,
    [lqFromMail] VARCHAR(256) NOT NULL,
    [lqFromIP] VARCHAR(16) NOT NULL,
    [lqFromName] VARCHAR(64) NOT NULL,
    [lqFromPhone] VARCHAR(16) NOT NULL,
    [lqMessage] VARCHAR(512) NOT NULL,
    [lqProofBy] VARCHAR(64) NULL,
    [lqProofComment] VARCHAR(512) NULL,
    [lqSent] SMALLDATETIME NULL,
    [lqADFXML] VARCHAR(8000) NULL
);

CREATE TABLE [LeadsExternalStatus] (
    [SID] TINYINT NOT NULL -- PK,
    [SDescription] VARCHAR(50) NULL
);

CREATE TABLE [LiquidMotorData] (
    [DlrID] VARCHAR(12) NULL,
    [adStockNumber] VARCHAR(32) NULL,
    [adYear] VARCHAR(4) NULL,
    [adMake] VARCHAR(30) NULL,
    [adModel] VARCHAR(40) NULL,
    [adTrim] VARCHAR(64) NULL,
    [adVIN] VARCHAR(19) NULL,
    [adMileage] INT NULL,
    [adPrice] INT NULL,
    [adMSRP] VARCHAR(16) NULL,
    [adExteriorColor] VARCHAR(90) NULL,
    [adInteriorColor] VARCHAR(90) NULL,
    [adTransmission] VARCHAR(90) NULL,
    [adImage] VARCHAR(3072) NULL,
    [adDescription] VARCHAR(3072) NULL,
    [adNotes] VARCHAR(8000) NULL,
    [adBodyType] VARCHAR(30) NULL,
    [adEngineType] VARCHAR(30) NULL,
    [adDriveType] VARCHAR(100) NULL,
    [adFuelType] VARCHAR(30) NULL,
    [adType] VARCHAR(30) NULL,
    [adInternetPrice] INT NULL,
    [DlrName] VARCHAR(64) NULL,
    [DlrAddress] VARCHAR(64) NULL,
    [DlrState] VARCHAR(4) NULL,
    [DlrZip] VARCHAR(5) NULL,
    [DlrPhone] VARCHAR(32) NULL,
    [DlrURL] VARCHAR(64) NULL,
    [DlrEmail] VARCHAR(90) NULL,
    [adCondition] VARCHAR(32) NULL,
    [DlrCity] VARCHAR(32) NULL,
    [adCertified] VARCHAR(32) NULL,
    [adStyle] VARCHAR(200) NULL,
    [adGenericExtColor] VARCHAR(32) NULL,
    [adSection] VARCHAR(32) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [LOCALDEALERS] (
    [LDID] INT NOT NULL -- PK,
    [LDSLOGO] VARCHAR(128) NOT NULL,
    [LDLLOGO] VARCHAR(128) NOT NULL,
    [LDTLOGO] VARCHAR(128) NOT NULL,
    [LDACTIVE] BIT NOT NULL,
    [CUSID] INT NOT NULL,
    [PUBID] INT NOT NULL,
    [LDCOMPANYNAME] VARCHAR(64) NULL,
    [LDADDRESS] VARCHAR(64) NULL,
    [LDCITY] VARCHAR(32) NULL,
    [LDSTATE] VARCHAR(2) NULL,
    [LDZIP] VARCHAR(10) NULL,
    [LDPHONE] VARCHAR(10) NULL,
    [LDPHONESHOW] BIT NULL,
    [LDALTPHONE] VARCHAR(10) NULL,
    [LDALTPHONESHOW] BIT NULL,
    [LDFAX] VARCHAR(10) NULL,
    [LDFAXSHOW] BIT NULL,
    [LDEMAIL] VARCHAR(128) NULL,
    [LDEMAILSHOW] BIT NULL,
    [LDWEBSITE] VARCHAR(128) NULL
);

CREATE TABLE [LookAtUsedCarsAds] (
    [dlrid] VARCHAR(24) NULL,
    [dlrname] VARCHAR(64) NULL,
    [dlraddress] VARCHAR(64) NULL,
    [dlrcity] VARCHAR(32) NULL,
    [dlrstate] VARCHAR(32) NULL,
    [dlrzip] VARCHAR(12) NULL,
    [dlremail] VARCHAR(128) NULL,
    [dlrurl] VARCHAR(512) NULL,
    [dlrphone] VARCHAR(24) NULL,
    [vehid] VARCHAR(24) NULL,
    [stocknumber] VARCHAR(64) NULL,
    [vin] VARCHAR(18) NULL,
    [vehtype] VARCHAR(24) NULL,
    [make] VARCHAR(64) NULL,
    [model] VARCHAR(64) NULL,
    [trim] VARCHAR(64) NULL,
    [year] VARCHAR(4) NULL,
    [miles] VARCHAR(12) NULL,
    [extcolor] VARCHAR(64) NULL,
    [condition] VARCHAR(12) NULL,
    [ymmt] VARCHAR(128) NULL,
    [features] VARCHAR(4000) NULL,
    [comments] VARCHAR(5000) NULL,
    [price] VARCHAR(10) NULL,
    [images] VARCHAR(5000) NULL,
    [thumbnails] VARCHAR(5000) NULL
);

CREATE TABLE [lookupCities] (
    [COUNTRY] VARCHAR(3) NULL,
    [ZIPCODE] VARCHAR(10) NULL,
    [EXT] SMALLINT NULL,
    [CITY] VARCHAR(40) NULL,
    [STATEID] SMALLINT NULL,
    [AREACODE] VARCHAR(20) NULL,
    [SITEID] SMALLINT NULL,
    [DATETIMESTAMP] DATETIME NULL
);

CREATE TABLE [LotBoysAds] (
    [dlrid] VARCHAR(32) NULL,
    [dlrName] VARCHAR(32) NULL,
    [dlrAddr] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(32) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZip] VARCHAR(10) NULL,
    [dlrEmail] VARCHAR(96) NULL,
    [dlrURL] VARCHAR(512) NULL,
    [dlrPhone] VARCHAR(18) NULL,
    [adID] VARCHAR(32) NULL,
    [adStock] VARCHAR(32) NULL,
    [adVIN] VARCHAR(32) NULL,
    [adSection] VARCHAR(32) NULL,
    [adType] VARCHAR(32) NULL,
    [adCertified] VARCHAR(24) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(256) NULL,
    [adSubModel] VARCHAR(64) NULL,
    [adYear] VARCHAR(4) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adColor] VARCHAR(64) NULL,
    [adCondition] VARCHAR(32) NULL,
    [adHeadline] VARCHAR(1024) NULL,
    [adText] VARCHAR(MAX) NULL,
    [adCustomText] VARCHAR(6500) NULL,
    [adPrice] VARCHAR(10) NULL,
    [adPhone] VARCHAR(18) NULL,
    [adPics] VARCHAR(6500) NULL
);

CREATE TABLE [LotBoysDealers] (
    [dlrID] VARCHAR(32) NULL,
    [dlrName] VARCHAR(32) NULL,
    [dlrAddr] VARCHAR(128) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZip] VARCHAR(10) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrURL] VARCHAR(512) NULL,
    [dlrPhone] VARCHAR(18) NULL,
    [dlrFileName] VARCHAR(128) NULL,
    [active] BIT NOT NULL
);

CREATE TABLE [LotVantage_Ads] (
    [dlrID] VARCHAR(32) NULL,
    [adStock] VARCHAR(100) NULL,
    [adInStockDate] VARCHAR(32) NULL,
    [adCarType] VARCHAR(255) NULL,
    [adstatus] VARCHAR(16) NULL,
    [adInvoice] VARCHAR(16) NULL,
    [adPackAmount] VARCHAR(16) NULL,
    [adCost] VARCHAR(16) NULL,
    [adHoldbackAmount] VARCHAR(32) NULL,
    [adPrice] VARCHAR(32) NULL,
    [adMSRP] VARCHAR(32) NULL,
    [adLotLocation] VARCHAR(64) NULL,
    [adcondition] VARCHAR(32) NULL,
    [adHeadline] VARCHAR(512) NULL,
    [adCertified] VARCHAR(32) NULL,
    [adCertificationNumber] VARCHAR(32) NULL,
    [adVIN] VARCHAR(32) NULL,
    [adMake] VARCHAR(128) NULL,
    [adModel] VARCHAR(256) NULL,
    [adYear] VARCHAR(10) NULL,
    [admodelcode] VARCHAR(64) NULL,
    [adSubModel] VARCHAR(256) NULL,
    [adSubTrimLevel] VARCHAR(100) NULL,
    [adSection] VARCHAR(512) NULL,
    [adVehicleTypeCode] VARCHAR(32) NULL,
    [adMiles] VARCHAR(50) NULL,
    [adPayload] VARCHAR(12) NULL,
    [adSeatingCapacity] VARCHAR(32) NULL,
    [adWheelBase] VARCHAR(12) NULL,
    [adbodytype] VARCHAR(128) NULL,
    [adDoors] VARCHAR(32) NULL,
    [adDriveTrain] VARCHAR(100) NULL,
    [adEngineDisposition] VARCHAR(128) NULL,
    [adEngineSize] VARCHAR(128) NULL,
    [adTransmission] VARCHAR(128) NULL,
    [adTransmissionType] VARCHAR(128) NULL,
    [adExtColor] VARCHAR(512) NULL,
    [adExtColorGeneric] VARCHAR(100) NULL,
    [adInterior] VARCHAR(64) NULL,
    [adintColor] VARCHAR(512) NULL,
    [adText] VARCHAR(8000) NULL,
    [adAddedFeatures] VARCHAR(MAX) NULL,
    [adCreatedDate] VARCHAR(MAX) NULL,
    [adLastModifiedDate] VARCHAR(MAX) NULL,
    [adLastModifiedFlag] VARCHAR(MAX) NULL,
    [adImageCount] VARCHAR(MAX) NULL,
    [adImageModDate] VARCHAR(MAX) NULL,
    [adPics] VARCHAR(MAX) NULL,
    [VDPURL] VARCHAR(MAX) NULL,
    [adtier] VARCHAR(MAX) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [LotVantage_Dealers] (
    [Dlrid] VARCHAR(12) NULL,
    [DlrName] VARCHAR(100) NULL,
    [DlrAddress] VARCHAR(64) NULL,
    [DlrAddress2] VARCHAR(64) NULL,
    [DlrCity] VARCHAR(32) NULL,
    [DlrState] VARCHAR(64) NULL,
    [DlrZip] VARCHAR(24) NULL,
    [DlrEmail] VARCHAR(128) NULL,
    [DlrStringEmail] VARCHAR(128) NULL,
    [DlrPhone] VARCHAR(64) NULL,
    [DlrURL] VARCHAR(512) NULL,
    [DlrLat] VARCHAR(32) NULL,
    [DlrLong] VARCHAR(32) NULL
);

CREATE TABLE [MagnetDigitalAds] (
    [dlrID] VARCHAR(12) NULL,
    [adID] VARCHAR(25) NULL,
    [adStock] VARCHAR(16) NULL,
    [adVIN] VARCHAR(25) NULL,
    [adSection] VARCHAR(23) NULL,
    [adType] VARCHAR(9) NULL,
    [adCertified] VARCHAR(9) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(32) NULL,
    [adSubModel] VARCHAR(128) NULL,
    [adYear] VARCHAR(12) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adColor] VARCHAR(32) NULL,
    [adCondition] VARCHAR(16) NULL,
    [adHeadline] VARCHAR(32) NULL,
    [adText] VARCHAR(4096) NULL,
    [adCustomText] VARCHAR(4096) NULL,
    [adPrice] VARCHAR(16) NULL,
    [adPhone] VARCHAR(16) NULL,
    [adPics] VARCHAR(4096) NULL,
    [adPic1] VARCHAR(4096) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [MagnetDigitalDealers] (
    [dlrID] VARCHAR(12) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(43) NULL,
    [dlrState] VARCHAR(8) NULL,
    [dlrZIP] VARCHAR(8) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrURL] VARCHAR(512) NULL,
    [dlrPhone] VARCHAR(16) NULL
);

CREATE TABLE [MAKES] (
    [MKSPELL] VARCHAR(24) NOT NULL -- PK,
    [MKSOUND] VARCHAR(16) NOT NULL,
    [MKUSE] VARCHAR(24) NOT NULL,
    [MKURL] VARCHAR(512) NULL,
    [MKLOGO] VARCHAR(128) NULL,
    [MKAUTO] BIT NOT NULL,
    [MKCYCLE] BIT NOT NULL
);

CREATE TABLE [ManualImport] (
    [manID] INT NOT NULL,
    [cusID] INT NOT NULL,
    [adNum] INT NOT NULL,
    [importDate] DATETIME NOT NULL,
    [importBy] VARCHAR(50) NOT NULL,
    [pubID] INT NOT NULL,
    [importState] TINYINT NOT NULL
);

CREATE TABLE [MarineReportForMark] (
    [ffid] INT NOT NULL,
    [ffdateofevent] DATETIME NULL,
    [ffcusid] INT NOT NULL,
    [ffwname] VARCHAR(64) NOT NULL,
    [acc_id_rep] INT NOT NULL,
    [ffwphone] VARCHAR(16) NOT NULL,
    [ffnotes] VARCHAR(8000) NULL,
    [min_ffdateofevent] DATETIME NULL,
    [ffidmaster] INT NULL,
    [ftname] VARCHAR(32) NOT NULL
);

CREATE TABLE [MemberPublications] (
    [memID] INT NOT NULL -- PK,
    [pubID] INT NOT NULL -- PK
);

CREATE TABLE [MEMBERS] (
    [MEMID] INT NOT NULL -- PK,
    [MEMUID] VARCHAR(64) NOT NULL,
    [MEMPWD] VARCHAR(32) NOT NULL,
    [MEMNAME] VARCHAR(64) NOT NULL,
    [MEMADDR] VARCHAR(64) NULL,
    [MEMCITY] VARCHAR(32) NULL,
    [MEMSTATE] VARCHAR(2) NOT NULL,
    [MEMZIP] VARCHAR(10) NOT NULL,
    [MEMEMAIL] VARCHAR(64) NULL,
    [MEMPHONE] VARCHAR(16) NULL,
    [MEMCREATED] SMALLDATETIME NOT NULL,
    [PUBID] INT NOT NULL
);

CREATE TABLE [Members77] (
    [memid] INT NOT NULL,
    [memuid] VARCHAR(64) NOT NULL,
    [mempwd] VARCHAR(32) NOT NULL
);

CREATE TABLE [MEMROLES] (
    [MEMID] INT NOT NULL -- PK,
    [MEMROLES] INT NOT NULL -- PK
);

CREATE TABLE [MemRoles_Backup] (
    [mrbID] BIGINT NOT NULL,
    [memID] INT NOT NULL,
    [memUID] VARCHAR(64) NOT NULL,
    [roleID] INT NOT NULL,
    [roleName] VARCHAR(50) NOT NULL,
    [RemovedOn] DATETIME NOT NULL
);

CREATE TABLE [MEMROLES_LOG] (
    [mrl_ID] INT NOT NULL -- PK,
    [mrl_Modified] DATETIME NOT NULL,
    [memID] INT NOT NULL,
    [roleID] INT NOT NULL,
    [usrID] INT NOT NULL,
    [mrl_Ticket] VARCHAR(16) NOT NULL
);

CREATE TABLE [MilitaryAutoSourceData] (
    [DlrID] VARCHAR(64) NULL,
    [adYear] VARCHAR(64) NULL,
    [adMake] VARCHAR(64) NULL,
    [adModel] VARCHAR(124) NULL,
    [adSubmodel] VARCHAR(64) NULL,
    [adStock] VARCHAR(64) NULL,
    [adVIN] VARCHAR(64) NULL,
    [adCondition] VARCHAR(64) NULL,
    [adBody] VARCHAR(64) NULL,
    [adFactoryOrderNumber] VARCHAR(64) NULL,
    [adMSRP] VARCHAR(64) NULL,
    [adManufacturerDiscount] VARCHAR(64) NULL,
    [adManufacturerRebates] VARCHAR(64) NULL,
    [adOnBase] VARCHAR(64) NULL,
    [adclearanceFlag] VARCHAR(64) NULL,
    [adinTransitFlag] VARCHAR(64) NULL,
    [adlowMileageFlag] VARCHAR(64) NULL,
    [adnewArrivalFlag] VARCHAR(64) NULL,
    [adspecialFlag] VARCHAR(64) NULL,
    [adVehicleType] VARCHAR(64) NULL,
    [adIntColor] VARCHAR(64) NULL,
    [adExtColor] VARCHAR(64) NULL,
    [adMPGCity] VARCHAR(64) NULL,
    [adMPGHwy] VARCHAR(64) NULL,
    [adMiles] VARCHAR(64) NULL,
    [adPrice] VARCHAR(64) NULL,
    [adSection] VARCHAR(64) NULL,
    [adVDP] VARCHAR(256) NULL,
    [adCurrentCountry] VARCHAR(200) NULL,
    [adPics] VARCHAR(MAX) NULL,
    [adtext] VARCHAR(MAX) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [Missing_LAT_LONG] (
    [Acc_Company] VARCHAR(64) NULL,
    [dlrid] VARCHAR(16) NULL
);

CREATE TABLE [Missing_RDP_URL] (
    [Acc_Company] VARCHAR(64) NOT NULL,
    [fdURL] VARCHAR(512) NULL,
    [dlrID] INT NULL
);

CREATE TABLE [MissingAdvantageImages] (
    [PUBID] INT NOT NULL,
    [PUBNAME] VARCHAR(64) NOT NULL,
    [CUSID] INT NULL,
    [DLNAME] VARCHAR(64) NULL,
    [DLPHONE] VARCHAR(16) NULL,
    [DSID] INT NOT NULL,
    [DSMODIFIED] SMALLDATETIME NOT NULL,
    [FilePath] VARCHAR(383) NULL
);

CREATE TABLE [MissingDSImages] (
    [DSID] INT NOT NULL,
    [IMGURL] VARCHAR(512) NULL,
    [IMGSORT] TINYINT NOT NULL
);

CREATE TABLE [MJMICustomers] (
    [dlrID] VARCHAR(32) NULL,
    [dlrName] VARCHAR(32) NULL,
    [dlrAddr] VARCHAR(128) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZip] VARCHAR(10) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrURL] VARCHAR(512) NULL,
    [dlrPhone] VARCHAR(18) NULL
);

CREATE TABLE [MJMIData] (
    [dlrID] VARCHAR(32) NULL,
    [adStock] VARCHAR(32) NULL,
    [adYear] VARCHAR(4) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(128) NULL,
    [adTrim] VARCHAR(64) NULL,
    [adVin] VARCHAR(32) NULL,
    [adMiles] VARCHAR(16) NULL,
    [MSRP] VARCHAR(32) NULL,
    [dlrPrice] VARCHAR(32) NULL,
    [adExtColor] VARCHAR(64) NULL,
    [adIntColor] VARCHAR(64) NULL,
    [adTransmission] VARCHAR(64) NULL,
    [adPics] VARCHAR(MAX) NULL,
    [adDescription] VARCHAR(8000) NULL,
    [adSection] VARCHAR(32) NULL,
    [adEngine] VARCHAR(64) NULL,
    [adDriveType] VARCHAR(64) NULL,
    [adFuelType] VARCHAR(32) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [MODELS] (
    [MDLMAKE] VARCHAR(32) NOT NULL -- PK,
    [MDLNAME] VARCHAR(32) NOT NULL -- PK,
    [MDLTRIM] VARCHAR(32) NOT NULL -- PK,
    [MDLCARTYPE] TINYINT NOT NULL
);

CREATE TABLE [MODELSNEW] (
    [MDLMAKE] VARCHAR(32) NOT NULL -- PK,
    [MDLNAME] VARCHAR(32) NOT NULL -- PK,
    [MDLTRIM] VARCHAR(32) NOT NULL -- PK,
    [MDLCARTYPE] TINYINT NOT NULL,
    [MDLWORDS] TINYINT NOT NULL
);

CREATE TABLE [ModifyEndeavor] (
    [MDID] INT NOT NULL,
    [pubid] INT NOT NULL,
    [adnum] INT NOT NULL,
    [date] DATETIME NOT NULL,
    [cancelby] VARCHAR(50) NOT NULL,
    [var1] BIT NOT NULL,
    [var2] BIT NOT NULL
);

CREATE TABLE [MultiFeedOverwrite] (
    [EDTAG] VARCHAR(64) NOT NULL -- PK,
    [FDID_OLD] VARCHAR(32) NOT NULL -- PK,
    [FDID_NEW] VARCHAR(32) NOT NULL,
    [CREATED] DATETIME NOT NULL
);

CREATE TABLE [NavigatorExcludeRan] (
    [External_Id] BIGINT NULL,
    [Exclude_Ran] NUMERIC(3,0) NULL,
    [Exclude_Recycler] NUMERIC(3,0) NULL
);

CREATE TABLE [netlookads] (
    [DLRID] VARCHAR(25) NULL,
    [ADID] VARCHAR(25) NULL,
    [ADVIN] VARCHAR(25) NULL,
    [ADSECTION] VARCHAR(25) NULL,
    [ADMAKE] VARCHAR(100) NULL,
    [ADMODEL] VARCHAR(100) NULL,
    [ADSUBMODEL] VARCHAR(100) NULL,
    [ADYEAR] VARCHAR(4) NULL,
    [ADMILES] VARCHAR(10) NULL,
    [ADHEADLINE] VARCHAR(2500) NULL,
    [ADTEXT] VARCHAR(8000) NULL,
    [ADPRICE] VARCHAR(100) NULL,
    [ADPHONE] VARCHAR(100) NULL,
    [ADPICS] VARCHAR(8000) NULL,
    [ADOPTIONS] VARCHAR(8000) NULL,
    [ADNEWUSED] VARCHAR(32) NULL,
    [ADEXTERIOR] VARCHAR(128) NULL,
    [ADCERTIFIED] VARCHAR(8) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [netlookdata] (
    [dlrID] VARCHAR(25) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(24) NULL,
    [dlrState] VARCHAR(12) NULL,
    [dlrZIP] VARCHAR(8) NULL,
    [dlrEmail] VARCHAR(64) NULL,
    [dlrURL] VARCHAR(255) NULL,
    [dlrPhone] VARCHAR(16) NULL,
    [adID] VARCHAR(25) NULL,
    [adStock] VARCHAR(25) NULL,
    [adVIN] VARCHAR(17) NULL,
    [adSection] VARCHAR(25) NULL,
    [adType] VARCHAR(25) NULL,
    [adCertified] VARCHAR(12) NULL,
    [adYear] VARCHAR(8) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(64) NULL,
    [adSubModel] VARCHAR(64) NULL,
    [adStyle] VARCHAR(25) NULL,
    [adMiles] VARCHAR(8) NULL,
    [adExteriorColor] VARCHAR(64) NULL,
    [adGenericExtColor] VARCHAR(64) NULL,
    [adHeadline] VARCHAR(100) NULL,
    [adText] VARCHAR(8000) NULL,
    [adCustomText] VARCHAR(4000) NULL,
    [adPrice] VARCHAR(12) NULL,
    [adInvoice] VARCHAR(12) NULL,
    [adMSRP] VARCHAR(12) NULL,
    [adMiscPrice1] VARCHAR(12) NULL,
    [adMiscPrice2] VARCHAR(12) NULL,
    [adModelCode] VARCHAR(25) NULL,
    [adDateInStock] VARCHAR(25) NULL,
    [adWheelbase] VARCHAR(12) NULL,
    [adDoors] VARCHAR(12) NULL,
    [adTransmission] VARCHAR(64) NULL,
    [adDriveType] VARCHAR(16) NULL,
    [adEngineDescription] VARCHAR(100) NULL,
    [adEngineCylinders] VARCHAR(24) NULL,
    [adEngDisplacement] VARCHAR(24) NULL,
    [adFuelType] VARCHAR(24) NULL,
    [adEPACity] VARCHAR(12) NULL,
    [adEPAHighway] VARCHAR(12) NULL,
    [adPics] VARCHAR(8000) NULL,
    [adThumbs] VARCHAR(8000) NULL,
    [adVDP] VARCHAR(255) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [netlookdealers] (
    [dlrID] VARCHAR(25) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(24) NULL,
    [dlrState] VARCHAR(12) NULL,
    [dlrZIP] VARCHAR(8) NULL,
    [dlrEmail] VARCHAR(64) NULL,
    [dlrURL] VARCHAR(255) NULL,
    [dlrPhone] VARCHAR(16) NULL,
    [adID] VARCHAR(25) NULL,
    [adStock] VARCHAR(25) NULL,
    [adVIN] VARCHAR(17) NULL,
    [adSection] VARCHAR(25) NULL,
    [adType] VARCHAR(25) NULL,
    [adCertified] VARCHAR(12) NULL,
    [adYear] VARCHAR(8) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(64) NULL,
    [adSubModel] VARCHAR(64) NULL,
    [adStyle] VARCHAR(25) NULL,
    [adMiles] VARCHAR(8) NULL,
    [adExteriorColor] VARCHAR(64) NULL,
    [adGenericExtColor] VARCHAR(64) NULL,
    [adHeadline] VARCHAR(100) NULL,
    [adText] VARCHAR(4000) NULL,
    [adCustomText] VARCHAR(4000) NULL,
    [adPrice] VARCHAR(12) NULL,
    [adInvoice] VARCHAR(12) NULL,
    [adMSRP] VARCHAR(12) NULL,
    [adMiscPrice1] VARCHAR(12) NULL,
    [adMiscPrice2] VARCHAR(12) NULL,
    [adModelCode] VARCHAR(25) NULL,
    [adDateInStock] VARCHAR(25) NULL,
    [adWheelbase] VARCHAR(12) NULL,
    [adDoors] VARCHAR(12) NULL,
    [adTransmission] VARCHAR(64) NULL,
    [adDriveType] VARCHAR(16) NULL,
    [adEngineDescription] VARCHAR(100) NULL,
    [adEngineCylinders] VARCHAR(24) NULL,
    [adEngDisplacement] VARCHAR(24) NULL,
    [adFuelType] VARCHAR(24) NULL,
    [adEPACity] VARCHAR(12) NULL,
    [adEPAHighway] VARCHAR(12) NULL,
    [adPics] VARCHAR(8000) NULL,
    [adThumbs] VARCHAR(8000) NULL,
    [adVDP] VARCHAR(255) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [New_AccountSecurity] (
    [ase_ID] INT NOT NULL -- PK,
    [acc_ID] INT NOT NULL,
    [aso_ID] INT NOT NULL
);

CREATE TABLE [New_AccountSecurityOptions] (
    [aso_ID] INT NOT NULL -- PK,
    [asg_ID] INT NOT NULL,
    [aso_Name] VARCHAR(128) NULL,
    [aso_Description] VARCHAR(256) NULL,
    [aso_Value] VARCHAR(128) NOT NULL,
    [aso_Sort] INT NOT NULL,
    [asr_ID] INT NULL,
    [rpt_QuickLink] INT NULL,
    [aso_Notes] VARCHAR(1024) NULL,
    [aso_Active] BIT NULL
);

CREATE TABLE [New_ADAccounts] (
    [ADMYID] INT NOT NULL -- PK,
    [ADLogin] VARCHAR(64) NULL,
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
    [External] INT NULL,
    [src_site] INT NULL,
    [rco_ServiceList] VARCHAR(128) NULL
);

CREATE TABLE [New_Class] (
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

CREATE TABLE [New_DMA] (
    [dma_Code] VARCHAR(5) NOT NULL -- PK,
    [dma_Name] VARCHAR(256) NULL
);

CREATE TABLE [new_EmailSources_Count_ByMonth] (
    [a] INT NOT NULL -- PK,
    [esr_ID] INT NOT NULL -- PK,
    [esr_Name] VARCHAR(50) NOT NULL,
    [esr_ShortName] VARCHAR(16) NOT NULL,
    [lYear] INT NOT NULL -- PK,
    [lMonth] INT NOT NULL -- PK,
    [lCount] INT NULL,
    [opsCount] INT NULL
);

CREATE TABLE [New_EmailSources_Count_ByMonth_v2] (
    [a] INT NOT NULL -- PK,
    [esr_ID] INT NOT NULL -- PK,
    [lYear] INT NOT NULL -- PK,
    [lMonth] INT NOT NULL -- PK,
    [lCount] INT NULL,
    [TAC] MONEY NULL
);

CREATE TABLE [New_NewPrintTranslate] (
    [npt_ID] INT NOT NULL -- PK,
    [scl_ID] INT NOT NULL,
    [ped_ID] INT NOT NULL,
    [print_eClsID] INT NOT NULL,
    [print_eClsNumber] INT NOT NULL,
    [print_eClsName] VARCHAR(255) NOT NULL,
    [print_Submit] BIT NOT NULL,
    [LastChange] DATETIME NOT NULL
);

CREATE TABLE [New_PrintEditions] (
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

CREATE TABLE [New_PrintPublications] (
    [pub_ID] INT NOT NULL -- PK,
    [pub_Name] VARCHAR(64) NOT NULL,
    [pub_PaginationShare] VARCHAR(64) NOT NULL,
    [pub_PaginationPath] VARCHAR(64) NOT NULL,
    [pub_NotifyEmail] VARCHAR(128) NOT NULL,
    [pub_PullFromSales] BIT NOT NULL,
    [pub_UploadFolder] VARCHAR(64) NOT NULL,
    [pub_UploadURL] VARCHAR(512) NULL,
    [pub_dB] VARCHAR(16) NOT NULL,
    [pub_IP] VARCHAR(32) NOT NULL,
    [pub_GM_Notify] VARCHAR(64) NULL,
    [pub_RGM_Notify] VARCHAR(64) NULL,
    [pub_VP_Notify] VARCHAR(64) NULL
);

CREATE TABLE [New_SubClass] (
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

CREATE TABLE [New_ZipCode] (
    [zip_Code] VARCHAR(5) NOT NULL -- PK,
    [zip_City] VARCHAR(32) NOT NULL,
    [stt_ID] VARCHAR(2) NOT NULL,
    [zip_Latitude] FLOAT NOT NULL,
    [zip_Longitude] FLOAT NOT NULL,
    [zip_Radius] INT NOT NULL,
    [AREACODE] VARCHAR(3) NULL,
    [dma_Code] VARCHAR(5) NULL,
    [within100] VARCHAR(MAX) NULL
);

CREATE TABLE [NewAggOverlay] (
    [acc_id] INT NOT NULL,
    [acc_company] VARCHAR(64) NOT NULL,
    [fduid] INT NULL,
    [fdid] VARCHAR(32) NULL,
    [dlr_has_overlay] BIT NULL,
    [Aggregator] VARCHAR(64) NULL,
    [feed_overlay_removed] BIT NULL
);

CREATE TABLE [newdlrsourcedealers] (
    [NDSDID] INT NOT NULL,
    [FdID] VARCHAR(50) NOT NULL,
    [DlrID] INT NULL,
    [DlrName] VARCHAR(255) NOT NULL,
    [PubID] INT NOT NULL,
    [EdID] INT NOT NULL
);

CREATE TABLE [NewFeedLive] (
    [AccountName] VARCHAR(64) NULL,
    [FDUID] INT NULL,
    [aso_name] VARCHAR(64) NULL,
    [Dealer_URL] VARCHAR(512) NULL,
    [Aggregator] VARCHAR(512) NULL,
    [Inventory_URL] VARCHAR(8000) NULL,
    [AdCount] INT NULL,
    [RepName] VARCHAR(128) NULL,
    [DealerLogo] VARCHAR(512) NULL
);

CREATE TABLE [NexsteppeAds] (
    [dlrid] VARCHAR(32) NULL,
    [adID] VARCHAR(32) NULL,
    [adStock] VARCHAR(128) NULL,
    [adVIN] VARCHAR(32) NULL,
    [adSection] VARCHAR(64) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(32) NULL,
    [adSubModel] VARCHAR(64) NULL,
    [adYear] VARCHAR(4) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adColor] VARCHAR(64) NULL,
    [adCondition] VARCHAR(32) NULL,
    [adHeadline] VARCHAR(1024) NULL,
    [adText] VARCHAR(8000) NULL,
    [adCustomText] VARCHAR(6500) NULL,
    [adPrice] VARCHAR(10) NULL,
    [adPhone] VARCHAR(18) NULL,
    [adPics] VARCHAR(6500) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [NexsteppeDealers] (
    [dlrid] VARCHAR(32) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddr] VARCHAR(128) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZip] VARCHAR(10) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrURL] VARCHAR(512) NULL,
    [dlrPhone] VARCHAR(18) NULL
);

CREATE TABLE [NexteppeAds] (
    [dlrID] VARCHAR(64) NULL,
    [adID] VARCHAR(25) NULL,
    [adStock] VARCHAR(20) NULL,
    [adVIN] VARCHAR(25) NULL,
    [adSection] VARCHAR(64) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(64) NULL,
    [adSubModel] VARCHAR(128) NULL,
    [adYear] VARCHAR(12) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adColor] VARCHAR(128) NULL,
    [adCondition] VARCHAR(16) NULL,
    [adHeadline] VARCHAR(MAX) NULL,
    [adText] VARCHAR(MAX) NULL,
    [adCustomText] VARCHAR(MAX) NULL,
    [adPrice] VARCHAR(16) NULL,
    [adPhone] VARCHAR(12) NULL,
    [adPics] VARCHAR(4096) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [NexteppeDealers] (
    [dlrID] VARCHAR(64) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(43) NULL,
    [dlrState] VARCHAR(8) NULL,
    [dlrZIP] VARCHAR(8) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrURL] VARCHAR(128) NULL,
    [dlrPhone] VARCHAR(16) NULL
);

CREATE TABLE [NormalizedFAVDP] (
    [faUID] INT NOT NULL -- PK,
    [faVDP] VARCHAR(8000) NULL
);

CREATE TABLE [NullSlsRep] (
    [AccountNameRatchet] VARCHAR(64) NULL,
    [AccountID] BIGINT NULL,
    [SalesRepID] INT NULL,
    [SalesRepAdEz] VARCHAR(128) NULL
);

CREATE TABLE [nwpubeditions] (
    [edid] INT NULL,
    [pubid] INT NULL
);

CREATE TABLE [OldDealerComCustomers] (
    [pubid] VARCHAR(4) NULL,
    [dealerid] VARCHAR(9) NULL,
    [dlrname] VARCHAR(64) NULL,
    [dlraddress] VARCHAR(64) NULL,
    [dlrcity] VARCHAR(32) NULL,
    [dlrstate] VARCHAR(16) NULL,
    [dlrzip] VARCHAR(16) NULL,
    [dlremail] VARCHAR(64) NULL,
    [dlrphone] VARCHAR(32) NULL,
    [dlrurl] VARCHAR(64) NULL,
    [dlrfax] VARCHAR(32) NULL
);

CREATE TABLE [ONECLICK] (
    [MEMID] INT NOT NULL -- PK,
    [RECID] INT NOT NULL,
    [OPTIN] BIT NOT NULL,
    [MODIFIED] SMALLDATETIME NOT NULL
);

CREATE TABLE [oodleCategories] (
    [catID] INT NOT NULL -- PK,
    [catName] VARCHAR(80) NOT NULL
);

CREATE TABLE [OodleSubCategories] (
    [scatID] INT NOT NULL -- PK,
    [catID] INT NOT NULL,
    [scatName] VARCHAR(80) NOT NULL,
    [scatFull] VARCHAR(80) NULL,
    [scatPartial] VARCHAR(80) NULL
);

CREATE TABLE [oodleTemp] (
    [id] VARCHAR(10) NULL,
    [secondary_source] VARCHAR(64) NULL,
    [year] VARCHAR(32) NULL,
    [make] VARCHAR(32) NULL,
    [model] VARCHAR(32) NULL,
    [title] VARCHAR(1024) NULL,
    [url] VARCHAR(1024) NULL,
    [image_url] VARCHAR(512) NULL,
    [price] VARCHAR(16) NULL,
    [create_time] VARCHAR(16) NULL,
    [expire_time] VARCHAR(16) NULL,
    [description] VARCHAR(MAX) NULL,
    [category] VARCHAR(64) NULL,
    [zip_code] VARCHAR(10) NULL,
    [country] VARCHAR(8) NULL
);

CREATE TABLE [oodleTempCats] (
    [cat] VARCHAR(80) NULL,
    [subCat] VARCHAR(80) NULL,
    [subCatFull] VARCHAR(60) NULL,
    [subCatPartial] VARCHAR(60) NULL
);

CREATE TABLE [oodleTempCats2] (
    [cat] VARCHAR(80) NULL,
    [subCat] VARCHAR(80) NULL,
    [subCatFull] VARCHAR(60) NULL,
    [subCatPartial] VARCHAR(60) NULL
);

CREATE TABLE [PACKAGEEXCLUDE] (
    [rID] INT NOT NULL -- PK,
    [SCLID] INT NOT NULL -- PK
);

CREATE TABLE [Palmetto] (
    [ADVIN] VARCHAR(32) NULL,
    [ADSTOCKNO] VARCHAR(30) NULL,
    [ADYEAR] VARCHAR(4) NULL,
    [ADMAKE] VARCHAR(64) NULL,
    [ADMODEL] VARCHAR(64) NULL,
    [ADSUBMODEL] VARCHAR(96) NULL,
    [ADEXTCOLOR] VARCHAR(128) NULL,
    [ADMILEAGE] INT NULL,
    [ADPRICE] MONEY NULL
);

CREATE TABLE [PAYMENTS] (
    [PAYID] INT NOT NULL -- PK,
    [RECID] INT NOT NULL,
    [SUBID] INT NOT NULL,
    [PAYAMOUNT] MONEY NOT NULL,
    [PAYDATE] SMALLDATETIME NOT NULL
);

CREATE TABLE [PCPierceAds] (
    [adyear] VARCHAR(64) NULL,
    [adcat] VARCHAR(64) NULL,
    [admake] VARCHAR(32) NULL,
    [admodel] VARCHAR(32) NULL,
    [adsubmodel] VARCHAR(50) NULL,
    [adcondition] VARCHAR(12) NULL,
    [adavailability] VARCHAR(64) NULL,
    [adlocation] VARCHAR(64) NULL,
    [adVIN] VARCHAR(17) NULL,
    [featured_inventory] VARCHAR(256) NULL,
    [admiles] VARCHAR(12) NULL,
    [adprice] VARCHAR(12) NULL,
    [adstock] VARCHAR(64) NULL,
    [adtransmission] VARCHAR(128) NULL,
    [fuel_economy] VARCHAR(24) NULL,
    [addrivetrain] VARCHAR(64) NULL,
    [adengine] VARCHAR(128) NULL,
    [adexteriorcolor] VARCHAR(128) NULL,
    [adinteriorcolor] VARCHAR(128) NULL,
    [admpg] VARCHAR(128) NULL,
    [advertised_specials] VARCHAR(64) NULL,
    [adtext] VARCHAR(8000) NULL,
    [adoptions] VARCHAR(128) NULL,
    [adVDP] VARCHAR(200) NULL,
    [latitude] VARCHAR(128) NULL,
    [longitude] VARCHAR(64) NULL,
    [adother_comments] VARCHAR(200) NULL,
    [adimages] VARCHAR(MAX) NULL,
    [adVURL] VARCHAR(512) NULL,
    [adcityMPG] VARCHAR(128) NULL,
    [adhighwayMPG] VARCHAR(128) NULL,
    [secondary_title] VARCHAR(64) NULL,
    [car_sold] VARCHAR(64) NULL,
    [metadesc] VARCHAR(64) NULL,
    [title] VARCHAR(64) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [PDFEDITION] (
    [PDFEDID] INT NOT NULL -- PK,
    [PDFNAME] VARCHAR(128) NOT NULL,
    [PUBID] INT NOT NULL
);

CREATE TABLE [pennysaverExport] (
    [id] VARCHAR(10) NULL,
    [category_id] VARCHAR(12) NULL,
    [headline] VARCHAR(256) NULL,
    [body] VARCHAR(4000) NULL,
    [zip] VARCHAR(10) NULL,
    [redirect_url] VARCHAR(512) NULL,
    [photo_url] VARCHAR(512) NULL
);

CREATE TABLE [PHOTOSTOPS] (
    [PSID] INT NOT NULL -- PK,
    [PSNAME] VARCHAR(64) NOT NULL,
    [PSADDR] VARCHAR(64) NOT NULL,
    [PSCITY] VARCHAR(32) NOT NULL,
    [PSSTATE] VARCHAR(2) NOT NULL,
    [PSZIP] VARCHAR(5) NOT NULL,
    [PSPHONE] VARCHAR(16) NULL,
    [PSNOTE] VARCHAR(255) NULL,
    [PUBID] INT NOT NULL
);

CREATE TABLE [PlatformAutoAds] (
    [dirID] VARCHAR(12) NULL,
    [adID] VARCHAR(12) NULL,
    [adStock] VARCHAR(32) NULL,
    [adVIN] VARCHAR(19) NULL,
    [adSection] VARCHAR(23) NULL,
    [adType] VARCHAR(10) NULL,
    [adCertified] VARCHAR(12) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(32) NULL,
    [adSubModel] VARCHAR(128) NULL,
    [adYear] VARCHAR(1000) NULL,
    [adMiles] VARCHAR(10) NULL,
    [adColor] VARCHAR(4000) NULL,
    [adCondition] VARCHAR(10) NULL,
    [adHeadline] VARCHAR(32) NULL,
    [adText] VARCHAR(4096) NULL,
    [adCustomText] VARCHAR(4096) NULL,
    [adPrice] VARCHAR(10) NULL,
    [adPhone] VARCHAR(16) NULL,
    [adPics] VARCHAR(4096) NULL
);

CREATE TABLE [PRCOAds] (
    [dlrid] VARCHAR(32) NULL,
    [dlrName] VARCHAR(32) NULL,
    [dlrAddr] VARCHAR(128) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZip] VARCHAR(10) NULL,
    [dlrPhone] VARCHAR(18) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrURL] VARCHAR(512) NULL,
    [dlrLogo] VARCHAR(128) NULL,
    [adStock] VARCHAR(32) NULL,
    [adYear] VARCHAR(4) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(32) NULL,
    [adTrim] VARCHAR(64) NULL,
    [adVIN] VARCHAR(32) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adPrice] VARCHAR(10) NULL,
    [adExtColor] VARCHAR(64) NULL,
    [adIntColor] VARCHAR(64) NULL,
    [adTransmission] VARCHAR(128) NULL,
    [adPics] VARCHAR(6500) NULL,
    [adDescription] VARCHAR(6500) NULL,
    [adOptions] VARCHAR(6500) NULL,
    [adEngineType] VARCHAR(64) NULL,
    [adDriveType] VARCHAR(64) NULL,
    [id] INT NOT NULL,
    [adSection] VARCHAR(64) NULL
);

CREATE TABLE [PremiumAutoCustomers] (
    [dlrID] VARCHAR(32) NULL,
    [dlrName] VARCHAR(32) NULL,
    [dlrAddr] VARCHAR(128) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZip] VARCHAR(10) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrURL] VARCHAR(512) NULL,
    [dlrPhone] VARCHAR(18) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [PremiumAutoData] (
    [dlrID] VARCHAR(32) NULL,
    [adID] VARCHAR(32) NULL,
    [adStock] VARCHAR(32) NULL,
    [adVIN] VARCHAR(32) NULL,
    [adSection] VARCHAR(32) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(64) NULL,
    [adSubModel] VARCHAR(64) NULL,
    [adYear] VARCHAR(32) NULL,
    [adMiles] VARCHAR(32) NULL,
    [adColor] VARCHAR(6500) NULL,
    [adHeadline] VARCHAR(1024) NULL,
    [adText] VARCHAR(8000) NULL,
    [adPrice] VARCHAR(24) NULL,
    [adPhone] VARCHAR(18) NULL,
    [adPics] VARCHAR(8000) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [PriceType] (
    [PRICETYPEID] INT NOT NULL -- PK,
    [PRICETYPE] VARCHAR(20) NOT NULL,
    [PRICETYPEDESC] VARCHAR(30) NOT NULL
);

CREATE TABLE [PromaxAds] (
    [dealership] VARCHAR(32) NULL,
    [location] VARCHAR(64) NULL,
    [vin] VARCHAR(32) NULL,
    [stockno] VARCHAR(32) NULL,
    [newused] VARCHAR(1) NULL,
    [modelyear] VARCHAR(4) NULL,
    [make] VARCHAR(64) NULL,
    [model] VARCHAR(64) NULL,
    [style] VARCHAR(64) NULL,
    [class] VARCHAR(12) NULL,
    [mileage] VARCHAR(12) NULL,
    [color] VARCHAR(64) NULL,
    [msrp] VARCHAR(12) NULL,
    [listprice] VARCHAR(12) NULL,
    [saleprice] VARCHAR(12) NULL,
    [description] VARCHAR(MAX) NULL,
    [options] VARCHAR(4000) NULL,
    [images] VARCHAR(MAX) NULL,
    [dlrid] VARCHAR(32) NULL,
    [id] INT NOT NULL,
    [cat] INT NULL
);

CREATE TABLE [PromoPixAds] (
    [dlrid] VARCHAR(32) NULL,
    [dlrname] VARCHAR(32) NULL,
    [adcondition] VARCHAR(32) NULL,
    [advin] VARCHAR(32) NULL,
    [adyear] VARCHAR(32) NULL,
    [admake] VARCHAR(32) NULL,
    [admodel] VARCHAR(32) NULL,
    [adsubmodel] VARCHAR(64) NULL,
    [adprice] VARCHAR(32) NULL,
    [adcertified] VARCHAR(32) NULL,
    [adtext] VARCHAR(6500) NULL,
    [doors] VARCHAR(32) NULL,
    [drivetrain] VARCHAR(32) NULL,
    [engine] VARCHAR(32) NULL,
    [transmission] VARCHAR(32) NULL,
    [exteriorcolor] VARCHAR(64) NULL,
    [interiorcolor] VARCHAR(64) NULL,
    [options] VARCHAR(6500) NULL,
    [adpics] VARCHAR(6500) NULL,
    [id] INT NOT NULL,
    [adsection] VARCHAR(128) NULL
);

CREATE TABLE [ProofLock] (
    [MEMID] INT NOT NULL,
    [SUBID] INT NOT NULL -- PK,
    [PROOFTIME] DATETIME NOT NULL -- PK,
    [PROOFSTATE] INT NOT NULL
);

CREATE TABLE [ProProdata] (
    [stocknumber] VARCHAR(24) NULL,
    [year] VARCHAR(4) NULL,
    [make] VARCHAR(32) NULL,
    [model] VARCHAR(64) NULL,
    [trim] VARCHAR(64) NULL,
    [vinnumber] VARCHAR(17) NULL,
    [mileage] VARCHAR(10) NULL,
    [price] VARCHAR(7) NULL,
    [exteriorcolor] VARCHAR(24) NULL,
    [interiorcolor] VARCHAR(24) NULL,
    [transmissiondescription] VARCHAR(64) NULL,
    [imageurls] VARCHAR(4000) NULL,
    [description] VARCHAR(4000) NULL,
    [vehiclecategory] VARCHAR(64) NULL,
    [enginedescription] VARCHAR(64) NULL,
    [drivetrain] VARCHAR(64) NULL,
    [fueltype] VARCHAR(24) NULL,
    [dlrid] VARCHAR(2400) NULL
);

CREATE TABLE [proprodealers] (
    [dlrID] VARCHAR(32) NULL,
    [dlrName] VARCHAR(32) NULL,
    [dlrAddr] VARCHAR(128) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZip] VARCHAR(10) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrURL] VARCHAR(512) NULL,
    [dlrPhone] VARCHAR(18) NULL,
    [dlrFileName] VARCHAR(128) NULL,
    [active] BIT NOT NULL
);

CREATE TABLE [ProxyCrawlers] (
    [Domain] VARCHAR(256) NOT NULL,
    [Account] VARCHAR(64) NOT NULL,
    [Feed_Deactivation] DATE NULL,
    [Crawler_Status] INT NOT NULL,
    [Using_Proxy] BIT NULL
);

CREATE TABLE [PSNAds] (
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(32) NULL,
    [dlrState] VARCHAR(2) NULL,
    [dlrZIP] VARCHAR(5) NULL,
    [dlrPhone] VARCHAR(12) NULL,
    [dlrEmail] VARCHAR(42) NULL,
    [adid] VARCHAR(64) NULL,
    [admvdp] VARCHAR(256) NULL,
    [adVIN] VARCHAR(17) NULL,
    [adStock] VARCHAR(50) NULL,
    [adcat] VARCHAR(128) NULL,
    [adtype] VARCHAR(128) NULL,
    [adcattype] VARCHAR(128) NULL,
    [adyear] VARCHAR(64) NULL,
    [adManufacturer] VARCHAR(128) NULL,
    [adMake] VARCHAR(128) NULL,
    [adModel] VARCHAR(128) NULL,
    [adcondition] VARCHAR(128) NULL,
    [adexteriorcolor] VARCHAR(128) NULL,
    [adexteriorcolor2] VARCHAR(128) NULL,
    [adprice] VARCHAR(64) NULL,
    [admiles] VARCHAR(64) NULL,
    [addisplacement] VARCHAR(128) NULL,
    [addescription] VARCHAR(8000) NULL,
    [addescriptionlong] VARCHAR(8000) NULL,
    [adimages] VARCHAR(MAX) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [psncategories] (
    [psncid] INT NOT NULL -- PK,
    [psncategory] VARCHAR(100) NOT NULL,
    [tmpcategory] VARCHAR(100) NOT NULL
);

CREATE TABLE [psndealers] (
    [dlr_id] VARCHAR(32) NULL,
    [dlr_vendorcode] VARCHAR(32) NULL,
    [dlr_name] VARCHAR(64) NULL,
    [dlr_address1] VARCHAR(64) NULL,
    [dlr_city] VARCHAR(32) NULL,
    [dlr_state] VARCHAR(32) NULL,
    [dlr_postalcode] VARCHAR(32) NULL,
    [dlr_country] VARCHAR(32) NULL,
    [dlr_phone] VARCHAR(32) NULL,
    [dlr_tollfreephone] VARCHAR(32) NULL,
    [dlr_fax] VARCHAR(32) NULL,
    [dlr_email] VARCHAR(32) NULL,
    [dlr_url] VARCHAR(32) NULL
);

CREATE TABLE [psnimages] (
    [dlr_id] VARCHAR(32) NULL,
    [lst_id] VARCHAR(32) NULL,
    [lst_url] VARCHAR(512) NULL,
    [lst_displayorder] VARCHAR(32) NULL,
    [lst_mimetype] VARCHAR(32) NULL
);

CREATE TABLE [psnlistings] (
    [dlr_id] VARCHAR(32) NULL,
    [lst_id] VARCHAR(32) NULL,
    [lst_category] VARCHAR(32) NULL,
    [lst_type] VARCHAR(32) NULL,
    [lst_cattype] VARCHAR(32) NULL,
    [lst_manufacturer] VARCHAR(32) NULL,
    [lst_brand] VARCHAR(32) NULL,
    [lst_modelyear] VARCHAR(32) NULL,
    [lst_model] VARCHAR(32) NULL,
    [lst_location] VARCHAR(32) NULL,
    [lst_address1] VARCHAR(64) NULL,
    [lst_city] VARCHAR(32) NULL,
    [lst_state] VARCHAR(32) NULL,
    [lst_postalcode] VARCHAR(32) NULL,
    [lst_country] VARCHAR(32) NULL,
    [lst_phone] VARCHAR(32) NULL,
    [lst_condition] VARCHAR(32) NULL,
    [lst_colorprimary] VARCHAR(32) NULL,
    [lst_colorsecondary] VARCHAR(32) NULL,
    [lst_price] VARCHAR(32) NULL,
    [lst_displacement] VARCHAR(32) NULL,
    [lst_miles] VARCHAR(32) NULL,
    [lst_vin] VARCHAR(32) NULL,
    [lst_stock] VARCHAR(32) NULL,
    [lst_descriptionshort] VARCHAR(32) NULL,
    [lst_descriptionlong] VARCHAR(4096) NULL,
    [lst_listingurl] VARCHAR(512) NULL
);

CREATE TABLE [PSNPhotos] (
    [adid] VARCHAR(64) NULL,
    [imgurl] VARCHAR(512) NULL,
    [imgsort] VARCHAR(64) NULL
);

CREATE TABLE [psnspecifications] (
    [dlr_id] VARCHAR(32) NULL,
    [lst_id] VARCHAR(32) NULL,
    [lst_specificationname] VARCHAR(32) NULL,
    [lst_specificationvalue] VARCHAR(32) NULL
);

CREATE TABLE [PUBEDITIONS] (
    [PUBID] INT NOT NULL -- PK,
    [EDID] INT NOT NULL -- PK
);

CREATE TABLE [PubExpiring] (
    [expID] INT NOT NULL -- PK,
    [pubID] INT NOT NULL,
    [webID] INT NOT NULL,
    [expB4DL] SMALLINT NOT NULL,
    [expRenewalDay] VARCHAR(256) NOT NULL,
    [expSlogan] VARCHAR(128) NOT NULL,
    [expAdQuantity] VARCHAR(128) NOT NULL,
    [expPhone] VARCHAR(16) NOT NULL,
    [insDays] SMALLINT NOT NULL,
    [xfrUploadPath] VARCHAR(128) NULL,
    [xfrDrive] VARCHAR(2) NULL,
    [xfrEndeavorShare] VARCHAR(32) NULL,
    [xfrEndeavorPath] VARCHAR(32) NULL,
    [xfrMailTo] VARCHAR(128) NULL,
    [expHoliday] VARCHAR(256) NULL,
    [deflqStatusID] INT NOT NULL,
    [PullSaleNotPag] BIT NOT NULL,
    [useVISA] BIT NULL,
    [useMC] BIT NULL,
    [useDISC] BIT NULL,
    [useAMEX] BIT NULL
);

CREATE TABLE [PUBLICATIONS] (
    [PUBID] INT NOT NULL -- PK,
    [PUBNAME] VARCHAR(64) NOT NULL,
    [PUBURL] VARCHAR(512) NULL,
    [PUBIP] VARCHAR(32) NOT NULL,
    [PUBDB] VARCHAR(16) NOT NULL,
    [PUBSERVER] VARCHAR(16) NULL,
    [PUBLOGDIR] VARCHAR(32) NULL,
    [PUBSOURCEID] INT NULL,
    [PUBINITIAL] VARCHAR(16) NULL,
    [PUBJOBINITIAL] VARCHAR(8) NULL,
    [WEBPICPATH] VARCHAR(512) NULL,
    [UPLOADPICPATH] VARCHAR(512) NULL,
    [WEBPICURL] VARCHAR(512) NULL,
    [ReportSrcID] INT NULL
);

CREATE TABLE [PubStates] (
    [PubID] INT NOT NULL -- PK,
    [State] VARCHAR(2) NOT NULL -- PK
);

CREATE TABLE [Ratchet_FeedSubmitted_Log] (
    [rfslID] INT NOT NULL,
    [NewffID] INT NULL,
    [OldffID] INT NULL,
    [Body] TEXT NULL,
    [newagg] INT NULL,
    [formtypeid] INT NULL,
    [ffDelayedStartRequested] BIT NULL,
    [ffDateDelayedStart] VARCHAR(10) NULL,
    [Received] DATETIME NULL,
    [Sent] DATETIME NULL
);

CREATE TABLE [Ratchet_Insert_Form_Log] (
    [acc_id_submitted] INT NULL,
    [acc_id_submitted_event] INT NULL,
    [aso_id] INT NULL,
    [ftID] INT NULL,
    [ffDateSold] DATETIME NULL,
    [acc_id_rep] INT NULL,
    [ffID] INT NULL,
    [ffIDMaster] INT NULL,
    [ffCusID] INT NULL,
    [ffwName] VARCHAR(64) NULL,
    [ffwAddress1] VARCHAR(64) NULL,
    [ffwAddress2] VARCHAR(64) NULL,
    [ffwCity] VARCHAR(32) NULL,
    [ffwState] VARCHAR(2) NULL,
    [ffwZip] VARCHAR(10) NULL,
    [ffwPhone] VARCHAR(16) NULL,
    [ffwURL] VARCHAR(512) NULL,
    [ffwEmail_String] VARCHAR(96) NULL,
    [ffwEmail_XML] VARCHAR(96) NULL,
    [ffwEmail_Contact] VARCHAR(96) NULL,
    [ffbCompany] VARCHAR(64) NULL,
    [ffbContact] VARCHAR(64) NULL,
    [ffbAddress1] VARCHAR(64) NULL,
    [ffbAddress2] VARCHAR(64) NULL,
    [ffbCity] VARCHAR(32) NULL,
    [ffbState] VARCHAR(2) NULL,
    [ffbZip] VARCHAR(10) NULL,
    [ffbPhone] VARCHAR(16) NULL,
    [ffbEmail] VARCHAR(96) NULL,
    [ffPrice] MONEY NULL,
    [fiID] INT NULL,
    [ffAggregatorName] VARCHAR(64) NULL,
    [ffAggregatorContact] VARCHAR(64) NULL,
    [ffAggregatorAddress] VARCHAR(64) NULL,
    [ffAggregatorPhone] VARCHAR(16) NULL,
    [ffAggregatorEmail] VARCHAR(96) NULL,
    [ffNotes] VARCHAR(8000) NULL,
    [ffDateOfEvent] DATETIME NULL,
    [ffTrackingNumber] VARCHAR(16) NULL,
    [ffDelayedStartRequested] BIT NULL,
    [ffDateDelayedStart] VARCHAR(10) NULL,
    [ffwContact_Name] VARCHAR(255) NULL,
    [ffFirstMonthPrice] MONEY NULL,
    [ffLastMonthPrice] MONEY NULL,
    [rdg_ID] INT NULL,
    [ffExcludeRAN] BIT NULL,
    [ffExcludeRCY] BIT NULL,
    [ffoHeader] VARCHAR(256) NULL,
    [ffoFooter] VARCHAR(256) NULL,
    [ffDateEnd] DATETIME NULL,
    [ffOngoing] BIT NULL
);

CREATE TABLE [RatchetCheck] (
    [ffid] INT NOT NULL,
    [ffIDMaster] INT NOT NULL,
    [ffDateOfEvent] DATETIME NULL,
    [ftID] INT NOT NULL,
    [ftName] VARCHAR(32) NOT NULL,
    [ffcusid] INT NULL,
    [fduid] INT NULL,
    [ffwName] VARCHAR(64) NULL,
    [ffAggregatorName] VARCHAR(64) NULL,
    [ffaActive] FLOAT NULL,
    [fdid] VARCHAR(32) NOT NULL,
    [fdimg4] VARCHAR(512) NULL,
    [fdcusid] INT NOT NULL,
    [fdname] VARCHAR(64) NOT NULL,
    [dlrid] INT NULL,
    [fmActive] BIT NOT NULL,
    [fmCusID] INT NULL,
    [fmDeactivateOn] DATE NULL
);

CREATE TABLE [RatchetCombined] (
    [fduid] INT NOT NULL,
    [dlrid] INT NULL,
    [fdname] VARCHAR(64) NOT NULL,
    [fdcusid] INT NOT NULL,
    [Aggregator] VARCHAR(128) NOT NULL,
    [ffprice] MONEY NULL,
    [adname] VARCHAR(128) NULL,
    [pubdb] VARCHAR(16) NULL,
    [pubname] VARCHAR(64) NOT NULL,
    [FirstUpload] DATETIME NULL,
    [LastUpload] DATETIME NULL,
    [ActiveAds] FLOAT NULL
);

CREATE TABLE [RatchetDeactivationReasons] (
    [rdrid] INT NOT NULL -- PK,
    [rdrname] VARCHAR(128) NOT NULL,
    [rdractive] BIT NOT NULL
);

CREATE TABLE [RatchetDeactivations] (
    [rdid] INT NOT NULL -- PK,
    [ffid] INT NOT NULL,
    [rdrid] INT NOT NULL,
    [explanation] VARCHAR(200) NOT NULL,
    [createddate] SMALLDATETIME NOT NULL,
    [createdbyaccid] INT NOT NULL
);

CREATE TABLE [RatchetDealerGroups] (
    [rdg_ID] INT NOT NULL -- PK,
    [rdg_Name] VARCHAR(64) NOT NULL,
    [rdg_City] VARCHAR(32) NOT NULL,
    [rdg_State] VARCHAR(2) NOT NULL,
    [rdg_Dealerships] INT NOT NULL
);

CREATE TABLE [RatchetDestinations] (
    [ffID] INT NOT NULL -- PK,
    [DestID] INT NOT NULL -- PK,
    [fdValue] MONEY NOT NULL
);

CREATE TABLE [RatchetFeedMigration] (
    [ffIDMaster] INT NULL,
    [SubscriptionId] INT NOT NULL
);

CREATE TABLE [RatchetFeedTracker] (
    [ffID] INT NOT NULL -- PK,
    [acc_ID_Submitted] INT NULL,
    [acc_ID_Submitted_Event] INT NULL,
    [ffDateSubmitted] DATETIME NULL,
    [aso_ID] INT NULL,
    [ftID] INT NULL,
    [ffDateSold] DATETIME NULL,
    [ffIDMaster] INT NULL,
    [ffCusID] INT NULL,
    [ffwName] VARCHAR(64) NULL,
    [acc_ID_Rep] INT NULL,
    [ffwAddress1] VARCHAR(64) NULL,
    [ffwAddress2] VARCHAR(64) NULL,
    [ffwCity] VARCHAR(32) NULL,
    [ffwState] VARCHAR(2) NULL,
    [ffwZip] VARCHAR(10) NULL,
    [ffwPhone] VARCHAR(16) NULL,
    [ffwURL] VARCHAR(512) NULL,
    [ffwEmail_String] VARCHAR(96) NULL,
    [ffwEmail_XML] VARCHAR(96) NULL,
    [ffwEmail_Contact] VARCHAR(96) NULL,
    [ffbCompany] VARCHAR(64) NULL,
    [ffbContact] VARCHAR(64) NULL,
    [ffbAddress1] VARCHAR(64) NULL,
    [ffbAddress2] VARCHAR(64) NULL,
    [ffbCity] VARCHAR(32) NULL,
    [ffbState] VARCHAR(2) NULL,
    [ffbZip] VARCHAR(10) NULL,
    [ffbPhone] VARCHAR(16) NULL,
    [ffbEmail] VARCHAR(96) NULL,
    [ffPrice] MONEY NULL,
    [fiID] INT NULL,
    [ffAggregatorName] VARCHAR(64) NULL,
    [ffAggregatorContact] VARCHAR(64) NULL,
    [ffAggregatorAddress] VARCHAR(64) NULL,
    [ffAggregatorPhone] VARCHAR(16) NULL,
    [ffAggregatorEmail] VARCHAR(96) NULL,
    [ffNotes] VARCHAR(8000) NULL,
    [ffDateOfEvent] DATETIME NULL,
    [ffDateAggregatorContact] DATETIME NULL,
    [ffDateAggregatorETAConnect] DATETIME NULL,
    [ffDateLive] DATETIME NULL,
    [ffDateOFReqSent] DATETIME NULL,
    [ffDateOFLive] DATETIME NULL,
    [ffDateSalesLiveQA] DATETIME NULL,
    [ffDateSalesOFQA] DATETIME NULL,
    [fsID] INT NULL,
    [wmtID] INT NULL,
    [fduid] INT NULL,
    [ffTrackingNumber] VARCHAR(16) NULL,
    [ffwContact_Name] VARCHAR(255) NULL,
    [ffFirstMonthPrice] MONEY NULL,
    [ffLastMonthPrice] MONEY NULL,
    [rdg_ID] INT NOT NULL,
    [ffExcludeRAN] BIT NULL,
    [ffExcludeRCY] BIT NULL,
    [ffoHeader] VARCHAR(256) NULL,
    [ffoFooter] VARCHAR(256) NULL,
    [ffDelayedStartRequested] BIT NULL,
    [ffDateDelayedStart] VARCHAR(10) NULL,
    [ffDateEnd] DATETIME NULL
);

CREATE TABLE [ratchetfeedtracker_bu] (
    [ffID] INT NOT NULL,
    [acc_ID_Submitted] INT NULL,
    [acc_ID_Submitted_Event] INT NULL,
    [ffDateSubmitted] DATETIME NULL,
    [aso_ID] INT NULL,
    [ftID] INT NULL,
    [ffDateSold] DATETIME NULL,
    [ffIDMaster] INT NULL,
    [ffCusID] INT NULL,
    [ffwName] VARCHAR(64) NULL,
    [acc_ID_Rep] INT NULL,
    [ffwAddress1] VARCHAR(64) NULL,
    [ffwAddress2] VARCHAR(64) NULL,
    [ffwCity] VARCHAR(32) NULL,
    [ffwState] VARCHAR(2) NULL,
    [ffwZip] VARCHAR(10) NULL,
    [ffwPhone] VARCHAR(16) NULL,
    [ffwURL] VARCHAR(512) NULL,
    [ffwEmail_String] VARCHAR(96) NULL,
    [ffwEmail_XML] VARCHAR(96) NULL,
    [ffwEmail_Contact] VARCHAR(96) NULL,
    [ffbCompany] VARCHAR(64) NULL,
    [ffbContact] VARCHAR(64) NULL,
    [ffbAddress1] VARCHAR(64) NULL,
    [ffbAddress2] VARCHAR(64) NULL,
    [ffbCity] VARCHAR(32) NULL,
    [ffbState] VARCHAR(2) NULL,
    [ffbZip] VARCHAR(10) NULL,
    [ffbPhone] VARCHAR(16) NULL,
    [ffbEmail] VARCHAR(96) NULL,
    [ffPrice] MONEY NULL,
    [fiID] INT NULL,
    [ffAggregatorName] VARCHAR(64) NULL,
    [ffAggregatorContact] VARCHAR(64) NULL,
    [ffAggregatorAddress] VARCHAR(64) NULL,
    [ffAggregatorPhone] VARCHAR(16) NULL,
    [ffAggregatorEmail] VARCHAR(96) NULL,
    [ffNotes] VARCHAR(8000) NULL,
    [ffDateOfEvent] DATETIME NULL,
    [ffDateAggregatorContact] DATETIME NULL,
    [ffDateAggregatorETAConnect] DATETIME NULL,
    [ffDateLive] DATETIME NULL,
    [ffDateOFReqSent] DATETIME NULL,
    [ffDateOFLive] DATETIME NULL,
    [ffDateSalesLiveQA] DATETIME NULL,
    [ffDateSalesOFQA] DATETIME NULL,
    [fsID] INT NULL,
    [wmtID] INT NULL,
    [fduid] INT NULL,
    [ffTrackingNumber] VARCHAR(16) NULL,
    [ffwContact_Name] VARCHAR(255) NULL,
    [ffFirstMonthPrice] MONEY NULL,
    [ffLastMonthPrice] MONEY NULL,
    [rdg_ID] INT NOT NULL,
    [ffExcludeRAN] BIT NULL,
    [ffExcludeRCY] BIT NULL,
    [ffoHeader] VARCHAR(256) NULL,
    [ffoFooter] VARCHAR(256) NULL,
    [ffDelayedStartRequested] BIT NULL,
    [ffDateDelayedStart] VARCHAR(10) NULL
);

CREATE TABLE [RatchetFeedTracker_Dupes] (
    [ffID] INT NOT NULL,
    [acc_ID_Submitted] INT NULL,
    [acc_ID_Submitted_Event] INT NULL,
    [ffDateSubmitted] DATETIME NULL,
    [aso_ID] INT NULL,
    [ftID] INT NULL,
    [ffDateSold] DATETIME NULL,
    [ffIDMaster] INT NULL,
    [ffCusID] INT NULL,
    [ffwName] VARCHAR(64) NULL,
    [acc_ID_Rep] INT NULL,
    [ffwAddress1] VARCHAR(64) NULL,
    [ffwAddress2] VARCHAR(64) NULL,
    [ffwCity] VARCHAR(32) NULL,
    [ffwState] VARCHAR(2) NULL,
    [ffwZip] VARCHAR(10) NULL,
    [ffwPhone] VARCHAR(16) NULL,
    [ffwURL] VARCHAR(512) NULL,
    [ffwEmail_String] VARCHAR(96) NULL,
    [ffwEmail_XML] VARCHAR(96) NULL,
    [ffwEmail_Contact] VARCHAR(96) NULL,
    [ffbCompany] VARCHAR(64) NULL,
    [ffbContact] VARCHAR(64) NULL,
    [ffbAddress1] VARCHAR(64) NULL,
    [ffbAddress2] VARCHAR(64) NULL,
    [ffbCity] VARCHAR(32) NULL,
    [ffbState] VARCHAR(2) NULL,
    [ffbZip] VARCHAR(10) NULL,
    [ffbPhone] VARCHAR(16) NULL,
    [ffbEmail] VARCHAR(96) NULL,
    [ffPrice] MONEY NULL,
    [fiID] INT NULL,
    [ffAggregatorName] VARCHAR(64) NULL,
    [ffAggregatorContact] VARCHAR(64) NULL,
    [ffAggregatorAddress] VARCHAR(64) NULL,
    [ffAggregatorPhone] VARCHAR(16) NULL,
    [ffAggregatorEmail] VARCHAR(96) NULL,
    [ffNotes] VARCHAR(8000) NULL,
    [ffDateOfEvent] DATETIME NULL,
    [ffDateAggregatorContact] DATETIME NULL,
    [ffDateAggregatorETAConnect] DATETIME NULL,
    [ffDateLive] DATETIME NULL,
    [ffDateOFReqSent] DATETIME NULL,
    [ffDateOFLive] DATETIME NULL,
    [ffDateSalesLiveQA] DATETIME NULL,
    [ffDateSalesOFQA] DATETIME NULL,
    [fsID] INT NULL,
    [wmtID] INT NULL,
    [fduid] INT NULL,
    [ffTrackingNumber] VARCHAR(16) NULL,
    [ffwContact_Name] VARCHAR(255) NULL,
    [ffFirstMonthPrice] MONEY NULL,
    [ffLastMonthPrice] MONEY NULL,
    [rdg_ID] INT NOT NULL,
    [ffExcludeRAN] BIT NULL,
    [ffExcludeRCY] BIT NULL,
    [ffoHeader] VARCHAR(256) NULL,
    [ffoFooter] VARCHAR(256) NULL,
    [ffDelayedStartRequested] BIT NULL,
    [ffDateDelayedStart] VARCHAR(10) NULL,
    [ffDateEnd] DATETIME NULL
);

CREATE TABLE [RatchetFeedTracker_Save_AdEzReSubmit] (
    [ffID] INT NOT NULL,
    [acc_ID_Submitted] INT NULL,
    [acc_ID_Submitted_Event] INT NULL,
    [ffDateSubmitted] DATETIME NULL,
    [aso_ID] INT NULL,
    [ftID] INT NULL,
    [ffDateSold] DATETIME NULL,
    [ffIDMaster] INT NULL,
    [ffCusID] INT NULL,
    [ffwName] VARCHAR(64) NULL,
    [acc_ID_Rep] INT NULL,
    [ffwAddress1] VARCHAR(64) NULL,
    [ffwAddress2] VARCHAR(64) NULL,
    [ffwCity] VARCHAR(32) NULL,
    [ffwState] VARCHAR(2) NULL,
    [ffwZip] VARCHAR(10) NULL,
    [ffwPhone] VARCHAR(16) NULL,
    [ffwURL] VARCHAR(512) NULL,
    [ffwEmail_String] VARCHAR(96) NULL,
    [ffwEmail_XML] VARCHAR(96) NULL,
    [ffwEmail_Contact] VARCHAR(96) NULL,
    [ffbCompany] VARCHAR(64) NULL,
    [ffbContact] VARCHAR(64) NULL,
    [ffbAddress1] VARCHAR(64) NULL,
    [ffbAddress2] VARCHAR(64) NULL,
    [ffbCity] VARCHAR(32) NULL,
    [ffbState] VARCHAR(2) NULL,
    [ffbZip] VARCHAR(10) NULL,
    [ffbPhone] VARCHAR(16) NULL,
    [ffbEmail] VARCHAR(96) NULL,
    [ffPrice] MONEY NULL,
    [fiID] INT NULL,
    [ffAggregatorName] VARCHAR(64) NULL,
    [ffAggregatorContact] VARCHAR(64) NULL,
    [ffAggregatorAddress] VARCHAR(64) NULL,
    [ffAggregatorPhone] VARCHAR(16) NULL,
    [ffAggregatorEmail] VARCHAR(96) NULL,
    [ffNotes] VARCHAR(8000) NULL,
    [ffDateOfEvent] DATETIME NULL,
    [ffDateAggregatorContact] DATETIME NULL,
    [ffDateAggregatorETAConnect] DATETIME NULL,
    [ffDateLive] DATETIME NULL,
    [ffDateOFReqSent] DATETIME NULL,
    [ffDateOFLive] DATETIME NULL,
    [ffDateSalesLiveQA] DATETIME NULL,
    [ffDateSalesOFQA] DATETIME NULL,
    [fsID] INT NULL,
    [wmtID] INT NULL,
    [fduid] INT NULL,
    [ffTrackingNumber] VARCHAR(16) NULL,
    [ffwContact_Name] VARCHAR(255) NULL,
    [ffFirstMonthPrice] MONEY NULL,
    [ffLastMonthPrice] MONEY NULL,
    [rdg_ID] INT NOT NULL,
    [ffExcludeRAN] BIT NULL,
    [ffExcludeRCY] BIT NULL,
    [ffoHeader] VARCHAR(256) NULL,
    [ffoFooter] VARCHAR(256) NULL,
    [ffDelayedStartRequested] BIT NULL,
    [ffDateDelayedStart] VARCHAR(10) NULL
);

CREATE TABLE [RatchetFormActive] (
    [ffaID] INT NOT NULL -- PK,
    [ffID] INT NOT NULL,
    [ffaActive] BIT NOT NULL,
    [ffaLastModified] DATETIME NOT NULL,
    [ffaUser] VARCHAR(64) NOT NULL
);

CREATE TABLE [RatchetFormStatus] (
    [fsID] INT NOT NULL -- PK,
    [fsName] VARCHAR(32) NULL,
    [fsSort] INT NULL,
    [fsActive] BIT NULL
);

CREATE TABLE [RatchetFormTypes] (
    [ftID] INT NOT NULL -- PK,
    [ftName] VARCHAR(32) NOT NULL,
    [ftSort] INT NOT NULL,
    [ftActive] BIT NOT NULL,
    [ftDisplay] BIT NULL,
    [ftLocal] BIT NULL
);

CREATE TABLE [RatchetInsertLog] (
    [ril_ID] INT NOT NULL -- PK,
    [FFID_Old] INT NULL,
    [FFID_New] INT NULL,
    [ril_Start] DATETIME NOT NULL,
    [ril_End] DATETIME NULL
);

CREATE TABLE [RatchetInventory] (
    [fiID] INT NOT NULL -- PK,
    [fiName] VARCHAR(32) NOT NULL,
    [fiValue] INT NOT NULL,
    [fiSort] INT NOT NULL,
    [fiActive] BIT NOT NULL,
    [PerformancePro] BIT NULL
);

CREATE TABLE [RatchetUpsells] (
    [ffID] INT NOT NULL -- PK,
    [upID] INT NOT NULL -- PK,
    [fsValue] MONEY NOT NULL
);

CREATE TABLE [RatchetUserFix] (
    [ffid] INT NOT NULL,
    [ffidmaster] INT NULL,
    [OldCreated] VARCHAR(32) NOT NULL,
    [OldModified] VARCHAR(32) NULL,
    [OldRep] VARCHAR(32) NOT NULL,
    [srcid] INT NOT NULL,
    [pub_id] INT NULL,
    [caologin] VARCHAR(64) NULL,
    [caooffice] VARCHAR(128) NULL,
    [aso_id] INT NULL,
    [NewCreated] VARCHAR(40) NOT NULL,
    [NewModified] VARCHAR(40) NOT NULL,
    [NewRep] VARCHAR(40) NOT NULL
);

CREATE TABLE [RECEIPTS] (
    [RECID] INT NOT NULL -- PK,
    [MEMID] INT NOT NULL,
    [CARDID] INT NOT NULL,
    [PROCODE] VARCHAR(16) NOT NULL,
    [RECAMOUNT] MONEY NOT NULL,
    [RECDATE] DATETIME NOT NULL,
    [PCCHARGEID] VARCHAR(16) NOT NULL
);

CREATE TABLE [RedlineData] (
    [DLRID] VARCHAR(64) NULL,
    [DLRName] VARCHAR(64) NULL,
    [DLRaddress] VARCHAR(64) NULL,
    [DLRcity] VARCHAR(100) NULL,
    [DLRstate] VARCHAR(64) NULL,
    [DLRzip] VARCHAR(64) NULL,
    [DLRphone] VARCHAR(64) NULL,
    [ADVIN] VARCHAR(32) NULL,
    [ADSTOCK] VARCHAR(100) NULL,
    [ADYEAR] VARCHAR(12) NULL,
    [ADMAKE] VARCHAR(64) NULL,
    [ADMODEL] VARCHAR(64) NULL,
    [ADEXTCOLOR] VARCHAR(128) NULL,
    [ADINTCOLOR] VARCHAR(500) NULL,
    [MSRP] VARCHAR(10) NULL,
    [ADPRICE] VARCHAR(10) NULL,
    [ADPRICEInternet] VARCHAR(10) NULL,
    [INVOICE] VARCHAR(12) NULL,
    [ADMILES] VARCHAR(12) NULL,
    [ADENGINE] VARCHAR(256) NULL,
    [ADCYLINDERS] VARCHAR(64) NULL,
    [ADDISPLACEMENT] VARCHAR(512) NULL,
    [ADTRANSMISSION] VARCHAR(64) NULL,
    [ADCONDITION] VARCHAR(24) NULL,
    [ADTEXT] VARCHAR(MAX) NULL,
    [ADDATEINSTOCK] VARCHAR(64) NULL,
    [ADWHEELBASE] VARCHAR(32) NULL,
    [ADPICS] VARCHAR(MAX) NULL,
    [ADSUBMODEL] VARCHAR(64) NULL,
    [ADSECTION] VARCHAR(64) NULL,
    [ADCERTIFIED] VARCHAR(24) NULL,
    [ADMODELCODE] VARCHAR(64) NULL,
    [ADVIDEOURL] VARCHAR(100) NULL,
    [ADMPGCITY] VARCHAR(12) NULL,
    [ADMPGHWY] VARCHAR(12) NULL,
    [ADCARFAX] VARCHAR(12) NULL,
    [ADFUELTYPE] VARCHAR(128) NULL,
    [ADPHOTOLASTMODIFIED] VARCHAR(32) NULL,
    [ADDOORS] VARCHAR(12) NULL,
    [ADLOCATION] VARCHAR(24) NULL,
    [ADDRIVETRAIN] VARCHAR(32) NULL,
    [ADOPTIONS] VARCHAR(8000) NULL,
    [ADEQUIPMENT] VARCHAR(MAX) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [ReevesAds] (
    [dlrid] VARCHAR(32) NULL,
    [adID] VARCHAR(32) NULL,
    [adStock] VARCHAR(32) NULL,
    [adVIN] VARCHAR(32) NULL,
    [adSection] VARCHAR(32) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(64) NULL,
    [adSubModel] VARCHAR(64) NULL,
    [adYear] VARCHAR(12) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adColor] VARCHAR(64) NULL,
    [adCondition] VARCHAR(32) NULL,
    [adHeadline] VARCHAR(1024) NULL,
    [adText] VARCHAR(MAX) NULL,
    [adCustomText] VARCHAR(6500) NULL,
    [adPrice] VARCHAR(1000) NULL,
    [adPhone] VARCHAR(100) NULL,
    [adPics] VARCHAR(MAX) NULL
);

CREATE TABLE [ReevesAdsTemp] (
    [dlrid] VARCHAR(32) NULL,
    [adID] VARCHAR(32) NULL,
    [adStock] VARCHAR(32) NULL,
    [adVIN] VARCHAR(32) NULL,
    [adSection] VARCHAR(32) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(64) NULL,
    [adSubModel] VARCHAR(64) NULL,
    [adYear] VARCHAR(12) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adColor] VARCHAR(64) NULL,
    [adCondition] VARCHAR(32) NULL,
    [adHeadline] VARCHAR(1024) NULL,
    [adText] VARCHAR(MAX) NULL,
    [adCustomText] VARCHAR(6500) NULL,
    [adPrice] VARCHAR(1000) NULL,
    [adPhone] VARCHAR(100) NULL,
    [adPics] VARCHAR(MAX) NULL
);

CREATE TABLE [REFUNDS] (
    [refID] INT NOT NULL -- PK,
    [recID] INT NOT NULL,
    [refAmount] MONEY NOT NULL,
    [refDate] SMALLDATETIME NOT NULL,
    [refReason] VARCHAR(255) NOT NULL,
    [pcChargeID] VARCHAR(16) NULL,
    [refBy] VARCHAR(25) NOT NULL,
    [refCredit] BIT NOT NULL,
    [pubid] INT NOT NULL
);

CREATE TABLE [Regions] (
    [rgID] INT NOT NULL -- PK,
    [pubID] INT NOT NULL,
    [rgName] VARCHAR(32) NOT NULL
);

CREATE TABLE [ReportSource] (
    [srcID] INT NOT NULL -- PK,
    [srcName] VARCHAR(32) NOT NULL,
    [srcDBName] VARCHAR(32) NULL,
    [srcWCID] INT NOT NULL
);

CREATE TABLE [Reseller_Ord_Sub_Discrepancies] (
    [Subscription_ID] VARCHAR(12) NULL,
    [Cmp_ID] VARCHAR(12) NULL,
    [Sls_Channel] VARCHAR(64) NULL,
    [Bus_Name] VARCHAR(64) NULL,
    [Cmp_Name] VARCHAR(256) NULL,
    [Ord_ID] VARCHAR(12) NULL,
    [Order_Item_ID] VARCHAR(12) NULL,
    [Order_Item_Flt_ID] VARCHAR(12) NULL,
    [Sub_state] VARCHAR(24) NULL,
    [Ord_state] VARCHAR(24) NULL,
    [Cmp_state] VARCHAR(24) NULL,
    [Sub_start_date] VARCHAR(24) NULL,
    [Ord_start_date] VARCHAR(24) NULL,
    [Sub_End_Date] VARCHAR(24) NULL,
    [Ord_End_Date] VARCHAR(24) NULL,
    [Sub_Target_Impressions] VARCHAR(12) NULL,
    [Ord_Target_Impressions] VARCHAR(12) NULL
);

CREATE TABLE [ResellerCheckList] (
    [rcl_ID] INT NOT NULL -- PK,
    [fdUID] INT NOT NULL,
    [user_acc_ID] INT NOT NULL,
    [rcl_Completed] DATETIME NULL,
    [rcl_Deactivated] DATETIME NULL
);

CREATE TABLE [ResellerCheckListOptions] (
    [rco_ID] INT NOT NULL -- PK,
    [rco_Name] VARCHAR(64) NOT NULL,
    [rco_Sort] INT NOT NULL,
    [rco_Active] BIT NOT NULL
);

CREATE TABLE [ResellerCheckListSelected] (
    [rcl_ID] INT NOT NULL -- PK,
    [rco_ID] INT NOT NULL -- PK
);

CREATE TABLE [ReyReyData] (
    [LotId] INT NULL,
    [ExtLotId] VARCHAR(32) NULL,
    [Vin] VARCHAR(32) NULL,
    [Stock] VARCHAR(32) NULL,
    [adYear] VARCHAR(5) NULL,
    [adMake] VARCHAR(64) NULL,
    [adModel] VARCHAR(128) NULL,
    [InternetPrice] INT NULL,
    [ListPrice] INT NULL,
    [InvoicePrice] INT NULL,
    [eColor] VARCHAR(64) NULL,
    [iColor] VARCHAR(64) NULL,
    [Transmission] VARCHAR(64) NULL,
    [Trim] VARCHAR(128) NULL,
    [Engine] VARCHAR(64) NULL,
    [Odometer] INT NULL,
    [Cylinder] VARCHAR(32) NULL,
    [EngineFuelType] VARCHAR(128) NULL,
    [ModelNumber] VARCHAR(32) NULL,
    [BodyStyle] VARCHAR(128) NULL,
    [PhotoURL] VARCHAR(512) NULL,
    [Options] VARCHAR(2048) NULL,
    [NewUsed] VARCHAR(1) NULL
);

CREATE TABLE [RideDigitalAds] (
    [adid] VARCHAR(64) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(32) NULL,
    [dlrState] VARCHAR(12) NULL,
    [dlrZIP] VARCHAR(5) NULL,
    [dlrPhone] VARCHAR(16) NULL,
    [dlrEmail] VARCHAR(64) NULL,
    [admvdp] VARCHAR(256) NULL,
    [adpostdate] VARCHAR(17) NULL,
    [adlastupdate] VARCHAR(17) NULL,
    [adStock] VARCHAR(50) NULL,
    [adcondition] VARCHAR(128) NULL,
    [adcat] VARCHAR(128) NULL,
    [adyear] VARCHAR(64) NULL,
    [adMake] VARCHAR(128) NULL,
    [adModel] VARCHAR(128) NULL,
    [secondaryclass] VARCHAR(64) NULL,
    [adVIN] VARCHAR(17) NULL,
    [adprice] VARCHAR(64) NULL,
    [adretail] VARCHAR(64) NULL,
    [adinternetprice] VARCHAR(64) NULL,
    [adinteriorcolor] VARCHAR(128) NULL,
    [adexteriorcolor] VARCHAR(128) NULL,
    [adlength] VARCHAR(128) NULL,
    [adwidth] VARCHAR(128) NULL,
    [admiles] VARCHAR(64) NULL,
    [adengine] VARCHAR(64) NULL,
    [adawnings] VARCHAR(64) NULL,
    [adtransmission] VARCHAR(64) NULL,
    [adslides] VARCHAR(64) NULL,
    [adsleeps] VARCHAR(64) NULL,
    [adfreshwater] VARCHAR(64) NULL,
    [adgraywater] VARCHAR(64) NULL,
    [adblackwater] VARCHAR(64) NULL,
    [adtowingcapacity] VARCHAR(64) NULL,
    [adhitchweight] VARCHAR(64) NULL,
    [addryweight] VARCHAR(64) NULL,
    [adgrossweightrating] VARCHAR(64) NULL,
    [addescription] VARCHAR(8000) NULL,
    [adimages] VARCHAR(MAX) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [RideDigitalPhotos] (
    [stockno] VARCHAR(64) NULL,
    [imgurl] VARCHAR(512) NULL,
    [imgsort] VARCHAR(512) NULL
);

CREATE TABLE [RideMarketingAds] (
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(32) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZIP] VARCHAR(5) NULL,
    [dlrPhone] VARCHAR(12) NULL,
    [dlrEmail] VARCHAR(64) NULL,
    [admvdp] VARCHAR(256) NULL,
    [adVIN] VARCHAR(17) NULL,
    [adStock] VARCHAR(50) NULL,
    [adcat] VARCHAR(128) NULL,
    [adyear] VARCHAR(64) NULL,
    [adMake] VARCHAR(128) NULL,
    [adModel] VARCHAR(128) NULL,
    [adcondition] VARCHAR(128) NULL,
    [adexteriorcolor] VARCHAR(128) NULL,
    [adinteriorcolor] VARCHAR(128) NULL,
    [adprice] VARCHAR(64) NULL,
    [admiles] VARCHAR(64) NULL,
    [addescription] VARCHAR(8000) NULL,
    [adimages] VARCHAR(MAX) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [RideMarketingPhotos] (
    [stockno] VARCHAR(17) NULL,
    [imgurl] VARCHAR(512) NULL,
    [imgsort] VARCHAR(4) NULL
);

CREATE TABLE [ROLES] (
    [ROLEID] INT NOT NULL -- PK,
    [ROLENAME] VARCHAR(50) NOT NULL
);

CREATE TABLE [Room58Data] (
    [Dlrname] VARCHAR(64) NULL,
    [Dlrcity] VARCHAR(64) NULL,
    [Dlrstate] VARCHAR(64) NULL,
    [Dlrzip] VARCHAR(64) NULL,
    [Dlrphone] VARCHAR(64) NULL,
    [Dlremail] VARCHAR(64) NULL,
    [adid] VARCHAR(64) NULL,
    [admvdp] VARCHAR(256) NULL,
    [adVIN] VARCHAR(17) NULL,
    [adStock] VARCHAR(50) NULL,
    [adCategory] VARCHAR(128) NULL,
    [adYear] VARCHAR(24) NULL,
    [adMake] VARCHAR(128) NULL,
    [adModel] VARCHAR(128) NULL,
    [adCondition] VARCHAR(128) NULL,
    [adExtColor] VARCHAR(128) NULL,
    [adPrice] VARCHAR(64) NULL,
    [adMiles] VARCHAR(64) NULL,
    [adTransmission] VARCHAR(64) NULL,
    [adCertified] VARCHAR(64) NULL,
    [adText] VARCHAR(8000) NULL,
    [adImages] VARCHAR(MAX) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [Room58Photos] (
    [adid] VARCHAR(64) NULL,
    [imgurl] VARCHAR(256) NULL,
    [imgsort] VARCHAR(3) NULL
);

CREATE TABLE [Rules] (
    [rule_id] INT NOT NULL -- PK,
    [rule_desc] VARCHAR(100) NOT NULL
);

CREATE TABLE [RVOneDatafeed] (
    [DlrId] VARCHAR(12) NULL,
    [adStock] VARCHAR(32) NULL,
    [adMake] VARCHAR(32) NULL,
    [adYear] VARCHAR(4) NULL,
    [adModel] VARCHAR(64) NULL,
    [adCat] VARCHAR(64) NULL,
    [adLength] VARCHAR(24) NULL,
    [adMSRP] VARCHAR(12) NULL,
    [adPrice] VARCHAR(12) NULL,
    [adStatus] VARCHAR(12) NULL,
    [AdCondition] VARCHAR(12) NULL,
    [adMiles] VARCHAR(12) NULL,
    [adFuel_Type] VARCHAR(24) NULL,
    [adText] VARCHAR(4096) NULL,
    [DlrCity] VARCHAR(24) NULL,
    [DlrState] VARCHAR(8) NULL,
    [DlrZipCode] VARCHAR(8) NULL,
    [adPics] VARCHAR(MAX) NULL,
    [adSlide_Out] VARCHAR(4) NULL,
    [adExteriorColor] VARCHAR(64) NULL,
    [adInteriorColor] VARCHAR(64) NULL,
    [adSleeps] VARCHAR(8) NULL,
    [adAwning] VARCHAR(8) NULL,
    [adLeveler_Jacks] VARCHAR(8) NULL,
    [adYouTubeUrl] VARCHAR(200) NULL,
    [adGrossWeight] VARCHAR(8) NULL,
    [adDryWeight] VARCHAR(8) NULL,
    [adChassis] VARCHAR(24) NULL,
    [adVIN] VARCHAR(20) NULL,
    [adEngine] VARCHAR(64) NULL,
    [vendor_id] VARCHAR(8) NULL,
    [advdpurl] VARCHAR(280) NULL,
    [DlrName] VARCHAR(64) NULL,
    [adWaterCapacity] VARCHAR(8) NULL,
    [AdId] VARCHAR(24) NULL
);

CREATE TABLE [SandhillData] (
    [adid] VARCHAR(MAX) NULL,
    [adcat] VARCHAR(20) NULL,
    [adHeadline] VARCHAR(64) NULL,
    [Status] VARCHAR(12) NULL,
    [OwnershipType] VARCHAR(64) NULL,
    [vehicletype] VARCHAR(100) NULL,
    [adMake] VARCHAR(64) NULL,
    [adModel] VARCHAR(64) NULL,
    [Location] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(64) NULL,
    [LocationCountry] VARCHAR(64) NULL,
    [dlrZip] VARCHAR(8) NULL,
    [RetailContactName] VARCHAR(64) NULL,
    [dlrPhone] VARCHAR(64) NULL,
    [RetailContactPhoneExtension] VARCHAR(64) NULL,
    [RentalContactName] VARCHAR(64) NULL,
    [RentalContactPhoneNumber] VARCHAR(64) NULL,
    [RentalContactPhoneExtension] VARCHAR(64) NULL,
    [adYear] VARCHAR(64) NULL,
    [adCondition] VARCHAR(64) NULL,
    [SerialNumber] VARCHAR(64) NULL,
    [Stockno] VARCHAR(64) NULL,
    [quantity] VARCHAR(MAX) NULL,
    [adtext] VARCHAR(4000) NULL,
    [DisplayOnSite] VARCHAR(64) NULL,
    [DisplayOnStore] VARCHAR(64) NULL,
    [DisplayOnStoreForRent] VARCHAR(64) NULL,
    [CertifiedUsed] VARCHAR(64) NULL,
    [ForSale] VARCHAR(64) NULL,
    [ForSaleTaxPercentage] VARCHAR(8) NULL,
    [ForSaleShippingPrice] VARCHAR(8) NULL,
    [ForSaleAdditionalFees] VARCHAR(8) NULL,
    [ForSaleTaxCode] VARCHAR(8) NULL,
    [ForRent] VARCHAR(64) NULL,
    [ForRentDailyRateMinimum] VARCHAR(8) NULL,
    [RentDailyRateMinimum] VARCHAR(8) NULL,
    [ForRentDailyRateMaximum] VARCHAR(8) NULL,
    [RentDailyRateMaximum] VARCHAR(8) NULL,
    [ForRentWeeklyRateMinimum] VARCHAR(8) NULL,
    [RentWeeklyRateMinimum] VARCHAR(8) NULL,
    [ForRentWeeklyRateMaximum] VARCHAR(8) NULL,
    [RentWeeklyRateMaximum] VARCHAR(8) NULL,
    [ForRentMonthlyRateMinimum] VARCHAR(8) NULL,
    [RentMonthlyRateMinimum] VARCHAR(8) NULL,
    [ForRentMonthlyRateMaximum] VARCHAR(8) NULL,
    [RentMonthlyRateMaximum] VARCHAR(8) NULL,
    [ForRentHourlyRateMinimum] VARCHAR(8) NULL,
    [RentHourlyRateMinimum] VARCHAR(8) NULL,
    [ForRentHourlyRateMaximum] VARCHAR(8) NULL,
    [RentHourlyRateMaximum] VARCHAR(8) NULL,
    [ForRentMileageRateMinimum] VARCHAR(8) NULL,
    [RentMileageRateMinimum] VARCHAR(8) NULL,
    [ForRentMileageRateMaximum] VARCHAR(MAX) NULL,
    [RentMileageRateMaximum] VARCHAR(MAX) NULL,
    [ForRentAcreRateMinimum] VARCHAR(MAX) NULL,
    [RentAcreRateMinimum] VARCHAR(8) NULL,
    [ForRentAcreRateMaximum] VARCHAR(MAX) NULL,
    [RentAcreRateMaximum] VARCHAR(8) NULL,
    [adPrice] VARCHAR(64) NULL,
    [ListPrice] VARCHAR(64) NULL,
    [MSRPPrice] VARCHAR(64) NULL,
    [ForLeaseDownPayment] VARCHAR(64) NULL,
    [LeaseDownPayment] VARCHAR(64) NULL,
    [ForLeaseRateMinimum] VARCHAR(64) NULL,
    [LeaseRateMinimum] VARCHAR(64) NULL,
    [ForLeaseRateMaximum] VARCHAR(64) NULL,
    [LeaseRateMaximum] VARCHAR(64) NULL,
    [ForLeaseMonthlyPrice] VARCHAR(64) NULL,
    [LeaseMonthlyPrice] VARCHAR(64) NULL,
    [FractionalOwnershipPrice] VARCHAR(64) NULL,
    [CharterHourlyPrice] VARCHAR(64) NULL,
    [DealerEstimatedValue] VARCHAR(64) NULL,
    [AvailableWhen] VARCHAR(64) NULL,
    [InventoryStatus] VARCHAR(64) NULL,
    [InventoryStatusDetails] VARCHAR(64) NULL,
    [ForLease] VARCHAR(64) NULL,
    [ForLeaseTermMonths] VARCHAR(64) NULL,
    [ForLeasePaymentFrequency] VARCHAR(MAX) NULL,
    [PictureList] VARCHAR(MAX) NULL,
    [MediaCount] VARCHAR(MAX) NULL,
    [MediaList] VARCHAR(MAX) NULL,
    [CurrencyCode] VARCHAR(64) NULL,
    [OwnerName] VARCHAR(64) NULL,
    [DSBusinessUnitName] VARCHAR(64) NULL,
    [WarrantyID] VARCHAR(64) NULL,
    [OnAuction] VARCHAR(64) NULL,
    [OnBidCaller] VARCHAR(64) NULL,
    [DismantledFromLookupID] VARCHAR(64) NULL,
    [AttachmentInventoryLocation] VARCHAR(64) NULL,
    [PartNumber] VARCHAR(64) NULL,
    [airconditioning] VARCHAR(64) NULL,
    [axle] VARCHAR(64) NULL,
    [color] VARCHAR(64) NULL,
    [drive] VARCHAR(64) NULL,
    [driverposition] VARCHAR(64) NULL,
    [engine] VARCHAR(64) NULL,
    [enginesize] VARCHAR(64) NULL,
    [enginetype] VARCHAR(64) NULL,
    [frontaxlelbs] VARCHAR(64) NULL,
    [fueltype] VARCHAR(64) NULL,
    [grossvehicleweight] VARCHAR(64) NULL,
    [horsepower] VARCHAR(64) NULL,
    [mileage] VARCHAR(64) NULL,
    [mileagetype] VARCHAR(64) NULL,
    [ratio] VARCHAR(64) NULL,
    [rearaxlelbs] VARCHAR(64) NULL,
    [suspension] VARCHAR(64) NULL,
    [transmanufacturer] VARCHAR(64) NULL,
    [transmission] VARCHAR(64) NULL,
    [transmissionrebuilt] VARCHAR(64) NULL,
    [transmissiontype] VARCHAR(64) NULL,
    [wheelbase] VARCHAR(64) NULL,
    [wheels] VARCHAR(64) NULL,
    [DataVersion] VARCHAR(64) NULL,
    [ForConsignment] VARCHAR(64) NULL,
    [Consignor] VARCHAR(64) NULL,
    [IsTitleRequired] VARCHAR(64) NULL,
    [IsTitleReceived] VARCHAR(64) NULL,
    [IsContract] VARCHAR(64) NULL,
    [QualityPercentage] VARCHAR(64) NULL,
    [IsAllowPickup] VARCHAR(64) NULL,
    [Title] VARCHAR(64) NULL,
    [BarcodeGTIN] VARCHAR(64) NULL,
    [ManufacturerMPN] VARCHAR(64) NULL,
    [numspeeds] VARCHAR(64) NULL,
    [cab] VARCHAR(64) NULL,
    [grossvehicleweightrating] VARCHAR(64) NULL,
    [overdrive] VARCHAR(64) NULL,
    [dot] VARCHAR(64) NULL,
    [hoursmeterinaccurate] VARCHAR(64) NULL,
    [hourssinceoverhaul] VARCHAR(64) NULL,
    [overhaul] VARCHAR(64) NULL,
    [cabinets] VARCHAR(64) NULL,
    [numberofbeds] VARCHAR(64) NULL,
    [powerlocks] VARCHAR(64) NULL,
    [sleeper] VARCHAR(64) NULL,
    [refrigerator] VARCHAR(64) NULL,
    [woodgraindash] VARCHAR(64) NULL,
    [auxiliarypowerunit] VARCHAR(64) NULL,
    [enginebrake] VARCHAR(64) NULL,
    [composition] VARCHAR(64) NULL,
    [doors] VARCHAR(64) NULL,
    [etrack] VARCHAR(64) NULL,
    [etracknumrows] VARCHAR(64) NULL,
    [floortype] VARCHAR(64) NULL,
    [length] VARCHAR(64) NULL,
    [liftendgate] VARCHAR(64) NULL,
    [lining] VARCHAR(64) NULL,
    [rooftype] VARCHAR(64) NULL,
    [thresholdplate] VARCHAR(64) NULL,
    [width] VARCHAR(64) NULL,
    [cabtype] VARCHAR(64) NULL,
    [doesnotrun] VARCHAR(64) NULL,
    [exhaust] VARCHAR(64) NULL,
    [supersingles] VARCHAR(64) NULL,
    [cruisecontrol] VARCHAR(64) NULL,
    [powersteering] VARCHAR(64) NULL,
    [hours] VARCHAR(64) NULL,
    [wetkit] VARCHAR(64) NULL,
    [height] VARCHAR(64) NULL,
    [powerwindows] VARCHAR(64) NULL,
    [liftaxle] VARCHAR(8) NULL,
    [sleepersize] VARCHAR(8) NULL,
    [OnHiBid] VARCHAR(8) NULL,
    [gliderkit] VARCHAR(8) NULL,
    [fuelcapacity] VARCHAR(8) NULL,
    [insulated] VARCHAR(64) NULL,
    [reefer] VARCHAR(64) NULL,
    [sidedoors] VARCHAR(64) NULL,
    [tilttelescope] VARCHAR(64) NULL,
    [seatmaterial] VARCHAR(64) NULL,
    [InventoryTitle] VARCHAR(100) NULL,
    [ListingDetailsURL] VARCHAR(256) NULL,
    [reeferhours] VARCHAR(64) NULL,
    [heatedmirror] VARCHAR(64) NULL,
    [turbo] VARCHAR(64) NULL,
    [axleconfiguration] VARCHAR(256) NULL,
    [SpecData] VARCHAR(300) NULL,
    [exhaustbrake] VARCHAR(64) NULL,
    [mudflaps] VARCHAR(MAX) NULL
);

CREATE TABLE [SandhillImageFix] (
    [DealerID] VARCHAR(MAX) NULL,
    [DSLookupID] VARCHAR(MAX) NULL,
    [PictureList] VARCHAR(MAX) NULL
);

CREATE TABLE [SandhillPhotos] (
    [stockno] VARCHAR(64) NULL,
    [imgurl] VARCHAR(512) NULL,
    [imgsort] VARCHAR(512) NULL
);

CREATE TABLE [SAVEAD] (
    [SAVID] INT NOT NULL,
    [MEMID] INT NOT NULL,
    [ADID] INT NOT NULL
);

CREATE TABLE [SAVED] (
    [SAVID] INT NOT NULL -- PK,
    [MEMID] INT NOT NULL,
    [PUBID] INT NULL,
    [ADNUM] INT NULL,
    [SAVTEXT] VARCHAR(512) NOT NULL,
    [SAVYEAR] SMALLINT NULL,
    [SAVMAKE] VARCHAR(32) NULL,
    [SAVMODEL] VARCHAR(128) NULL,
    [SAVSUBMODEL] VARCHAR(32) NULL,
    [SAVPRICE] MONEY NULL,
    [SAVPHONE] VARCHAR(16) NULL,
    [SAVEMAIL] VARCHAR(92) NULL,
    [SAVIMG] VARCHAR(512) NULL,
    [SAVEXPIRED] BIT NOT NULL,
    [SAVDATE] DATETIME NOT NULL
);

CREATE TABLE [SCLSORT] (
    [catorder] INT NOT NULL -- PK,
    [sclid] INT NOT NULL,
    [sclname] VARCHAR(128) NOT NULL
);

CREATE TABLE [SEARCHPAGES] (
    [SPID] INT NOT NULL -- PK,
    [SPNAME] VARCHAR(36) NOT NULL,
    [SPACTIVE] BIT NOT NULL,
    [SPVEHICLE] BIT NOT NULL
);

CREATE TABLE [searchRadius] (
    [searchid] INT NOT NULL -- PK,
    [radius] INT NOT NULL
);

CREATE TABLE [ServerSource] (
    [SERID] INT NOT NULL -- PK,
    [SERVERNAME] VARCHAR(50) NOT NULL
);

CREATE TABLE [ShortURL] (
    [id] UNIQUEIDENTIFIER NOT NULL -- PK,
    [shorturl] VARCHAR(512) NULL,
    [url] VARCHAR(8000) NOT NULL,
    [customkey] VARCHAR(100) NULL,
    [entered] DATETIME NOT NULL,
    [indexkey] INT NULL,
    [groupkey] VARCHAR(50) NULL
);

CREATE TABLE [ShortURLSandhill] (
    [id] UNIQUEIDENTIFIER NOT NULL -- PK,
    [shorturl] VARCHAR(512) NULL,
    [url] VARCHAR(8000) NOT NULL,
    [customkey] VARCHAR(100) NULL,
    [entered] DATETIME NOT NULL,
    [indexkey] INT NULL,
    [groupkey] VARCHAR(50) NULL
);

CREATE TABLE [ShortUrlSanhillBU] (
    [id] UNIQUEIDENTIFIER NOT NULL,
    [shorturl] VARCHAR(512) NULL,
    [url] VARCHAR(8000) NOT NULL,
    [customkey] VARCHAR(100) NULL,
    [entered] DATETIME NOT NULL
);

CREATE TABLE [SincroCustomers] (
    [DLRID] VARCHAR(12) NULL,
    [DLRCODE] VARCHAR(12) NULL,
    [DLRNAME] VARCHAR(128) NULL,
    [DLRTITLE] VARCHAR(64) NULL,
    [DLRADDR] VARCHAR(64) NULL,
    [DLRCITY] VARCHAR(32) NULL,
    [DLRSTATE] VARCHAR(2) NULL,
    [DLRZIP] VARCHAR(10) NULL,
    [DLRPHONE] VARCHAR(24) NULL,
    [DLRFAX] VARCHAR(20) NULL,
    [DLREMAIL] VARCHAR(128) NULL,
    [DLRCONTACT] VARCHAR(128) NULL,
    [DLRURL] VARCHAR(128) NULL
);

CREATE TABLE [SincroData] (
    [DLRID] VARCHAR(12) NULL,
    [ADVIN] VARCHAR(32) NULL,
    [ADSTOCK] VARCHAR(100) NULL,
    [ADMAKE] VARCHAR(64) NULL,
    [ADMODEL] VARCHAR(64) NULL,
    [ADSUBMODEL] VARCHAR(128) NULL,
    [ADYEAR] VARCHAR(4) NULL,
    [ADPRICE] MONEY NULL,
    [ADPRICE2] VARCHAR(10) NULL,
    [MSRP] VARCHAR(10) NULL,
    [INVOICE] VARCHAR(12) NULL,
    [ADMILES] VARCHAR(8) NULL,
    [ADEXTCOLOR] VARCHAR(128) NULL,
    [ADINTCOLOR] VARCHAR(500) NULL,
    [ADTEXT] VARCHAR(5000) NULL,
    [ADAMENITIES] VARCHAR(5000) NULL,
    [ADCERTIFIED] VARCHAR(24) NULL,
    [TRANSMISSION] VARCHAR(2) NULL,
    [ADSECTION] VARCHAR(32) NULL,
    [BODYSTYLE] VARCHAR(64) NULL,
    [ADSPEEDS] VARCHAR(64) NULL,
    [ADDOORS] VARCHAR(12) NULL,
    [ADCYLINDERS] VARCHAR(64) NULL,
    [ADENGINE] VARCHAR(MAX) NULL,
    [ADCLASS] VARCHAR(128) NULL,
    [TRANSTEXT] VARCHAR(1200) NULL,
    [ENGPOWER] VARCHAR(512) NULL,
    [ENGCONFIG] VARCHAR(512) NULL,
    [DISPLACEMENT] VARCHAR(512) NULL,
    [INDUCTION] VARCHAR(100) NULL,
    [FUELTYPE] VARCHAR(128) NULL,
    [WARRANTY] VARCHAR(2000) NULL,
    [LASTMODIFIED] VARCHAR(32) NULL,
    [ADNUM] VARCHAR(32) NULL,
    [ADPIC1] VARCHAR(MAX) NULL,
    [ADdrivetrain] VARCHAR(32) NULL,
    [oem_model_code] VARCHAR(64) NULL,
    [lot_date] VARCHAR(20) NULL,
    [adVDP] VARCHAR(256) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [SmartWebCustomers] (
    [dlrID] VARCHAR(8) NULL,
    [dlrName] VARCHAR(32) NULL,
    [dlrEmail] VARCHAR(96) NULL,
    [dlrURL] VARCHAR(40) NULL,
    [dlrPhone] VARCHAR(16) NULL,
    [dlrZip] VARCHAR(5) NULL
);

CREATE TABLE [SmartWebData] (
    [dlrID] VARCHAR(8) NULL,
    [adID] VARCHAR(32) NULL,
    [adSection] VARCHAR(32) NULL,
    [adMake] VARCHAR(21) NULL,
    [adModel] VARCHAR(64) NULL,
    [adSubModel] VARCHAR(64) NULL,
    [adYear] VARCHAR(4) NULL,
    [adMiles] VARCHAR(8) NULL,
    [adHeadline] VARCHAR(64) NULL,
    [adText] VARCHAR(1024) NULL,
    [adPrice] VARCHAR(8) NULL,
    [adPhone] VARCHAR(16) NULL,
    [adPiclt] VARCHAR(512) NULL,
    [adPic1] VARCHAR(512) NULL,
    [adPic2] VARCHAR(512) NULL,
    [adPic3] VARCHAR(512) NULL,
    [adPic4] VARCHAR(512) NULL,
    [adextcolor] VARCHAR(256) NULL,
    [adnewused] VARCHAR(16) NULL,
    [adcertified] VARCHAR(16) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [sonicdata] (
    [adid] VARCHAR(42) NULL,
    [dlrid] VARCHAR(32) NULL,
    [vin] VARCHAR(32) NULL,
    [stockno] VARCHAR(32) NULL,
    [adyear] VARCHAR(12) NULL,
    [make] VARCHAR(64) NULL,
    [model] VARCHAR(64) NULL,
    [model_code] VARCHAR(32) NULL,
    [trim] VARCHAR(64) NULL,
    [bodystyle] VARCHAR(32) NULL,
    [transmission] VARCHAR(64) NULL,
    [drive_train] VARCHAR(32) NULL,
    [doors] VARCHAR(32) NULL,
    [exterior_color] VARCHAR(64) NULL,
    [interior_color] VARCHAR(64) NULL,
    [truck_cab] VARCHAR(128) NULL,
    [truck_bed] VARCHAR(128) NULL,
    [msrp] VARCHAR(32) NULL,
    [invoice] VARCHAR(32) NULL,
    [price] VARCHAR(32) NULL,
    [wholesale_price] VARCHAR(32) NULL,
    [retail_price] VARCHAR(32) NULL,
    [sale_price] VARCHAR(32) NULL,
    [city_mpg] VARCHAR(32) NULL,
    [highway_mpg] VARCHAR(32) NULL,
    [horse_power] VARCHAR(128) NULL,
    [mileage] VARCHAR(32) NULL,
    [comments] VARCHAR(MAX) NULL,
    [options] VARCHAR(6000) NULL,
    [adpics] VARCHAR(MAX) NULL,
    [adtype] VARCHAR(8) NULL,
    [certified] VARCHAR(8) NULL,
    [engine] VARCHAR(128) NULL,
    [engine_size] VARCHAR(32) NULL,
    [fuel] VARCHAR(32) NULL,
    [lot_date] VARCHAR(32) NULL,
    [creation_date] VARCHAR(32) NULL,
    [last_modified] VARCHAR(32) NULL,
    [carfax_expiration] VARCHAR(32) NULL,
    [carfax_previous_owners] VARCHAR(8) NULL,
    [dealership] VARCHAR(64) NULL,
    [dealership_address1] VARCHAR(64) NULL,
    [dealership_address2] VARCHAR(128) NULL,
    [dealership_city] VARCHAR(64) NULL,
    [dealership_state] VARCHAR(32) NULL,
    [dealership_postalcode] VARCHAR(32) NULL,
    [adtext] VARCHAR(6000) NULL,
    [dealership_phone] VARCHAR(32) NULL,
    [dealership_url] VARCHAR(512) NULL
);

CREATE TABLE [sonicdatatemp] (
    [adid] VARCHAR(42) NULL,
    [dlrid] VARCHAR(32) NULL,
    [vin] VARCHAR(32) NULL,
    [stockno] VARCHAR(32) NULL,
    [adyear] VARCHAR(12) NULL,
    [make] VARCHAR(64) NULL,
    [model] VARCHAR(64) NULL,
    [model_code] VARCHAR(32) NULL,
    [trim] VARCHAR(64) NULL,
    [bodystyle] VARCHAR(32) NULL,
    [transmission] VARCHAR(64) NULL,
    [drive_train] VARCHAR(32) NULL,
    [doors] VARCHAR(32) NULL,
    [exterior_color] VARCHAR(64) NULL,
    [interior_color] VARCHAR(64) NULL,
    [truck_cab] VARCHAR(128) NULL,
    [truck_bed] VARCHAR(128) NULL,
    [msrp] VARCHAR(32) NULL,
    [invoice] VARCHAR(32) NULL,
    [price] VARCHAR(32) NULL,
    [wholesale_price] VARCHAR(32) NULL,
    [retail_price] VARCHAR(32) NULL,
    [sale_price] VARCHAR(32) NULL,
    [city_mpg] VARCHAR(32) NULL,
    [highway_mpg] VARCHAR(32) NULL,
    [horse_power] VARCHAR(128) NULL,
    [mileage] VARCHAR(32) NULL,
    [comments] VARCHAR(MAX) NULL,
    [options] VARCHAR(6000) NULL,
    [adpics] VARCHAR(MAX) NULL,
    [adtype] VARCHAR(8) NULL,
    [certified] VARCHAR(8) NULL,
    [engine] VARCHAR(128) NULL,
    [engine_size] VARCHAR(32) NULL,
    [fuel] VARCHAR(32) NULL,
    [lot_date] VARCHAR(32) NULL,
    [creation_date] VARCHAR(32) NULL,
    [last_modified] VARCHAR(32) NULL,
    [carfax_expiration] VARCHAR(32) NULL,
    [carfax_previous_owners] VARCHAR(8) NULL,
    [dealership] VARCHAR(64) NULL,
    [dealership_address1] VARCHAR(64) NULL,
    [dealership_address2] VARCHAR(128) NULL,
    [dealership_city] VARCHAR(64) NULL,
    [dealership_state] VARCHAR(32) NULL,
    [dealership_postalcode] VARCHAR(32) NULL,
    [adtext] VARCHAR(6000) NULL,
    [dealership_phone] VARCHAR(32) NULL,
    [dealership_url] VARCHAR(512) NULL
);

CREATE TABLE [SonicDealers] (
    [dlrID] VARCHAR(32) NULL,
    [dlrName] VARCHAR(32) NULL,
    [dlrAddr] VARCHAR(128) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZip] VARCHAR(10) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrURL] VARCHAR(512) NULL,
    [dlrPhone] VARCHAR(18) NULL,
    [dlrFileName] VARCHAR(128) NULL,
    [active] BIT NOT NULL
);

CREATE TABLE [SpectrumRollup] (
    [rpt_Date] DATE NULL,
    [rpt_Channel] VARCHAR(128) NULL,
    [rpt_Division] VARCHAR(128) NULL,
    [rep_Login] VARCHAR(128) NULL,
    [acc_ID] INT NULL,
    [dlr_Name] VARCHAR(64) NULL,
    [inv_Units] INT NULL,
    [dlr_LiveDate] DATE NULL,
    [lead_Emails] INT NOT NULL,
    [lead_Calls] INT NOT NULL,
    [dis_Clicks] INT NULL,
    [dis_Impressions] INT NULL,
    [lcl_ProfileViews] INT NULL,
    [inv_IncludeImages] INT NULL,
    [inv_IncludePrice] INT NULL,
    [has_Feed] INT NULL,
    [has_Display] INT NULL,
    [has_Local] INT NULL,
    [vdp_3rdParty] INT NULL,
    [isDisplayRegular] INT NULL,
    [isDisplaySmartAd] INT NULL,
    [isDisplayGeoFence] INT NULL
);

CREATE TABLE [SQLInjectionCheck] (
    [Table_Column] VARCHAR(512) NULL,
    [Rows_Infected] INT NULL
);

CREATE TABLE [StaleSitemap] (
    [AccountID] INT NOT NULL,
    [AccountName] VARCHAR(128) NULL,
    [Domain] VARCHAR(100) NOT NULL,
    [LastUpdate] VARCHAR(100) NOT NULL,
    [CrawlType] VARCHAR(100) NOT NULL,
    [Channel] VARCHAR(128) NULL,
    [Subscription] VARCHAR(256) NULL
);

CREATE TABLE [STATES] (
    [STATE] VARCHAR(2) NOT NULL -- PK,
    [STATENAME] VARCHAR(64) NULL,
    [INAMERICA] BIT NOT NULL
);

CREATE TABLE [StatPubs] (
    [PubID] INT NOT NULL,
    [PubName] VARCHAR(64) NULL,
    [PubURL] VARCHAR(512) NULL,
    [PubCode] VARCHAR(4) NULL
);

CREATE TABLE [STATUS] (
    [STATID] TINYINT NOT NULL -- PK,
    [STATDESC] VARCHAR(64) NOT NULL
);

CREATE TABLE [stlouisdata] (
    [id] INT NOT NULL,
    [autoid] VARCHAR(32) NULL,
    [adid] VARCHAR(32) NULL,
    [site] VARCHAR(64) NULL,
    [accountid] VARCHAR(32) NULL,
    [bodystyle] VARCHAR(32) NULL,
    [certified] VARCHAR(32) NULL,
    [dealerid] VARCHAR(32) NULL,
    [dealername] VARCHAR(64) NULL,
    [dealerstocknumber] VARCHAR(32) NULL,
    [description] VARCHAR(4000) NULL,
    [enginetext] VARCHAR(64) NULL,
    [exteriorcolor] VARCHAR(64) NULL,
    [fueltype] VARCHAR(64) NULL,
    [city] VARCHAR(32) NULL,
    [state] VARCHAR(32) NULL,
    [zip] VARCHAR(10) NULL,
    [interiorcolor] VARCHAR(64) NULL,
    [year] VARCHAR(4) NULL,
    [make] VARCHAR(64) NULL,
    [model] VARCHAR(64) NULL,
    [mileagein] VARCHAR(10) NULL,
    [cylinders] VARCHAR(4) NULL,
    [doors] VARCHAR(4) NULL,
    [posttype] VARCHAR(32) NULL,
    [source] VARCHAR(32) NULL,
    [vehicletype] VARCHAR(32) NULL,
    [postdate] VARCHAR(32) NULL,
    [expiredate] VARCHAR(32) NULL,
    [price] VARCHAR(10) NULL,
    [msrp] VARCHAR(10) NULL,
    [transmissionspeed] VARCHAR(10) NULL,
    [transmissiontype] VARCHAR(32) NULL,
    [drivetype] VARCHAR(32) NULL,
    [style] VARCHAR(64) NULL,
    [amenities] VARCHAR(1200) NULL,
    [used] VARCHAR(2) NULL,
    [vin] VARCHAR(20) NULL,
    [warranty] VARCHAR(32) NULL,
    [images] VARCHAR(8000) NULL,
    [contactname] VARCHAR(64) NULL,
    [contactphone] VARCHAR(32) NULL,
    [contactaltphone] VARCHAR(32) NULL,
    [contactemail] VARCHAR(64) NULL,
    [featuredad] VARCHAR(10) NULL,
    [spotlightad] VARCHAR(10) NULL
);

CREATE TABLE [StLouisData_XML] (
    [xml] XML NULL
);

CREATE TABLE [StockNumCustomers] (
    [dlrID] VARCHAR(32) NULL,
    [dlrName] VARCHAR(32) NULL,
    [dlrAddr] VARCHAR(128) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZip] VARCHAR(10) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrURL] VARCHAR(512) NULL,
    [dlrPhone] VARCHAR(18) NULL
);

CREATE TABLE [StockNumData] (
    [dlrID] VARCHAR(32) NULL,
    [adID] VARCHAR(17) NULL,
    [adStock] VARCHAR(17) NULL,
    [adVin] VARCHAR(32) NULL,
    [adSection] VARCHAR(32) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(128) NULL,
    [adSubModel] VARCHAR(128) NULL,
    [adYear] VARCHAR(4) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adColor] VARCHAR(64) NULL,
    [adCondition] VARCHAR(32) NULL,
    [adHeadline] VARCHAR(64) NULL,
    [adText] VARCHAR(6000) NULL,
    [adCustomText] VARCHAR(4000) NULL,
    [adPrice] VARCHAR(32) NULL,
    [adPhone] VARCHAR(32) NULL,
    [adPic1t] VARCHAR(512) NULL,
    [adPic1] VARCHAR(512) NULL,
    [adPic2] VARCHAR(512) NULL,
    [adPic3] VARCHAR(512) NULL,
    [adPics] VARCHAR(6400) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [Story] (
    [StoryID] INT NOT NULL -- PK,
    [StoryHeadline] VARCHAR(255) NOT NULL,
    [StorySummary] VARCHAR(1000) NOT NULL,
    [StoryText] TEXT NOT NULL,
    [StoryClass] INT NOT NULL,
    [StoryGroup] INT NOT NULL,
    [StorySort] INT NOT NULL,
    [StoryReleaseDate] DATETIME NOT NULL,
    [StoryActive] BIT NOT NULL,
    [StoryAuthor] VARCHAR(50) NOT NULL,
    [StoryPhoto] BIT NOT NULL,
    [StoryTagLine] VARCHAR(100) NOT NULL,
    [PubID] INT NOT NULL
);

CREATE TABLE [su_ADDInfoByUser] (
    [UserID] VARCHAR(255) NULL,
    [ListingID] INT NOT NULL -- PK,
    [Preferred] BIT NULL,
    [Showcase] BIT NULL,
    [Enlarged] BIT NULL
);

CREATE TABLE [SUBCLASS] (
    [SCLID] INT NOT NULL -- PK,
    [CLSID] INT NOT NULL,
    [SCLNAME] VARCHAR(64) NOT NULL,
    [SCLORDER] INT NOT NULL,
    [SCLSEARCH] INT NOT NULL,
    [New_scl_ID] INT NULL
);

CREATE TABLE [SUBEDITIONS] (
    [SUBID] INT NOT NULL -- PK,
    [EDID] INT NOT NULL -- PK
);

CREATE TABLE [SUBIMAGES] (
    [SUBID] INT NOT NULL -- PK,
    [IMGURL] VARCHAR(255) NOT NULL -- PK,
    [IMGSORT] TINYINT NOT NULL -- PK
);

CREATE TABLE [SUBMIT] (
    [SUBID] INT NOT NULL -- PK,
    [MEMID] INT NOT NULL,
    [PUBID] INT NOT NULL,
    [SCLID] INT NOT NULL,
    [SUBYEAR] SMALLINT NOT NULL,
    [SUBMAKE] VARCHAR(32) NOT NULL,
    [SUBMODEL] VARCHAR(32) NOT NULL,
    [SUBSMODEL] VARCHAR(32) NULL,
    [SUBTEXT] VARCHAR(4096) NOT NULL,
    [SUBHEADLINE] VARCHAR(255) NULL,
    [SUBBOXED] BIT NULL,
    [SUBINS] TINYINT NOT NULL,
    [SUBPRICE] MONEY NOT NULL,
    [SUBCOST] MONEY NOT NULL,
    [SUBENTERED] SMALLDATETIME NOT NULL,
    [SUBMODIFIED] SMALLDATETIME NOT NULL,
    [SUBPROOFED] BIT NOT NULL,
    [SUBSTATUS] TINYINT NOT NULL,
    [SUBFNAME1] VARCHAR(128) NULL,
    [SUBFNAME2] VARCHAR(128) NULL,
    [SUBFNAME3] VARCHAR(128) NULL,
    [SUBFNAME4] VARCHAR(128) NULL,
    [SUBADTYPE] TINYINT NOT NULL,
    [SUBEMAIL] VARCHAR(64) NULL,
    [SUBPHONE] VARCHAR(12) NOT NULL,
    [SUBNOPHONE] BIT NOT NULL,
    [SUBRTIS] BIT NOT NULL,
    [SUBPREFERRED] BIT NOT NULL,
    [SUBADTEXT] VARCHAR(512) NULL,
    [ADID] INT NULL,
    [SUBREASON] VARCHAR(512) NULL,
    [SUBPHOTOSRC] INT NULL,
    [ECLSNUMBER] INT NULL,
    [SUBPACKAGE] INT NULL,
    [SUBUPSELL] TINYINT NULL
);

CREATE TABLE [Subscriptions] (
    [SbsID] INT NOT NULL -- PK,
    [StartDate] DATETIME NOT NULL,
    [EndDate] DATETIME NOT NULL,
    [Counter] INT NOT NULL,
    [RecID] INT NOT NULL,
    [SbsTypeID] INT NOT NULL,
    [MemID] INT NOT NULL,
    [PubID] INT NOT NULL
);

CREATE TABLE [SubscriptionType] (
    [SbsTypeID] INT NOT NULL -- PK,
    [TypeName] VARCHAR(50) NOT NULL,
    [Days] SMALLINT NOT NULL,
    [Price] MONEY NOT NULL,
    [Active] BIT NOT NULL,
    [PubID] INT NOT NULL
);

CREATE TABLE [sysdiagrams] (
    [name] NVARCHAR(128) NOT NULL,
    [principal_id] INT NOT NULL,
    [diagram_id] INT NOT NULL -- PK,
    [version] INT NULL,
    [definition] VARBINARY(MAX) NULL
);

CREATE TABLE [TableChangeLog] (
    [XID] SMALLINT NOT NULL,
    [XLoginName] NVARCHAR(128) NULL,
    [XUserName] NVARCHAR(128) NULL,
    [XChangeDate] DATETIME NOT NULL,
    [TableName] VARCHAR(64) NOT NULL,
    [spid] SMALLINT NOT NULL,
    [dbid] SMALLINT NOT NULL,
    [uid] SMALLINT NULL,
    [login_time] DATETIME NOT NULL,
    [last_batch] DATETIME NOT NULL,
    [status] NCHAR(30) NOT NULL,
    [hostname] NCHAR(128) NOT NULL,
    [program_name] NCHAR(128) NOT NULL,
    [hostprocess] NCHAR(10) NOT NULL,
    [cmd] NCHAR(16) NOT NULL,
    [nt_domain] NCHAR(128) NOT NULL,
    [nt_username] NCHAR(128) NOT NULL,
    [net_address] NCHAR(12) NOT NULL,
    [net_library] NCHAR(12) NOT NULL,
    [loginame] NCHAR(128) NOT NULL,
    [sql_handle] BINARY(20) NOT NULL,
    [connect_time] DATETIME NULL,
    [net_transport] NVARCHAR(40) NULL,
    [protocol_type] NVARCHAR(40) NULL,
    [auth_scheme] NVARCHAR(40) NULL,
    [last_read] DATETIME NULL,
    [last_write] DATETIME NULL,
    [client_net_address] VARCHAR(48) NULL,
    [client_tcp_port] INT NULL,
    [local_net_address] VARCHAR(48) NULL,
    [local_tcp_port] INT NULL,
    [connection_id] UNIQUEIDENTIFIER NULL,
    [most_recent_sql_handle] VARBINARY(64) NULL
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

CREATE TABLE [tempaccountids] (
    [a] INT NULL,
    [f] INT NOT NULL
);

CREATE TABLE [TempCharter] (
    [adtype] VARCHAR(32) NULL,
    [category] VARCHAR(64) NULL,
    [subcategory] VARCHAR(64) NULL,
    [id] VARCHAR(12) NULL,
    [custID] VARCHAR(12) NULL,
    [publication] VARCHAR(64) NULL,
    [year] VARCHAR(32) NULL,
    [make] VARCHAR(32) NULL,
    [model] VARCHAR(64) NULL,
    [headline] VARCHAR(128) NULL,
    [adtext] VARCHAR(2048) NULL,
    [phone] VARCHAR(13) NULL,
    [url] VARCHAR(512) NULL,
    [image_url] VARCHAR(512) NULL,
    [price] VARCHAR(12) NULL,
    [create_time] VARCHAR(16) NULL,
    [zip_code] VARCHAR(10) NULL
);

CREATE TABLE [TEMPDLM] (
    [DEALERID] INT NOT NULL,
    [MEMID] INT NOT NULL
);

CREATE TABLE [TempOutFeed] (
    [XMLID] INT NOT NULL -- PK,
    [XMLText] VARCHAR(8000) NULL
);

CREATE TABLE [tempVODads] (
    [ADNUM] INT NOT NULL,
    [SCLID] INT NULL,
    [CUSID] INT NULL,
    [YEAR] INT NULL,
    [MAKE] VARCHAR(64) NULL,
    [MODEL] VARCHAR(64) NULL,
    [ADTEXT] VARCHAR(512) NULL,
    [ADPHONE] VARCHAR(16) NULL,
    [ADPRICE] INT NULL,
    [DLRZIP] INT NULL,
    [ADID] INT NULL
);

CREATE TABLE [TexasDirectData] (
    [dlrID] VARCHAR(32) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(32) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZIP] VARCHAR(10) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrURL] VARCHAR(512) NULL,
    [dlrPhone] VARCHAR(24) NULL,
    [adVIN] VARCHAR(24) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(128) NULL,
    [adYear] VARCHAR(8) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adStock] VARCHAR(32) NULL,
    [adColor] VARCHAR(64) NULL,
    [adHeadline] VARCHAR(6500) NULL,
    [adPhone] VARCHAR(18) NULL,
    [adPrice] VARCHAR(10) NULL,
    [adText] VARCHAR(8000) NULL,
    [adSection] VARCHAR(32) NULL,
    [adID] VARCHAR(32) NULL,
    [adSubModel] VARCHAR(128) NULL,
    [adPics] VARCHAR(MAX) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [TMPiMoveDaleR] (
    [old_CUSID] INT NULL,
    [old_PUBID] INT NULL,
    [Customer] VARCHAR(256) NULL,
    [new_CUSID] INT NULL
);

CREATE TABLE [TMPiMoveDaleR_feedads] (
    [faUID] INT NOT NULL,
    [fdPUBID] INT NOT NULL,
    [fdEDID] INT NOT NULL,
    [faVIN] VARCHAR(64) NOT NULL,
    [faADNUM] INT NOT NULL,
    [faCAT] VARCHAR(255) NOT NULL,
    [faSCLID] INT NOT NULL,
    [faTYPE] TINYINT NOT NULL,
    [faSPECIAL] TINYINT NOT NULL,
    [faTOP] TINYINT NOT NULL,
    [faTEXT] VARCHAR(4096) NOT NULL,
    [faHTML] TEXT NULL,
    [faHEADLINE] VARCHAR(128) NULL,
    [faBOXED] BIT NOT NULL,
    [faYEAR] SMALLINT NULL,
    [faMAKE] VARCHAR(32) NULL,
    [faMODEL] VARCHAR(128) NULL,
    [faSUBMODEL] VARCHAR(32) NULL,
    [faPRICE] MONEY NULL,
    [faPHONE] VARCHAR(16) NULL,
    [faPIC1] VARCHAR(512) NULL,
    [faPIC2] VARCHAR(512) NULL,
    [faPIC3] VARCHAR(512) NULL,
    [faPIC4] VARCHAR(512) NULL,
    [faPICS] VARCHAR(8000) NOT NULL,
    [faCOST] MONEY NOT NULL,
    [faCREATED] SMALLDATETIME NOT NULL,
    [faLASTUPLOAD] SMALLDATETIME NOT NULL,
    [faACTIVE] BIT NOT NULL,
    [adID] INT NULL,
    [faSTOCK] VARCHAR(32) NULL,
    [fdUID] INT NULL
);

CREATE TABLE [TMPiMoveDaleR_FEEDDEALERS] (
    [fdUID] INT NOT NULL,
    [fdID] VARCHAR(32) NOT NULL,
    [fdPUBID] INT NOT NULL,
    [fdEDID] INT NOT NULL,
    [fdCUSID] INT NOT NULL,
    [fdNAME] VARCHAR(64) NOT NULL,
    [fdADDR] VARCHAR(64) NOT NULL,
    [fdCITY] VARCHAR(32) NULL,
    [fdSTATE] VARCHAR(2) NOT NULL,
    [fdZIP] VARCHAR(10) NOT NULL,
    [fdPHONE] VARCHAR(16) NOT NULL,
    [fdALTPHONE] VARCHAR(16) NOT NULL,
    [fdFAX] VARCHAR(16) NOT NULL,
    [fdEMAIL_STRING] VARCHAR(96) NOT NULL,
    [fdEMAIL_XML] VARCHAR(96) NOT NULL,
    [fdURL] VARCHAR(512) NULL,
    [fdPROFILE] TINYINT NOT NULL,
    [fdIMG1] VARCHAR(512) NULL,
    [fdIMG2] VARCHAR(512) NULL,
    [fdIMG3] VARCHAR(512) NULL,
    [fdIMG4] VARCHAR(512) NULL,
    [fdSHOWOTHER] BIT NOT NULL,
    [fdCAO] BIT NOT NULL,
    [dlrID] INT NULL,
    [fdUIDMaster] INT NULL
);

CREATE TABLE [TMPiMoveDaleR_FEEDUPDATE] (
    [FUUID] INT NOT NULL,
    [fdUID] INT NULL,
    [fuCUSID] INT NULL,
    [fuNAME] VARCHAR(64) NULL,
    [fuADDR] VARCHAR(64) NULL,
    [fuCITY] VARCHAR(32) NULL,
    [fuSTATE] VARCHAR(2) NULL,
    [fuZIP] VARCHAR(10) NULL,
    [fuPHONE] VARCHAR(16) NULL,
    [fuALTPHONE] VARCHAR(16) NULL,
    [fuFAX] VARCHAR(16) NULL,
    [fuEMAIL_STRING] VARCHAR(96) NULL,
    [fuEMAIL_XML] VARCHAR(96) NULL,
    [fuURL] VARCHAR(512) NULL,
    [fuPROFILE] TINYINT NULL,
    [fuIMG1] VARCHAR(512) NULL,
    [fuIMG2] VARCHAR(512) NULL,
    [fuIMG3] VARCHAR(512) NULL,
    [fuIMG4] VARCHAR(512) NULL,
    [fuSHOWOTHER] BIT NULL,
    [fuCAO] BIT NULL,
    [fuAdStart] VARCHAR(256) NULL,
    [fuAdEnd] VARCHAR(256) NULL,
    [fuAllPreferred] BIT NULL,
    [fuAllBoxed] BIT NULL,
    [fuUIDMaster] INT NULL
);

CREATE TABLE [TMPiMoveDaleR_RatchetClient] (
    [rcc_ID] INT NOT NULL,
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
    [rcc_Site_Zip] VARCHAR(5) NOT NULL,
    [rcc_Site_URL] VARCHAR(512) NOT NULL,
    [rcc_Site_Email_Text] VARCHAR(128) NOT NULL,
    [rcc_Site_Email_XML] VARCHAR(128) NOT NULL,
    [rcc_Site_Email_Contact] VARCHAR(128) NOT NULL,
    [rcc_Notes] VARCHAR(1024) NOT NULL,
    [rcc_Site_ContactName] VARCHAR(128) NOT NULL,
    [rdg_ID] INT NOT NULL,
    [bty_ID] INT NOT NULL
);

CREATE TABLE [TMPiMoveDaleR_RatchetFeedTracker] (
    [ffID] INT NOT NULL,
    [acc_ID_Submitted] INT NULL,
    [acc_ID_Submitted_Event] INT NULL,
    [ffDateSubmitted] DATETIME NULL,
    [aso_ID] INT NULL,
    [ftID] INT NULL,
    [ffDateSold] DATETIME NULL,
    [ffIDMaster] INT NULL,
    [ffCusID] INT NULL,
    [ffwName] VARCHAR(64) NULL,
    [acc_ID_Rep] INT NULL,
    [ffwAddress1] VARCHAR(64) NULL,
    [ffwAddress2] VARCHAR(64) NULL,
    [ffwCity] VARCHAR(32) NULL,
    [ffwState] VARCHAR(2) NULL,
    [ffwZip] VARCHAR(10) NULL,
    [ffwPhone] VARCHAR(16) NULL,
    [ffwURL] VARCHAR(512) NULL,
    [ffwEmail_String] VARCHAR(96) NULL,
    [ffwEmail_XML] VARCHAR(96) NULL,
    [ffwEmail_Contact] VARCHAR(96) NULL,
    [ffbCompany] VARCHAR(64) NULL,
    [ffbContact] VARCHAR(64) NULL,
    [ffbAddress1] VARCHAR(64) NULL,
    [ffbAddress2] VARCHAR(64) NULL,
    [ffbCity] VARCHAR(32) NULL,
    [ffbState] VARCHAR(2) NULL,
    [ffbZip] VARCHAR(10) NULL,
    [ffbPhone] VARCHAR(16) NULL,
    [ffbEmail] VARCHAR(96) NULL,
    [ffPrice] MONEY NULL,
    [fiID] INT NULL,
    [ffAggregatorName] VARCHAR(64) NULL,
    [ffAggregatorContact] VARCHAR(64) NULL,
    [ffAggregatorAddress] VARCHAR(64) NULL,
    [ffAggregatorPhone] VARCHAR(16) NULL,
    [ffAggregatorEmail] VARCHAR(96) NULL,
    [ffNotes] VARCHAR(8000) NULL,
    [ffDateOfEvent] DATETIME NULL,
    [ffDateAggregatorContact] DATETIME NULL,
    [ffDateAggregatorETAConnect] DATETIME NULL,
    [ffDateLive] DATETIME NULL,
    [ffDateOFReqSent] DATETIME NULL,
    [ffDateOFLive] DATETIME NULL,
    [ffDateSalesLiveQA] DATETIME NULL,
    [ffDateSalesOFQA] DATETIME NULL,
    [fsID] INT NULL,
    [wmtID] INT NULL,
    [fduid] INT NULL,
    [ffTrackingNumber] VARCHAR(16) NULL,
    [ffwContact_Name] VARCHAR(255) NULL,
    [ffFirstMonthPrice] MONEY NULL,
    [ffLastMonthPrice] MONEY NULL,
    [rdg_ID] INT NOT NULL,
    [ffExcludeRAN] BIT NULL,
    [ffExcludeRCY] BIT NULL
);

CREATE TABLE [ToCarsDirect_Ads] (
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
    [adIntColor] VARCHAR(512) NULL,
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
    [sellerType] VARCHAR(64) NULL
);

CREATE TABLE [ToCarsDirect_Dealers] (
    [dlrID] VARCHAR(32) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(100) NULL,
    [dlrCity] VARCHAR(50) NULL,
    [dlrState] VARCHAR(10) NULL,
    [dlrZip] VARCHAR(32) NULL,
    [dlrEmail] VARCHAR(200) NULL,
    [dlrURL] VARCHAR(512) NULL,
    [dlrPhone] VARCHAR(32) NULL
);

CREATE TABLE [TOP10] (
    [ID] INT NOT NULL -- PK,
    [BUNCH] TINYINT NULL,
    [TITLE] VARCHAR(64) NOT NULL,
    [RANK] TINYINT NOT NULL,
    [VEHICLE] VARCHAR(64) NOT NULL,
    [TOTAL] INT NULL,
    [SOURCE] VARCHAR(64) NULL,
    [SOURCEHREF] VARCHAR(255) NULL,
    [CARHREF] VARCHAR(255) NULL
);

CREATE TABLE [toweb2carz_ads] (
    [DEALER_ID] VARCHAR(256) NULL,
    [TYPE] VARCHAR(256) NULL,
    [STOCK_ID] VARCHAR(256) NULL,
    [VIN] VARCHAR(256) NULL,
    [MAKE] VARCHAR(256) NULL,
    [MODEL] VARCHAR(256) NULL,
    [YEAR] VARCHAR(256) NULL,
    [TRIM] VARCHAR(256) NULL,
    [PRICE] VARCHAR(256) NULL,
    [MILES] VARCHAR(256) NULL,
    [BODY] VARCHAR(256) NULL,
    [ENGINE] VARCHAR(256) NULL,
    [FUEL] VARCHAR(256) NULL,
    [CYLINDERS] VARCHAR(256) NULL,
    [DOORS] VARCHAR(256) NULL,
    [COLOR_EXTERIOR] VARCHAR(256) NULL,
    [COLOR_INTERIOR] VARCHAR(256) NULL,
    [CERTIFIED] VARCHAR(256) NULL,
    [TRANSMISSION] VARCHAR(256) NULL,
    [SPEEDS] VARCHAR(256) NULL,
    [WARRANTY] VARCHAR(256) NULL,
    [DISPLACEMENT] VARCHAR(256) NULL,
    [OPTIONS] VARCHAR(8000) NULL,
    [DESCRIPTION] VARCHAR(8000) NULL,
    [PROMOTIONAL_TEXT] VARCHAR(8000) NULL,
    [PHOTO_URLS] VARCHAR(8000) NULL
);

CREATE TABLE [toweb2carz_dealers] (
    [DEALER_ID] VARCHAR(32) NULL,
    [DEALER_NAME] VARCHAR(64) NULL,
    [ADDRESS] VARCHAR(64) NULL,
    [CITY] VARCHAR(64) NULL,
    [STATE] VARCHAR(24) NULL,
    [ZIP] VARCHAR(24) NULL,
    [CONTACT_NAME] VARCHAR(64) NULL,
    [CONTACT_EMAIL] VARCHAR(225) NULL,
    [PHONE] VARCHAR(24) NULL,
    [LEAD_FORMAT] VARCHAR(24) NULL,
    [LEAD_EMAIL] VARCHAR(156) NULL,
    [URL] VARCHAR(512) NULL
);

CREATE TABLE [TPDLINFO] (
    [MEMID] INT NOT NULL,
    [MEMUID] VARCHAR(64) NOT NULL,
    [MEMPWD] VARCHAR(32) NOT NULL,
    [MEMNAME] VARCHAR(64) NOT NULL,
    [MEMADDR] VARCHAR(64) NULL,
    [MEMCITY] VARCHAR(32) NULL,
    [MEMSTATE] VARCHAR(2) NOT NULL,
    [MEMZIP] VARCHAR(10) NOT NULL,
    [MEMEMAIL] VARCHAR(64) NULL,
    [MEMPHONE] VARCHAR(16) NULL,
    [MEMCREATED] SMALLDATETIME NOT NULL,
    [PUBID] INT NOT NULL,
    [MAXEWORDS] INT NOT NULL,
    [MAXOWORDS] INT NOT NULL,
    [MAXADS] INT NOT NULL,
    [CUSID] INT NULL,
    [PACKAGE] INT NOT NULL,
    [ADRELEASE] INT NOT NULL,
    [DLNAME] VARCHAR(64) NULL,
    [DLADDR] VARCHAR(64) NULL,
    [DLCITY] VARCHAR(32) NULL,
    [DLSTATE] VARCHAR(2) NULL,
    [DLZIP] VARCHAR(10) NULL,
    [DLPHONE] VARCHAR(16) NULL,
    [DLALTPHONE] VARCHAR(16) NULL,
    [DLFAX] VARCHAR(16) NULL,
    [DLEMAIL] VARCHAR(96) NULL,
    [DLXMLEMAIL] BIT NULL,
    [DLURL] VARCHAR(512) NULL,
    [DLPROFILE] TINYINT NULL,
    [DLIMG1] VARCHAR(512) NULL,
    [DLIMG2] VARCHAR(512) NULL,
    [DLIMG3] VARCHAR(512) NULL,
    [DLIMG4] VARCHAR(512) NULL,
    [DLSHOWOTHER] BIT NULL,
    [DLCAO] BIT NULL,
    [DLADSTART] VARCHAR(256) NULL,
    [DLADEND] VARCHAR(256) NULL,
    [DLALLPREFERRED] BIT NULL,
    [DLALLBOXED] BIT NULL,
    [dlpubid] INT NULL,
    [DLSOMEPREFERRED] INT NOT NULL,
    [DLSOMEBOXED] INT NOT NULL,
    [DLTEST] BIT NOT NULL,
    [DLSALESREP] VARCHAR(64) NULL,
    [DSID] INT NOT NULL,
    [dspubid] INT NOT NULL,
    [SCLID] INT NOT NULL,
    [ECLSNUMBER] INT NULL,
    [DSYEAR] SMALLINT NOT NULL,
    [DSMAKE] VARCHAR(32) NOT NULL,
    [DSMODEL] VARCHAR(32) NOT NULL,
    [DSSMODEL] VARCHAR(32) NULL,
    [DSADTEXT] VARCHAR(4096) NOT NULL,
    [DSHEADLINE] VARCHAR(255) NULL,
    [DSBOXED] BIT NULL,
    [DSINS] TINYINT NOT NULL,
    [DSPRICE] MONEY NOT NULL,
    [DSENTERED] SMALLDATETIME NOT NULL,
    [DSMODIFIED] SMALLDATETIME NOT NULL,
    [DSSTATUS] TINYINT NOT NULL,
    [DSADTYPE] TINYINT NOT NULL,
    [DSEMAIL] VARCHAR(64) NULL,
    [DSZIP] VARCHAR(10) NULL,
    [DSPHONE] VARCHAR(12) NOT NULL,
    [DSNOPHONE] BIT NOT NULL,
    [DSPREFERRED] BIT NOT NULL,
    [ADID] INT NULL,
    [DSPACKAGE] INT NULL,
    [DSVIN] VARCHAR(17) NULL,
    [DSREASON] VARCHAR(512) NULL,
    [DSTHUMB] VARCHAR(255) NULL,
    [DSSTOCKNO] VARCHAR(32) NULL
);

CREATE TABLE [TransferInfo] (
    [TLID] INT NOT NULL -- PK,
    [subid] INT NOT NULL -- PK,
    [dyntext] VARCHAR(4000) NULL,
    [year] INT NULL,
    [make] VARCHAR(32) NULL,
    [model] VARCHAR(32) NULL,
    [submodel] VARCHAR(32) NULL,
    [price] MONEY NULL,
    [sclid] INT NULL,
    [eclsnumber] INT NULL,
    [adtext] VARCHAR(8000) NULL,
    [email] VARCHAR(64) NULL,
    [phone] VARCHAR(15) NULL,
    [nophone] BIT NULL,
    [boxed] BIT NULL,
    [photo] BIT NULL,
    [headline] VARCHAR(255) NULL,
    [preferred] BIT NULL,
    [package] INT NULL,
    [pdestination] VARCHAR(64) NULL,
    [ldestination] VARCHAR(64) NULL,
    [memname] VARCHAR(64) NULL,
    [memaddr] VARCHAR(128) NULL,
    [memcity] VARCHAR(64) NULL,
    [memstate] VARCHAR(2) NULL,
    [memzip] VARCHAR(50) NULL,
    [leadin] VARCHAR(1000) NULL,
    [webedid] INT NULL,
    [endedid] INT NULL,
    [adnum] INT NULL,
    [cusid] INT NULL,
    [edid] VARCHAR(64) NULL,
    [feat] VARCHAR(20) NULL
);

CREATE TABLE [Translate] (
    [trID] INT NOT NULL -- PK,
    [wEdID] INT NOT NULL,
    [wSclID] INT NOT NULL,
    [eEdID] INT NOT NULL,
    [eClsID] INT NOT NULL,
    [eClsNumber] INT NOT NULL,
    [eClsName] VARCHAR(255) NOT NULL,
    [eClsOrder] INT NOT NULL,
    [eClsWebSubmit] BIT NOT NULL
);

CREATE TABLE [TreisterCustomer] (
    [DlrID] VARCHAR(16) NULL,
    [DlrNAME] VARCHAR(64) NULL,
    [DlrADDR] VARCHAR(128) NULL,
    [DlrCITY] VARCHAR(64) NULL,
    [DlrSTATE] VARCHAR(3) NULL,
    [DlrZIP] VARCHAR(5) NULL,
    [DlrPHONE] VARCHAR(16) NULL,
    [DlrEMAIL] VARCHAR(128) NULL,
    [DlrURL] VARCHAR(64) NULL,
    [DlrFile] VARCHAR(128) NULL
);

CREATE TABLE [TreisterData] (
    [dlrID] VARCHAR(16) NULL,
    [adStock] VARCHAR(16) NULL,
    [adYear] VARCHAR(16) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(64) NULL,
    [adTrim] VARCHAR(64) NULL,
    [adVin] VARCHAR(32) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adPrice] VARCHAR(16) NULL,
    [adExtColor] VARCHAR(32) NULL,
    [adIntColor] VARCHAR(32) NULL,
    [adTransmission] VARCHAR(32) NULL,
    [adPics] VARCHAR(4096) NULL,
    [adOptions] VARCHAR(4096) NULL,
    [id] INT NOT NULL,
    [adSection] VARCHAR(32) NULL,
    [adText] VARCHAR(4096) NULL
);

CREATE TABLE [TurboChanges] (
    [tucID] INT NOT NULL -- PK,
    [fdUID] INT NOT NULL,
    [tucSubmitted] DATETIME NOT NULL,
    [tucDestinations] XML NULL,
    [tucPhotoOverlay] BIT NOT NULL,
    [tucNotes] VARCHAR(8000) NOT NULL,
    [user_acc_id] INT NULL
);

CREATE TABLE [TurboPLDCampaigns] (
    [subscripionId] BIGINT NULL,
    [campaignId] BIGINT NULL,
    [name] VARCHAR(128) NULL,
    [Start_Date] DATE NULL,
    [End_Date] DATE NULL,
    [clientId] BIGINT NULL,
    [Sales_Channel] VARCHAR(128) NULL,
    [feedId] INT NOT NULL,
    [fdUid] INT NOT NULL,
    [insertDate] DATETIME NOT NULL,
    [active] BIT NOT NULL,
    [bid] MONEY NULL,
    [TurboDailyBudget] DECIMAL(10,4) NULL,
    [FacebookDailyBidAmount] NUMERIC(10,4) NULL,
    [FacebookDailyBudget] NUMERIC(10,4) NULL
);

CREATE TABLE [TurboSnapshot] (
    [turbodate] DATETIME NOT NULL -- PK,
    [turbofile] TEXT NOT NULL,
    [accid] INT NOT NULL
);

CREATE TABLE [TurboVerifyAccount] (
    [tvaID] INT NOT NULL -- PK,
    [tvaDate] DATETIME NOT NULL,
    [tvaUser] VARCHAR(64) NOT NULL,
    [tvaMachine] VARCHAR(64) NOT NULL,
    [tvaIP] VARCHAR(16) NOT NULL,
    [user_acc_id] INT NOT NULL,
    [aso_Value] VARCHAR(128) NOT NULL,
    [tvaResult] VARCHAR(1024) NULL
);

CREATE TABLE [UpSell] (
    [usID] TINYINT NOT NULL -- PK,
    [usName] VARCHAR(32) NOT NULL,
    [usActive] BIT NOT NULL,
    [usDefault] BIT NOT NULL
);

CREATE TABLE [Upsells] (
    [upID] INT NOT NULL -- PK,
    [upName] VARCHAR(32) NOT NULL,
    [upSort] INT NOT NULL,
    [upActive] BIT NOT NULL
);

CREATE TABLE [User_Test] (
    [UsrID] INT NOT NULL -- PK,
    [UsrEmail] VARCHAR(255) NOT NULL -- PK,
    [UsrPassword] VARCHAR(50) NOT NULL,
    [UsrFirstName] VARCHAR(50) NOT NULL,
    [UsrLastName] VARCHAR(50) NOT NULL,
    [UsrAddress] VARCHAR(50) NOT NULL,
    [UsrCity] VARCHAR(50) NOT NULL,
    [UsrState] VARCHAR(2) NOT NULL,
    [UsrZip] VARCHAR(50) NOT NULL,
    [UsrPhone] VARCHAR(20) NOT NULL,
    [UsrActive] BIT NOT NULL
);

CREATE TABLE [v12softwareData] (
    [dlrID] VARCHAR(32) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddr] VARCHAR(128) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZip] VARCHAR(10) NULL,
    [dlrPhone] VARCHAR(18) NULL,
    [adID] VARCHAR(12) NULL,
    [adVin] VARCHAR(32) NULL,
    [adCondition] VARCHAR(32) NULL,
    [adStock] VARCHAR(32) NULL,
    [adYear] VARCHAR(4) NULL,
    [adMake] VARCHAR(42) NULL,
    [adModel] VARCHAR(128) NULL,
    [adBody] VARCHAR(32) NULL,
    [adDoors] VARCHAR(12) NULL,
    [adTrim] VARCHAR(64) NULL,
    [adExtColor] VARCHAR(64) NULL,
    [adIntColor] VARCHAR(64) NULL,
    [adEngine] VARCHAR(64) NULL,
    [adFuelType] VARCHAR(32) NULL,
    [adDriveTrain] VARCHAR(64) NULL,
    [adTransmission] VARCHAR(64) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adPrice] VARCHAR(32) NULL,
    [adCertified] VARCHAR(12) NULL,
    [adOptions] VARCHAR(MAX) NULL,
    [adDescription] VARCHAR(MAX) NULL,
    [adPics] VARCHAR(MAX) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [VariableCost] (
    [vcID] INT NOT NULL -- PK,
    [rID] INT NULL,
    [vcMin] MONEY NULL,
    [vcMax] MONEY NULL,
    [vcRate] MONEY NULL
);

CREATE TABLE [vastTemp] (
    [id] VARCHAR(10) NULL,
    [secondary_source] VARCHAR(64) NULL,
    [year] VARCHAR(32) NULL,
    [make] VARCHAR(64) NULL,
    [model] VARCHAR(128) NULL,
    [title] VARCHAR(1024) NULL,
    [url] VARCHAR(1024) NULL,
    [image_url] VARCHAR(8000) NULL,
    [price] VARCHAR(13) NULL,
    [create_time] VARCHAR(24) NULL,
    [expire_time] VARCHAR(24) NULL,
    [description] VARCHAR(2024) NULL,
    [category] VARCHAR(256) NULL,
    [zip_code] VARCHAR(10) NULL,
    [country] VARCHAR(8) NULL,
    [lead] VARCHAR(5) NULL
);

CREATE TABLE [VAutoData] (
    [dlrID] VARCHAR(45) NULL,
    [adID] VARCHAR(24) NULL,
    [adStock] VARCHAR(32) NULL,
    [adVIN] VARCHAR(24) NULL,
    [adSection] VARCHAR(10) NULL,
    [adMake] VARCHAR(64) NULL,
    [adModel] VARCHAR(128) NULL,
    [adSubModel] VARCHAR(64) NULL,
    [adYear] VARCHAR(10) NULL,
    [adMiles] VARCHAR(12) NULL,
    [adColor] VARCHAR(128) NULL,
    [adCondition] VARCHAR(10) NULL,
    [adHeadline] VARCHAR(200) NULL,
    [adText] VARCHAR(8000) NULL,
    [adCustomText] VARCHAR(8000) NULL,
    [adPrice] VARCHAR(16) NULL,
    [adPhone] VARCHAR(24) NULL,
    [adPics] VARCHAR(MAX) NULL,
    [adThumbs] VARCHAR(MAX) NULL,
    [dlrName] VARCHAR(128) NULL,
    [MSRP] VARCHAR(12) NULL,
    [adCertified] VARCHAR(12) NULL,
    [adStyle] VARCHAR(64) NULL,
    [adGenericExteriorColor] VARCHAR(64) NULL,
    [adInteriorColor] VARCHAR(64) NULL,
    [adInvoice] VARCHAR(12) NULL,
    [adMiscPrice1] VARCHAR(12) NULL,
    [adMiscPrice2] VARCHAR(12) NULL,
    [adModelCode] VARCHAR(32) NULL,
    [adDateInStock] VARCHAR(16) NULL,
    [adWheelbase] VARCHAR(12) NULL,
    [adDoors] VARCHAR(12) NULL,
    [adTransmission] VARCHAR(MAX) NULL,
    [adDrivetype] VARCHAR(12) NULL,
    [adEngineDescription] VARCHAR(120) NULL,
    [adEngineCylinders] VARCHAR(12) NULL,
    [adEngineDisplacement] VARCHAR(12) NULL,
    [adFuel] VARCHAR(12) NULL,
    [adEPACity] VARCHAR(12) NULL,
    [adEPAHighway] VARCHAR(12) NULL,
    [adVDPURL] VARCHAR(256) NULL,
    [dlraddress] VARCHAR(64) NULL,
    [dlrcity] VARCHAR(64) NULL,
    [dlrstate] VARCHAR(64) NULL,
    [dlrzip] VARCHAR(64) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [VAutoDatatemp] (
    [dlrID] VARCHAR(32) NULL,
    [adID] VARCHAR(24) NULL,
    [adStock] VARCHAR(32) NULL,
    [adVIN] VARCHAR(24) NULL,
    [adSection] VARCHAR(10) NULL,
    [adMake] VARCHAR(64) NULL,
    [adModel] VARCHAR(128) NULL,
    [adSubModel] VARCHAR(64) NULL,
    [adYear] VARCHAR(10) NULL,
    [adMiles] VARCHAR(12) NULL,
    [adColor] VARCHAR(128) NULL,
    [adCondition] VARCHAR(10) NULL,
    [adHeadline] VARCHAR(200) NULL,
    [adText] VARCHAR(8000) NULL,
    [adCustomText] VARCHAR(8000) NULL,
    [adPrice] VARCHAR(12) NULL,
    [adPhone] VARCHAR(24) NULL,
    [adPics] VARCHAR(MAX) NULL,
    [adThumbs] VARCHAR(MAX) NULL,
    [dlrName] VARCHAR(128) NULL,
    [MSRP] VARCHAR(12) NULL,
    [adCertified] VARCHAR(12) NULL,
    [adStyle] VARCHAR(64) NULL,
    [adGenericExteriorColor] VARCHAR(64) NULL,
    [adInteriorColor] VARCHAR(64) NULL,
    [adInvoice] VARCHAR(12) NULL,
    [adMiscPrice1] VARCHAR(12) NULL,
    [adMiscPrice2] VARCHAR(12) NULL,
    [adModelCode] VARCHAR(32) NULL,
    [adDateInStock] VARCHAR(16) NULL,
    [adWheelbase] VARCHAR(12) NULL,
    [adDoors] VARCHAR(12) NULL,
    [adTransmission] VARCHAR(64) NULL,
    [adDrivetype] VARCHAR(12) NULL,
    [adEngineDescription] TEXT NULL,
    [adEngineCylinders] VARCHAR(12) NULL,
    [adEngineDisplacement] VARCHAR(12) NULL,
    [adFuel] VARCHAR(12) NULL,
    [adEPACity] VARCHAR(12) NULL,
    [adEPAHighway] VARCHAR(12) NULL,
    [adVDPURL] VARCHAR(256) NULL
);

CREATE TABLE [VAutoDataTim] (
    [dlrID] VARCHAR(MAX) NULL,
    [adID] VARCHAR(MAX) NULL,
    [adStock] VARCHAR(MAX) NULL,
    [adVIN] VARCHAR(MAX) NULL,
    [adSection] VARCHAR(MAX) NULL,
    [adMake] VARCHAR(MAX) NULL,
    [adModel] VARCHAR(MAX) NULL,
    [adSubModel] VARCHAR(MAX) NULL,
    [adYear] VARCHAR(MAX) NULL,
    [adMiles] VARCHAR(MAX) NULL,
    [adColor] VARCHAR(MAX) NULL,
    [adCondition] VARCHAR(MAX) NULL,
    [adHeadline] VARCHAR(MAX) NULL,
    [adText] VARCHAR(MAX) NULL,
    [adCustomText] VARCHAR(MAX) NULL,
    [adPrice] VARCHAR(MAX) NULL,
    [adPhone] VARCHAR(MAX) NULL,
    [adPics] VARCHAR(MAX) NULL,
    [adThumbs] VARCHAR(MAX) NULL,
    [dlrName] VARCHAR(MAX) NULL,
    [MSRP] VARCHAR(MAX) NULL,
    [adCertified] VARCHAR(MAX) NULL,
    [adStyle] VARCHAR(MAX) NULL,
    [adGenericExteriorColor] VARCHAR(MAX) NULL,
    [adInteriorColor] VARCHAR(MAX) NULL,
    [adInvoice] VARCHAR(MAX) NULL,
    [adMiscPrice1] VARCHAR(MAX) NULL,
    [adMiscPrice2] VARCHAR(MAX) NULL,
    [adModelCode] VARCHAR(MAX) NULL,
    [adDateInStock] VARCHAR(MAX) NULL,
    [adWheelbase] VARCHAR(MAX) NULL,
    [adDoors] VARCHAR(MAX) NULL,
    [adTransmission] VARCHAR(MAX) NULL,
    [adDrivetype] VARCHAR(MAX) NULL,
    [adEngineDescription] VARCHAR(MAX) NULL,
    [adEngineCylinders] VARCHAR(MAX) NULL,
    [adEngineDisplacement] VARCHAR(MAX) NULL,
    [adFuel] VARCHAR(MAX) NULL,
    [adEPACity] VARCHAR(MAX) NULL,
    [adEPAHighway] VARCHAR(MAX) NULL,
    [adVDPURL] VARCHAR(MAX) NULL,
    [dlraddress] VARCHAR(MAX) NULL,
    [dlrcity] VARCHAR(MAX) NULL,
    [dlrstate] VARCHAR(MAX) NULL,
    [dlrzip] VARCHAR(MAX) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [VDPtoVIN] (
    [veh_vin] VARCHAR(32) NULL,
    [veh_url] VARCHAR(8000) NULL
);

CREATE TABLE [VERIFIED] (
    [memid] INT NOT NULL,
    [guid] VARCHAR(50) NOT NULL,
    [verified] BIT NOT NULL
);

CREATE TABLE [VinControlAds] (
    [dlrid] VARCHAR(32) NULL,
    [adID] VARCHAR(32) NULL,
    [adStock] VARCHAR(32) NULL,
    [adVIN] VARCHAR(32) NULL,
    [adSection] VARCHAR(32) NULL,
    [adType] VARCHAR(32) NULL,
    [adCertified] VARCHAR(24) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(32) NULL,
    [adSubModel] VARCHAR(64) NULL,
    [adYear] VARCHAR(4) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adColor] VARCHAR(64) NULL,
    [adCondition] VARCHAR(32) NULL,
    [adHeadline] VARCHAR(1024) NULL,
    [adText] VARCHAR(6500) NULL,
    [adCustomText] VARCHAR(6500) NULL,
    [adPrice] VARCHAR(10) NULL,
    [adPhone] VARCHAR(18) NULL,
    [adThumbs] VARCHAR(MAX) NULL,
    [adPics] VARCHAR(MAX) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [VinControlDealers] (
    [dlrid] VARCHAR(32) NULL,
    [dlrName] VARCHAR(32) NULL,
    [dlrAddr] VARCHAR(128) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZip] VARCHAR(10) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrURL] VARCHAR(512) NULL,
    [dlrPhone] VARCHAR(18) NULL
);

CREATE TABLE [VinSolutionsData] (
    [dlrid] VARCHAR(MAX) NULL,
    [usednew] VARCHAR(10) NULL,
    [year] VARCHAR(100) NULL,
    [make] VARCHAR(32) NULL,
    [model] VARCHAR(128) NULL,
    [trim] VARCHAR(MAX) NULL,
    [bodystyle] VARCHAR(64) NULL,
    [stocknumber] VARCHAR(32) NULL,
    [vin] VARCHAR(25) NULL,
    [mileage] VARCHAR(100) NULL,
    [price] VARCHAR(100) NULL,
    [engine] VARCHAR(64) NULL,
    [transmission] VARCHAR(64) NULL,
    [color] VARCHAR(64) NULL,
    [interior] VARCHAR(4000) NULL,
    [adtext] VARCHAR(MAX) NULL,
    [options] VARCHAR(MAX) NULL,
    [lotprice] VARCHAR(128) NULL,
    [msrp] VARCHAR(12) NULL,
    [invoice] VARCHAR(MAX) NULL,
    [imageurls] VARCHAR(MAX) NULL,
    [certified] VARCHAR(35) NULL,
    [modelcode] VARCHAR(64) NULL,
    [autoid] VARCHAR(100) NULL,
    [internetspecial] VARCHAR(32) NULL,
    [inventorydate] VARCHAR(16) NULL,
    [carfaxoneowner] VARCHAR(32) NULL,
    [carfaxavailable] VARCHAR(400) NULL,
    [videoplayerurl] VARCHAR(255) NULL,
    [videoembedurl] VARCHAR(255) NULL,
    [lastupdated] VARCHAR(24) NULL,
    [custom1] VARCHAR(4000) NULL,
    [custom2] VARCHAR(4000) NULL,
    [custom3] VARCHAR(4000) NULL,
    [custom4] VARCHAR(4000) NULL,
    [custom5] VARCHAR(8000) NULL,
    [lastphotoupdateutc] VARCHAR(64) NULL,
    [doors] VARCHAR(32) NULL,
    [modelseries] VARCHAR(64) NULL,
    [enginecylinders] VARCHAR(20) NULL,
    [mpg_city] VARCHAR(32) NULL,
    [mpg_highway] VARCHAR(128) NULL,
    [fuel_type] VARCHAR(128) NULL,
    [cab_type] VARCHAR(128) NULL,
    [cost] VARCHAR(32) NULL,
    [compareprice] VARCHAR(32) NULL,
    [drivetrain] VARCHAR(128) NULL,
    [VDP] VARCHAR(MAX) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [VOIDTYPE] (
    [VDTYPE] INT NOT NULL -- PK,
    [VDDESC] VARCHAR(50) NOT NULL
);

CREATE TABLE [vw_StevenRatchetTrackerReport] (
    [ffID] INT NOT NULL -- PK,
    [ffDateSubmitted] DATETIME NULL,
    [aso_id] INT NULL,
    [aso_name] VARCHAR(128) NULL,
    [ftID] INT NULL,
    [ftName] VARCHAR(32) NOT NULL,
    [acc_id_rep] INT NULL,
    [acc_name_rep] VARCHAR(128) NOT NULL,
    [ffIDMaster] INT NULL,
    [ffwName] VARCHAR(64) NULL,
    [ffwPhone] VARCHAR(16) NULL,
    [ffCusID] INT NULL,
    [ffwZip] VARCHAR(10) NULL,
    [ffPrice] MONEY NULL,
    [ffAggregatorName] VARCHAR(64) NULL,
    [ffnotes] VARCHAR(8000) NULL,
    [ffdateofevent] DATETIME NULL,
    [ffDateLive] DATETIME NULL,
    [dlrid] INT NULL,
    [RecentAdCount] INT NULL,
    [destid] VARCHAR(256) NULL,
    [fduid] INT NULL,
    [arl_id] INT NULL,
    [ffExcludeRAN] BIT NULL,
    [ffExcludeRCY] BIT NULL,
    [fiName] VARCHAR(32) NULL,
    [fiValue] INT NULL
);

CREATE TABLE [vw_StevenRatchetTrackerReport_Acct] (
    [ID] INT NOT NULL -- PK,
    [ffDateSubmitted] DATETIME NULL,
    [aso_id] INT NULL,
    [aso_name] VARCHAR(128) NULL,
    [ftID] INT NULL,
    [ftName] VARCHAR(32) NOT NULL,
    [acc_id_rep] INT NULL,
    [acc_name_rep] VARCHAR(128) NOT NULL,
    [ffIDMaster] INT NULL,
    [ffwName] VARCHAR(64) NULL,
    [ffbPhone] VARCHAR(16) NULL,
    [ffCusID] INT NULL,
    [ffwZip] VARCHAR(10) NULL,
    [ffPrice] MONEY NULL,
    [ffAggregatorName] VARCHAR(64) NULL,
    [ffnotes] VARCHAR(8000) NULL,
    [ffdateofevent] DATETIME NULL,
    [ffDateLive] DATETIME NULL,
    [dlrid] INT NULL,
    [RecentAdCount] INT NULL,
    [destid] VARCHAR(256) NULL,
    [fduid] INT NULL,
    [arl_id] INT NULL,
    [ffExcludeRAN] BIT NULL,
    [ffExcludeRCY] BIT NULL,
    [fiName] VARCHAR(32) NULL,
    [fiValue] INT NULL
);

CREATE TABLE [vw_StevenRatchetTrackerReport_All] (
    [ffID] INT NOT NULL -- PK,
    [ffDateSubmitted] DATETIME NULL,
    [aso_id] INT NULL,
    [aso_name] VARCHAR(128) NULL,
    [pubid] VARCHAR(128) NOT NULL,
    [ftID] INT NULL,
    [ftName] VARCHAR(32) NOT NULL,
    [acc_id_rep] INT NULL,
    [acc_name_rep] VARCHAR(128) NOT NULL,
    [ffIDMaster] INT NULL,
    [ffwName] VARCHAR(64) NULL,
    [ffwPhone] VARCHAR(16) NULL,
    [ffCusID] INT NULL,
    [ffwZip] VARCHAR(10) NULL,
    [ffPrice] MONEY NULL,
    [ffAggregatorName] VARCHAR(64) NULL,
    [ffnotes] VARCHAR(8000) NULL,
    [ffdateofevent] DATETIME NULL,
    [ffDateLive] DATETIME NULL,
    [dlrid] INT NULL,
    [RecentAdCount] INT NULL,
    [destid] VARCHAR(256) NULL,
    [fduid] INT NULL,
    [arl_id] INT NULL,
    [ffExcludeRAN] BIT NULL,
    [ffExcludeRCY] BIT NULL,
    [fiName] VARCHAR(32) NULL,
    [fiValue] INT NULL
);

CREATE TABLE [vw_StevenRatchetTrackerReport_LastReactivate] (
    [ffid] INT NOT NULL -- PK,
    [ffidmaster] INT NULL,
    [fduid] INT NULL,
    [ffdateofevent] DATETIME NULL
);

CREATE TABLE [WasUsed_Change] (
    [fduid] INT NOT NULL,
    [dlrid] INT NULL,
    [fauid] INT NOT NULL,
    [adid] INT NULL,
    [fxmileage] VARCHAR(50) NULL,
    [fxcondition] VARCHAR(16) NULL,
    [ChangedOn] DATETIME NOT NULL
);

CREATE TABLE [WCD_Web] (
    [ID] BIGINT NOT NULL -- PK,
    [job_domain] VARCHAR(128) NULL,
    [job_lastexecution] DATETIME NULL,
    [veh_vin] VARCHAR(256) NULL,
    [veh_url] VARCHAR(1024) NULL,
    [DataSource] VARCHAR(256) NULL,
    [fdID] VARCHAR(32) NULL,
    [fdEdID] INT NULL,
    [acc_ID] INT NULL,
    [veh_stock] VARCHAR(32) NULL
);

CREATE TABLE [webadaddress] (
    [pubid] INT NOT NULL,
    [adnum] INT NOT NULL,
    [adaddress] VARCHAR(64) NOT NULL,
    [adzip] VARCHAR(5) NOT NULL
);

CREATE TABLE [WEBADS] (
    [PUBID] INT NOT NULL,
    [ADNUM] INT NOT NULL,
    [CUSID] INT NOT NULL,
    [EDID] INT NOT NULL,
    [SCLID] INT NOT NULL,
    [ADTYPE] TINYINT NOT NULL,
    [ADSPECIAL] TINYINT NOT NULL,
    [ADTOP] TINYINT NULL,
    [ADTEXT] VARCHAR(4096) NOT NULL,
    [ADHTML] TEXT NULL,
    [ADHEADLINE] VARCHAR(255) NULL,
    [ADBOXED] BIT NULL,
    [ADYEAR] SMALLINT NULL,
    [ADMAKE] VARCHAR(32) NULL,
    [ADMODEL] VARCHAR(128) NULL,
    [ADSUBMODEL] VARCHAR(32) NULL,
    [ADPRICE] MONEY NULL,
    [ADPHONE] VARCHAR(16) NULL,
    [ADPIC1] VARCHAR(512) NULL,
    [ADCOST] MONEY NULL
);

CREATE TABLE [WEBDEALERS] (
    [PUBID] INT NOT NULL,
    [CUSID] INT NOT NULL,
    [DLRNAME] VARCHAR(64) NULL,
    [DLRADDR] VARCHAR(64) NULL,
    [DLRCITY] VARCHAR(32) NULL,
    [DLRSTATE] VARCHAR(2) NOT NULL,
    [DLRZIP] VARCHAR(10) NULL,
    [DLRPHONE] VARCHAR(16) NOT NULL,
    [DLRALTPHONE] VARCHAR(16) NULL,
    [DLRFAX] VARCHAR(16) NULL,
    [DLREMAIL] VARCHAR(96) NULL,
    [DLRURL] VARCHAR(512) NULL,
    [IMG1] VARCHAR(512) NULL,
    [IMG2] VARCHAR(512) NULL,
    [IMG3] VARCHAR(512) NULL,
    [DLRCAO] BIT NOT NULL
);

CREATE TABLE [WebFeatures] (
    [wfID] INT NOT NULL -- PK,
    [pubID] INT NOT NULL,
    [wftID] INT NOT NULL,
    [wfSourceID] INT NOT NULL,
    [wfSouceFeatureValue] VARCHAR(128) NOT NULL
);

CREATE TABLE [WebFeaturesTranslate] (
    [wftID] INT NOT NULL -- PK,
    [wftName] VARCHAR(128) NOT NULL,
    [wftSourceTable] INT NOT NULL,
    [wftSourceFeature] INT NOT NULL
);

CREATE TABLE [WebManagementTeam] (
    [wmtID] INT NOT NULL -- PK,
    [wmtName] VARCHAR(64) NOT NULL
);

CREATE TABLE [WebPackageAging_Combine] (
    [office] VARCHAR(64) NULL,
    [db] NVARCHAR(128) NOT NULL -- PK,
    [cusid] INT NOT NULL -- PK,
    [cuscompany] VARCHAR(64) NULL,
    [cusphone] VARCHAR(16) NOT NULL,
    [EmpName] VARCHAR(65) NULL,
    [eBillAddress] VARCHAR(64) NULL,
    [BillingType] VARCHAR(10) NOT NULL,
    [sum_slscost] MONEY NULL,
    [max_slscost] MONEY NULL,
    [min_slscost] MONEY NULL,
    [cnt_slsrundate] INT NULL,
    [max_slsrundate] DATETIME NULL,
    [min_slsrundate] DATETIME NULL,
    [FED] MONEY NULL,
    [LCL] MONEY NULL,
    [BAN] MONEY NULL,
    [ADV] MONEY NULL,
    [PKGNUM] FLOAT NULL,
    [PKG] MONEY NULL,
    [aging_cusid] INT NULL,
    [description] VARCHAR(64) NULL,
    [aging_cost] MONEY NULL,
    [aging_payments] MONEY NULL,
    [aging_curr] MONEY NULL,
    [aging_curr_date] VARCHAR(16) NULL,
    [aging_30] MONEY NULL,
    [aging_30_date] VARCHAR(16) NULL,
    [aging_60] MONEY NULL,
    [aging_60_date] VARCHAR(16) NULL,
    [aging_90plus] MONEY NULL,
    [aso_ID] INT NULL
);

CREATE TABLE [WebUntanglerAds] (
    [dlrID] VARCHAR(12) NULL,
    [adID] VARCHAR(25) NULL,
    [adStock] VARCHAR(16) NULL,
    [adVIN] VARCHAR(25) NULL,
    [adSection] VARCHAR(23) NULL,
    [adSCLID] VARCHAR(9) NULL,
    [adCertified] VARCHAR(9) NULL,
    [adMake] VARCHAR(32) NULL,
    [adModel] VARCHAR(32) NULL,
    [adSubModel] VARCHAR(128) NULL,
    [adYear] VARCHAR(12) NULL,
    [adMiles] VARCHAR(16) NULL,
    [adColor] VARCHAR(32) NULL,
    [adCondition] VARCHAR(16) NULL,
    [adHeadline] VARCHAR(64) NULL,
    [adText] VARCHAR(4096) NULL,
    [adCustom] VARCHAR(4096) NULL,
    [adPrice] VARCHAR(16) NULL,
    [adPhone] VARCHAR(16) NULL,
    [adPic1t] VARCHAR(4096) NULL,
    [adPic1] VARCHAR(4096) NULL,
    [adPic2] VARCHAR(4096) NULL,
    [adPic3] VARCHAR(4096) NULL,
    [adPic4] VARCHAR(4096) NULL,
    [adPics] VARCHAR(MAX) NULL,
    [adThumbs] VARCHAR(MAX) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [WebUntanglerDealers] (
    [dlrID] VARCHAR(12) NULL,
    [dlrName] VARCHAR(64) NULL,
    [dlrAddress] VARCHAR(64) NULL,
    [dlrCity] VARCHAR(43) NULL,
    [dlrState] VARCHAR(8) NULL,
    [dlrZIP] VARCHAR(8) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrURL] VARCHAR(128) NULL,
    [dlrPhone] VARCHAR(16) NULL
);

CREATE TABLE [whoscalling_lingo] (
    [wcl_id] INT NOT NULL -- PK,
    [wcl_text] VARCHAR(500) NOT NULL,
    [wcl_created] DATETIME NOT NULL,
    [wcl_active] BIT NOT NULL
);

CREATE TABLE [whoscallingcampaignlist_endeavorused] (
    [PubDB] VARCHAR(16) NULL,
    [wc_ServiceNumber] VARCHAR(10) NULL,
    [wc_DateChecked] DATETIME NULL
);

CREATE TABLE [WhosCalllingChangeRequestLog] (
    [wc_RequestID] INT NOT NULL -- PK,
    [wc_RequestDate] DATETIME NOT NULL,
    [SubmittedBy] VARCHAR(32) NOT NULL,
    [ffIDMaster] INT NOT NULL,
    [SrcID] INT NOT NULL,
    [CusID] INT NOT NULL,
    [isNew] BIT NOT NULL,
    [wc_CustomerID] INT NULL,
    [wc_CampaignID] INT NULL,
    [wc_CampaignName] VARCHAR(150) NULL,
    [wc_Redirect] VARCHAR(50) NULL,
    [wc_ServiceNumber] VARCHAR(50) NULL,
    [wc_ExternalID] VARCHAR(150) NULL,
    [wc_IsWhisper] BIT NULL,
    [wc_Status] VARCHAR(50) NULL
);

CREATE TABLE [WhosCalllingMasterCampaign] (
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
    [wc_CustomerID] INT NOT NULL,
    [ActiveFeed] INT NOT NULL,
    [ActiveEndeavor] INT NOT NULL,
    [ActiveEndeavorOnline] INT NOT NULL
);

CREATE TABLE [whoscalllingmastercampaign_clean] (
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
    [wc_CustomerID] INT NOT NULL,
    [ActiveFeed] INT NOT NULL,
    [ActiveEndeavor] INT NOT NULL,
    [ActiveEndeavorOnline] INT NOT NULL
);

CREATE TABLE [windowstickerdata] (
    [dlrid] VARCHAR(64) NULL,
    [VIN] VARCHAR(32) NULL,
    [StockNumber] VARCHAR(32) NULL,
    [Year] VARCHAR(12) NULL,
    [Make] VARCHAR(64) NULL,
    [Model] VARCHAR(64) NULL,
    [MD] VARCHAR(64) NULL,
    [Engine] VARCHAR(64) NULL,
    [EngineSize] VARCHAR(32) NULL,
    [Transmission] VARCHAR(64) NULL,
    [DriveTrain] VARCHAR(32) NULL,
    [Trim] VARCHAR(32) NULL,
    [BodyStyle] VARCHAR(32) NULL,
    [CityFuel] VARCHAR(32) NULL,
    [HWYFuel] VARCHAR(32) NULL,
    [Mileage] VARCHAR(32) NULL,
    [Color] VARCHAR(64) NULL,
    [InteriorColor] VARCHAR(64) NULL,
    [InternetPrice] VARCHAR(32) NULL,
    [RetailPrice] VARCHAR(32) NULL,
    [Notes] VARCHAR(4000) NULL,
    [ShortReview] VARCHAR(4000) NULL,
    [Certified] VARCHAR(1) NULL,
    [NewUsed] VARCHAR(1) NULL,
    [Image_URLs] VARCHAR(4000) NULL,
    [Equipment] VARCHAR(4000) NULL,
    [Category] VARCHAR(50) NULL,
    [id] INT NOT NULL
);

CREATE TABLE [WindowStickerdatatemp] (
    [VIN] VARCHAR(32) NULL,
    [StockNumber] VARCHAR(32) NULL,
    [Year] VARCHAR(12) NULL,
    [Make] VARCHAR(64) NULL,
    [Model] VARCHAR(64) NULL,
    [MD] VARCHAR(64) NULL,
    [Engine] VARCHAR(64) NULL,
    [EngineSize] VARCHAR(32) NULL,
    [Transmission] VARCHAR(64) NULL,
    [DriveTrain] VARCHAR(32) NULL,
    [Trim] VARCHAR(32) NULL,
    [BodyStyle] VARCHAR(32) NULL,
    [CityFuel] VARCHAR(32) NULL,
    [HWYFuel] VARCHAR(32) NULL,
    [Mileage] VARCHAR(32) NULL,
    [Color] VARCHAR(64) NULL,
    [InteriorColor] VARCHAR(64) NULL,
    [InternetPrice] VARCHAR(32) NULL,
    [RetailPrice] VARCHAR(32) NULL,
    [Notes] VARCHAR(4000) NULL,
    [ShortReview] VARCHAR(4000) NULL,
    [Certified] VARCHAR(1) NULL,
    [NewUsed] VARCHAR(1) NULL,
    [Image_URLs] VARCHAR(4000) NULL,
    [Equipment] VARCHAR(4000) NULL
);

CREATE TABLE [windowstickerdealers] (
    [dlrID] VARCHAR(32) NULL,
    [dlrName] VARCHAR(32) NULL,
    [dlrAddr] VARCHAR(128) NULL,
    [dlrCity] VARCHAR(64) NULL,
    [dlrState] VARCHAR(32) NULL,
    [dlrZip] VARCHAR(10) NULL,
    [dlrEmail] VARCHAR(128) NULL,
    [dlrURL] VARCHAR(512) NULL,
    [dlrPhone] VARCHAR(18) NULL,
    [dlrFileName] VARCHAR(128) NULL,
    [active] BIT NOT NULL
);

CREATE TABLE [x__DEALERIMAGES] (
    [DSID] INT NOT NULL -- PK,
    [IMGURL] VARCHAR(255) NOT NULL -- PK,
    [IMGSORT] TINYINT NOT NULL
);

CREATE TABLE [x__DEALERLOGIN] (
    [MEMID] INT NOT NULL,
    [MAXEWORDS] INT NOT NULL,
    [MAXOWORDS] INT NOT NULL,
    [MAXADS] INT NOT NULL,
    [CUSID] INT NULL,
    [PACKAGE] INT NOT NULL,
    [ADRELEASE] INT NOT NULL,
    [DLNAME] VARCHAR(64) NULL,
    [DLADDR] VARCHAR(64) NULL,
    [DLCITY] VARCHAR(32) NULL,
    [DLSTATE] VARCHAR(2) NULL,
    [DLZIP] VARCHAR(10) NULL,
    [DLPHONE] VARCHAR(16) NULL,
    [DLALTPHONE] VARCHAR(16) NULL,
    [DLFAX] VARCHAR(16) NULL,
    [DLEMAIL] VARCHAR(96) NULL,
    [DLXMLEMAIL] BIT NULL,
    [DLURL] VARCHAR(512) NULL,
    [DLPROFILE] TINYINT NULL,
    [DLIMG1] VARCHAR(512) NULL,
    [DLIMG2] VARCHAR(512) NULL,
    [DLIMG3] VARCHAR(512) NULL,
    [DLIMG4] VARCHAR(512) NULL,
    [DLSHOWOTHER] BIT NULL,
    [DLCAO] BIT NULL,
    [DLADSTART] VARCHAR(256) NULL,
    [DLADEND] VARCHAR(256) NULL,
    [DLALLPREFERRED] BIT NULL,
    [DLALLBOXED] BIT NULL,
    [PUBID] INT NULL,
    [DLSOMEPREFERRED] INT NOT NULL,
    [DLSOMEBOXED] INT NOT NULL,
    [DLTEST] BIT NOT NULL,
    [DLSALESREP] VARCHAR(64) NULL,
    [DLMODIFIED] DATETIME NULL,
    [DLEXPIRATION] DATETIME NULL,
    [acc_ID_Rep] INT NULL,
    [contact_name] VARCHAR(255) NULL,
    [contact_email] VARCHAR(255) NULL
);

CREATE TABLE [x__DEALERSUBMIT] (
    [DSID] INT NOT NULL -- PK,
    [MEMID] INT NOT NULL,
    [PUBID] INT NOT NULL,
    [SCLID] INT NOT NULL,
    [ECLSNUMBER] INT NULL,
    [DSYEAR] SMALLINT NOT NULL,
    [DSMAKE] VARCHAR(32) NOT NULL,
    [DSMODEL] VARCHAR(32) NOT NULL,
    [DSSMODEL] VARCHAR(32) NULL,
    [DSADTEXT] VARCHAR(4096) NOT NULL,
    [DSHEADLINE] VARCHAR(255) NULL,
    [DSBOXED] BIT NULL,
    [DSINS] TINYINT NOT NULL,
    [DSPRICE] MONEY NOT NULL,
    [DSENTERED] SMALLDATETIME NOT NULL,
    [DSMODIFIED] SMALLDATETIME NOT NULL,
    [DSSTATUS] TINYINT NOT NULL,
    [DSADTYPE] TINYINT NOT NULL,
    [DSEMAIL] VARCHAR(64) NULL,
    [DSZIP] VARCHAR(10) NULL,
    [DSPHONE] VARCHAR(12) NOT NULL,
    [DSNOPHONE] BIT NOT NULL,
    [DSPREFERRED] BIT NOT NULL,
    [ADID] INT NULL,
    [DSPACKAGE] INT NULL,
    [DSVIN] VARCHAR(17) NULL,
    [DSREASON] VARCHAR(512) NULL,
    [DSTHUMB] VARCHAR(255) NULL,
    [DSSTOCKNO] VARCHAR(32) NULL,
    [DSEXPIREDATE] DATETIME NULL,
    [DSEXPIREWEEKS] INT NULL
);

CREATE TABLE [xlate] (
    [XLID] INT NOT NULL -- PK,
    [EDID] INT NOT NULL,
    [ENDEAVORID] INT NOT NULL,
    [WEBCLS] INT NOT NULL,
    [ENDCLS] INT NOT NULL
);

CREATE TABLE [xml] (
    [XMLID] INT NOT NULL -- PK,
    [XMLEMAIL] VARCHAR(128) NOT NULL,
    [XMLCC] VARCHAR(128) NULL,
    [XMLACTIVE] BIT NOT NULL,
    [XMLPUBID] INT NOT NULL
);

CREATE TABLE [xsitedest] (
    [xdstID] INT NOT NULL -- PK,
    [xdstPubID] INT NOT NULL,
    [xsrcID] INT NOT NULL
);

CREATE TABLE [xsitesource] (
    [xsrcID] INT NOT NULL -- PK,
    [xsrcPhone] VARCHAR(12) NOT NULL,
    [xsrcPubID] INT NOT NULL
);

CREATE TABLE [xsitexlate] (
    [xtID] INT NOT NULL -- PK,
    [xtsrcSclID] INT NOT NULL,
    [xtdestSclID] INT NOT NULL
);

CREATE TABLE [zipcodes] (
    [ZIPCODE] VARCHAR(5) NOT NULL -- PK,
    [ZIPCITY] VARCHAR(32) NULL,
    [ZIPSTATE] VARCHAR(2) NOT NULL,
    [AREACODE] CHAR(3) NOT NULL,
    [LATITUDE] FLOAT NOT NULL,
    [LONGITUDE] FLOAT NOT NULL
);

CREATE TABLE [zzz___pubmakes] (
    [pubID] INT NOT NULL -- PK,
    [Make] VARCHAR(32) NOT NULL -- PK,
    [Count] INT NOT NULL
);
