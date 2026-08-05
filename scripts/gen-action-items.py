#!/usr/bin/env python3
"""Aggregate per-session action_items.json into analysis/action-items.json."""
import json, re
from pathlib import Path

ROOT = Path(__file__).parent.parent
SESSIONS_DIR = ROOT / 'analysis' / 'sessions'
OUT = ROOT / 'analysis' / 'action-items.json'

# Load session metadata from each session.json
session_meta = {}
for sd in SESSIONS_DIR.iterdir():
    sj = sd / 'session.json'
    if sj.exists():
        s = json.loads(sj.read_text())
        session_meta[sd.name] = {'title': s.get('title', sd.name), 'date': s.get('date', '')}

all_items = []
seen_sessions = []

for session_dir in sorted(SESSIONS_DIR.iterdir()):
    if not session_dir.is_dir():
        continue
    ai_file = session_dir / 'results' / 'action_items.json'
    if not ai_file.exists():
        continue
    session_id = session_dir.name
    meta = session_meta.get(session_id, {'title': session_id, 'date': ''})
    items = json.loads(ai_file.read_text())
    if not isinstance(items, list):
        continue
    seen_sessions.append(session_id)
    for item in items:
        all_items.append({
            'action':   item.get('action', ''),
            'assignee': item.get('assignee', ''),
            'priority': item.get('priority', 'Medium'),
            'deadline': item.get('deadline') or '',
            'context':  item.get('context', ''),
            'session':  session_id,
            'session_title': meta['title'],
            'session_date':  meta['date'],
        })

# Sort: High → Medium → Low, then by session date desc
PRIO = {'High': 0, 'Medium': 1, 'Low': 2}
all_items.sort(key=lambda x: (PRIO.get(x['priority'], 1), x['session_date']), reverse=False)
all_items.sort(key=lambda x: x['session_date'], reverse=True)
all_items.sort(key=lambda x: PRIO.get(x['priority'], 1))

# Preserve curation (status/resolution) from the existing rollup — matched by
# (session, action). New items default to status "open".
prev = json.loads(OUT.read_text()) if OUT.exists() else {}
curated = {(i.get('session'), i.get('action')): i for i in prev.get('items', [])}
for it in all_items:
    p = curated.get((it['session'], it['action']))
    it['status'] = (p or {}).get('status', 'open')
    if p and p.get('resolution'):
        it['resolution'] = p['resolution']

session_latest = str(sorted([m['date'] for m in session_meta.values() if m['date']])[-1]) if session_meta else ''
out = {
    'version': prev.get('version', 1),
    'updated': max(session_latest, prev.get('updated', '')),
    'changelog': prev.get('changelog', [{'date': '2026-06-09', 'note': f'Initial aggregation from {len(seen_sessions)} sessions'}]),
    'sessions': seen_sessions,
    'items': all_items,
}
OUT.write_text(json.dumps(out, indent=2) + '\n')
print(f'Wrote {len(all_items)} action items from {len(seen_sessions)} sessions to {OUT}')
