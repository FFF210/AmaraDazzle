<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 신청 완료</title>

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
.breadcrumb {
	margin-top: 8px;
	margin-left: 24px;
}

.CompleteWrapper {
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: calc(100vh - 76px);
	overflow: hidden; /* 스크롤 강제 차단 */
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

.check-icon {
	width: 80px;
	height: 80px;
	margin: 0 auto 20px;
	padding: 20px;
	display: flex;
	align-items: center;
	justify-content: center;
}

.check-icon i {
	font-size: 80px; /* 아이콘 크기 */
	color: green; /* 아이콘 색상 */
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

.bold {
	font-weight: bold;
	margin: 15px 0;
	font-size: 16px;
	color: #000;
}

.b {
	display: flex;
	justify-content: center;
}
</style>

</head>
<body>
	<my:layout>
		<my:breadcrumb
			items="이벤트 관리:/brand2/eventList" />
	
		<div class="CompleteWrapper">
			<div class="CompleteContainer">
				<div class="check-icon">
					<i class="bi bi-check2-circle"></i>
				</div>
				<h2>이벤트 등록이 완료되었습니다.</h2>
				<div class="bold">이벤트 페이지에서 확인 가능합니다.</div>
				<div class="b">
					<button class="btn btn-outline btn-md"
						onclick="location.href='/brand2/eventList'">목록 보기</button>
				</div>
			</div>
		</div>
	</my:layout>


</body>
</html>