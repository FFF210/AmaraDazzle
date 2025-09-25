<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이 쿠폰 / 포인트</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="./tagcss/reset.css" />
<link rel="stylesheet" href="./consumer/css/header.css" />
<link rel="stylesheet" href="./consumer/css/mypageMenu.css" />
<link rel="stylesheet" href="./consumer/css/footer.css" />
<link rel="stylesheet" href="./consumer/css/userInfo.css" />
<link rel="stylesheet" href="./tagcss/table.css" />
<link rel="stylesheet" href="./tagcss/button.css" />
<link rel="stylesheet" href="./tagcss/dateRangeFilterBox.css" />
<link rel="stylesheet" href="./consumer/css/myCoupoint.css" />
<link rel="stylesheet" href="./tagcss/coupon.css" />

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

		<!-- Main Content -->
		<main class="main-content">

			<!-- user info -->
			<my:userInfo userName="홍길동" points="903" coupons="0"
				notifications="2" />

			<h3>마이 쿠폰 / 포인트</h3>

			<!-- 쿠폰 섹션 -->
			<section class="coupon">
				<!-- 보유 쿠폰 테이블 -->
				<div class="table-wrapper">
					<table class="table">
						<thead>
							<tr>
								<th style="width: 580px;">쿠폰명</th>
								<th style="width: 140px;">쿠폰사용조건</th>
								<th style="width: 140px;">사용가능기간</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="coupon-name">쿠폰 이미지 , [9월 BABY] 3만원 이상 1천원 할인</td>
								<td>30,000원 이상</td>
								<td>2025.09 ~ 2025.09.31</td>
							</tr>
						</tbody>
					</table>
				</div>
				<button class="btn btn-primary btn-md" id="coupon-zone">쿠폰존
					바로가기</button>

			</section>

			<!-- 포인트 섹션 -->
			<section class="point">
				<div class="middle-devider">
					<h2>사용가능한 포인트: 903 P</h2>
				</div>
				<div>
					<my:dateRangeFilterBox periods="1,3,6,12" submitLabel="조회" />

					<div class="table-wrapper">
						<table class="table">
							<thead>
								<tr>
									<th style="width: 140px;">일자</th>
									<th style="width: 580px;">내용</th>
									<th style="width: 140px;">적립/사용</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>2025.09.07</td>
									<td>주문 적립 <br> 주문번호 : Y2509072282558
									</td>
									<td>+19P</td>
								</tr>
								<tr>
									<td>2025.09.07</td>
									<td>주문 적립 <br> 주문번호 : Y2509072282558
									</td>
									<td>+19P</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</section>
		</main>
	</div>
	<!-- 하단 푸터 -->
	<%@ include file="/consumer/footer.jsp"%>
</body>
</html>