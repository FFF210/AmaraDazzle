<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>배송 상세</title>
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
<link rel="stylesheet" href="./css/table.css" />
<link rel="stylesheet" href="./css/detailForm.css" />
</head>

<body>
	<my:layout>
		<div class="page-container">

			<!-- breadcrumb -->
			<div class="page-breadcrumb">
				<my:breadcrumb items="배송관리:/brand/shippingList,배송상세:" />
			</div>

			<!-- 페이지 헤더 -->
			<div class="page-header">
				<h2>배송 상세</h2>
			</div>

			<!-- 취소 상세 폼 -->
			<form class="product-form">

				<section class="form-section">
					<h3>기본 정보</h3>
					<div class="form-group">
						<label>주문번호</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="${shippingDetail.summary.orderCode}" />
					</div>
					<div class="form-group">
						<label>운송장번호</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="${shippingDetail.summary.trackingNo}" />
					</div>
					<div class="form-group tag">
						<label>배송상태</label>
						<c:choose>
							<c:when test="${shippingDetail.summary.displayStatus == 'SHIPPING'}">
								<my:tag color="blue" size="lg" text="배송중" />
							</c:when>
							<c:when test="${shippingDetail.summary.displayStatus == 'DELIVERED'}">
								<my:tag color="green" size="lg" text="배송완료" />
							</c:when>
							<c:when test="${shippingDetail.summary.displayStatus == 'COLLECTING'}">
								<my:tag color="orange" size="lg" text="상품 회수중" />
							</c:when>
							<c:when test="${shippingDetail.summary.displayStatus == 'EXCHANGE SHIPPING'}">
								<my:tag color="purple" size="lg" text="교환 배송중" />
							</c:when>
						</c:choose>
					</div>
				</section>
				
				section class="form-section">
					<h3>수령인 정보</h3>
					<div class="form-group">
						<label>수령인</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="${shippingDetail.summary.shipRecipient}" />
					</div>
					<div class="form-group">
						<label>연락처</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="${shippingDetail.summary.shipPhone}" />
					</div>
					<div class="form-group">
						<label>주소</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="${shippingDetail.summary.shipAddress}" />
					</div>
					<div class="form-group">
						<label>배송 요청사항</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="${shippingDetail.summary.note}" />
					</div>
				</section>

				<section class="form-section">
					<h3>배송 상품</h3>
					<div class="table-wrapper">
						<table class="table">
							<thead>
								<tr>
									<th>번호</th>
									<th>상품명</th>
									<th>옵션</th>
									<th>수량</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="item" items="${shippingDetail.items}" varStatus="loop">
									<tr>
										<td>${loop.index + 1}</td>
										<td>${item.productName}</td>
										<td><c:out value="${item.optionName}" default="-" /></td>
										<td>${item.quantity}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</section>
			</form>
		</div>
	</my:layout>
</body>
</html>
