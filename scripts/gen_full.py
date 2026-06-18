#!/usr/bin/env python3
"""Render public/<slug>.html for every SUBPAGE from scripts/pages_full.json,
faithfully reproducing calliope.ai copy inside our design system."""
import json, html, re, os

V_CSS, V_HDR, V_FTR, V_JS = 43, 12, 16, 9
OUT = "public"

def e(s): return html.escape(s or "", quote=True)
def rich(s):
    """**bold** -> <strong>, escape the rest."""
    parts=re.split(r'(\*\*.+?\*\*)', s or "")
    o=""
    for p in parts:
        if p.startswith('**') and p.endswith('**'): o+="<strong>"+e(p[2:-2])+"</strong>"
        else: o+=e(p)
    return o

# ---- per-slug metadata (active nav, footer CTA key, back-link) ----
def meta(slug):
    def m(active,dp,back=None,eyebrow=''):
        return {'active':active,'dataPage':dp,'back':back,'eyebrow':eyebrow}
    if slug in ('product','governance','security','deployment','solutions','industries'):
        return m(  {'product':'platform','governance':'','security':'security',
                    'deployment':'deployment','industries':'industries'}.get(slug,slug),
                   slug, None)
    if slug.startswith('product-'):    return m('platform','product',  ('/product.html','The Workbench'))
    if slug == 'governance-secrets':   return m('security','security',('/security.html','Security'))
    if slug.startswith('governance-'): return m('','governance',('/governance.html','Governance'))
    if slug.startswith('security-'):   return m('security','security',('/security.html','Security'))
    if slug.startswith('deployment-'): return m('deployment','deployment',('/deployment.html','Deployment'))
    if slug.startswith('solution-'):   return m('solutions','solutions',('/solutions.html','Solutions'))
    if slug.startswith('industry-'):   return m('industries','industries',('/industries.html','Industries'))
    if slug in ('about','team','careers','contact','developer-resources'):
        return m('', 'home', ('/','Home'))
    return m('', 'home', None)

EY_FALLBACK={'product':'Platform · The Hub','governance':'Zentinelle · GRC for AI','security':'Security',
 'deployment':'Deployment','solutions':'Solutions','industries':'Industries'}

HEAD = """<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>{title}</title>
  <meta name="description" content="{desc}" />
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=DM+Sans:ital,opsz,wght@0,9..40,100..1000;1,9..40,100..1000&family=IBM+Plex+Sans:ital,wght@0,100..700;1,100..700&display=swap" rel="stylesheet" />
  <link rel="icon" href="/img/favicon.png" />
  <link rel="stylesheet" href="/styles.css?v={vcss}" />
  <script src="/site-header.js?v={vhdr}"></script>
  <script src="/site-footer.js?v={vftr}"></script>
</head>
<body>
  <div class="vframe" aria-hidden="true"></div>
  <site-header data-active="{active}"></site-header>
  <main id="main">
"""
FOOT = """  </main>
  <site-footer data-page="{dp}"></site-footer>
  <script src="/script.js?v={vjs}"></script>
</body>
</html>
"""

def hero(eyebrow,h1,sub,back):
    backh=f'<a href="{e(back[0])}" class="subhero-back">← {e(back[1])}</a>' if back else ""
    return f"""    <section class="hero hero--center subhero">
      <div class="wrap hero-center">
        {backh}
        <p class="section-eyebrow">{e(eyebrow)}</p>
        <h1 class="hero-title">{rich(h1)}</h1>
        <p class="hero-sub">{rich(sub)}</p>
        <div class="hero-actions center">
          <a href="/#demo" class="btn btn-primary btn-lg">Book a demo</a>
          <a href="/pricing.html" class="btn btn-ghost btn-lg">See pricing →</a>
        </div>
      </div>
    </section>
"""

def orch(heading, cards):
    rows=[]
    for i,c in enumerate(cards,1):
        rows.append(f"""        <article class="orch-row">
          <div class="orch-copy">
            <span class="orch-no">{i:02d}</span>
            <h3 class="orch-title">{rich(c['title'])}</h3>
            <p class="orch-desc">{rich(c['desc'])}</p>
          </div>
          <div class="orch-visual"><div class="img-ph"><span>{e(c['title'])}<br>(screenshot)</span></div></div>
        </article>""")
    head=f'<div class="wrap"><h2 class="section-title">{rich(heading)}</h2></div>' if heading else ""
    return f"""    <section>
      {head}
      <div class="orch-rows">
{chr(10).join(rows)}
      </div>
    </section>
"""

def grid(heading, cards, light):
    cls="band-light" if light else ""
    cardhtml="".join(f'<div class="feature"><h3>{rich(c["title"])}</h3><p>{rich(c["desc"])}</p></div>' for c in cards)
    head=f'<h2 class="section-title">{rich(heading)}</h2>' if heading else ""
    return f"""    <section class="{cls}">
      <div class="wrap">
        {head}
        <div class="feature-grid card-grid-3">{cardhtml}</div>
      </div>
    </section>
"""

def narrative(heading, paras, bullets, light, as_list):
    cls="band-light" if light else ""
    h=f'<h2 class="section-title">{rich(heading)}</h2>' if heading else ""
    body=""
    if as_list and paras:
        # first para may be a lead line; rest are list items
        lead = paras[0] if (paras and len(paras[0])>50 and len(paras)>1) else ""
        items = paras[1:] if lead else paras
        if lead: body+=f'<p class="section-lead" style="max-width:760px;">{rich(lead)}</p>'
        body+='<ul class="copy-list">'+''.join(f'<li>{rich(x)}</li>' for x in items)+'</ul>'
    else:
        body+=''.join(f'<p class="section-lead" style="max-width:760px;">{rich(p)}</p>' for p in paras)
    if bullets:
        body+='<ul class="copy-list">'+''.join(f'<li>{rich(b)}</li>' for b in bullets)+'</ul>'
    return f"""    <section class="{cls}">
      <div class="wrap">
        {h}
        {body}
      </div>
    </section>
"""

ROTATOR = """<h2 class="valley-line">
          Enterprises are scaling
          <span class="rotator" aria-hidden="true">
            <span class="rotator-track">
              <span>secure ML</span>
              <span>AI agents</span>
              <span>data science</span>
              <span>private LLMs</span>
              <span>secure ML</span>
              <span>AI agents</span>
              <span>data science</span>
            </span>
          </span>
          <span class="visually-hidden">AI agents, data science, private LLMs and secure ML</span>
          with Calliope
        </h2>"""

def valley(slug, closing):
    return f"""    <section class="valley" id="demo" aria-label="Book a demo">
      <div class="wrap valley-content center">
        {ROTATOR}
        <p class="cta-sub">Book a private demo, or explore the platform on your own terms.</p>
        <form class="lead-inline center" data-lead-form data-source="{e(slug)}">
          <input type="email" name="email" required placeholder="you@company.com" aria-label="Work email" />
          <button type="submit" class="btn btn-primary">Book a demo</button>
        </form>
        <p class="lead-note">A 30-minute walkthrough with an engineer — not a sales script.</p>
      </div>
    </section>
"""

def clean_h1(h):
    return re.sub(r'[\s—–\-&]+$','',h or '').strip()

def render(slug, doc):
    mt=meta(slug)
    hr=doc['hero']
    eyebrow = hr['eyebrow'] or mt['eyebrow'] or EY_FALLBACK.get(slug,'') or slug.replace('-',' ').title()
    h1 = clean_h1(hr['h1']) or slug.replace('-',' ').title()
    secs = doc['sections']
    sub = hr['sub']
    if not sub and secs and secs[0]['paras']: sub=secs[0]['paras'][0]
    blocks=[hero(eyebrow,h1,sub,mt['back'])]

    # closing line = last section that is a single short statement (heading only, no cards)
    closing=None
    body_secs=list(secs)
    if body_secs:
        last=body_secs[-1]
        if not last['cards'] and last['heading'] and len(last['paras'])<=1:
            closing=last['heading']
            body_secs=body_secs[:-1]

    light=True
    first_cards_done=False
    for s in body_secs:
        heading=s['heading']
        if s['cards']:
            if not first_cards_done:
                blocks.append(orch(heading, s['cards'])); first_cards_done=True
            else:
                blocks.append(grid(heading, s['cards'], light)); light=not light
        elif s['paras'] or s['bullets']:
            as_list = heading.strip().endswith(':') or all(len(p)<70 for p in s['paras'][1:]) and len(s['paras'])>2
            blocks.append(narrative(heading, s['paras'], s['bullets'], light, as_list)); light=not light

    # final CTA (rotator + Calliope form) now comes from <site-footer>, not here
    head=HEAD.format(title=e((eyebrow.split('·')[-1].strip() or slug)+" | Calliope AI"),
                     desc=e((sub or h1)[:150]), vcss=V_CSS,vhdr=V_HDR,vftr=V_FTR,active=mt['active'])
    foot=FOOT.format(dp=mt['dataPage'], vjs=V_JS)
    return head+"".join(blocks)+foot

def main():
    docs=json.load(open('scripts/pages_full.json'))
    skip={'pricing','product','governance','security','deployment','solutions','industries'}  # bespoke hubs handled separately
    n=0
    for slug,doc in docs.items():
        if slug in skip: continue
        if not doc['hero']['h1'] and not doc['sections']: continue
        open(os.path.join(OUT,slug+".html"),"w").write(render(slug,doc)); n+=1
    print("generated",n,"subpages")

if __name__=="__main__": main()
