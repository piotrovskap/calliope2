"""Resolve SQL Agent Job IDs (from ProgramName hex) to friendly job names via msdb."""
import re
import csv
from pathlib import Path
from db import query

DATA = Path(__file__).resolve().parents[1] / "data"

# Read the job samples list
with (DATA / "26_sql_agent_jobs.csv").open() as f:
    r = csv.DictReader(f)
    jobs = list(r)

# Extract Job ID hex from each ProgramName
JOB_HEX = re.compile(r"Job 0x([0-9A-F]+)", re.IGNORECASE)

# Get all SQL Agent jobs from msdb
try:
    _, rows, _ = query(
        "SELECT job_id, name, enabled, date_created, date_modified, description "
        "FROM dbo.sysjobs ORDER BY name",
        database="msdb",
    )
except Exception as e:
    print(f"failed to query msdb.sysjobs: {e}")
    raise SystemExit

print(f"{len(rows)} jobs in msdb.sysjobs\n")
# Build hex(byte-reversed) → name map
# In SQL Server, the binary job_id is stored little-endian; ProgramName shows
# the value as displayed by sys.dm_exec_sessions which is the binary repr.
# Easiest: try both raw and reversed.
hex_to_name = {}
for jid, name, enabled, dc, dm, desc in rows:
    raw_hex = bytes(jid).hex().upper() if isinstance(jid, (bytes, bytearray)) else None
    if raw_hex:
        hex_to_name[raw_hex] = (name, enabled, dc, dm, desc)

# Match each program string
out_rows = []
matched = 0
for j in jobs:
    prog = j["program"]
    m = JOB_HEX.search(prog)
    if not m:
        continue
    hex_str = m.group(1).upper()
    info = hex_to_name.get(hex_str)
    if info:
        name, enabled, dc, dm, desc = info
        print(f"  samples={j['samples']:>7s}  days={j['days_seen']:>3s}  db={j['database']:18s} | {name}")
        out_rows.append([
            hex_str, name, j["database"], j["samples"], j["days_seen"],
            enabled, str(dc), str(dm), (desc or "").replace("\n", " ")[:200],
        ])
        matched += 1
    else:
        out_rows.append([hex_str, "(unknown)", j["database"], j["samples"],
                         j["days_seen"], "", "", "", ""])

print(f"\nmatched {matched}/{len(jobs)} job entries")

with (DATA / "29_sql_agent_jobs_named.csv").open("w", newline="") as f:
    w = csv.writer(f)
    w.writerow(["job_id_hex", "job_name", "database", "samples", "days_seen",
                "enabled", "date_created", "date_modified", "description"])
    for r in out_rows:
        w.writerow(r)
