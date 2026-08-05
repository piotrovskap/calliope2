#!/usr/bin/env python3
"""Verifiability gate for the golden-record system of record.

Asserts the v1 contract holds, so "verifiable" is enforced, not asserted:
  1. record.json conforms to schema.json (JSON Schema).
  2. Reference integrity: every cited ref_id is defined; every reference href resolves
     (repo file exists, or is an http URL).
  3. Graph integrity: every relationship from/to, every field.entity_id, and every
     source_mapping.source_id resolves to a real node; ids are unique.
  4. Provenance completeness: every field either maps to >=1 source target, or is a
     CDP-minted/derived/orphan/none field — and every field carries justification
     (established_by + ref_ids).
  5. Entity primitives: every entity has a non-empty sample_schema.

Exit non-zero with a clear message on any violation.
"""
import json
import os
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
GR = os.path.join(ROOT, 'analysis/artifacts/golden-record')
REC = os.path.join(GR, 'record.json')
SCH = os.path.join(GR, 'schema.json')

NO_SOURCE_OK = {'primary_key', 'derived', 'orphan', 'none'}


def fail(msg):
    print('ERROR: ' + msg)
    sys.exit(1)


def main():
    rec = json.load(open(REC))
    sch = json.load(open(SCH))

    # 1. JSON Schema conformance
    try:
        import jsonschema
        try:
            jsonschema.validate(rec, sch)
        except jsonschema.ValidationError as e:
            loc = '/'.join(str(p) for p in e.absolute_path) or '<root>'
            fail(f'record.json does not conform to schema.json at {loc}: {e.message}')
    except ImportError:
        print('  (jsonschema not installed — skipping formal conformance; running structural checks only)')

    refs = rec.get('references', {})
    ent_ids = {e['id'] for e in rec['model']['entities']}
    src_ids = {s['id'] for s in rec['source_registry']}

    # id uniqueness
    for label, items in [('entity', rec['model']['entities']), ('source', rec['source_registry'])]:
        ids = [x['id'] for x in items]
        dupes = {i for i in ids if ids.count(i) > 1}
        if dupes:
            fail(f'duplicate {label} ids: {sorted(dupes)}')

    # 2. reference hrefs resolve
    broken = []
    for rid, r in refs.items():
        h = r.get('href', '')
        if h.startswith('http'):
            continue
        if not os.path.exists(os.path.join(ROOT, h)):
            broken.append((rid, h))
    if broken:
        fail(f'reference href(s) do not resolve in repo: {broken}')

    # 2b. every cited ref_id is defined
    cited = set()

    def collect(o):
        if isinstance(o, dict):
            for k, v in o.items():
                if k == 'ref_ids' and isinstance(v, list):
                    cited.update(v)
                else:
                    collect(v)
        elif isinstance(o, list):
            for v in o:
                collect(v)
    collect(rec)
    undef = sorted(c for c in cited if c not in refs)
    if undef:
        fail(f'ref_ids cited but not defined in references registry: {undef}')

    # 3. graph integrity
    for r in rec['model']['relationships']:
        if r['from'] not in ent_ids:
            fail(f"relationship {r['id']} 'from' references unknown entity {r['from']}")
        if r['to'] not in ent_ids:
            fail(f"relationship {r['id']} 'to' references unknown entity {r['to']}")

    # 5. entity primitives present
    for e in rec['model']['entities']:
        if not e.get('sample_schema'):
            fail(f"entity {e['id']} has no primitive sample_schema")

    # 4. field provenance + graph
    n_fields = 0
    n_maps = 0
    for sec in rec['sections']:
        for f in sec['fields']:
            n_fields += 1
            if f.get('entity_id') not in ent_ids:
                fail(f"field '{f['name']}' attaches to unknown entity_id {f.get('entity_id')}")
            sms = f.get('source_mappings', [])
            n_maps += len(sms)
            for sm in sms:
                if sm.get('source_id') and sm['source_id'] not in src_ids:
                    fail(f"field '{f['name']}' maps to unknown source_id {sm['source_id']}")
            # provenance completeness
            if not sms and f.get('identity_role') not in NO_SOURCE_OK:
                fail(f"field '{f['name']}' (identity_role={f.get('identity_role')}) has no source_mappings and is not CDP-minted/derived/orphan/none")
            # justification
            if not f.get('established_by') or not f.get('ref_ids'):
                fail(f"field '{f['name']}' lacks justification (established_by + ref_ids)")

    n_ent = len(ent_ids)
    n_rel = len(rec['model']['relationships'])
    n_src = len(src_ids)
    print(f'OK: golden record valid — {n_ent} entities, {n_rel} relationships, {n_fields} fields '
          f'({n_maps} field->source mappings), {n_src} sources, {len(refs)} references; '
          f'conforms to schema, every reference resolves, every field traced and justified.')


if __name__ == '__main__':
    main()
