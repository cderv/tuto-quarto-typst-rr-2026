// Rend _assets/og-card.html en og-card.png (racine), 2400x1260 (ratio 1200x630).
// Necessite Playwright + Chromium :
//   npx playwright install chromium
//   NODE_PATH=/opt/node22/lib/node_modules node _assets/render-card.js
const { chromium } = require('playwright');
const path = require('path');

(async () => {
  const html = 'file://' + path.join(__dirname, 'og-card.html');
  const out = path.join(__dirname, '..', 'og-card.png');
  const b = await chromium.launch();
  const p = await b.newPage({ viewport: { width: 1200, height: 630 }, deviceScaleFactor: 2 });
  await p.goto(html);
  try { await p.evaluate(() => document.fonts.ready); } catch (e) {}
  await p.waitForTimeout(500);
  await p.screenshot({ path: out, clip: { x: 0, y: 0, width: 1200, height: 630 } });
  await b.close();
  console.log('Ecrit : ' + out);
})();
