<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>토스페이 결제 완료</title>

<link rel="stylesheet" href="../tagcss/breadcrumb.css" />
<link rel="stylesheet" href="../tagcss/brandHeader.css" />
<link rel="stylesheet" href="../tagcss/layout.css" />
<link rel="stylesheet" href="../tagcss/reset.css" />
<link rel="stylesheet" href="../tagcss/selectbox.css" />
<link rel="stylesheet" href="../tagcss/sidebar.css" />
<link rel="stylesheet" href="../tagcss/tableFilter.css" />
<link rel="stylesheet" href="../tagcss/pagination.css" />
<link rel="stylesheet" href="../tagcss/button.css" />

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

<style>
.CompleteWrapper {
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: calc(100vh - 76px);
}
.CompleteContainer {
	background: #fff;
	padding: 40px;
	border-radius: 10px;
	text-align: center;
	width: 500px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
	margin: 0 auto;
}
.icon {
	width: 80px;
	height: 80px;
	margin: 0 auto 20px;
	display: flex;
	align-items: center;
	justify-content: center;
	color: #43a047; /* 초록색 */
}
.icon i {
	font-size: 80px;
}
h2 {
	margin-bottom: 15px;
	font-size: 20px;
	color: #333;
}
.info {
	font-size: 15px;
	margin-bottom: 5px;
	color: #444;
}
.b {
  display: flex;
  justify-content: center;
}
</style>
</head>
<body>
	<my:layout>
		<div class="CompleteWrapper">
			<div class="CompleteContainer">
				<div class="icon">
					<i class="bi bi-check-circle-fill"></i>
				</div>
				<h2>결제가 완료되었습니다.</h2>
				<div class="info">정상적으로 결제가 완료되었습니다.</div>
				<!-- 
				<div class="b" style="margin-top:10px;">
					<button class="btn btn-outline btn-md"
						onclick="location.href='/brand2/membership.jsp'">신청 목록 보기</button>
				</div>
				 -->
				<div class="b" style="margin-top:20px;">
					<button class="btn btn-outline btn-md"
						onclick="location.href='/brand'">홈으로 돌아가기</button>
				</div>
			</div>
		</div>
	</my:layout>
</body>
</html>
