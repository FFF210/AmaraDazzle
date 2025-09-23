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
		<li class="menu-item ">
			<a href="#" class="menu-link" title="홈"> 
				<i class="bi bi-house-fill"></i> 
				<span class="menu-text">홈</span>
		</a></li>
		
		<!-- 단일 메뉴 -->
		<li class="menu-item ">
			<a href="#" class="menu-link" title="오늘의 할 일"> 
				<i class="bi bi-house-fill"></i> 
				<span class="menu-text">오늘의 할 일</span>
		</a></li>
		
		<!-- 단일 메뉴 -->
		<li class="menu-item ">
			<a href="#" class="menu-link" title="회원"> 
				<i class="bi bi-house-fill"></i> 
				<span class="menu-text">회원</span>
		</a></li>
		
		<!-- 단일 메뉴 -->
		<li class="menu-item ">
			<a href="#" class="menu-link" title="일대일문의"> 
				<i class="bi bi-house-fill"></i> 
				<span class="menu-text">일대일문의</span>
		</a></li>

		<!-- 서브메뉴 포함 -->
		<li class="menu-item has-submenu">
			<button class="menu-link" title="게시판">
				<i class="bi bi-box-seam-fill"></i> 
				<span class="menu-text">게시판</span> 
				<i class="bi bi-chevron-down submenu-icon"></i>
			</button>
			<ul class="submenu">
				<li><a href="#">신고글</a></li>
				<li><a href="#">공지사항</a></li>
			</ul>
		</li>

		<!-- 서브메뉴 포함 -->
		<li class="menu-item has-submenu">
			<button class="menu-link" title="주문정산">
				<i class="bi bi-box-seam-fill"></i> 
				<span class="menu-text">주문정산</span> 
				<i class="bi bi-chevron-down submenu-icon"></i>
			</button>
			<ul class="submenu">
				<li><a href="#">주문내역</a></li>
				<li><a href="#">정산내역</a></li>
			</ul>
		</li>

		<!-- 서브메뉴 포함 -->
		<li class="menu-item has-submenu">
			<button class="menu-link" title="프로모션">
				<i class="bi bi-box-seam-fill"></i> 
				<span class="menu-text">프로모션</span> 
				<i class="bi bi-chevron-down submenu-icon"></i>
			</button>
			<ul class="submenu">
				<li><a href="#">이벤트</a></li>
				<li><a href="#">메인배너</a></li>
				<li><a href="#">쿠폰</a></li>
				<li><a href="#">포인트</a></li>
			</ul>
		</li>

		<!-- 서브메뉴 포함 -->
		<li class="menu-item has-submenu">
			<button class="menu-link" title="설정">
				<i class="bi bi-box-seam-fill"></i> 
				<span class="menu-text">설정</span> 
				<i class="bi bi-chevron-down submenu-icon"></i>
			</button>
			<ul class="submenu">
				<li><a href="#">ㅇㅇㅇㅇ</a></li>
				<li><a href="#">플랫폴 세팅</a></li>
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
