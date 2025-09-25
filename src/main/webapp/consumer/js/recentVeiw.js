// 최근 본 상품 보관 키
const KEY = 'recentProductIds';
const MAX = 20;

// 패널 토글
document.addEventListener('click', (e) => {
  const btn = e.target.closest('.recent-toggle');
  if (!btn) return;
  const panel = document.getElementById('recent-panel');
  const open = !panel.hasAttribute('hidden');
  if (open) { panel.setAttribute('hidden', ''); btn.setAttribute('aria-expanded', 'false'); }
  else { panel.removeAttribute('hidden'); btn.setAttribute('aria-expanded', 'true'); renderRecent(panel); }
});

// productId를 최근목록에 추가 (productDetail.jsp에서 호출)
export function addRecent(productId){
  try{
    let ids = JSON.parse(localStorage.getItem(KEY) || '[]');
    ids = ids.filter(id => id !== productId); // 중복 제거
    ids.unshift(productId);                    // 맨 앞에
    if (ids.length > MAX) ids = ids.slice(0, MAX);
    localStorage.setItem(KEY, JSON.stringify(ids));
  }catch(e){ /* storage 막힌 경우 무시 */ }
}

// 패널 렌더
function renderRecent(panel){
  let ids = [];
  try{ ids = JSON.parse(localStorage.getItem(KEY) || '[]').slice(0, 8); }catch(e){}
  if (!ids.length){ panel.innerHTML = '<div class="empty">최근 본 상품이 없습니다.</div>'; return; }

  // ① 초간단 버전: 썸네일 API 없이 링크만(임시)
  // panel.innerHTML = ids.map(id => `<a href="/productDetail?id=${id}" class="recent-link">상품 #${id}</a>`).join('');

  // ② 권장: 미니정보 API로 받아서 카드 렌더
  fetch(`/api/products/mini?ids=${ids.join(',')}`)
    .then(r => r.json())
    .then(list => {
      panel.innerHTML = list.map(it => `
        <a class="recent-item" href="/productDetail?id=${it.id}">
          <img src="${it.thumbUrl}" alt="${it.name}">
          <div class="name">${it.name}</div>
          <div class="price">${it.priceFormatted}</div>
        </a>`).join('');
    })
    .catch(()=>{ panel.innerHTML = '<div class="empty">최근 본 상품을 불러오지 못했습니다.</div>'; });
}
