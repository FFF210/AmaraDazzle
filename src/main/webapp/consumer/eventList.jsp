<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>이벤트 목록</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="<c:url value='/tagcss/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/modalRecent.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/productCard.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/tag.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/pagination.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/heartBtn.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/price.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/pageHeader.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/eventCard.css'/>" />
<link rel="stylesheet" href="<c:url value='/consumer/css/header.css'/>" />
<link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>" />
<link rel="stylesheet"
	href="<c:url value='/consumer/css/eventList.css'/>" />
</head>
<body>

	<!-- 상단 헤더 -->
	<%@ include file="./header.jsp"%>

	<!-- 페이지 헤더 -->
	<div class="page-header-wrapper">
		<my:pageHeader title="이벤트" description="참여하고, 더 많은 혜택을 만나보세요" />
	</div>

	<!-- 이벤트 목록 -->
	<div class="event-list-container">
		<div class="event-grid">
			<c:forEach var="e" items="${eventList}">
				<c:url value="/store/eventDetail" var="detailUrl">
					<c:param name="eventId" value="${e.eventId}" />
				</c:url>

				<!-- 날짜 포맷 적용 -->
				<fmt:formatDate value="${e.startDate}" pattern="yyyy-MM-dd"
					var="startFmt" />
				<fmt:formatDate value="${e.endDate}" pattern="yyyy-MM-dd"
					var="endFmt" />

				<my:eventCard thumbnailFileId="${e.thumbnailFileId}"
					title="${e.eventName}" startDate="${startFmt}" endDate="${endFmt}"
					href="${detailUrl}" status="${e.status}" />
			</c:forEach>
		</div>

		<c:set var="queryString">
				page=
			</c:set>

		<!-- 페이징 -->
		<div class="page-pagination">
			<my:pagination currentPage="${currentPage}"
				totalPages="${totalPages}" baseUrl="/store/eventList?${queryString}" />
		</div>
	</div>

	<!-- 하단 푸터 -->
	<%@ include file="./footer.jsp"%>
</body>
</html>
