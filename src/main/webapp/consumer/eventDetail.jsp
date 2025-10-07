<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%-- 오늘 날짜를 JSTL 변수에 저장 --%>
<jsp:useBean id="now" class="java.util.Date" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>이벤트 상세</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="<c:url value='/tagcss/modalRecent.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/pageHeader.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/productCard.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/tag.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/modalRecent.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/pagination.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/heartBtn.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/price.css'/>" />
<link rel="stylesheet" href="<c:url value='/consumer/css/header.css'/>" />
<link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>" />
<link rel="stylesheet"
	href="<c:url value='/consumer/css/eventDetail.css'/>" />
</head>
<body>
	<!-- 상단 헤더 -->
	<%@ include file="./header.jsp"%>

	<!-- 이벤트 상세 본문 (이미지) -->
	<div class="event-detail">
		<img
			src="${pageContext.request.contextPath}/image?fileId=${eventDetail.detailFileId}"
			alt="이벤트 대표 이미지" width="630px" />
	</div>

	<!-- 이벤트 관련 상품 -->
	<div class="event-products">
		<div class="product-grid">
			<c:forEach var="p" items="${eventProducts}">
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

				<%-- 숫자 포맷팅 (소수점 제거, 3자리마다 콤마) --%>
				<fmt:formatNumber value="${p.finalPrice}" type="number"
					maxFractionDigits="0" groupingUsed="true" var="finalPrice" />

				<fmt:formatNumber value="${saleRateRaw}" type="number"
					maxFractionDigits="0" groupingUsed="true" var="saleRate" />

				<c:url value="/store/productDetail" var="detailUrl">
					<c:param name="productId" value="${p.productId}" />
				</c:url>

				<%-- 상품 카드 렌더링 --%>
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
		</div>
	</div>

	<!-- 하단 푸터 -->
	<%@ include file="./footer.jsp"%>
</body>

<script>
document.addEventListener("DOMContentLoaded", () => {
/*********************************************************************************************************
 * 찜 버튼 클릭 이벤트
 *********************************************************************************************************/
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
			    	  if (!data.success && data.requireLogin) {
			    		    window.location.href = "/store/login"; // 로그인 페이지로 이동
			    		  }
			    	  else if (data.success) {
				          if (data.isWished) {
				            icon.classList.remove("bi-heart");
				            icon.classList.add("bi-heart-fill", "active");
				          } else {
				            icon.classList.remove("bi-heart-fill", "active");
				            icon.classList.add("bi-heart");
				          }
			        } else {
			          alert(data.message);
			        }
			      })
			      .catch(err => console.error(err));
			    });
			  });
			});
</script>
</html>
