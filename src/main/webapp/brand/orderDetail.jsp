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
<link rel="stylesheet" href="./css/alert.css" />
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
						<my:breadcrumb items="배송관리:/brand/shippingList,주문상세:" />
					</c:when>
					<c:when test="${param.from eq 'shippingDetail'}">
						<my:breadcrumb
							items="배송관리:/brand/shippingList,배송상세:/brand/shippingDetail?orderId=${param.orderId}&status=${param.status},주문상세:" />
					</c:when>
					<c:when test="${param.from eq 'cancel'}">
						<my:breadcrumb items="취소관리:/brand/cancelList,주문상세:" />
					</c:when>
					<c:when test="${param.from eq 'cancelDetail'}">
						<my:breadcrumb
							items="취소관리:/brand/cancelList,취소상세:/brand/cancelDetail?orderId=${param.orderId},주문상세:" />
					</c:when>
					<c:when test="${param.from eq 'exchange'}">
						<my:breadcrumb items="교환관리:/brand/exchangeList,주문상세:" />
					</c:when>
					<c:when test="${param.from eq 'exchangeDetail'}">
						<my:breadcrumb
							items="교환관리:/brand/exchangeList,교환상세:/brand/exchangeDetail?exchangeId=${param.exchangeId},주문상세:" />
					</c:when>
					<c:when test="${param.from eq 'return'}">
						<my:breadcrumb items="반품관리:/brand/returnList,주문상세:" />
					</c:when>
					<c:when test="${param.from eq 'returnDetail'}">
						<my:breadcrumb
							items="반품관리:/brand/returnList,반품상세:/brand/returnDetail?returnId=${param.returnId},주문상세:" />
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
								<my:tag color="green" size="lg" text="배송완료" />
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
										<td>${item.optionName}</td>
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
													<my:tag color="green" size="sm" text="배송완료" />
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
															data-product-id="${product.productId}"
															onclick="location.href='/brand/shippingDetail?orderId=${orderDetail.summary.ordersId}&status=${item.itemStatus}&from=order'">배송조회</button>
													</c:when>
													<c:when test="${item.itemStatus eq 'DELIVERED'}">
														<button type="button"
															class="btn btn-outline btn-sm btn-release"
															data-product-id="${product.productId}"
															onclick="location.href='/brand/shippingDetail?orderId=${orderDetail.summary.ordersId}&status=${item.itemStatus}&from=order'">배송조회</button>
													</c:when>
													<c:when test="${item.itemStatus eq 'CANCELLED'}">
														<button type="button"
															class="btn btn-outline btn-sm btn-release"
															data-product-id="${product.productId}"
															onclick="location.href='/brand/cancelDetail?orderId=${orderDetail.summary.ordersId}&from=order'">취소조회</button>
													</c:when>
													<c:when test="${item.itemStatus eq 'COLLECTING'}">
														<button type="button"
															class="btn btn-outline btn-sm btn-release"
															data-product-id="${product.productId}"
															onclick="location.href='/brand/shippingDetail?orderId=${orderDetail.summary.ordersId}&status=${item.itemStatus}&from=order'">회수조회</button>
													</c:when>
													<c:when
														test="${fn:startsWith(item.itemStatus, 'EXCHANGE') eq true}">
														<button type="button"
															class="btn btn-outline btn-sm btn-release"
															data-product-id="${product.productId}"
															onclick="location.href='/brand/exchangeDetail?exchangeId=${item.exchangeId}&orderId=${orderDetail.summary.ordersId}&from=order'">교환조회</button>
													</c:when>
													<c:when
														test="${fn:startsWith(item.itemStatus, 'RETURN') eq 'true'}">
														<button type="button"
															class="btn btn-outline btn-sm btn-release"
															data-product-id="${product.productId}"
															onclick="location.href='/brand/returnDetail?returnId=${item.returnId}&orderId=${orderDetail.summary.ordersId}&from=order'">반품조회</button>
													</c:when>
												</c:choose>
											</div></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</section>

				<!-- 배송 정보 -->
				<section class="form-section">
					<h3>배송 정보</h3>
					<div class="form-group">
						<label>송장번호</label>


						<c:choose>
							<c:when
								test="${not empty orderDetail.summary.trackingNo && orderDetail.summary.orderStatus eq 'SHIPPING'}">
								<my:textInput id="trackingNo_${orderDetail.summary.ordersId}"
									type="readOnly" size="lg"
									value="${orderDetail.summary.trackingNo}" />
								<button id="registerBtn_${orderDetail.summary.ordersId}"
									type="button" class="btn btn-primary btn-xl"
									onclick="completeDelivery(${orderDetail.summary.ordersId})">
									배송완료</button>
							</c:when>
							<c:when
								test="${not empty orderDetail.summary.trackingNo && orderDetail.summary.orderStatus eq 'DELIVERED'}">
								<my:textInput id="trackingNo_${orderDetail.summary.ordersId}"
									type="readOnly" size="lg"
									value="${orderDetail.summary.trackingNo}" />
							</c:when>
							<c:when
								test="${empty orderDetail.summary.trackingNo && orderDetail.summary.orderStatus eq 'PAID'}">
								<my:textInput id="trackingNo_${orderDetail.summary.ordersId}"
									type="default" size="lg" value="" />
								<button id="registerBtn_${orderDetail.summary.ordersId}"
									type="button" class="btn btn-primary btn-xl"
									onclick="updateShipping(${orderDetail.summary.ordersId})">
									등록</button>
							</c:when>
						</c:choose>
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
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
function updateShipping(orderId) {
    const trackingNo = $("#trackingNo_" + orderId).val();
    const carrierName = "대한통운";
    const $button = $("#registerBtn_" + orderId);

    if (!trackingNo || !carrierName) {
        alert("운송장번호와 택배사를 모두 입력해주세요.");
        return;
    }
    
    $button.prop("disabled", true).text("등록 중...");

    $.ajax({
        type: "POST",
        url: "<c:url value='/brand/updateShippingInfo'/>",
        data: {
            orderId: orderId,
            trackingNo: trackingNo,
            carrierName: carrierName
        },
        dataType: "json",
        success: function(res) {
            if (res.success) {
            	location.reload(); 
            } else {
                alert("업데이트 실패: " + res.message);
            }
        },
        error: function() {
            alert("서버 오류 발생");
        }
    });
}

function completeDelivery(orderId) {
    const $button = $("#registerBtn_" + orderId);
    
    $button.prop("disabled", true).text("배송 중...");

    $.ajax({
        type: "POST",
        url: "<c:url value='/brand/completeDelivery'/>",
        data: {
            orderId: orderId,
        },
        dataType: "json",
        success: function(res) {
            if (res.success) {
            	location.reload(); 
            } else {
                alert("업데이트 실패: " + res.message);
            }
        },
        error: function() {
            alert("서버 오류 발생");
        }
    });
}
</script>
</body>
</html>
