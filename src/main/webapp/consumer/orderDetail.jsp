<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>주문 상세정보</title>
<link rel="stylesheet" href="<c:url value='/tagcss/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/modalRecent.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/productCard.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/tag.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/pagination.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/heartBtn.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/price.css'/>" />
<link rel="stylesheet" href="<c:url value='/consumer/css/header.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>">
<link rel="stylesheet"
	href="<c:url value='/consumer/css/orderDetail.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/textInput.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/table.css'/>">
<link rel="stylesheet"
	href="<c:url value='/consumer/css/mypageMenu.css'/>">

</head>
<body>
	<%-- 헤더 --%>
	<%@ include file="/consumer/header.jsp"%>

	<div class="page-wrap">
		<div class="page-grid">
			<%-- 좌측 마이페이지 메뉴 --%>
			<%@ include file="/consumer/mypageMenu.jsp"%>

			<main class="content">
				<%-- 주문상세정보--%>
				<section class="section">
					<h1 class="page-title">주문 상세정보</h1>
					<div class="order-info">
						<div class="info-item">
							<span class="label">주문일자:</span> <span class="value"> <fmt:formatDate
									value="${orderDetailInfo.order.createdAt}" pattern="yyyy-MM-dd" />
							</span> <span class="value order-number">${orderDetailInfo.order.orderCode}</span>
						</div>
					</div>
				</section>

				<%-- ===== 배송상품 ===== --%>
				<section class="section">
					<h2 class="section-title">배송상품</h2>
					<p class="section-subtitle">총
						${fn:length(orderDetailInfo.orderItems)}건</p>

					<div class="table-wrapper" style="overflow: auto">
						<table class="table">
							<thead>
								<tr>
									<th>상품명</th>
									<th>판매가</th>
									<th>수량</th>
									<th>구매가</th>
									<th>진행현황</th>
									<th>선택</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="item" items="${orderDetailInfo.orderItems}">
									<tr>
										<td>
											<div class="product-info">
												<span class="brand">${item.brandName}</span><br> <span
													class="product-name"> ${item.productName} <c:if
														test="${not empty item.optionValue}">
														<br>
														<small>(${item.optionValue})</small>
													</c:if>
												</span>
											</div>
										</td>
										<td><fmt:formatNumber value="${item.unitPrice}"
												pattern="#,###" />원</td>
										<td>${item.quantity}</td>
										<td class="price-highlight"><fmt:formatNumber
												value="${item.total}" pattern="#,###" />원</td>
										<td>
											<%-- 상태별 한글 표시 --%> <c:choose>
												<c:when test="${item.status == 'PAID'}">결제완료</c:when>
												<c:when test="${item.status == 'PREPARING'}">상품준비중</c:when>
												<c:when test="${item.status == 'SHIPPING'}">배송중</c:when>
												<c:when test="${item.status == 'DELIVERED'}">배송완료</c:when>
												<c:when test="${item.status == 'CONFIRMED'}">구매확정</c:when>
												<c:otherwise>${item.status}</c:otherwise>
											</c:choose>
										</td>
										<td>
											<%-- 상태별 버튼 (orderList와 동일 로직) --%> <c:choose>
												<c:when
													test="${item.status == 'PAID' || item.status == 'PREPARING'}">
													<button type="button" class="action-btn">취소신청</button>
												</c:when>
												<c:when test="${item.status == 'SHIPPING'}">
													<button type="button" class="action-btn">배송조회</button>
												</c:when>
												<c:when test="${item.status == 'DELIVERED'}">
													<button onclick="location.href='${pageContext.request.contextPath}/store/mypage/myReview'" type="button" class="action-btn">리뷰작성</button>
												</c:when>
											</c:choose>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</section>

				<%-- ===== 배송지 정보 ===== --%>
				<section class="section od-ship">
					<h2 class="section-title">배송지 정보</h2>

					<div class="form-rows">
						<!-- 받는분 -->
						<div class="row">
							<div class="label">받는분</div>
							<div class="input-wrapper">
								<my:textInput type="readOnly" name="name"
									value="${orderDetailInfo.order.shipRecipient}" size="lg" />
							</div>
						</div>

						<!-- 주소 -->
						<div class="row">
							<div class="label">주소</div>
							<div class="addr">
								<!-- 1) 우편번호: 단독 한 줄 -->
								<div class="addr-row">
									<my:textInput type="readOnly" name="postcode"
										value="(${orderDetailInfo.order.shipPostcode})" size="lg" />
								</div>

								<!-- 2) 도로명 / 지번: 2열 -->
								<div class="addr-row addr-grid-2">
									<my:textInput type="readOnly" name="mainAddress"
										value="${orderDetailInfo.order.shipLine1}" size="lg" />
									<my:textInput type="readOnly" name="detailAddress"
										value="${orderDetailInfo.order.shipLine2}" size="lg" />
								</div>
							</div>
						</div>

						<!-- 연락처 -->
						<div class="row">
							<div class="label">연락처</div>
							<div class="input-wrapper">
								<my:textInput id="연락처" name="phoneNumber" type="readOnly"
									value="${orderDetailInfo.order.shipPhone}" size="lg" />
							</div>
						</div>

						<!-- 요청사항 -->
						<div class="row">
							<div class="label">배송 요청 사항</div>
							<div class="input-wrapper">
								<my:textInput id="배송요청사항" name="request" type="readOnly"
									value="${orderDetailInfo.order.note}" size="lg" />
							</div>
						</div>
					</div>
				</section>

				<%-- ===== 결제 정보 ===== --%>
				<section class="section od-payment">
					<h2 class="section-title">결제 정보</h2>

					<div class="form-rows">
						<div class="row">
							<div class="label">총 주문금액</div>
							<div class="input-wrapper">
								<my:textInput type="readOnly"
									value="${orderDetailInfo.paymentInfo.subtotalAmountText}"
									size="lg" />
							</div>
						</div>

						<div class="row">
							<div class="label">총 할인금액</div>
							<div class="input-wrapper">
								<my:textInput type="readOnly"
									value="${orderDetailInfo.paymentInfo.discountAmountText}"
									size="lg" />
							</div>
						</div>

						<div class="row">
							<div class="label">쿠폰 할인</div>
							<div class="input-wrapper">
								<my:textInput type="readOnly"
									value="${orderDetailInfo.paymentInfo.couponDisplayText}"
									size="lg" />
							</div>
						</div>

						<div class="row">
							<div class="label">포인트 사용</div>
							<div class="input-wrapper">
								<my:textInput type="readOnly"
									value="${orderDetailInfo.paymentInfo.usingPointText}" size="lg" />
							</div>
						</div>

						<div class="row">
							<div class="label">총 결제금액</div>
							<div class="input-wrapper">
								<my:textInput type="readOnly"
									value="${orderDetailInfo.paymentInfo.totalAmountText}"
									size="lg" />
							</div>
						</div>

						<div class="row">
							<div class="label">결제수단</div>
							<div class="input-wrapper">
								<my:textInput type="readOnly" value="토스 페이먼츠" size="lg" />
							</div>
						</div>
					</div>
				</section>

				<div class="page-actions">
					<a href="${pageContext.request.contextPath}/store/mypage/orderList"
						class="btn-primary">목록</a>
				</div>
			</main>
		</div>
	</div>

	<%-- 푸터 --%>
	<%@ include file="/consumer/footer.jsp"%>
</body>
</html>
