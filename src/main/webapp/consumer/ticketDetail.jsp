<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터 - 1:1 문의 상세</title>
<link rel="stylesheet" href="<c:url value='/tagcss/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/modalRecent.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/productCard.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/tag.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/pagination.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/heartBtn.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/price.css'/>" />
<link rel="stylesheet" href="<c:url value='/consumer/css/header.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/pageHeader.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/button.css'/>">
<link rel="stylesheet"
	href="<c:url value='/consumer/css/ticketDetail.css'/>">
</head>
<body>
	<%-- 헤더 --%>
	<%@ include file="/consumer/header.jsp"%>

	<div class="pageHeader-wrapper">
		<my:pageHeader hasButton="false" title="고객센터" description="무엇을 도와드릴까요" />
	</div>

	<!-- 문의 상세 페이지 -->
	<main class="main-content">

		<!-- 문의 정보 -->
		<div class="ticket-info-box">
			<div class="info-row">
				<span class="info-label">문의 유형</span> <span class="info-value">
					<c:choose>
						<c:when test="${ticket.category == 'ORDER'}">주문</c:when>
						<c:when test="${ticket.category == 'CANCEL'}">취소</c:when>
						<c:when test="${ticket.category == 'REFUND'}">환불</c:when>
						<c:when test="${ticket.category == 'EXCHANGE'}">교환</c:when>
						<c:when test="${ticket.category == 'DELIVERY'}">배송</c:when>
						<c:when test="${ticket.category == 'PAYMENT'}">결제</c:when>
						<c:when test="${ticket.category == 'EVENT'}">이벤트</c:when>
						<c:when test="${ticket.category == 'SITE_ISSUE'}">사이트 이용 오류/개선</c:when>
						<c:otherwise>기타</c:otherwise>
					</c:choose>
				</span>
			</div>

			<div class="info-row">
				<span class="info-label">작성일</span> <span class="info-value">
					<fmt:formatDate value="${ticket.questionedAt}"
						pattern="yyyy-MM-dd HH:mm" />
				</span>
			</div>

			<c:if test="${not empty ticket.orderId}">
				<div class="info-row">
					<span class="info-label">주문 ID</span> <span class="info-value">${ticket.orderId}</span>
				</div>
			</c:if>

			<div class="info-row">
				<span class="info-label">답변 상태</span> <span class="info-value">
					<c:choose>
						<c:when test="${not empty ticket.answer}">
							<span class="status-badge answered">답변완료</span>
						</c:when>
						<c:otherwise>
							<span class="status-badge pending">답변대기</span>
						</c:otherwise>
					</c:choose>
				</span>
			</div>
		</div>

		<!-- 문의 내용 -->
		<div class="content-section">
			<h3 class="section-title">문의</h3>
			<div class="content-box">
				<p class="question-text">${ticket.question}</p>
			</div>

			<!-- 첨부 이미지 -->
			<c:if
				test="${not empty ticket.image1FileId or not empty ticket.image2FileId or not empty ticket.image3FileId}">
				<div class="image-list">
					<c:if test="${not empty ticket.image1FileId}">
						<img
							src="${pageContext.request.contextPath}/image?fileId=${ticket.image1FileId}"
							alt="첨부이미지 1" class="attached-img" width="160px" />
					</c:if>
					<c:if test="${not empty ticket.image2FileId}">
						<img
							src="${pageContext.request.contextPath}/image?fileId=${ticket.image2FileId}"
							alt="첨부이미지 2" class="attached-img" width="160px" />
					</c:if>
					<c:if test="${not empty ticket.image3FileId}">
						<img
							src="${pageContext.request.contextPath}/image?fileId=${ticket.image3FileId}"
							alt="첨부이미지 3" class="attached-img" width="160px" />
					</c:if>
				</div>
			</c:if>
		</div>

		<!-- 답변 내용 -->
		<c:if test="${not empty ticket.answer}">
			<div class="content-section answer-section">
				<h3 class="section-title">답변</h3>
				<div class="answer-date">
					<fmt:formatDate value="${ticket.answeredAt}"
						pattern="yyyy-MM-dd HH:mm" />
				</div>
				<div class="content-box answer-box">
					<p class="answer-text">${ticket.answer}</p>
				</div>

			</div>
		</c:if>

		<!-- 답변 대기 중 -->
		<c:if test="${empty ticket.answer}">
			<div class="content-section pending-section">
				<div class="pending-message">
					<i class="pending-icon">⏱</i>
					<p>답변을 준비 중입니다.</p>
					<small>빠른 시일 내에 답변드리겠습니다.</small>
				</div>
			</div>
		</c:if>

		<!-- 버튼 -->
		<div class="action-button">
			<button type="button" class="btn btn-outline btn-lg"
				onclick="goBack()">목록으로</button>
		</div>

	</main>

	<%-- footer --%>
	<%@ include file="/consumer/footer.jsp"%>

	<script>
		function goBack() {
			location.href = '<c:url value="/store/mypage/ticketList"/>';
		}
	</script>

</body>
</html>