<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>정산 대시보드</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="./css/reset.css" />
<link rel="stylesheet" href="./css/button.css" />
<link rel="stylesheet" href="./css/form-controls.css" />
<link rel="stylesheet" href="./css/layout.css" />
<link rel="stylesheet" href="./css/sidebar.css" />
<link rel="stylesheet" href="./css/header.css" />
<link rel="stylesheet" href="./css/alert.css" />
<link rel="stylesheet" href="./css/settlementDashboard.css" />
</head>
<body>
	<my:layout>
		<div class="settlement-dashboard">

			<!-- 상단: 카드 + 도넛 차트 -->
			<div class="top-section">
				<div class="cards-grid">
					<div class="card-item">
						<i class="bi bi-coin"></i>
						<div>
							<p class="card-label">이번 달 정산 예정 금액</p>
							<p class="card-value">2,750,000원</p>
						</div>
					</div>
					<div class="card-item">
						<i class="bi bi-receipt"></i>
						<div>
							<p class="card-label">이번 달 수수료</p>
							<p class="card-value">2,750,000원</p>
						</div>
					</div>
					<div class="card-item">
						<i class="bi bi-cart-check"></i>
						<div>
							<p class="card-label">이번 달 총 주문 금액</p>
							<p class="card-value">2,750,000원</p>
						</div>
					</div>
					<div class="card-item">
						<i class="bi bi-cash-coin"></i>
						<div>
							<p class="card-label">이번 달 순수 매출액</p>
							<p class="card-value">2,750,000원</p>
						</div>
					</div>
				</div>

				<div class="donut-chart">
					<h3 class="chart-title">총 주문 금액</h3>
					<div id="donutChart"></div>
					<ul class="chart-legend">
						<li><span class="legend-color green"></span>쿠폰/포인트 합계</li>
						<li><span class="legend-color blue"></span>순수 매출액</li>
						<li><span class="legend-color pink"></span>수수료</li>
					</ul>
				</div>
			</div>

			<!-- 하단: 바 차트 -->
			<div class="bottom-section">
				<h3 class="chart-title">월 단위 정산 금액 추이</h3>
				<div id="barChart"></div>
			</div>

		</div>
	</my:layout>
</body>
</html>
