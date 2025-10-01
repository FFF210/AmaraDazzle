<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>기획 상품</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

<link rel="stylesheet" href="<c:url value='/tagcss/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/pageHeader.css'/>" />
<link rel="stylesheet"
	href="<c:url value='/tagcss/categoryFilter.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/sortList.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/productCard.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/tag.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/modalRecent.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/pagination.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/heartBtn.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/price.css'/>" />
<link rel="stylesheet" href="<c:url value='/consumer/css/header.css'/>" />
<link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>" />
<link rel="stylesheet"
	href="<c:url value='/consumer/css/planList.css'/>" />
</head>
<body>

	<!-- 최근 본 상품 모달 mock 데이터 -->
	<%
	java.util.List<String> recentList = new java.util.ArrayList<>();
	for (int i = 1; i <= 8; i++) {
		recentList.add("테스트 상품 " + i);
	}
	request.setAttribute("recentList", recentList);
	%>

	<!-- 최근 본 상품 모달 -->
	<my:modalRecent recentList="${recentList}" />

	<!-- 상단 헤더 -->
	<%@ include file="./header.jsp"%>

	<!-- 페이지 헤더 -->
	<div class="page-header-wrapper">
		<my:pageHeader title="기획전" description="꼭 갖고 싶은 그 상품들! 다양한 혜택까지!" />
	</div>

	<!-- 컨텐츠 영역 -->
	<div class="plan-container">
		<!-- 카테고리 필터 -->
		<my:categoryFilter
			categories="전체,스킨케어,마스크팩,클렌징,선케어,립메이크업,베이스메이크업,아이메이크업,헤어케어,바디케어,향수,맨즈케어"
			columns="15" selected="${param.category1Id}" />

		<!-- 정렬 옵션 -->
		<my:sortList hasSelect="false" />

		<!-- 상품 카드 실제 데이터 -->
		<div class="product-grid">
			<c:forEach var="p" items="${productPlanList}">
				<%-- 할인율(saleRate) 계산 --%>
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

				<%-- 최종 가격(finalPrice) 계산 --%>
				<c:choose>
					<c:when test="${p.discountType eq 'RATE'}">
						<c:set var="finalPriceRaw"
							value="${p.price - (p.price * p.discountValue / 100)}" />
					</c:when>
					<c:when test="${p.discountType eq 'AMOUNT'}">
						<c:set var="finalPriceRaw" value="${p.price - p.discountValue}" />
					</c:when>
					<c:otherwise>
						<c:set var="finalPriceRaw" value="${p.price}" />
					</c:otherwise>
				</c:choose>

				<%-- 숫자 포맷팅 (소수점 제거, 3자리마다 콤마) --%>
				<fmt:formatNumber value="${finalPriceRaw}" type="number"
					maxFractionDigits="0" groupingUsed="true" var="finalPrice" />

				<fmt:formatNumber value="${saleRateRaw}" type="number"
					maxFractionDigits="0" groupingUsed="true" var="saleRate" />

				<c:url value="/store/productDetail" var="detailUrl">
					<c:param name="productId" value="${p.productId}" />
				</c:url>

				<%-- 상품 카드 렌더링 --%>
				<my:productCard brand="${p.brandName}" productId="${p.productId}" title="${p.name}" isWished="${p.isWished}"
					isSale="${p.discountType ne null}" hasOption="${p.hasOption eq 1}"
					originPrice="${p.price}" saleRate="${saleRate}"
					finalPrice="${finalPrice}" href="${detailUrl}">

					<c:if test="${p.discountType ne null}">
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
		</div>

		<c:set var="queryString">
			<c:if test="${not empty param.sort}">sort=${param.sort}&</c:if>
			<c:if test="${not empty param.category1Id}">category1Id=${param.category1Id}&</c:if>
			<c:if test="${not empty param.category2Id}">category2Id=${param.category2Id}&</c:if>
			<c:if test="${not empty param.category3Id}">category3Id=${param.category3Id}&</c:if>
				page=
			</c:set>

		<!-- 페이징 -->
		<div class="page-pagination">
			<my:pagination currentPage="${currentPage}"
				totalPages="${totalPages}" baseUrl="/store/planList?${queryString}" />
		</div>
	</div>

	<!-- 하단 푸터 -->
	<%@ include file="./footer.jsp"%>

	<script>
	/*********************************************************************************************************
	 * 정렬, 카테고리 옵션 클릭 이벤트
	 *********************************************************************************************************/
	 document.addEventListener("DOMContentLoaded", () => {
		    const sortMap = {
		        "인기순": "POPULAR",
		        "최근 등록순": "RECENT",
		        "판매 수량순": "SALES",
		        "낮은 가격순": "PRICELOW",
		        "높은 가격순": "PRICEHIGH",
		    };

		    const currentSort = "${param.sort != null ? param.sort : 'POPULAR'}";

		    // 정렬 버튼 이벤트
		    document.querySelectorAll(".sort-item").forEach(btn => {
		        const mapped = sortMap[btn.textContent.trim()];

		        // 현재 선택된 sort 버튼 강조
		        if (mapped === currentSort) {
		            btn.classList.add("selected");
		        }

		        // 클릭 시 서버 요청
		        btn.addEventListener("click", () => {
		            const sortKey = sortMap[btn.textContent.trim()];
		            const url = new URL(window.location.href);
		            url.searchParams.set("page", 1); // 정렬 바꾸면 첫 페이지부터
		            url.searchParams.set("sort", sortKey);
		            location.href = url.toString();
		        });
		    });

		    // 카테고리 버튼 이벤트
		    document.querySelectorAll(".category-item").forEach(btn => {
		        btn.addEventListener("click", () => {
		            if (!btn.classList.contains("empty")) {
		                const categoryId = btn.dataset.categoryid;
		                const url = new URL(window.location.href);
		                url.searchParams.set("page", 1); // 카테고리 바꾸면 첫 페이지부터
		                url.searchParams.set("category1Id", categoryId);
		                url.searchParams.set("sort", currentSort);
		                location.href = url.toString();
		            }
		        });
		    });
		});
	
	 /*********************************************************************************************************
	  * 찜 버튼 클릭 이벤트 (HeartBtn - 카운트 없이)
	  *********************************************************************************************************/
	 document.addEventListener("DOMContentLoaded", () => {
	   document.querySelectorAll(".wishlist-btn .heart-btn").forEach(btn => {
	     btn.addEventListener("click", (e) => {
	       e.stopPropagation();
	       e.preventDefault();

	       const icon = btn.querySelector("i");
	       const productId = btn.closest(".product-card").dataset.productid;

	       fetch("/store/wishlistToggle", {
	         method: "POST",
	         headers: { "Content-Type": "application/x-www-form-urlencoded" },
	         body: "productId=" + encodeURIComponent(productId)
	       })
	       .then(res => res.json())
	       .then(data => {
	         if (data.success) {
	           // DB 반영 결과에 따라 아이콘 토글
	           if (data.isWished) {
	             icon.classList.remove("bi-heart");
	             icon.classList.add("bi-heart-fill", "active");
	           } else {
	             icon.classList.remove("bi-heart-fill", "active");
	             icon.classList.add("bi-heart");
	           }

	           // 부모 페이지로 이벤트 전달 (선택적)
	           const event = new CustomEvent("heartToggled", {
	             detail: { 
	               productId: productId, 
	               active: data.isWished 
	             }
	           });
	           document.dispatchEvent(event);
	         } else {
	           alert(data.message);
	         }
	       })
	       .catch(err => console.error(err));
	     });
	   });
	 });




	</script>
</body>
</html>
