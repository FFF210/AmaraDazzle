<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>오늘 할 일</title>
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
<link rel="stylesheet" href="./css/todoDashboard.css" />
<script src="${pageContext.request.contextPath}/resources/js/toast.js"></script>
</head>
<body>
	<!-- Toast 알림 컨테이너 -->
	<div id="toast-container"></div>

	<my:layout>
		<!-- breadcrumb -->
		<div class="page-breadcrumb">
			<nav class="breadcrumb">
				<ul>
					<li class="home">홈</li>
				</ul>
			</nav>
		</div>

		<div class="dashboard-container">
			<div class="dashboard-container-wrapper-100">
				<!-- 요약 -->
				<section class="dashboard-section">
					<h3 class="section-title">요약</h3>
					<div class="tasks-grid">
						<div class="task-card">
							<i class="bi bi-cash-coin"></i>
							<p class="task-label">오늘 주문 건 수</p>
							<p class="task-count">${summary.todayOrderCount}</p>
						</div>
						<div class="task-card">
							<i class="bi bi-arrow-counterclockwise"></i>
							<p class="task-label">최근 7일 내 반품/교환 건 수</p>
							<p class="task-count">${summary.refundExchangeCount}</p>
						</div>
						<div class="task-card">
							<i class="bi bi-box-seam"></i>
							<p class="task-label">재고 경고 수 (재고 10 이하 상품/옵션)</p>
							<p class="task-count">${summary.lowStockCount}</p>
						</div>
						<div class="task-card">
							<i class="bi bi-box-seam"></i>
							<p class="task-label">부정 리뷰 (평점 2 이하)</p>
							<p class="task-count">${summary.badReviewCount}</p>
						</div>
					</div>
				</section>
			</div>

			<div class="dashboard-container-wrapper">


				<!-- 오늘 할 일  -->
				<section class="dashboard-section">
					<h3 class="section-title">오늘 할 일</h3>
					<div class="status-list">
						<a href="/brand/orderList?status=PAID" class="status-item"><span
							class="status-title">결제 완료 주문</span> <span>${todo.paidOrderCount}건</span>
							<i class="bi bi-chevron-right"></i></a> <a
							href="/brand/orderList?status=PREPARING" class="status-item"><span
							class="status-title">배송 대기</span> <span>${todo.preparingOrderCount}건</span>
							<i class="bi bi-chevron-right"></i> </a> <a
							href="/brand/returnList?status=REQUESTED" class="status-item"><span
							class="status-title">반품 요청</span><span>${todo.returnRequestedCount}건</span>
							<i class="bi bi-chevron-right"></i></a> <a
							href="/brand/exchangeList?status=REQUESTED" class="status-item"><span
							class="status-title">교환 요청</span><span>${todo.exchangeRequestedCount}건</span>
							<i class="bi bi-chevron-right"></i> </a> <a
							href="/brand/qnaList?answerStatus=PENDING" class="status-item"><span
							class="status-title">미답변 문의</span><span>${todo.unansweredInquiryCount}건</span>
							<i class="bi bi-chevron-right"></i></a>
					</div>
				</section>
			


			<div class="dashboard-container-wrapper-inner">
				<!-- 이벤트 일정 -->
				<section class="dashboard-section">
					<h3 class="section-title">이벤트 일정</h3>
					<div class="alerts">

						<c:choose>
							<c:when test="${not empty events}">
								<c:forEach var="event" items="${events}">
									<c:choose>
										<c:when test="${event.status eq 'RECRUIT'}">
											<c:set var="msg"
												value="[D-${event.daysUntilStart}] ${event.eventName}" />
										</c:when>
										<c:when test="${event.status eq 'ONGOING'}">
											<c:set var="msg"
												value="[${event.daysUntilEnd}일 후 마감] ${event.eventName}" />
										</c:when>
										<c:otherwise>
											<c:set var="msg" value="" />
										</c:otherwise>
									</c:choose>
									<c:if test="${not empty msg}">
										<my:alert type="info" message="${msg}" />
									</c:if>
								</c:forEach>
							</c:when>

							<c:otherwise>
								<p>현재 예정된 이벤트가 없습니다.</p>
							</c:otherwise>
						</c:choose>

					</div>
				</section>
				
				<!-- 이번 주 인기 상품 -->
				<section class="dashboard-section">
					<h3 style="margin-left: 20px;">🏆 이번 주 인기 상품</h3>

					<c:if test="${not empty products}">
						<c:set var="weekStart" value="${products[0].weekStartDate}" />
						<c:set var="baseDate" value="${products[0].baseDate}" />
						<fmt:formatDate value="${weekStart}" pattern="yyyy-MM-dd"
							var="startFmt" />
						<fmt:formatDate value="${baseDate}" pattern="yyyy-MM-dd"
							var="endFmt" />

						<p style="margin-left: 20px; color: #555;">${startFmt}~
							${endFmt}</p>
					</c:if>

					<c:choose>
						<c:when test="${not empty products}">
							<div class="top3-container">
								<c:forEach var="product" items="${products}" varStatus="loop">
									<div class="top3-card">
										<div class="rank-badge">
											<c:choose>
												<c:when test="${loop.index == 0}">🥇 1위</c:when>
												<c:when test="${loop.index == 1}">🥈 2위</c:when>
												<c:when test="${loop.index == 2}">🥉 3위</c:when>
											</c:choose>
										</div>

										<img src="/upload/${product.thumbnailFileId}"
											alt="${product.productName}" />
										<div class="name">${product.productName}</div>
										<div class="sold">
											<fmt:formatNumber value="${product.totalSold}" />
											개 판매
										</div>
									</div>
								</c:forEach>
							</div>
						</c:when>
						<c:otherwise>
							<p style="color: #888; margin-left: 20px;">이번 주 판매된 상품이 없습니다.</p>
						</c:otherwise>
					</c:choose>
				</section>
			</div>
			</div>
		</div>
	</my:layout>
	<script>
document.addEventListener("DOMContentLoaded", () => {
  const toastData = localStorage.getItem("toast");
  if (toastData) {
    const { type, message } = JSON.parse(toastData);
    showToast(type, message); // 프로젝트에서 이미 사용 중인 showToast 함수 호출
    localStorage.removeItem("toast"); // 한번 띄운 후 바로 제거
  }
});
</script>

</body>
</html>
