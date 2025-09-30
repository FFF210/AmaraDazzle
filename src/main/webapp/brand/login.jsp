<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>로그인</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="../tagcss/reset.css" />
<link rel="stylesheet" href="../tagcss/button.css" />
<link rel="stylesheet" href="../tagcss/textInput.css" />
<link rel="stylesheet" href="../tagcss/alert.css" />
<link rel="stylesheet" href="./css/auth.css" />
</head>
<body class="login-page">
	<div class="auth-container">
		<!-- 로고 -->
		<div class="login-logo">
			<img src="../image/logo_black.svg" alt="Brand" />
			<h1 class="brand-name">AmaraDazzle</h1>
		</div>

		<!-- 로그인 폼 -->
		<form action="/brand/login" method="post" class="auth-form">
			<div class="input-group">
				<div class="form-group">
					<label for="email">아이디</label>
					<my:textInput id="email" name="email" placeholder="아이디를 입력하세요"
						type="default" size="lg"
						state="${field eq 'email' ? 'error' : 'default'}"
						errorText="${field eq 'email' ? fieldError : ''}"
						value="${not empty email ? email : cookie.email.value}" />

				</div>
				<div class="form-group">
					<label for="password">비밀번호</label>
					<my:textInput id="password" name="password"
						placeholder="비밀번호를 입력하세요" type="password" size="lg"
						state="${field eq 'password' ? 'error' : 'default'}"
						errorText="${field eq 'password' ? fieldError : ''}"
						value="${not empty password ? password : cookie.password.value}" />

				</div>
			</div>

			<div class="form-options">
				<p>
					<input type="checkbox" name="autoLogin" value="true"
						${cookie.autoLogin.value eq "true"? "checked" :""} />자동로그인
				</p>
				<a href="/brand/findAccount" class="link">아이디/비밀번호 찾기</a>
			</div>

			<button type="submit" class="btn btn-primary btn-xl login">로그인</button>

			<p class="auth-footer">
				아직 계정이 없으신가요? <a href="/brand/signup" class="link">회원가입</a>
			</p>
		</form>
	</div>
</body>

<script>
  /*********************************************************************************************************
   * 에러 상태 표시/제거 함수
   *********************************************************************************************************/
   function setError(inputId, message) {
	   const wrapper = document.getElementById(inputId).closest(".text-input-wrapper");
	   wrapper.classList.remove("state--default");
	   wrapper.classList.add("state--error");

	   let err = wrapper.querySelector(".text-input-error");
	   if (err) err.remove();

	   if (message) {
	     const span = document.createElement("span");
	     span.className = "text-input-error";
	     span.textContent = message;
	     wrapper.appendChild(span);
	   }
	 }

   function clearError(inputId) {
	   const wrapper = document.getElementById(inputId).closest(".text-input-wrapper");
	   wrapper.classList.remove("state--error");
	   wrapper.classList.add("state--default");

	   let err = wrapper.querySelector(".text-input-error");
	   if (err) err.remove();
	 }
   
   /*********************************************************************************************************
    * 서버에서 전달된 필드 에러 적용
    *********************************************************************************************************/
   document.addEventListener("DOMContentLoaded", () => {
     <%if (request.getAttribute("fieldError") != null) {%>
       const field = "<%=request.getAttribute("field")%>";
       const message = "<%=request.getAttribute("fieldError")%>";
       setError(field, message);
     <%}%>
   });
  
   /*********************************************************************************************************
    * 이메일 형식 검증
    *********************************************************************************************************/
   document.addEventListener("DOMContentLoaded", () => {
     const emailInput = document.getElementById("email");
     const form = document.querySelector(".auth-form");

     form.addEventListener("submit", (e) => {
       const email = emailInput.value.trim();
       const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

       if (!regex.test(email)) {
         e.preventDefault(); // 제출 막기
         setError("email", "올바른 이메일 형식을 입력해주세요.");
         emailInput.focus();
         return false;
       } else {
         clearError("email");
       }
     });
   });
</script>
</html>
