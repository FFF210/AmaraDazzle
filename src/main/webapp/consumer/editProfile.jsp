<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<link rel="stylesheet" href="<c:url value='/tagcss/reset.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/header.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>">
<link rel="stylesheet"
	href="<c:url value='/consumer/css/orderDetail.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/textInput.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/table.css'/>">
<link rel="stylesheet"
	href="<c:url value='/consumer/css/mypageMenu.css'/>">
</head>
<body>
	<%-- 헤더 --%>
	<%@ include file="/consumer/header.jsp"%>

	<div class="page-wrap">
		<main class="editProfile-content">
			<h1>회원정보 수정</h1>

			<section class="basic-info">
			<!-- 닉네임 -->
				<div class="form-row nickname-row">
					<div class="label">닉네임</div>
					<div class="input-wrapper">
						<my:textInput type="default" name="nickname" value="" size="lg" />
					</div>
				</div>
				<!-- 비밀번호 -->
				<div class="form-row password-row">
					<div class="label">비밀번호</div>
					<div class="input-wrapper">
						<my:textInput type="default" name="nickname" value="" size="lg" />
					</div>
				</div>
				<div class="form-row password-row">
					<div class="label">비밀번호 확인</div>
					<div class="input-wrapper">
						<my:textInput type="default" name="nickname" value="" size="lg" />
					</div>
				</div>
				<!-- 연락처 -->
				<div class="form-row phone-row">
					<div class="label">연락처</div>
					<div class="input-wrapper">
						<my:textInput type="default" name="nickname" value="" size="lg" />
					</div>
				</div>
				<!-- 주소 -->
				<div class="form-row address-row">
					<div class="label">
						주소 <span class="required">*</span>
					</div>
					<div class="input-area address-row">
						<div class="address-input-group">
						<my:textInput id="shipPostcode" name="shipPostcode"
										value="$" type="default"
										size="sm" state="default" />
									<button type="button" class="btn btn-outline btn-md"
										style="width: auto; min-width: auto;">우편번호 찾기</button>
								</div>
								<div class=detail-address>
									<my:textInput id="shipLine1" name="shipLine1"
										value="" type="default" size="sm"
										state="default" />
									<my:textInput id="shipLine2" name="shipLine2"
										value="" type="default" size="sm"
										state="default" /></div>
					</div>
				</div>
			</section>

			<section class="additional-info"></section>
			<!-- 생년월일 -->
			<div class="form-row birthdate-row">
					<div class="label">생년월일</div>
					<div class="input-wrapper">
						<my:textInput type="default" name="birthdate" value="" size="lg" />
					</div>
				</div>
				<!-- 기타 -->
				<div class="form-row additional-row">
				<div class="label">기타상세내용</div>
					<div class="input-wrapper">
						<my:textInput type="default" name="nickname" value="" size="lg" />
					</div>
				</div>
			
			<section class="skin-info">
			<div class="form-row skin-type">
					<div class="label">피부타입</div>
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
				<label>퍼스널컬러</label>
					<div class="skin-type-tags">
						<input type="radio" id="cooltone" name="personalColorId" value="1"
							class="tag-radio"> <label for="skin-dry"
							class="tag white md selectable-tag">쿨톤</label> <input
							type="radio" id="warmtone" name="personalColorId" value="2"
							class="tag-radio"> <label for="skin-oily"
							class="tag white md selectable-tag">웜톤</label> <input
							type="radio" id="skin-combination" name="personalColorId" value="3"
							class="tag-radio"> <label for="skin-combination"
							class="tag white md selectable-tag">봄웜톤</label> <input
							type="radio" id="skin-sensitive" name="personalColorId" value="4"
							class="tag-radio"> <label for="skin-sensitive"
							class="tag white md selectable-tag">여름쿨톤</label> <input
							type="radio" id="skin-dehydrated" name="personalColorId" value="5"
							class="tag-radio"> <label for="skin-dehydrated"
							class="tag white md selectable-tag">겨울쿨톤</label>
					</div>
					<label>피부고민</label>
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
			</section>


			<div class="agreement">
			<div class="terms-item">
						<label class="checkbox-label"> <input type="checkbox"
							id="agreeAll"> <span><strong>마케팅 활용 및 광고성 정보 수신 동의(선택) </strong></span>
						</label>
			</div>
			</div>

			<div class="delete-account">
			<a href=""></a>
			</div>

		</main>
	</div>

	<%-- 푸터 --%>
	<%@ include file="/consumer/footer.jsp"%>
</body>
</html>