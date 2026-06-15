import json, re, html, urllib.request, time, os

TS = "20251226215539"
D = os.path.dirname(__file__)
F = os.path.join(D, "site-content.json")
data = json.load(open(F))

def clean(t):
    t = re.sub(r'<script[\s\S]*?</script>', ' ', t, flags=re.I)
    t = re.sub(r'<style[\s\S]*?</style>', ' ', t, flags=re.I)
    t = re.sub(r'<svg[\s\S]*?</svg>', ' ', t, flags=re.I)
    t = re.sub(r'<[^>]+>', ' ', t)
    t = html.unescape(t)
    return re.sub(r'\s+', ' ', t).strip()

todo = [p for p, v in data.items() if isinstance(v, str) and v.startswith("ERR")]
print(f"retrying {len(todo)} pages")

for p in todo:
    url = f"https://web.archive.org/web/{TS}id_/https://calliope.ai{p}"
    delay = 3
    for attempt in range(5):
        try:
            req = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0"})
            raw = urllib.request.urlopen(req, timeout=45).read().decode("utf-8", "ignore")
            data[p] = clean(raw)
            print(f"OK {p} ({len(data[p])} chars)")
            json.dump(data, open(F, "w"), indent=1, ensure_ascii=False)
            break
        except Exception as e:
            print(f"  retry {attempt+1} {p}: {e}")
            time.sleep(delay)
            delay *= 2
    else:
        print(f"GAVE UP {p}")
    time.sleep(2.5)

remaining = [p for p, v in data.items() if isinstance(v, str) and v.startswith("ERR")]
print("DONE. still missing:", len(remaining), remaining)
