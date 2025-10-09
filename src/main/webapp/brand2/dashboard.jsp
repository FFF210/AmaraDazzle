<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대시보드 화면</title>

<!-- Pretendard 폰트 (CDN) -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css">

<!-- flatpickr 기본 테마 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/themes/light.css">

<!-- 한글화 & 커스텀 CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/custom-flatpickr.css">

<link rel="stylesheet" href="./css/dashboard.css" />

<link rel="stylesheet" href="../tagcss/tag.css" />
<link rel="stylesheet" href="../tagcss/breadcrumb.css" />
<link rel="stylesheet" href="../tagcss/dateInput.css" />
<link rel="stylesheet" href="../tagcss/form-controls.css" />
<link rel="stylesheet" href="../tagcss/brandHeader.css" />
<link rel="stylesheet" href="../tagcss/layout.css" />
<link rel="stylesheet" href="../tagcss/reset.css" />
<link rel="stylesheet" href="../tagcss/selectbox.css" />
<link rel="stylesheet" href="../tagcss/sidebar.css" />
<link rel="stylesheet" href="../tagcss/pagination.css" />
<link rel="stylesheet" href="../tagcss/table.css" />
<link rel="stylesheet" href="../tagcss/button.css" />
<link rel="stylesheet" href="../tagcss/tableFilter.css" />
<link rel="stylesheet" href="../tagcss/textInput.css" />

<!-- 달력 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

<!-- Chart.js CDN -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
.breadcrumb {
	margin-top: 8px;
	margin-left: 24px;
}
</style>

</head>
<body>
<%--
-- orders
subtotal_amount = 100,000   -- 상품금액 합계 (할인 전)
discount_amount = 10,000    -- 전체 할인
shipping_amount = 2,500     -- 배송비
total_amount    = 92,500    -- 최종 결제 금액 (= 100,000 - 10,000 + 2,500)

-- order_item
unit_price   = 100,000
quantity     = 1
line_subtotal = 100,000     -- 라인 소계 (상품금액)
discount      = 10,000
total         = 90,000      -- 라인 최종 금액
status        = CONFIRMED

 --%>
	<my:layout>
		<my:breadcrumb
			items="대시보드:/brand2/dashboard, 매출지표:/brand2/salesStatus.jsp, 성과지표:/brand2/salesStatus.jsp. 마케팅메일 성과:/brand2/salesStatus.jsp, 메인이벤트지표:/brand2/salesStatus.jsp" />

		<div class=dachcontainer>
			<!-- KPI 지표 -->
			<div class="kpi-cards">
				<div class="card">
					<h4>오늘 매출</h4>
					<p>
						<fmt:formatNumber value="${salesToday}" type="number"
							groupingUsed="true" />원
					</p>
					<span>${todayProductCount}개의 제품이 팔렸어요!</span>
				</div>
				<div class="card">
					<h4>어제 매출</h4>
					<p>
						<fmt:formatNumber value="${salesYesterday}" type="number"
							groupingUsed="true" />원
					</p>
					<span>${yesterdayProductCount}개의 제품이 팔렸어요!</span>
				</div>
				<div class="card">
					<h4>이번 주 매출</h4>
					<p>
						<fmt:formatNumber value="${salesWeek}" type="number"
							groupingUsed="true" />원
					</p>
					<span>${weekProductCount}개의 제품이 팔렸어요!</span>
				</div>
			</div>

			<!-- 매출 그래프 -->
			<div class="chart-box">
				<h3>총 매출액</h3>
				<p class="total-sales">
					<fmt:formatNumber value="${totalSales}" type="number"
						groupingUsed="true" />원
					<span class="trend up">▲ 지난 달보다 ${salesGrowth}% 상승했어요!</span>
				</p>
				<canvas id="salesCompareChart"></canvas>
			</div>
<%--
			<!-- 메일 성과 -->
			<div class="performance">
				<div class="perf-card">
					<div class="icon">
						<i class="bi bi-coin"></i>
					</div>

					<h4>구매전환율</h4>
					<p>${mailOpenCount}</p>
					<span class="rate up">+100%</span>
				</div>
				<div class="perf-card">
					<div class="icon">
						<i class="bi bi-envelope"></i>
					</div>
					<h4>메일열람 수</h4>
					<p>${mailClickCount}</p>
					<span class="rate up">+100%</span>
				</div>
				<div class="perf-card">
					<div class="icon">
						<i class="bi bi-hand-index-fill"></i>
					</div>
					<h4>클릭 수</h4>
					<p>${mailClickCount}</p>
					<span class="rate up">+100%</span>
				</div>
			</div>

			<p class="perf-note">이 지표는 최근 한 달 데이터를 기준으로 합니다.</p>
 --%>
		</div>

	</my:layout>

	<script>
	const salesData = ${salesListJson != null ? salesListJson : "[]"};
	  const salesCompareData = ${salesCompareJson != null ? salesCompareJson : "[]"};
	</script>
	<script src="./js/dashboard.js"></script>

</body>
</html>