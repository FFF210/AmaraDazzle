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
					<form action="<c:url value='searchResult'/>" method="get"
						style="display: flex; width: 100%;">
						<!-- 숨김 라벨 -->
						<label for="keyword" class="sr-only">검색어</label>

						<div class="search-input-wrapper">
							<!-- 돋보기 버튼 -->
								<i class="bi bi-search search-btn" aria-hidden="true"></i>
							<!-- 검색어 입력창 -->
							<input id="keyword" type="text" name="keyword"
								class="search-input" placeholder="상품, 브랜드 검색"
								value="${param.keyword}" autocomplete="off">
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
			<div class="tab-navigation">
				<ul class="main-nav">

					<!-- 스킨케어 -->
					<li class="nav-item"><a
						href="<c:url value='/store/categoryList?page=1&category1Id=1'/>">스킨케어</a>
						<div class="dropdown-panel">
							<div class="category-group">
								<div class="category-column">
									<h4>
										<a
											href="<c:url value='/store/categoryList?page=1&category1Id=1'/>">스킨케어</a>
									</h4>
									<ul>
										<li><a
											href="<c:url value='/store/categoryList?page=1&category1Id=1&category2Id=2&hasSmall=0'/>">스킨/토너</a></li>
										<li><a
											href="<c:url value='/store/categoryList?page=1&category1Id=1&category2Id=3&hasSmall=0'/>">에센스/세럼/앰플</a></li>
										<li><a
											href="<c:url value='/store/categoryList?page=1&category1Id=1&category2Id=4&hasSmall=0'/>">크림</a></li>
										<li><a
											href="<c:url value='/store/categoryList?page=1&category1Id=1&category2Id=5&hasSmall=0'/>">로션</a></li>
										<li><a
											href="<c:url value='/store/categoryList?page=1&category1Id=1&category2Id=6&hasSmall=0'/>">미스트</a></li>
										<li><a
											href="<c:url value='/store/categoryList?page=1&category1Id=1&category2Id=7&hasSmall=0'/>">페이셜오일</a></li>
									</ul>
								</div>
								<div class="category-column">
									<h4><a
											href="<c:url value='/store/categoryList?page=1&category1Id=8'/>">마스크팩</a></h4>
									<ul>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=8&category2Id=9&hasSmall=0'/>">시트팩</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=8&category2Id=10&hasSmall=0'/>">패드</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=8&category2Id=11&hasSmall=0'/>">페이셜팩</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=8&category2Id=12&hasSmall=0'/>">코팩</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=8&category2Id=13&hasSmall=0'/>">패치</a></li>
									</ul>
								</div>
								<div class="category-column">
									<h4><a
											href="<c:url value='/store/categoryList?page=1&category1Id=14'/>">클렌징</a></h4>
									<ul>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=14&category2Id=15&hasSmall=0'/>">클렌징폼/젤</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=14&category2Id=16&hasSmall=0'/>">오일/밤</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=14&category2Id=17&hasSmall=0'/>">워터/밀크</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=14&category2Id=18&hasSmall=0'/>">스크럽/필링</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=14&category2Id=19&hasSmall=0'/>">티슈/패드</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=14&category2Id=20&hasSmall=0'/>">립/아이리무버</a></li>
									</ul>
								</div>
								<div class="category-column">
									<h4><a
											href="<c:url value='/store/categoryList?page=1&category1Id=21'/>">선케어</a></h4>
									<ul>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=21&category2Id=22&hasSmall=0'/>">선크림</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=21&category2Id=23&hasSmall=0'/>">선스틱</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=21&category2Id=24&hasSmall=0'/>">선쿠션</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=21&category2Id=25&hasSmall=0'/>">선스프레이/선패치</a></li>
									</ul>
								</div>
							</div>
						</div></li>

					<!-- 메이크업 -->
					<li class="nav-item"><a
						href="<c:url value='/store/categoryList?page=1&category1Id=26'/>">메이크업</a>
						<div class="dropdown-panel">
							<div class="category-group">
								<div class="category-column">
									<h4><a
											href="<c:url value='/store/categoryList?page=1&category1Id=26&category2Id=27&hasSmall=1'/>">립메이크업</a></h4>
									<ul>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=26&category2Id=27&category3Id=28&hasSmall=1'/>">립스틱</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=26&category2Id=27&category3Id=29&hasSmall=1'/>">립틴트</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=26&category2Id=27&category3Id=30&hasSmall=1'/>">립글로스</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=26&category2Id=27&category3Id=31&hasSmall=1'/>">립케어/립밤</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=26&category2Id=27&category3Id=32&hasSmall=1'/>">립라이너</a></li>
									</ul>
								</div>
								<div class="category-column">
									<h4><a
											href="<c:url value='/store/categoryList?page=1&category1Id=26&category2Id=33&hasSmall=1'/>">베이스메이크업</a></h4>
									<ul>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=26&category2Id=33&category3Id=34&hasSmall=1'/>">쿠션</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=26&category2Id=33&category3Id=35&hasSmall=1'/>">파운데이션</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=26&category2Id=33&category3Id=36&hasSmall=1'/>">블러셔</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=26&category2Id=33&category3Id=37&hasSmall=1'/>">파우더/팩트</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=26&category2Id=33&category3Id=38&hasSmall=1'/>">컨실러</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=26&category2Id=33&category3Id=39&hasSmall=1'/>">베이스/프라이머</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=26&category2Id=33&category3Id=40&hasSmall=1'/>">쉐이딩</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=26&category2Id=33&category3Id=41&hasSmall=1'/>">하이라이터</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=26&category2Id=33&category3Id=42&hasSmall=1'/>">픽서</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=26&category2Id=33&category3Id=43&hasSmall=1'/>">BB/CC</a></li>
									</ul>
								</div>
								<div class="category-column">
									<h4><a
											href="<c:url value='/store/categoryList?page=1&category1Id=26&category2Id=44&hasSmall=1'/>">아이메이크업</a></h4>
									<ul>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=26&category2Id=44&category3Id=45&hasSmall=1'/>">아이라이너</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=26&category2Id=44&category3Id=46&hasSmall=1'/>">마스카라/픽서</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=26&category2Id=44&category3Id=47&hasSmall=1'/>">아이브로우</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=26&category2Id=44&category3Id=48&hasSmall=1'/>">아이섀도우</a></li>
									</ul>
								</div>
							</div>
						</div></li>

					<!-- 바디&헤어 -->
					<li class="nav-item"><a
						href="<c:url value='/store/categoryList?page=1&category1Id=49'/>">헤어 & 바디케어</a>
						<div class="dropdown-panel">
							<div class="category-group">
								<div class="category-column">
									<h4><a
											href="<c:url value='/store/categoryList?page=1&category1Id=49'/>">헤어케어</a></h4>
									<ul>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=49&category2Id=50&hasSmall=0'/>">샴푸/린스</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=49&category2Id=51&hasSmall=0'/>">트리트먼트/팩</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=49&category2Id=52&hasSmall=0'/>">헤어에센스</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=49&category2Id=53&hasSmall=0'/>">스타일링</a></li>
									</ul>
								</div>
								<div class="category-column">
									<h4><a
											href="<c:url value='/store/categoryList?page=1&category1Id=54'/>">바디케어</a></h4>
									<ul>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=54&category2Id=55&hasSmall=0'/>">바디워시/클렌저</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=54&category2Id=56&hasSmall=0'/>">바디스크럽</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=54&category2Id=57&hasSmall=0'/>">바디로션</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=54&category2Id=58&hasSmall=0'/>">바디크림</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=54&category2Id=59&hasSmall=0'/>">바디오일</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=54&category2Id=60&hasSmall=0'/>">바디미스트</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=54&category2Id=61&hasSmall=0'/>">데오드란트</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=54&category2Id=62&hasSmall=0'/>">비누</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=54&category2Id=63&hasSmall=0'/>">입욕제</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=54&category2Id=64&hasSmall=0'/>">핸드케어</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=54&category2Id=65&hasSmall=0'/>">풋케어</a></li>
									</ul>
								</div>
							</div>
						</div></li>

					<!-- 향수 -->
					<li class="nav-item"><a
						href="<c:url value='/store/categoryList?page=1&category1Id=66'/>">향수</a>
						<div class="dropdown-panel">
							<div class="category-group">
								<div class="category-column">
									<h4><a
											href="<c:url value='/store/categoryList?page=1&category1Id=66'/>">향수</a></h4>
									<ul>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=66&category2Id=67&hasSmall=0'/>">여성향수</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=66&category2Id=68&hasSmall=0'/>">남성향수</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=66&category2Id=69&hasSmall=0'/>">헤어퍼퓸</a></li>
									</ul>
								</div>
							</div>
						</div></li>

					<!-- 맨즈케어 -->
					<li class="nav-item"><a
						href="<c:url value='/store/categoryList?page=1&category1Id=70'/>">맨즈케어</a>
						<div class="dropdown-panel">
							<div class="category-group">
								<div class="category-column">
									<h4><a
											href="<c:url value='/store/categoryList?page=1&category1Id=70&category2Id=71&hasSmall=1'/>">스킨케어</a></h4>
									<ul>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=70&category2Id=71&category3Id=72&hasSmall=1'/>">올인원</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=70&category2Id=71&category3Id=73&hasSmall=1'/>">스킨/로션/세럼</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=70&category2Id=71&category3Id=74&hasSmall=1'/>">클렌징/선크림/팩</a></li>
									</ul>
								</div>
								<div class="category-column">
									<h4><a
											href="<c:url value='/store/categoryList?page=1&category1Id=70&category2Id=75&hasSmall=1'/>">메이크업</a></h4>
									<ul>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=70&category2Id=75&category3Id=76&hasSmall=1'/>">BB</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=70&category2Id=75&category3Id=77&hasSmall=1'/>">쿠션/파운데이션</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=70&category2Id=75&category3Id=78&hasSmall=1'/>">쉐이딩/파우더/기름종이</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=70&category2Id=75&category3Id=79&hasSmall=1'/>">립밤</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=70&category2Id=75&category3Id=80&hasSmall=1'/>">아이브로우</a></li>
									</ul>
								</div>
								<div class="category-column">
									<h4><a
											href="<c:url value='/store/categoryList?page=1&category1Id=70&category2Id=81&hasSmall=0'/>">쉐이빙/왁싱</a></h4>
								</div>
								<div class="category-column">
									<h4><a
											href="<c:url value='/store/categoryList?page=1&category1Id=70&category2Id=82&hasSmall=1'/>">바디케어</a></h4>
									<ul>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=70&category2Id=82&category3Id=83&hasSmall=1'/>">바디워시/로션</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=70&category2Id=82&category3Id=84&hasSmall=1'/>">데오/바디미스트</a></li>
									</ul>
								</div>
								<div class="category-column">
									<h4><a
											href="<c:url value='/store/categoryList?page=1&category1Id=70&category2Id=85&hasSmall=1'/>">헤어케어</a></h4>
									<ul>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=70&category2Id=85&category3Id=86&hasSmall=1'/>">스프레이/왁스/젤</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=70&category2Id=85&category3Id=87&hasSmall=1'/>">오일/토닉/컬크림</a></li>
										<li><a href="<c:url value='/store/categoryList?page=1&category1Id=70&category2Id=85&category3Id=88&hasSmall=1'/>">샴푸/린스</a></li>
									</ul>
								</div>
							</div>
						</div></li>
				</ul>

				<!-- 기존 sub-nav 유지 -->
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