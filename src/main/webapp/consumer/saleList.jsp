<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>세일</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="./css/reset.css" />
<link rel="stylesheet" href="./css/header.css" />
<link rel="stylesheet" href="./css/pageHeader.css" />
<link rel="stylesheet" href="./css/categoryFilter.css" />
<link rel="stylesheet" href="./css/productItem.css" />
<link rel="stylesheet" href="./css/sortList.css" />
<link rel="stylesheet" href="./css/productCard.css" />
<link rel="stylesheet" href="./css/tag.css" />
<link rel="stylesheet" href="./css/footer.css" />
<link rel="stylesheet" href="./css/saleList.css" />
</head>
<body>

	<!-- 상단 헤더 -->
	<%@ include file="header.jsp"%>

	<%-- 선택된 카테고리 파라미터 처리 --%>
	<c:set var="selectedCategory"
		value="${param.category != null ? param.category : '전체'}" />

	<!-- 페이지 헤더 -->
	<div class="page-header-wrapper">
		<my:pageHeader title="세일" description="핫 세일! 이건 꼭 사야 해!" />
	</div>

	<!-- 컨텐츠 영역 -->
	<div class="sale-container">
		<!-- 카테고리 필터 -->
		<my:categoryFilter
			categories="전체,스킨케어,마스크팩,클렌징,선케어,립메이크업,베이스메이크업,아이메이크업,헤어케어,바디케어,향수,맨즈케어"
			columns="15" selected="${selectedCategory}" />

		<!-- 주목할 만한 세일 상품 섹션 -->
		<div class="highlight-sale-section">
			<h2 class="section-title">주목할 만한 세일 상품</h2>

			<div class="highlight-sale-container">

				<!-- 왼쪽 버튼 -->
				<button class="nav-btn prev">
					<i class="bi bi-chevron-left"></i>
				</button>

				<!-- 상품 아이템 리스트 -->
				<div class="highlight-sale-list">
					<my:productItem size="md" title="리얼 딥 마스크 7매입" isSale="true"
						hasOption="false" originPrice="34000" saleRate="25"
						finalPrice="25500" showTags="true">
						<my:tag color="red" size="sm" text="세일" />
						<my:tag color="yellow" size="sm" text="기획" />
					</my:productItem>

					<my:productItem size="md" title="수분 진정 크림" isSale="true"
						hasOption="false" originPrice="28000" saleRate="30"
						finalPrice="19600" showTags="true">
						<my:tag color="red" size="sm" text="세일" />
					</my:productItem>
				</div>
				<!-- 오른쪽 버튼 -->
				<button class="nav-btn next">
					<i class="bi bi-chevron-right"></i>
				</button>
			</div>
		</div>

		<!-- 정렬 옵션 -->
		<my:sortList hasSelect="false" />

		<!-- 상품 카드 mock 데이터 -->
		<div class="product-grid">
			<c:forEach var="i" begin="1" end="16">
				<my:productCard brand="바이오던스" title="${selectedCategory} 상품 ${i}"
					isSale="true" hasOption="false" originPrice="34000" saleRate="25"
					finalPrice="25500">
					<my:tag color="red" size="sm" text="세일" />
				</my:productCard>
			</c:forEach>
		</div>
	</div>

	<!-- 하단 푸터 -->
	<%@ include file="/footer.jsp"%>

	<script>
    // 카테고리 버튼 클릭 시 → 새로고침 (파라미터 전달)
    document.addEventListener("DOMContentLoaded", () => {
      document.querySelectorAll(".category-item").forEach(btn => {
        btn.addEventListener("click", () => {
          if (!btn.classList.contains("empty")) {
            const category = btn.dataset.category;
            location.href = "saleList.jsp?category=" + encodeURIComponent(category);
          }
        });
      });
    });
  </script>

</body>
</html>
