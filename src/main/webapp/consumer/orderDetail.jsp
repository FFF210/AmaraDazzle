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
<link rel="stylesheet" href="<c:url value='/tagcss/textInput.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/table.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/button.css'/>">
<link rel="stylesheet"
	href="<c:url value='/consumer/css/mypageMenu.css'/>">
<link rel="stylesheet"
	href="<c:url value='/consumer/css/orderDetail.css'/>">

</head>
<body>
	<%-- 헤더 --%>
	<%@ include file="/consumer/header.jsp"%>

	<div class="container">

		<%-- 마이페이지 메뉴 --%>
		<%@ include file="/consumer/mypageMenu.jsp"%>

		<div class="page-contents">

			<%-- 주문상세정보--%>
			<section class="section">
				<h1 class="page-title">주문 상세정보</h1>
				<div class="order-info">
					<div class="info-item">
						<p>
							<span class="label">주문일자:</span> <span class="value"> <fmt:formatDate
									value="${orderDetailInfo.order.createdAt}" pattern="yyyy-MM-dd" />
							</span>
						</p>
						<p>
							<span class="label">주문번호:</span> <span class="value order-number">${orderDetailInfo.order.orderCode}</span>
						</p>
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
								<th style="width: 150px; padding: 0;">상품명</th>
								<th style="width: 60px; padding: 0;">판매가</th>
								<th style="width: 30px; padding: 0;">수량</th>
								<th style="width: 60px; padding: 0;">결제금액</th>
								<th style="width: 80px; padding: 0;">진행현황</th>
								<th style="width: 80px; padding: 0;">선택</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="item" items="${orderDetailInfo.orderItems}">
								<tr>
									<td style="padding: 0; cursor: pointer;"
										onclick="location.href='${pageContext.request.contextPath}/store/productDetail?productId=${item.productId}'">
										<div
											style="display: flex; align-items: center; gap: 12px; padding: 20px 0;">
											<img
												src="${pageContext.request.contextPath}/image?fileId=${item.thumbnailFileId}"
												alt="${item.productName}"
												style="width: 80px; height: 80px; object-fit: cover;">
											<div class="product-info"
												style="text-align: left; display: flex; flex-direction: column; width: 100%; height: fit-content; gap: 6px;">
												<p class="product-brand"
													style="color: #333; font-weight: 700; font-size: 13px;">${item.brandName}</p>
												<p class="product-name">${item.productName}</p>
												<c:if test="${not empty item.optionValue}">
													<P style="color: #888; font-weight: 400; font-size: 13px;">옵션
														| ${item.optionValue}</P>
												</c:if>
											</div>
										</div>
									</td>
									<td style="padding: 0; color: #111; font-size: 13px;"><fmt:formatNumber
											value="${item.unitPrice}" pattern="#,###" />원</td>
									<td style="padding: 0; color: #111; font-size: 13px;">${item.quantity}</td>
									<td class="price-highlight"><c:choose>
											<c:when test="${item.total lt item.unitPrice}">
												<div class="price-wrapper">
													<span class="original-price"> <fmt:formatNumber
															value="${item.unitPrice}" pattern="#,###" />원
													</span> <span class="discounted-price"> <fmt:formatNumber
															value="${item.total}" pattern="#,###" />원
													</span>
												</div>
											</c:when>
											<c:otherwise>
												<span class="normal-price"> <fmt:formatNumber
														value="${item.total}" pattern="#,###" />원
												</span>
											</c:otherwise>
										</c:choose></td>

									<td style="padding: 0; color: #111; font-size: 13px;">
										<%-- 상태별 한글 표시 --%> <c:choose>
											<c:when test="${item.status == 'PAID'}">결제완료</c:when>
											<c:when test="${item.status == 'PREPARING'}">상품준비중</c:when>
											<c:when test="${item.status == 'SHIPPING'}">배송중</c:when>
											<c:when test="${item.status == 'DELIVERED'}">배송완료</c:when>
											<c:when test="${item.status == 'CANCELLED'}">주문취소</c:when>
											<c:when test="${item.status == 'CONFIRMED'}">구매확정</c:when>
											<c:otherwise>${item.status}</c:otherwise>
										</c:choose>
									</td>
									<td style="padding: 0;">
										<%-- 상태별 버튼 (orderList와 동일 로직) --%> <c:choose>
											<c:when
												test="${item.status == 'PAID' || item.status == 'PREPARING'}">
												<button type="button"
													class="btn btn-outline btn-sm action-btn"
													onclick="cancelOrderItem(${item.orderItemId})"
													style="width: 90px;">주문취소</button>
											</c:when>
											<c:when test="${item.status == 'SHIPPING'}">
												<button type="button"
													class="btn btn-outline btn-sm action-btn"
													style="width: 90px;">배송조회</button>
											</c:when>
											<c:when test="${item.status == 'DELIVERED'}">
												<button
													onclick="location.href='${pageContext.request.contextPath}/store/mypage/myReview'"
													type="button" class="btn btn-outline btn-sm action-btn"
													style="width: 90px;">리뷰작성</button>
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

				<div class="form-rows"
					style="margin-top: 20px; border-top: 1.5px solid #f1f1f1; border-bottom: 1.5px solid #f1f1f1;">
					<!-- 받는분 -->
					<div class="row" style="border-bottom: 1px solid #f1f1f1;">
						<div class="label">받는분</div>
						<div class="input-wrapper">
							<my:textInput type="readOnly" name="name"
								value="${orderDetailInfo.order.shipRecipient}" size="lg" />
						</div>
					</div>

					<!-- 주소 -->
					<div class="row"
						style="height: 80px; border-bottom: 1px solid #f1f1f1;">
						<div class="label">주소</div>
						<div class="addr">
							<!-- 1) 우편번호: 단독 한 줄 -->
							<div class="addr-row">
								<div class="text-input-wrapper size--lg state--default">
									<div class="text-input-inner readOnly">
										<input type="text" name="postcode" class="text-input readOnly"
											value="(${orderDetailInfo.order.shipPostcode})" readOnly
											style="height: 30px;" />
									</div>
								</div>
							</div>

							<!-- 2) 도로명 / 지번: 2열 -->
							<div class="addr-row addr-grid-2">
								<div class="text-input-wrapper size--lg state--default">
									<div class="text-input-inner readOnly">
										<input type="text" name="mainAddress"
											class="text-input readOnly"
											value="도로명: ${orderDetailInfo.order.shipLine1} ${orderDetailInfo.order.shipLine2}"
											readOnly style="height: 30px;" />
									</div>
								</div>
							</div>
						</div>
					</div>

					<!-- 연락처 -->
					<div class="row" style="border-bottom: 1px solid #f1f1f1;">
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
				<div
					style="display: flex; width: 100%; align-items: start; justify-content: space-between; border-top: 1.5px solid #f1f1f1; border-bottom: 1.5px solid #f1f1f1; margin-top: 20px;">
					<div
						style="padding: 30px 60px; display: flex; flex-direction: column; gap: 10px; align-items: center;">
						<h4 style="font-size: 18px; color: #333;">주문금액</h4>
						<p style="font-size: 20px; color: #ff4444; font-weight: 700;">${orderDetailInfo.paymentInfo.subtotalAmountText}</p>
					</div>

					<div
						style="padding: 30px 60px; display: flex; flex-direction: column; gap: 10px; align-items: center;">
						<h4 style="font-size: 18px; color: #333;">쿠폰할인금액</h4>
						<div
							style="display: flex; flex-direction: column; align-items: center; gap: 4px;">

							<c:choose>
								<c:when
									test="${orderDetailInfo.paymentInfo.couponDisplayText == '0원'}">
									<p style="font-size: 20px; color: #ff4444; font-weight: 700;">
										${orderDetailInfo.paymentInfo.couponDisplayText}</p>
								</c:when>
								<c:otherwise>
									<p style="font-size: 20px; color: #ff4444; font-weight: 700;">-${orderDetailInfo.paymentInfo.couponDisplayText}</p>
									<p
										style="background: rgb(255, 68, 68, 0.1); padding: 4px 12px; border-radius: 8px; font-size: 13px; font-weight: 500; color: #333;">${orderDetailInfo.paymentInfo.couponName}</p>
								</c:otherwise>
							</c:choose>
						</div>
					</div>

					<div
						style="padding: 30px 60px; display: flex; flex-direction: column; gap: 10px; align-items: center;">
						<h4 style="font-size: 18px; color: #333;">포인트 결제</h4>
						<p style="font-size: 20px; color: #ff4444; font-weight: 700;">
							<c:choose>
								<c:when
									test="${empty orderDetailInfo.paymentInfo.usingPointText}">
									0
      
    </c:when>
								<c:otherwise>${orderDetailInfo.paymentInfo.usingPointText}
    </c:otherwise>
							</c:choose>
						</p>
					</div>
				</div>

				<div
					style="display: flex; flex-direction: column; align-items: end; padding: 20px 30px; background: #f9f9f9;">
					<h3 style="font-size: 20px;">
						총 결제금액   <span style="color: #7421C4">${orderDetailInfo.paymentInfo.totalAmountText}</span>
					</h3>
					<p style="font-size: 13px; color: #999;">토스페이</p>
				</div>
			</section>

			<div class="page-actions">
				<button
					onclick="location.href='${pageContext.request.contextPath}/store/mypage/orderList'"
					class="btn btn-primary btn-xl" style="width: 300px;">목록</button>

			</div>
		</div>
	</div>

	<%-- 푸터 --%>
	<%@ include file="/consumer/footer.jsp"%>
	<script>
	function cancelOrderItem(orderItemId) {
	    if(confirm('정말로 주문을 취소하시겠습니까?')) {
	        location.href = '${pageContext.request.contextPath}/store/cancelOrder?orderItemId=' + orderItemId;
	    }
	}
	</script>
</body>
</html>
