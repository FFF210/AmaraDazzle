<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>로그인</title>
<link rel="stylesheet" href="../css/reset.css" />
<link rel="stylesheet" href="../css/componant/button.css" />
<link rel="stylesheet" href="../css/admin/auth.css" />
<link rel="stylesheet" href="../css/componant/textInput.css" />
</head>
<body class="login-page">
	<div class="auth-container">
		<!-- 로고 -->
		<div class="login-logo">
			<img src="./images/logo_black.svg" alt="Brand" />
			<h1 class="brand-name">Brand</h1>
		</div>

		<!-- 로그인 폼 -->
		<form action="/login" method="post" class="auth-form">
			<div class="input-group">
				<div class="form-group">
					<label for="loginId">아이디</label>
					<my:textInput id="loginId" name="loginId" placeholder="아이디를 입력하세요"
						type="default" size="lg" state="default" />
				</div>
				<div class="form-group">
					<label for="loginPw">비밀번호</label>
					<my:textInput id="loginPw" name="loginPw" placeholder="비밀번호를 입력하세요"
						type="password" size="lg" state="default" />
				</div>
			</div>

			<div class="form-options">
				<p>
					<input type="checkbox" name="rememberId" /> 아이디 기억하기
				</p>
			</div>

			<button type="submit" class="btn btn-primary btn-xl login">로그인</button>
			
		</form>
	</div>
</body>
</html>
