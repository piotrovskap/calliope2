#!/usr/bin/env python3
"""Isolate each calliope.ai page's unique body text from the flattened crawl."""
import json, re, sys

SRC = "design-system/reference/site-content.json"

def load_pages():
    data = json.load(open(SRC))
    out = {}
    def walk(o):
        if isinstance(o, dict):
            for k, v in o.items():
                if isinstance(k, str) and k.startswith("/") and isinstance(v, str):
                    out.setdefault(k, v)
                walk(v)
        elif isinstance(o, list):
            for v in o: walk(v)
    walk(data)
    return out

def longest_common_substring(a, b):
    # DP is too slow for huge strings; use a coarse anchor approach:
    # find the longest shared run by scanning anchor windows.
    best = ""
    # sample anchors from a every 200 chars, length 400, check in b
    step, win = 120, 600
    for i in range(0, len(a)-win, step):
        chunk = a[i:i+win]
        if chunk in b and len(chunk) > len(best):
            # extend
            j = b.find(chunk)
            # grow left
            li = i; lj = j
            while li > 0 and lj > 0 and a[li-1] == b[lj-1]:
                li -= 1; lj -= 1
            # grow right
            ri = i+win; rj = j+win
            while ri < len(a) and rj < len(b) and a[ri] == b[rj]:
                ri += 1; rj += 1
            cand = a[li:ri]
            if len(cand) > len(best): best = cand
    return best

FOOT_MARKERS = ["This site uses cookies", "Empowering innovation with CalliopeAI",
                "Contact Calliope Labs", "Calliope Labs Inc (c)", "All rights reserved"]

def main():
    pages = load_pages()
    keys = sorted(pages)
    # nav block = longest common substring between home and governance
    nav = longest_common_substring(pages["/"], pages["/governance/"])
    print(f"[nav block len={len(nav)}] starts: {nav[:80]!r}\n", file=sys.stderr)
    targets = sys.argv[1:] or ["/governance/", "/product/ai-lab/", "/industries/healthcare-pharma/", "/team/", "/solutions/chatbots/", "/deployment/jump-server/"]
    for k in targets:
        t = pages.get(k, "")
        body = t
        # strip nav (last occurrence)
        idx = body.rfind(nav[:300]) if nav else -1
        if idx >= 0:
            body = body[idx+len(nav):]
        # strip footer
        cut = len(body)
        for m in FOOT_MARKERS:
            j = body.find(m)
            if j >= 0: cut = min(cut, j)
        body = body[:cut]
        body = re.sub(r"\s+", " ", body).strip()
        print(f"\n========== {k} ==========")
        print(body[:1200])

if __name__ == "__main__":
    main()
