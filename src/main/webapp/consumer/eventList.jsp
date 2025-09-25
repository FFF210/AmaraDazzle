<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>이벤트 목록</title>
<link rel="stylesheet" href="./css/reset.css" />
<link rel="stylesheet" href="./css/header.css" />
<link rel="stylesheet" href="./css/pageHeader.css" />
<link rel="stylesheet" href="./css/eventCard.css" />
<link rel="stylesheet" href="./css/footer.css" />
<link rel="stylesheet" href="./css/eventList.css" />
</head>
<body>

	<!-- 상단 헤더 -->
	<%@ include file="/consumer/header.jsp"%>

	<!-- 페이지 헤더 -->
	<div class="page-header-wrapper">
		<my:pageHeader title="이벤트" description="풍성한 이벤트! 즐거운 올리브영"
			hasButton="true" />
	</div>

	<!-- 이벤트 목록 -->
	<div class="event-list-container">
		<div class="event-grid">
			<c:forEach var="i" begin="1" end="12">
				<my:eventCard imageUrl="https://placehold.co/320x160"
					title="올영 뷰티 구매인증 리뷰 이벤트 ${i}" startDate="2025-09-01"
					endDate="2025-09-31" />
			</c:forEach>
		</div>
	</div>

	<!-- 하단 푸터 -->
	<%@ include file="/consumer/footer.jsp"%>


</body>
</html>
