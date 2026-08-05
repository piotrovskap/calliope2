"""Find correct timestamp columns for the failed targets."""
from db import query

for db, sch, tbl in [
    ("RedDawn", "dbo", "ListingImageDownload_Queue_History"),
    ("MegatronRepository", "dbo", "ListingVehicleRepository"),
]:
    print(f"\n== {db}.{sch}.{tbl} ==")
    sql = f"""
    SELECT c.name, ty.name AS dtype
    FROM sys.columns c
    JOIN sys.tables t ON c.object_id = t.object_id
    JOIN sys.schemas s ON t.schema_id = s.schema_id
    JOIN sys.types ty ON c.user_type_id = ty.user_type_id
    WHERE s.name = '{sch}' AND t.name = '{tbl}'
      AND ty.name IN ('datetime','datetime2','smalldatetime','date','datetimeoffset')
    ORDER BY c.column_id
    """
    _, rows, _ = query(sql, database=db)
    for n, t in rows:
        print(f"  {n:35s} {t}")
