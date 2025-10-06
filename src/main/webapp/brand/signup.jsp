<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>회원가입</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="../tagcss/reset.css" />
<link rel="stylesheet" href="../tagcss/button.css" />
<link rel="stylesheet" href="../tagcss/textInput.css" />
<link rel="stylesheet" href="./css/alert.css" />
<link rel="stylesheet" href="./css/auth.css" />
</head>
<body class="signup-page">
	<!-- Toast 알림 컨테이너 -->
	<div id="toast-container"></div>

	<div class="auth-container">
		<!-- 로고 -->
		<div class="signup-logo">
			<img src="../image/logo_black.svg" alt="Brand" />
			<h1 class="brand-name">AmaraDazzle</h1>
		</div>

		<h2 class="auth-title">계정 정보를 입력해주세요</h2>

		<!-- 회원가입 폼 -->
		<form action="/brand/signup" method="post" class="auth-form">
			<div class="input-group">
				<div class="form-group">
					<label for="email">이메일</label>
					<div class="checkDuplicate-wrapper">
						<my:textInput id="email" name="email" type="default" size="lg"
							state="default" />
						<button type="button" class="btn btn-outline btn-xl"
							onclick="checkDuplicate('email')">중복확인</button>
					</div>
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
					<label for="brn">사업자등록번호</label>
					<div class="checkDuplicate-wrapper">
						<my:textInput id="brn" name="brn" type="default" size="lg"
							state="default" />
						<button type="button" class="btn btn-outline btn-xl"
							onclick="checkDuplicate('brn')">중복확인</button>
					</div>
				</div>

				<div class="form-group">
					<label for="brandName">브랜드명</label>
					<div class="checkDuplicate-wrapper">
						<my:textInput id="brandName" name="brandName" type="default"
							size="lg" state="default" />
						<button type="button" class="btn btn-outline btn-xl"
							onclick="checkDuplicate('brandName')">중복확인</button>
					</div>
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
				<label class="agreeAll"><input type="checkbox" id="agreeAll" />
					모두 동의합니다.</label>
				<div class="checkbox-wrpper">
					<label><input type="checkbox" required /> [필수] <span>통합계정
							약관</span>에 동의합니다.</label> <label><input type="checkbox" required />
						[필수] <span>개인정보 수집 및 이용</span>에 동의합니다.</label> <label><input
						type="checkbox" required /> [필수] 만 14세 이상입니다.</label>
				</div>
			</div>

			<button type="submit" id="submitBtn"
				class="btn btn-primary btn-xl signup" disabled>가입하기</button>
		</form>
	</div>

	<script src="./js/toast.js"></script>
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
 * 체크박스 동의
 *********************************************************************************************************/
const agreeAll = document.getElementById("agreeAll");
const reqChecks = document.querySelectorAll(".form-agree input[type='checkbox']:not(#agreeAll)");
const submitBtn = document.querySelector("button.signup");

// 전체 동의 -> 개별 체크
agreeAll.addEventListener("change", () => {
  reqChecks.forEach(cb => cb.checked = agreeAll.checked);
  validateForm();
});

// 개별 체크 -> 전체 동의
reqChecks.forEach(cb => cb.addEventListener("change", () => {
  agreeAll.checked = [...reqChecks].every(c => c.checked);
  validateForm();
}));

/*********************************************************************************************************
 * 유효성 검사 이벤트
 *********************************************************************************************************/
// 이메일 검증
document.getElementById("email").addEventListener("blur", (e) => {
  const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  if (!regex.test(e.target.value)) {
    setError("email", "올바른 이메일 형식이 아닙니다.");
  } else {
    clearError("email");
  }
  validateForm();
});

// 비밀번호 확인
document.getElementById("confirmPw").addEventListener("blur", () => {
  const pw = document.getElementById("password").value;
  const confirmPw = document.getElementById("confirmPw").value;
  if (pw !== confirmPw) {
    setError("confirmPw", "비밀번호가 일치하지 않습니다.");
  } else {
    clearError("confirmPw");
  }
  validateForm();
});

//사업자등록번호 포맷 (실시간)
document.getElementById("brn").addEventListener("input", (e) => {
  let v = e.target.value.replace(/\D/g, "").slice(0,10);
  if (v.length >= 5) v = v.replace(/(\d{3})(\d{2})(\d{0,5})/, "$1-$2-$3");
  else if (v.length >= 3) v = v.replace(/(\d{3})(\d{0,2})/, "$1-$2");
  e.target.value = v;
});
// 사업자등록번호 검증 (포커스 아웃 시)
document.getElementById("brn").addEventListener("blur", (e) => {
  if (e.target.value.replace(/\D/g, "").length !== 10) {
    setError("brn", "사업자등록번호는 10자리여야 합니다.");
  } else {
    clearError("brn");
  }
  validateForm();
});

//휴대폰 번호 포맷 (실시간)
document.getElementById("phone").addEventListener("input", (e) => {
  let v = e.target.value.replace(/\D/g, "").slice(0,11);
  if (v.length > 7) {
    v = v.replace(/(\d{3})(\d{4})(\d{0,4})/, "$1-$2-$3");
  } else if (v.length > 3) {
    v = v.replace(/(\d{3})(\d{0,4})/, "$1-$2");
  }
  e.target.value = v;
});

// 휴대폰 번호 검증 (포커스 아웃 시)
document.getElementById("phone").addEventListener("blur", (e) => {
  const digits = e.target.value.replace(/\D/g, "");
  if (digits.length < 10 || digits.length > 11) {
    setError("phone", "휴대폰 번호가 올바르지 않습니다.");
  } else {
    clearError("phone");
  }
  validateForm();
});

//form submit 시 하이픈 제거 → 서버에는 숫자만 전송
document.querySelector("form.auth-form").addEventListener("submit", (e) => {
  const brnInput = document.getElementById("brn");
  brnInput.value = brnInput.value.replace(/\D/g, ""); // 숫자만 남김

  const phoneInput = document.getElementById("phone");
  phoneInput.value = phoneInput.value.replace(/\D/g, ""); // 숫자만 남김
});

/*********************************************************************************************************
 * 폼 전체 유효성 검사 (버튼 활성화 제어)
 *********************************************************************************************************/
function validateForm() {
  const emailValid   = !document.getElementById("email").closest(".text-input-wrapper").classList.contains("state--error")
                        && document.getElementById("email").value.trim() !== "";
  const pwValid      = document.getElementById("password").value !== ""
                        && !document.getElementById("confirmPw").closest(".text-input-wrapper").classList.contains("state--error");
  const brnValid   = !document.getElementById("brn").closest(".text-input-wrapper").classList.contains("state--error")
                        && document.getElementById("brn").value.trim() !== "";
  const brandValid   = document.getElementById("brandName").value.trim() !== "";
  const phoneValid   = !document.getElementById("phone").closest(".text-input-wrapper").classList.contains("state--error")
                        && document.getElementById("phone").value.trim() !== "";
  const agreeValid   = [...reqChecks].every(c => c.checked);

  submitBtn.disabled = !(emailValid && pwValid && brnValid && brandValid && phoneValid && agreeValid);
}

/*********************************************************************************************************
 * 중복 확인 (Ajax 자리)
 *********************************************************************************************************/
function checkDuplicate(field) {
  const value = document.getElementById(field).value;
  if (!value) {
    showToast("error", "값을 입력해주세요.");
    return;
  }

  // TODO: 서버 연동 필요
  fetch(`/checkDuplicate?field=\${field}&value=\${value}`)
    .then(res => res.json())
    .then(data => {
      if (data.exists) {
        setError(field, "이미 사용 중인 값입니다.");
      } else {
        clearError(field);
        showToast("success", "사용 가능합니다");
      }
      validateForm();
    })
    .catch(err => {
      console.error(err);
      showToast("error", "중복 확인 중 오류가 발생했습니다.");
    });
}
</script>

</body>
</html>
