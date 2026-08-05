#!/usr/bin/env python3
"""Encode the brain as SQLite — the dormant option for when JSON outgrows itself.

app/brain.json (the canonical projection) <-> brain.db (queryable: SQL joins,
math, FTS5 search). The .db is derived and untracked (gitignored), built on
demand. SQLite is NOT used by the portal or CI today — brain.json stays the
source of truth. These are the tools to keep the option open until the JSON
becomes unmanageable:

  build  — seed / migrate-in   (brain.json -> brain.db)
  dump   — migrate-out         (brain.db  -> brain.json)
  query  — read                (SELECT ... )
  exec   — write / CRUD        (INSERT/UPDATE/DELETE/DDL)
  check  — verify the encoding round-trips losslessly

Each node/edge keeps its full JSON in a `json` column (lossless source of truth
for `dump`), alongside extracted columns for querying. No new data: a faithful
re-encoding of brain.json. A future Cloudflare D1 deploy loads the same schema.

Usage:
  python3 scripts/brain-sqlite.py build [db]      # brain.json -> brain.db
  python3 scripts/brain-sqlite.py dump  [db]       # brain.db  -> json on stdout
  python3 scripts/brain-sqlite.py query "<SQL>"    # read: run a query, print rows
  python3 scripts/brain-sqlite.py exec  "<SQL>"    # write/CRUD directly on brain.db
  python3 scripts/brain-sqlite.py check            # build + dump, assert lossless
"""
import json
import sqlite3
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
BRAIN = ROOT / 'app' / 'brain.json'
DEFAULT_DB = ROOT / 'app' / 'brain.db'

SCHEMA = """
CREATE TABLE node (
  id TEXT PRIMARY KEY, kind TEXT, label TEXT, derived INTEGER,
  durability TEXT, status TEXT, owner TEXT, source_path TEXT, json TEXT
);
CREATE TABLE edge (
  id TEXT PRIMARY KEY, src TEXT, dst TEXT, type TEXT, class TEXT, json TEXT
);
CREATE INDEX idx_node_kind ON node(kind);
CREATE INDEX idx_edge_src ON edge(src);
CREATE INDEX idx_edge_dst ON edge(dst);
CREATE INDEX idx_edge_type ON edge(type);
CREATE VIRTUAL TABLE node_fts USING fts5(id UNINDEXED, label, kind, headings);
"""


def build(db_path):
    brain = json.loads(BRAIN.read_text(encoding='utf-8'))
    if Path(db_path).exists():
        Path(db_path).unlink()
    con = sqlite3.connect(db_path)
    con.executescript(SCHEMA)
    for n in brain['nodes']:
        src = n.get('source') or {}
        con.execute(
            'INSERT INTO node(id,kind,label,derived,durability,status,owner,source_path,json)'
            ' VALUES (?,?,?,?,?,?,?,?,?)',
            (n['id'], n['kind'], n.get('label'), int(bool(n.get('derived'))),
             n.get('durability'), n.get('status'), n.get('owner'), src.get('path'),
             json.dumps(n, ensure_ascii=False)))
        headings = ' '.join((n.get('data') or {}).get('headings', []) or [])
        con.execute('INSERT INTO node_fts(id,label,kind,headings) VALUES (?,?,?,?)',
                    (n['id'], n.get('label'), n['kind'], headings))
    for e in brain['edges']:
        con.execute('INSERT INTO edge(id,src,dst,type,class,json) VALUES (?,?,?,?,?,?)',
                    (e['id'], e['src'], e['dst'], e['type'], e.get('class'),
                     json.dumps(e, ensure_ascii=False)))
    con.commit()
    n_nodes = con.execute('SELECT count(*) FROM node').fetchone()[0]
    n_edges = con.execute('SELECT count(*) FROM edge').fetchone()[0]
    con.close()
    return n_nodes, n_edges


def dump(db_path):
    con = sqlite3.connect(db_path)
    nodes = [json.loads(r[0]) for r in con.execute('SELECT json FROM node ORDER BY kind, id')]
    edges = [json.loads(r[0]) for r in
             con.execute('SELECT json FROM edge ORDER BY type, src, dst')]
    con.close()
    return {'nodes': nodes, 'edges': edges}


def check():
    brain = json.loads(BRAIN.read_text(encoding='utf-8'))
    with tempfile.TemporaryDirectory() as td:
        db = Path(td) / 'brain.db'
        build(db)
        out = dump(db)
    if out['nodes'] != brain['nodes'] or out['edges'] != brain['edges']:
        # locate first divergence
        for a, b in zip(out['nodes'], brain['nodes']):
            if a != b:
                print(f'ROUND-TRIP FAILED: node diverged at {b.get("id")}')
                sys.exit(1)
        print(f'ROUND-TRIP FAILED: counts nodes {len(out["nodes"])}/{len(brain["nodes"])} '
              f'edges {len(out["edges"])}/{len(brain["edges"])}')
        sys.exit(1)
    print(f'OK: brain.json <-> brain.db round-trip is lossless '
          f'({len(brain["nodes"])} nodes, {len(brain["edges"])} edges)')


def query(sql, db_path):
    if not Path(db_path).exists():
        build(db_path)
    con = sqlite3.connect(db_path)
    con.row_factory = sqlite3.Row
    for row in con.execute(sql):
        print(json.dumps({k: row[k] for k in row.keys()}, ensure_ascii=False))
    con.close()


def exec_sql(sql, db_path):
    """Write/CRUD directly on brain.db (INSERT/UPDATE/DELETE/DDL).

    For when SQLite becomes the primary store. Until then brain.json is the
    source and the db is rebuilt from it, so writes here are overwritten by the
    next `build`. The FTS index (node_fts) is not auto-synced — rebuild it if you
    mutate node labels/headings.
    """
    if not Path(db_path).exists():
        build(db_path)
    con = sqlite3.connect(db_path)
    con.executescript(sql)
    con.commit()
    print(f'OK: executed ({con.total_changes} row(s) changed)')
    con.close()


def main():
    cmd = sys.argv[1] if len(sys.argv) > 1 else 'build'
    if cmd == 'build':
        db = sys.argv[2] if len(sys.argv) > 2 else DEFAULT_DB
        n, e = build(db)
        print(f'Wrote {Path(db).relative_to(ROOT) if Path(db).is_relative_to(ROOT) else db} '
              f'({n} nodes, {e} edges)')
    elif cmd == 'dump':
        db = sys.argv[2] if len(sys.argv) > 2 else DEFAULT_DB
        print(json.dumps(dump(db), ensure_ascii=False, indent=2))
    elif cmd == 'check':
        check()
    elif cmd == 'query':
        query(sys.argv[2], DEFAULT_DB)
    elif cmd == 'exec':
        exec_sql(sys.argv[2], DEFAULT_DB)
    else:
        print(__doc__)
        sys.exit(2)


if __name__ == '__main__':
    main()
