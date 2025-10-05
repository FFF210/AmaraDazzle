<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>취소 상세</title>
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
				<my:breadcrumb items="취소관리:/brand/cancelList,취소상세:" />
			</div>

			<!-- 페이지 헤더 -->
			<div class="page-header">
				<h2>취소 상세</h2>
			</div>

			<!-- 취소 상세 폼 -->
			<form class="product-form">

				<section class="form-section">
					<h3>기본 정보</h3>
					<div class="form-group">
						<label>주문번호</label>
						<my:textInput type="link" state="default" size="lg"
							value="${cancelOrderDetail.summary.orderCode}"
							link="/brand/orderDetail?orderId=${cancelOrderDetail.summary.orderId}&from=cancelDetail" />
					</div>
					<div class="form-group">
						<label>요청일</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="${cancelOrderDetail.items[0].cancelledDate}" />
					</div>
					<div class="form-group tag">
						<label>취소상태</label>
						<my:tag color="green" size="lg" text="취소완료" />
					</div>
				</section>

				<section class="form-section">
					<h3>취소 상품</h3>
					<div class="table-wrapper">
						<table class="table">
							<thead>
								<tr>
									<th>번호</th>
									<th>상품명</th>
									<th>옵션</th>
									<th>수량</th>
									<th class="sortable">취소금액 <i
										class="bi bi-dash-lg sort-icon"></i></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="item" items="${cancelOrderDetail.items}"
									varStatus="loop">
									<tr>
										<td>${loop.index + 1}</td>
										<td>${item.productName}</td>
										<td>${item.optionName}</td>
										<td>${item.quantity}</td>
										<td><fmt:formatNumber value="${item.cancelledAmount}"
												type="number" maxFractionDigits="0" groupingUsed="true" /></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div class="form-group-br"></div>
				</section>

				<fmt:formatNumber value="${cancelOrderDetail.summary.totalAmount}"
					type="number" var="fmtTotalAmount" />
				<fmt:formatNumber value="${cancelOrderDetail.summary.usingPoint}"
					type="number" var="fmtUsingPoint" />
				<fmt:formatNumber value="${cancelOrderDetail.summary.couponAmount}"
					type="number" var="fmtCouponAmount" />
				<fmt:formatNumber value="${cancelOrderDetail.summary.actualCancelAmount}"
					type="number" var="fmtActualCancelAmount" />

				<section class="form-section">
					<h3>취소 처리</h3>
					<div class="form-group">
						<label>총 결제 금액</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="${fmtTotalAmount}" />
					</div>
					<div class="form-group">
						<label>쿠폰 할인액</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="${fmtCouponAmount}" />
					</div>
					<div class="form-group chip-wrapper">
						<label>쿠폰 내역</label>
						<div class="chip">${cancelOrderDetail.summary.couponName}</div>
					</div>
					<div class="form-group">
						<label>포인트 사용액</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="${fmtUsingPoint}" />
					</div>
					<div class="form-group">
						<label>실제 취소액</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="${fmtActualCancelAmount}" />
					</div>
				</section>
			</form>
		</div>
	</my:layout>
</body>
</html>
