<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>입점 신청</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="./css/reset.css" />
<link rel="stylesheet" href="./css/button.css" />
<link rel="stylesheet" href="./css/imageBtn.css" />
<link rel="stylesheet" href="./css/textInput.css" />
<link rel="stylesheet" href="./css/textArea.css" />
<link rel="stylesheet" href="./css/selectbox.css" />
<link rel="stylesheet" href="./css/auth.css" />
</head>
<body class="signup-page">
	<div class="auth-container">
		<!-- 로고 -->
		<div class="signup-logo">
			<img src="./images/logo_black.svg" alt="Brand" />
			<h1 class="brand-name">Brand</h1>
		</div>

		<h2 class="auth-title">
			브랜드 입점 신청 <br>
			<span>간단한 정보를 입력하시면 운영팀이 확인 후 승인합니다.</span>
		</h2>

		<!-- 입점신청 폼 -->
		<form action="/signup" method="post" class="auth-form">
			<div class="input-group">
				<div class="form-group">
					<label for="email">브랜드 로고</label>
					<my:imageBtn name="upload1" />
				</div>

				<div class="form-group">
					<label for="password">대표이미지</label>
					<my:imageBtn name="upload1" />
				</div>

				<div class="form-group">
					<label for="confirmPw">브랜드 소개</label>
					<my:textArea name="desc" placeholder="내용을 입력하세요" />
				</div>

				<div class="form-group">
					<label for="bizNo">은행명</label>
					<my:selectbox size="lg" items="추천순,인기순,최신순,낮은가격순,높은가격순"
						initial="은행명" />
				</div>

				<div class="form-group">
					<label for="brandName">계좌번호</label>
					<my:textInput id="brandName" name="brandName" type="default"
						size="lg" state="default" />
				</div>
			</div>
			<div class="apply-margin"></div>

			<button type="submit" class="btn btn-primary btn-xl signup">브랜드
				등록 완료</button>
		</form>
	</div>
</body>
</html>
