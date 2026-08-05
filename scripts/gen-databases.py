#!/usr/bin/env python3
"""Generate docs/databases.json from the per-DB docs' YAML frontmatter.

Scans docs/databases/*.md (excluding README.md and _template.md), parses each
doc's frontmatter, and emits a portal-data JSON that drives the Database Schema
Docs viewer (status roll-up + per-DB detail). The frontmatter declares dump/erd
paths even when the file doesn't exist yet, so presence is verified on disk —
referenced only when the file is actually there.
"""
import json
import re
from pathlib import Path

ROOT = Path(__file__).parent.parent
DB_DIR = ROOT / 'docs' / 'databases'
OUT = ROOT / 'docs' / 'databases.json'
README = DB_DIR / 'README.md'

# The README '## Status' table is regenerated from the same rows, fenced by these
# markers, so it can't drift from databases.json (it used to be hand-edited).
README_BEGIN = '<!-- BEGIN generated: db-status-table (scripts/gen-databases.py) -->'
README_END = '<!-- END generated -->'

# data-flow.md is the cross-estate flow diagram, not a database — keep it out of the catalog.
EXCLUDE = {'README.md', '_template.md', 'data-flow.md'}

# in-progress first (active work), then partial, then pending (awaiting access),
# then blocked (parked), then complete (done) — most-actionable at the top.
STATUS_ORDER = {'in-progress': 0, 'partial': 1, 'pending': 2, 'blocked': 3, 'complete': 4}


def parse_frontmatter(text):
    """Return the YAML frontmatter as a flat dict (string values).

    Values may carry a trailing inline `# comment` (the template seeds them);
    strip it. Not a full YAML parser — the frontmatter here is flat key: value.
    """
    text = text.lstrip('﻿')
    m = re.match(r'^---\s*\n(.*?)\n---\s*\n?', text, re.DOTALL)
    if not m:
        return {}
    meta = {}
    for line in m.group(1).splitlines():
        if not line.strip() or ':' not in line:
            continue
        key, val = line.split(':', 1)
        # Drop an inline comment, but not a '#' inside a quoted value.
        val = re.sub(r'\s+#.*$', '', val)
        meta[key.strip()] = val.strip().strip('"\'')
    return meta


def _cell(val):
    """Escape a value for a Markdown table cell (a literal pipe would split it)."""
    return str(val).replace('|', '\\|')


def render_status_table(rows):
    """Build the README '## Status' table from the same sorted rows as the JSON.

    Columns mirror the existing hand-maintained table exactly:
    Database (linked to <id>.md) | Owner | Access | Researcher | Doc (= status).
    """
    lines = [
        '| Database | Owner | Access | Researcher | Doc |',
        '|---|---|---|---|---|',
    ]
    for r in rows:
        lines.append(
            f"| [{_cell(r['database'])}]({r['id']}.md) | {_cell(r['owner'])} | "
            f"{_cell(r['access'])} | {_cell(r['researcher'])} | {_cell(r['status'])} |"
        )
    return '\n'.join(lines)


def write_status_table(rows):
    """Rewrite the marked block in the README in place. Idempotent."""
    text = README.read_text(encoding='utf-8')
    block = f'{README_BEGIN}\n{render_status_table(rows)}\n{README_END}'
    pattern = re.compile(
        re.escape(README_BEGIN) + r'.*?' + re.escape(README_END), re.DOTALL
    )
    if not pattern.search(text):
        raise SystemExit(
            f'{README}: missing generated markers '
            f'({README_BEGIN!r} … {README_END!r})'
        )
    new_text = pattern.sub(lambda _m: block, text, count=1)
    if new_text != text:
        README.write_text(new_text, encoding='utf-8')
        print(f'Updated status table in {README} ({len(rows)} rows)')


def main():
    rows = []
    for md in sorted(DB_DIR.glob('*.md')):
        if md.name in EXCLUDE:
            continue
        meta = parse_frontmatter(md.read_text(encoding='utf-8', errors='replace'))
        if not meta:
            print(f'  skip {md.name}: no frontmatter')
            continue

        db_id = md.stem  # kebab-case filename is the canonical id

        # Verify the referenced artifacts exist before pointing at them.
        dump_rel = f'dumps/{db_id}.sql'
        erd_rel = f'erd/{db_id}.svg'
        dump = dump_rel if (DB_DIR / dump_rel).exists() else None
        erd = erd_rel if (DB_DIR / erd_rel).exists() else None

        rows.append({
            'id': db_id,
            # tolerate both frontmatter styles: database/source/title and name/server
            'database': meta.get('database') or meta.get('name') or db_id,
            'source': meta.get('source') or meta.get('server') or '',
            'title': meta.get('title') or meta.get('name') or '',
            # normalize 'partial — caveat...' / 'pending (note)' to the leading token for a clean badge
            'status': (re.split(r'\s+[—(\-]', meta.get('status', 'pending') or 'pending', maxsplit=1)[0].strip() or 'pending'),
            'access': meta.get('access', 'pending'),
            'researcher': meta.get('researcher', ''),
            'owner': meta.get('owner', ''),
            'updated': meta.get('updated', ''),
            'doc': md.name,
            'dump': dump,
            'erd': erd,
        })

    rows.sort(key=lambda r: (STATUS_ORDER.get(r['status'], 9),
                             r['database'].lower()))

    prev = json.loads(OUT.read_text()) if OUT.exists() else {}
    latest = max((r['updated'] for r in rows if r['updated']), default='')

    out = {
        'version': prev.get('version', 1),
        'updated': max(latest, prev.get('updated', '')),
        'changelog': prev.get('changelog', [
            {'date': latest, 'note': f'Initial generation from {len(rows)} per-DB docs'},
        ]),
        'databases': rows,
    }
    OUT.write_text(json.dumps(out, indent=2) + '\n')

    write_status_table(rows)

    erds = sum(1 for r in rows if r['erd'])
    dumps = sum(1 for r in rows if r['dump'])
    print(f'Wrote {len(rows)} databases to {OUT} ({erds} ERDs, {dumps} dumps)')


if __name__ == '__main__':
    main()
