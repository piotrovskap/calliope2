import pkg from '/Users/patrycjapiotrowska/.npm/_npx/e41f203b7505f1fb/node_modules/playwright/index.js';
const { chromium } = pkg;
import fs from 'node:fs';
import path from 'node:path';

const OUT = path.resolve('design-system/reference');
const SHOTS = path.join(OUT, 'screenshots');
fs.mkdirSync(SHOTS, { recursive: true });

// Key pages that cover all UI patterns on calliope.ai
const PAGES = [
  ['home', '/'],
  ['product', '/product/'],
  ['governance', '/governance/'],
  ['security', '/security/'],
  ['deployment', '/deployment/'],
  ['pricing', '/pricing/'],
  ['solutions', '/solutions/'],
  ['industries', '/industries/'],
  ['team', '/team/'],
];

const WAYBACK_TS = '20251226215539';
const liveUrl = (p) => `https://calliope.ai${p}`;
const waybackUrl = (p) => `https://web.archive.org/web/${WAYBACK_TS}/https://calliope.ai${p}`;

const STYLE_SCRIPT = () => {
  const pick = (el, props) => {
    const cs = getComputedStyle(el);
    const o = {};
    for (const p of props) o[p] = cs.getPropertyValue(p);
    return o;
  };
  const boxProps = ['color','background-color','background-image','font-family','font-size','font-weight','line-height','border-radius','border','padding','letter-spacing','box-shadow'];
  const data = { url: location.href };
  data.body = pick(document.body, ['color','background-color','font-family','font-size','line-height']);
  const h1 = document.querySelector('h1');
  if (h1) data.h1 = pick(h1, boxProps);
  const h2 = document.querySelector('h2');
  if (h2) data.h2 = pick(h2, boxProps);
  // buttons / CTA-like links
  const btns = [...document.querySelectorAll('a,button')].filter(e => {
    const cs = getComputedStyle(e);
    const bg = cs.backgroundColor;
    const hasBg = bg && bg !== 'rgba(0, 0, 0, 0)' && bg !== 'transparent';
    const hasBorder = parseFloat(cs.borderTopWidth) > 0;
    return (hasBg || hasBorder) && e.offsetWidth > 40 && e.offsetHeight > 24 && e.offsetHeight < 90;
  }).slice(0, 12);
  data.buttons = btns.map(b => ({ text: (b.innerText||'').trim().slice(0,40), ...pick(b, boxProps) }));
  const link = document.querySelector('a[href]');
  if (link) data.link = pick(link, ['color','font-weight','text-decoration-line']);
  // collect color frequency across visible elements
  const freq = {};
  const add = (c) => { if (!c || c==='rgba(0, 0, 0, 0)') return; freq[c]=(freq[c]||0)+1; };
  for (const el of document.querySelectorAll('*')) {
    const cs = getComputedStyle(el);
    add(cs.color); add(cs.backgroundColor); add(cs.borderTopColor);
  }
  data.colorFreq = Object.entries(freq).sort((a,b)=>b[1]-a[1]).slice(0,30);
  return data;
};

const browser = await chromium.launch();
const ctx = await browser.newContext({
  viewport: { width: 1440, height: 900 },
  userAgent: 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0 Safari/537.36',
  deviceScaleFactor: 2,
});
const page = await ctx.newPage();
const results = {};

for (const [name, p] of PAGES) {
  let source = 'live';
  try {
    await page.goto(liveUrl(p), { waitUntil: 'networkidle', timeout: 30000 });
    const title = await page.title();
    if (/just a moment|attention required|enable javascript/i.test(title)) throw new Error('cf-challenge: ' + title);
  } catch (e) {
    source = 'wayback';
    try {
      await page.goto(waybackUrl(p), { waitUntil: 'networkidle', timeout: 45000 });
      // remove wayback toolbar if present
      await page.evaluate(() => { const w = document.getElementById('wm-ipp-base'); if (w) w.remove(); }).catch(()=>{});
    } catch (e2) {
      console.log(`SKIP ${name}: ${e2.message}`);
      results[name] = { error: e2.message };
      continue;
    }
  }
  await page.waitForTimeout(1500);
  const shot = path.join(SHOTS, `${name}.png`);
  await page.screenshot({ path: shot, fullPage: true }).catch(err => console.log('shot fail', name, err.message));
  let styles = {};
  try { styles = await page.evaluate(STYLE_SCRIPT); } catch (e) { styles = { error: e.message }; }
  results[name] = { source, screenshot: path.relative(OUT, shot), styles };
  console.log(`OK ${name} (${source})`);
}

fs.writeFileSync(path.join(OUT, 'design-tokens.raw.json'), JSON.stringify(results, null, 2));
await browser.close();
console.log('DONE -> design-tokens.raw.json');
