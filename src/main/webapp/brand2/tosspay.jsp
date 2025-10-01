<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://js.tosspayments.com/v1/payment"></script>
<script src="js/tossPay.js"></script>
</head>
<body>
	<button type="button" class="pay-button" id="payBtn">
		<img
			src="${pageContext.request.contextPath}/brand2/images/TossPay_Logo_Primary.png"
			width="280px" alt="토스페이결제하기">
	</button>
</body>
</html>