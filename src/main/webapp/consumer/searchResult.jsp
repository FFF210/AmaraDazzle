<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>${param.keyword}검색</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="./css/reset.css" />
<link rel="stylesheet" href="./css/header.css" />
<link rel="stylesheet" href="./css/pageHeader.css" />
<link rel="stylesheet" href="./css/brandNavCard.css" />
<link rel="stylesheet" href="./css/searchFilter.css" />
<link rel="stylesheet" href="./css/sortList.css" />
<link rel="stylesheet" href="./css/productCard.css" />
<link rel="stylesheet" href="./css/tag.css" />
<link rel="stylesheet" href="./css/footer.css" />
<link rel="stylesheet" href="./css/searchResult.css" />
</head>
<body>

	<!-- 상단 헤더 -->
	<%@ include file="header.jsp"%>

	<%-- 검색어 파라미터 처리 --%>
	<c:set var="keyword"
		value="${param.keyword != null ? param.keyword : '검색어'}" />

	<!-- 페이지 헤더 -->
	<div class="page-header-wrapper">
		<my:pageHeader title="${keyword}" isSearch="true" />
	</div>

    <!-- 컨텐츠 영역 -->
	<div class="search-container">
		<!-- 브랜드 매칭 영역 (예: 검색어가 브랜드명과 일치할 경우) -->
		<c:if test="${keyword eq '바이오던스'}">

			<my:brandNavCard brandName="바이오던스"
				logoUrl="https://placehold.co/64x64" likes="500" />

		</c:if>
		<!-- 검색 필터 -->
		<my:searchFilter />

		<!-- 정렬 옵션 -->
		<my:sortList hasSelect="false" />

		<!-- 상품 카드 mock 데이터 -->
		<div class="product-grid">
			<c:forEach var="i" begin="1" end="16">
				<my:productCard brand="바이오던스" title="${keyword} 상품 ${i}"
					isSale="true" hasOption="false" originPrice="34000" saleRate="25"
					finalPrice="25500">
					<my:tag color="red" size="sm" text="세일" />
					<my:tag color="yellow" size="sm" text="기획" />
				</my:productCard>
			</c:forEach>
		</div>
	</div>

	<!-- 하단 푸터 -->
	<%@ include file="footer.jsp"%>

</body>
</html>
