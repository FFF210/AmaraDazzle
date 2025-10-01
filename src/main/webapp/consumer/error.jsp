<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AMARA DAZZLE</title>
<link rel="stylesheet" href="<c:url value="/css/error.css"/>">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="<c:url value="/consumer/js/error.js"/>"></script>
</head>
<body>
<div class="error">
	<h1>오류가 발생하였습니다</h1>
	<hr>
	<table>
		<colgroup>
			<col style="width: 25%;">
			<col style="width: 75%;">
		</colgroup>
		<tbody>
			<tr>
				<th>오류명</th>
				<td>${err }</td>
			</tr>
		</tbody>
	</table>
	<hr>
	<div class="buttonDiv">
		<button type="button" onclick="location.href='<c:url value="/store/main"/>'" id="homeBtn">홈으로</button>
	</div>
</div>
</body>
</html>