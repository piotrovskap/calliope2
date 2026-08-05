"""Inspect candidate log tables' schemas and sample rows."""
from db import query

candidates = [
    ("Megatron", "dbo", "BackupLog"),
    ("Megatron", "dbo", "BKUPHistory"),
    ("Megatron", "dbo", "obr_History_v4"),
    ("Megatron", "dbo", "PerformanceTargetAccounts_History"),
    ("Megatron", "dbo", "FileDetails_Log"),
    ("Megatron", "dbo", "ActivityLog"),
    ("RedDawn", "dbo", "ListingImageDownload_Queue_History"),
]

for db, sch, tbl in candidates:
    print(f"\n==== {db}.{sch}.{tbl} ====")
    try:
        sql = f"""
        SELECT c.name, ty.name AS data_type, c.max_length, c.is_nullable
        FROM sys.columns c
        JOIN sys.tables t ON c.object_id = t.object_id
        JOIN sys.schemas s ON t.schema_id = s.schema_id
        JOIN sys.types ty ON c.user_type_id = ty.user_type_id
        WHERE s.name = '{sch}' AND t.name = '{tbl}'
        ORDER BY c.column_id
        """
        _, cols, _ = query(sql, database=db)
        for c, t, ml, nn in cols:
            print(f"  {c:35s} {t:15s} maxlen={ml:>6}  null={nn}")
        _, sample, _ = query(f"SELECT TOP 3 * FROM [{sch}].[{tbl}] WITH (NOLOCK) ORDER BY 1 DESC", database=db)
        print(f"  --- {len(sample)} sample rows ---")
        for r in sample:
            print("    " + " | ".join(str(v)[:40] for v in r))
    except Exception as e:
        print(f"  ! {e}")
