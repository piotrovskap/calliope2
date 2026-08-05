"""Inspect process_log schema and sample recent rows."""
from db import query

DB = "oltp"
TBL = "process_log_20260613T23"  # most recent complete week

print(f"== {DB}.{TBL} schema ==")
_, rows, _ = query(f"""
    SELECT c.name, ty.name AS dtype, c.max_length, c.is_nullable
    FROM sys.columns c
    JOIN sys.tables t ON c.object_id = t.object_id
    JOIN sys.schemas s ON t.schema_id = s.schema_id
    JOIN sys.types ty ON c.user_type_id = ty.user_type_id
    WHERE s.name = 'dbo' AND t.name = '{TBL}'
    ORDER BY c.column_id
""", database=DB, prefix="RL_PROD")
for n, t, ml, nn in rows:
    print(f"  {n:35s} {t:15s} maxlen={ml:>6}  null={nn}")

print(f"\n== sample rows (TOP 5, recent) ==")
_, sample, _ = query(f"SELECT TOP 5 * FROM dbo.[{TBL}] WITH (NOLOCK) ORDER BY 1 DESC",
                     database=DB, prefix="RL_PROD")
col_names = [r[0] for r in rows]
for s in sample:
    print()
    for c, v in zip(col_names, s):
        sv = str(v) if v is not None else "NULL"
        if len(sv) > 100:
            sv = sv[:100] + "…"
        print(f"  {c:35s} = {sv}")

print(f"\n== distinct values in process-name-ish columns ==")
# After schema inspection, guess what's the process_name column.
# Try common names: name, process_name, source, action, command, sp_name, type
for col in ("name", "process_name", "source", "action", "command", "sp_name", "type"):
    try:
        _, top, dt = query(
            f"SELECT TOP 15 [{col}], COUNT_BIG(*) AS n FROM dbo.[{TBL}] WITH (NOLOCK) "
            f"WHERE [{col}] IS NOT NULL GROUP BY [{col}] ORDER BY n DESC",
            database=DB, prefix="RL_PROD",
        )
        print(f"\n  -- top 15 by {col} (q={dt:.1f}s) --")
        for v, n in top:
            print(f"    {int(n):>10,}  {str(v)[:80]}")
    except Exception:
        pass
