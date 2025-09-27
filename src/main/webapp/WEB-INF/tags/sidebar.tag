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
		<li class="menu-item active"><a href="#" class="menu-link"
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
				<li><a href="#">주문 관리</a></li>
				<li><a href="#">취소 관리</a></li>
				<li><a href="#">교환 관리</a></li>
				<li><a href="#">반품 관리</a></li>
				<li><a href="#">배송 관리</a></li>
			</ul>
		</li>

		<li class="menu-item has-submenu">
			<button class="menu-link" title="고객 관리">
				<i class="bi bi-people-fill"></i> <span class="menu-text">고객
					관리</span> <i class="bi bi-chevron-down submenu-icon"></i>
			</button>
			<ul class="submenu">
				<li><a href="#">리뷰 조회</a></li>
				<li><a href="#">문의 조회</a></li>
			</ul>
		</li>

		<li class="menu-item has-submenu">
			<button class="menu-link" title="정산 관리">
				<i class="bi bi-wallet-fill"></i> <span class="menu-text">정산
					관리</span> <i class="bi bi-chevron-down submenu-icon"></i>
			</button>
			<ul class="submenu">
				<li><a href="#">정산 대시보드</a></li>
				<li><a href="#">정산 목록 조회</a></li>
			</ul>
		</li>

		<li class="menu-item has-submenu">
			<button class="menu-link" title="프로모션">
				<i class="bi bi-tags-fill"></i> <span class="menu-text">프로모션</span>
				<i class="bi bi-chevron-down submenu-icon"></i>
			</button>
			<ul class="submenu">
				<li><a href="#">이벤트 신청</a></li>
				<li><a href="#">이벤트 신청 조회</a></li>
			</ul>
		</li>

		<li class="menu-item has-submenu">
			<button class="menu-link" title="배너 광고">
				<i class="bi bi-badge-ad-fill"></i> <span class="menu-text">배너
					광고</span> <i class="bi bi-chevron-down submenu-icon"></i>
			</button>
			<ul class="submenu">
				<li><a href="#">배너 광고 신청</a></li>
				<li><a href="#">배너 광고 조회</a></li>
			</ul>
		</li>

		<li class="menu-item has-submenu">
			<button class="menu-link" title="마케팅 메일">
				<i class="bi bi-envelope-at-fill"></i> <span class="menu-text">마케팅
					메일</span> <i class="bi bi-chevron-down submenu-icon"></i>
			</button>
			<ul class="submenu">
				<li><a href="#">메일 발송</a></li>
				<li><a href="#">메일 발송 조회</a></li>
			</ul>
		</li>

		<li class="menu-item has-submenu">
			<button class="menu-link" title="통계 지표">
				<i class="bi bi-bar-chart-fill"></i> <span class="menu-text">통계
					지표</span> <i class="bi bi-chevron-down submenu-icon"></i>
			</button>
			<ul class="submenu">
				<li><a href="#">대시보드</a></li>
				<li><a href="#">매출 현황</a></li>
				<li><a href="#">성과 지표</a></li>
				<li><a href="#">마게팅 메일 성과</a></li>
				<li><a href="#">메인 이벤트 성과</a></li>
			</ul>
		</li>

		<li class="menu-item has-submenu">
			<button class="menu-link" title="멤버십">
				<i class="bi bi-person-badge-fill"></i> <span class="menu-text">멤버십</span>
				<i class="bi bi-chevron-down submenu-icon"></i>
			</button>
			<ul class="submenu">
				<li><a href="#">구독</a></li>
				<li><a href="#">결제 관리·해지</a></li>
			</ul>
		</li>

		<li class="menu-item has-submenu">
			<button class="menu-link" title="운영 지원">
				<i class="bi bi-signpost-2-fill"></i> <span class="menu-text">운영
					지원</span> <i class="bi bi-chevron-down submenu-icon"></i>
			</button>
			<ul class="submenu">
				<li><a href="#">공지사항</a></li>
				<li><a href="#">문의하기</a></li>
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

    let isPinned = false;

    // hover 시 자동 열림/닫힘
    sidebar.addEventListener("mouseenter", () => {
      if (!isPinned) sidebar.classList.remove("collapsed");
    });
    sidebar.addEventListener("mouseleave", () => {
      if (!isPinned) sidebar.classList.add("collapsed");
    });

    // 고정 버튼
    pinBtn.addEventListener("click", () => {
      isPinned = !isPinned;
      if (isPinned) {
        sidebar.classList.remove("collapsed");
        pinBtn.classList.add("pinned");
      } else {
        sidebar.classList.add("collapsed");
        pinBtn.classList.remove("pinned");
      }
    });

    // 서브메뉴 열고 닫기
    document.querySelectorAll(".menu-item.has-submenu > .menu-link").forEach(btn => {
      btn.addEventListener("click", () => {
        const parent = btn.closest(".menu-item");
        parent.classList.toggle("open");
      });
    });

    // 단일 메뉴 클릭 시 active 적용
    document.querySelectorAll(".menu-item:not(.has-submenu) > .menu-link").forEach(link => {
      link.addEventListener("click", () => {
        document.querySelectorAll(".menu-item, .submenu a").forEach(el => el.classList.remove("active"));
        link.closest(".menu-item").classList.add("active");
      });
    });

    // 서브메뉴 클릭 시 active 적용
    document.querySelectorAll(".submenu a").forEach(link => {
      link.addEventListener("click", () => {
        document.querySelectorAll(".menu-item, .submenu a").forEach(el => el.classList.remove("active"));
        const parentItem = link.closest(".menu-item");
        parentItem.classList.add("active");
        link.classList.add("active");
      });
    });
  });
</script>
