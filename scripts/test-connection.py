"""
Test SQL Server connectivity — second server
DAS Technology · Phase 0 Discovery
Researcher: Alicia Salazar · 2026-06-14

Run from your local machine:
    pip install pymssql python-dotenv
    python scripts/test-connection.py

Reads credentials from .env in the repo root.
"""

import os
import sys
from pathlib import Path

# Load .env from repo root (one level up from scripts/)
try:
    from dotenv import load_dotenv
    load_dotenv(Path(__file__).parent.parent / ".env")
except ImportError:
    pass  # fall back to os.environ

try:
    import pymssql
except ImportError:
    sys.exit("pymssql not installed. Run: pip install pymssql")

HOST     = os.getenv("ETL_MSSQL_HOST",     "74.179.80.27")
PORT     = int(os.getenv("ETL_MSSQL_PORT", "1433"))
USER     = os.getenv("ETL_MSSQL_USER",     "ConflictAI")
PASSWORD = os.getenv("ETL_MSSQL_PASSWORD", "")

DATABASES = ["DWRPT_AI", "DataStaging", "kFeedhub", "Zuora"]

print(f"\nConnecting to {HOST}:{PORT} as {USER}\n")
print(f"{'Database':<20} {'Status':<12} {'Tables':>7}  {'SQL Server version'}")
print("-" * 90)

all_ok = True
for db in DATABASES:
    try:
        conn = pymssql.connect(
            server=HOST, port=PORT,
            user=USER, password=PASSWORD,
            database=db,
            login_timeout=10, timeout=15
        )
        cur = conn.cursor()

        # Table count
        cur.execute(
            "SELECT COUNT(*) FROM information_schema.tables "
            "WHERE table_type = 'BASE TABLE'"
        )
        table_count = cur.fetchone()[0]

        # SQL Server version (first line only)
        cur.execute("SELECT @@VERSION")
        version = cur.fetchone()[0].split('\n')[0].strip()

        conn.close()
        print(f"  {db:<18} {'OK':<12} {table_count:>7}  {version}")

    except pymssql.OperationalError as e:
        all_ok = False
        msg = str(e).replace('\n', ' ').strip()
        print(f"  {db:<18} {'FAILED':<12}         {msg[:80]}")
    except Exception as e:
        all_ok = False
        print(f"  {db:<18} {'ERROR':<12}         {str(e)[:80]}")

print()
if all_ok:
    print("All databases reachable.")
else:
    print("One or more databases failed. Check firewall / credentials.")
print()
