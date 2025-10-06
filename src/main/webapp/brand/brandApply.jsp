<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>입점 신청</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="../tagcss/reset.css" />
<link rel="stylesheet" href="../tagcss/button.css" />
<link rel="stylesheet" href="../tagcss/textInput.css" />
<link rel="stylesheet" href="../tagcss/textArea.css" />
<link rel="stylesheet" href="../tagcss/selectbox.css" />
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

		<h2 class="auth-title">
			브랜드 입점 신청 <br> <span>간단한 정보를 입력하시면 운영팀이 확인 후 승인합니다.</span>
		</h2>

		<!-- 입점신청 폼 -->
		<form action="/brand/brandApply" method="post" class="auth-form"
			enctype="multipart/form-data">
			<div class="input-group">
				<div class="form-group">
					<label for="upload1">브랜드 로고</label> <img
						src="${contextPath}/image/plus.png" id="preview-thumbnail"
						alt="대표 이미지" width="100px"
						onclick="document.getElementById('upload1').click();" /> <input
						type="file" id="upload1" name="upload1" accept="image/*"
						style="display: none"
						onchange="readURL(this,'preview-thumbnail');" /> <img
						id="preview1" src="#" alt="미리보기" style="display: none;" />
				</div>

				<div class="form-group">
					<label for="upload2">대표 이미지</label> <img
						src="${contextPath}/image/plus.png" id="preview-thumbnail"
						alt="대표 이미지" width="100px"
						onclick="document.getElementById('upload2').click();" /> <input
						type="file" id="upload2" name="upload2" accept="image/*"
						style="display: none"
						onchange="readURL(this,'preview-thumbnail');" /> <img
						id="preview2" class="preview-img" src="#" alt="미리보기"
						style="display: none;" />
				</div>

				<div class="form-group">
					<label for="intro">브랜드 소개</label>
					<my:textArea name="intro" placeholder="내용을 입력하세요" />
				</div>

				<div class="form-group">
					<label for="bank">정산 은행명</label>
					<my:selectbox size="lg" id="bankSelect"
						items="국민은행,신한은행,우리은행,하나은행,농협은행" initial="은행명" />
					<input type="hidden" name="bank" id="bank" />
				</div>

				<div class="form-group">
					<label for="accountNumber">정산 계좌번호</label>
					<my:textInput id="accountNumber" name="accountNumber"
						type="default" size="lg" state="default" />
				</div>

				<div class="form-group">
					<label for="accountHolder">예금주명</label>
					<my:textInput id="accountHolder" name="accountHolder"
						type="default" size="lg" state="default" />
				</div>
			</div>
			<div class="apply-margin"></div>

			<button type="submit" class="btn btn-primary btn-xl signup">브랜드
				등록 완료</button>
		</form>
	</div>
</body>
<script src="./js/toast.js"></script>
<script src="./js/selectbox.js"></script>
<script>
  /*********************************************************************************************************
   * toast 호출
   *********************************************************************************************************/
	window.addEventListener("load", () => {
    	showToast("success", "회원가입이 완료되었습니다. 계속해서 브랜드 입점 신청을 진행해주세요.");
  	});
	
  /*********************************************************************************************************
   * 은행명 selectbox
   *********************************************************************************************************/
  document.addEventListener("DOMContentLoaded", () => {
    const selectEl = document.getElementById("bankSelect");
    const hiddenInput = document.getElementById("bank");

    selectEl.addEventListener("change", () => {
      hiddenInput.value = selectEl.value;
    });
  });
  
  /*********************************************************************************************************
   * 이미지 버튼
   *********************************************************************************************************/
   function readURL(input, previewId) {
	    if (input.files && input.files[0]) {
	      const reader = new FileReader();
	      reader.onload = function(e) {
	        document.getElementById(previewId).src = e.target.result;
	      }
	      reader.readAsDataURL(input.files[0]);
	    }
	  }
});
</script>
</html>
