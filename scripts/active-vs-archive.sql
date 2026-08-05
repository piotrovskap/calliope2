/* ============================================================
   Active vs. Archive Table Classification
   DAS Technology · Phase 0 Discovery
   Researcher: Alicia Salazar · 2026-06-14

   Run in SSMS connected to 20.51.108.231. Read-only (no changes).

   Classifies every user table in the 9 accessible databases as:
     ACTIVE_WRITE   — received inserts/updates/deletes since last restart
     READ_ONLY      — queried but not written since last restart
     NEVER_ACCESSED — zero I/O recorded (may just be post-restart quiet)

   Data source: sys.dm_db_index_usage_stats (resets on SQL Server
   service restart — treat NEVER_ACCESSED with caution if the service
   was recently restarted).

   Also flags tables whose names contain archive/history/log patterns.
   ============================================================ */

SET NOCOUNT ON;

-- ── Databases to audit ────────────────────────────────────────────────────────
DECLARE @databases TABLE (db_name NVARCHAR(128));
INSERT INTO @databases VALUES
    ('Megatron'),
    ('EndeavorCentral'),
    ('MegatronRepository'),
    ('OutboundFeeds'),
    ('PetFinder'),
    ('prime'),
    ('RedDawn'),
    ('Trax'),
    ('web');

-- ── Results table ─────────────────────────────────────────────────────────────
IF OBJECT_ID('tempdb..#activity') IS NOT NULL DROP TABLE #activity;
CREATE TABLE #activity (
    database_name   NVARCHAR(128),
    schema_name     NVARCHAR(128),
    table_name      NVARCHAR(256),
    row_count       BIGINT,
    write_ops       BIGINT,     -- user_updates since last SQL Server restart
    read_ops        BIGINT,     -- user_seeks + user_scans + user_lookups
    last_write      DATETIME,
    last_seek       DATETIME,
    last_scan       DATETIME,
    classification  NVARCHAR(32),
    name_signal     NVARCHAR(64)
);

-- ── Loop over databases ───────────────────────────────────────────────────────
DECLARE @db_name NVARCHAR(128);
DECLARE db_cur CURSOR LOCAL FAST_FORWARD FOR
    SELECT db_name FROM @databases;

OPEN db_cur;
FETCH NEXT FROM db_cur INTO @db_name;

WHILE @@FETCH_STATUS = 0
BEGIN
    IF DB_ID(@db_name) IS NULL
    BEGIN
        FETCH NEXT FROM db_cur INTO @db_name;
        CONTINUE;
    END;

    DECLARE @sql NVARCHAR(MAX) = N'
        USE [' + @db_name + N'];

        SELECT
            DB_NAME()                       AS database_name,
            s.name                          AS schema_name,
            t.name                          AS table_name,

            -- Row count estimate from partition stats (no full scan needed)
            ISNULL((
                SELECT SUM(p.row_count)
                FROM   sys.dm_db_partition_stats p
                WHERE  p.object_id = t.object_id
                  AND  p.index_id IN (0, 1)   -- heap or clustered only
            ), 0)                           AS row_count,

            -- Write operations (INSERT / UPDATE / DELETE) since last restart
            -- Aggregate over heap (index_id=0) and clustered (index_id=1) only
            -- to avoid double-counting nonclustered index maintenance
            ISNULL(SUM(u.user_updates), 0)  AS write_ops,

            -- Read operations
            ISNULL(SUM(u.user_seeks
                     + u.user_scans
                     + u.user_lookups), 0)  AS read_ops,

            -- Timestamps
            MAX(u.last_user_update)         AS last_write,
            MAX(u.last_user_seek)           AS last_seek,
            MAX(u.last_user_scan)           AS last_scan,

            -- Classification
            CASE
                WHEN ISNULL(SUM(u.user_updates), 0) > 0
                    THEN ''ACTIVE_WRITE''
                WHEN ISNULL(SUM(u.user_seeks
                              + u.user_scans
                              + u.user_lookups), 0) > 0
                    THEN ''READ_ONLY''
                ELSE
                    ''NEVER_ACCESSED''
            END                             AS classification,

            -- Name-based archive signals (additional hint, not definitive)
            CASE
                WHEN t.name LIKE ''%[_]arch''       THEN ''_arch''
                WHEN t.name LIKE ''%[_]arch[_]%''   THEN ''_arch_''
                WHEN t.name LIKE ''%[_]hist''        THEN ''_hist''
                WHEN t.name LIKE ''%[_]hist[_]%''    THEN ''_hist_''
                WHEN t.name LIKE ''%[_]log''         THEN ''_log''
                WHEN t.name LIKE ''%[_]bak''         THEN ''_bak''
                WHEN t.name LIKE ''%[_]old''         THEN ''_old''
                WHEN t.name LIKE ''%[_]backup''      THEN ''_backup''
                WHEN t.name LIKE ''%[_]temp''        THEN ''_temp''
                WHEN t.name LIKE ''%Archive''        THEN ''Archive''
                WHEN t.name LIKE ''Archive%''        THEN ''Archive''
                WHEN t.name LIKE ''%History''        THEN ''History''
                WHEN t.name LIKE ''History%''        THEN ''History''
                WHEN t.name LIKE ''%Backup''         THEN ''Backup''
                WHEN t.name LIKE ''%[_]copy''        THEN ''_copy''
                ELSE ''''
            END                             AS name_signal

        FROM sys.tables t
        JOIN sys.schemas s
               ON s.schema_id = t.schema_id
        LEFT JOIN sys.dm_db_index_usage_stats u
               ON  u.object_id   = t.object_id
               AND u.database_id = DB_ID()
               AND u.index_id   <= 1    -- heap + clustered only
        WHERE t.is_ms_shipped = 0       -- user tables only
        GROUP BY t.object_id, t.name, s.name
        ORDER BY s.name, t.name;
    ';

    BEGIN TRY
        INSERT INTO #activity
        EXEC sp_executesql @sql;
    END TRY
    BEGIN CATCH
        -- Skip on access error
    END CATCH;

    FETCH NEXT FROM db_cur INTO @db_name;
END;

CLOSE db_cur;
DEALLOCATE db_cur;

-- ── Output 1: Full table activity matrix ──────────────────────────────────────
-- Sort: active writers first, then read-only, then never accessed.
-- Within each group, highest write/read ops first, then largest tables.
SELECT
    database_name                                               AS [Database],
    schema_name                                                 AS [Schema],
    table_name                                                  AS [Table],
    classification                                              AS [Classification],
    FORMAT(row_count,  'N0')                                    AS [Rows (est.)],
    FORMAT(write_ops,  'N0')                                    AS [Write Ops],
    FORMAT(read_ops,   'N0')                                    AS [Read Ops],
    ISNULL(CONVERT(VARCHAR(19), last_write, 120), '—')          AS [Last Write],
    ISNULL(CONVERT(VARCHAR(19), last_seek,  120), '—')          AS [Last Seek],
    ISNULL(CONVERT(VARCHAR(19), last_scan,  120), '—')          AS [Last Scan],
    ISNULL(NULLIF(name_signal, ''), '—')                        AS [Archive Signal]
FROM #activity
ORDER BY
    database_name,
    CASE classification
        WHEN 'ACTIVE_WRITE'   THEN 1
        WHEN 'READ_ONLY'      THEN 2
        WHEN 'NEVER_ACCESSED' THEN 3
        ELSE 4
    END,
    write_ops DESC,
    read_ops  DESC,
    row_count DESC,
    table_name;

-- ── Output 2: Database-level summary ─────────────────────────────────────────
SELECT
    database_name                                               AS [Database],
    COUNT(*)                                                    AS [Total Tables],
    SUM(CASE WHEN classification = 'ACTIVE_WRITE'   THEN 1 ELSE 0 END) AS [Active Write],
    SUM(CASE WHEN classification = 'READ_ONLY'      THEN 1 ELSE 0 END) AS [Read Only],
    SUM(CASE WHEN classification = 'NEVER_ACCESSED' THEN 1 ELSE 0 END) AS [Never Accessed],
    SUM(CASE WHEN name_signal   <> ''               THEN 1 ELSE 0 END) AS [Archive Name Pattern],
    FORMAT(SUM(row_count), 'N0')                                AS [Total Rows (est.)]
FROM #activity
GROUP BY database_name
ORDER BY database_name;

-- ── Output 3: Tables that look archival but are still being written ───────────
-- These are worth flagging — active-write tables with archive-sounding names
-- may be append-only logs or audit trails, which ARE useful for CDP history.
SELECT
    database_name   AS [Database],
    schema_name     AS [Schema],
    table_name      AS [Table],
    classification  AS [Classification],
    FORMAT(write_ops, 'N0')         AS [Write Ops],
    FORMAT(row_count, 'N0')         AS [Rows (est.)],
    name_signal                     AS [Archive Signal]
FROM #activity
WHERE classification = 'ACTIVE_WRITE'
  AND name_signal    <> ''
ORDER BY database_name, write_ops DESC;

DROP TABLE #activity;
