/* Shared site navigation — one component for every page.
   Usage: <site-header data-active="product|governance|solutions|pricing"></site-header>
   Renders into light DOM so the existing script.js handlers (#hamburger,
   #searchBtn, #announce, …) bind exactly as before. */
(function () {
  var CHEVRON =
    '<svg class="caret" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M6 9l6 6 6-6"/></svg>';

  /* The trigger is a real link to the section hub so it works for keyboard and
     screen-reader users (the mega panel is a hover/pointer enhancement). */
  function mega(label, key, hubHref, inner, active) {
    var cls = 'nav-item has-mega' + (active === key ? ' is-active' : '');
    var curr = active === key ? ' aria-current="page"' : '';
    return (
      '<div class="' + cls + '" data-nav="' + key + '">' +
        '<a class="nav-link" href="' + hubHref + '"' + curr + '>' + label + ' ' + CHEVRON + '</a>' +
        '<div class="mega">' + inner + '</div>' +
      '</div>'
    );
  }

  var PRODUCT_INNER =
    '<div class="wrap mega-grid">' +
      '<div class="mega-col"><h4>Build · The Hub</h4>' +
        '<a href="/product-ai-lab.html">AI Lab</a><a href="/product-ide.html">AI IDE</a><a href="/product-chat-studio.html">Chat Studio</a>' +
        '<a href="/product-deep-agent.html">Deep Agent</a><a href="/product-langflow.html">Langflow</a><a href="/product-browser.html">Secure Browser</a></div>' +
      '<div class="mega-col"><h4>Core building blocks</h4>' +
        '<a href="/product-agents.html">Agents</a><a href="/product-agent-coding.html">Agent Coding</a><a href="/product-code-assist.html">Code Assist</a>' +
        '<a href="/product-data-agents.html">Data Agents</a><a href="/product-datasets.html">Datasets</a><a href="/product-model-hosting.html">Model Hosting</a>' +
        '<a href="/product-notebook-chat.html">Notebook Chat</a><a href="/product-notebook-generation.html">Notebook Generation</a><a href="/product-prompt-engineering.html">Prompt Engineering</a></div>' +
      '<div class="mega-col"><h4>Run · Astrolift</h4>' +
        '<a href="/deployment-cloud-hosted.html">Cloud Hosted</a><a href="/deployment-dedicated-cloud.html">Dedicated Cloud</a><a href="/deployment-jump-server.html">VPC Gateway</a>' +
        '<a href="/deployment-on-premise.html">On-prem / Air-gapped</a><a href="/deployment-desktop.html">Download Desktop</a></div>' +
      '<div class="mega-col mega-feature"><h4>What\'s new</h4>' +
        '<a href="/#blueprint" class="mega-card"><span class="mega-card-tag">Free guide</span>' +
        '<span class="mega-card-title">Private-AI Deployment Blueprint</span>' +
        '<span class="mega-card-desc">Reference architecture + GRC checklist.</span></a></div>' +
    '</div>' +
    '<a href="/product.html" class="mega-cta wrap-cta"><span>See the full platform — 19 tools, one workspace</span><span class="mega-cta-go">Explore the Hub →</span></a>';

  var GOV_INNER =
    '<div class="wrap mega-grid mega-grid--2">' +
      '<div class="mega-col"><h4>Govern · Zentinelle</h4>' +
        '<a href="/governance.html">GRC overview</a><a href="/governance-audit.html">Audit &amp; Observability</a><a href="/governance-policies.html">Policy management</a>' +
        '<a href="/governance-risk.html">Risk management</a><a href="/governance-compliance.html">Compliance frameworks</a><a href="/governance-content-scanning.html">Content scanning</a>' +
        '<a href="/governance-secrets.html">Secrets &amp; credentials</a></div>' +
      '<div class="mega-col"><h4>Security</h4>' +
        '<a href="/security.html">Security overview</a><a href="/security-architecture.html">Security architecture</a>' +
        '<a href="/security-data-protection.html">Data protection</a><a href="/security-compliance.html">Compliance &amp; certifications</a></div>' +
      '<div class="mega-col mega-feature"><h4>Outcome</h4>' +
        '<a href="/deployment.html" class="mega-card"><span class="mega-card-tag">Deploy anywhere</span>' +
        '<span class="mega-card-title">Runs in your account</span>' +
        '<span class="mega-card-desc">Cloud, on-prem, or air-gapped — your data never egresses.</span></a></div>' +
    '</div>';

  var SOL_INNER =
    '<div class="wrap mega-grid mega-grid--2">' +
      '<div class="mega-col"><h4>By use case</h4>' +
        '<a href="/solution-agent-platforms.html">Agent platforms</a><a href="/solution-ai-applications.html">AI applications</a><a href="/solution-chatbots.html">Chatbots</a>' +
        '<a href="/solution-data-exploration.html">Data exploration</a><a href="/solution-internal-automation.html">Internal automation</a><a href="/solution-knowledge-base.html">Knowledge base</a>' +
        '<a href="/solution-research-tools.html">Research tools</a></div>' +
      '<div class="mega-col"><h4>By industry</h4>' +
        '<a href="/industries.html">All industries</a><a href="/industry-financial-services.html">Financial services</a><a href="/industry-healthcare-pharma.html">Healthcare &amp; pharma</a><a href="/industry-government-defense.html">Government &amp; defense</a>' +
        '<a href="/industry-energy-utilities.html">Energy &amp; utilities</a><a href="/industry-life-sciences.html">Life sciences &amp; biotech</a><a href="/industry-manufacturing.html">Manufacturing</a>' +
        '<a href="/industry-research-academia.html">Research &amp; academia</a><a href="/industry-climate-environment.html">Climate &amp; environment</a></div>' +
      '<div class="mega-col mega-feature"><h4>Get started</h4>' +
        '<a href="/#demo" class="mega-card"><span class="mega-card-tag">30 min</span>' +
        '<span class="mega-card-title">Book a private demo</span>' +
        '<span class="mega-card-desc">A walkthrough with an engineer — not a sales script.</span></a></div>' +
    '</div>';

  var RES_INNER =
    '<div class="wrap mega-grid mega-grid--2">' +
      '<div class="mega-col"><h4>Learn</h4>' +
        '<a href="/how-it-works.html">How it works</a><a href="/#blueprint">Deployment blueprint</a><a href="/developer-resources.html">Developer resources</a><a href="/support.html">Support</a><a href="/blog.html">Blog</a></div>' +
      '<div class="mega-col"><h4>Company</h4>' +
        '<a href="/about.html">About Calliope</a><a href="/team.html">Team</a><a href="/careers.html">Careers</a><a href="/contact.html">Contact</a></div>' +
      '<div class="mega-col mega-feature"><h4>Get the guide</h4>' +
        '<a href="/#blueprint" class="mega-card"><span class="mega-card-tag">Free PDF</span>' +
        '<span class="mega-card-title">Deployment Blueprint</span>' +
        '<span class="mega-card-desc">Self-host enterprise AI in days, not 18 months.</span></a></div>' +
    '</div>';

  function markup(active) {
    var cur = function (k) { return active === k ? ' aria-current="page"' : ''; };
    return '' +
      '<a class="skip-link" href="#main">Skip to content</a>' +
      '<div class="topbar">' +
        '<div class="announce" id="announce">' +
          '<span>Onboarding a limited number of private deployments this quarter.</span>' +
          '<a href="/#demo" class="announce-link">Request access&nbsp;→</a>' +
          '<button class="announce-close" aria-label="Dismiss" data-close-announce>&times;</button>' +
        '</div>' +
        '<header class="header" id="header">' +
          '<div class="wrap header-inner">' +
            '<a class="brand" href="/" aria-label="Calliope"><img class="brand-logo" src="/img/calliope%20logo.png" alt="Calliope" /></a>' +
            '<nav class="nav" aria-label="Primary">' +
              mega('Product', 'product', '/product.html', PRODUCT_INNER, active) +
              mega('Governance', 'governance', '/governance.html', GOV_INNER, active) +
              mega('Solutions', 'solutions', '/solutions.html', SOL_INNER, active) +
              '<a class="nav-link nav-link--solo" href="/pricing.html"' + cur('pricing') + '>Pricing</a>' +
              mega('Resources', 'resources', '/#blueprint', RES_INNER, active) +
            '</nav>' +
            '<div class="header-cta">' +
              '<button class="search-btn" id="searchBtn" aria-label="Search" title="Search (⌘K)">' +
                '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><circle cx="11" cy="11" r="7"/><line x1="21" y1="21" x2="16.5" y2="16.5"/></svg>' +
              '</button>' +
              '<a href="/#login" class="nav-link nav-link--solo">Sign in</a>' +
              '<a href="/#demo" class="btn btn-primary btn-sm">Book a demo</a>' +
              '<button class="hamburger" id="hamburger" aria-label="Menu" aria-expanded="false"><span></span><span></span><span></span></button>' +
            '</div>' +
          '</div>' +
          '<div class="mobile-menu" id="mobileMenu">' +
            '<a href="/product.html">Product</a>' +
            '<a href="/governance.html">Governance</a>' +
            '<a href="/solutions.html">Solutions</a>' +
            '<a href="/pricing.html">Pricing</a>' +
            '<a href="/#blueprint">Resources</a>' +
            '<a href="/#login">Sign in</a>' +
            '<a href="/#demo" class="btn btn-primary btn-block">Book a demo</a>' +
          '</div>' +
        '</header>' +
      '</div>';
  }

  if (typeof window.HTMLElement === 'function') {
    var SiteHeader = class extends HTMLElement {
      connectedCallback() {
        this.innerHTML = markup(this.getAttribute('data-active') || '');
      }
    };
    if (!customElements.get('site-header')) {
      customElements.define('site-header', SiteHeader);
    }
  }
})();
