#!/usr/bin/env python3
"""Re-pull Confluence pages with structure preserved (tables/lists/headings).
Reads page_id from each file's frontmatter, fetches export_view HTML via the
api.atlassian.com gateway (Basic auth, scoped token), converts to GFM with pandoc,
and overwrites the file keeping its frontmatter."""
import os, re, sys, json, base64, time, subprocess, urllib.request, urllib.error

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CONF_DIR = os.path.join(ROOT, 'artifacts/phase-0/confluence')
CID = '7503916e-a51e-4d15-acfe-afc3bc61e0b8'
TODAY = '2026-06-09'

def env(k):
    for line in open(os.path.join(ROOT, '.env')):
        if line.startswith(k + '='): return line.split('=', 1)[1].strip()
    return os.environ.get(k)

EMAIL = 'lmata@weareconflict.com'
TOKEN = env('JIRA_API_TOKEN')
AUTH = base64.b64encode(f'{EMAIL}:{TOKEN}'.encode()).decode()

def fm_split(md):
    m = re.match(r'^---\s*\n(.*?)\n---\s*\n?', md, re.S)
    if not m: return {}, '', md
    meta = {}
    for line in m.group(1).split('\n'):
        i = line.find(':')
        if i > 0: meta[line[:i].strip()] = line[i+1:].strip()
    return meta, m.group(1), md[m.end():]

def fetch(pid):
    url = f'https://api.atlassian.com/ex/confluence/{CID}/wiki/rest/api/content/{pid}?expand=body.export_view'
    req = urllib.request.Request(url, headers={'Authorization': 'Basic ' + AUTH, 'Accept': 'application/json'})
    with urllib.request.urlopen(req, timeout=30) as r:
        return json.load(r)['body']['export_view']['value']

def to_md(html):
    p = subprocess.run(['pandoc', '-f', 'html', '-t', 'gfm', '--wrap=none'],
                       input=html.encode(), capture_output=True)
    out = p.stdout.decode()
    # Drop Confluence inline styles preserved in raw-HTML blocks (light info/note/code
    # panel backgrounds, dark text, broken /wiki/s/... placeholder bg-images) — they
    # clash with the dark-theme reader and add noise to the machine-readable markdown.
    out = re.sub(r'\s+style="[^"]*"', '', out)
    return out

files = sorted(f for f in os.listdir(CONF_DIR) if f.endswith('.md'))
ok = []; fail = []
for fn in files:
    path = os.path.join(CONF_DIR, fn)
    meta, raw_fm, _ = fm_split(open(path).read())
    pid = meta.get('page_id')
    if not pid:
        fail.append((fn, 'no page_id')); continue
    try:
        html = fetch(pid)
        body = to_md(html).strip()
        # rebuild frontmatter: keep original lines, set/append repulled
        fm_lines = [l for l in raw_fm.split('\n') if not l.startswith('repulled:')]
        fm_lines.append(f'repulled: {TODAY}')
        out = '---\n' + '\n'.join(fm_lines) + '\n---\n\n' + body + '\n'
        open(path, 'w').write(out)
        ok.append((fn, len(body)))
    except urllib.error.HTTPError as e:
        fail.append((fn, f'HTTP {e.code}'))
    except Exception as e:
        fail.append((fn, str(e)[:60]))
    time.sleep(0.25)

print(f'OK: {len(ok)}  FAIL: {len(fail)}')
for fn, why in fail: print('  FAIL', fn, '-', why)
print('sample sizes:', [(f, n) for f, n in ok[:3]])
