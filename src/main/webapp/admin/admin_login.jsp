<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>관리자 로그인</title>

<link rel="stylesheet" href="./css/common/toast.css" />
<link rel="stylesheet" href="./css/admin_login.css" />
<link rel="stylesheet" href="../tagcss/button.css" />
<link rel="stylesheet" href="../tagcss/textInput.css" />
<!-- 부트스트랩 아이콘 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" />

</head>

<body class="login-page">
	<div class="alert_section" id="toast"></div>
	<div id="overlay" class="overlay"></div>

	
	<div class="auth-container">
		<!-- 로고 -->
		<div class="login-logo">
			<img src="/image/logo_black_below.svg" alt="logo" />
		</div>

		<!-- 로그인 폼 -->
		<form id="loginForm" class="auth-form">
			<div class="input-group">
				<div class="form-group">
					<label for="aid">아이디</label>
					<my:textInput id="aid" name="aid" 
						placeholder="아이디를 입력하세요" type="default" size="lg"
						state="${field eq 'aid' ? 'error' : 'default'}"
						errorText="${field eq 'aid' ? fieldError : ''}"
						value="${cookie.id.value}" />
				</div>
				<div class="form-group">
					<label for="apass">비밀번호</label>
					<my:textInput id="apass" name="apass"
						placeholder="비밀번호를 입력하세요" type="password" size="lg"
						state="${field eq 'apass' ? 'error' : 'default'}"
						errorText="${field eq 'apass' ? fieldError : ''}" />
				</div>
			</div>

			<div class="form-options">
				<p>
					<label>
						<input type="checkbox" id="rememberId" name="rememberId"
							<c:if test="${cookie.rememberId.value == 'Y'}">checked</c:if>/>
						아이디 기억하기
					</label>
				</p>
			</div>

			<button type="submit" class="btn btn-primary btn-xl login">로그인</button>
		</form>
	</div>
</body>

<script src="./js/common/toast.js"></script>
<script src="./js/admin_login.js"></script>
</html>
