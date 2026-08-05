/* ============================================================
   Common Client ID — Coverage Map
   DAS Technology · Phase 0 Discovery
   Researcher: Alicia Salazar · 2026-06-14

   Run this in SSMS connected to 20.51.108.231.
   No changes are made — all queries are read-only (NOLOCK).

   Output: one row per table that carries a CCID variant column.
   Databases with NO match appear as a single ABSENT row.

   When DWRPT / EDW_Staging access is granted, add them to
   the @databases table at the top.
   ============================================================ */

SET NOCOUNT ON;

-- ── 1. Configuration ─────────────────────────────────────────────────────────

-- Coverage threshold to call a column "deterministic"
DECLARE @threshold DECIMAL(5,1) = 80.0;

-- Column name variants to search (lower-case; matched case-insensitively)
DECLARE @col_variants TABLE (col_name NVARCHAR(128));
INSERT INTO @col_variants VALUES
    ('common_client_id'),
    ('commonclientid'),
    ('mccid'),
    ('ccid');
-- NOTE: 'client_id' intentionally excluded — too generic.
--       Add it back if you want to surface mapping tables like ClientId_Mapping.

-- Databases to audit
DECLARE @databases TABLE (
    db_name     NVARCHAR(128),
    tier        NVARCHAR(32),
    role        NVARCHAR(128)
);
INSERT INTO @databases VALUES
-- ── Accessible now ───────────────────────────────────────────────────────────
    ('Megatron',           'core',      'Advertiser / Listing hub'),
    ('EndeavorCentral',    'core',      'Sales / billing'),
    ('MegatronRepository', 'archive',   'Historical leads / listings'),
    ('OutboundFeeds',      'dist',      'Feed distribution'),
    ('PetFinder',          'vertical',  'Pet vertical'),
    ('prime',              'perf',      'Performance advertising'),
    ('RedDawn',            'crawl',     'Web crawlers'),
    ('Trax',               'analytics', 'Traffic analytics'),
    ('web',                'core',      'Main website / listings');
-- ── Uncomment when Ron Mulder provisions access ──────────────────────────────
--  ('DWRPT',              'dw',        'Data warehouse / reporting'),
--  ('EDW_Staging',        'dw',        'ETL staging (DMS/CRM/CVH)'),
--  ('CIM',                'inv',       'Central inventory management'),
--  ('ML_Production',      'legacy',    'MediaLogix'),
--  ('RL_Production',      'legacy',    'Response Logic OLTP');

-- ── 2. Results table ─────────────────────────────────────────────────────────

IF OBJECT_ID('tempdb..#ccid_results') IS NOT NULL DROP TABLE #ccid_results;

CREATE TABLE #ccid_results (
    database_name   NVARCHAR(128),
    tier            NVARCHAR(32),
    db_role         NVARCHAR(128),
    table_name      NVARCHAR(256),
    column_name     NVARCHAR(128),
    data_type       NVARCHAR(64),
    total_rows      BIGINT,
    non_null_rows   BIGINT,
    distinct_values BIGINT,
    coverage_pct    DECIMAL(5,1),
    status          NVARCHAR(32),
    notes           NVARCHAR(512)
);

-- ── 3. Main loop ─────────────────────────────────────────────────────────────

DECLARE @db_name    NVARCHAR(128),
        @db_tier    NVARCHAR(32),
        @db_role    NVARCHAR(128);

DECLARE db_cursor CURSOR LOCAL FAST_FORWARD FOR
    SELECT db_name, tier, role FROM @databases;

OPEN db_cursor;
FETCH NEXT FROM db_cursor INTO @db_name, @db_tier, @db_role;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Check the database exists and is accessible
    IF DB_ID(@db_name) IS NULL
    BEGIN
        INSERT INTO #ccid_results
            (database_name, tier, db_role, table_name, column_name,
             data_type, total_rows, non_null_rows, distinct_values,
             coverage_pct, status, notes)
        VALUES
            (@db_name, @db_tier, @db_role, N'(n/a)', N'—',
             NULL, NULL, NULL, NULL, NULL,
             N'NO ACCESS', N'Database not found or access denied');

        FETCH NEXT FROM db_cursor INTO @db_name, @db_tier, @db_role;
        CONTINUE;
    END;

    -- ── 3a. Find tables with a CCID variant column ───────────────────────────
    DECLARE @schema_sql NVARCHAR(MAX);
    SET @schema_sql = N'
        USE [' + @db_name + N'];
        SELECT
            s.name          AS schema_name,
            t.name          AS tbl_name,
            c.name          AS col_name,
            tp.name         AS data_type,
            c.is_nullable
        FROM sys.columns c
        JOIN sys.tables  t  ON t.object_id  = c.object_id
        JOIN sys.schemas s  ON s.schema_id  = t.schema_id
        JOIN sys.types   tp ON tp.user_type_id = c.user_type_id
        WHERE LOWER(c.name) IN (
            ''common_client_id'', ''commonclientid'', ''mccid'', ''ccid''
        )
        ORDER BY t.name, c.name;
    ';

    IF OBJECT_ID('tempdb..#schema_hits') IS NOT NULL DROP TABLE #schema_hits;
    CREATE TABLE #schema_hits (
        schema_name NVARCHAR(128),
        tbl_name    NVARCHAR(128),
        col_name    NVARCHAR(128),
        data_type   NVARCHAR(64),
        is_nullable BIT
    );

    BEGIN TRY
        INSERT INTO #schema_hits
        EXEC sp_executesql @schema_sql;
    END TRY
    BEGIN CATCH
        INSERT INTO #ccid_results
            (database_name, tier, db_role, table_name, column_name,
             data_type, total_rows, non_null_rows, distinct_values,
             coverage_pct, status, notes)
        VALUES
            (@db_name, @db_tier, @db_role, N'(n/a)', N'—',
             NULL, NULL, NULL, NULL, NULL,
             N'ERROR', SUBSTRING(ERROR_MESSAGE(), 1, 500));

        FETCH NEXT FROM db_cursor INTO @db_name, @db_tier, @db_role;
        CONTINUE;
    END CATCH;

    -- No hits in this database
    IF NOT EXISTS (SELECT 1 FROM #schema_hits)
    BEGIN
        INSERT INTO #ccid_results
            (database_name, tier, db_role, table_name, column_name,
             data_type, total_rows, non_null_rows, distinct_values,
             coverage_pct, status, notes)
        VALUES
            (@db_name, @db_tier, @db_role,
             N'(none)', N'—', NULL, NULL, NULL, NULL, NULL,
             N'ABSENT',
             N'No common_client_id variant found in any table');

        FETCH NEXT FROM db_cursor INTO @db_name, @db_tier, @db_role;
        CONTINUE;
    END;

    -- ── 3b. Measure coverage for each hit ────────────────────────────────────
    DECLARE @sch   NVARCHAR(128),
            @tbl   NVARCHAR(128),
            @col   NVARCHAR(128),
            @dtype NVARCHAR(64),
            @nullable BIT;

    DECLARE hit_cursor CURSOR LOCAL FAST_FORWARD FOR
        SELECT schema_name, tbl_name, col_name, data_type, is_nullable
        FROM #schema_hits;

    OPEN hit_cursor;
    FETCH NEXT FROM hit_cursor INTO @sch, @tbl, @col, @dtype, @nullable;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        DECLARE @total    BIGINT = NULL,
                @non_null BIGINT = NULL,
                @distinct BIGINT = NULL,
                @pct      DECIMAL(5,1) = NULL,
                @status   NVARCHAR(32),
                @notes    NVARCHAR(512) = N'';

        -- Fast row-count estimate via partition stats
        DECLARE @est_sql NVARCHAR(MAX) = N'
            USE [' + @db_name + N'];
            SELECT @rc = SUM(p.row_count)
            FROM   sys.dm_db_partition_stats p
            JOIN   sys.objects o ON o.object_id = p.object_id
            JOIN   sys.schemas s ON s.schema_id = o.schema_id
            WHERE  o.name = @tbl AND s.name = @sch
              AND  p.index_id IN (0, 1);
        ';

        DECLARE @est_rows BIGINT = 0;
        BEGIN TRY
            EXEC sp_executesql @est_sql,
                N'@tbl NVARCHAR(128), @sch NVARCHAR(128), @rc BIGINT OUTPUT',
                @tbl = @tbl, @sch = @sch, @rc = @est_rows OUTPUT;
        END TRY
        BEGIN CATCH
            SET @est_rows = -1;
        END CATCH;

        IF ISNULL(@est_rows, 0) = 0
        BEGIN
            -- Empty table or estimate unavailable
            SET @status = N'SCHEMA ONLY';
            SET @notes  = N'Table appears empty (partition stats = 0)';
        END
        ELSE
        BEGIN
            -- Measure actual coverage (NOLOCK — safe on large tables)
            DECLARE @cov_sql NVARCHAR(MAX) = N'
                USE [' + @db_name + N'];
                SELECT
                    @total    = COUNT(*),
                    @non_null = COUNT([' + @col + N']),
                    @distinct = COUNT(DISTINCT [' + @col + N'])
                FROM [' + @sch + N'].[' + @tbl + N'] WITH (NOLOCK);
            ';

            BEGIN TRY
                EXEC sp_executesql @cov_sql,
                    N'@total BIGINT OUTPUT, @non_null BIGINT OUTPUT, @distinct BIGINT OUTPUT',
                    @total    = @total    OUTPUT,
                    @non_null = @non_null OUTPUT,
                    @distinct = @distinct OUTPUT;

                IF ISNULL(@total, 0) > 0
                    SET @pct = CAST(@non_null * 100.0 / @total AS DECIMAL(5,1));
                ELSE
                    SET @pct = NULL;

                SET @status = CASE
                    WHEN @pct IS NULL                  THEN N'SCHEMA ONLY'
                    WHEN @pct >= @threshold            THEN N'DETERMINISTIC'
                    WHEN @pct  > 0                     THEN N'PARTIAL'
                    ELSE                                    N'ABSENT (null)'
                END;

                -- Flag known mapping tables
                IF @tbl IN ('CommonClientIdMapping','ClientId_Mapping','ClientIdMapping','MappingClient')
                    SET @status = N'MAPPING TABLE';

            END TRY
            BEGIN CATCH
                SET @status = N'ERROR';
                SET @notes  = SUBSTRING(ERROR_MESSAGE(), 1, 500);
            END CATCH;
        END;

        INSERT INTO #ccid_results
            (database_name, tier, db_role, table_name, column_name,
             data_type, total_rows, non_null_rows, distinct_values,
             coverage_pct, status, notes)
        VALUES
            (@db_name, @db_tier, @db_role,
             @sch + N'.' + @tbl, @col, @dtype,
             @total, @non_null, @distinct, @pct,
             @status, @notes);

        FETCH NEXT FROM hit_cursor INTO @sch, @tbl, @col, @dtype, @nullable;
    END;

    CLOSE hit_cursor;
    DEALLOCATE hit_cursor;

    IF OBJECT_ID('tempdb..#schema_hits') IS NOT NULL DROP TABLE #schema_hits;

    FETCH NEXT FROM db_cursor INTO @db_name, @db_tier, @db_role;
END;

CLOSE db_cursor;
DEALLOCATE db_cursor;

-- ── 4. Results ───────────────────────────────────────────────────────────────

-- 4a. Coverage matrix (main output)
SELECT
    database_name                               AS [Database],
    tier                                        AS [Tier],
    table_name                                  AS [Table],
    column_name                                 AS [Column],
    data_type                                   AS [Type],
    status                                      AS [Status],
    ISNULL(CAST(coverage_pct AS VARCHAR) + '%',
           '—')                                 AS [Coverage %],
    ISNULL(FORMAT(total_rows,    'N0'), '—')    AS [Total Rows],
    ISNULL(FORMAT(non_null_rows, 'N0'), '—')    AS [Non-Null Rows],
    ISNULL(FORMAT(distinct_values,'N0'), '—')   AS [Distinct IDs],
    ISNULL(notes, '')                           AS [Notes]
FROM #ccid_results
ORDER BY
    CASE status
        WHEN 'MAPPING TABLE'  THEN 1
        WHEN 'DETERMINISTIC'  THEN 2
        WHEN 'PARTIAL'        THEN 3
        WHEN 'SCHEMA ONLY'    THEN 4
        WHEN 'ABSENT (null)'  THEN 5
        WHEN 'ABSENT'         THEN 6
        WHEN 'NO ACCESS'      THEN 7
        WHEN 'ERROR'          THEN 8
        ELSE 9
    END,
    database_name,
    table_name;

-- 4b. Summary by database
SELECT
    database_name           AS [Database],
    tier                    AS [Tier],
    db_role                 AS [Role],
    COUNT(*)                AS [Tables Found],
    SUM(CASE WHEN status = 'DETERMINISTIC'  THEN 1 ELSE 0 END) AS [Deterministic],
    SUM(CASE WHEN status = 'PARTIAL'        THEN 1 ELSE 0 END) AS [Partial],
    SUM(CASE WHEN status = 'MAPPING TABLE'  THEN 1 ELSE 0 END) AS [Mapping Tables],
    SUM(CASE WHEN status IN ('ABSENT','ABSENT (null)') THEN 1 ELSE 0 END) AS [Absent],
    MAX(CASE WHEN status NOT IN ('ABSENT','ABSENT (null)','NO ACCESS','ERROR')
             THEN 'HAS CCID' ELSE 'NO CCID' END)               AS [CCID Present?],
    MAX(CASE WHEN status = 'ABSENT' THEN notes ELSE '' END)     AS [Notes]
FROM #ccid_results
GROUP BY database_name, tier, db_role
ORDER BY
    CASE MAX(CASE WHEN status NOT IN ('ABSENT','ABSENT (null)','NO ACCESS','ERROR')
                  THEN 'HAS CCID' ELSE 'NO CCID' END)
        WHEN 'HAS CCID' THEN 1 ELSE 2
    END,
    database_name;

-- 4c. Audit queries for Megatron (run separately to validate data quality)
PRINT '';
PRINT '============================================================';
PRINT 'AUDIT QUERIES — run these in Megatron to validate CCID quality';
PRINT '============================================================';
PRINT '
-- 1. Null rate in Client.common_client_id
USE Megatron;
SELECT
    COUNT(*)                                        AS total_clients,
    COUNT(common_client_id)                         AS non_null,
    COUNT(DISTINCT common_client_id)                AS distinct_ids,
    CAST(COUNT(common_client_id) * 100.0
         / NULLIF(COUNT(*), 0) AS DECIMAL(5,1))     AS pct_populated
FROM [Client] WITH (NOLOCK);

-- 2. Duplicate acc_id mappings in CommonClientIdMapping
USE Megatron;
SELECT acc_id, COUNT(*) AS mapping_count
FROM [CommonClientIdMapping]
GROUP BY acc_id
HAVING COUNT(*) > 1
ORDER BY mapping_count DESC;

-- 3. Cross-check Client vs CommonClientIdMapping
USE Megatron;
SELECT TOP 100
    c.acc_ID,
    c.common_client_id              AS client_ccid,
    m.client_id                     AS mapping_client_id,
    m.sales_channel_id,
    m.ref_id,
    CASE WHEN CAST(c.common_client_id AS VARCHAR(50)) = m.client_id
         THEN ''MATCH'' ELSE ''MISMATCH'' END AS id_match
FROM [Client]              c WITH (NOLOCK)
LEFT JOIN [CommonClientIdMapping] m WITH (NOLOCK)
    ON m.acc_id = c.acc_ID
WHERE c.common_client_id IS NOT NULL
ORDER BY id_match DESC;
';

DROP TABLE #ccid_results;
