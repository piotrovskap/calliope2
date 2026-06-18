/* Shared site navigation — one component for every page.
   Structure mirrors calliope.ai (Platform / Industries / Solutions / Deployment /
   Security megas + How It Works & Support links, utility bar with About / Pricing /
   Blog / Contact / Log In / Download), rendered in our design-system style.
   Usage: <site-header data-active="platform|industries|solutions|deployment|security"></site-header> */
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

  var FEATURE_CARD =
    '<div class="mega-col mega-feature"><h4>Get started</h4>' +
      '<a href="/#demo" class="mega-card"><span class="mega-card-tag">30 min</span>' +
      '<span class="mega-card-title">Book a private demo</span>' +
      '<span class="mega-card-desc">A walkthrough with an engineer — not a sales script.</span></a></div>';

  var PLATFORM_INNER =
    '<div class="wrap mega-grid">' +
      '<div class="mega-col"><h4>Platform</h4>' +
        '<a href="/product.html">The Workbench</a><a href="/product-integrations.html">Integrations</a></div>' +
      '<div class="mega-col"><h4>Tools</h4>' +
        '<a href="/product-agterm.html">AGTerm — AI Terminal</a><a href="/product-ide.html">Calliope AI IDE</a><a href="/product-chat-studio.html">Chat Studio</a>' +
        '<a href="/product-deep-agent.html">Deep Data Agent</a><a href="/product-browser.html">Web Browser</a></div>' +
      '<div class="mega-col"><h4>Tools</h4>' +
        '<a href="/product-desktop.html">Calliope AI Desktop</a><a href="/product-ai-lab.html">Calliope AI Lab</a><a href="/product-db-loadr.html">DB Loadr — Database Studio</a>' +
        '<a href="/product-file-manager.html">File Manager</a></div>' +
      '<div class="mega-col mega-feature"><h4>What\'s new</h4>' +
        '<a href="/#blueprint" class="mega-card"><span class="mega-card-tag">Free guide</span>' +
        '<span class="mega-card-title">Private-AI Deployment Blueprint</span>' +
        '<span class="mega-card-desc">Reference architecture + GRC checklist.</span></a></div>' +
    '</div>' +
    '<a href="/product.html" class="mega-cta wrap-cta"><span>Purpose-built tools plus curated add-ons — one secured Workbench</span><span class="mega-cta-go">Explore the platform →</span></a>';

  var INDUSTRIES_INNER =
    '<div class="wrap mega-grid mega-grid--2">' +
      '<div class="mega-col"><h4>Industries</h4>' +
        '<a href="/industries.html">Industries Overview</a><a href="/industry-climate-environment.html">Climate &amp; Environmental Science</a><a href="/industry-energy-utilities.html">Energy, Utilities &amp; Oil/Gas</a>' +
        '<a href="/industry-financial-services.html">Financial Services</a><a href="/industry-government-defense.html">Government &amp; Defense</a></div>' +
      '<div class="mega-col"><h4>&nbsp;</h4>' +
        '<a href="/industry-healthcare-pharma.html">Healthcare &amp; Pharma</a><a href="/industry-life-sciences.html">Life Sciences &amp; Biotech</a><a href="/industry-manufacturing.html">Manufacturing</a>' +
        '<a href="/industry-research-academia.html">Research &amp; Academia</a></div>' +
      FEATURE_CARD +
    '</div>';

  var SOLUTIONS_INNER =
    '<div class="wrap mega-grid mega-grid--2">' +
      '<div class="mega-col"><h4>Solutions</h4>' +
        '<a href="/solutions.html">Solutions Overview</a><a href="/solution-agent-platforms.html">Agent Platforms</a><a href="/solution-ai-applications.html">AI Applications</a></div>' +
      '<div class="mega-col"><h4>&nbsp;</h4>' +
        '<a href="/solution-data-exploration.html">Data Exploration</a><a href="/solution-internal-automation.html">Internal Automation</a><a href="/solution-research-tools.html">Research Tools</a></div>' +
      FEATURE_CARD +
    '</div>';

  var DEPLOYMENT_INNER =
    '<div class="wrap mega-grid mega-grid--2">' +
      '<div class="mega-col"><h4>Deployment</h4>' +
        '<a href="/deployment.html">Deployment Overview</a><a href="/deployment-cloud-hosted.html">Cloud Hosted</a><a href="/deployment-dedicated-cloud.html">Dedicated Cloud</a>' +
        '<a href="/deployment-desktop.html">Desktop App</a></div>' +
      '<div class="mega-col"><h4>&nbsp;</h4>' +
        '<a href="/deployment-jump-server.html">Jump Server / VPC Gateway</a><a href="/deployment-on-premise.html">On-Premise / Air-Gapped</a></div>' +
      FEATURE_CARD +
    '</div>';

  var SECURITY_INNER =
    '<div class="wrap mega-grid mega-grid--2">' +
      '<div class="mega-col"><h4>Security</h4>' +
        '<a href="/security.html">Security Overview</a><a href="/security-compliance.html">Compliance &amp; Certifications</a><a href="/security-data-protection.html">Data Protection</a></div>' +
      '<div class="mega-col"><h4>&nbsp;</h4>' +
        '<a href="/governance-secrets.html">Secrets Management</a><a href="/security-architecture.html">Security Architecture</a></div>' +
      FEATURE_CARD +
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
        '<div class="utilbar">' +
          '<div class="wrap utilbar-inner">' +
            '<nav class="util-nav" aria-label="Secondary">' +
              '<div class="util-dd">' +
                '<a class="util-link" href="/about.html">About ' + CHEVRON + '</a>' +
                '<div class="util-menu">' +
                  '<a href="/about.html">About Calliope</a><a href="/developer-resources.html">Developer Resources</a>' +
                  '<a href="/team.html">Team</a><a href="/careers.html">Careers</a>' +
                '</div>' +
              '</div>' +
              '<a class="util-link" href="/pricing.html">Pricing</a>' +
              '<a class="util-link" href="/blog.html">Blog</a>' +
              '<a class="util-link" href="/contact.html">Contact</a>' +
              '<span class="util-sep"></span>' +
              '<a class="util-link" href="/#login">Log In</a>' +
              '<a class="util-download" href="/deployment-desktop.html">Download</a>' +
            '</nav>' +
          '</div>' +
        '</div>' +
        '<header class="header" id="header">' +
          '<div class="wrap header-inner">' +
            '<a class="brand" href="/" aria-label="Calliope"><img class="brand-logo" src="/img/calliope%20logo.png" alt="Calliope" /></a>' +
            '<nav class="nav" aria-label="Primary">' +
              '<a class="nav-link nav-link--solo" href="/how-it-works.html"' + cur('how') + '>How It Works</a>' +
              mega('Platform', 'platform', '/product.html', PLATFORM_INNER, active) +
              mega('Industries', 'industries', '/industries.html', INDUSTRIES_INNER, active) +
              mega('Solutions', 'solutions', '/solutions.html', SOLUTIONS_INNER, active) +
              mega('Deployment', 'deployment', '/deployment.html', DEPLOYMENT_INNER, active) +
              mega('Security', 'security', '/security.html', SECURITY_INNER, active) +
              '<a class="nav-link nav-link--solo" href="/support.html"' + cur('support') + '>Support</a>' +
            '</nav>' +
            '<div class="header-cta">' +
              '<button class="search-btn" id="searchBtn" aria-label="Search" title="Search (⌘K)">' +
                '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><circle cx="11" cy="11" r="7"/><line x1="21" y1="21" x2="16.5" y2="16.5"/></svg>' +
              '</button>' +
              '<a href="/#demo" class="btn btn-primary btn-sm">Book a demo</a>' +
              '<button class="hamburger" id="hamburger" aria-label="Menu" aria-expanded="false"><span></span><span></span><span></span></button>' +
            '</div>' +
          '</div>' +
          '<div class="mobile-menu" id="mobileMenu">' +
            '<a href="/how-it-works.html">How It Works</a>' +
            '<a href="/product.html">Platform</a>' +
            '<a href="/industries.html">Industries</a>' +
            '<a href="/solutions.html">Solutions</a>' +
            '<a href="/deployment.html">Deployment</a>' +
            '<a href="/security.html">Security</a>' +
            '<a href="/support.html">Support</a>' +
            '<a href="/about.html">About</a>' +
            '<a href="/pricing.html">Pricing</a>' +
            '<a href="/blog.html">Blog</a>' +
            '<a href="/contact.html">Contact</a>' +
            '<a href="/#login">Log In</a>' +
            '<a href="/deployment-desktop.html" class="btn btn-primary btn-block">Download</a>' +
            '<a href="/#demo" class="btn btn-ghost btn-block">Book a demo</a>' +
          '</div>' +
        '</header>' +
      '</div>' +
      '<div class="search-overlay" id="searchOverlay" hidden>' +
        '<div class="search-box" role="dialog" aria-modal="true" aria-label="Search Calliope">' +
          '<div class="search-input-row">' +
            '<svg class="search-ico" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><circle cx="11" cy="11" r="7" /><line x1="21" y1="21" x2="16.5" y2="16.5" /></svg>' +
            '<input id="searchInput" type="text" placeholder="Search Calliope — products, deploy, governance…" autocomplete="off" spellcheck="false" />' +
            '<kbd class="search-esc">Esc</kbd>' +
          '</div>' +
          '<ul class="search-results" id="searchResults" role="listbox"></ul>' +
        '</div>' +
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
