"""Search for ETL log/audit tables across all accessible DBs.

Specifically looking for JuiceReporting_Logs (referenced in
etl/Juicebox Reporting/*.sql) and any *_Log/*_History table that
records start_time/end_time/records_processed.
"""
from db import query

dbs = ["EndeavorCentral", "Megatron", "MegatronRepository", "OutboundFeeds",
       "PetFinder", "Prime", "RedDawn", "Trax", "WEB"]

PATTERNS = ("juicereporting_logs", "etl_log", "ssis_log", "process_log",
            "run_log", "audit_log", "execution_log", "_history",
            "sp_executions", "executionlog")

print("Tables matching ETL-log patterns:\n")
total = 0
for db in dbs:
    where = " OR ".join([f"LOWER(t.name) LIKE '%{p}%'" for p in PATTERNS])
    sql = f"""
    SELECT s.name + '.' + t.name AS full_name,
           (SELECT COUNT(*) FROM sys.columns c WHERE c.object_id = t.object_id) AS n_cols,
           p.rows AS row_count
    FROM sys.tables t
    JOIN sys.schemas s ON t.schema_id = s.schema_id
    JOIN sys.indexes i ON t.object_id = i.object_id AND i.index_id IN (0,1)
    JOIN sys.partitions p ON i.object_id = p.object_id AND i.index_id = p.index_id
    WHERE {where}
    """
    try:
        _, rows, _ = query(sql, database=db)
    except Exception as e:
        print(f"  ! {db}: {e}")
        continue
    for fn, ncols, rc in rows:
        print(f"  {db}.{fn:50s}  ncols={ncols:>3}  rows={rc:>12,}")
        total += 1
print(f"\nfound {total} candidates")
