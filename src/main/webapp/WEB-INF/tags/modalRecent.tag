<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="empty"%>
<%@ tag isELIgnored="false"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<%-- ================================
     최근 본 상품 모달
================================ --%>
<div id="recent-modal" class="recent-modal hidden">

	<!-- 모달 본문 -->
	<div class="recent-content">

		<!-- 상단 헤더 -->
		<div class="recent-header">
			<span class="recent-count">전체 0개</span>
			<button class="recent-clear">전체삭제</button>
		</div>

		<!-- 상품 목록 -->
		<div class="recent-body">
			<div class="product-grid-recent" id="recent-grid">
				<p class="empty">최근 본 상품이 없습니다.</p>
			</div>
		</div>

		<!-- 페이지네이션 -->
		<div class="recent-pagination" id="recent-pagination"></div>

	</div>
</div>

<script>
const contextPath = `\${pageContext.request.contextPath}`;
</script>

<script>
document.addEventListener("DOMContentLoaded", () => {
  /* ==============================
     1. 기본 변수 및 DOM 요소
  ============================== */
  const KEY = 'recentProductIds';
  const productIds = JSON.parse(localStorage.getItem(KEY) || '[]');
  const pageSize = 4;
  let currentPage = 1;

  const modal = document.getElementById("recent-modal");
  const btn = document.getElementById("recent-btn");
  const overlay = document.querySelector(".recent-overlay");
  const clearBtn = document.querySelector(".recent-clear");
  const grid = document.getElementById("recent-grid");
  const pagination = document.getElementById("recent-pagination");
  const countEl = document.querySelector(".recent-count");


  /* ==============================
     2. 최근 본 상품 로드 (API)
  ============================== */
  function loadRecentProducts() {
    if (!productIds.length) {
      grid.innerHTML = '<p class="empty">최근 본 상품이 없습니다.</p>';
      pagination.innerHTML = '';
      countEl.textContent = '전체 0개';
      return;
    }

    // 서버 API 요청 (예: /api/recentProducts?productIds=1,2,3)
    fetch('/api/recentProducts?productIds=' + productIds.join(','))
      .then(res => res.json())
      .then(products => {
        countEl.textContent = `전체 ${products.length}개`;
        renderPage(products, currentPage);
        renderPagination(products.length);
      })
      .catch(err => {
        console.error('최근 본 상품 로드 실패:', err);
        grid.innerHTML = '<p class="empty">상품 정보를 불러오지 못했습니다.</p>';
      });
  }


  /* ==============================
     3. 상품 카드 렌더링 (productCard 동일 UI)
  ============================== */
  function renderPage(list, page) {
	  const start = (page - 1) * pageSize;
	  const end = start + pageSize;
	  const subset = list.slice(start, end);

	  if (!subset.length) {
	    grid.innerHTML = '<p class="empty">최근 본 상품이 없습니다.</p>';
	    return;
	  }

	  grid.innerHTML = subset.map(p => {

	    let saleRate = 0;
	    if (p.discountType eq 'RATE') {
	      saleRate = p.discountValue;
	    } else if (p.discountType eq 'AMOUNT' && p.price > 0) {
	      saleRate = Math.round((p.discountValue / p.price) * 100);
	    }

	    // 가격 포맷 (3자리 콤마)
	    const formattedPrice = Number(p.finalPrice || 0).toLocaleString();

	    // 찜 여부
	    const heartClass = p.isWished ? 'bi-heart-fill active' : 'bi-heart';

	    // 썸네일 URL
	    const thumbUrl = p.thumbnailFileId
  			? `${contextPath}/image?fileId=${p.thumbnailFileId}`
  			: `${contextPath}/image/placeholder.png`;


	    // 할인율 표시
	    const saleRateHtml = p.isSale
	      ? `<span class="sale-rate">${saleRate}${p.discountType eq 'RATE' ? '%' : '원'}</span>`
	      : '';

	    // 태그 표시
	    const tagHtml = `
	      ${p.isExclusive ? '<span class="tag green sm">단독</span>' : ''}
	      ${p.isPlanned ? '<span class="tag yellow sm">기획</span>' : ''}
	      ${p.isSale ? '<span class="tag red sm">세일</span>' : ''}
	    `;

	    return `
	      <a class="product-card" data-productid="${p.productId}" href="/store/productDetail?productId=${p.productId}">
	        <div class="product-image">
	          <img src="${thumbUrl}" alt="${p.name}" width="220" />
	          <div class="wishlist-btn">
	            <button class="heart-btn icon-only">
	              <i class="bi ${heartClass}"></i>
	            </button>
	          </div>
	        </div>

	        <div class="product-info">
	          <p class="product-brand">${p.brandName}</p>
	          <p class="product-title">${p.name}</p>
	        </div>

	        <div class="price sm">
	          ${saleRateHtml}
	          <span class="final">${formattedPrice}원${p.hasOption ? '~' : ''}</span>
	        </div>

	        <div class="product-tags">${tagHtml}</div>
	      </a>
	    `;
	  }).join('');
	}



  /* ==============================
     4. 페이지네이션 렌더링
  ============================== */
  function renderPagination(total) {
    const pageCount = Math.ceil(total / pageSize);
    pagination.innerHTML = Array.from({ length: pageCount }, (_, i) => `
      <button class="page-btn ${i + 1 == currentPage ? 'active' : ''}" data-page="${i + 1}">
        ${i + 1}
      </button>
    `).join('');

    // 각 버튼 클릭 시 해당 페이지로 이동
    pagination.querySelectorAll('.page-btn').forEach(btn =>
      btn.addEventListener('click', () => {
        currentPage = Number(btn.dataset.page);
        loadRecentProducts();
      })
    );
  }


  /* ==============================
     5. 모달 열기 / 닫기
  ============================== */
  btn?.addEventListener("click", () => {
	  modal.classList.toggle("show"); 
	  if (modal.classList.contains("show")) {
	    loadRecentProducts();
	  }
	});


  /* ==============================
     6. 전체삭제 기능
  ============================== */
  if (clearBtn) {
    clearBtn.addEventListener("click", () => {
      localStorage.removeItem(KEY);
      grid.innerHTML = '<p class="empty">최근 본 상품이 없습니다.</p>';
      pagination.innerHTML = '';
      countEl.textContent = '전체 0개';
      window.location.reload();
    });
  }

});
</script>
