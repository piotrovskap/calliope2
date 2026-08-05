"""Phase 1c — derive the canonical ETL output table list.

Scans every .sql file under the ETL repo for write statements
(INSERT INTO / SELECT INTO / MERGE INTO / UPDATE / DELETE FROM) and extracts
the target table name. Then cross-references with the discovered tables to
produce data/04_etl_target_tables.csv — the allow-list for phase 2.
"""
from __future__ import annotations

import csv
import re
from collections import defaultdict
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[4]  # scripts → usage-analysis → etl → docs → das-tech
ETL_ROOTS = [
    REPO_ROOT / "etl" / "SSIS",
    REPO_ROOT / "etl" / "BlackBook",
    REPO_ROOT / "etl" / "Juicebox Reporting",
    REPO_ROOT / "etl" / "Mautic",
    REPO_ROOT / "etl" / "PostgreSQL (Analytics Mautic)",
]
DATA = Path(__file__).resolve().parents[1] / "data"

# Captures: optional [db].[schema].[table] / db.schema.table / schema.table / table
# Brackets, double-quotes, or bare identifiers
IDENT = r'(?:\[[^\]]+\]|"[^"]+"|[A-Za-z_][A-Za-z0-9_]*)'
QUAL  = rf'(?:{IDENT}\.)?(?:{IDENT}\.)?{IDENT}'

PATTERNS = [
    ("insert", re.compile(rf'\bINSERT\s+INTO\s+({QUAL})', re.IGNORECASE)),
    ("select_into", re.compile(rf'\bINTO\s+({QUAL})\s+FROM\b', re.IGNORECASE)),
    ("merge", re.compile(rf'\bMERGE\s+(?:INTO\s+)?({QUAL})', re.IGNORECASE)),
    ("update", re.compile(rf'\bUPDATE\s+({QUAL})\s+(?:SET|FROM|WITH)', re.IGNORECASE)),
    ("delete", re.compile(rf'\bDELETE\s+FROM\s+({QUAL})', re.IGNORECASE)),
]

STRIP = re.compile(r'[\[\]"]')


def normalize(qual: str) -> tuple[str | None, str | None, str]:
    """Returns (db, schema, table) lowercased; db/schema may be None."""
    parts = [STRIP.sub("", p).strip() for p in qual.split(".") if p.strip()]
    if len(parts) == 3:
        return parts[0].lower(), parts[1].lower(), parts[2].lower()
    if len(parts) == 2:
        return None, parts[0].lower(), parts[1].lower()
    return None, None, parts[0].lower()


def scan() -> dict:
    """Returns {(db?, schema?, table): {op: count, files: {file: count}}}."""
    hits = defaultdict(lambda: {"ops": defaultdict(int), "files": set()})
    for root in ETL_ROOTS:
        if not root.exists():
            continue
        for sql_file in root.rglob("*.sql"):
            try:
                txt = sql_file.read_text(errors="replace")
            except Exception:
                continue
            # crude comment strip
            txt = re.sub(r"--[^\n]*", "", txt)
            txt = re.sub(r"/\*.*?\*/", "", txt, flags=re.DOTALL)
            for op, pat in PATTERNS:
                for m in pat.finditer(txt):
                    key = normalize(m.group(1))
                    # skip @vars, #temp, ##globaltemp, and obvious CTE noise
                    if any(p and p.startswith(("#", "@")) for p in key if p):
                        continue
                    if key[2].startswith(("#", "@")):
                        continue
                    if key[2] in {"select", "from", "where", "set", "values"}:
                        continue
                    hits[key]["ops"][op] += 1
                    hits[key]["files"].add(str(sql_file.relative_to(REPO_ROOT)))
    return hits


def load_real_tables() -> dict:
    """{(db_lower, schema_lower, table_lower): row}"""
    real = {}
    with (DATA / "01_tables.csv").open() as f:
        r = csv.DictReader(f)
        for row in r:
            k = (row["database"].lower(), row["schema"].lower(), row["table"].lower())
            real[k] = row
    return real


def main():
    hits = scan()
    real = load_real_tables()

    # Resolve any 2- or 1-part names against the real catalog by table name match.
    # If unique match by table name, attach the (db, schema).
    by_table_name = defaultdict(list)
    for k in real:
        by_table_name[k[2]].append(k)

    matched, unmatched = [], []
    for (db, sch, tbl), meta in hits.items():
        candidates = by_table_name.get(tbl, [])
        resolved = None
        if db and sch:
            resolved = (db, sch, tbl) if (db, sch, tbl) in real else None
        if not resolved and sch:
            cands = [k for k in candidates if k[1] == sch]
            if len(cands) == 1:
                resolved = cands[0]
        if not resolved and len(candidates) == 1:
            resolved = candidates[0]

        record = {
            "raw_db": db or "",
            "raw_schema": sch or "",
            "raw_table": tbl,
            "ops": dict(meta["ops"]),
            "n_files": len(meta["files"]),
            "files": sorted(meta["files"])[:5],
        }
        if resolved:
            r = real[resolved]
            record.update({
                "resolved_db": resolved[0],
                "resolved_schema": resolved[1],
                "resolved_table": resolved[2],
                "row_count": int(r["row_count"] or 0),
                "total_mb": float(r["total_mb"] or 0),
            })
            matched.append(record)
        else:
            unmatched.append(record)

    # Sort matched by row count desc
    matched.sort(key=lambda r: r["row_count"], reverse=True)

    # Write allow-list
    with (DATA / "04_etl_target_tables.csv").open("w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["database", "schema", "table", "row_count", "total_mb",
                    "ops", "n_files", "sample_files"])
        for r in matched:
            w.writerow([
                r["resolved_db"], r["resolved_schema"], r["resolved_table"],
                r["row_count"], round(r["total_mb"], 1),
                ";".join(f"{k}={v}" for k, v in sorted(r["ops"].items())),
                r["n_files"], " | ".join(r["files"]),
            ])

    with (DATA / "04b_etl_unresolved.csv").open("w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["raw_db", "raw_schema", "raw_table", "ops", "n_files", "sample_files"])
        for r in unmatched:
            w.writerow([
                r["raw_db"], r["raw_schema"], r["raw_table"],
                ";".join(f"{k}={v}" for k, v in sorted(r["ops"].items())),
                r["n_files"], " | ".join(r["files"]),
            ])

    print(f"matched ETL targets: {len(matched)}")
    print(f"unresolved refs (likely temp/cte/typo or in inaccessible DBs): {len(unmatched)}")
    print("\nTop 25 matched ETL output tables by rows:")
    for r in matched[:25]:
        ops = ",".join(f"{k}:{v}" for k, v in sorted(r['ops'].items()))
        print(f"  {r['resolved_db']}.{r['resolved_schema']}.{r['resolved_table']:50s}"
              f"  rows={r['row_count']:>12,}  mb={r['total_mb']:>8.1f}  ops={ops}")


if __name__ == "__main__":
    main()
