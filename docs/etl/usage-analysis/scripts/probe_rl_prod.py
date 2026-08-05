"""Try multiple TDS versions / encryption flags against RL_PROD."""
import os
import pyodbc
from pathlib import Path
from dotenv import load_dotenv

load_dotenv(Path(__file__).resolve().parents[4] / ".env")

H = os.environ["RL_PROD_MSSQL_HOST"]
P = os.environ["RL_PROD_MSSQL_PORT"]
U = os.environ["RL_PROD_MSSQL_USER"]
PW = os.environ["RL_PROD_MSSQL_PASSWORD"]

# Combinations to try
VARIANTS = [
    {"TDS_Version": "7.0"},
    {"TDS_Version": "7.1"},
    {"TDS_Version": "7.2"},
    {"TDS_Version": "7.3"},
    {"TDS_Version": "7.4"},
    {"TDS_Version": "7.4", "Encrypt": "yes"},
    {"TDS_Version": "7.4", "Encrypt": "yes", "TrustServerCertificate": "yes"},
    {"TDS_Version": "8.0"},  # FreeTDS supports this for Azure
]

for v in VARIANTS:
    parts = [
        "DRIVER={FreeTDS}",
        f"SERVER={H}",
        f"PORT={P}",
        f"UID={U}",
        f"PWD={PW}",
        "ClientCharset=UTF-8",
    ]
    for k, val in v.items():
        parts.append(f"{k}={val}")
    cs = ";".join(parts)
    label = " ".join(f"{k}={val}" for k, val in v.items())
    try:
        cn = pyodbc.connect(cs, timeout=15, readonly=True, autocommit=True)
        cur = cn.cursor()
        cur.execute("SELECT @@VERSION, @@SERVERNAME")
        row = cur.fetchone()
        cn.close()
        print(f"  ✓ {label}")
        print(f"      server: {row[1]}")
        print(f"      version: {str(row[0])[:120]}")
        break
    except Exception as e:
        print(f"  ✗ {label}  → {str(e)[:120]}")
