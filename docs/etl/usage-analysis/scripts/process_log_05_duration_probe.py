"""Probe how widespread the `Completed: HH:MM:SS.fff` pattern is in
message_text, and sample non-matching rows to understand other formats.

Only scans one recent week to keep cost bounded.
"""
from db import query

TBL = "process_log_20260613T23"

print("== matching vs non-matching rows ==")
_, rows, dt = query(f"""
    SELECT
        SUM(CASE WHEN message_text LIKE 'Completed:%' THEN 1 ELSE 0 END) AS completed_prefix,
        SUM(CASE WHEN message_text LIKE '%Completed:%' THEN 1 ELSE 0 END) AS completed_anywhere,
        SUM(CASE WHEN message_text IS NULL THEN 1 ELSE 0 END) AS null_text,
        COUNT_BIG(*) AS total
    FROM dbo.[{TBL}] WITH (NOLOCK)
""", database="oltp", prefix="RL_PROD")
print(f"q={dt:.1f}s")
for c, n in zip(["completed_prefix", "completed_anywhere", "null_text", "total"], rows[0]):
    print(f"  {c}: {int(n):,}")

print("\n== sample 'Completed:' messages — confirm parseable shape ==")
_, rows, _ = query(f"""
    SELECT TOP 10 LEFT(message_text, 60), subject
    FROM dbo.[{TBL}] WITH (NOLOCK)
    WHERE message_text LIKE 'Completed:%'
""", database="oltp", prefix="RL_PROD")
for txt, subj in rows:
    print(f"  [{str(subj)[:35]:35s}] {txt}")

print("\n== sample non-'Completed:' messages — by component ==")
_, rows, _ = query(f"""
    SELECT TOP 30 component, subject, LEFT(message_text, 80) AS msg
    FROM dbo.[{TBL}] WITH (NOLOCK)
    WHERE message_text NOT LIKE '%Completed:%'
      AND message_text IS NOT NULL
""", database="oltp", prefix="RL_PROD")
for comp, subj, msg in rows:
    print(f"  [{str(comp)[:20]:20s}] [{str(subj)[:30]:30s}] {msg}")

print("\n== test the SQL extraction on a sample ==")
_, rows, _ = query(f"""
    SELECT TOP 10
        message_text AS txt,
        SUBSTRING(message_text, 12, 2) AS hh,
        SUBSTRING(message_text, 15, 2) AS mm,
        SUBSTRING(message_text, 18, 2) AS ss,
        SUBSTRING(message_text, 21, 3) AS frac3,
        TRY_CAST(SUBSTRING(message_text, 12, 2) AS INT) * 3600000
         + TRY_CAST(SUBSTRING(message_text, 15, 2) AS INT) * 60000
         + TRY_CAST(SUBSTRING(message_text, 18, 2) AS INT) * 1000
         + TRY_CAST(SUBSTRING(message_text, 21, 3) AS INT) AS total_ms
    FROM dbo.[{TBL}] WITH (NOLOCK)
    WHERE message_text LIKE 'Completed:%'
""", database="oltp", prefix="RL_PROD")
for txt, hh, mm, ss, frac, ms in rows:
    print(f"  {hh}:{mm}:{ss}.{frac} → {ms} ms  [{str(txt)[:60]}]")
