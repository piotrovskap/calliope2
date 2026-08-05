/* ============================================================
   Stored Procedures, Functions, Views & ETL Objects
   DAS Technology · Phase 0 Discovery
   Researcher: Alicia Salazar · 2026-06-14

   Run in SSMS connected to the target server (second server:
   DWRPT_AI, DataStaging, kFeedhub, Zuora).
   Read-only — no DDL changes.

   Extracts:
     1. Stored procedures — name, schema, create/modify date, full body
     2. Scalar and table-valued functions — same detail
     3. Views — name, schema, create/modify date, full definition
     4. SQL Agent jobs — job name, step name, step command, schedule
     5. Linked servers — name, provider, data source
     6. Triggers — name, parent table, event type, body

   Run once per database by changing USE [<db>] at the top,
   or use the multi-db loop version at the bottom.
   ============================================================ */

SET NOCOUNT ON;

-- ── Change this to the database you are auditing ──────────────────────────────
USE [DWRPT_AI];
-- ─────────────────────────────────────────────────────────────────────────────


-- ============================================================
-- SECTION 1: Stored Procedures
-- ============================================================

PRINT '=== STORED PROCEDURES ===';

SELECT
    s.name                          AS [Schema],
    p.name                          AS [Procedure Name],
    p.create_date                   AS [Created],
    p.modify_date                   AS [Last Modified],
    sm.definition                   AS [Body]
FROM sys.procedures p
JOIN sys.schemas   s  ON s.schema_id = p.schema_id
JOIN sys.sql_modules sm ON sm.object_id = p.object_id
WHERE p.is_ms_shipped = 0
ORDER BY s.name, p.name;


-- ============================================================
-- SECTION 2: Functions (scalar + table-valued)
-- ============================================================

PRINT '=== FUNCTIONS ===';

SELECT
    s.name                          AS [Schema],
    o.name                          AS [Function Name],
    o.type_desc                     AS [Type],
    o.create_date                   AS [Created],
    o.modify_date                   AS [Last Modified],
    sm.definition                   AS [Body]
FROM sys.objects o
JOIN sys.schemas    s  ON s.schema_id = o.schema_id
JOIN sys.sql_modules sm ON sm.object_id = o.object_id
WHERE o.type IN ('FN', 'IF', 'TF')   -- FN = scalar, IF = inline TVF, TF = multi-statement TVF
  AND o.is_ms_shipped = 0
ORDER BY s.name, o.name;


-- ============================================================
-- SECTION 3: Views (including definition)
-- ============================================================

PRINT '=== VIEWS ===';

SELECT
    s.name                          AS [Schema],
    v.name                          AS [View Name],
    v.create_date                   AS [Created],
    v.modify_date                   AS [Last Modified],
    sm.definition                   AS [Definition]
FROM sys.views v
JOIN sys.schemas    s  ON s.schema_id = v.schema_id
JOIN sys.sql_modules sm ON sm.object_id = v.object_id
WHERE v.is_ms_shipped = 0
ORDER BY s.name, v.name;


-- ============================================================
-- SECTION 4: SQL Server Agent Jobs
-- (runs against msdb, always — not scoped to USE [db] above)
-- ============================================================

PRINT '=== SQL AGENT JOBS ===';

-- Output 4a: Job list with schedule info
SELECT
    j.name                          AS [Job Name],
    j.enabled                       AS [Enabled],
    j.description                   AS [Description],
    j.date_created                  AS [Created],
    j.date_modified                 AS [Last Modified],
    ISNULL(
        (SELECT TOP 1
             CASE s.freq_type
                 WHEN 1   THEN 'Once'
                 WHEN 4   THEN 'Daily every ' + CAST(s.freq_interval AS VARCHAR) + ' day(s)'
                 WHEN 8   THEN 'Weekly'
                 WHEN 16  THEN 'Monthly'
                 WHEN 32  THEN 'Monthly relative'
                 WHEN 64  THEN 'On SQL Server Agent start'
                 WHEN 128 THEN 'When idle'
                 ELSE 'Unknown (' + CAST(s.freq_type AS VARCHAR) + ')'
             END
             + ' at '
             + RIGHT('000000' + CAST(s.active_start_time AS VARCHAR), 6)
         FROM msdb.dbo.sysjobschedules js
         JOIN msdb.dbo.sysschedules    s  ON s.schedule_id = js.schedule_id
         WHERE js.job_id = j.job_id
         ORDER BY s.active_start_time
        ),
    'No schedule') AS [Schedule],
    ISNULL(
        (SELECT TOP 1
             CASE h.run_status
                 WHEN 0 THEN 'Failed'
                 WHEN 1 THEN 'Succeeded'
                 WHEN 2 THEN 'Retry'
                 WHEN 3 THEN 'Cancelled'
                 WHEN 4 THEN 'Running'
                 ELSE 'Unknown'
             END
         FROM msdb.dbo.sysjobhistory h
         WHERE h.job_id    = j.job_id
           AND h.step_id   = 0          -- outcome step
         ORDER BY h.run_date DESC, h.run_time DESC
        ),
    'No history') AS [Last Run Status],
    ISNULL(
        (SELECT TOP 1
             CAST(h.run_date AS CHAR(8))
         FROM msdb.dbo.sysjobhistory h
         WHERE h.job_id  = j.job_id
           AND h.step_id = 0
         ORDER BY h.run_date DESC, h.run_time DESC
        ),
    '—') AS [Last Run Date]
FROM msdb.dbo.sysjobs j
ORDER BY j.name;

-- Output 4b: Job steps with full command text
SELECT
    j.name                          AS [Job Name],
    js.step_id                      AS [Step #],
    js.step_name                    AS [Step Name],
    js.subsystem                    AS [Subsystem],
    js.database_name                AS [Database],
    js.command                      AS [Command / Body],
    CASE js.on_success_action
        WHEN 1 THEN 'Quit success'
        WHEN 2 THEN 'Quit failure'
        WHEN 3 THEN 'Go to next step'
        WHEN 4 THEN 'Go to step ' + CAST(js.on_success_step_id AS VARCHAR)
        ELSE '?'
    END                             AS [On Success],
    CASE js.on_fail_action
        WHEN 1 THEN 'Quit success'
        WHEN 2 THEN 'Quit failure'
        WHEN 3 THEN 'Go to next step'
        WHEN 4 THEN 'Go to step ' + CAST(js.on_fail_step_id AS VARCHAR)
        ELSE '?'
    END                             AS [On Fail],
    js.last_run_date                AS [Last Run Date],
    CASE js.last_run_outcome
        WHEN 0 THEN 'Failed'
        WHEN 1 THEN 'Succeeded'
        WHEN 2 THEN 'Retry'
        WHEN 3 THEN 'Cancelled'
        WHEN 5 THEN 'Unknown'
        ELSE CAST(js.last_run_outcome AS VARCHAR)
    END                             AS [Last Run Outcome]
FROM msdb.dbo.sysjobs      j
JOIN msdb.dbo.sysjobsteps  js ON js.job_id = j.job_id
ORDER BY j.name, js.step_id;


-- ============================================================
-- SECTION 5: Linked Servers
-- ============================================================

PRINT '=== LINKED SERVERS ===';

SELECT
    s.name                          AS [Linked Server Name],
    s.provider                      AS [Provider],
    s.data_source                   AS [Data Source],
    s.product                       AS [Product],
    s.catalog                       AS [Catalog],
    s.is_remote_login_enabled       AS [Remote Login Enabled],
    s.is_rpc_out_enabled            AS [RPC Out Enabled],
    s.modify_date                   AS [Last Modified]
FROM sys.servers s
WHERE s.is_linked = 1
ORDER BY s.name;


-- ============================================================
-- SECTION 6: Triggers
-- ============================================================

PRINT '=== TRIGGERS ===';

SELECT
    s.name                          AS [Schema],
    OBJECT_NAME(t.parent_id)        AS [Parent Table],
    t.name                          AS [Trigger Name],
    t.type_desc                     AS [Type],
    t.create_date                   AS [Created],
    t.modify_date                   AS [Last Modified],
    sm.definition                   AS [Body],
    -- Event types (INSERT / UPDATE / DELETE)
    CASE WHEN OBJECTPROPERTY(t.object_id, 'ExecIsInsertTrigger') = 1 THEN 'INSERT ' ELSE '' END
    + CASE WHEN OBJECTPROPERTY(t.object_id, 'ExecIsUpdateTrigger') = 1 THEN 'UPDATE ' ELSE '' END
    + CASE WHEN OBJECTPROPERTY(t.object_id, 'ExecIsDeleteTrigger') = 1 THEN 'DELETE' ELSE '' END
                                    AS [Events],
    CASE WHEN t.is_disabled = 1 THEN 'DISABLED' ELSE 'ENABLED' END AS [Status]
FROM sys.triggers    t
JOIN sys.sql_modules sm ON sm.object_id = t.object_id
JOIN sys.schemas     s  ON s.schema_id  = OBJECTPROPERTY(t.parent_id, 'SchemaId')
WHERE t.parent_class = 1            -- table triggers only (not database-level)
  AND t.is_ms_shipped = 0
ORDER BY s.name, OBJECT_NAME(t.parent_id), t.name;


-- ============================================================
-- SECTION 7: Summary counts (quick overview)
-- ============================================================

PRINT '=== SUMMARY ===';

SELECT
    'Stored Procedures' AS [Object Type],
    COUNT(*) AS [Count]
FROM sys.procedures
WHERE is_ms_shipped = 0

UNION ALL

SELECT 'Functions', COUNT(*)
FROM sys.objects
WHERE type IN ('FN','IF','TF')
  AND is_ms_shipped = 0

UNION ALL

SELECT 'Views', COUNT(*)
FROM sys.views
WHERE is_ms_shipped = 0

UNION ALL

SELECT 'Triggers', COUNT(*)
FROM sys.triggers
WHERE is_ms_shipped = 0
  AND parent_class = 1

UNION ALL

SELECT 'SQL Agent Jobs (server-wide)', COUNT(*)
FROM msdb.dbo.sysjobs

UNION ALL

SELECT 'Linked Servers', COUNT(*)
FROM sys.servers
WHERE is_linked = 1;


-- ============================================================
-- MULTI-DB LOOP VERSION
-- Uncomment and run this block to scan all four databases on
-- this server in one pass (Sections 1-3 only — jobs and linked
-- servers are server-scoped, not per-database).
-- ============================================================

/*
DECLARE @dbs TABLE (db_name NVARCHAR(128));
INSERT INTO @dbs VALUES
    ('DWRPT_AI'),
    ('DataStaging'),
    ('kFeedhub'),
    ('Zuora');

IF OBJECT_ID('tempdb..#procs') IS NOT NULL DROP TABLE #procs;
CREATE TABLE #procs (
    database_name NVARCHAR(128),
    schema_name   NVARCHAR(128),
    object_name   NVARCHAR(256),
    object_type   NVARCHAR(64),
    created       DATETIME,
    modified      DATETIME,
    body          NVARCHAR(MAX)
);

DECLARE @db NVARCHAR(128), @sql NVARCHAR(MAX);
DECLARE cur CURSOR LOCAL FAST_FORWARD FOR SELECT db_name FROM @dbs;
OPEN cur; FETCH NEXT FROM cur INTO @db;

WHILE @@FETCH_STATUS = 0
BEGIN
    IF DB_ID(@db) IS NOT NULL
    BEGIN
        SET @sql = N'
            USE [' + @db + N'];
            SELECT
                DB_NAME(),
                s.name,
                o.name,
                o.type_desc,
                o.create_date,
                o.modify_date,
                sm.definition
            FROM sys.objects o
            JOIN sys.schemas     s  ON s.schema_id  = o.schema_id
            JOIN sys.sql_modules sm ON sm.object_id = o.object_id
            WHERE o.type IN (''P'',''FN'',''IF'',''TF'',''V'')
              AND o.is_ms_shipped = 0
            ORDER BY o.type, s.name, o.name;
        ';
        BEGIN TRY
            INSERT INTO #procs EXEC sp_executesql @sql;
        END TRY
        BEGIN CATCH END CATCH;
    END
    FETCH NEXT FROM cur INTO @db;
END
CLOSE cur; DEALLOCATE cur;

SELECT * FROM #procs ORDER BY database_name, object_type, schema_name, object_name;
DROP TABLE #procs;
*/
