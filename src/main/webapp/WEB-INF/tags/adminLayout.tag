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
		<my:adminBreadcrumb />
		<!-- breadcrumb end -->

		<!-- 본문 -->
		<main class="content">
			<jsp:doBody />
		</main>
	</div>
</div>





