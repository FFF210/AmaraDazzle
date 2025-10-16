<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>정산 대시보드</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="../tagcss/reset.css" />
<link rel="stylesheet" href="../tagcss/button.css" />
<link rel="stylesheet" href="../tagcss/form-controls.css" />
<link rel="stylesheet" href="../tagcss/layout.css" />
<link rel="stylesheet" href="../tagcss/sidebar.css" />
<link rel="stylesheet" href="../tagcss/brandHeader.css" />
<link rel="stylesheet" href="../tagcss/breadcrumb.css" />
<link rel="stylesheet" href="./css/alert.css" />
<link rel="stylesheet" href="./css/settlementDashboard.css" />

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
	<my:layout>
		<!-- breadcrumb -->
		<div class="page-breadcrumb">
			<my:breadcrumb items="정산:" />
		</div>

		<div class="settlement-dashboard">

			<fmt:formatNumber value="${summary.currentFinalAmount}" type="number"
				maxFractionDigits="0" groupingUsed="true"
				var="currentFinalAmountFmt" />
			<fmt:formatNumber value="${summary.currentFee}" type="number"
				maxFractionDigits="0" groupingUsed="true" var="currentFeeFmt" />
			<fmt:formatNumber value="${summary.currentTotalSales}" type="number"
				maxFractionDigits="0" groupingUsed="true" var="currentTotalSalesFmt" />
			<fmt:formatNumber value="${summary.currentPureProfit}" type="number"
				maxFractionDigits="0" groupingUsed="true" var="currentPureProfitFmt" />

			<!-- 상단: 카드 + 도넛 차트 -->
			<div class="top-section">
				<div class="cards-grid">
					<div class="card-item">
						<i class="bi bi-wallet2"></i>
						<div>
							<p class="card-label">이번 달 정산 예정 금액</p>
							<p class="card-value">${currentFinalAmountFmt} 원</p>
						</div>
					</div>
					<div class="card-item">
						<i class="bi bi-receipt-cutoff"></i>
						<div>
							<p class="card-label">이번 달 수수료</p>
							<p class="card-value">${currentFeeFmt} 원</p>
						</div>
					</div>
					<div class="card-item">
						<i class="bi bi-bag-check"></i>
						<div>
							<p class="card-label">이번 달 총 주문 금액</p>
							<p class="card-value">${currentTotalSalesFmt} 원</p>
						</div>
					</div>
					<div class="card-item">
						<i class="bi bi-piggy-bank"></i>
						<div>
							<p class="card-label">이번 달 순수 매출액</p>
							<p class="card-value">${currentPureProfitFmt} 원</p>
						</div>
					</div>
				</div>

				<div class="donut-chart">
					<h3 class="chart-title">이번 달 총 주문 금액 비율</h3>
					<canvas id="donutChart" width="200" height="200"></canvas>
				</div>
			</div>

			<!-- 하단: 바 차트 -->
			<div class="bottom-section">
				<h3 class="chart-title">월 단위 정산 금액 추이</h3>
				<canvas id="lineChart" width="1300" height="380"></canvas>
			</div>

		</div>
	</my:layout>
	<script>
	/*********************************************************************************************************
	 * 도넛 차트
	 *********************************************************************************************************/
	const ctx = document.getElementById('donutChart');

	// JSP에서 전달된 데이터
	const discount = ${donut.discountAmount};
	const donutPureProfit = ${donut.pureProfit};
	const fee = ${donut.fee};

	new Chart(ctx, {
	  type: 'doughnut',
	  data: {
	    labels: ['쿠폰·포인트', '순수 매출액', '수수료'],
	    datasets: [{
	      data: [discount, donutPureProfit, fee],
	      backgroundColor: ['#FF9F40', '#FFCD56', '#4BC0C0'],
	      borderColor: ['#FFFFFF'],
	      borderWidth: 2,
	      hoverOffset: 10
	    }]
	  },
	  options: {
		    responsive: true,
		    maintainAspectRatio: false,
		    cutout: '60%',
		    plugins: {
		      legend: {
		        position: 'right',  /* 하단 → 우측으로 변경 */
		        labels: {
		          boxWidth: 15,      /* 색상 박스 크기 조절 */
		          padding: 15,       /* 항목 간 여백 */
		          font: { size: 13 } /* 글자 크기 */
		        }
		      }
		    },
		    layout: {
		      padding: 10
		    }
		  }
		});

	/*********************************************************************************************************
	 * 라인 차트
	 *********************************************************************************************************/
	const ctx2 = document.getElementById('lineChart');

	const labels = [
	  <c:forEach var="item" items="${trendList}" varStatus="status">
	    "${item.monthLabel}"<c:if test="${!status.last}">,</c:if>
	  </c:forEach>
	];

	const totalSales = [
	  <c:forEach var="item" items="${trendList}" varStatus="status">
	    ${item.totalSales}<c:if test="${!status.last}">,</c:if>
	  </c:forEach>
	];

	const fees = [
	  <c:forEach var="item" items="${trendList}" varStatus="status">
	    ${item.fee}<c:if test="${!status.last}">,</c:if>
	  </c:forEach>
	];

	const trendPureProfit = [
	  <c:forEach var="item" items="${trendList}" varStatus="status">
	    ${item.pureProfit}<c:if test="${!status.last}">,</c:if>
	  </c:forEach>
	];

	new Chart(ctx2, {
	  type: 'line',
	  data: {
	    labels: labels,
	    datasets: [
	      {
	        label: '총매출',
	        data: totalSales,
	        borderColor: '#4BC0C0',
	        tension: 0.3,
	        fill: false,
	        borderWidth: 2
	      },
	      {
	        label: '수수료',
	        data: fees,
	        borderColor: '#FF6384',
	        tension: 0.3,
	        fill: false,
	        borderWidth: 2
	      },
	      {
	        label: '순이익',
	        data: trendPureProfit,
	        borderColor: '#FFCE56',
	        tension: 0.3,
	        fill: false,
	        borderWidth: 2
	      }
	    ]
	  },
	  options: {
	    responsive: true,
	    plugins: {
	      legend: {
	        position: 'bottom',
	        labels: { font: { size: 13 } }
	      }
	    },
	    scales: {
	      y: {
	        beginAtZero: true,
	        ticks: {
	          callback: function (value) {
	            return value.toLocaleString() + '원';
	          }
	        }
	      }
	    }
	  }
	});
	</script>
</body>
</html>
