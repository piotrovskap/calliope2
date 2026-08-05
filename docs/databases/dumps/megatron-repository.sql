-- Megatron Repository Database — DDL Schema Dump
-- Source: SQL Server 20.51.108.231
-- Generated: 2026-06-11
-- Schema-only; no data. Re-extract to refresh.

CREATE TABLE [_MigrateLeadqueue] (
    [ldq_id] INT NOT NULL,
    [lst_id] INT NOT NULL,
    [ldq_lqs_id] INT NOT NULL,
    [ldq_created] DATETIME NOT NULL,
    [ldq_frommail] VARCHAR(256) NOT NULL,
    [ldq_fromip] VARCHAR(16) NOT NULL,
    [ldq_fromfirstname] VARCHAR(64) NOT NULL,
    [ldq_fromlastname] VARCHAR(64) NOT NULL,
    [ldq_fromzipcode] VARCHAR(5) NOT NULL,
    [ldq_fromphone] VARCHAR(16) NOT NULL,
    [ldq_message] VARCHAR(512) NOT NULL,
    [ldq_proofer_acc_id] INT NULL,
    [ldq_proofcomment] VARCHAR(512) NULL,
    [ldq_sent] DATETIME NULL,
    [ldq_adfxml] VARCHAR(8000) NULL,
    [ldq_multisend] BIT NOT NULL,
    [ldq_source] VARCHAR(32) NULL
);

CREATE TABLE [_MigrateListing] (
    [lst_id] INT NOT NULL,
    [acc_id] INT NULL,
    [src_id] INT NOT NULL,
    [src_adid] VARCHAR(32) NULL,
    [scl_id] INT NOT NULL,
    [rrg_id] INT NOT NULL,
    [zip_code] VARCHAR(5) NOT NULL,
    [lst_issale] BIT NOT NULL,
    [lst_type] TINYINT NOT NULL,
    [lst_cost] MONEY NOT NULL,
    [lst_weeks] INT NOT NULL,
    [lst_headline] VARCHAR(64) NOT NULL,
    [lst_title] VARCHAR(128) NOT NULL,
    [lst_price] MONEY NOT NULL,
    [lst_phone] VARCHAR(16) NOT NULL,
    [lst_extension] VARCHAR(10) NOT NULL,
    [lss_id] INT NOT NULL,
    [lst_created] DATETIME NOT NULL,
    [lst_modified] DATETIME NOT NULL,
    [master_lst_id] INT NULL,
    [lst_lastupload] DATETIME NULL,
    [lst_modifiedby] INT NULL,
    [lst_options] VARCHAR(256) NULL,
    [lpt_id] INT NULL
);

CREATE TABLE [_MigrateListingVehicle] (
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
    [veh_sellertype] VARCHAR(16) NULL
);

CREATE TABLE [acc_id_lst_ID] (
    [acc_id] INT NULL,
    [lst_id] INT NOT NULL -- PK
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

CREATE TABLE [DealerVault_Matched] (
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
    [DataSource] VARCHAR(10) NOT NULL
);

CREATE TABLE [DealerVault_Matching] (
    [acc_id] BIGINT NULL,
    [id] VARCHAR(36) NULL,
    [_Keyword] VARCHAR(128) NULL,
    [_Field] VARCHAR(24) NOT NULL,
    [_Secondary] VARCHAR(32) NULL,
    [_Date] DATE NULL
);

CREATE TABLE [EmailObjectsRepository] (
    [emo_IDENTITY] INT NOT NULL,
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

CREATE TABLE [IntMaxes] (
    [IntMax] INT NULL,
    [TableName] VARCHAR(64) NULL,
    [ColumnName] VARCHAR(64) NULL
);

CREATE TABLE [LeadQueueRepository] (
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

CREATE TABLE [ListingLastUpload] (
    [acc_ID] INT NULL,
    [LastUpload] DATETIME NULL
);

CREATE TABLE [ListingRepository] (
    [lst_ID] INT NOT NULL -- PK,
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
    [lst_Price] MONEY NOT NULL,
    [lst_Phone] VARCHAR(16) NOT NULL,
    [lst_Extension] VARCHAR(10) NOT NULL,
    [lss_ID] INT NOT NULL,
    [lst_Created] DATETIME NOT NULL,
    [lst_Modified] DATETIME NOT NULL,
    [master_lst_ID] INT NULL,
    [lst_LastUpload] DATETIME NULL,
    [lst_ModifiedBy] INT NULL,
    [lst_Options] VARCHAR(256) NULL,
    [lpt_ID] INT NULL
);

CREATE TABLE [ListingVehicleRepository] (
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
    [veh_sellertype] VARCHAR(16) NULL
);

CREATE TABLE [LogFile] (
    [lfName] VARCHAR(4000) NULL,
    [lfCreated] DATETIME NULL,
    [lfSize] BIGINT NULL
);

CREATE TABLE [MailQueueRepository] (
    [mlq_ID] INT NOT NULL,
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

CREATE TABLE [ReceiptRepository] (
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

CREATE TABLE [RefundRepository] (
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

CREATE TABLE [SearchQueriesLogsRepository] (
    [srchID] INT NOT NULL,
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

CREATE TABLE [znfStatus] (
    [znf_Status] INT NOT NULL -- PK,
    [znf_StatusName] VARCHAR(32) NOT NULL
);
