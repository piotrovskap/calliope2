function renderProduct(p) {
  var B = ['B','R','O','C','S'];
  var N = ['Build','Run','Observe','Control','Secure'];

  function brocs() {
    return '<div class="brocsrow">'
      + p.brocs.map(function(on,i){
          return '<i class="'+(on?'on':'')+'" title="'+N[i]+'">'+B[i]+'</i>';
        }).join('')
      + '</div>';
  }

  var badge = p.badge ? '<div class="badge">'+p.badge+'</div>' : '';

  var stats = p.stats.map(function(s){
    return '<div class="stat"><span class="stat-num">'+s.num+'</span><span class="stat-lbl">'+s.lbl+'</span></div>';
  }).join('');

  var cards = p.features.map(function(f,i){
    return '<div class="card"><span class="card-num">0'+(i+1)+'</span><h3 class="card-h">'+f.h+'</h3><p class="card-p">'+f.p+'</p></div>';
  }).join('');

  var specs = p.specs.map(function(r){
    return '<tr><td>'+r[0]+'</td><td>'+r[1]+'</td></tr>';
  }).join('');

  var foot = p.footer.map(function(c){
    return '<div class="foot-cell"><span>'+c.lbl+'</span><b>'+c.val+'</b></div>';
  }).join('');

  var arrowOut = '<svg width="10" height="10" viewBox="0 0 10 10" fill="none"><path d="M2 8L8 2M8 2H4.5M8 2V5.5" stroke="currentColor" stroke-width="1.4" stroke-linecap="round" stroke-linejoin="round"/></svg>';

  document.getElementById('bp-content').innerHTML =
    '<div class="doc">'

    /* hero */
    + '<section class="hero">'
    +   '<div>'
    +     '<p class="eyebrow">'+p.tagline+'</p>'
    +     '<h1 class="hero-h1">'+p.name+'</h1>'
    +     brocs()
    +     badge
    +     '<p class="hero-desc">'+p.desc+'</p>'
    +     '<div class="hero-ctas">'
    +       '<a class="cta-primary" href="'+p.cta.href+'" target="_blank" rel="noopener">'+p.cta.label+' '+arrowOut+'</a>'
    +       '<a class="cta-secondary" href="'+p.ctaSecondary.href+'">'+p.ctaSecondary.label+'</a>'
    +     '</div>'
    +   '</div>'
    +   '<div class="hero-fig" id="pf-fig">'
    +     '<div class="reg tl"></div><div class="reg tr"></div>'
    +     '<div class="reg bl"></div><div class="reg br"></div>'
    +     '<div class="fig-svg" id="pf-svg"></div>'
    +     '<span class="fig-dwg">'+p.dwg+'</span>'
    +   '</div>'
    + '</section>'

    /* stats */
    + '<div class="stats">'+stats+'</div>'

    /* features */
    + '<section class="features">'
    +   '<div class="section-head"><span>01</span> Capabilities</div>'
    +   '<div class="cards">'+cards+'</div>'
    + '</section>'

    /* specs */
    + '<section class="specs">'
    +   '<div class="section-head"><span>02</span> Specifications</div>'
    +   '<table class="spec-table"><tbody>'+specs+'</tbody></table>'
    + '</section>'

    /* footer */
    + '<div class="sheet-foot">'+foot+'</div>'

    /* see also */
    + '<section class="see-also" id="see-also">'
    +   '<p class="eyebrow" style="margin-bottom:12px">Learn more</p>'
    +   '<div class="section-head"><span>↓</span> Parts list · the three machines</div>'
    +   '<div id="parts-list-container"></div>'
    + '</section>'

    + '</div>';

  if (p.figSvg) {
    fetch(p.figSvg).then(function(r){return r.text();}).then(function(svg){
      var el = document.getElementById('pf-svg');
      if (el) el.innerHTML = svg;
    });
  }

  /* load parts list */
  fetch('/blueprint/parts-fragment.html').then(function(r){return r.text();}).then(function(html){
    var el = document.getElementById('parts-list-container');
    if (!el) return;
    var tmp = document.createElement('div');
    tmp.innerHTML = html;
    var parts = tmp.querySelector('.parts');
    if (parts) {
      el.appendChild(parts);
      /* wire up clicks */
      el.querySelectorAll('.part').forEach(function(part) {
        part.addEventListener('click', function() {
          var link = part.querySelector('a.partlink');
          if (!link) return;
          var pid = link.getAttribute('href').replace('#','');
          window.location.href = '/blueprint/' + pid + '/';
        });
      });
    }
  });
}
