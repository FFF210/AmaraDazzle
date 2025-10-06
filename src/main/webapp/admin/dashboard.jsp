<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>


<!DOCTYPE html>
<html>
<!-- 헤드부분 -->
<%@ include file="./common/config.jsp" %>

<title>홈</title>
<link rel="stylesheet" href="./css/dashboard.css" />

<!-- Chartjs cdn -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<!-- 헤드부분 end -->

<body>

	<!-- 레이아웃 + 메인컨텐츠 -->
	<my:adminLayout>
		<%@ include file="./main_content/dashboard_content.jsp"%>
	</my:adminLayout>
	<!-- 레이아웃 + 메인컨텐츠 end -->


	



	<!-- JS부분 -->
	<script src="./js/dashboard.js"></script>
	<!-- JS부분 end -->

</body>
</html>