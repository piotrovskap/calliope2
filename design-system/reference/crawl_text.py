import json, re, html, urllib.request, time, os

TS = "20251226215539"
PAGES = """/ /about-calliope/ /careers/ /contact/ /team/ /pricing/
/product/ /product/ai-lab/ /product/ide/ /product/browser/ /product/chat/ /product/deep-agent/ /product/langflow/
/product/core/agents/ /product/core/agent-coding/ /product/core/code-assist/ /product/core/data-agents/ /product/core/datasets/ /product/core/model-hosting/ /product/core/notebook-chat/ /product/core/notebook-generation/ /product/core/prompt-engineering/
/governance/ /governance/audit/ /governance/compliance/ /governance/content-scanning/ /governance/policies/ /governance/risk/ /governance/secrets/
/security/ /security/architecture/ /security/compliance/ /security/data-protection/
/deployment/ /deployment/cloud-hosted/ /deployment/dedicated-cloud/ /deployment/desktop/ /deployment/jump-server/ /deployment/on-premise/
/solutions/ /solutions/agent-platforms/ /solutions/ai-applications/ /solutions/chatbots/ /solutions/data-exploration/ /solutions/internal-automation/ /solutions/knowledge-base/ /solutions/research-tools/
/industries/ /industries/climate-environment/ /industries/energy-utilities/ /industries/financial-services/ /industries/government-defense/ /industries/healthcare-pharma/ /industries/life-sciences/ /industries/manufacturing/ /industries/research-academia/
/developer-resources/""".split()

def clean(t):
    t = re.sub(r'<script[\s\S]*?</script>', ' ', t, flags=re.I)
    t = re.sub(r'<style[\s\S]*?</style>', ' ', t, flags=re.I)
    t = re.sub(r'<svg[\s\S]*?</svg>', ' ', t, flags=re.I)
    t = re.sub(r'<[^>]+>', ' ', t)
    t = html.unescape(t)
    t = re.sub(r'\s+', ' ', t).strip()
    return t

out = {}
for p in PAGES:
    url = f"https://web.archive.org/web/{TS}id_/https://calliope.ai{p}"
    try:
        req = urllib.request.Request(url, headers={"User-Agent":"Mozilla/5.0"})
        raw = urllib.request.urlopen(req, timeout=40).read().decode("utf-8","ignore")
        txt = clean(raw)
        # drop boilerplate nav/footer repeated everywhere by trimming common header
        out[p] = txt
        print(f"OK {p} ({len(txt)} chars)")
    except Exception as e:
        out[p] = f"ERR {e}"
        print(f"ERR {p}: {e}")
    time.sleep(0.3)

with open(os.path.join(os.path.dirname(__file__),"site-content.json"),"w") as f:
    json.dump(out, f, indent=1, ensure_ascii=False)
print("DONE", len(out), "pages")
