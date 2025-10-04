<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>쿠폰</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

<link rel="stylesheet" href="<c:url value='/tagcss/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/pageHeader.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/button.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/tag.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/modalRecent.css'/>" />
<link rel="stylesheet"
	href="<c:url value='/tagcss/consumerCoupon.css'/>" />
<link rel="stylesheet" href="<c:url value='/consumer/css/header.css'/>" />
<link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>" />
<link rel="stylesheet"
	href="<c:url value='/consumer/css/couponList.css'/>" />
</head>
<body>
	<!-- 상단 헤더 -->
	<%@ include file="./header.jsp"%>

	<!-- 페이지 헤더 -->
	<div class="page-header-wrapper">
		<my:pageHeader title="쿠폰" description="쇼핑하는 재미! 올리브영만의 더 특별한 혜택" />
	</div>

	<div class="coupon-wrapper">
		<c:set var="prevBrand" value="" />
		<c:forEach var="coupon" items="${couponList}" varStatus="status">

			<c:if test="${prevBrand ne coupon.brandName}">
				<c:if test="${not empty prevBrand}">
	</div>
	<!-- 이전 brand-coupon-list 닫기 -->
	</c:if>

	<div class="brand-coupon-section">
		<a class="brand-title" href="/store/brandDetail?brandId=${coupon.writerId}">
			<img
				src="${pageContext.request.contextPath}/image?fileId=${coupon.logoFileId}"
				alt="브랜드 아이콘" width="40px" /> ${coupon.brandName}
		</a>
		<div class="brand-coupon-list">
			<!-- 브랜드 쿠폰 박스 시작 -->
			</c:if>

			<!-- 금액 포맷 -->
			<fmt:formatNumber value="${coupon.amount}" pattern="#,###"
				var="amountFmt" />
			<fmt:formatNumber value="${coupon.amountCondition}" pattern="#,###"
				var="amountConditionFmt" />

			<!-- 쿠폰 출력 -->
			<my:consumerCoupon couponId="${coupon.couponId}"
				cname="${coupon.cname}" couponLimit="${coupon.couponLimit}"
				categoryName="${coupon.categoryName}"
				amountCondition="${amountConditionFmt}"
				downloaded="${coupon.downloaded}" amount="${amountFmt}" />

			<c:set var="prevBrand" value="${coupon.brandName}" />

			<!-- 마지막 루프에서 brand-coupon-list 닫기 -->
			<c:if test="${status.last}">
		</div>
		<!-- brand-coupon-list -->
	</div>
	<!-- brand-coupon-section -->
	</c:if>

	</c:forEach>
	</div>


	<!-- 하단 푸터 -->
	<%@ include file="./footer.jsp"%>
</body>
<script>
/*********************************************************************************************************
 * 쿠폰 다운 이벤트
 *********************************************************************************************************/
document.querySelectorAll('.coupon-download-btn').forEach(btn => {
    btn.addEventListener('click', () => {
        const couponId = btn.dataset.id;

        if (!couponId) {
            alert("쿠폰 ID가 없습니다.");
            return;
        }

        fetch('<c:url value="/store/couponDownload"/>', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'couponId=' + encodeURIComponent(couponId)
        })
        .then(r => r.json())
        .then(data => {
        	 if (!data.success && data.requireLogin) {
	    		    window.location.href = "/store/login"; // 로그인 페이지로 이동
	    	}
            else if (data.success) {
                btn.innerHTML = '<i class="bi bi-check2"></i>';
                btn.disabled = true; // 클릭된 버튼만 비활성화
                location.reload();
            }
        })
        .catch(err => {
            console.error(err);
            alert("쿠폰 발급 중 오류가 발생했습니다.");
        });
    });
});
</script>

</html>
