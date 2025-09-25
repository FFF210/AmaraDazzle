<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>회원가입</title>
<link rel="stylesheet" href="./css/reset.css" />
<link rel="stylesheet" href="./css/button.css" />
<link rel="stylesheet" href="./css/auth.css" />
<link rel="stylesheet" href="./css/textInput.css" />
</head>
<body class="signup-page">
	<div class="auth-container">
		<!-- 로고 -->
		<div class="signup-logo">
			<img src="./images/logo_black.svg" alt="Brand" />
			<h1 class="brand-name">Brand</h1>
		</div>

		<h2 class="auth-title">계정 정보를 입력해주세요</h2>

		<!-- 회원가입 폼 -->
		<form action="/signup" method="post" class="auth-form">
			<div class="input-group">
				<div class="form-group">
					<label for="email">이메일</label>
					<my:textInput id="email" name="email" type="default" size="lg"
						state="default" />
				</div>

				<div class="form-group">
					<label for="password">비밀번호</label>
					<my:textInput id="password" name="password" type="password"
						size="lg" state="default" />
				</div>

				<div class="form-group">
					<label for="confirmPw">비밀번호 확인</label>
					<my:textInput id="confirmPw" name="confirmPw" type="password"
						size="lg" state="default" />
				</div>

				<div class="form-group">
					<label for="bizNo">사업자등록번호</label>
					<my:textInput id="bizNo" name="bizNo" type="default" size="lg"
						state="default" />
				</div>

				<div class="form-group">
					<label for="brandName">브랜드명</label>
					<my:textInput id="brandName" name="brandName" type="default"
						size="lg" state="default" />
				</div>

				<div class="form-group">
					<label for="managerName">담당자명</label>
					<my:textInput id="managerName" name="managerName" type="default"
						size="lg" state="default" />
				</div>

				<div class="form-group">
					<label for="phone">휴대폰 번호</label>
					<my:textInput id="phone" name="phone" type="default" size="lg"
						state="default" />
				</div>
			</div>
			<!-- 약관 동의 -->
			<div class="form-agree">
				<label class="agreeAll"><input type="checkbox" id="agreeAll" /> 모두 동의합니다.</label> 
				<div class="checkbox-wrpper">
					<label><input type="checkbox" required /> [필수] <span>통합계정 약관</span>에 동의합니다.</label> 
					<label><input type="checkbox" required /> [필수] <span>개인정보 수집 및 이용</span>에 동의합니다.</label> 
					<label><input type="checkbox" required /> [필수] 만 14세 이상입니다.</label>
				</div>
			</div>

			<button type="submit" class="btn btn-primary btn-xl signup">가입하기</button>
		</form>
	</div>

	<script>
	  // 전체 동의 체크박스
	  const agreeAll = document.getElementById("agreeAll");
	  agreeAll.addEventListener("change", () => {
	    document.querySelectorAll(".form-agree input[type='checkbox']").forEach(cb => {
	      if (cb !== agreeAll) cb.checked = agreeAll.checked;
	    });
	  });
	</script>
</body>
</html>
