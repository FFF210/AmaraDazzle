<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신청 완료</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/pretendard/dist/web/static/pretendard.css" />
<link rel="stylesheet" href="../tagcss/reset.css" />
<link rel="stylesheet" href="../tagcss/button.css" />

<style>
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
	color: #0C8CE9; /* 아이콘 색상 */
}

h2 {
	margin-bottom: 12px;
	color: #171717;
	text-align: center;
	font-size: 32px;
	font-style: normal;
	font-weight: 700;
	line-height: 150%;
	letter-spacing: 0.182px;
	white-space: nowrap;
}

.info {
	font-size: 15px;
	margin-bottom: 5px;
	color: #444;
	white-space: nowrap;
}

.bold {
	margin-bottom: 48px;
	color: #333;
	font-size: 20px;
	font-style: normal;
	font-weight: 600;
	white-space: nowrap;
}

.b {
	display: flex;
	width: 100%;
	justify-content: center;
}
</style>
</head>
<body>
	<div class="CompleteWrapper">
		<div class="CompleteContainer">
			<div class="check-icon">
				<i class="bi bi-clipboard-check-fill"></i>
			</div>
			<h2>신청이 접수되었습니다</h2>
			<div class="bold">운영팀이 확인 후 승인 여부를 이메일로 알려드립니다.</div>
			<div class="b">
				<button class="btn btn-primary btn-xl"
					onclick="location.href='/consumer/main'">AmaraDazzle 둘러보기</button>
			</div>
		</div>
	</div>

</body>
</html>