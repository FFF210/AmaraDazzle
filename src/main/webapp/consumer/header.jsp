<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ page import="dto.Member"%>

<%-- 
==============================
 JSP 처리 로직 (상단 서버사이드 로직)
============================== 
--%>

<%
// 세션에서 로그인 사용자 정보 가져오기
Member loginUser = (Member) session.getAttribute("loginUser");

// 로그인된 사용자의 장바구니 개수 조회
int cartCount = 0;
if (loginUser != null) {
	// MyBatis를 통한 장바구니 개수 조회
	//cartCount = cartService.getCartCount(loginUser.getId());
}

request.setAttribute("loginUser", loginUser);
// request.setAttribute("cartCount", cartCount);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>AMARA DAZZLE</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
</head>

<body>
	<!-- 전체 헤더 영역 배경 컨테이너 -->
	<div class="header-background">
		<header class="header">

			<!-- ========== 상단 헤더 영역 (로고 + 검색 + 사용자 메뉴) ========== -->
			<div class="header-top">

				<!-- 검색 영역 -->
				<div class="search-area">
					<form action="<c:url value='/productList'/>" method="get"
						style="display: flex; width: 100%;">
						<!-- 숨김 라벨 -->
						<label for="keyword" class="sr-only">검색어</label>

						<div class="search-input-wrapper">
							<!-- 돋보기 버튼 -->
							<button class="search-btn" aria-label="검색">
								<i class="bi bi-search" aria-hidden="true"></i>
							</button>
							<!-- 검색어 입력창 -->
							<input id="keyword" type="text" name="keyword"
								class="search-input" placeholder="상품, 브랜드 검색"
								value="${param.keyword}">
						</div>
					</form>
				</div>

				<!-- 브랜드 로고 -->
				<div class="logo">
					<a href="<c:url value='/store/main'/>"> <img
						src="<c:url value='/image/logo_black.svg'/>" alt="AD 로고">
					</a>
				</div>

				<!-- 사용자 메뉴 -->
				<div class="user-shortcut">
					<c:choose>
						<c:when test="${not empty loginUser}">
							<!-- 로그인 상태 -->
							<span class="username">${loginUser.name}님</span>
							<a href="<c:url value='/store/logout'/>">로그아웃</a>
							<a href="<c:url value='/store/mypage'/>">마이페이지</a>

							<!-- 장바구니 (배지 포함) -->
							<a href="<c:url value='/store/mypage/cart'/>" class="cart-link">
								장바구니 <c:if test="${cartCount > 0}">
									<span class="cart-count">${cartCount}</span>
								</c:if>
							</a>
						</c:when>
						<c:otherwise>
							<!-- 비로그인 상태 -->
							<a href="<c:url value='/store/join'/>">회원가입</a>
							<a href="<c:url value='/store/login'/>">로그인</a>
							<a href="<c:url value='/store/mypage/cart'/>" class="cart-link">장바구니</a>
						</c:otherwise>
					</c:choose>

					<!-- 최근 본 상품: 토글 버튼 -->
					<button id="recent-btn" type="button" class="recent-toggle">최근
						본 상품</button>
				</div>
			</div>


			<!-- ========== 하단 네비게이션 영역 ========== -->
			<div class="tab-navigation" style="display: flex !important;">
				<!-- 메인 카테고리 -->
				<ul class="main-nav">
					<li><a href="<c:url value='/productList?categoryId=1'/>">스킨케어</a></li>
					<li><a href="<c:url value='/productList?categoryId=2'/>">메이크업</a></li>
					<li><a href="<c:url value='/productList?categoryId=3'/>">헤어케어</a></li>
					<li><a href="<c:url value='/productList?categoryId=4'/>">바디케어</a></li>
					<li><a href="<c:url value='/productList?categoryId=5'/>">향수</a></li>
					<li><a href="<c:url value='/productList?categoryId=6'/>">맨즈케어</a></li>
				</ul>

				<!-- 서브 메뉴 -->
				<ul class="sub-nav">
					<li><a href="<c:url value='/store/ranking'/>">랭킹</a></li>
					<li><a href="<c:url value='/store/saleList'/>">세일</a></li>
					<li><a href="<c:url value='/store/planList'/>">기획</a></li>
					<li><a href="<c:url value='/store/eventList'/>">이벤트</a></li>
					<li><a href="<c:url value='/store/couponList'/>">쿠폰</a></li>
				</ul>
			</div>
		</header>
		<!-- 최근 본 상품 모달 include -->
			<my:modalRecent />
	</div>

	<script>
	// 검색창: Enter키 입력 시 폼 제출
	document.querySelector('.search-input').addEventListener('keypress', function(e) {
	    if (e.key === 'Enter') {
	        this.closest('form').submit();
	    }
	});
	
	// 장바구니 개수 업데이트 함수 (다른 페이지에서 호출 가능)
	function updateCartCount() {
	    <c:if test="${not empty loginUser}">
	    fetch('/api/cart/count')
	        .then(response => response.json())
	        .then(data => {
	            const countElement = document.querySelector('.cart-count');
	            if (data.count > 0) {
	                if (countElement) {
	                    countElement.textContent = data.count;
	                } else {
	                    // 카운트 엘리먼트가 없으면 생성
	                    const cartLink = document.querySelector('.cart-link');
	                    const countSpan = document.createElement('span');
	                    countSpan.className = 'cart-count';
	                    countSpan.textContent = data.count;
	                    cartLink.appendChild(countSpan);
	                }
	            } else if (countElement) {
	                countElement.remove();
	            }
	        });
	    </c:if>
	}
</script>