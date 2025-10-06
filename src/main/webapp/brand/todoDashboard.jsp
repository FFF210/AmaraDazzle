<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>오늘 할 일</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="./css/reset.css" />
<link rel="stylesheet" href="./css/button.css" />
<link rel="stylesheet" href="./css/form-controls.css" />
<link rel="stylesheet" href="./css/layout.css" />
<link rel="stylesheet" href="./css/sidebar.css" />
<link rel="stylesheet" href="./css/header.css" />
<link rel="stylesheet" href="./css/alert.css" />
<link rel="stylesheet" href="./css/breadcrumb.css" />
<link rel="stylesheet" href="./css/alert.css" />
<link rel="stylesheet" href="./css/todoDashboard.css" />
</head>
<body>
	<my:layout>
		<div class="dashboard-container">
			<!-- 요약 -->
			<section class="dashboard-section">
				<h3 class="section-title">요약</h3>
				<div class="tasks-grid">
					<div class="task-card">
						<i class="bi bi-cash-coin"></i>
						<p class="task-label">오늘 주문 건</p>
						<p class="task-count">80건</p>
					</div>
					<div class="task-card">
						<i class="bi bi-arrow-counterclockwise"></i>
						<p class="task-label">환불 건</p>
						<p class="task-count">80건</p>
					</div>
					<div class="task-card">
						<i class="bi bi-box-seam"></i>
						<p class="task-label">상품 재고 경고</p>
						<p class="task-count">80건</p>
					</div>
				</div>
			</section>

			<!-- 이벤트 일정 -->
			<section class="dashboard-section">
				<h3 class="section-title">이벤트 일정</h3>
				<div class="alerts">
					<my:alert type="info" message="립 틴트 런칭 프로모션" />
					<my:alert type="info" message="가을맞이 보습 케어 기획전" />
					<my:alert type="info" message="여름 클리어런스 세일" />
				</div>
			</section>

			<!-- 오늘 할 일  -->
			<section class="dashboard-section">
				<h3 class="section-title">오늘 할 일</h3>
				<div class="status-list">
					<a href="#" class="status-item"><span class="status-title">결제
							완료 주문</span> <span>80건</span> <i class="bi bi-chevron-right"></i></a> <a
						href="#" class="status-item"><span class="status-title">배송
							대기</span> <span>80건</span> <i class="bi bi-chevron-right"></i> </a> <a
						href="#" class="status-item"><span class="status-title">반품
							요청</span><span>80건</span> <i class="bi bi-chevron-right"></i></a> <a
						href="#" class="status-item"><span class="status-title">교환
							요청</span><span>80건</span> <i class="bi bi-chevron-right"></i> </a> <a
						href="#" class="status-item"><span class="status-title">미답변
							문의</span><span>80건</span> <i class="bi bi-chevron-right"></i></a>
				</div>
			</section>

			<!-- 공지사항 -->
			<section class="dashboard-section">
				<h3 class="section-title">플랫폼 공지사항</h3>
				<div class="alerts">
					<my:alert type="warning" message="[시스템] 정산 대시보드 기능 개선" />
					<my:alert type="success" message="보안 업데이트가 성공적으로 적용되었습니다." />
				</div>
			</section>
		</div>
	</my:layout>
</body>
</html>
