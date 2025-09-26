<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="scriptless"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>



<%-- ================================
     Layout 커스텀 태그

     사용법 예시:
     <%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
     <link rel="stylesheet" href="./css/reset.css" />
	 <link rel="stylesheet" href="./css/sidebar.css" />
	 <link rel="stylesheet" href="./css/header.css" />
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
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<div class="container">
	<!-- 사이드바 -->
	<my:adminSidebar />
	<!-- 사이드바 end -->


	<!-- 메인 영역 -->
	<div class="main">

		<!-- 상단 헤더 -->
		<my:adminHeader />
		<!-- 상단 헤더 end -->

		<!-- breadcrumb -->
		<my:adminBreadcrumb items="상품 관리:/product,상품 목록 조회:" />
		<!-- breadcrumb end -->

		<!-- 본문 -->
		<main class="content">
			<jsp:doBody />
		</main>
	</div>
</div>


<!-- 정보수정 & 로그아웃 팝업 -->
<div class="modal hidden loginInfo">
	<div class="info">
		<img src="./image/logo_black.png" /> 
		<span><b> &nbsp;홍 길 동 [ADMIN]</b></span>
	</div>
	<div class="modifyInfo">
		<button type="button">내 정보 수정</button>
	</div>
	<div class="logout">
		<button type="button">로그아웃</button>
	</div>
</div>
<!-- 정보수정 & 로그아웃 팝업 end -->


<!-- JS소스 -->
<script>
// loginInfo 모달 열고닫기 
const logInfoBtn = document.querySelector(".header .bi-person");
const loginInfoBox = document.querySelector(".modal.loginInfo");

//팝업 열기/닫기 토글
logInfoBtn.addEventListener("click", (e) => {
    e.stopPropagation(); // **버튼을 눌러도 문서 클릭으로 닫히지 않게**
    loginInfoBox.classList.toggle("hidden");
});

// 팝업 내부는 닫힘 방지
loginInfoBox.addEventListener("click", (e) => e.stopPropagation());

// 문서 아무 곳이나 클릭 → 팝업 닫기
document.addEventListener("click", () => {
    if (!loginInfoBox.classList.contains("hidden")) {
    	loginInfoBox.classList.add("hidden");
    }
});


//회원 검색 모달 열고닫기
const cName_searchBtn = document.querySelector("#cName_searchBtn");
const searchUserBox = document.querySelector(".modal.modal_search_box");
const modal_selectBtn = document.getElementById("modal_selectBtn");


// 팝업 열기/닫기 토글
cName_searchBtn.addEventListener("click", (e) => {
    e.stopPropagation(); // **버튼을 눌러도 문서 클릭으로 닫히지 않게**
    searchUserBox.classList.toggle("hidden");
});

// 팝업 내부는 닫힘 방지
searchUserBox.addEventListener("click", (e) => e.stopPropagation());

// 문서 아무 곳이나 클릭 → 팝업 닫기
document.addEventListener("click", () => {
    if (!searchUserBox.classList.contains("hidden")) {
        searchUserBox.classList.add("hidden");
    }
});

</script>
<!-- JS소스 end -->


