<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<title>마이 페이지</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="<c:url value='/tagcss/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/modalRecent.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/productCard.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/tag.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/pagination.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/heartBtn.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/price.css'/>" />
<link rel="stylesheet"
	href="<c:url value='/consumer/css/mypageMenu.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>">
<link rel="stylesheet"
	href="<c:url value='/consumer/css/orderStatusCard.css'/>">
<link rel="stylesheet"
	href="<c:url value='/consumer/css/userInfo.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/mypage.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/header.css'/>">
</head>

<body>
	<!-- 상단 헤더 -->
	<%@ include file="/consumer/header.jsp"%>

	<div class="container">

		<!-- 마이페이지 메뉴 -->
		<%@ include file="/consumer/mypageMenu.jsp"%>

		<!-- Main Content -->
		<main class="main-content">

			<!-- ============================ 1. 사용자 정보 요약 ============================ -->
			<div class="user-info">
				<%-- 이 부분 tag 수정해서 그걸로 교체했었는데 grade가 이건 그냥 일반으로 나와요 --%>
				<%--<my:userInfo userName="${memberInfo.name}"
					grade="${memberInfo.grade}" 
					points="${memberInfo.pointBalance}"
					coupons="${couponCount}" />--%>

				<div class="user-info__top">
					<p class="greeting">
						<span class="name">${memberInfo.name}</span> 님 반갑습니다.
					</p>					
				</div>

				<!-- 하단 통계 영역 -->
				<div class="user-info__bottom">
					<div class="stat">
						<span class="label">등급</span> <span class="value"><span
							class="em">${memberInfo.grade}</span></span>
					</div>
					<div class="stat">
						<span class="label">포인트</span> <span class="value"><span
							class="em">${memberInfo.pointBalance}</span> p</span>
					</div>
					<div class="stat">
						<span class="label">쿠폰</span> <span class="value"><span
							class="em">${couponCount}</span> 개</span>
					</div>
				</div> 
			</div>

			<!-- ============================ 2. 주문/배송 조회 ============================ -->
			<div class="order-status-card">
				<div class="order-status-header">
					<h3 class="order-status-title">주문/배송 조회</h3>
					<a class="more-btn" href="/store/mypage/orderList"> <span
						class="more-text">더보기</span> <span class="more-icon">›</span>
					</a>
				</div>

				<div class="order-status-box">
					<div class="status-item ${activeStatus eq 'order' ? 'active' : ''}">
						<div class="status-count">${orderSummary.orderCount}</div>
						<div class="status-label">주문접수</div>
					</div>

					<div
						class="status-item ${activeStatus eq 'payment' ? 'active' : ''}">
						<div class="status-count">${orderSummary.paymentCount}</div>
						<div class="status-label">결제완료</div>
					</div>

					<div
						class="status-item ${activeStatus eq 'shipping' ? 'active' : ''}">
						<div class="status-count">${orderSummary.shippingCount}</div>
						<div class="status-label">배송준비중</div>
					</div>

					<div
						class="status-item ${activeStatus eq 'delivered' ? 'active' : ''}">
						<div class="status-count">${orderSummary.deliveredCount}</div>
						<div class="status-label">배송중</div>
					</div>

					<div
						class="status-item ${activeStatus eq 'confirmed' ? 'active' : ''}">
						<div class="status-count">${orderSummary.confirmedCount}</div>
						<div class="status-label">배송완료</div>
					</div>
				</div>
			</div>

			<!-- ============================ 3. 좋아요 섹션 ============================ -->
			<section class="product-section">
				<div class="section-header">
					<h3 class="section-title">좋아요</h3>
					<a href="/store/mypage/like" class="more-link">더보기 ></a>
				</div>

				<!-- 보배님.. 이게 수정된 카드 데이터 인데.. 우선 노션에 설명은 적겠지만 모르겠으면 바로 저한테 물어보세용ㅜㅜ  -->
				<!-- forEach 문에서 items 부분(현재 productPlanList)만 백엔드에서 내려오는 데이터 이름으로 바꾸시면 됩니다! -->
				<!-- 나머지 수정할 필요 없음 !!! -->
				<div class="product-grid">
					 <c:forEach var="p" items="${wishlist}">
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

						<c:set var="__hasOptionInt" value="${p.hasOption ? 1 : 0}" />
						<c:set var="__isExclusiveInt" value="${p.isExclusive ? 1 : 0}" />
						<c:set var="__isPlannedInt" value="${p.isPlanned ? 1 : 0}" />

						<my:productCard brand="${p.brandName}" productId="${p.productId}"
							title="${p.name}" isWished="${p.isWished}"
							isSale="${p.discountType ne null and p.discountValue ne null 
          and p.startDate ne null 
          and p.endDate ne null 
          and p.startDate.time <= now.time 
          and now.time <= p.endDate.time}"
							hasOption="${__hasOptionInt eq 1}" originPrice="${p.price}"
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
							<c:if test="${__isExclusiveInt ne 0}">
								<my:tag color="green" size="sm" text="단독" />
							</c:if>
							<c:if test="${__isPlannedInt ne 0}">
								<my:tag color="yellow" size="sm" text="기획" />
							</c:if>
						</my:productCard>
					</c:forEach>
				</div>
			</section>

			<!-- ============================ 4. 장바구니 섹션 ============================ -->
			<section class="product-section">
				<div class="section-header">
					<h3 class="section-title">장바구니</h3>
					<a href="/store/mypage/cart" class="more-link">더보기 ></a>
				</div>

				<div class="product-grid">
					<c:forEach var="p" items="${cartItems}">
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

						<c:set var="__hasOptionInt" value="${p.hasOption ? 1 : 0}" />
						<c:set var="__isExclusiveInt" value="${p.isExclusive ? 1 : 0}" />
						<c:set var="__isPlannedInt" value="${p.isPlanned ? 1 : 0}" />

						<my:productCard brand="${p.brandName}" productId="${p.productId}"
							title="${p.name}" isWished="${p.isWished}"
							isSale="${p.discountType ne null and p.discountValue ne null 
          and p.startDate ne null 
          and p.endDate ne null 
          and p.startDate.time <= now.time 
          and now.time <= p.endDate.time}"
							hasOption="${__hasOptionInt eq 1}" originPrice="${p.price}"
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
							<c:if test="${__isExclusiveInt ne 0}">
								<my:tag color="green" size="sm" text="단독" />
							</c:if>
							<c:if test="${__isPlannedInt ne 0}">
								<my:tag color="yellow" size="sm" text="기획" />
							</c:if>
						</my:productCard>
					</c:forEach>
				</div>
			</section>
		</main>
	</div>

	<!-- 하단 푸터 -->
	<%@ include file="/consumer/footer.jsp"%>
</body>
</html>