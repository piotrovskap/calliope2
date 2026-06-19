/* Shared site footer — one component for every page (includes the marble hand).
   Usage: <site-footer></site-footer>
   Renders into light DOM so script.js form handlers bind as usual. */
(function () {
  /* Per-page pre-footer CTA — copy mirrors the matching page on calliope.ai.
     Each page selects via <site-footer data-page="..."> (defaults to "home"). */
  var CTAS = {
    home:        { h: 'Stop saying no to AI.', a: 'Start saying YES, safely.', s: 'A secure AI development platform that enables innovation instead of blocking it — launch faster, stay compliant, keep control.', p: ['Talk to sales', '/#demo'], sec: ['See governance', '/governance.html'] },
    home2:       { h: 'Self-host enterprise AI', a: 'in days.', s: 'Stop choosing between moving fast and staying in control.', p: ['Book a demo', '/#demo'], sec: ['See how it works', '/how-it-works.html'] },
    product:     { h: 'Stop managing', a: 'tools.', s: 'The Hub gives your team everything they need to develop, deploy and govern AI systems — in one platform that works the way enterprises require.', p: ['Get started', '/#demo'], sec: ['Talk to us', '/#demo'] },
    ide:         { h: 'The most capable', a: 'AI IDE.', s: 'Available for macOS, Windows and Linux. No accounts, no signup — free for personal, professional and commercial use.', p: ['Download AI IDE', '/#demo'], sec: ['Try cloud version', '/#demo'] },
    governance:  { h: 'Stop treating AI like', a: 'traditional IT.', s: 'Zentinelle gives you the GRC infrastructure AI systems require — observability, controllability and feedback loops that keep autonomous systems under control.', p: ['Talk to sales', '/#demo'], sec: ['See risk management', '/governance.html'] },
    security:    { h: "Security isn't a feature.", a: "It's the architecture.", s: 'From how we ship code to how we manage runtime workloads, Calliope embeds security from the first commit — not bolted on later.', p: ['Talk to sales', '/#demo'], sec: ['See compliance', '/security-compliance.html'], fig: '/img/calliope-img/5.png' },
    deployment:  { h: 'Deploy where', a: 'you need to.', s: "Whether you're a startup moving fast or an enterprise with strict compliance requirements, Calliope adapts to your infrastructure — not the other way around.", p: ['Talk to sales', '/#demo'], sec: ['Start free (Desktop)', '/#demo'] },
    solutions:   { h: "Whatever", a: "you're building.", s: 'Calliope gives every team the AI capabilities they need — with the governance, compliance and deployment flexibility your organization requires.', p: ['Talk to sales', '/#demo'], sec: ['See governance', '/governance.html'] },
    industries:  { h: 'Compliant AI,', a: 'wherever you operate.', s: 'Calliope gives every industry the AI platform it needs — governed, compliant and deployable in your own perimeter.', p: ['Talk to sales', '/#demo'], sec: ['See governance', '/governance.html'] },
    'industry-fs': { h: 'AI for', a: 'financial services.', s: 'Calliope gives financial institutions the AI platform they need — with the controls their regulators require.', p: ['Contact sales', '/#demo'], sec: ['See compliance', '/security-compliance.html'] },
    pricing:     { h: 'Built by builders,', a: 'for builders.', s: "Whether you're building agent platforms, AI-first products or internal copilots, Calliope is your unfair advantage.", p: ['Start building smarter', '/#demo'], sec: ['Explore the platform', '/product.html'] },
    how:         { h: 'From prototype to', a: 'governed production.', s: 'Build, govern and ship AI on one platform that runs in your perimeter — in under an hour.', p: ['Book a demo', '/#demo'], sec: ['See pricing', '/pricing.html'] }
  };

  function precta(page) {
    var c = CTAS[page] || CTAS.home;
    var head = c.a ? (c.h + ' <span class="grad">' + c.a + '</span>') : c.h;
    return '' +
      '<section class="precta band-light" aria-label="Get started">' +
        '<div class="precta-inner wrap">' +
          '<div class="precta-copy">' +
            '<h2 class="precta-head">' + head + '</h2>' +
            '<p class="precta-sub">' + c.s + '</p>' +
            '<form class="lead-inline precta-form" data-lead-form data-source="precta-' + page + '">' +
              '<input type="email" name="email" required placeholder="you@company.com" aria-label="Work email" />' +
              '<button type="submit" class="btn btn-primary btn-lg">' + c.p[0] + ' →</button>' +
            '</form>' +
            '<label class="gdpr-consent">' +
              '<input type="checkbox" name="consent" value="yes" required />' +
              '<span>I agree to the processing of my personal data to be contacted about this request, as described in the <a href="/#privacy">Privacy Policy</a>. (GDPR / RODO)</span>' +
            '</label>' +
            '<a href="' + c.sec[1] + '" class="precta-textlink">' + c.sec[0] + ' →</a>' +
          '</div>' +
          '<div class="precta-figure">' +
            '<canvas class="split-ascii" aria-hidden="true"></canvas>' +
            '<img src="' + (c.fig || '/img/calliope-img/2.png') + '" alt="" loading="lazy" />' +
          '</div>' +
        '</div>' +
      '</section>';
  }

  function valleyRotator() {
    return '' +
      '<section class="valley" id="demo" aria-label="Get started">' +
        '<div class="wrap valley-content center">' +
          '<h2 class="valley-line">' +
            'Enterprises are scaling ' +
            '<span class="rotator" aria-hidden="true">' +
              '<span class="rotator-track">' +
                '<span>secure ML</span><span>AI agents</span><span>data science</span>' +
                '<span>private LLMs</span><span>secure ML</span><span>AI agents</span><span>data science</span>' +
              '</span>' +
            '</span>' +
            '<span class="visually-hidden">AI agents, data science, private LLMs and secure ML</span>' +
            ' with Calliope' +
          '</h2>' +
        '</div>' +
      '</section>';
  }

  function markup(page) {
    return '' +
      valleyRotator() +
      precta(page) +
      '<footer class="footer">' +
        '<div class="footer-hand-wrap" aria-hidden="true">' +
          '<img class="footer-hand" src="/img/calliope-img/3.png" alt="" loading="lazy" />' +
        '</div>' +
        '<div class="wrap footer-top">' +
          '<div class="footer-brand">' +
            '<a class="brand" href="/" aria-label="Calliope"><img class="brand-logo" src="/img/calliope%20logo.png" alt="Calliope" /></a>' +
            '<p>The private-AI studio. Own your AI, run it on your cloud — security and governance built in.</p>' +
            '<form class="lead-inline footer-form" data-lead-form data-source="footer">' +
              '<input type="email" name="email" required placeholder="you@company.com" aria-label="Work email" />' +
              '<button type="submit" class="btn btn-primary btn-sm">Subscribe</button>' +
            '</form>' +
            '<div class="footer-social" aria-label="Social links">' +
              '<a href="/#" aria-label="X (Twitter)"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24h-6.66l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231 5.45-6.231Zm-1.161 17.52h1.833L7.084 4.126H5.117L17.083 19.77Z" /></svg></a>' +
              '<a href="/#" aria-label="LinkedIn"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M20.45 20.45h-3.55v-5.57c0-1.33-.02-3.04-1.85-3.04-1.85 0-2.13 1.44-2.13 2.94v5.67H9.36V9h3.41v1.56h.05c.47-.9 1.64-1.85 3.37-1.85 3.6 0 4.27 2.37 4.27 5.46v6.28ZM5.34 7.43a2.06 2.06 0 1 1 0-4.12 2.06 2.06 0 0 1 0 4.12ZM7.12 20.45H3.56V9h3.56v11.45ZM22.22 0H1.77C.79 0 0 .77 0 1.73v20.54C0 23.22.79 24 1.77 24h20.45c.98 0 1.78-.78 1.78-1.73V1.73C24 .77 23.2 0 22.22 0Z" /></svg></a>' +
              '<a href="/#" aria-label="GitHub"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 .5C5.37.5 0 5.87 0 12.5c0 5.3 3.44 9.8 8.21 11.39.6.11.82-.26.82-.58l-.01-2.04c-3.34.73-4.04-1.61-4.04-1.61-.55-1.39-1.34-1.76-1.34-1.76-1.09-.75.08-.73.08-.73 1.2.08 1.84 1.24 1.84 1.24 1.07 1.84 2.81 1.31 3.5 1 .11-.78.42-1.31.76-1.61-2.67-.3-5.47-1.34-5.47-5.95 0-1.31.47-2.39 1.24-3.23-.12-.3-.54-1.52.12-3.18 0 0 1.01-.32 3.3 1.23a11.5 11.5 0 0 1 6 0c2.29-1.55 3.3-1.23 3.3-1.23.66 1.66.24 2.88.12 3.18.77.84 1.23 1.92 1.23 3.23 0 4.62-2.81 5.64-5.49 5.94.43.37.81 1.1.81 2.22l-.01 3.29c0 .32.21.7.82.58A12.01 12.01 0 0 0 24 12.5C24 5.87 18.63.5 12 .5Z" /></svg></a>' +
            '</div>' +
          '</div>' +
          '<div class="footer-cols">' +
            '<div><h4>Product</h4><a href="/product.html">The Hub</a><a href="/product-ide.html">AI IDE</a><a href="/deployment.html">Deploy · Astrolift</a><a href="/governance.html">Zentinelle GRC</a><a href="/security.html">Security</a><a href="/pricing.html">Pricing</a></div>' +
            '<div><h4>Solutions</h4><a href="/solutions.html">By use case</a><a href="/industries.html">By industry</a><a href="/industry-financial-services.html">Financial services</a><a href="/industry-healthcare-pharma.html">Healthcare</a><a href="/industry-government-defense.html">Gov &amp; Defense</a></div>' +
            '<div><h4>Resources</h4><a href="/#blueprint">Deployment blueprint</a><a href="/how-it-works.html">How it works</a><a href="/developer-resources.html">Documentation</a><a href="/support.html">Support</a><a href="/security.html">Security</a></div>' +
            '<div><h4>Company</h4><a href="/about.html">About</a><a href="/careers.html">Careers</a><a href="/blog.html">Blog</a><a href="/#demo">Book a demo</a><a href="/contact.html">Contact</a></div>' +
          '</div>' +
        '</div>' +
        '<div class="wrap footer-bottom">' +
          '<p>© 2026 Calliope Labs / CONFLICT · Miami, FL. All rights reserved.</p>' +
          '<nav class="footer-legal" aria-label="Legal">' +
            '<a href="/#">Privacy</a><a href="/#">Terms</a><a href="/#">Security</a><a href="/#">Status</a>' +
            '<span class="footer-region">🌐 Global</span>' +
          '</nav>' +
        '</div>' +
      '</footer>';
  }

  if (typeof window.HTMLElement === 'function') {
    var SiteFooter = class extends HTMLElement {
      connectedCallback() { this.innerHTML = markup(this.getAttribute('data-page') || 'home'); }
    };
    if (!customElements.get('site-footer')) {
      customElements.define('site-footer', SiteFooter);
    }
  }
})();
