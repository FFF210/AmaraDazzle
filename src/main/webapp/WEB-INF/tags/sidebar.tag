<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="empty"%>

<%-- ================================
     Sidebar 커스텀 태그
================================ --%>

<nav class="sidebar" id="sidebar">
	<!-- 헤더 -->
	<div class="sidebar-header">
		<div class="logo"></div>
		<!-- 상단 고정 버튼 -->
		<button id="pinBtn" title="사이드바 고정">
			<i class="bi bi-pin-angle"></i>
		</button>
	</div>

	<!-- 메뉴 리스트 -->
	<ul class="menu">
		<!-- 단일 메뉴 -->
		<li class="menu-item"><a href="/brand/todoDashboard" class="menu-link"
			title="홈"> <i class="bi bi-house-fill"></i> <span
				class="menu-text">홈</span>
		</a></li>

		<!-- 서브메뉴 포함 -->
		<li class="menu-item has-submenu">
			<button class="menu-link" title="상품 관리">
				<i class="bi bi-box-seam-fill"></i> <span class="menu-text">상품
					관리</span> <i class="bi bi-chevron-down submenu-icon"></i>
			</button>
			<ul class="submenu">
				<li><a href="/brand/productDetail">상품 등록</a></li>
				<li><a href="/brand/productList">상품 목록 조회</a></li>
			</ul>
		</li>

		<li class="menu-item has-submenu">
			<button class="menu-link" title="주문·배송 관리">
				<i class="bi bi-cart-fill"></i> <span class="menu-text">주문·배송
					관리</span> <i class="bi bi-chevron-down submenu-icon"></i>
			</button>
			<ul class="submenu">
				<li><a href="/brand/orderList">주문 관리</a></li>
				<li><a href="/brand/cancelList">취소 관리</a></li>
				<li><a href="/brand/exchangeList">교환 관리</a></li>
				<li><a href="/brand/returnList">반품 관리</a></li>
				<li><a href="/brand/shippingList">배송 관리</a></li>
			</ul>
		</li>

		<li class="menu-item has-submenu">
			<button class="menu-link" title="고객 관리">
				<i class="bi bi-people-fill"></i> <span class="menu-text">고객
					관리</span> <i class="bi bi-chevron-down submenu-icon"></i>
			</button>
			<ul class="submenu">
				<li><a href="/brand/reviewList">리뷰 조회</a></li>
				<li><a href="/brand/qnaList">문의 조회</a></li>
			</ul>
		</li>

		<li class="menu-item has-submenu">
			<button class="menu-link" title="정산 관리">
				<i class="bi bi-wallet-fill"></i> <span class="menu-text">정산
					관리</span> <i class="bi bi-chevron-down submenu-icon"></i>
			</button>
			<ul class="submenu">
				<li><a href="/brand/settlementDashboard">정산 대시보드</a></li>
				<li><a href="/brand/settlementList">정산 목록 조회</a></li>
			</ul>
		</li>

		<li class="menu-item has-submenu">
			<button class="menu-link" title="프로모션">
				<i class="bi bi-tags-fill"></i> <span class="menu-text">프로모션</span>
				<i class="bi bi-chevron-down submenu-icon"></i>
			</button>
			<ul class="submenu">
				<li><a href="/brand2/eventList">이벤트 신청 및 조회</a></li>
			</ul>
		</li>

		<li class="menu-item has-submenu">
			<button class="menu-link" title="배너 광고">
				<i class="bi bi-badge-ad-fill"></i> <span class="menu-text">배너
					광고</span> <i class="bi bi-chevron-down submenu-icon"></i>
			</button>
			<ul class="submenu">
				<li><a href="/brand2/adbanner">배너 광고 신청</a></li>
				<li><a href="/brand2/adbannerList">배너 광고 조회</a></li>
			</ul>
		</li>

		<li class="menu-item has-submenu">
			<button class="menu-link" title="쿠폰 발급">
				<i class="bi bi-envelope-at-fill"></i> <span class="menu-text">쿠폰 발급</span> 
				<i class="bi bi-chevron-down submenu-icon"></i>
			</button>
			<ul class="submenu">
				<li><a href="#">쿠폰 발급</a></li>
				<li><a href="#">쿠폰 발급 조회</a></li>
			</ul>
		</li>

		<li class="menu-item has-submenu">
			<button class="menu-link" title="통계 지표">
				<i class="bi bi-bar-chart-fill"></i> <span class="menu-text">통계
					지표</span> <i class="bi bi-chevron-down submenu-icon"></i>
			</button>
			<ul class="submenu">
				<li><a href="/brand2/dashboard">대시보드</a></li>
				<li><a href="/brand2/salesOverview">매출 현황</a></li>
			</ul>
		</li>

		<li class="menu-item has-submenu">
			<button class="menu-link" title="멤버십">
				<i class="bi bi-person-badge-fill"></i> <span class="menu-text">멤버십</span>
				<i class="bi bi-chevron-down submenu-icon"></i>
			</button>
			<ul class="submenu">
				<li><a href="/brand2/membership">구독</a></li>
				<li><a href="/brand2/membershipList">결제 관리·해지</a></li>
			</ul>
		</li>

		<li class="menu-item has-submenu">
			<button class="menu-link" title="운영 지원">
				<i class="bi bi-signpost-2-fill"></i> <span class="menu-text">운영
					지원</span> <i class="bi bi-chevron-down submenu-icon"></i>
			</button>
			<ul class="submenu">
				<li><a href="/brand/noticeList">공지사항</a></li>
				<!-- <li><a href="/brand/inquiryList">문의하기</a></li> -->
			</ul>
		</li>
	</ul>

	<!-- 푸터 -->
	<div class="sidebar-footer">ⓒ copyright 2025</div>
</nav>

<script>
document.addEventListener("DOMContentLoaded", () => {
  const sidebar = document.getElementById("sidebar");
  const pinBtn = document.getElementById("pinBtn");

  /***********************************************
   * 1. 고정 상태 로드
   ***********************************************/
  const isPinned = localStorage.getItem("sidebarPinned") === "true";
  if (isPinned) {
    sidebar.classList.remove("collapsed");
    pinBtn.classList.add("pinned");
  } else {
    sidebar.classList.add("collapsed");
    pinBtn.classList.remove("pinned");
  }

  /***********************************************
   * 2. 고정 버튼 토글
   ***********************************************/
  pinBtn.addEventListener("click", () => {
    const nowPinned = localStorage.getItem("sidebarPinned") === "true";
    if (nowPinned) {
      sidebar.classList.add("collapsed");
      pinBtn.classList.remove("pinned");
      localStorage.setItem("sidebarPinned", "false");
    } else {
      sidebar.classList.remove("collapsed");
      pinBtn.classList.add("pinned");
      localStorage.setItem("sidebarPinned", "true");
    }
  });

  /***********************************************
   * 3. Hover 시 자동 열림/닫힘 (비고정일 때만)
   ***********************************************/
  sidebar.addEventListener("mouseenter", () => {
    if (localStorage.getItem("sidebarPinned") !== "true") {
      sidebar.classList.remove("collapsed");
    }
  });
  sidebar.addEventListener("mouseleave", () => {
    if (localStorage.getItem("sidebarPinned") !== "true") {
      sidebar.classList.add("collapsed");
    }
  });

  /***********************************************
   * 4. 서브메뉴 열림/닫힘 상태 저장
   ***********************************************/
  const submenuItems = document.querySelectorAll(".menu-item.has-submenu > .menu-link");
  submenuItems.forEach((btn, idx) => {
    const parent = btn.closest(".menu-item");
    const isOpen = localStorage.getItem("submenuOpen_" + idx) === "true";
    if (isOpen) parent.classList.add("open");

    btn.addEventListener("click", () => {
      parent.classList.toggle("open");
      localStorage.setItem("submenuOpen_" + idx, parent.classList.contains("open"));
    });
  });

  /***********************************************
   * 5. 단일 메뉴 active 처리
   ***********************************************/
  document.querySelectorAll(".menu-item:not(.has-submenu) > .menu-link").forEach(link => {
    link.addEventListener("click", () => {
      document.querySelectorAll(".menu-item, .submenu a").forEach(el => el.classList.remove("active"));
      link.closest(".menu-item").classList.add("active");
    });
  });

  /***********************************************
   * 6. 서브메뉴 항목 클릭 시 active 처리
   ***********************************************/
  document.querySelectorAll(".submenu a").forEach(link => {
    link.addEventListener("click", () => {
      document.querySelectorAll(".menu-item, .submenu a").forEach(el => el.classList.remove("active"));
      const parentItem = link.closest(".menu-item");
      parentItem.classList.add("active");
      link.classList.add("active");
    });
  });

  /***********************************************
   * 7. 현재 URL 기반 active/open 자동 적용
   ***********************************************/
  const currentPath = window.location.pathname.replace(/\/$/, ""); // 끝 / 제거
  document.querySelectorAll(".menu a, .submenu a").forEach(link => {
    const href = link.getAttribute("href");
    if (!href || href === "#") return;

    const cleanHref = href.replace(/\/$/, "");
    if (currentPath === cleanHref) {
      // active
      link.classList.add("active");
      const parentItem = link.closest(".menu-item");
      if (parentItem) parentItem.classList.add("active");

      // has-submenu open 처리 (단, 사용자가 닫은 경우는 제외)
      const parentMenu = link.closest(".menu-item.has-submenu");
      if (parentMenu) {
        const submenuIndex = Array.from(document.querySelectorAll(".menu-item.has-submenu"))
          .indexOf(parentMenu);
        const isClosed = localStorage.getItem("submenuOpen_" + submenuIndex) === "false";
        if (!isClosed) parentMenu.classList.add("open");
      }
    }
  });
});
</script>

