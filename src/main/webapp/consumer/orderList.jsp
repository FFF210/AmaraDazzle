<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<link rel="stylesheet" href="<c:url value='/consumer/css/mypageMenu.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/orderStatusCard.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/userInfo.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/dateRangeFilterBox.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/pagination.css'/>">


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
				<my:userInfo userName="홍길동" points="903" coupons="0"
					notifications="2" />
				<my:orderStatusCard title="주문/배송 조회" orderCount="0" paymentCount="0"
					shippingCount="0" deliveredCount="2" confirmedCount="2"
					activeStatus="delivered" />

				<div class="box-wrapper">
					<my:dateRangeFilterBox periods="1,3,6,12" submitLabel="조회" />
				</div>
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
					<tr>
						<td class="order-number-cell" rowspan="2">
							<div class="order-date">2025.09.07</div>
							<div class="order-number">Y234352234</div> <a href="#"
							class="detail-link">상세보기</a>
						</td>
						<td>
							<div style="display: flex; align-items: center; gap: 12px;">
								<div class="product-image">이미지</div>
								<div class="product-info">
									<div class="product-brand">일리</div>
									<div class="product-name">일리 신더렐라 단팥철쭉이크 40g 5종 택1</div>
								</div>
							</div>
						</td>
						<td>1</td>
						<td>39,000원</td>
						<td>
							<div class="status-button">
								<button class="btn btn-outline btn-sm">배송조회</button>
								<button class="btn btn-outline btn-sm">리뷰작성</button>
								<button class="btn btn-outline btn-sm">교환신청</button>
								<button class="btn btn-outline btn-sm">반품신청</button>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div style="display: flex; align-items: center; gap: 12px;">
								<div class="product-image">이미지</div>
								<div class="product-info">
									<div class="product-brand">일리</div>
									<div class="product-name">일리 신더렐라 단팥철쭉이크 40g 5종 택1</div>
								</div>
							</div>
						</td>
						<td>1</td>
						<td>39,000원</td>
						<td>
							<div class="status-button">
								<button class="btn btn-outline btn-sm">배송조회</button>
								<button class="btn btn-outline btn-sm">리뷰작성</button>
								<button class="btn btn-outline btn-sm">교환신청</button>
								<button class="btn btn-outline btn-sm">반품신청</button>
							</div>
						</td>
					</tr>
				</table>
			</div>
			<my:pagination currentPage="1" baseUrl="" totalPages="3" />
		</div>
	</div>
	<!-- 하단 푸터 -->
	<%@ include file="/consumer/footer.jsp"%>
</body>
</html>