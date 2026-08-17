(() => {
  // Shared radio-card component contract used by tools and instance sizes.
  const bindRadioCards = (cards) => cards.forEach((card) => {
    card.classList.add('radio-card');
    if (card.classList.contains('instance-option')) card.classList.add('environment-card');
    card.setAttribute('role', 'radio');
    card.setAttribute('aria-checked', String(card.classList.contains('selected')));
    if (card.disabled) card.setAttribute('aria-disabled', 'true');
  });
  const themeOptions = [...document.querySelectorAll('.theme-option')];
  const savedTheme = localStorage.getItem('calliope-theme') || 'dark';
  const applyTheme = (theme) => {
    document.documentElement.dataset.theme = theme;
    themeOptions.forEach((option) => {
      const active = option.dataset.themeValue === theme;
      option.classList.toggle('active', active);
      option.setAttribute('aria-pressed', String(active));
    });
  };
  applyTheme(savedTheme);
  themeOptions.forEach((option) => option.addEventListener('click', () => {
    localStorage.setItem('calliope-theme', option.dataset.themeValue);
    applyTheme(option.dataset.themeValue);
  }));

  // Nav view switching: Workbench flow  <->  Active environments  <->  Tokens
  const createLayout = document.querySelector('.create-layout');
  const navWorkbench = document.querySelector('.site-nav a[href="/hub"]');
  const navActiveEnv = document.querySelector('.nav-active-env');
  const navTokens = document.querySelector('.site-nav a[href="#tokens"]');
  const setWorkbenchView = (view) => {
    createLayout.classList.toggle('view-active', view === 'active');
    createLayout.classList.toggle('view-tokens', view === 'tokens');
    if (navWorkbench) {
      navWorkbench.classList.toggle('active', view === 'workbench');
      navWorkbench.setAttribute('aria-current', view === 'workbench' ? 'page' : 'false');
    }
    if (navActiveEnv) navActiveEnv.classList.toggle('active', view === 'active');
    if (navTokens) navTokens.classList.toggle('active', view === 'tokens');
    window.scrollTo({ top: 0, behavior: 'smooth' });
  };
  navActiveEnv?.addEventListener('click', (event) => { event.preventDefault(); setWorkbenchView('active'); });
  navTokens?.addEventListener('click', (event) => { event.preventDefault(); setWorkbenchView('tokens'); });
  navWorkbench?.addEventListener('click', (event) => { event.preventDefault(); setWorkbenchView('workbench'); });

  const steps = [...document.querySelectorAll('[data-flow-step]')];
  const methods = [...document.querySelectorAll('.method')];
  const integrationsTabLabel = document.querySelector('[data-category="integrations"]');
  if (integrationsTabLabel) integrationsTabLabel.textContent = 'Integrations';
  document.querySelectorAll('.environment-card strong').forEach((label) => {
    if (label.textContent.trim() === 'DB Loadr') label.textContent = 'DB Load';
    if (label.textContent.trim() === 'AFFiNE') label.textContent = 'AFFINE';
  });
  const toolIcons = {
    'AgTerm Web': 'terminal-window', 'AI IDE': 'code', 'AI Lab': 'flask', 'Chat Studio': 'chats',
    'DB Load': 'database', 'Deep Data Agent': 'stack', Desktop: 'monitor', 'File Manager': 'folder',
    'Web Browser': 'globe', 'Agent Sandbox': 'sparkle', 'Agent Coding': 'code-simple',
    'Agent + Browser': 'browsers', 'Agent + Desktop': 'desktop', 'Agent + Terminal': 'terminal',
    'Fossil Repo': 'git-branch', Scuttlebot: 'robot', AFFINE: 'squares-four', Etherpad: 'note-pencil',
    Evidence: 'chart-line-up', Flowise: 'share-network', 'Label Studio': 'check-square', Langflow: 'flow-arrow',
    MLflow: 'layers', Superset: 'chart-line', Voila: 'notebook'
  };
  const applyToolIcons = () => document.querySelectorAll('.environment-card').forEach((card) => {
    const name = card.querySelector('strong')?.textContent.trim();
    const iconName = toolIcons[name];
    if (!iconName) return;
    const icon = card.querySelector('.env-icon');
    if (icon) icon.innerHTML = `<i class="ph ph-${iconName}" aria-hidden="true"></i>`;
  });
  applyToolIcons();
  const next = document.querySelector('[data-continue]');
  const back = document.querySelector('[data-back]');
  const launchState = document.querySelector('[data-launch-state]');
  const panelActions = document.querySelector('.panel-actions');
  const flowStepCopy = document.querySelector('.flow-step-copy');
  const label = document.querySelector('[data-step-label]');
  let current = 1;
  let selectedCategory = null;
  let selectedTool = null;
  let selectedInstance = null;
  let selectedFlavor = null;
  const categoryStep = steps[0];
  const environmentStep = steps.find((step) => step.dataset.flowStep === '1');
  const instanceStep = steps.find((step) => step.dataset.flowStep === '2');
  instanceStep.dataset.flowStep = '3';
  const flavorStep = document.createElement('div');
  flavorStep.className = 'flow-step';
  flavorStep.dataset.flowStep = '2';
  flavorStep.innerHTML = '<div class="section-title">Choose desktop flavor</div><p class="section-description">Select the desktop environment for your workspace.</p><div class="environment-grid desktop-flavor-options" role="radiogroup" aria-label="Desktop flavor"><button class="environment-card flavor-option" type="button" data-flavor="debian"><span class="env-icon"><i class="ph ph-linux-logo"></i></span><span class="radio"></span><strong>Debian</strong><p>Stable Linux desktop environment.</p></button><button class="environment-card flavor-option" type="button" data-flavor="ubuntu"><span class="env-icon"><i class="ph ph-ubuntu-logo"></i></span><span class="radio"></span><strong>Ubuntu</strong><p>Popular general-purpose desktop.</p></button><button class="environment-card flavor-option" type="button" data-flavor="devops"><span class="env-icon"><i class="ph ph-wrench"></i></span><span class="radio"></span><strong>DevOps</strong><p>Tools for development and operations.</p></button><button class="environment-card flavor-option" type="button" data-flavor="kali"><span class="env-icon"><i class="ph ph-shield-check"></i></span><span class="radio"></span><strong>Kali</strong><p>Security-focused Linux environment.</p></button><button class="environment-card flavor-option" type="button" data-flavor="re"><span class="env-icon"><i class="ph ph-terminal-window"></i></span><span class="radio"></span><strong>Re</strong><p>Lightweight workspace configuration.</p></button><button class="environment-card flavor-option" type="button" data-flavor="openclaw"><span class="env-icon"><i class="ph ph-robot"></i></span><span class="radio"></span><strong>Openclaw</strong><p>AI-ready desktop environment.</p></button></div>';
  instanceStep.before(flavorStep);
  steps.splice(1, 0, flavorStep);
  const sizeOptions = [...instanceStep.querySelectorAll('.instance-option')];
  const sizeGroups = {
    tiny: 'small', 'x-small': 'small', small: 'small',
    medium: 'medium', 'm-large': 'medium', 'c-large': 'medium',
    large: 'large', 'c-xlarge': 'large', 'm-xlarge': 'large', xlarge: 'large',
    'c-2xlarge': 'large', 'm-2xlarge': 'large', 'm-4xlarge': 'large'
  };
  sizeOptions.forEach((option) => { option.dataset.sizeGroup = sizeGroups[option.dataset.instance] || 'small'; });
  const instanceTabs = document.createElement('div');
  instanceTabs.className = 'environment-tabs';
  instanceTabs.setAttribute('role', 'tablist');
  ['all', 'small', 'medium', 'large'].forEach((group) => {
    const tab = document.createElement('button');
    tab.className = `environment-tab${group === 'all' ? ' active' : ''}`;
    tab.type = 'button';
    tab.dataset.sizeGroup = group;
    tab.setAttribute('role', 'tab');
    tab.setAttribute('aria-selected', String(group === 'all'));
    tab.textContent = group === 'all' ? 'All' : group[0].toUpperCase() + group.slice(1);
    instanceTabs.append(tab);
  });
  instanceStep.querySelector('.instance-options').before(instanceTabs);
  const instanceGroupHeadings = {};
  instanceTabs.querySelectorAll('.environment-tab').forEach((tab) => tab.addEventListener('click', () => {
    const group = tab.dataset.sizeGroup;
    instanceTabs.querySelectorAll('.environment-tab').forEach((item) => {
      const active = item === tab;
      item.classList.toggle('active', active);
      item.setAttribute('aria-selected', String(active));
    });
    sizeOptions.forEach((option) => {
      const hidden = group !== 'all' && option.dataset.sizeGroup !== group;
      option.hidden = hidden;
      option.style.setProperty('display', hidden ? 'none' : 'grid', 'important');
    });
    Object.values(instanceGroupHeadings).forEach((heading) => heading.style.setProperty('display', group === 'all' ? 'block' : 'none', 'important'));
    if (selectedInstance && sizeOptions.find((option) => option.dataset.instance === selectedInstance)?.hidden) {
      selectedInstance = null;
      sizeOptions.forEach((option) => option.classList.remove('selected'));
      render();
    }
  }));
  environmentStep.querySelector('.section-title')?.remove();
  environmentStep.querySelector('.section-description')?.remove();
  const originalPanels = [...document.querySelectorAll('[data-panel]')];
  const agentPanel = originalPanels.find((panel) => panel.dataset.panel === 'agents');
  if (agentPanel) {
    const agentTools = [
      ['◉', 'Agent + Browser', 'AI coding agent with a Chromium browser and live terminal.', ''],
      ['▣', 'Agent + Desktop', 'Full Debian desktop with an AI coding agent — Claude, Codex, or Gemini.', ''],
      ['>_', 'Agent + Terminal', 'AI coding agent with a noVNC terminal — Claude, Codex, or Gemini.', ''],
      ['⌘', 'Fossil Repo', 'Fossil SCM source control with GitHub sync and issue tracking.', 'Singleton'],
      ['▤', 'Scuttlebot', 'AI agent coordination backplane — IRC-based real-time oversight.', 'Singleton']
    ];
    agentPanel.replaceChildren(...agentTools.map(([icon, name, description, badge]) => {
      const card = document.createElement('button');
      card.className = 'environment-card';
      card.innerHTML = `${badge ? `<span class="featured">${badge}</span>` : ''}<span class="env-icon">${icon}</span><span class="radio"></span><strong>${name}</strong><p>${description}</p>`;
      return card;
    }));
  }
  applyToolIcons();
  document.querySelectorAll('.environment-card .featured').forEach((badge) => badge.remove());
  const environmentTabs = [...document.querySelectorAll('.environment-tab[data-category]')];
  const environmentHint = document.querySelector('.environment-hint');
  const environmentTitle = categoryStep.querySelector('.environment-head h2');
  const environmentSubtitle = categoryStep.querySelector('.environment-head p');
  const flowHeading = document.querySelector('.flow-step-copy h2');
  const flowSummary = document.querySelector('.flow-step-copy .flow-step-description');
  const environmentBody = document.createElement('div');
  environmentBody.className = 'environment-selection-body';
  environmentBody.replaceChildren();
  originalPanels.forEach((panel) => environmentBody.append(panel));
  const categoryLabels = { core: 'Core Tools', agents: 'Agentic Engineering', integrations: 'Integrations' };
  const allPanel = document.createElement('div');
  allPanel.className = 'all-environments-panel hidden-panel';
  allPanel.dataset.panel = 'all';
  originalPanels.forEach((panel) => {
    const cards = [...panel.querySelectorAll('.environment-card')]
      .sort((a, b) => a.querySelector('strong').textContent.localeCompare(b.querySelector('strong').textContent));
    if (!cards.length) return;
    const section = document.createElement('div');
    section.className = 'all-env-section';
    const heading = document.createElement('h3');
    heading.className = 'all-env-category';
    heading.textContent = categoryLabels[panel.dataset.panel] || panel.dataset.panel;
    const grid = document.createElement('div');
    grid.className = 'environment-grid';
    cards.forEach((card) => grid.append(card.cloneNode(true)));
    section.append(heading, grid);
    allPanel.append(section);
  });
  environmentBody.append(allPanel);
  categoryStep.append(environmentBody);
  let renderedCurrent = null;
  const render = () => { const stepChanged = renderedCurrent !== null && renderedCurrent !== current; steps.forEach((s) => { const active = Number(s.dataset.flowStep) === current; s.classList.toggle('active', active); s.style.setProperty('display', active ? 'block' : 'none', 'important'); if (active && stepChanged) { s.classList.remove('step-enter-from-bottom'); requestAnimationFrame(() => { s.classList.add('step-enter-from-bottom'); window.setTimeout(() => s.classList.remove('step-enter-from-bottom'), 260); }); } }); renderedCurrent = current; label.textContent = String(current).padStart(2, '0'); back.textContent = current === 1 ? 'Cancel' : 'Back'; next.innerHTML = current === 3 ? 'Launch Lab <span>↗</span>' : 'Continue <span>→</span>'; next.disabled = current === 1 ? !selectedTool : current === 2 ? !selectedFlavor : !selectedInstance; const tooltip = document.querySelector('.continue-tooltip'); if (tooltip) tooltip.textContent = current === 1 ? 'Choose a tool to continue.' : current === 2 ? 'Choose a desktop flavor to continue.' : 'Choose an instance size to continue.'; const stepCopy = current === 2 ? ['Choose desktop flavor', 'Select the desktop environment for your workspace.'] : current === 3 ? ['Select instance size', 'Adjust resources based on your workload needs.'] : ['Choose your environment', 'Pick the workspace that fits your goals, adjust instance size, and launch.']; if (flowHeading) flowHeading.textContent = stepCopy[0]; if (flowSummary) flowSummary.textContent = stepCopy[1]; if (environmentTitle) environmentTitle.textContent = stepCopy[0]; if (environmentSubtitle) environmentSubtitle.textContent = stepCopy[1]; if (current === 3 && selectedCategory) { originalPanels.forEach((panel) => panel.classList.toggle('hidden-panel', panel.dataset.panel !== selectedCategory)); } };
  document.querySelectorAll('.instance-option:not(:disabled)').forEach((option) => option.addEventListener('click', () => {
    document.querySelectorAll('.instance-option').forEach((item) => {
      item.classList.toggle('selected', item === option);
      item.setAttribute('aria-checked', String(item === option));
    });
    selectedInstance = option.dataset.instance;
    render();
  }));
  methods.forEach((method) => method.addEventListener('click', () => { const group = method.closest('.method-grid,.method-list'); group.querySelectorAll('.method').forEach((m) => m.classList.remove('selected')); method.classList.add('selected'); }));
  document.querySelectorAll('.instance-option').forEach((option) => option.classList.remove('selected'));
  document.querySelectorAll('.instance-option').forEach((option) => {
    const details = option.querySelector(':scope > span:not(.instance-radio)');
    const radio = option.querySelector('.instance-radio');
    if (!details || !radio) return;
    const icon = document.createElement('span');
    icon.className = 'env-icon';
    icon.innerHTML = '<i class="ph ph-cpu" aria-hidden="true"></i>';
    radio.className = 'radio';
    const title = details.querySelector('strong');
    const description = document.createElement('p');
    const instanceDescriptions = {
      'X-Small (Chat Basic)': 'Minimal chat configuration - UI + basic data agent',
      'Small (Chat Standard)': 'Standard chat configuration - Enhanced data processing',
      'Medium (Minimum)': 'Minimum configuration - Light workloads only',
      'M-Large': 'Data processing with high memory requirements.',
      'C-Large': 'CPU-intensive workloads with high compute power',
      'Large': 'Balanced performance - Recommended for most users',
      'C-XLarge': 'High parallel processing power',
      'M-XLarge': 'Large datasets and in-memory processing',
      'XLarge': 'Intensive tasks and very large datasets',
      'C-2XLarge': 'Maximum Fargate compute power for demanding applications',
      'M-2XLarge': 'Very large in-memory datasets',
      'M-4XLarge': 'Maximum Fargate memory for big data applications'
    };
    description.textContent = instanceDescriptions[title?.textContent.trim()] || details.querySelector('small')?.textContent || '';
    option.replaceChildren(icon, radio, title, description);
  });
  const instanceOrder = ['tiny', 'x-small', 'small', 'medium', 'm-large', 'c-large', 'large', 'c-xlarge', 'm-xlarge', 'xlarge', 'c-2xlarge', 'm-2xlarge', 'm-4xlarge'];
  const instanceOptions = document.querySelector('.instance-options');
  if (instanceOptions) {
    const sortedInstances = [...instanceOptions.querySelectorAll('.instance-option')].sort((a, b) => instanceOrder.indexOf(a.dataset.instance) - instanceOrder.indexOf(b.dataset.instance));
    instanceOptions.replaceChildren(...sortedInstances);
    const sizeGroupLabels = { small: 'Small', medium: 'Medium', large: 'Large' };
    let lastSizeGroup = null;
    [...instanceOptions.querySelectorAll('.instance-option')].forEach((option) => {
      const group = option.dataset.sizeGroup;
      if (group === lastSizeGroup) return;
      const heading = document.createElement('div');
      heading.className = 'instance-group-heading';
      heading.dataset.sizeGroup = group;
      heading.textContent = sizeGroupLabels[group] || group;
      instanceOptions.insertBefore(heading, option);
      instanceGroupHeadings[group] = heading;
      lastSizeGroup = group;
    });
  }
  const tabBar = document.querySelector('.environment-tabs');
  const allTab = document.createElement('button');
  allTab.className = 'environment-tab all-tab';
  allTab.dataset.category = 'all';
  allTab.textContent = 'All';
  tabBar.prepend(allTab);
  const tabs = [...document.querySelectorAll('.environment-tab[data-category]')];
  const panels = [...document.querySelectorAll('[data-panel]')];
  const setPanelVisibility = (category) => {
    panels.forEach((panel) => {
      const visible = panel.dataset.panel === category;
      panel.classList.toggle('hidden-panel', !visible);
      panel.setAttribute('aria-hidden', String(!visible));
    });
  };
  selectedCategory = 'all';
  tabs.forEach((tab) => { tab.classList.toggle('active', tab.dataset.category === 'all'); tab.setAttribute('aria-selected', tab.dataset.category === 'all' ? 'true' : 'false'); });
  setPanelVisibility('all');
  document.querySelectorAll('.environment-card').forEach((card) => card.classList.remove('selected'));
  selectedTool = null;
  const hint = document.createElement('div');
  hint.className = 'environment-hint';
  hint.innerHTML = '<span>Choose one environment</span><span data-selection-hint>AI Lab selected</span>';
  document.querySelector('.environment-tabs').after(hint);
  const choiceHelp = document.createElement('p');
  choiceHelp.className = 'choice-help';
  choiceHelp.innerHTML = 'Not sure what to choose? <a href="/contact.html">Talk to our team</a>.';
  document.querySelector('.workbench-description').after(choiceHelp);
  tabs.forEach((tab) => {
    const panel = document.querySelector(`[data-panel="${tab.dataset.category}"]`);
    const count = document.createElement('span');
    count.className = 'tab-count';
    count.textContent = panel ? panel.querySelectorAll('.environment-card').length : '';
    tab.append(count);
    tab.setAttribute('role', 'tab');
    tab.setAttribute('aria-selected', tab.classList.contains('active') ? 'true' : 'false');
    tab.addEventListener('click', () => {
      const nextCategory = tab.dataset.category;
      if (nextCategory === selectedCategory) return;
      selectedCategory = nextCategory;
      environmentBody.classList.add('is-switching');
      tabs.forEach((item) => {
        const active = item.dataset.category === nextCategory;
        item.classList.toggle('active', active);
        item.setAttribute('aria-selected', String(active));
      });
      document.querySelectorAll('.environment-card').forEach((card) => card.classList.remove('selected'));
      selectedTool = null;
      setPanelVisibility(nextCategory);
      environmentTitle.textContent = 'Choose your environment';
      environmentSubtitle.textContent = 'Pick one workspace to get started. You can add more tools later.';
      if (environmentHint) environmentHint.style.display = 'none';
      current = 1;
      render();
      window.setTimeout(() => environmentBody.classList.remove('is-switching'), 220);
    });
  });
  document.querySelectorAll('.environment-selection-body .environment-card').forEach((card) => card.addEventListener('click', () => {
    document.querySelectorAll('.environment-selection-body .environment-card').forEach((item) => item.classList.remove('selected'));
    card.classList.add('selected');
    selectedTool = card.querySelector('strong')?.textContent.trim() || null;
    if (selectedTool !== 'Desktop') selectedFlavor = null;
    hint.querySelector('[data-selection-hint]').textContent = `${card.querySelector('strong').textContent} selected`;
    render();
  }));
  document.querySelectorAll('.flavor-option').forEach((card) => card.addEventListener('click', () => {
    document.querySelectorAll('.flavor-option').forEach((item) => item.classList.remove('selected'));
    card.classList.add('selected');
    selectedFlavor = card.dataset.flavor;
    render();
  }));
  bindRadioCards([...document.querySelectorAll('.environment-card'), ...document.querySelectorAll('.instance-option')]);
  const startLaunch = () => {
    steps.forEach((step) => {
      step.hidden = true;
      step.classList.remove('active');
      step.style.setProperty('display', 'none', 'important');
    });
    if (launchState) {
      launchState.hidden = false;
      launchState.style.setProperty('display', 'block', 'important');
    }
    if (panelActions) {
      panelActions.hidden = true;
      panelActions.style.setProperty('display', 'none', 'important');
    }
    if (flowStepCopy) flowStepCopy.style.setProperty('display', 'none', 'important');
    if (label) label.textContent = selectedTool === 'Desktop' ? '04' : '03';
    if (flowHeading) flowHeading.textContent = 'Cloud Environment';
    if (flowSummary) flowSummary.textContent = 'We’re setting up your workspace in the cloud.';
    if (launchState) {
      const progress = launchState.querySelector('[data-launch-progress]');
      const status = launchState.querySelector('[data-launch-status]');
      const stages = [
        ['Allocating resources…', 18, 0],
        ['Network setup…', 38, 1],
        ['Starting container…', 58, 2],
        ['Loading services…', 78, 3],
        ['Ready!', 100, 4]
      ];
      stages.forEach(([message, width, activeIndex], index) => setTimeout(() => {
        if (progress) progress.style.width = `${width}%`;
        if (status) status.textContent = message;
        launchState.querySelectorAll('.launch-steps li').forEach((step, stepIndex) => {
          step.classList.toggle('complete', stepIndex < activeIndex);
          step.classList.toggle('active', stepIndex === activeIndex);
        });
      }, index * 900));
    }
  };
  next.addEventListener('click', () => { if (current === 3) startLaunch(); else { current = current === 1 && selectedTool !== 'Desktop' ? 3 : current + 1; render(); } });
  back.addEventListener('click', (event) => { if (current > 1) { event.preventDefault(); current = current === 3 && selectedTool !== 'Desktop' ? 1 : current - 1; if (current === 1) { environmentTitle.textContent = 'Choose a category'; environmentSubtitle.textContent = 'Start with the kind of work you want to do.'; if (environmentHint) environmentHint.style.display = 'none'; } render(); window.scrollTo({ top: 0, behavior: 'smooth' }); document.documentElement.scrollTop = 0; } });
  environmentTitle.textContent = 'Choose your environment';
  environmentSubtitle.textContent = 'Pick the workspace that fits your goals, adjust instance size, and launch.';
  if (environmentHint) environmentHint.style.display = 'none';
  render();
})();
