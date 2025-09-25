(function () {
  function ready(fn){
    if (document.readyState !== 'loading') fn();
    else document.addEventListener('DOMContentLoaded', fn);
  }

  ready(function(){
    var BASE = (typeof window.__CTX__ === 'string') ? window.__CTX__ : '/';

    // 검색 엔터 제출
    var searchInput = document.querySelector('.search-input');
    if (searchInput && searchInput.form){
      searchInput.addEventListener('keydown', function(e){
        if (e.key === 'Enter'){ e.preventDefault(); this.form.submit(); }
      });
    }

    // ===== 최근 본 상품 드로어 =====
    var drawer   = document.getElementById('recent-drawer');
    var overlay  = document.getElementById('recent-overlay');
    var grid     = document.getElementById('recent-grid');
    var btnTgl   = document.querySelector('.recent-toggle');
    var btnClose = document.getElementById('recent-close');
    var btnClear = document.getElementById('recent-clear');
    var countEl  = document.getElementById('recent-count');
    var KEY      = 'recentProductIds';

    function hasDrawer(){
      return drawer && overlay && grid && btnTgl;
    }

    function openDrawer(){
      drawer.classList.add('open');
      drawer.setAttribute('aria-hidden','false');
      overlay.removeAttribute('hidden');
      renderRecent();
    }
    function closeDrawer(){
      drawer.classList.remove('open');
      drawer.setAttribute('aria-hidden','true');
      overlay.setAttribute('hidden','');
    }

    if (hasDrawer()){
      btnTgl.addEventListener('click', function(){
        if (drawer.classList.contains('open')) closeDrawer(); else openDrawer();
      });
      if (btnClose) btnClose.addEventListener('click', closeDrawer);
      overlay.addEventListener('click', closeDrawer);
      document.addEventListener('keydown', function(e){ if (e.key === 'Escape') closeDrawer(); });

      function getIds(){
        try { var v = localStorage.getItem(KEY); return v ? JSON.parse(v) : []; }
        catch(e){ return []; }
      }
      function setIds(ids){
        try { localStorage.setItem(KEY, JSON.stringify(ids)); } catch(e){}
      }

      if (btnClear){
        btnClear.addEventListener('click', function(){ setIds([]); renderRecent(); });
      }

      function renderRecent(){
        var ids = getIds().slice(0, 20);
        if (countEl) countEl.textContent = ids.length ? '(' + ids.length + ')' : '';
        if (!ids.length){
          grid.innerHTML = '<div class="empty">최근 본 상품이 없습니다.</div>';
          return;
        }
        var html = '';
        for (var i=0;i<ids.length;i++){
          var id = ids[i];
          html += '<a class="card" href="'+BASE+'productDetail?id='+id+'">'
                +   '<div class="thumb"><img src="'+BASE+'images/placeholder.png" alt="상품 #'+id+'"></div>'
                +   '<div class="name">상품 #'+id+'</div>'
                + '</a>';
        }
        grid.innerHTML = html;
      }
    }

    // ===== 장바구니 배지 갱신(선택) =====
    var cartLink = document.querySelector('.cart-link');
    if (cartLink && window.fetch){
      fetch(BASE + 'api/cart/count')
        .then(function(r){ return r.ok ? r.json() : {count:0}; })
        .then(function(data){
          if (!data || typeof data.count !== 'number') return;
          var badge = cartLink.querySelector('.cart-count');
          if (data.count > 0){
            if (!badge){
              badge = document.createElement('span');
              badge.className = 'cart-count';
              cartLink.appendChild(badge);
            }
            badge.textContent = String(data.count);
          } else if (badge){
            badge.remove();
          }
        })
        .catch(function(){});
    }
  });
})();
