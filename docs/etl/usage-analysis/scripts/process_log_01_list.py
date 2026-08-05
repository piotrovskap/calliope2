"""List all process_log_* tables on RL_PROD.oltp and their row counts.

Also detects whether there's a "current" non-dated process_log table.
"""
from db import query

print("== process_log_* tables on RL_PROD.oltp ==")
_, rows, dt = query("""
    SELECT s.name AS [schema],
           t.name AS [table],
           p.rows AS row_count,
           SUM(a.total_pages) * 8 / 1024.0 AS total_mb
    FROM sys.tables t
    JOIN sys.schemas s ON t.schema_id = s.schema_id
    JOIN sys.indexes i ON t.object_id = i.object_id
    JOIN sys.partitions p ON i.object_id = p.object_id AND i.index_id = p.index_id
    JOIN sys.allocation_units a ON p.partition_id = a.container_id
    WHERE i.index_id IN (0,1)
      AND t.is_ms_shipped = 0
      AND LOWER(t.name) LIKE 'process_log%'
    GROUP BY s.name, t.name, p.rows
    ORDER BY t.name DESC
""", database="oltp", prefix="RL_PROD")

print(f"q={dt:.2f}s, {len(rows)} tables\n")
total_rows = 0
for sch, tbl, rc, mb in rows:
    print(f"  {sch}.{tbl:40s}  rows={int(rc):>10,}  size={float(mb or 0):>8.1f} MB")
    total_rows += int(rc)
print(f"\ntotal rows across all process_log tables: {total_rows:,}")

# Also write to CSV
import csv
from pathlib import Path
DATA = Path(__file__).resolve().parents[1] / "data" / "rl_prod"
DATA.mkdir(parents=True, exist_ok=True)
with (DATA / "40_process_log_tables.csv").open("w", newline="") as f:
    w = csv.writer(f)
    w.writerow(["schema", "table", "row_count", "total_mb"])
    for r in rows:
        w.writerow([r[0], r[1], int(r[2] or 0), float(r[3] or 0)])
print(f"\nwrote {DATA / '40_process_log_tables.csv'}")
