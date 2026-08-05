#!/usr/bin/env python3
"""Generate activity.json from git log for the portal homepage."""
import json, re, subprocess, sys
from pathlib import Path

ROOT = Path(__file__).parent.parent
N = int(sys.argv[1]) if len(sys.argv) > 1 else 30

raw = subprocess.check_output(
    ['git', 'log', f'-n{N}', '--pretty=format:%h|%as|%s'],
    cwd=ROOT, text=True
).strip().splitlines()

TYPE_MAP = {
    'feat': 'Feature', 'fix': 'Fix', 'chore': 'Chore',
    'docs': 'Docs', 'refactor': 'Refactor', 'test': 'Test',
    'perf': 'Perf', 'style': 'Style', 'ci': 'CI',
}

STATUS_LABEL = {'A': 'added', 'M': 'modified', 'D': 'deleted', 'R': 'renamed'}

def files_for(h):
    out = subprocess.check_output(
        ['git', 'diff-tree', '--no-commit-id', '-r', '--name-status', h],
        cwd=ROOT, text=True
    ).strip().splitlines()
    result = []
    for line in out:
        parts = line.split('\t', 1)
        if len(parts) == 2:
            result.append({'status': STATUS_LABEL.get(parts[0][0], parts[0][0].lower()), 'path': parts[1]})
    return result

def body_for(h):
    """Full commit message body (everything after the subject line), trimmed."""
    return subprocess.check_output(
        ['git', 'log', '-1', '--format=%b', h],
        cwd=ROOT, text=True
    ).strip()

entries = []
for line in raw:
    parts = line.split('|', 2)
    if len(parts) != 3:
        continue
    h, date, subject = parts
    m = re.match(r'^(\w+)(?:\([^)]+\))?!?:\s*(.+)$', subject)
    if m:
        ctype = TYPE_MAP.get(m.group(1), m.group(1).capitalize())
        title = m.group(2)
    else:
        ctype = 'Commit'
        title = subject
    entries.append({'hash': h, 'date': date, 'type': ctype, 'title': title, 'body': body_for(h), 'files': files_for(h)})

out = ROOT / 'activity.json'
out.write_text(json.dumps(entries, indent=2) + '\n')
print(f'Wrote {len(entries)} entries to {out}')
