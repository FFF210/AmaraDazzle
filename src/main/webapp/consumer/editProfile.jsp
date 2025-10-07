<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<link rel="stylesheet" href="<c:url value='/tagcss/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/modalRecent.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/productCard.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/tag.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/pagination.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/heartBtn.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/price.css'/>" />
<link rel="stylesheet" href="<c:url value='/consumer/css/header.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/editProfile.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/textInput.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/button.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/mypageMenu.css'/>">
</head>
<body>
	<%-- 헤더 --%>
	<%@ include file="/consumer/header.jsp"%>

	<div class="page-wrap">
		<main class="editProfile-content">
			<h1>회원정보 수정</h1>

			<!-- ⭐ form 태그 추가 -->
			<form method="post" action="${pageContext.request.contextPath}/store/mypage/editProfile">

				<section class="basic-info">
					<!-- 닉네임 -->
					<div class="form-row nickname-row">
						<div class="label">닉네임</div>
						<div class="input-wrapper">
							<my:textInput type="default" name="nickname" value="${member.nickname}" size="lg" />
						</div>
					</div>
					
					<!-- 비밀번호 (기존 값 안 보여줌) -->
					<div class="form-row password-row">
						<div class="label">비밀번호</div>
						<div class="input-wrapper">
							<my:textInput type="password" name="password" value="" size="lg" placeholder="변경하려면 입력" />
						</div>
					</div>
					<div class="form-row password-row">
						<div class="label">비밀번호 확인</div>
						<div class="input-wrapper">
							<my:textInput type="password" name="passwordConfirm" value="" size="lg" />
						</div>
					</div>
					
					<!-- 연락처 -->
					<div class="form-row phone-row">
						<div class="label">연락처</div>
						<div class="input-wrapper">
							<my:textInput type="default" name="phone" value="${member.phone}" size="lg" />
						</div>
					</div>
					
					<!-- 주소 -->
					<div class="form-row address-row">
						<div class="label">주소</div>
						<div class="input-area address-row">
							<div class="address-input-group">
								<my:textInput id="postcode" name="postcode" value="${member.postcode}" 
									type="default" size="sm" state="default" />
								<button type="button" class="btn btn-outline btn-md"
									style="width: auto; min-width: auto;">우편번호 찾기</button>
							</div>
							<div class="detail-address">
								<my:textInput id="line1" name="line1" value="${member.line1}"
									type="default" size="sm" state="default" />
								<my:textInput id="line2" name="line2" value="${member.line2}"
									type="default" size="sm" state="default" />
							</div>
						</div>
					</div>
				</section>

				<section class="additional-info">
					<!-- 생년월일 -->
					<div class="form-row birthdate-row">
						<div class="label">생년월일</div>
						<div class="input-wrapper">
							<my:textInput type="date" name="birthDate" 
								value="<fmt:formatDate value='${member.birthDate}' pattern='yyyy-MM-dd'/>" size="lg" />
						</div>
					</div>
					
					<!-- 성별 추가 -->
					<div class="form-row gender-row">
						<div class="label">성별</div>
						<div class="input-wrapper">
							<input type="radio" id="gender-m" name="gender" value="M" 
								${member.gender == 'M' ? 'checked' : ''}>
							<label for="gender-m">남성</label>
							
							<input type="radio" id="gender-f" name="gender" value="F"
								${member.gender == 'F' ? 'checked' : ''}>
							<label for="gender-f">여성</label>
						</div>
					</div>
				</section>

				<section class="skin-info">
					<!-- 피부타입 -->
					<div class="form-row skin-type">
						<div class="label">피부타입</div>
						<div class="skin-type-tags">
							<input type="radio" id="skin-dry" name="skinTypeId" value="14"
								class="tag-radio" ${member.skinTypeId == 14 ? 'checked' : ''}> 
							<label for="skin-dry" class="tag white md selectable-tag">건성</label>
							
							<input type="radio" id="skin-oily" name="skinTypeId" value="15"
								class="tag-radio" ${member.skinTypeId == 15 ? 'checked' : ''}> 
							<label for="skin-oily" class="tag white md selectable-tag">지성</label>
							
							<input type="radio" id="skin-normal" name="skinTypeId" value="16"
								class="tag-radio" ${member.skinTypeId == 16 ? 'checked' : ''}> 
							<label for="skin-normal" class="tag white md selectable-tag">중성</label>
							
							<input type="radio" id="skin-sensitive" name="skinTypeId" value="17"
								class="tag-radio" ${member.skinTypeId == 17 ? 'checked' : ''}> 
							<label for="skin-sensitive" class="tag white md selectable-tag">민감성</label>
							
							<input type="radio" id="skin-combination" name="skinTypeId" value="18"
								class="tag-radio" ${member.skinTypeId == 18 ? 'checked' : ''}> 
							<label for="skin-combination" class="tag white md selectable-tag">복합성</label>
							
							<input type="radio" id="skin-dehydrated-oily" name="skinTypeId" value="19" 
								class="tag-radio" ${member.skinTypeId == 19 ? 'checked' : ''}> 
							<label for="skin-dehydrated-oily" class="tag white md selectable-tag">수부지</label>
						</div>
					</div>
					
					<!-- 퍼스널컬러 -->
					<div class="form-row personal-color">
						<div class="label">퍼스널컬러</div>
						<div class="personal-color-tags">
							<input type="radio" id="spring-warm" name="personalColorId" value="20" 
								class="tag-radio" ${member.personalColorId == 20 ? 'checked' : ''}> 
							<label for="spring-warm" class="tag white md selectable-tag">봄웜톤</label>
							
							<input type="radio" id="summer-cool" name="personalColorId" value="21"
								class="tag-radio" ${member.personalColorId == 21 ? 'checked' : ''}> 
							<label for="summer-cool" class="tag white md selectable-tag">여름쿨톤</label>
							
							<input type="radio" id="autumn-warm" name="personalColorId" value="23"
								class="tag-radio" ${member.personalColorId == 23 ? 'checked' : ''}> 
							<label for="autumn-warm" class="tag white md selectable-tag">가을웜톤</label>
							
							<input type="radio" id="winter-cool" name="personalColorId" value="24"
								class="tag-radio" ${member.personalColorId == 24 ? 'checked' : ''}> 
							<label for="winter-cool" class="tag white md selectable-tag">겨울쿨톤</label>
							
							<input type="radio" id="unknown" name="personalColorId" value="25"
								class="tag-radio" ${member.personalColorId == 25 ? 'checked' : ''}> 
							<label for="unknown" class="tag white md selectable-tag">잘모르겠어요</label>
						</div>
					</div>
					
					<!-- 피부고민 (체크박스) -->
					<div class="form-row skin-issue">
						<div class="label">피부고민</div>
						<div class="skin-issue-tags">
							<input type="checkbox" id="issue-atopy" name="skinIssues" value="1" 
								class="tag-checkbox" ${skinIssues.contains(1) ? 'checked' : ''}> 
							<label for="issue-atopy" class="tag white md selectable-tag">아토피</label>
							
							<input type="checkbox" id="issue-calming" name="skinIssues" value="2" 
								class="tag-checkbox" ${skinIssues.contains(2) ? 'checked' : ''}> 
							<label for="issue-calming" class="tag white md selectable-tag">진정</label>
							
							<input type="checkbox" id="issue-acne" name="skinIssues" value="3" 
								class="tag-checkbox" ${skinIssues.contains(3) ? 'checked' : ''}> 
							<label for="issue-acne" class="tag white md selectable-tag">여드름</label>
							
							<input type="checkbox" id="issue-whitening" name="skinIssues" value="4" 
								class="tag-checkbox" ${skinIssues.contains(4) ? 'checked' : ''}> 
							<label for="issue-whitening" class="tag white md selectable-tag">미백,잡티</label>
							
							<input type="checkbox" id="issue-sebum" name="skinIssues" value="5" 
								class="tag-checkbox" ${skinIssues.contains(5) ? 'checked' : ''}> 
							<label for="issue-sebum" class="tag white md selectable-tag">피지,블랙헤드</label>
							
							<input type="checkbox" id="issue-keratin" name="skinIssues" value="6" 
								class="tag-checkbox" ${skinIssues.contains(6) ? 'checked' : ''}> 
							<label for="issue-keratin" class="tag white md selectable-tag">각질</label>
							
							<input type="checkbox" id="issue-darkcircle" name="skinIssues" value="7" 
								class="tag-checkbox" ${skinIssues.contains(7) ? 'checked' : ''}> 
							<label for="issue-darkcircle" class="tag white md selectable-tag">다크서클</label>
							
							<input type="checkbox" id="issue-pore" name="skinIssues" value="8" 
								class="tag-checkbox" ${skinIssues.contains(8) ? 'checked' : ''}> 
							<label for="issue-pore" class="tag white md selectable-tag">모공</label>
							
							<input type="checkbox" id="issue-redness" name="skinIssues" value="9" 
								class="tag-checkbox" ${skinIssues.contains(9) ? 'checked' : ''}> 
							<label for="issue-redness" class="tag white md selectable-tag">홍조</label>
							
							<input type="checkbox" id="issue-aging" name="skinIssues" value="10" 
								class="tag-checkbox" ${skinIssues.contains(10) ? 'checked' : ''}> 
							<label for="issue-aging" class="tag white md selectable-tag">슬로우에이징</label>
							
							<input type="checkbox" id="issue-moisture" name="skinIssues" value="11" 
								class="tag-checkbox" ${skinIssues.contains(11) ? 'checked' : ''}> 
							<label for="issue-moisture" class="tag white md selectable-tag">피부보습,속건조</label>
							
							<input type="checkbox" id="issue-sunblock" name="skinIssues" value="12" 
								class="tag-checkbox" ${skinIssues.contains(12) ? 'checked' : ''}> 
							<label for="issue-sunblock" class="tag white md selectable-tag">자외선차단</label>
							
							<input type="checkbox" id="issue-none" name="skinIssues" value="13" 
								class="tag-checkbox" ${skinIssues.contains(13) ? 'checked' : ''}> 
							<label for="issue-none" class="tag white md selectable-tag">해당없음</label>
						</div>
					</div>
				</section>

				<!-- 마케팅 동의 -->
				<div class="agreement">
					<div class="terms-item">
						<label class="checkbox-label"> 
							<input type="checkbox" id="marketingOpt" name="marketingOpt" 
								${member.marketingOpt == 1 ? 'checked' : ''}> 
							<span><strong>마케팅 활용 및 광고성 정보 수신 동의(선택)</strong></span>
						</label>
					</div>
				</div>

				<div class="delete-account">
					<a href="">회원 탈퇴하기</a>
				</div>

				<div class="button-container">
					<button type="submit" class="btn btn-primary btn-lg">확인</button>
				</div>
			</form>
		</main>
	</div>

	<%-- 푸터 --%>
	<%@ include file="/consumer/footer.jsp"%>
</body>
</html>