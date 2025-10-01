<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>주문 상세</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="../tagcss/reset.css" />
<link rel="stylesheet" href="../tagcss/button.css" />
<link rel="stylesheet" href="../tagcss/form-controls.css" />
<link rel="stylesheet" href="../tagcss/layout.css" />
<link rel="stylesheet" href="../tagcss/sidebar.css" />
<link rel="stylesheet" href="../tagcss/brandHeader.css" />
<link rel="stylesheet" href="../tagcss/breadcrumb.css" />
<link rel="stylesheet" href="../tagcss/tag.css" />
<link rel="stylesheet" href="../tagcss/textInput.css" />
<link rel="stylesheet" href="../tagcss/table.css" />
<link rel="stylesheet" href="./css/detailForm.css" />
</head>

<body>
	<my:layout>
		<div class="page-container">

			<!-- breadcrumb -->
			<div class="page-breadcrumb">
				<c:choose>
					<c:when test="${param.from eq 'order'}">
						<my:breadcrumb items="주문관리:/brand/orderList,주문상세:" />
					</c:when>
					<c:when test="${param.from eq 'shipping'}">
						<my:breadcrumb
							items="배송관리:/brand/shippingList,배송상세:/brand/shippingDetail?orderId=${param.orderId}&status=${param.status},주문상세:" />
					</c:when>
					<c:when test="${param.from eq 'cancel'}">
						<my:breadcrumb items="취소관리:/brand/cancelList,주문상세:" />
					</c:when>
					<c:when test="${param.from eq 'exchange'}">
						<my:breadcrumb items="교환관리:/brand/exchangeList,주문상세:" />
					</c:when>
					<c:when test="${param.from eq 'return'}">
						<my:breadcrumb items="반품관리:/brand/returnList,주문상세:" />
					</c:when>
				</c:choose>
			</div>

			<!-- 페이지 헤더 -->
			<div class="page-header">
				<h2>주문 상세</h2>
			</div>

			<!-- 주문 상세 폼 -->
			<form class="product-form">

				<!-- 주문 요약 -->
				<section class="form-section">
					<h3>주문 정보</h3>
					<div class="form-group">
						<label>주문번호</label>
						<my:textInput type="readOnly" size="lg"
							value="${orderDetail.summary.orderCode}" />
					</div>
					<div class="form-group">
						<label>주문일</label>
						<my:textInput type="readOnly" size="lg"
							value="${orderDetail.summary.createdAt}" />
					</div>
					<div class="form-group tag">
						<label>주문상태</label>
						<c:choose>
							<c:when test="${orderDetail.summary.orderStatus == 'PAID'}">
								<my:tag color="yellow" size="lg" text="결제완료" />
							</c:when>
							<c:when test="${orderDetail.summary.orderStatus == 'PREPARING'}">
								<my:tag color="yellow" size="lg" text="상품준비중" />
							</c:when>
							<c:when test="${orderDetail.summary.orderStatus == 'SHIPPING'}">
								<my:tag color="yellow" size="lg" text="배송중" />
							</c:when>
							<c:when test="${orderDetail.summary.orderStatus == 'DELIVERED'}">
								<my:tag color="yellow" size="lg" text="배송완료" />
							</c:when>
							<c:when test="${orderDetail.summary.orderStatus == 'CONFIRMED'}">
								<my:tag color="green" size="lg" text="구매확정" />
							</c:when>
							<c:when test="${orderDetail.summary.orderStatus == 'CANCELLED'}">
								<my:tag color="red" size="lg" text="주문취소" />
							</c:when>
							<c:when test="${orderDetail.summary.orderStatus == 'COLLECTING'}">
								<my:tag color="red" size="lg" text="상품회수중" />
							</c:when>
							<c:when
								test="${fn:startsWith(orderDetail.summary.orderStatus, 'EXCHANGE')}">
								<my:tag color="red" size="lg" text="교환" />
							</c:when>
							<c:when
								test="${fn:startsWith(orderDetail.summary.orderStatus, 'RETURN')}">
								<my:tag color="red" size="lg" text="반품" />
							</c:when>
						</c:choose>
					</div>
					<div class="form-group">
						<label>결제 수단</label>
						<my:textInput type="readOnly" size="lg" value="토스페이" />
					</div>

					<fmt:formatNumber value="${orderDetail.summary.discountAmount}"
						type="number" var="fmtDiscountAmount" />
					<fmt:formatNumber value="${orderDetail.summary.usingPoint}"
						type="number" var="fmtUsingPoint" />
					<fmt:formatNumber value="${orderDetail.summary.totalAmount}"
						type="number" var="fmtTotalAmount" />

					<div class="form-group">
						<label>할인 금액</label>
						<my:textInput type="readOnly" size="lg"
							value="${fmtDiscountAmount}" />
					</div>
					<div class="form-group">
						<label>쿠폰/포인트 금액</label>
						<my:textInput type="readOnly" size="lg" value="${fmtUsingPoint}" />
					</div>
					<div class="form-group chip-wrapper">
						<label>쿠폰 내역</label>
						<c:forEach var="coupon" items="${orderDetail.coupons}">
							<div class="chip">${coupon.cname}</div>
						</c:forEach>
					</div>
					<div class="form-group">
						<label>총 결제 금액</label>
						<my:textInput type="readOnly" size="lg" value="${fmtTotalAmount}" />
					</div>
				</section>

				<!-- 주문자 정보 -->
				<section class="form-section">
					<h3>주문자 정보</h3>
					<div class="form-group">
						<label>주문인</label>
						<my:textInput type="readOnly" size="lg"
							value="${orderDetail.summary.memberName}" />
					</div>
					<div class="form-group">
						<label>연락처</label>
						<my:textInput type="readOnly" size="lg"
							value="${orderDetail.summary.memberPhone}" />
					</div>
					<div class="form-group">
						<label>이메일</label>
						<my:textInput type="readOnly" size="lg"
							value="${orderDetail.summary.memberEmail}" />
					</div>
				</section>

				<!-- 수령인 정보 -->
				<section class="form-section">
					<h3>수령인 정보</h3>
					<div class="form-group">
						<label>수령인</label>
						<my:textInput type="readOnly" size="lg"
							value="${orderDetail.summary.shipRecipient}" />
					</div>
					<div class="form-group">
						<label>연락처</label>
						<my:textInput type="readOnly" size="lg"
							value="${orderDetail.summary.shipPhone}" />
					</div>
					<div class="form-group">
						<label>주소</label>
						<my:textInput type="readOnly" size="lg"
							value="${orderDetail.summary.shipLine1} ${orderDetail.summary.shipLine2}" />
					</div>
				</section>

				<!-- 주문 상품 -->
				<section class="form-section">
					<h3>주문 상품</h3>
					<div class="table-wrapper">
						<table class="table">
							<thead>
								<tr>
									<th>번호</th>
									<th>상품명</th>
									<th>옵션</th>
									<th>수량</th>
									<th>결제금액</th>
									<th>상태</th>
									<th>작업</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="item" items="${orderDetail.items}"
									varStatus="loop">
									<tr>
										<td>${loop.index + 1}</td>
										<td>${item.productName}</td>
										<td><c:out value="${item.optionName}" /></td>
										<td>${item.quantity}</td>
										<td><fmt:formatNumber value="${item.total}" type="number"
												maxFractionDigits="0" groupingUsed="true" /></td>
										<td><c:choose>
												<c:when test="${item.itemStatus == 'PAID'}">
													<my:tag color="yellow" size="sm" text="결제완료" />
												</c:when>
												<c:when test="${item.itemStatus == 'PREPARING'}">
													<my:tag color="yellow" size="sm" text="상품준비중" />
												</c:when>
												<c:when test="${item.itemStatus == 'SHIPPING'}">
													<my:tag color="yellow" size="sm" text="배송중" />
												</c:when>
												<c:when test="${item.itemStatus == 'DELIVERED'}">
													<my:tag color="yellow" size="sm" text="배송완료" />
												</c:when>
												<c:when test="${item.itemStatus == 'CONFIRMED'}">
													<my:tag color="green" size="sm" text="구매확정" />
												</c:when>
												<c:when test="${item.itemStatus == 'CANCELLED'}">
													<my:tag color="red" size="sm" text="주문취소" />
												</c:when>
												<c:when test="${item.itemStatus == 'COLLECTING'}">
													<my:tag color="gray" size="sm" text="상품회수중" />
												</c:when>
												<c:when test="${fn:startsWith(item.itemStatus, 'EXCHANGE')}">
													<my:tag color="red" size="sm" text="교환" />
												</c:when>
												<c:when test="${fn:startsWith(item.itemStatus, 'RETURN')}">
													<my:tag color="red" size="sm" text="반품" />
												</c:when>
											</c:choose></td>
										<td><div class="actions">
												<c:choose>
													<c:when test="${item.itemStatus eq 'SHIPPING'}">
														<button type="button"
															class="btn btn-outline btn-sm btn-release"
															data-product-id="${product.productId}">배송조회</button>
													</c:when>
													<c:when test="${item.itemStatus eq 'DELIVERED'}">
														<button type="button"
															class="btn btn-outline btn-sm btn-release"
															data-product-id="${product.productId}">배송조회</button>
													</c:when>
													<c:when test="${item.itemStatus eq 'CANCELLED'}">
														<button type="button"
															class="btn btn-outline btn-sm btn-release"
															data-product-id="${product.productId}">취소조회</button>
													</c:when>
													<c:when test="${item.itemStatus eq 'COLLECTING'}">
														<button type="button"
															class="btn btn-outline btn-sm btn-release"
															data-product-id="${product.productId}">회수조회</button>
													</c:when>
													<c:when
														test="${fn:startsWith(item.itemStatus, 'EXCHANGE') eq true}">
														<button type="button"
															class="btn btn-outline btn-sm btn-release"
															data-product-id="${product.productId}">교환조회</button>
													</c:when>
													<c:when
														test="${fn:startsWith(item.itemStatus, 'RETURN') eq 'true'}">
														<button type="button"
															class="btn btn-outline btn-sm btn-release"
															data-product-id="${product.productId}">반품조회</button>
													</c:when>
												</c:choose>
											</div></td>
									</tr>
								</c:forEach>
								<c:if test="${empty orderDetail.items}">
									<tr>
										<td colspan="6">주문 상품이 없습니다.</td>
									</tr>
								</c:if>
							</tbody>
						</table>
					</div>
				</section>

				<!-- 배송 정보 -->
				<section class="form-section">
					<h3>배송 정보</h3>
					<div class="form-group">
						<label>송장번호</label>
						<my:textInput type="default" size="lg"
							value="${orderDetail.summary.trackingNo}" />
						<button type="button" class="btn btn-primary btn-xl">등록</button>
					</div>
					<div class="form-group">
						<label>배송 요청사항</label>
						<my:textInput type="readOnly" size="lg"
							value="${orderDetail.summary.note}" />
					</div>
				</section>

			</form>
		</div>
	</my:layout>
</body>
</html>
