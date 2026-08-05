#!/usr/bin/env python3
"""Generate app/knowledge_graph.json — the single, versioned, reproducible KG.

Federates the per-session graphs and frozen baselines listed in
analysis/sessions/catalog.json, applying the declarative curation overlay
analysis/kg-curation.json (merge / remove / type_fixes / additions). Replaces
the retired analysis/curate_kg.py plus the one-off kg_apply_*.py / kg_resolve_*.py
patch scripts: their logic and findings now live in the overlay.

Invariant (enforced by scripts/check-kg.py): no new data — every output node and
edge traces to an input graph or the overlay, and the output is a superset of the
frozen baselines. This generator only relocates and relates existing data.

Run from the repo root:  python3 scripts/gen-kg.py
"""
import json
from datetime import date
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
CATALOG = ROOT / 'analysis' / 'sessions' / 'catalog.json'
OVERLAY = ROOT / 'analysis' / 'kg-curation.json'
OUT = ROOT / 'app' / 'knowledge_graph.json'


def load(path):
    return json.loads(Path(path).read_text(encoding='utf-8'))


def nodes_of(graph):
    return graph.get('nodes') or graph.get('entities') or []


def edges_of(graph):
    return graph.get('edges') or graph.get('relationships') or []


def descriptions_of(raw):
    ds = raw.get('descriptions')
    if ds:
        return [d for d in ds if d]
    d = raw.get('description')
    return [d] if d else []


def main():
    catalog = load(CATALOG)
    overlay = load(OVERLAY)

    merge = overlay['merge']
    remove = set(overlay['remove'])
    remove_lower = {r.lower() for r in remove}
    type_fixes = overlay['type_fixes']
    additions = overlay['additions']

    # alias -> canonical (curate_kg.resolve, now overlay-driven)
    alias_to_canonical = {}
    for canonical, aliases in merge.items():
        alias_to_canonical[canonical.lower()] = canonical
        for alias in aliases:
            alias_to_canonical[alias.lower()] = canonical

    def resolve(name):
        return alias_to_canonical.get((name or '').lower(), name or '')

    nodes_by_canon = {}
    edges_by_key = {}

    def add_node(raw, session_key):
        name = raw.get('name') or raw.get('id') or ''
        if name in remove or name.lower() in remove_lower:
            return
        canon = resolve(name)
        if canon in remove:
            return
        ntype = raw.get('type', 'concept')
        if canon in type_fixes:
            fixed = type_fixes[canon]
            if fixed is None:
                return
            ntype = fixed
        node = nodes_by_canon.get(canon)
        if node is None:
            node = {'id': canon, 'name': canon, 'type': ntype,
                    'descriptions': [], 'sessions': set()}
            nodes_by_canon[canon] = node
        elif ntype:
            node['type'] = ntype
        for d in descriptions_of(raw):
            if d not in node['descriptions']:
                node['descriptions'].append(d)
        for s in raw.get('sessions', []) or []:
            node['sessions'].add(s)
        if session_key:
            node['sessions'].add(session_key)

    def add_edge(raw, session_key):
        src = resolve(raw.get('source', ''))
        tgt = resolve(raw.get('target', ''))
        rel = raw.get('type', raw.get('relationship_type', '')) or ''
        if not src or not tgt or src == tgt:
            return
        key = (src, tgt, rel)
        edge = edges_by_key.get(key)
        if edge is None:
            edge = {'source': src, 'target': tgt, 'type': rel, 'sessions': set()}
            edges_by_key[key] = edge
        for s in (raw.get('sessions') or []):
            edge['sessions'].add(s)
        if raw.get('session'):
            edge['sessions'].add(raw['session'])
        if session_key:
            edge['sessions'].add(session_key)

    # 1. session graphs (deep session's graph is the curated baseline)
    inputs = [(s['key'], ROOT / s['graph']) for s in catalog['sessions']]
    # 2. frozen federation baselines (prior app/knowledge_graph.json + patches)
    inputs += [(fi['source'], ROOT / fi['path']) for fi in catalog.get('federation_inputs', [])]

    for key, path in inputs:
        g = load(path)
        for n in nodes_of(g):
            add_node(n, key if not key.startswith('baseline') else None)
        for e in edges_of(g):
            add_edge(e, key if not key.startswith('baseline') else None)

    # 3. declarative overlay additions (relocated from the retired patch scripts)
    for n in additions.get('nodes', []):
        add_node(n, None)
    for ap in additions.get('append_descriptions', []):
        node = nodes_by_canon.get(resolve(ap['name']))
        if node and ap['description'] not in node['descriptions']:
            node['descriptions'].append(ap['description'])
    for e in additions.get('edges', []):
        add_edge(e, None)

    # drop edges whose endpoints did not survive as nodes
    node_ids = set(nodes_by_canon)
    final_nodes = sorted(nodes_by_canon.values(), key=lambda n: n['id'])
    for n in final_nodes:
        n['sessions'] = sorted(n['sessions'])
        if not n['descriptions']:
            del n['descriptions']
    final_edges = []
    for (src, tgt, rel), e in sorted(edges_by_key.items()):
        if src in node_ids and tgt in node_ids:
            e['sessions'] = sorted(e['sessions'])
            final_edges.append(e)

    prev = load(OUT) if OUT.exists() else {}
    prev_core = (prev.get('nodes'), prev.get('edges'))
    generated = date.today().isoformat()
    if prev_core == (final_nodes, final_edges):
        generated = prev.get('meta', {}).get('generated_at', generated)

    out = {
        'meta': {
            'version': 2,
            'generated_at': generated,
            'generator': 'scripts/gen-kg.py',
            'sources': [str(p.relative_to(ROOT)) for _, p in inputs] + ['analysis/kg-curation.json'],
            'sessions': [s['key'] for s in catalog['sessions']],
            'counts': {'nodes': len(final_nodes), 'edges': len(final_edges)},
        },
        'nodes': final_nodes,
        'edges': final_edges,
        # Aliases: the portal viewer reads nodes/edges; Planopticon (the /kg skill)
        # reads entities/relationships. Emit both off the same lists so a graph query
        # via planopticon reports the real relationship_count, not 0.
        'entities': final_nodes,
        'relationships': final_edges,
    }
    OUT.write_text(json.dumps(out, indent=2, ensure_ascii=False) + '\n', encoding='utf-8')
    print(f'Wrote {OUT.relative_to(ROOT)} ({len(final_nodes)} nodes, {len(final_edges)} edges)')


if __name__ == '__main__':
    main()
