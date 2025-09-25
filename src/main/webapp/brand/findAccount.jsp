<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>아이디/비밀번호 찾기</title>
<link rel="stylesheet" href="./css/reset.css" />
<link rel="stylesheet" href="./css/button.css" />
<link rel="stylesheet" href="./css/textInput.css" />
<link rel="stylesheet" href="./css/auth.css" />
<link rel="stylesheet" href="./css/findAccount.css" />
</head>
<body class="find-page">
	<div class="auth-container">
	
		<!-- 로고 -->
		<div class="find-logo">
			<img src="./images/logo_black.svg" alt="Brand" />
			<h1 class="brand-name">Brand</h1>
		</div>

		<!-- 탭 -->
		<div class="find-tabs">
			<button type="button" class="tab-btn active" data-target="findId">아이디 찾기</button>
			<button type="button" class="tab-btn" data-target="findPw">비밀번호 찾기</button>
		</div>

		<!-- 아이디 찾기 -->
		<div class="tab-panel active" id="findId">
			<form action="/findId" method="post" class="auth-form">
			
				<div class="input-group">
					<div class="form-group">
						<label for="brandName">브랜드명</label>
						<my:textInput id="brandName" name="brandName" type="default" size="lg" state="default"/>
					</div>
	
					<div class="form-group">
						<label for="phone">휴대폰 번호</label>
						<my:textInput id="phone" name="phone" type="default" size="lg" state="default"/>
					</div>
				</div>

				<button type="submit" class="btn btn-primary btn-xl findAccount">아이디 찾기</button>
			</form>
		</div>

		<!-- 비밀번호 찾기 -->
		<div class="tab-panel" id="findPw">
			<form action="/findPw" method="post" class="auth-form">
			
				<div class="input-group">
					<div class="form-group">
						<label for="loginId">아이디</label>
						<my:textInput id="loginId" name="loginId" type="default" size="lg" state="default"/>
					</div>
	
					<div class="form-group">
						<label for="phonePw">휴대폰 번호</label>
						<my:textInput id="phonePw" name="phonePw" type="default" size="lg" state="default"/>
					</div>
				</div>

				<button type="submit" class="btn btn-primary btn-xl findAccount">비밀번호 찾기</button>
			</form>
		</div>

		<p class="auth-footer">
			아직 계정이 없으신가요? <a href="/signup" class="link">회원가입</a>
		</p>
	</div>

<script>
  // 탭 전환
  document.querySelectorAll(".tab-btn").forEach(btn => {
    btn.addEventListener("click", () => {
      const target = btn.dataset.target;

      // 버튼 상태 변경
      document.querySelectorAll(".tab-btn").forEach(b => b.classList.remove("active"));
      btn.classList.add("active");

      // 패널 상태 변경
      document.querySelectorAll(".tab-panel").forEach(panel => {
        panel.classList.remove("active");
      });
      document.getElementById(target).classList.add("active");
    });
  });
</script>

</body>
</html>
