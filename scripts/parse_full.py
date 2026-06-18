#!/usr/bin/env python3
"""Parse the full archived calliope.ai pages (~/Desktop/screens/full/<slug>.html)
into clean structured copy: hero (eyebrow,h1,sub) + ordered sections.
Emits scripts/pages_full.json."""
import re, html, os, json

FULL = os.path.expanduser('~/Desktop/screens/full')
BRANDS = ('CALLIOPE AI','ZENTINELLE','SECURITY','DEPLOYMENT')

def toks(s):
    """Yield (tag, classlist, text) for content elements in <main>, in order."""
    s=re.sub(r'<!-- BEGIN WAYBACK TOOLBAR INSERT -->.*?<!-- END WAYBACK TOOLBAR INSERT -->',' ',s,flags=re.S)
    m=re.search(r'<main\b.*?</main>',s,re.S)
    if m: s=m.group(0)
    for t in ['script','style','svg','noscript']:
        s=re.sub(r'<%s\b[\s\S]*?</%s>'%(t,t),' ',s,flags=re.I)
    out=[]
    for tag,attrs,txt in re.findall(r'<(div|h[1-6]|p|li|a|button)\b([^>]*)>([^<]*)',s):
        txt=re.sub(r'\s+',' ',html.unescape(txt)).strip()
        if len(txt)<2: continue
        cls=re.search(r'class="([^"]*)"',attrs)
        out.append((tag, (cls.group(1) if cls else ''), txt))
    return out

def has(c,*keys): return any(k in c for k in keys)

# buttons / CTA labels to ignore as copy
BTN = {'contact us','book a demo','get started','talk to us','talk to','learn more',
       'download','download free','download now','try cloud version','request a demo',
       'see deployment options','see deployment details','start free','sign up','log in',
       'explore','read the docs','get the guide','see pricing','start building'}

def is_btn(tag,c,t):
    tl=t.lower().strip(' →')
    return tl in BTN or has(c,'text-block','button','btn') and len(t)<24

def parse(slug):
    els=toks(open(os.path.join(FULL,slug+'.html')).read())
    # dedupe consecutive identical
    cl=[]
    for x in els:
        if not cl or cl[-1][2]!=x[2]: cl.append(x)
    els=cl
    hero={'eyebrow':'','h1':'','sub':''}
    sections=[]; cur=None
    i=0
    # --- hero ---
    # first bold/white line = h1; preceding short bare line (not button) = eyebrow; following subtitle = sub
    for j,(tag,c,t) in enumerate(els):
        if has(c,'font-weight-bold','text-white') or tag in ('h1',):
            hero['h1']=t
            if j>0 and len(els[j-1][2])<40 and not is_btn(*els[j-1]):
                hero['eyebrow']=els[j-1][2]
            # sub = next subtitle/gray/plain paragraph
            for k in range(j+1,min(j+4,len(els))):
                t2=els[k][2]
                if is_btn(*els[k]): continue
                if has(els[k][1],'subtitle','text-calliope-gray') or els[k][0]=='p' or len(t2)>60:
                    hero['sub']=t2; start=k+1; break
            else: start=j+1
            break
    else:
        start=0
    # --- sections ---
    def flush():
        nonlocal cur
        if cur and (cur['paras'] or cur['cards'] or cur['bullets']):
            sections.append(cur)
        cur=None
    seen_h1=False
    for tag,c,t in els[start:]:
        if is_btn(tag,c,t): continue
        if t==hero['sub'] or t==hero['h1']: continue
        # new section heading: brand eyebrow OR bold/white line OR special-title/title
        if t.upper() in BRANDS:
            flush(); cur={'eyebrow':t,'heading':'','paras':[],'cards':[],'bullets':[]}; continue
        if has(c,'font-weight-bold','text-white'):
            if cur is None: cur={'eyebrow':'','heading':'','paras':[],'cards':[],'bullets':[]}
            cur['heading']=t; continue
        if has(c,'special-title') or (has(c,'title') and tag!='h5'):
            # a sub-heading inside section (e.g. "Features", closing line) -> start new section
            flush(); cur={'eyebrow':'','heading':t,'paras':[],'cards':[],'bullets':[]}; continue
        if tag=='h5' or (has(c,'title') and tag=='h5'):
            if cur is None: cur={'eyebrow':'','heading':'','paras':[],'cards':[],'bullets':[]}
            cur['cards'].append({'title':t,'desc':''}); continue
        if tag=='li':
            if cur is None: cur={'eyebrow':'','heading':'','paras':[],'cards':[],'bullets':[]}
            if cur['cards'] and not cur['cards'][-1]['desc']:
                cur['cards'][-1]['desc']=t
            elif cur['cards']:
                cur['cards'][-1]['desc']+=' '+t
            else:
                cur['bullets'].append(t)
            continue
        # plain paragraph / gray text
        if cur is None: cur={'eyebrow':'','heading':'','paras':[],'cards':[],'bullets':[]}
        if cur['cards'] and not cur['cards'][-1]['desc'] and len(t)>20:
            cur['cards'][-1]['desc']=t
        else:
            cur['paras'].append(t)
    flush()
    return {'slug':slug,'hero':hero,'sections':sections}

if __name__=='__main__':
    import sys
    if len(sys.argv)>1:
        print(json.dumps(parse(sys.argv[1]),indent=1,ensure_ascii=False))
