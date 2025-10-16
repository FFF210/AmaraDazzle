<%@ tag language="java" pageEncoding="UTF-8" body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ attribute name="couponId" required="false" type="java.lang.String"%>
<%@ attribute name="cname" required="false" type="java.lang.String"%>
<%@ attribute name="categoryName" required="false"
	type="java.lang.String"%>
<%@ attribute name="amountCondition" required="false"
	type="java.lang.String"%>
<%@ attribute name="amount" required="false" type="java.lang.String"%>
<%@ attribute name="startDate" required="false" type="java.lang.String"%>
<%@ attribute name="endDate" required="false" type="java.lang.String"%>
<%@ attribute name="downloaded" required="false" type="java.lang.String"%>

<div class="consumer-coupon">
	<div class="consumer-coupon-info">
		<!-- 쿠폰명 -->
		<p class="cname">${cname}</p>

		<!-- 할인 금액 -->
		<p class="amount">${amount}원</p>

		<!-- 조건/카테고리 -->
		<div class="sub">
			<c:if test="${not empty amountCondition}">
				<p class="amountCondition">${amountCondition}원 이상 구매 시&nbsp;</p>
			</c:if>
			<c:if test="${not empty categoryName}">
				<p class="categoryName">${categoryName}전용</p>
			</c:if>
		</div>

		<!-- 유효기간 -->
		<c:if test="${not empty startDate and not empty endDate}">
			<div class="date">${startDate}~${endDate}</div>
		</c:if>
	</div>

	<!-- 개별 쿠폰 다운로드 버튼 -->
	<div class="consumer-coupon-down">
		<button type="button"
		        class="coupon-download-btn"
		        data-id="${couponId}"
		        <c:if test="${downloaded == '1'}">disabled</c:if>>
			<c:choose>
				<c:when test="${downloaded == '1'}">
					<i class="bi bi-check2"></i>
				</c:when>
				<c:otherwise>
					<i class="bi bi-download"></i>
				</c:otherwise>
			</c:choose>
		</button>
	</div>
</div>
