<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<link rel="stylesheet" href="<c:url value='/tagcss/reset.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/header.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>">
<link rel="stylesheet"
	href="<c:url value='/consumer/css/orderDetail.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/textInput.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/table.css'/>">
<link rel="stylesheet"
	href="<c:url value='/consumer/css/mypageMenu.css'/>">
</head>
<body>
<%-- 헤더 --%>
	<%@ include file="/consumer/header.jsp"%>
	
	<div class="page-wrap">
	<main class="content">
	<h1>회원정보 수정</h1>
	
	<section class="basic-info">
	<div class="row">
	<div class="label">닉네임</div>
	<div class="input-wrapper">
	<my:textInput type="default" name="nickname"
						  value="" size="lg" />
	</div>

	</div>
	</section>
	
	<section class="additional-info">
	</section>
	
	<section class="skin-info">
	</section>

	
	<div class="agreement">
	</div>
	
	<div class="delete-account">
	</div>
	
	</main>
	</div>

	<%-- 푸터 --%>
	<%@ include file="/consumer/footer.jsp"%>
</body>
</html>