#!/usr/bin/env python3
"""Parse the CDP field-source matrix -> docs/cdp-field-catalog.json.

Reads docs/cdp-field-source-matrix.md (the 27-field CDP catalog) into structured
records and attempts to resolve each field's declared source (DB.table.column)
against the parsed physical schema (docs/databases/schema.json, from parse-ddl.py).
A resolved field gets `resolved_to` (a real column path) — the basis for a
`sourced-by` edge in the brain. Unresolved fields are REPORTED, never invented:
most matrix sources reference EDW_staging / abbreviated paths not present in the
dumped source systems, which is itself a finding.

Run from the repo root:  python3 scripts/gen-field-catalog.py
"""
import json
import re
from datetime import date
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
MATRIX = ROOT / 'docs' / 'cdp-field-source-matrix.md'
SCHEMA = ROOT / 'docs' / 'databases' / 'schema.json'
OUT = ROOT / 'docs' / 'cdp-field-catalog.json'

ROW_RE = re.compile(r'^\|\s*(\d+)\s*\|')


def clean(cell):
    return cell.strip().strip('`').strip()


def build_column_index(schema):
    """Lookups: exact (db,table,col), (table,col), and by-column-name -> [paths]."""
    by_db_table_col = {}
    by_table_col = {}
    by_col = {}
    for db in schema['databases']:
        tokens = {db['id'].replace('-', '').lower(), db['name'].lower()}
        for t in db['tables']:
            tl = t['name'].lower()
            for c in t['columns']:
                cl = c['name'].lower()
                path = f"{db['id']}.{t['full_name']}.{c['name']}"
                by_table_col.setdefault((tl, cl), path)
                by_col.setdefault(cl, []).append(path)
                for tok in tokens:
                    by_db_table_col[(tok, tl, cl)] = path
    return by_db_table_col, by_table_col, by_col


# A clean SQL column identifier (filters garbage tokens like "A", "COX?", "X+Y").
CLEAN_COL = re.compile(r'^[A-Za-z][A-Za-z0-9_]{3,}$')


def candidate_columns(raw, by_col):
    """Name-match the declared source column against any dumped column.

    Heuristic: a column with the same NAME exists at these paths. This is a
    candidate, NOT confirmed lineage (the matrix's declared DB, EDW_staging, is
    not dumped). Only applied to a clean column identifier on a dotted path.
    Returns up to 6 paths.
    """
    if not raw or raw in {'—', '-'}:
        return []
    core = re.split(r'\s*\(', raw, maxsplit=1)[0].strip().strip('`')
    if '.' not in core:
        return []
    token = re.split(r'[./]', core)[-1].strip()
    if not CLEAN_COL.match(token):
        return []
    return by_col.get(token.lower(), [])[:6]


def resolve_source(raw, idx):
    """Best-effort parse of a 'DB.table.column' source against the schema index.

    Returns (parsed_dict, resolved_to_path|None, reason). Abbreviated/wildcard
    sources (…, *, /, empty) are deliberately left unresolved. `idx` is the
    (by_db_table_col, by_table_col) tuple from build_column_index.
    """
    by_dbtc, by_tc, _by_col = idx
    if not raw or raw in {'—', '-'}:
        return None, None, 'no source declared'
    # strip trailing parenthetical notes like "(// DealBookDate)"
    core = re.split(r'\s*\(', raw, maxsplit=1)[0].strip().strip('`')
    if any(ch in core for ch in ('…', '*', '/')):
        return {'raw': core}, None, 'abbreviated/wildcard source'
    parts = core.split('.')
    if len(parts) < 2:
        return {'raw': core}, None, 'not a DB.table.column path'
    db, col = parts[0], parts[-1]
    table = parts[-2]
    parsed = {'db': db, 'table': table, 'column': col}
    hit = by_dbtc.get((db.replace('-', '').lower(), table.lower(), col.lower())) \
        or by_tc.get((table.lower(), col.lower()))
    if hit:
        return parsed, hit, 'resolved'
    return parsed, None, f'no column {table}.{col} in dumped schema (source DB {db!r} not dumped)'


def main():
    schema = json.loads(SCHEMA.read_text(encoding='utf-8'))
    idx = build_column_index(schema)

    fields = []
    for line in MATRIX.read_text(encoding='utf-8').splitlines():
        if not ROW_RE.match(line):
            continue
        cells = line.split('|')
        # drop the empty cells from the surrounding pipes
        cells = cells[1:-1] if len(cells) >= 2 and cells[0].strip() == '' else cells
        cells = [clean(c) for c in cells]
        # Column layout varies by section: the wide tables are 8 columns
        # (# | field | target | source | prov | etl | Status | Phase) while the
        # narrower Service-History (7-col, no Prov.) and Protect (6-col, no Prov.
        # or ETL) tables drop middle columns. Across every shape the two trailing
        # columns are fixed: Status is always the second-to-last cell and Phase
        # the last. Read both positionally so GAP/narrow rows map correctly
        # (cells[6] would grab Phase, not Status, on the 6/7-col rows).
        if len(cells) < 4:
            continue
        n, cdp_field, cdp_target = cells[0], cells[1], cells[2]
        # Wide rows (>=8 cells) have Status at the fixed index 6; narrower rows
        # keep Status as the second-to-last column and Phase as the last.
        status = cells[6] if len(cells) >= 8 else (cells[-2] if len(cells) >= 5 else cells[-1])
        phase = cells[-1] if len(cells) >= 5 else ''
        source = cells[3] if len(cells) >= 5 else ''
        prov = cells[4] if len(cells) >= 6 else ''
        etl = cells[5] if len(cells) >= 7 else ''
        parsed, resolved_to, reason = resolve_source(source, idx)
        cands = [] if resolved_to else candidate_columns(source, idx[2])
        fields.append({
            'n': int(n),
            'cdp_field': cdp_field,
            'cdp_target': cdp_target,
            'source_raw': source,
            'source': parsed,
            'providers': prov,
            'etl_path': etl,
            'status': status,
            'phase': phase,
            'resolved': resolved_to is not None,
            'resolved_to': resolved_to,
            'resolution_note': reason,
            # name-match candidates in the dumped schema (not confirmed lineage)
            'candidate_columns': cands,
            'candidate_dbs': sorted({c.split('.', 1)[0] for c in cands}),
        })

    # no-loss guard: every numbered row in the matrix must become a field record
    expected = sum(1 for line in MATRIX.read_text(encoding='utf-8').splitlines()
                   if ROW_RE.match(line))
    if len(fields) != expected:
        raise SystemExit(f'ERROR: parsed {len(fields)} fields but the matrix has '
                         f'{expected} numbered rows — a field was dropped.')

    resolved = sum(1 for f in fields if f['resolved'])
    prev = json.loads(OUT.read_text()) if OUT.exists() else {}
    generated = date.today().isoformat()
    if prev.get('fields') == fields:
        generated = prev.get('meta', {}).get('generated_at', generated)

    out = {
        'meta': {
            'version': 1,
            'generated_at': generated,
            'generator': 'scripts/gen-field-catalog.py',
            'source': 'docs/cdp-field-source-matrix.md',
            'resolves_against': 'docs/databases/schema.json',
            'counts': {'fields': len(fields), 'resolved': resolved,
                       'unresolved': len(fields) - resolved,
                       'with_candidates': sum(1 for f in fields if f['candidate_columns'])},
        },
        'fields': fields,
    }
    OUT.write_text(json.dumps(out, indent=2, ensure_ascii=False) + '\n', encoding='utf-8')
    print(f'Wrote {OUT.relative_to(ROOT)}: {len(fields)} fields, '
          f'{resolved} resolved to a dumped column, {len(fields) - resolved} unresolved')
    if resolved < len(fields):
        print('  unresolved (source not in dumped schema) — reported, not invented:')
        for f in fields:
            if not f['resolved']:
                print(f"    #{f['n']:>2} {f['cdp_field']:<22} {f['resolution_note']}")


if __name__ == '__main__':
    main()
