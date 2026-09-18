(function () {
  /* Load IBM Plex Sans 500 if not already present */
  if (!document.querySelector('link[href*="IBM+Plex+Sans"]')) {
    var font = document.createElement('link');
    font.rel = 'stylesheet';
    font.href = 'https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:wght@400;500;600&display=swap';
    document.head.appendChild(font);
  }

  /* Inject CSS — exact copy from /blueprint with hardcoded values */
  var style = document.createElement('style');
  style.textContent = ''
    + '.bp-topbar{position:sticky;top:0;z-index:50}'
    + '.bp-header{background:rgba(22,35,69,.82);backdrop-filter:blur(12px);-webkit-backdrop-filter:blur(12px);border-bottom:1px solid rgba(63,241,239,.18)}'
    + '.bp-header-inner{display:flex;align-items:center;gap:2rem;height:66px;max-width:1360px;margin:0 auto;padding:0 clamp(16px,4vw,44px)}'
    + '.bp-brand{display:inline-flex;align-items:center;text-decoration:none}'
    + '.bp-brand-logo{display:block;height:22px;width:auto}'
    + '.bp-nav{display:flex;gap:.2rem;margin-right:auto;margin-left:1.25rem}'
    + '.bp-nav-link{font:500 .92rem/1 "IBM Plex Sans",system-ui,sans-serif!important;letter-spacing:normal!important;text-transform:none!important;color:#8fa3c4;text-decoration:none;padding:.55rem .7rem;border-radius:6px;transition:color .15s,background .15s}'
    + '.bp-nav-link:hover{color:#fff!important;background:rgba(255,255,255,.05)}'
    + '.bp-nav-link--solo:hover{background:none!important;color:#3FF1EF!important}'
    + '.bp-cta{display:flex;gap:.7rem;align-items:center}'
    + '.bp-btn{display:inline-flex;align-items:center;gap:.4rem;font:600 .9rem/1 "IBM Plex Sans",system-ui,sans-serif!important;letter-spacing:normal!important;text-transform:none!important;padding:.58rem 1rem;border-radius:8px;text-decoration:none;border:1px solid transparent;cursor:pointer;transition:transform .15s,filter .15s}'
    + '.bp-btn:hover{transform:translateY(-1px)}'
    + '.bp-btn-primary{background:#3FF1EF!important;color:#08131f!important;box-shadow:0 8px 24px -10px rgba(63,241,239,.5)}'
    + '.bp-btn-primary:hover{filter:brightness(1.07)}'
    + '@media(max-width:760px){.bp-nav{display:none}.bp-cta .bp-nav-link--solo{display:none}}';
  document.head.appendChild(style);

  /* Inject HTML before body content */
  var nav = document.createElement('div');
  nav.className = 'bp-topbar';
  nav.innerHTML = '<header class="bp-header"><div class="bp-header-inner">'
    + '<a class="bp-brand" href="/blueprint/" aria-label="Calliope AI Blueprint">'
    + '<img class="bp-brand-logo" src="/blueprint/assets/calliope-ai.png" alt="Calliope AI">'
    + '</a>'
    + '<nav class="bp-nav" aria-label="Blueprint sections">'
    + '<a class="bp-nav-link" href="/blueprint/">Start</a>'
    + '<a class="bp-nav-link" href="/blueprint/#assembly">Assembly</a>'
    + '<a class="bp-nav-link" href="/blueprint/#parts">Parts</a>'
    + '<a class="bp-nav-link" href="/blueprint/#topologies">Topologies</a>'
    + '<a class="bp-nav-link" href="/blueprint/#rollout">Rollout</a>'
    + '</nav>'
    + '<div class="bp-cta">'
    + '<a class="bp-nav-link bp-nav-link--solo" href="https://calliope.ai/contact">Contact us</a>'
    + '<a class="bp-btn bp-btn-primary" href="https://calliope.ai/blueprint/calliope-ai-deployment-blueprint.pdf" download>Download PDF</a>'
    + '</div>'
    + '</div></header>';

  document.body.insertBefore(nav, document.body.firstChild);
})();
