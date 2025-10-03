<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>브랜드 상세 페이지</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="<c:url value='/tagcss/reset.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/header.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/toast.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/button.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/heartBtn.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/categoryFilter.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/tag.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/price.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/sortList.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/productCard.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/coupon.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/eventCard.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/pagination.css'/>">
<link rel="stylesheet"
	href="<c:url value='/consumer/css/brandDetail.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>">
</head>
<body>
	<!-- 상단 헤더 -->
	<%@ include file="/consumer/header.jsp"%>

	<!-- 페이지-->
	<div class="brandDetail-page">

		<!-- 페이지 컨텐츠 -->
		<div class="main-content">

			<!-- 상단 영역 -->
			<div class="upper-container">

				<!-- 브랜드 헤더 -->
				<div class="brand-header">
					<div class="brand-title">
						<h1>${brand.brandName}</h1>

						<!-- 하트버튼 -->
						<div class="brand-favorite" data-brandid="${brand.brandId}">
							<my:heartBtn state="${isFollowing ? 'active' : 'default'}"
								onlyIcon="true" hasCount="true" count="${followerCount}" />
							<span>명이 이 브랜드를 좋아합니다.</span>
						</div>
					</div>

					<!-- 브랜드 대표 이미지가 와야함...  w:980px h:320px -->
					<div class="brand-image">
						<c:if test="${brand.heroFileId != null}">
							<!-- heroFileId로 이미지 표시 (upload_file 테이블 조인 필요하면 서블릿에서 처리) -->
						</c:if>
					</div>
				</div>
				<div class="intro-wrapper">
					<span>${brand.intro}</span>
				</div>


				<!-- 이벤트 & 브랜드 쿠폰 -->
				<div class="brand-promotion">
					<my:eventCard imageUrl="https://placehold.co/320x160"
						title="올영 뷰티 구매인증 리뷰 이벤트" startDate="2025-09-01"
						endDate="2025-09-31" />

					<!-- 쿠폰 다운 -->
					<div class="coupon-download">
						<my:coupon amount="2,000" startDate="2025.09.01"
							endDate="2025.12.31" label="신규 가입 혜택" />
						<button class="btn btn-primary btn-md">관심 브랜드 등록하고 쿠폰 받기</button>
					</div>
				</div>
			</div>


			<!-- 브랜드 상품존 -->
			<div class="product-section">
				<div class="filter-boxes">
					<div class="category-filter">
						<button
							class="category-item ${empty param.category1Id ? 'selected' : ''}"
							onclick="location.href='brandDetail?brandId=${brand.brandId}'">전체</button>

						<button
							class="category-item ${param.category1Id eq '1' ? 'selected' : ''}"
							onclick="location.href='brandDetail?brandId=${brand.brandId}&category1Id=1'">스킨케어</button>

						<button
							class="category-item ${param.category1Id eq '8' ? 'selected' : ''}"
							onclick="location.href='brandDetail?brandId=${brand.brandId}&category1Id=8'">마스크팩</button>

						<button
							class="category-item ${param.category1Id eq '14' ? 'selected' : ''}"
							onclick="location.href='brandDetail?brandId=${brand.brandId}&category1Id=14'">클렌징</button>

						<button
							class="category-item ${param.category1Id eq '21' ? 'selected' : ''}"
							onclick="location.href='brandDetail?brandId=${brand.brandId}&category1Id=21'">선케어</button>

						<button
							class="category-item ${param.category1Id eq '26' ? 'selected' : ''}"
							onclick="location.href='brandDetail?brandId=${brand.brandId}&category1Id=26'">메이크업</button>

						<button
							class="category-item ${param.category1Id eq '49' ? 'selected' : ''}"
							onclick="location.href='brandDetail?brandId=${brand.brandId}&category1Id=49'">헤어케어</button>

						<button
							class="category-item ${param.category1Id eq '54' ? 'selected' : ''}"
							onclick="location.href='brandDetail?brandId=${brand.brandId}&category1Id=54'">바디케어</button>

						<button
							class="category-item ${param.category1Id eq '66' ? 'selected' : ''}"
							onclick="location.href='brandDetail?brandId=${brand.brandId}&category1Id=66'">향수</button>

						<button
							class="category-item ${param.category1Id eq '70' ? 'selected' : ''}"
							onclick="location.href='brandDetail?brandId=${brand.brandId}&category1Id=70'">맨즈케어</button>
					</div>
					<div class="sortlist-wrapper">
						<my:sortList hasSelect="false" />
					</div>
				</div>
				<div class="product-grid">
					<c:choose>
						<c:when test="${not empty products}">
							<c:forEach var="product" items="${products}">
								<my:productCard brand="${brand.brandName}"
									productId="${product.productId}" title="${product.productName}"
									isSale="${product.discountType != null && product.discountType != 'NONE'}"
									hasOption="true" originPrice="${product.price}"
									saleRate="${product.discountValue != null ? product.discountValue : 0}"
									finalPrice="${product.price}" />
							</c:forEach>
						</c:when>
						<c:otherwise>
							<p>등록된 상품이 없습니다.</p>
						</c:otherwise>
					</c:choose>
				</div>

				<c:if test="${not empty products}">
					<div class="pagination-wrapper">
						<my:pagination currentPage="1" baseUrl="" totalPages="1" />
					</div>
				</c:if>
			</div>
		</div>
	</div>

	<!-- 하단 푸터 -->
	<%@ include file="/consumer/footer.jsp"%>
	<script>
window.brandId = ${brand.brandId};

// 상품별 찜 여부 데이터
window.wishlistData = {
    <c:forEach var="product" items="${products}" varStatus="status">
        ${product.productId}: ${product.isWished != null ? product.isWished : false}<c:if test="${!status.last}">,</c:if>
    </c:forEach>
};
</script>

	<script>
// 페이지 로드 후 하트 상태 업데이트
document.addEventListener('DOMContentLoaded', function() {
    if (window.wishlistData) {
        document.querySelectorAll('.product-card').forEach(card => {
            const productId = card.dataset.productid;
            const isWished = window.wishlistData[productId];
            
            if (isWished) {
                const heartIcon = card.querySelector('.heart-btn i');
                if (heartIcon) {
                    heartIcon.classList.remove('bi-heart');
                    heartIcon.classList.add('bi-heart-fill', 'active');
                }
            }
        });
    }
});
</script>
	<script src="<c:url value='/consumer/js/addToWishlist.js'/>"></script>
	<script src="<c:url value='/consumer/js/addToBrandFollow.js'/>"></script>
</body>
</html>