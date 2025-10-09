<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 / 비밀번호 찾기</title>
<link rel="stylesheet" href="<c:url value='/tagcss/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/modalRecent.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/productCard.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/tag.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/pagination.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/heartBtn.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/price.css'/>" />
<link rel="stylesheet" href="<c:url value='/consumer/css/header.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/textInput.css'/>">
<link rel="stylesheet" href="<c:url value='/brand/css/auth.css' />">
<link rel="stylesheet"
	href="<c:url value='/consumer/css/findAccount.css' />">
<link rel="stylesheet" href="<c:url value='/tagcss/button.css'/>">
</head>
<body class="find-page">
	<%-- 헤더 --%>
	<%@ include file="/consumer/header.jsp"%>
	<main class="main-content">
		<div class="auth-container">

			<h3>아이디 / 비밀번호 찾기</h3>

			<!-- 성공/실패 메시지 표시 -->
			<c:if test="${not empty errorMessage}">
				<div class="alert alert-error">${errorMessage}</div>
			</c:if>

			<c:if test="${success and not empty foundEmail}">
				<div class="alert alert-success">
					회원님의 이메일은 <strong>${foundEmail}</strong> 입니다.
				</div>
			</c:if>

			<!-- 비밀번호 재설정 성공 메시지 -->
			<c:if test="${passwordResetSuccess}">
				<div class="alert alert-success">비밀번호가 성공적으로 변경되었습니다. 로그인해주세요.
				</div>
			</c:if>

			<!-- 에러 메시지 -->
			<c:if test="${not empty errorMessage}">
				<div class="alert alert-error">${errorMessage}</div>
			</c:if>

			<!-- 탭 -->
			<div class="find-tabs">
				<button type="button" class="tab-btn active" data-target="findId">아이디
					찾기</button>
				<button type="button" class="tab-btn" data-target="findPw">비밀번호
					찾기</button>
			</div>

			<!-- 아이디 찾기 -->
			<div class="tab-panel active" id="findId">
				<form action="/findId" method="post" class="auth-form">

					<div class="input-group">
						<div class="form-group">
							<label for="memberNam">이름</label>
							<my:textInput id="memberNam" name="memberName" type="default"
								size="lg" state="default" />
						</div>

						<div class="form-group">
							<label for="phone">휴대폰 번호</label>
							<my:textInput id="phone" name="phone" type="default" size="lg"
								state="default" />
						</div>
					</div>

					<button type="submit" class="btn btn-primary btn-xl findAccount">아이디
						찾기</button>
				</form>
			</div>

			<!-- 비밀번호 찾기 -->
			<div class="tab-panel" id="findPw">
				<form action="/findPw" method="post" class="auth-form">

					<div class="input-group">
						<div class="form-group">
							<label for="loginId">아이디</label>
							<my:textInput id="loginId" name="loginId" type="default"
								size="lg" state="default" />
						</div>

						<div class="form-group">
							<label for="phonePw">휴대폰 번호</label>
							<my:textInput id="phonePw" name="phonePw" type="default"
								size="lg" state="default" />
						</div>
					</div>

					<button type="submit" class="btn btn-primary btn-xl findAccount">비밀번호
						찾기</button>
				</form>
			</div>

			<p class="auth-footer">
				아직 계정이 없으신가요? <a href="/store/join" class="link">회원가입</a>
			</p>
		</div>
	</main>

	<%-- footer --%>
	<%@ include file="/consumer/footer.jsp"%>

	<!-- 비밀번호 재설정 팝업 -->
	<div id="passwordResetModal" class="modal" style="display: none;">
		<div class="modal-content">
			<span class="close">&times;</span>
			<h3>비밀번호 재설정</h3>

			<!-- 에러 메시지 -->
			<c:if test="${not empty resetErrorMessage}">
				<div class="alert alert-error">${resetErrorMessage}</div>
			</c:if>

			<form action="/resetPassword" method="post" id="resetPasswordForm">
				<div class="form-group">
					<label for="newPassword">새 비밀번호</label>
					<my:textInput id="newPassword" name="newPassword" type="password"
						size="lg" state="default" />
				</div>

				<div class="form-group">
					<label for="confirmPassword">비밀번호 확인</label>
					<my:textInput id="confirmPassword" name="confirmPassword"
						type="password" size="lg" state="default" />
				</div>

				<button type="submit" class="btn btn-primary btn-xl">비밀번호
					변경</button>
			</form>
		</div>
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
  
//비밀번호 재설정 팝업 표시
  <c:if test="${showPasswordResetPopup}">
      document.addEventListener("DOMContentLoaded", () => {
          const modal = document.getElementById("passwordResetModal");
          modal.style.display = "block";
      });
  </c:if>

  // 팝업 닫기
  document.querySelector(".close")?.addEventListener("click", () => {
      document.getElementById("passwordResetModal").style.display = "none";
  });

  // 팝업 바깥 클릭 시 닫기
  window.addEventListener("click", (e) => {
      const modal = document.getElementById("passwordResetModal");
      if (e.target === modal) {
          modal.style.display = "none";
      }
  });
</script>

</body>
</html>