<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>쿠폰</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="./css/reset.css" />
<link rel="stylesheet" href="./css/header.css" />
<link rel="stylesheet" href="./css/pageHeader.css" />
<link rel="stylesheet" href="./css/coupon.css" />
<link rel="stylesheet" href="./css/footer.css" />
<link rel="stylesheet" href="./css/couponList.css" />
</head>
<body>
	<!-- 상단 헤더 -->
	<%@ include file="header.jsp"%>

	<!-- 페이지 헤더 -->
	<div class="page-header-wrapper">
		<my:pageHeader title="쿠폰" description="쇼핑하는 재미! 올리브영만의 더 특별한 혜택" />
	</div>
	
	<my:coupon amount="10000" startDate="2026-08-08" endDate="2026-08-08" />

	<!-- 하단 푸터 -->
	<%@ include file="footer.jsp"%>
</body>
</html>
