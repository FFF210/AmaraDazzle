<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>브랜드 정보 수정</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="./css/reset.css" />
<link rel="stylesheet" href="./css/button.css" />
<link rel="stylesheet" href="./css/form-controls.css" />
<link rel="stylesheet" href="./css/layout.css" />
<link rel="stylesheet" href="./css/sidebar.css" />
<link rel="stylesheet" href="./css/header.css" />
<link rel="stylesheet" href="./css/selectbox.css" />
<link rel="stylesheet" href="./css/alert.css" />
<link rel="stylesheet" href="./css/dialog.css" />
<link rel="stylesheet" href="./css/uploader.css" />
<link rel="stylesheet" href="./css/textInput.css" />
<link rel="stylesheet" href="./css/textArea.css" />
<link rel="stylesheet" href="./css/breadcrumb.css" />
<link rel="stylesheet" href="./css/uploader.css" />
<link rel="stylesheet" href="./css/detailForm.css" />
</head>

<body class="<c:if test='${not empty product}'>edit-mode</c:if>">
	<my:layout>
		<div class="page-container">

			<!-- breadcrumb -->
			<div class="page-breadcrumb">
				<my:breadcrumb items="정보수정:" />
			</div>

			<!-- 페이지 헤더 -->
			<div class="page-header">
				<h2>정보 수정</h2>
			</div>

			<!-- 상품 등록/수정 폼 -->
			<form class="product-form">

				<section class="form-section">
					<h3>기본 정보</h3>

					<div class="form-group">
						<label>브랜드명</label>
						<my:textInput type="default" state="default" size="lg"
							value="20250827001" />
					</div>
					<div class="form-group image">
						<label>로고 이미지</label>
						<my:imageBtn name="upload1" />
					</div>
					<div class="form-group image">
						<label>배너 이미지</label>
						<my:uploader size="lg" id="fileInput1" label="Click to upload"
							desc="또는 파일을 이 영역으로 드래그하세요" />
					</div>
					<div class="form-group">
						<label>소개</label>
						<my:textArea name="ingredients" placeholder="입력" maxLength="200"
							showCount="true" />
					</div>
				</section>

				<section class="form-section">
					<h3>사업자 정보</h3>

					<div class="form-group">
						<label>사업자등록번호</label>
						<my:textInput type="default" state="default" size="lg"
							value="20250827001" />
					</div>
					<div class="form-group">
						<label>대표자명</label>
						<my:textInput type="default" state="default" size="lg"
							value="20250827001" />
					</div>
					<div class="form-group">
						<label>연락처</label>
						<my:textInput type="default" state="default" size="lg"
							value="20250827001" />
					</div>
				</section>

				<section class="form-section">
					<h3>정산 정보</h3>

					<div class="form-group">
						<label>은행명</label>
						<my:textInput type="default" state="default" size="lg"
							value="20250827001" />
					</div>
					<div class="form-group">
						<label>예금주명</label>
						<my:textInput type="default" state="default" size="lg"
							value="20250827001" />
					</div>
					<div class="form-group">
						<label>계좌번호</label>
						<my:textInput type="default" state="default" size="lg"
							value="20250827001" />
					</div>
				</section>

				<section class="form-section">
					<h3>배송 정보</h3>

					<div class="form-group">
						<label>출고지 주소</label>
						<my:textInput type="default" state="default" size="lg"
							value="20250827001" />
					</div>
					<div class="form-group">
						<label>반품/교환 주소</label>
						<my:textInput type="default" state="default" size="lg"
							value="20250827001" />
					</div>
					<div class="form-group">
						<label>기본 배송비</label>
						<my:textInput type="default" state="default" size="lg"
							value="20250827001" />
					</div>
					<div class="form-group">
						<label>무료배송 조건</label>
						<my:textInput type="default" state="default" size="lg"
							value="50,000 이상" />
					</div>
				</section>

				<!-- 버튼 -->
				<div class="form-actions">
					<button type="submit" class="btn btn-outline btn-xl">취소</button>
					<button type="submit" class="btn btn-primary btn-xl">수정</button>
				</div>
			</form>
		</div>
	</my:layout>
</body>
</html>

