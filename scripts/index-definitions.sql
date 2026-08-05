/* ============================================================
   Index Definitions — All 9 DAS Databases
   DAS Technology · Phase 0 Discovery
   Researcher: Alicia Salazar · 2026-06-14

   Run in SSMS connected to 20.51.108.231. Read-only (no changes).
   Queries sys.indexes + sys.index_columns for each database.

   Output: one row per index — name, type, key columns, included
   columns, uniqueness, fill factor.

   Uses FOR XML PATH for column concatenation (SQL Server pre-2017,
   STRING_AGG not available).
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
IF OBJECT_ID('tempdb..#idx_results') IS NOT NULL DROP TABLE #idx_results;
CREATE TABLE #idx_results (
    database_name   NVARCHAR(128),
    schema_name     NVARCHAR(128),
    table_name      NVARCHAR(256),
    index_name      NVARCHAR(256),
    index_type      NVARCHAR(64),
    is_primary_key  BIT,
    is_unique       BIT,
    is_disabled     BIT,
    key_columns     NVARCHAR(MAX),
    included_cols   NVARCHAR(MAX),
    fill_factor     TINYINT
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
            DB_NAME()       AS database_name,
            s.name          AS schema_name,
            t.name          AS table_name,
            i.name          AS index_name,
            i.type_desc     AS index_type,
            i.is_primary_key,
            i.is_unique,
            i.is_disabled,

            -- Key columns (ordered, with DESC flag where applicable)
            STUFF((
                SELECT '', '' + c.name
                       + CASE WHEN ic2.is_descending_key = 1 THEN '' DESC'' ELSE '''' END
                FROM   sys.index_columns ic2
                JOIN   sys.columns c
                         ON  c.object_id = ic2.object_id
                         AND c.column_id = ic2.column_id
                WHERE  ic2.object_id          = i.object_id
                  AND  ic2.index_id           = i.index_id
                  AND  ic2.is_included_column = 0
                ORDER  BY ic2.key_ordinal
                FOR XML PATH('''')
            ), 1, 2, '''')  AS key_columns,

            -- Included columns (non-key, for covering indexes)
            STUFF((
                SELECT '', '' + c.name
                FROM   sys.index_columns ic3
                JOIN   sys.columns c
                         ON  c.object_id = ic3.object_id
                         AND c.column_id = ic3.column_id
                WHERE  ic3.object_id          = i.object_id
                  AND  ic3.index_id           = i.index_id
                  AND  ic3.is_included_column = 1
                ORDER  BY ic3.index_column_id
                FOR XML PATH('''')
            ), 1, 2, '''')  AS included_cols,

            i.fill_factor

        FROM sys.indexes i
        JOIN sys.tables  t ON t.object_id = i.object_id
        JOIN sys.schemas s ON s.schema_id = t.schema_id
        WHERE i.type        > 0     -- exclude heaps (type = 0 = no index, data only)
          AND t.is_ms_shipped = 0   -- user tables only
        ORDER BY s.name, t.name, i.is_primary_key DESC, i.is_unique DESC, i.name;
    ';

    BEGIN TRY
        INSERT INTO #idx_results
        EXEC sp_executesql @sql;
    END TRY
    BEGIN CATCH
        -- Skip on access error — surface separately if needed
    END CATCH;

    FETCH NEXT FROM db_cur INTO @db_name;
END;

CLOSE db_cur;
DEALLOCATE db_cur;

-- ── Output 1: Full index matrix ───────────────────────────────────────────────
SELECT
    database_name                                               AS [Database],
    schema_name                                                 AS [Schema],
    table_name                                                  AS [Table],
    index_name                                                  AS [Index Name],
    index_type                                                  AS [Type],
    CASE is_primary_key WHEN 1 THEN 'YES' ELSE ''  END          AS [PK?],
    CASE is_unique      WHEN 1 THEN 'YES' ELSE ''  END          AS [Unique?],
    CASE is_disabled    WHEN 1 THEN 'DISABLED' ELSE '' END      AS [Disabled?],
    key_columns                                                 AS [Key Columns],
    ISNULL(included_cols, '')                                   AS [Included Columns],
    CASE fill_factor
        WHEN 0  THEN '(default)'
        ELSE CAST(fill_factor AS VARCHAR) + '%'
    END                                                         AS [Fill Factor]
FROM #idx_results
ORDER BY
    database_name,
    schema_name,
    table_name,
    is_primary_key DESC,
    is_unique DESC,
    index_name;

-- ── Output 2: Per-table index count summary ───────────────────────────────────
SELECT
    database_name                                               AS [Database],
    schema_name                                                 AS [Schema],
    table_name                                                  AS [Table],
    COUNT(*)                                                    AS [Total Indexes],
    SUM(CASE WHEN is_primary_key = 1 THEN 1 ELSE 0 END)        AS [PKs],
    SUM(CASE WHEN is_unique = 1 AND is_primary_key = 0
             THEN 1 ELSE 0 END)                                 AS [Unique Indexes],
    SUM(CASE WHEN is_unique = 0 THEN 1 ELSE 0 END)             AS [Nonclustered],
    SUM(CASE WHEN is_disabled = 1 THEN 1 ELSE 0 END)           AS [Disabled]
FROM #idx_results
GROUP BY database_name, schema_name, table_name
ORDER BY database_name, schema_name, table_name;

-- ── Output 3: Database-level summary ─────────────────────────────────────────
SELECT
    database_name                                               AS [Database],
    COUNT(DISTINCT table_name)                                  AS [Tables With Indexes],
    COUNT(*)                                                    AS [Total Indexes],
    SUM(CASE WHEN is_primary_key = 1 THEN 1 ELSE 0 END)        AS [Primary Keys],
    SUM(CASE WHEN is_unique = 1 AND is_primary_key = 0
             THEN 1 ELSE 0 END)                                 AS [Unique Indexes],
    SUM(CASE WHEN is_disabled = 1 THEN 1 ELSE 0 END)           AS [Disabled Indexes],
    SUM(CASE WHEN index_type = 'CLUSTERED' THEN 1 ELSE 0 END)  AS [Clustered],
    SUM(CASE WHEN index_type = 'NONCLUSTERED' THEN 1 ELSE 0 END) AS [Nonclustered]
FROM #idx_results
GROUP BY database_name
ORDER BY database_name;

DROP TABLE #idx_results;
