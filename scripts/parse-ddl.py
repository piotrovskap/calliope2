#!/usr/bin/env python3
"""Parse the T-SQL DDL dumps into queryable structure -> docs/databases/schema.json.

Brings the schema-only dumps in docs/databases/dumps/*.sql (database -> table ->
column, with type, nullability, and PK) into the brain as structured data instead
of flat SQL text. Pure extraction: every table/column is read verbatim from a dump;
nothing is invented (Phase 3, no new data).

Run from the repo root:  python3 scripts/parse-ddl.py
"""
import json
import re
from datetime import date
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DUMPS = ROOT / 'docs' / 'databases' / 'dumps'
OUT = ROOT / 'docs' / 'databases' / 'schema.json'

# A column line: identifier, type (with optional (...) args), then the rest
# (nullability / defaults / inline -- comment). Constraint/keyword lines are skipped.
COL_RE = re.compile(r'^\s*\[?(?P<name>\w+)\]?\s+(?P<type>\w+(?:\s*\([^)]*\))?)\s+(?P<rest>.*)$')
SKIP_PREFIX = ('CONSTRAINT', 'PRIMARY', 'FOREIGN', 'INDEX', 'UNIQUE', 'CHECK',
               'CREATE', 'GO', 'USE', 'ALTER', 'SET', 'WITH', ')')
CREATE_RE = re.compile(r'CREATE\s+TABLE\s+(?:\[?(?P<schema>\w+)\]?\.)?\[?(?P<table>\w+)\]?\s*\(', re.I)
PK_CONSTRAINT_RE = re.compile(r'PRIMARY\s+KEY\s*(?:CLUSTERED|NONCLUSTERED)?\s*\(([^)]*)\)', re.I)


def server_of(text):
    m = re.search(r'^--\s*Server:\s*(.+)$', text, re.M)
    return m.group(1).strip() if m else ''


def db_name_of(text, stem):
    m = re.search(r'USE\s+\[?(\w+)\]?', text)
    return m.group(1) if m else stem


def parse_columns(body):
    """Parse the inside of a CREATE TABLE (...) block into column dicts."""
    columns = []
    pk_from_constraint = set()
    for raw in body.splitlines():
        line = raw.strip()
        if not line or line.startswith('--') or line.startswith('/*'):
            continue
        up = line.upper()
        pk_con = PK_CONSTRAINT_RE.search(line)
        if pk_con:
            for c in pk_con.group(1).split(','):
                pk_from_constraint.add(re.sub(r'[\[\]\s]', '', c).lower())
            continue
        if up.startswith(SKIP_PREFIX):
            continue
        m = COL_RE.match(line)
        if not m:
            continue
        rest = m.group('rest')
        comment = ''
        if '--' in rest:
            rest, comment = rest.split('--', 1)
            comment = comment.strip()
        nullable = 'NOT NULL' not in rest.upper()
        is_pk = bool(re.search(r'\bPK\b', comment))
        columns.append({
            'name': m.group('name'),
            'type': re.sub(r'\s+', '', m.group('type')).upper(),
            'nullable': nullable,
            'is_pk': is_pk,
        })
    # apply table-level PRIMARY KEY constraint to columns
    for c in columns:
        if c['name'].lower() in pk_from_constraint:
            c['is_pk'] = True
    return columns


def parse_dump(path):
    text = path.read_text(encoding='utf-8', errors='replace')
    tables = []
    for m in CREATE_RE.finditer(text):
        # find the matching ");" that closes this CREATE TABLE
        start = m.end()
        depth = 1
        i = start
        while i < len(text) and depth:
            ch = text[i]
            if ch == '(':
                depth += 1
            elif ch == ')':
                depth -= 1
            i += 1
        body = text[start:i - 1]
        schema = m.group('schema') or 'dbo'
        name = m.group('table')
        cols = parse_columns(body)
        tables.append({
            'schema': schema,
            'name': name,
            'full_name': f'{schema}.{name}',
            'columns': cols,
        })
    return text, tables


def main():
    databases = []
    n_tables = n_cols = 0
    for sql in sorted(DUMPS.glob('*.sql')):
        text, tables = parse_dump(sql)
        databases.append({
            'id': sql.stem,
            'name': db_name_of(text, sql.stem),
            'server': server_of(text),
            'dump': f'dumps/{sql.name}',
            'table_count': len(tables),
            'tables': tables,
        })
        n_tables += len(tables)
        n_cols += sum(len(t['columns']) for t in tables)

    databases.sort(key=lambda d: d['id'])
    prev = json.loads(OUT.read_text()) if OUT.exists() else {}
    generated = date.today().isoformat()
    if prev.get('databases') == databases:
        generated = prev.get('meta', {}).get('generated_at', generated)

    out = {
        'meta': {
            'version': 1,
            'generated_at': generated,
            'generator': 'scripts/parse-ddl.py',
            'source': 'docs/databases/dumps/*.sql',
            'counts': {'databases': len(databases), 'tables': n_tables, 'columns': n_cols},
        },
        'databases': databases,
    }
    OUT.write_text(json.dumps(out, indent=2, ensure_ascii=False) + '\n', encoding='utf-8')
    print(f'Wrote {OUT.relative_to(ROOT)}: {len(databases)} databases, '
          f'{n_tables} tables, {n_cols} columns')


if __name__ == '__main__':
    main()
