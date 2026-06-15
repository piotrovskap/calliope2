import pkg from '/Users/patrycjapiotrowska/.npm/_npx/e41f203b7505f1fb/node_modules/playwright/index.js';
const { chromium } = pkg;
import path from 'node:path';

const file = 'http://localhost:4321/';
const browser = await chromium.launch();
const ctx = await browser.newContext({ viewport: { width: 1280, height: 900 }, deviceScaleFactor: 2 });
const page = await ctx.newPage();
const errors = [];
page.on('pageerror', e => errors.push('PAGEERROR: ' + e.message));
page.on('console', m => { if (m.type() === 'error') errors.push('CONSOLE: ' + m.text()); });
await page.goto(file, { waitUntil: 'networkidle' });
await page.waitForTimeout(600);
await page.screenshot({ path: 'design-system/reference/screenshots/rebrand-landing.png', fullPage: true });
// trigger modal via exit intent simulation
await page.mouse.move(640, 400);
await page.mouse.move(640, 0);
await page.dispatchEvent('body', 'mouseout', { clientY: 0, relatedTarget: null }).catch(()=>{});
await page.evaluate(() => {
  const ev = new MouseEvent('mouseout', { clientY: 0 });
  Object.defineProperty(ev, 'relatedTarget', { value: null });
  document.dispatchEvent(ev);
});
await page.waitForTimeout(400);
const modalVisible = await page.evaluate(() => {
  const m = document.getElementById('leadModal');
  return m && !m.hidden && m.classList.contains('open');
});
await page.screenshot({ path: 'design-system/reference/screenshots/rebrand-modal.png' });
console.log('modal opened on exit-intent:', modalVisible);
console.log('JS errors:', errors.length ? errors : 'none');
await browser.close();
