<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="scriptless"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<%-- ================================
     Layout 커스텀 태그

     사용법 예시:
     <%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
     <link rel="stylesheet" href="./css/reset.css" />
	 <link rel="stylesheet" href="./css/sidebar.css" />
	 <link rel="stylesheet" href="./css/brandHeader.css" />
	 <link rel="stylesheet" href="./css/layout.css" />
	 <link rel="stylesheet" href="./css/button.css" />
	 <link rel="stylesheet"
		href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
		
	 <my:layout>
     	<h1>브랜드 어드민 대시보드</h1>
     	<p>이곳에 페이지 본문이 들어갑니다.</p>
     	<p>본문을 layout 태그로 감싸주세요!</p>
   	 </my:layout>
================================ --%>

<div class="layout-container" id="layoutContainer">

	<!-- 사이드바 -->
	<aside class="layout-sidebar">
		<my:sidebar />
	</aside>

	<!-- 메인 영역 -->
	<div class="layout-main">

		<!-- 상단 헤더 -->
		<header class="layout-header">
			<my:brandHeader />
		</header>

		<!-- 본문 -->
		<main class="layout-content">
			<jsp:doBody />
		</main>
	</div>
</div>

<script>
  document.addEventListener("DOMContentLoaded", () => {
    const layoutContainer = document.getElementById("layoutContainer");
    const sidebar = document.getElementById("sidebar");

    // ===============================
    // 1. 초기 상태 localStorage 반영
    // ===============================
    const isPinned = localStorage.getItem("sidebarPinned") === "true";
    if (!isPinned) {
      // 사이드바 접힘 → layout도 접힘 처리
      layoutContainer.classList.add("collapsed");
    } else {
      // 사이드바 고정 → layout 정상 상태
      layoutContainer.classList.remove("collapsed");
    }

    // ===============================
    // 2. 사이드바 상태 변화 감지
    // ===============================
    const observer = new MutationObserver(() => {
      if (sidebar.classList.contains("collapsed")) {
        layoutContainer.classList.add("collapsed");
      } else {
        layoutContainer.classList.remove("collapsed");
      }
    });

    observer.observe(sidebar, { attributes: true, attributeFilter: ["class"] });
  });
</script>
