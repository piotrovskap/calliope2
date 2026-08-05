#!/usr/bin/env python3
"""Generate specs/estimates.json — the activity timetable, from the backlog + bands + owners.

Single source: each activity (user story) and its T-shirt size come from
specs/manifest.json; the size -> low/high band from specs/estimate-bands.json; the
owner split (who does what %) from specs/roles.json. Per-activity low/high, each
owner's share, and all rollups (phase, workstream, person, role) are DERIVED here —
never hand-entered. Un-sized activities are surfaced, not guessed.

Run from the repo root:  python3 scripts/gen-estimates.py
"""
import json
from datetime import date
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
MANIFEST = ROOT / 'specs' / 'manifest.json'
BANDS = ROOT / 'specs' / 'estimate-bands.json'
ROLES = ROOT / 'specs' / 'roles.json'
OUT = ROOT / 'specs' / 'estimates.json'


def main():
    manifest = json.loads(MANIFEST.read_text(encoding='utf-8'))
    bandcfg = json.loads(BANDS.read_text(encoding='utf-8'))
    bands = bandcfg['bands']
    rolecfg = json.loads(ROLES.read_text(encoding='utf-8'))
    roles = rolecfg['roles']
    person_role = rolecfg.get('person_role', {})
    act_as, ws_as = rolecfg.get('activity_assignment', {}), rolecfg.get('workstream_assignment', {})
    ph_as, default_as = rolecfg.get('phase_assignment', {}), rolecfg.get('default_assignment', [])
    exclude_phases = set(rolecfg.get('exclude_phases', []))
    items = {i['id']: i for i in manifest['items']}

    def role_of(who):
        return person_role.get(who, who if who in roles else 'Unknown')

    def round2(x):
        return round(x, 2)

    activities = []
    for it in manifest['items']:
        if it.get('type') != 'story':
            continue
        feature = items.get(it.get('parent_id'), {})
        is_feat = feature.get('type') == 'feature'
        epic = items.get(feature.get('parent_id'), {}) if is_feat else feature
        if epic.get('id') in exclude_phases:
            continue
        ws_id = feature.get('id', '') if is_feat else ''
        size = it.get('estimate')
        band = bands.get(size) if size else None
        low = band['low'] if band else None
        high = band['high'] if band else None
        pts = band.get('points') if band else None
        assignment = act_as.get(it['id']) or ws_as.get(ws_id) or ph_as.get(epic.get('id', '')) or default_as
        owners = []
        for o in assignment:
            pct = o['pct']
            owners.append({
                'who': o['who'],
                'role': role_of(o['who']),
                'pct': pct,
                'points': round2(pts * pct / 100) if pts is not None else None,
                'low': round2(low * pct / 100) if low is not None else None,
                'high': round2(high * pct / 100) if high is not None else None,
            })
        activities.append({
            'id': it['id'],
            'activity': it['title'],
            'phase': epic.get('title', ''),
            'phase_id': epic.get('id', ''),
            'workstream': feature.get('title', '') if is_feat else '',
            'workstream_id': ws_id,
            'size': size or None,
            'points': pts,
            'low': low,
            'high': high,
            'owners': owners,
        })

    def rollup_total(key):
        agg, order = {}, []
        for a in activities:
            k = a[key]
            if k not in agg:
                agg[k] = {'label': k, 'points': 0, 'low': 0, 'high': 0, 'activities': 0, 'unsized': 0}
                order.append(k)
            r = agg[k]
            r['activities'] += 1
            if a['low'] is None:
                r['unsized'] += 1
            else:
                r['points'] += a['points'] or 0; r['low'] += a['low']; r['high'] += a['high']
        return [{**agg[k], 'low': round2(agg[k]['low']), 'high': round2(agg[k]['high'])} for k in order]

    def rollup_share(key):
        agg, order = {}, []
        for a in activities:
            for o in a['owners']:
                k = o[key]
                if k not in agg:
                    agg[k] = {'label': k, 'points': 0, 'low': 0, 'high': 0, 'activities': 0, 'unsized': 0}
                    order.append(k)
                r = agg[k]
                r['activities'] += 1
                if o['low'] is None:
                    r['unsized'] += 1
                else:
                    r['points'] += o.get('points') or 0; r['low'] += o['low']; r['high'] += o['high']
        return sorted(([{**agg[k], 'points': round2(agg[k]['points']), 'low': round2(agg[k]['low']), 'high': round2(agg[k]['high'])} for k in order]),
                      key=lambda r: -r['high'])

    sized = [a for a in activities if a['low'] is not None]
    no_person = sum(1 for a in activities for o in a['owners'] if o['role'] in roles and not roles[o['role']] and o['who'] in roles)

    # Overhead: cross-cutting allocations expressed as a % of a base set of
    # activities (a workstream id or activity id). Additive ON TOP OF the
    # per-activity 100% owner splits — never part of them.
    overhead = []
    for ov in rolecfg.get('overhead', []):
        base = set(ov['base'])
        in_base = [a for a in sized if a['workstream_id'] in base or a['id'] in base]
        blo = round2(sum(a['low'] for a in in_base))
        bhi = round2(sum(a['high'] for a in in_base))
        overhead.append({
            'label': ov['label'], 'who': ov['who'], 'role': role_of(ov['who']),
            'pct': ov['pct'], 'base': ov['base'], 'note': ov.get('note', ''),
            'base_low': blo, 'base_high': bhi,
            'low': round2(blo * ov['pct'] / 100), 'high': round2(bhi * ov['pct'] / 100),
        })

    rbp, rbr = rollup_share('who'), rollup_share('role')
    # fold overhead shares into the person + role rollups so they surface there too
    for rollup, field in ((rbp, 'who'), (rbr, 'role')):
        idx = {r['label']: r for r in rollup}
        for ov in overhead:
            r = idx.get(ov[field])
            if r is None:
                r = {'label': ov[field], 'points': 0, 'low': 0, 'high': 0, 'activities': 0, 'unsized': 0, 'overhead_shares': 0}
                rollup.append(r); idx[ov[field]] = r
            r['low'] = round2(r['low'] + ov['low'])
            r['high'] = round2(r['high'] + ov['high'])
            r['overhead_shares'] = r.get('overhead_shares', 0) + 1
        rollup.sort(key=lambda r: -r['high'])

    totals = {
        'activities': len(activities),
        'sized': len(sized),
        'unsized': len(activities) - len(sized),
        'owner_shares_without_person': no_person,
        'points': round2(sum(a['points'] or 0 for a in sized)),
        'low': round2(sum(a['low'] for a in sized)),
        'high': round2(sum(a['high'] for a in sized)),
        'overhead_low': round2(sum(o['low'] for o in overhead)),
        'overhead_high': round2(sum(o['high'] for o in overhead)),
    }

    # ── Anonymize the OUTPUT. roles.json stays the internal source of truth (names +
    # splits); the published estimates.json carries ROLE labels only, so no individual
    # name reaches the portal. The math is unchanged — shares already roll up by role;
    # per-activity owners are merged by role (pct/low/high summed), names dropped.
    def anon_owners(owners):
        merged, order = {}, []
        for o in owners:
            r = o['role']
            if r not in merged:
                merged[r] = {'role': r, 'pct': 0, 'points': None, 'low': None, 'high': None}
                order.append(r)
            m = merged[r]
            m['pct'] += o['pct']
            for fld in ('points', 'low', 'high'):
                if o[fld] is not None:
                    m[fld] = round2((m[fld] or 0) + o[fld])
        return [merged[r] for r in order]

    activities_out = [{**a, 'owners': anon_owners(a['owners'])} for a in activities]
    overhead_out = [{k: v for k, v in ov.items() if k != 'who'} for ov in overhead]

    prev = json.loads(OUT.read_text()) if OUT.exists() else {}
    core = {'activities': activities_out,
            'rollup_by_phase': rollup_total('phase'), 'rollup_by_workstream': rollup_total('workstream'),
            'rollup_by_role': rbr, 'overhead': overhead_out}
    generated = date.today().isoformat()
    if all(prev.get(k) == v for k, v in core.items()):
        generated = prev.get('meta', {}).get('generated_at', generated)

    out = {
        'meta': {
            'version': 3,
            'generated_at': generated,
            'generator': 'scripts/gen-estimates.py',
            'sources': ['specs/manifest.json', 'specs/estimate-bands.json', 'specs/roles.json'],
            'unit': bandcfg.get('unit', 'engineer-days'),
            'bands': bands,
            'role_labels': sorted(roles.keys()),
            'totals': {k: v for k, v in totals.items() if k != 'owner_shares_without_person'},
        },
        **core,
    }
    OUT.write_text(json.dumps(out, indent=2, ensure_ascii=False) + '\n', encoding='utf-8')
    print(f"Wrote {OUT.relative_to(ROOT)}: {totals['activities']} activities "
          f"({totals['sized']} sized, {totals['unsized']} un-sized), total {totals['low']}-{totals['high']} {out['meta']['unit']}")
    print('  by role:')
    for r in out['rollup_by_role']:
        print(f"    {r['label']:24} {r['low']:>6}-{r['high']:<6} ({r['activities']} shares)")


if __name__ == '__main__':
    main()
