#!/usr/bin/env python3
"""Extract verbatim calliope.ai copy per page and emit scripts/pages_content.json."""
import json, re

SRC = "design-system/reference/site-content.json"

# slug, calliope path, archetype, active(nav), dataPage(CTA key), back{href,label}
REG = [
 # product tools
 ("product-ai-lab","/product/ai-lab/","tool","product","product","/product.html","The Hub"),
 ("product-chat-studio","/product/chat/","tool","product","product","/product.html","The Hub"),
 ("product-deep-agent","/product/deep-agent/","tool","product","product","/product.html","The Hub"),
 ("product-langflow","/product/langflow/","tool","product","product","/product.html","The Hub"),
 ("product-browser","/product/browser/","tool","product","product","/product.html","The Hub"),
 # core blocks
 ("product-agents","/product/core/agents/","tool","product","product","/product.html","The Hub"),
 ("product-agent-coding","/product/core/agent-coding/","tool","product","product","/product.html","The Hub"),
 ("product-code-assist","/product/core/code-assist/","tool","product","product","/product.html","The Hub"),
 ("product-data-agents","/product/core/data-agents/","tool","product","product","/product.html","The Hub"),
 ("product-datasets","/product/core/datasets/","tool","product","product","/product.html","The Hub"),
 ("product-model-hosting","/product/core/model-hosting/","tool","product","product","/product.html","The Hub"),
 ("product-notebook-chat","/product/core/notebook-chat/","tool","product","product","/product.html","The Hub"),
 ("product-notebook-generation","/product/core/notebook-generation/","tool","product","product","/product.html","The Hub"),
 ("product-prompt-engineering","/product/core/prompt-engineering/","tool","product","product","/product.html","The Hub"),
 # governance children
 ("governance-audit","/governance/audit/","child","governance","governance","/governance.html","Governance"),
 ("governance-compliance","/governance/compliance/","child","governance","governance","/governance.html","Governance"),
 ("governance-content-scanning","/governance/content-scanning/","child","governance","governance","/governance.html","Governance"),
 ("governance-policies","/governance/policies/","child","governance","governance","/governance.html","Governance"),
 ("governance-risk","/governance/risk/","child","governance","governance","/governance.html","Governance"),
 ("governance-secrets","/governance/secrets/","child","governance","governance","/governance.html","Governance"),
 # security children
 ("security-architecture","/security/architecture/","child","governance","security","/security.html","Security"),
 ("security-data-protection","/security/data-protection/","child","governance","security","/security.html","Security"),
 # deployment children
 ("deployment-cloud-hosted","/deployment/cloud-hosted/","child","product","deployment","/deployment.html","Deployment"),
 ("deployment-dedicated-cloud","/deployment/dedicated-cloud/","child","product","deployment","/deployment.html","Deployment"),
 ("deployment-jump-server","/deployment/jump-server/","child","product","deployment","/deployment.html","Deployment"),
 ("deployment-on-premise","/deployment/on-premise/","child","product","deployment","/deployment.html","Deployment"),
 ("deployment-desktop","/deployment/desktop/","child","product","deployment","/deployment.html","Deployment"),
 # solutions
 ("solution-agent-platforms","/solutions/agent-platforms/","solution","solutions","solutions","/solutions.html","Solutions"),
 ("solution-ai-applications","/solutions/ai-applications/","solution","solutions","solutions","/solutions.html","Solutions"),
 ("solution-chatbots","/solutions/chatbots/","solution","solutions","solutions","/solutions.html","Solutions"),
 ("solution-data-exploration","/solutions/data-exploration/","solution","solutions","solutions","/solutions.html","Solutions"),
 ("solution-internal-automation","/solutions/internal-automation/","solution","solutions","solutions","/solutions.html","Solutions"),
 ("solution-knowledge-base","/solutions/knowledge-base/","solution","solutions","solutions","/solutions.html","Solutions"),
 ("solution-research-tools","/solutions/research-tools/","solution","solutions","solutions","/solutions.html","Solutions"),
 # industries
 ("industry-healthcare-pharma","/industries/healthcare-pharma/","industry","solutions","industries","/industries.html","Industries"),
 ("industry-government-defense","/industries/government-defense/","industry","solutions","industries","/industries.html","Industries"),
 ("industry-energy-utilities","/industries/energy-utilities/","industry","solutions","industries","/industries.html","Industries"),
 ("industry-life-sciences","/industries/life-sciences/","industry","solutions","industries","/industries.html","Industries"),
 ("industry-manufacturing","/industries/manufacturing/","industry","solutions","industries","/industries.html","Industries"),
 ("industry-research-academia","/industries/research-academia/","industry","solutions","industries","/industries.html","Industries"),
 ("industry-climate-environment","/industries/climate-environment/","industry","solutions","industries","/industries.html","Industries"),
 # company
 ("about","/about-calliope/","about","","home","",""),
 ("team","/team/","team","","home","",""),
 ("careers","/careers/","careers","","home","",""),
 ("contact","/contact/","contact","","home","",""),
 ("developer-resources","/developer-resources/","posts","","home","",""),
 ("blog","/blog/","posts","","home","",""),
]

def load_pages():
    data=json.load(open(SRC)); out={}
    def walk(o):
        if isinstance(o,dict):
            for k,v in o.items():
                if isinstance(k,str) and k.startswith("/") and isinstance(v,str): out.setdefault(k,v)
                walk(v)
        elif isinstance(o,list):
            for v in o: walk(v)
    walk(data); return out

def lcsub(a,b):
    best=""; step,win=120,600
    for i in range(0,max(1,len(a)-win),step):
        c=a[i:i+win]
        if c in b and len(c)>len(best):
            j=b.find(c); li,lj=i,j
            while li>0 and lj>0 and a[li-1]==b[lj-1]: li-=1; lj-=1
            ri,rj=i+win,j+win
            while ri<len(a) and rj<len(b) and a[ri]==b[rj]: ri+=1; rj+=1
            if ri-li>len(best): best=a[li:ri]
    return best

FOOT=["This site uses cookies","Empowering innovation with CalliopeAI","Contact Calliope Labs","Calliope Labs Inc (c)","All rights reserved"]

def body_of(raw, nav):
    b=raw
    i=b.rfind(nav[:300]) if nav else -1
    if i>=0: b=b[i+len(nav):]
    cut=len(b)
    for m in FOOT:
        j=b.find(m)
        if j>=0: cut=min(cut,j)
    return b[:cut].strip()

def features(body):
    # **Title** — desc  pairs
    out=[]
    for m in re.finditer(r"\*\*(.+?)\*\*\s*[—–-]?\s*(.*?)(?=\*\*|$)", body):
        t=m.group(1).strip(); d=re.sub(r"\s+"," ",m.group(2)).strip(" .—–-")
        if t and len(t)<70: out.append({"title":t,"desc":d[:200]})
    return out[:6]

def clean(s): return re.sub(r"\s+"," ",s).strip()


NAMES={
 "product-ai-lab":"AI Lab","product-chat-studio":"Chat Studio","product-deep-agent":"Deep Agent",
 "product-langflow":"Langflow","product-browser":"Secure Browser","product-agents":"Agents",
 "product-agent-coding":"Agent Coding","product-code-assist":"Code Assist","product-data-agents":"Data Agents",
 "product-datasets":"Datasets","product-model-hosting":"Model Hosting","product-notebook-chat":"Notebook Chat",
 "product-notebook-generation":"Notebook Generation","product-prompt-engineering":"Prompt Engineering",
 "governance-audit":"Audit & Observability","governance-compliance":"Compliance Frameworks",
 "governance-content-scanning":"Content Scanning","governance-policies":"Policy Management",
 "governance-risk":"Risk Management","governance-secrets":"Secrets & Credentials",
 "security-architecture":"Security Architecture","security-data-protection":"Data Protection",
 "deployment-cloud-hosted":"Cloud Hosted","deployment-dedicated-cloud":"Dedicated Cloud",
 "deployment-jump-server":"Jump Server / VPC Gateway","deployment-on-premise":"On-Premise / Air-Gapped",
 "deployment-desktop":"Desktop App","solution-agent-platforms":"Agent Platforms",
 "solution-ai-applications":"AI Applications","solution-chatbots":"Chatbots",
 "solution-data-exploration":"Data Exploration","solution-internal-automation":"Internal Automation",
 "solution-knowledge-base":"Knowledge Base","solution-research-tools":"Research Tools",
 "industry-healthcare-pharma":"Healthcare & Pharma","industry-government-defense":"Government & Defense",
 "industry-energy-utilities":"Energy & Utilities","industry-life-sciences":"Life Sciences & Biotech",
 "industry-manufacturing":"Manufacturing","industry-research-academia":"Research & Academia",
 "industry-climate-environment":"Climate & Environment",
 "about":"About Calliope","team":"Team","careers":"Careers","contact":"Contact",
 "developer-resources":"Developer Resources","blog":"Blog",
}
SECT={"tool":"Product","child":None,"solution":"Solutions","industry":"Industries",
 "about":"Company","team":"Company","careers":"Company","contact":"Company","posts":"Company"}
def eyebrow_for(slug,arch,blabel):
    name=NAMES.get(slug,slug.replace("-"," ").title())
    sect=SECT.get(arch)
    if arch=="child": sect=blabel  # Governance/Security/Deployment
    return f"{sect} · {name}" if sect else name

def main():
    pages=load_pages()
    nav=lcsub(pages["/"],pages["/governance/"])
    docs={}
    for slug,path,arch,active,dp,bhref,blabel in REG:
        raw=pages.get(path,"")
        body=clean(body_of(raw,nav)) if raw else ""
        feats=features(body)
        # clean eyebrow derived from slug (our "Section · Name" style)
        eyebrow=eyebrow_for(slug,arch,blabel)
        # strip leading ALL-CAPS section label from the body (e.g. "AI LAB", "MANUFACTURING", "ZENTINELLE GRC")
        rest=re.sub(r"^([A-Z][A-Z0-9&]+(?:\s[A-Z][A-Z0-9&]+){0,3})\s+","",body)
        # hero chunk = up to next ALL-CAPS section label (>=2 caps words) or first **
        stars=rest.find("**"); stars=stars if stars>=0 else len(rest)
        lbl=re.search(r"\s([A-Z][A-Z]{2,}(?:\s[A-Z&][A-Z]+){0,3})\s[A-Z]?[a-z]", rest)
        lblpos=lbl.start() if lbl else len(rest)
        hero=clean(rest[:min(stars,lblpos)])
        # h1 = first sentence (verbatim); fall back to a clean word boundary
        hm=re.match(r"(.{6,130}?[.?!])(\s|$)", hero)
        if hm: h1=clean(hm.group(1))
        else:
            cut=hero[:90].rfind(" "); h1=clean(hero[:cut if cut>20 else 90])
        sub=clean(hero[len(h1):])[:260]
        docs[slug]={"slug":slug,"path":path,"archetype":arch,"active":active,"dataPage":dp,
                    "back":({"href":bhref,"label":blabel} if bhref else None),
                    "eyebrow":eyebrow or blabel or "Calliope",
                    "h1":h1,"sub":sub,"features":feats,
                    "_body":body[:2000]}
    json.dump(docs,open("scripts/pages_content.json","w"),indent=1,ensure_ascii=False)
    print("wrote",len(docs),"pages")
    # quick sample
    for s in ["product-ai-lab","governance-audit","solution-chatbots","industry-manufacturing","careers"]:
        d=docs[s]; print(f"\n## {s}\n eyebrow: {d['eyebrow']}\n h1: {d['h1']}\n sub: {d['sub'][:120]}\n feats: {[f['title'] for f in d['features']]}")

if __name__=="__main__": main()
