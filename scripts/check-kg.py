#!/usr/bin/env python3
"""Validate the generated KG (app/knowledge_graph.json). CI gate for Phase 2.

Three assertions enforce the no-new-data / don't-break-the-curated-set invariant:

  1. SUPERSET    — every node and edge in the frozen baselines (federated + curated)
                   survives into the output (modulo nodes the overlay explicitly removes).
                   Guarantees the curation is not lost.
  2. NO HALLUCINATION — every output node and edge traces to an input graph or the
                   overlay. Nothing is invented.
  3. FINDINGS    — the migrated patch-script findings are present (MediaLogix inventory,
                   CCID non-functional, the Server-IP / Azure-migration hypothesis).

Exit non-zero on any violation. Run from repo root: python3 scripts/check-kg.py
"""
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / 'app' / 'knowledge_graph.json'
CATALOG = ROOT / 'analysis' / 'sessions' / 'catalog.json'
OVERLAY = ROOT / 'analysis' / 'kg-curation.json'
BASELINES = [ROOT / 'analysis' / 'kg' / 'baseline' / 'federated.json',
             ROOT / 'analysis' / 'kg' / 'baseline' / 'curated.json']


def load(p):
    return json.loads(Path(p).read_text(encoding='utf-8'))


def nodes_of(g):
    return g.get('nodes') or g.get('entities') or []


def edges_of(g):
    return g.get('edges') or g.get('relationships') or []


def main():
    out = load(OUT)
    overlay = load(OVERLAY)
    catalog = load(CATALOG)

    merge = overlay['merge']
    remove = set(overlay['remove'])
    remove_lower = {r.lower() for r in remove}
    type_fixes = overlay['type_fixes']

    alias = {}
    for canon, aliases in merge.items():
        alias[canon.lower()] = canon
        for a in aliases:
            alias[a.lower()] = canon

    def resolve(name):
        return alias.get((name or '').lower(), name or '')

    def dropped(canon, raw_name):
        """True if the overlay legitimately removes this node."""
        if raw_name in remove or raw_name.lower() in remove_lower:
            return True
        if canon in remove:
            return True
        return type_fixes.get(canon, '') is None

    out_node_ids = {n['id'] for n in out['nodes']}
    out_edges = {(e['source'], e['target'], e['type']) for e in out['edges']}
    errors = []

    # 1. SUPERSET of both frozen baselines
    for base_path in BASELINES:
        g = load(base_path)
        bn = base_path.name
        for n in nodes_of(g):
            raw = n.get('name') or n.get('id') or ''
            canon = resolve(raw)
            if dropped(canon, raw):
                continue
            if canon not in out_node_ids:
                errors.append(f'SUPERSET: baseline node missing from output: {canon!r} (from {bn})')
        for e in edges_of(g):
            s, t = resolve(e.get('source', '')), resolve(e.get('target', ''))
            rel = e.get('type', e.get('relationship_type', '')) or ''
            if s == t or s not in out_node_ids or t not in out_node_ids:
                continue  # endpoint legitimately dropped or self-loop
            if (s, t, rel) not in out_edges:
                errors.append(f'SUPERSET: baseline edge missing from output: {(s, t, rel)} (from {bn})')

    # 2. NO HALLUCINATION — output traces to inputs or overlay
    input_node_canons, input_edge_keys = set(), set()
    input_paths = [ROOT / s['graph'] for s in catalog['sessions']]
    input_paths += [ROOT / fi['path'] for fi in catalog.get('federation_inputs', [])]
    input_paths += BASELINES
    for p in input_paths:
        g = load(p)
        for n in nodes_of(g):
            input_node_canons.add(resolve(n.get('name') or n.get('id') or ''))
        for e in edges_of(g):
            input_edge_keys.add((resolve(e.get('source', '')), resolve(e.get('target', '')),
                                 e.get('type', e.get('relationship_type', '')) or ''))
    add = overlay['additions']
    for n in add.get('nodes', []):
        input_node_canons.add(resolve(n.get('name', '')))
    for e in add.get('edges', []):
        input_edge_keys.add((resolve(e['source']), resolve(e['target']), e['type']))

    for n in out['nodes']:
        if n['id'] not in input_node_canons:
            errors.append(f'HALLUCINATION: output node not traceable to any source: {n["id"]!r}')
    for e in out['edges']:
        if (e['source'], e['target'], e['type']) not in input_edge_keys:
            errors.append(f'HALLUCINATION: output edge not traceable to any source: {(e["source"], e["target"], e["type"])}')

    # 3. FINDINGS present (the migrated patch-script knowledge)
    def node(id_):
        return next((n for n in out['nodes'] if n['id'] == id_), None)

    if not node('MediaLogix'):
        errors.append('FINDINGS: MediaLogix node missing')
    if not node('Server IP discrepancy 2026-06-14'):
        errors.append('FINDINGS: Server IP discrepancy node missing')
    if not node('usw2-db-ml-vm-p'):
        errors.append('FINDINGS: Azure VM node (usw2-db-ml-vm-p) missing')
    ccid = node('Common Client ID')
    if not ccid or not any('non-functional' in d for d in ccid.get('descriptions', [])):
        errors.append('FINDINGS: CCID non-functional finding missing')

    if errors:
        print(f'KG validation FAILED ({len(errors)} issue(s)):')
        for e in errors[:40]:
            print(f'  - {e}')
        if len(errors) > 40:
            print(f'  ... and {len(errors) - 40} more')
        sys.exit(1)

    n_nodes, n_edges = len(out['nodes']), len(out['edges'])
    print(f'OK: KG valid — {n_nodes} nodes, {n_edges} edges; superset of both baselines, '
          f'no untraceable nodes/edges, findings present')


if __name__ == '__main__':
    main()
