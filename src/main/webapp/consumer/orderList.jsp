<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문/배송 조회</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="<c:url value='/tagcss/reset.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/header.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/table.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/tag.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/button.css'/>">
<link rel="stylesheet"
	href="<c:url value='/consumer/css/mypageMenu.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>">
<link rel="stylesheet"
	href="<c:url value='/consumer/css/orderStatusCard.css'/>">
<link rel="stylesheet"
	href="<c:url value='/consumer/css/userInfo.css'/>">
<link rel="stylesheet"
	href="<c:url value='/tagcss/dateRangeFilterBox.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/pagination.css'/>">
<link rel="stylesheet"
	href="<c:url value='/consumer/css/orderList.css'/>">


</head>
<body>

	<!-- 상단 헤더 -->
	<%@ include file="/consumer/header.jsp"%>

	<div class="container">
		<!-- Sidebar -->
		<aside class="sidebar">
			<!-- 마이페이지 메뉴 -->
			<%@ include file="/consumer/mypageMenu.jsp"%>
		</aside>

		<div class="page-contents">
			<!-- user info -->
			<div class="user-wrapper">
				<my:userInfo userName="${sessionScope.memberName}"
					points="${memberInfo.pointBalance}"
					coupons="${couponCount}"
					notifications="${sessionScope.memberNotifications}" />
			</div>

			<my:orderStatusCard title="주문/배송 조회"
				orderCount="${orderSummary.orderCount}"
				paymentCount="${orderSummary.paymentCount}"
				shippingCount="${orderSummary.shippingCountt}"
				deliveredCount="${orderSummary.deliveredCount}"
				confirmedCount="${orderSummary.confirmedCount}"
				activeStatus="delivered" />

			<div class="box-wrapper">
				<form action="<c:url value='/store/mypage/orderList'/>" method="get">
					<my:dateRangeFilterBox periods="1,3,6,12" submitLabel="조회"
						size="sm" />
				</form>
			</div>


			<div class="table-wrapper">
				<table class="table">
					<thead>
						<tr>
							<th style="width: 150px;">주문번호</th>
							<th style="width: 380px;">상품</th>
							<th style="width: 46px;">수량</th>
							<th style="width: 103px;">구매가</th>
							<th style="width: 145px;">상태</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${empty orderResult.groupedOrders}">
								<tr>
									<td colspan="5" style="text-align: center; padding: 50px;">
										주문 내역이 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<!-- 주문별 외부 루프 -->
								<c:forEach var="order" items="${orderResult.groupedOrders}">
									<!-- 상품별 내부 루프 -->
									<c:forEach var="item" items="${order.items}"
										varStatus="itemStatus">
										<tr>
											<!-- 첫 번째 상품일 때만 주문번호 셀 표시 -->
											<c:if test="${itemStatus.first}">
												<td class="order-number-cell"
													rowspan="${fn:length(order.items)}">
													<div class="order-date">
														<fmt:formatDate value="${order.orderDate}"
															pattern="yyyy.MM.dd" />
													</div>
													<div class="order-number">${order.orderCode}</div> <a
													href="${pageContext.request.contextPath}/store/mypage/consumerOrderDetail?orderId=${order.ordersId}"
													class="detail-link"> 상세보기</a>
												</td>
											</c:if>

											<!-- 상품 정보 -->
											<td>
												<div style="display: flex; align-items: center; gap: 12px;">
													<div class="product-image">이미지</div>
													<div class="product-info">
														<div class="product-brand">${item.brandName}</div>
														<div class="product-name">
															<a
																href="${pageContext.request.contextPath}/store/productDetail?productId=${item.productId}">
																${item.productName} ${item.productName} <c:if
																	test="${not empty item.optionValue}">
                                            (${item.optionValue})
                                        </c:if>
															</a>
														</div>
													</div>
												</div>
											</td>
											<td>${item.quantity}</td>
											<td><fmt:formatNumber value="${item.total}"
													pattern="#,###" />원</td>
											<td>
												<!-- 상태명 표시 -->
												<div class="order-status">
													<c:choose>
														<c:when test="${item.status == 'PAID'}">결제완료</c:when>
														<c:when test="${item.status == 'PREPARING'}">상품준비중</c:when>
														<c:when test="${item.status == 'SHIPPING'}">배송중</c:when>
														<c:when test="${item.status == 'DELIVERED'}">배송완료</c:when>
														<c:when test="${item.status == 'CONFIRMED'}">구매확정</c:when>
														<c:when test="${item.status == 'CANCELLED'}">취소완료</c:when>
														<c:when test="${item.status == 'EXCHANGE_REQUESTED'}">교환신청</c:when>
														<c:when test="${item.status == 'EXCHANGE_APPROVED'}">교환승인</c:when>
														<c:when test="${item.status == 'COLLECTING'}">회수중</c:when>
														<c:when test="${item.status == 'EXCHANGE_SHIPPING'}">교환배송중</c:when>
														<c:when test="${item.status == 'EXCHANGE_REJECTED'}">교환거절</c:when>
														<c:when test="${item.status == 'EXCHANGE_COMPLETED'}">교환완료</c:when>
														<c:when test="${item.status == 'RETURN_REQUESTED'}">반품신청</c:when>
														<c:when test="${item.status == 'RETURN_APPROVED'}">반품승인</c:when>
														<c:when test="${item.status == 'RETURN_REFUNDING'}">반품대기</c:when>
														<c:when test="${item.status == 'RETURN_REJECTED'}">반품거절</c:when>
														<c:when test="${item.status == 'RETURN_COMPLETED'}">반품완료</c:when>
														<c:otherwise>${item.status}</c:otherwise>
													</c:choose>
												</div>
												<div class="status-button">
													<c:choose>
														<%-- 결제완료, 상품준비중 - 취소신청 --%>
														<c:when
															test="${item.status == 'PAID' || item.status == 'PREPARING'}">
															<button class="btn btn-outline btn-sm"
																onclick="cancelOrder(${item.orderItemId})">취소신청</button>
														</c:when>
														<c:when test="${item.status == 'SHIPPING'}">
															<button class="btn btn-outline btn-sm"
																onclick="trackDelivery('${item.trackingNo}', '${item.carrierName}')">배송조회</button>
														</c:when>

														<%-- 배송완료 - 리뷰작성, 교환신청, 반품신청 (세로 배치) --%>
														<c:when test="${item.status == 'DELIVERED'}">
															<div class="button-vertical">
																<button class="btn btn-outline btn-sm"
																	onclick="writeReview(${item.orderItemId})">리뷰작성</button>
																<button class="btn btn-outline btn-sm"
																	onclick="requestExchange(${item.orderItemId})">교환신청</button>
																<button class="btn btn-outline btn-sm"
																	onclick="requestReturn(${item.orderItemId})">반품신청</button>
															</div>
														</c:when>

														<%-- 교환배송중 - 배송조회 --%>
														<c:when test="${item.status == 'EXCHANGE_SHIPPING'}">
															<button class="btn btn-outline btn-sm"
																onclick="trackDelivery('${item.trackingNo}', '${item.carrierName}')">배송조회</button>
														</c:when>

														<%-- 구매확정 - 리뷰작성만 --%>
														<c:when test="${item.status == 'CONFIRMED'}">
															<button class="btn btn-outline btn-sm"
																onclick="writeReview(${item.orderItemId})">리뷰작성</button>
														</c:when>

														<%-- 기타 상태 - 버튼 없음 --%>
														<c:otherwise>
															<span class="no-action">-</span>
														</c:otherwise>
													</c:choose>
												</div>
											</td>
										</tr>
									</c:forEach>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
			<div class=pagination-wrapper>
			<my:pagination currentPage="${orderResult.currentPage}"
				baseUrl="/store/mypage/orderList" totalPages="${orderResult.totalPages}" />
			</div>
		</div>
	</div>
	<!-- 하단 푸터 -->
	<%@ include file="/consumer/footer.jsp"%>
	<script>
	function cancelOrder(orderItemId) {
	    if(confirm('주문을 취소하시겠습니까?')) {
	        // 취소 처리 로직
	        location.href = '/consumer/cancelOrder?orderItemId=' + orderItemId;
	    }
	}

	function trackDelivery(trackingNo, carrierName) {
	    // 택배 조회 새창으로 열기
	    let url = '';
	    if(carrierName === 'CJ대한통운') {
	        url = `https://www.doortodoor.co.kr/parcel/doortodoor.do?fsp_action=PARC_ACT_002&fsp_cmd=retrieveInvNoACT&invc_no=${trackingNo}`;
	    } else if(carrierName === '롯데택배') {
	        url = `https://www.lotteglogis.com/home/reservation/tracking/linkView?InvNo=${trackingNo}`;
	    }
	    window.open(url, '_blank');
	}

	function writeReview(orderItemId) {
	    location.href = '/consumer/writeReview?orderItemId=' + orderItemId;
	}

	function requestExchange(orderItemId) {
	    location.href = '/consumer/requestExchange?orderItemId=' + orderItemId;
	}

	function requestReturn(orderItemId) {
	    location.href = '/consumer/requestReturn?orderItemId=' + orderItemId;
	}
	</script>
</body>
</html>