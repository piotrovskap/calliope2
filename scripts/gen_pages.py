#!/usr/bin/env python3
"""Render public/<slug>.html for every page in scripts/pages_content.json,
reusing the existing design-system classes."""
import json, html, re, os

V_CSS, V_HDR, V_FTR, V_JS = 47, 14, 16, 13
DATA = "scripts/pages_content.json"
OUT = "public"

def e(s): return html.escape(s or "", quote=True)

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

def hero(p):
    back = f'<a href="{e(p["back"]["href"])}" class="subhero-back">← {e(p["back"]["label"])}</a>' if p.get("back") else ""
    return f"""    <section class="hero hero--center subhero">
      <div class="wrap hero-center">
        {back}
        <p class="section-eyebrow">{e(p["eyebrow"])}</p>
        <h1 class="hero-title">{e(p["h1"])}</h1>
        <p class="hero-sub">{e(p["sub"])}</p>
        <div class="hero-actions center">
          <a href="/#demo" class="btn btn-primary btn-lg">Book a demo</a>
          <a href="/pricing.html" class="btn btn-ghost btn-lg">See pricing →</a>
        </div>
      </div>
    </section>
"""

def orch_rows(name, feats):
    if not feats: return ""
    rows=[]
    for i,f in enumerate(feats,1):
        rows.append(f"""        <article class="orch-row">
          <div class="orch-copy">
            <span class="orch-no">{i:02d}</span>
            <h3 class="orch-title">{e(f['title'])}</h3>
            <p class="orch-desc">{e(f['desc'])}</p>
          </div>
          <div class="orch-visual"><div class="img-ph"><span>{e(name)} — {e(f['title'])}<br>(screenshot)</span></div></div>
        </article>""")
    return f"""    <section>
      <div class="wrap"><p class="section-eyebrow">How it works</p><h2 class="section-title">What it does.</h2></div>
      <div class="orch-rows">
{chr(10).join(rows)}
      </div>
    </section>
"""

def feature_grid(title, feats, light=True):
    if not feats: return ""
    cards="".join(f'<div class="feature"><h3>{e(f["title"])}</h3><p>{e(f["desc"])}</p></div>' for f in feats)
    cls="band-light" if light else ""
    return f"""    <section class="{cls}">
      <div class="wrap">
        <h2 class="section-title">{e(title)}</h2>
        <div class="feature-grid card-grid-3">{cards}</div>
      </div>
    </section>
"""

def people_grid(body):
    # parse "NAME Role" sequences (NAME = all-caps token, role = following Title-case words)
    ppl=re.findall(r"\b([A-Z]{3,})\s+([A-Z][A-Za-z][^A-Z]{2,40}?)(?=[A-Z]{3,}|$)", body)
    if not ppl: return ""
    cards=[]
    for nm,role in ppl[:16]:
        role=re.sub(r"\s+"," ",role).strip(" .&")
        cards.append(f'<div class="feature"><div class="img-ph" style="aspect-ratio:1/1;margin-bottom:1rem;"><span>{e(nm.title())}</span></div><h3>{e(nm.title())}</h3><p>{e(role)}</p></div>')
    return f"""    <section>
      <div class="wrap">
        <h2 class="section-title">Meet the humans behind the AI.</h2>
        <div class="feature-grid card-grid-3">{''.join(cards)}</div>
      </div>
    </section>
"""

def prose(body):
    txt=re.sub(r"\*\*","",body)[:1100]
    return f"""    <section class="band-light">
      <div class="wrap"><p class="section-lead" style="max-width:760px;">{e(txt)}</p></div>
    </section>
"""

def contact_block():
    return """    <section>
      <div class="wrap">
        <div class="card lead-card" style="max-width:560px;margin:0 auto;">
          <form data-lead-form data-source="contact">
            <h3>Talk to us</h3>
            <label>Work email <input type="email" name="email" required placeholder="you@company.com" autocomplete="email" /></label>
            <label>Company <input type="text" name="company" placeholder="Acme Corp" autocomplete="organization" /></label>
            <button type="submit" class="btn btn-primary btn-block">Contact sales</button>
            <p class="lead-card-note">A 30-minute walkthrough with an engineer — not a sales script.</p>
          </form>
        </div>
      </div>
    </section>
"""

def valley(p):
    return f"""    <section class="valley" id="demo" aria-label="Book a demo">
      <div class="wrap valley-content center">
        <h2 class="valley-line">See it running in your cloud.</h2>
        <p class="cta-sub">Book a private demo, or explore the platform on your own terms.</p>
        <form class="lead-inline center" data-lead-form data-source="{e(p['slug'])}">
          <input type="email" name="email" required placeholder="you@company.com" aria-label="Work email" />
          <button type="submit" class="btn btn-primary">Book a demo</button>
        </form>
        <p class="lead-note">A 30-minute walkthrough with an engineer — not a sales script.</p>
      </div>
    </section>
"""

def render(p):
    name=p["eyebrow"].split("·")[-1].strip()
    arch=p["archetype"]; feats=p.get("features",[]); body=p.get("_body","")
    blocks=[hero(p)]
    if arch in ("tool","child","solution","industry"):
        blocks.append(orch_rows(name, feats[:3]))
        rest=feats[3:] if len(feats)>3 else (feats if not feats[:3] else [])
        if rest: blocks.append(feature_grid("More capabilities", rest, light=True))
    elif arch=="team":
        blocks.append(people_grid(body))
    elif arch=="careers":
        blocks.append(prose(body))
        if feats: blocks.append(feature_grid("Open roles", feats, light=True))
    elif arch=="contact":
        blocks.append(contact_block())
    elif arch=="posts":
        blocks.append(prose(body))
        if feats: blocks.append(feature_grid("Resources", feats, light=True))
    else:  # about / fallback
        blocks.append(prose(body))
        if feats: blocks.append(feature_grid("What we believe", feats, light=True))
    blocks.append(valley(p))
    head=HEAD.format(title=e(name+" | Calliope AI"), desc=e(p["sub"][:150] or name),
                     vcss=V_CSS, vhdr=V_HDR, vftr=V_FTR, active=p.get("active",""))
    foot=FOOT.format(dp=p.get("dataPage","home"), vjs=V_JS)
    return head + "".join(blocks) + foot

def main():
    docs=json.load(open(DATA))
    n=0
    for slug,p in docs.items():
        open(os.path.join(OUT,slug+".html"),"w").write(render(p)); n+=1
    print("generated",n,"pages")

if __name__=="__main__": main()
