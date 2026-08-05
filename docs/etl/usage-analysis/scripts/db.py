"""Shared SQL Server connection helper.

Read-only. Loads credentials from repo-root .env via python-dotenv.

Supports multiple servers via env-variable prefix:
    ETL      -> ETL_MSSQL_HOST / ETL_MSSQL_PORT / ...
    RL_PROD  -> RL_PROD_MSSQL_HOST / ...
    DWRPT    -> DWRPT_MSSQL_HOST / ...
    CIM      -> CIM_MSSQL_HOST / ...
"""
from __future__ import annotations

import os
import time
from contextlib import contextmanager
from pathlib import Path

import pyodbc
from dotenv import load_dotenv

REPO_ROOT = Path(__file__).resolve().parents[4]  # scripts → usage-analysis → etl → docs → das-tech
load_dotenv(REPO_ROOT / ".env")

DEFAULT_PREFIX = "ETL"


def _env(prefix: str, key: str, default: str | None = None) -> str | None:
    return os.environ.get(f"{prefix}_MSSQL_{key}", default)


def _conn_str(prefix: str, database: str | None = None) -> str:
    host = _env(prefix, "HOST")
    if not host:
        raise RuntimeError(f"missing {prefix}_MSSQL_HOST in .env")
    port = _env(prefix, "PORT", "1433")
    user = _env(prefix, "USER")
    pw = _env(prefix, "PASSWORD")
    tds = _env(prefix, "TDS_VERSION", "7.4")  # SQL 2012=7.0/7.1, 2014=7.3, 2016+=7.4
    parts = [
        "DRIVER={FreeTDS}",
        f"SERVER={host}",
        f"PORT={port}",
        f"UID={user}",
        f"PWD={pw}",
        f"TDS_Version={tds}",
        "ClientCharset=UTF-8",
    ]
    if database:
        parts.append(f"DATABASE={database}")
    return ";".join(parts)


@contextmanager
def connect(database: str | None = None, prefix: str = DEFAULT_PREFIX):
    cn = pyodbc.connect(_conn_str(prefix, database), timeout=30, readonly=True, autocommit=True)
    try:
        yield cn
    finally:
        cn.close()


def query(sql: str, database: str | None = None, params: tuple | None = None,
          prefix: str = DEFAULT_PREFIX):
    """Run a SELECT and return (columns, rows, elapsed_seconds)."""
    t0 = time.perf_counter()
    with connect(database, prefix=prefix) as cn:
        cur = cn.cursor()
        cur.execute(sql, params or ())
        cols = [c[0] for c in cur.description] if cur.description else []
        rows = cur.fetchall()
    return cols, rows, time.perf_counter() - t0


if __name__ == "__main__":
    import sys
    prefixes = sys.argv[1:] or ["ETL", "RL_PROD", "DWRPT", "CIM"]
    for p in prefixes:
        print(f"\n== {p} ==")
        try:
            cols, rows, dt = query(
                "SELECT @@SERVERNAME AS server, @@VERSION AS v, "
                "SUSER_NAME() AS login, GETDATE() AS now",
                prefix=p,
            )
            print(f"  connected in {dt:.2f}s")
            for r in rows:
                for c, v in zip(cols, r):
                    print(f"  {c}: {str(v)[:120]}")
        except Exception as e:
            print(f"  ! {e}")
