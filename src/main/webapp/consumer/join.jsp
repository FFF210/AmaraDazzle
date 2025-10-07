<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입</title>
<link rel="stylesheet" href="<c:url value='/tagcss/reset.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/modalRecent.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/productCard.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/tag.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/pagination.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/heartBtn.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/price.css'/>" />
<link rel="stylesheet" href="<c:url value='/consumer/css/header.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/join.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/textInput.css'/>">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<!-- 카카오 우편번호 서비스 -->
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
	<!-- 헤더 include -->
	<%@ include file="/consumer/header.jsp"%>

	<main class="join-container">
		<div class="join-box">
			<h1 class="join-title">회원가입</h1>

			<form id="joinForm" action="<c:url value='/store/join'/>"
				method="post">
				<!-- 아이디(이메일) -->
				<div class="input-group">
					<label for="email">아이디(이메일) <span class="required">*</span></label>
					<input type="email" id="email" name="email"
						placeholder="이메일 주소를 입력해주세요" required>
				</div>

				<!-- 비밀번호 -->
				<div class="input-group">
					<label for="password">비밀번호 <span class="required">*</span></label>
					<input type="password" id="password" name="password"
						placeholder="비밀번호를 입력하세요" required>
				</div>

				<!-- 비밀번호 확인 -->
				<div class="input-group">
					<label for="passwordConfirm">비밀번호 확인 <span class="required">*</span></label>
					<input type="password" id="passwordConfirm" name="passwordConfirm"
						placeholder="비밀번호를 다시 입력하세요" required>
					<div class="validation-message" id="passwordConfirmMessage"></div>
				</div>

				<!-- 닉네임 -->
				<div class="input-group">
					<label for="nickname">닉네임 <span class="required">*</span></label> <input
						type="text" id="nickname" name="nickname" placeholder="닉네임을 입력하세요"
						required>
				</div>

				<!-- 이름 -->
				<div class="input-group">
					<label for="name">이름 <span class="required">*</span></label> <input
						type="text" id="name" name="name" placeholder="이름을 입력하세요" required>
				</div>

				<!-- 휴대폰 번호 -->
				<div class="input-group">
					<label for="phone">휴대폰 번호 <span class="required">*</span></label> <input
						type="tel" id="phone" name="phone" placeholder="휴대폰 번호를 입력하세요"
						required>
				</div>

				<!-- 주소 -->
				<div class="input-group">
					<label for="address">주소 <span class="required">*</span></label>
					<div class="input-with-button">
						<input type="text" id="postcode" name="postcode"
							placeholder="우편번호" readonly>
						<button type="button" class="check-btn" onclick="findPostcode()">우편번호
							찾기</button>
					</div>
					<input type="text" id="line1" name="line1" placeholder="주소"
						readonly> <input type="text" id="line2" name="line2"
						placeholder="상세주소를 입력하세요">
				</div>

				<!-- 생년월일 -->
				<div class="input-group birthdate-group">
					<label for="birthDate">생년월일</label> <input type="date"
						id="birthDate" name="birthDate">
				</div>

				<!-- 성별 -->
				<div class="input-group">
					<label>성별</label>
					<div class="gender-group">
						<label class="radio-label"> <input type="radio"
							name="gender" value="M" id="male"> <span>남</span>
						</label> <label class="radio-label"> <input type="radio"
							name="gender" value="F" id="female"> <span>여</span>
						</label>
					</div>
				</div>

				<!-- 피부타입 -->
				<div class="input-group">
					<label>피부타입</label>
					<div class="skin-type-tags">
						<input type="radio" id="skin-dry" name="skinTypeId" value="1"
							class="tag-radio"> <label for="skin-dry"
							class="tag white md selectable-tag">건성</label> <input
							type="radio" id="skin-oily" name="skinTypeId" value="2"
							class="tag-radio"> <label for="skin-oily"
							class="tag white md selectable-tag">지성</label> <input
							type="radio" id="skin-combination" name="skinTypeId" value="3"
							class="tag-radio"> <label for="skin-combination"
							class="tag white md selectable-tag">복합성</label> <input
							type="radio" id="skin-sensitive" name="skinTypeId" value="4"
							class="tag-radio"> <label for="skin-sensitive"
							class="tag white md selectable-tag">민감성</label> <input
							type="radio" id="skin-dehydrated" name="skinTypeId" value="5"
							class="tag-radio"> <label for="skin-dehydrated"
							class="tag white md selectable-tag">수부지</label>
					</div>
				</div>


				<!-- 약관 동의 -->
				<div class="terms-section">
					<div class="terms-item">
						<label class="checkbox-label"> <input type="checkbox"
							id="agreeAll"> <span><strong>모두 동의합니다.</strong></span>
						</label>
					</div>
					<div class="terms-item">
						<label class="checkbox-label"> <input type="checkbox"
							id="termsRequired" name="termsRequired" required class="individual-terms"> <span>[필수]
								<a href="#" onclick="showTerms('privacy')">개인정보처리방침</a> 동의합니다.
						</span>
						</label>
					</div>
					<div class="terms-item">
						<label class="checkbox-label"> <input type="checkbox"
							id="termsService" name="termsService" required class="individual-terms"> <span>[필수]
								<a href="#" onclick="showTerms('service')">이용약관 및 정책</a> 동의합니다.
						</span>
						</label>
					</div>
					<div class="terms-item">
						<label class="checkbox-label"> <input type="checkbox"
							id="termsAge" name="termsAge" required class="individual-terms"> <span>[필수]
								만 14세 이상입니다.</span>
						</label>
					</div>
				</div>

				<button type="submit" class="join-btn">가입하기</button>
			</form>
		</div>
	</main>

	<!-- 푸터 include -->
	<%@ include file="/consumer/footer.jsp"%>

	<script src="<c:url value='/js/join.js'/>"></script>


	<script>
	// 우편번호 기능
		function findPostcode() {
			new daum.Postcode({
				oncomplete : function(data) {
					// 우편번호와 주소 정보를 해당 필드에 넣는다.
					document.getElementById('postcode').value = data.zonecode;
					document.getElementById('line1').value = data.roadAddress;

					// 상세주소 입력란으로 포커스
					document.getElementById('line2').focus();
				}
			}).open();
		}
		
		// 전체 동의 체크박스 기능
		document.addEventListener('DOMContentLoaded', function() {
		    const agreeAllCheckbox = document.getElementById('agreeAll');
		    const individualCheckboxes = document.querySelectorAll('.individual-terms');
		    
		    // 전체 동의 체크박스 클릭 시
		    agreeAllCheckbox.addEventListener('change', function() {
		        individualCheckboxes.forEach(checkbox => {
		            checkbox.checked = agreeAllCheckbox.checked;
		        });
		    });
		    
		    // 개별 체크박스 클릭 시 전체 동의 상태 확인
		    individualCheckboxes.forEach(checkbox => {
		        checkbox.addEventListener('change', function() {
		            const allChecked = Array.from(individualCheckboxes).every(cb => cb.checked);
		            agreeAllCheckbox.checked = allChecked;
		        });
		    });
		});
		</script>
	<!-- 에러 메시지 표시 -->
	<c:if test="${not empty errorMessage}">
		<script>
			alert('${errorMessage}');
		</script>
	</c:if>
</body>
</html>