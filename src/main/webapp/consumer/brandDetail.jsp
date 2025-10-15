<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>브랜드 상세 페이지</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="<c:url value='/tagcss/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/modalRecent.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/productCard.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/tag.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/pagination.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/heartBtn.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/price.css'/>" />
<link rel="stylesheet" href="<c:url value='/consumer/css/header.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/toast.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/button.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/sortList.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/coupon.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/eventCard.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/pagination.css'/>">
<link rel="stylesheet"
	href="<c:url value='/tagcss/consumerCoupon.css'/>" />
<link rel="stylesheet"
	href="<c:url value='/tagcss/categoryFilter.css'/>" />
<link rel="stylesheet"
	href="<c:url value='/consumer/css/brandDetail.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>">
</head>
<body>
	<!-- 상단 헤더 -->
	<%@ include file="/consumer/header.jsp"%>

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

				<!-- 브랜드 소개 -->
				<%-- <div class="intro-wrapper">
					<span>${brand.intro}</span>
				</div> --%>

					<img
						src="${pageContext.request.contextPath}/image?fileId=${brand.heroFileId}"
						alt="브랜드 히어로 이미지" height= "550px"/>

			</div>


			<!-- 이벤트 & 브랜드 쿠폰 -->
			<div class="brand-promotion">
				<%-- 이벤트 카드 --%>

    <my:eventCard thumbnailFileId="${e.thumbnailFileId}"
        title="${e.eventName}" startDate="${startFmt}" endDate="${endFmt}"
        href="${detailUrl}" status="${e.status}" /> 


				<%-- 쿠폰 목록이 존재할 때만 렌더링 --%>
				<c:if test="${not empty couponList}">
					<c:forEach var="coupon" items="${couponList}">
						<!-- 금액 포맷 -->
						<fmt:formatNumber value="${coupon.amount}" pattern="#,###"
							var="amountFmt" />
						<fmt:formatNumber value="${coupon.amountCondition}"
							pattern="#,###" var="amountConditionFmt" />

						<my:consumerCoupon couponId="${coupon.couponId}"
							cname="${coupon.cname}" couponLimit="${coupon.couponLimit}"
							categoryName="${coupon.categoryName}"
							amountCondition="${amountConditionFmt}"
							downloaded="${coupon.downloaded}" amount="${amountFmt}" />
					</c:forEach>
				</c:if>
			</div>

		</div>


		<!-- 브랜드 상품존 -->
		<div class="product-section">
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

			<!-- 상품 카드 실제 데이터 -->
			<div class="product-grid">
				<c:choose>
					<c:when test="${not empty products}">
						<c:forEach var="p" items="${products}">
							<c:choose>
								<c:when test="${p.discountType eq 'RATE'}">
									<c:set var="saleRateRaw" value="${p.discountValue}" />
								</c:when>
								<c:when test="${p.discountType eq 'AMOUNT'}">
									<c:set var="saleRateRaw"
										value="${(p.discountValue / p.price) * 100}" />
								</c:when>
								<c:otherwise>
									<c:set var="saleRateRaw" value="0" />
								</c:otherwise>
							</c:choose>

							<fmt:formatNumber value="${p.finalPrice}" type="number"
								maxFractionDigits="0" groupingUsed="true" var="finalPrice" />

							<fmt:formatNumber value="${saleRateRaw}" type="number"
								maxFractionDigits="0" groupingUsed="true" var="saleRate" />

							<c:url value="/store/productDetail" var="detailUrl">
								<c:param name="productId" value="${p.productId}" />
							</c:url>


							<my:productCard brand="${p.brandName}" productId="${p.productId}"
								title="${p.name}" isWished="${p.isWished}"
								isSale="${p.discountType ne null and p.discountValue ne null 
          and p.startDate ne null 
          and p.endDate ne null 
          and p.startDate.time <= now.time 
          and now.time <= p.endDate.time}"
								hasOption="${p.hasOption eq 1}" originPrice="${p.price}"
								saleRate="${saleRate}" finalPrice="${finalPrice}"
								href="${detailUrl}" thumbnailFileId="${p.thumbnailFileId}">

								<c:if
									test="${p.discountType ne null 
          and p.discountValue ne null 
          and p.startDate ne null 
          and p.endDate ne null 
          and p.startDate.time <= now.time 
          and now.time <= p.endDate.time}">
									<my:tag color="red" size="sm" text="세일" />
								</c:if>
								<c:if test="${p.isExclusive ne 0}">
									<my:tag color="green" size="sm" text="단독" />
								</c:if>
								<c:if test="${p.isPlanned ne 0}">
									<my:tag color="yellow" size="sm" text="기획" />
								</c:if>
							</my:productCard>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<p>등록된 상품이 없습니다.</p>
					</c:otherwise>
				</c:choose>
			</div>


<c:set var="queryString">
			<c:if test="${not empty param.brandId}">brandId=${param.brandId}&</c:if>
			<c:if test="${not empty param.category1Id}">category1Id=${param.category1Id}&</c:if>
				page=
			</c:set>
			

			<!-- 페이징 -->
			<div class="page-pagination">
				<my:pagination currentPage="${currentPage}"
					totalPages="${totalPages}"
					baseUrl="/store/brandDetail?${queryString}" />
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