/* ============================================================
   Row Counts + Table Sizes — Second Server (4 databases)
   DAS Technology · Phase 0 Discovery
   Researcher: Alicia Salazar · 2026-06-14

   Run in SSMS connected to the second server.
   Read-only — no changes.

   Databases: DWRPT_AI, DataStaging, kFeedhub, Zuora

   Uses sys.partitions (no VIEW SERVER STATE required) and
   sys.allocation_units for size. FOR XML PATH for column
   concatenation (SQL Server pre-2017 safe).

   Output 1: one row per table — rows, reserved KB, data KB, index KB
   Output 2: database-level summary
   ============================================================ */

SET NOCOUNT ON;

IF OBJECT_ID('tempdb..#rowcounts') IS NOT NULL DROP TABLE #rowcounts;
CREATE TABLE #rowcounts (
    database_name   NVARCHAR(128),
    schema_name     NVARCHAR(128),
    table_name      NVARCHAR(256),
    row_count       BIGINT,
    reserved_kb     BIGINT,
    data_kb         BIGINT,
    index_kb        BIGINT,
    unused_kb       BIGINT
);

DECLARE @db   NVARCHAR(128);
DECLARE @sql  NVARCHAR(MAX);

DECLARE db_cur CURSOR LOCAL FAST_FORWARD FOR
    SELECT name FROM master.sys.databases
    WHERE name IN ('DWRPT_AI','DataStaging','kFeedhub','Zuora')
      AND state_desc = 'ONLINE'
    ORDER BY name;

OPEN db_cur;
FETCH NEXT FROM db_cur INTO @db;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @sql = N'
        USE [' + @db + N'];

        SELECT
            DB_NAME()           AS database_name,
            s.name              AS schema_name,
            t.name              AS table_name,

            -- Row count from partition stats (no full scan, no VIEW SERVER STATE)
            SUM(p.rows)         AS row_count,

            -- Sizes from allocation units
            SUM(a.total_pages)  * 8 AS reserved_kb,
            SUM(a.used_pages)   * 8 AS data_kb,
            (SUM(a.total_pages) - SUM(a.used_pages)) * 8 AS index_kb,
            (SUM(a.total_pages) - SUM(a.used_pages)) * 8 AS unused_kb

        FROM sys.tables t
        JOIN sys.schemas         s   ON s.schema_id    = t.schema_id
        JOIN sys.indexes         i   ON i.object_id    = t.object_id
        JOIN sys.partitions      p   ON p.object_id    = i.object_id
                                    AND p.index_id     = i.index_id
        JOIN sys.allocation_units a  ON a.container_id =
                CASE
                    WHEN a.type IN (1,3) THEN p.hobt_id
                    WHEN a.type = 2      THEN p.partition_id
                END
        WHERE t.is_ms_shipped = 0
        GROUP BY s.name, t.name
        ORDER BY s.name, t.name;
    ';

    BEGIN TRY
        INSERT INTO #rowcounts
        EXEC sp_executesql @sql;
    END TRY
    BEGIN CATCH
        -- Surface the error as an informational row so you know which DB failed
        INSERT INTO #rowcounts (database_name, schema_name, table_name, row_count)
        VALUES (@db, '(error)', ERROR_MESSAGE(), -1);
    END CATCH;

    FETCH NEXT FROM db_cur INTO @db;
END;

CLOSE db_cur;
DEALLOCATE db_cur;


-- ── Output 1: Full table list ─────────────────────────────────────────────────
SELECT
    database_name                   AS [Database],
    schema_name                     AS [Schema],
    table_name                      AS [Table],
    FORMAT(row_count,  'N0')        AS [Rows],
    FORMAT(reserved_kb / 1024.0, 'N2') AS [Reserved MB],
    FORMAT(data_kb     / 1024.0, 'N2') AS [Data MB],
    FORMAT(index_kb    / 1024.0, 'N2') AS [Index MB]
FROM #rowcounts
WHERE row_count >= 0                -- exclude error rows
ORDER BY
    database_name,
    row_count DESC;

-- ── Output 2: Top 20 largest tables across all DBs ───────────────────────────
SELECT TOP 20
    database_name                   AS [Database],
    schema_name                     AS [Schema],
    table_name                      AS [Table],
    FORMAT(row_count,  'N0')        AS [Rows],
    FORMAT(reserved_kb / 1024.0, 'N2') AS [Reserved MB]
FROM #rowcounts
WHERE row_count >= 0
ORDER BY reserved_kb DESC;

-- ── Output 3: Database-level summary ─────────────────────────────────────────
SELECT
    database_name                   AS [Database],
    COUNT(*)                        AS [Table Count],
    FORMAT(SUM(row_count),     'N0')  AS [Total Rows],
    FORMAT(SUM(reserved_kb) / 1024.0, 'N2') AS [Total Reserved MB],
    FORMAT(SUM(data_kb)     / 1024.0, 'N2') AS [Total Data MB],
    SUM(CASE WHEN row_count = 0 THEN 1 ELSE 0 END) AS [Empty Tables]
FROM #rowcounts
WHERE row_count >= 0
GROUP BY database_name
ORDER BY SUM(reserved_kb) DESC;

DROP TABLE #rowcounts;
