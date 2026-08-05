-- Petfinder Database — DDL Schema Dump
-- Source: SQL Server 20.51.108.231
-- Generated: 2026-06-11
-- Schema-only; no data. Re-extract to refresh.

CREATE TABLE [_SilverPop_temp] (
    [acc_email_string] VARCHAR(128) NOT NULL,
    [OptInDate] DATETIME NULL,
    [OptedOut] VARCHAR(16) NULL,
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
    [OptOut] VARCHAR(24) NULL,
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

CREATE TABLE [CerritosResponse] (
    [response] VARCHAR(MAX) NULL
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

CREATE TABLE [GetJobURLResponse] (
    [jurID] INT NOT NULL -- PK,
    [jurDate] DATETIME NULL,
    [jurURL] VARCHAR(4000) NULL,
    [jurResponse] VARCHAR(4000) NULL
);

CREATE TABLE [ibf_EpicMotorSports_Data] (
    [response] VARCHAR(MAX) NULL
);

CREATE TABLE [IntMaxes] (
    [IntMax] INT NULL,
    [TableName] VARCHAR(64) NULL,
    [ColumnName] VARCHAR(64) NULL
);

CREATE TABLE [PetFinderCalls] (
    [pfc_ID] INT NOT NULL -- PK,
    [pfc_Name] VARCHAR(64) NOT NULL,
    [pfc_ZipCode] VARCHAR(5) NOT NULL,
    [pfc_Count] INT NOT NULL,
    [pfc_Active] BIT NOT NULL
);

CREATE TABLE [PetFinderPets] (
    [pfp_ID] VARCHAR(16) NOT NULL -- PK,
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

CREATE TABLE [PetFinderShelters] (
    [pfs_ID] VARCHAR(16) NOT NULL -- PK,
    [pfs_Name] VARCHAR(64) NULL,
    [pfs_Address1] VARCHAR(64) NULL,
    [pfs_Address2] VARCHAR(64) NULL,
    [pfs_City] VARCHAR(64) NULL,
    [pfs_State] VARCHAR(2) NULL,
    [pfs_Zip] VARCHAR(5) NULL,
    [pfs_Phone] VARCHAR(16) NULL,
    [pfs_Email] VARCHAR(128) NULL
);

CREATE TABLE [SilverpopAccountStatus] (
    [sas_ID] INT NOT NULL,
    [acc_ID] INT NOT NULL,
    [acc_Email] VARCHAR(128) NOT NULL,
    [sas_OptInDate] DATETIME NULL,
    [sas_OptInDetails] VARCHAR(128) NULL,
    [sas_OptedOut] VARCHAR(2) NULL,
    [sas_OptedOutDate] DATETIME NULL,
    [sas_OptOutDetails] VARCHAR(128) NULL
);

CREATE TABLE [SilverpopMailQueueStatus] (
    [sms_ID] INT NOT NULL,
    [mlq_ID] INT NOT NULL,
    [acc_ID] INT NOT NULL,
    [sms_Date] DATETIME NULL,
    [recipient_ID] VARCHAR(64) NULL,
    [organization_ID] VARCHAR(254) NULL
);

CREATE TABLE [SilverpopUpdateStatus] (
    [sus_ID] INT NOT NULL,
    [sus_Path] VARCHAR(250) NULL,
    [sus_Date] DATETIME NULL,
    [sus_Processed] INT NULL
);

CREATE TABLE [sysdiagrams] (
    [name] NVARCHAR(128) NOT NULL,
    [principal_id] INT NOT NULL,
    [diagram_id] INT NOT NULL -- PK,
    [version] INT NULL,
    [definition] VARBINARY(MAX) NULL
);

CREATE TABLE [URLEncodeNumbers] (
    [Num] INT NOT NULL -- PK
);

CREATE TABLE [URLResponse] (
    [response] VARCHAR(MAX) NULL
);

CREATE TABLE [URLResponseLog] (
    [rsp_ID] INT NOT NULL -- PK,
    [rsp_Date] DATETIME NOT NULL,
    [rsp_URL] NVARCHAR(4000) NULL,
    [rsp_Data] NVARCHAR(4000) NULL,
    [rsp_Results] NTEXT NULL
);

CREATE TABLE [ZipCode] (
    [zip_Code] VARCHAR(5) NOT NULL -- PK,
    [zip_City] VARCHAR(32) NOT NULL,
    [stt_ID] VARCHAR(2) NOT NULL,
    [zip_Latitude] FLOAT NOT NULL,
    [zip_Longitude] FLOAT NOT NULL,
    [zip_Radius] INT NOT NULL,
    [AREACODE] VARCHAR(3) NULL
);

CREATE TABLE [ZipCodeRequestCount] (
    [pfc_zipcode] VARCHAR(5) NOT NULL,
    [pfc_name] VARCHAR(64) NOT NULL,
    [adcount] INT NULL,
    [calldate] DATETIME NOT NULL
);
