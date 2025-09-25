<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>교환 상세</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="./css/reset.css" />
<link rel="stylesheet" href="./css/button.css" />
<link rel="stylesheet" href="./css/form-controls.css" />
<link rel="stylesheet" href="./css/layout.css" />
<link rel="stylesheet" href="./css/sidebar.css" />
<link rel="stylesheet" href="./css/header.css" />
<link rel="stylesheet" href="./css/breadcrumb.css" />
<link rel="stylesheet" href="./css/tag.css" />
<link rel="stylesheet" href="./css/imageBtn.css" />
<link rel="stylesheet" href="./css/selectbox.css" />
<link rel="stylesheet" href="./css/textInput.css" />
<link rel="stylesheet" href="./css/table.css" />
<link rel="stylesheet" href="./css/detailForm.css" />
</head>

<body>
	<my:layout>
		<div class="page-container">

			<!-- breadcrumb -->
			<div class="page-breadcrumb">
				<my:breadcrumb items="교환관리:/order,교환상세:" />
			</div>

			<!-- 페이지 헤더 -->
			<div class="page-header">
				<h2>교환 상세</h2>
			</div>

			<!-- 교환  상세 폼 -->
			<form class="product-form">

				<section class="form-section">
					<h3>기본 정보</h3>
					<div class="form-group">
						<label>주문번호</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="20250827001" />
					</div>
					<div class="form-group">
						<label>교환번호</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="20250827001" />
					</div>
					<div class="form-group">
						<label>교환 요청일</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="2025-08-27" />
					</div>
					<div class="form-group tag">
						<label>교환상태</label>
						<my:tag color="green" size="lg" text="결제완료" />
					</div>
				</section>

				<section class="form-section">
					<h3>교환 상품</h3>
					<div class="form-group">
						<label>상품명</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="김철수" />
					</div>
					<div class="form-group">
						<label>옵션</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="010-0000-1234" />
					</div>
					<div class="form-group">
						<label>수량</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="kosta@email.com" />
					</div>
					<div class="form-group">
						<label>결제금액</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="kosta@email.com" />
					</div>
					<div class="form-group">
						<label>희망옵션</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="kosta@email.com" />
					</div>
					<div class="form-group">
						<label>요청사유</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="kosta@email.com" />
					</div>
					<div class="form-group">
						<label>첨부파일</label>
						<div class="form-image-group">
							<my:imageBtn name="upload1" />
							<my:imageBtn name="upload1" />
							<my:imageBtn name="upload1" />
						</div>
					</div>
				</section>

				<section class="form-section">
					<h3>교환 처리</h3>
					<div class="form-group tag">
						<label>재고 확인 결과</label>
						<my:tag color="green" size="lg" text="결제완료" />
					</div>
					<div class="form-group">
						<label>교환비 부담 주체 <span class="required">*</span></label>
						<my:selectbox size="lg" items="구매자,판매자" />
					</div>
					<div class="form-group">
						<label>추가 결제 금액</label>
						<my:textInput type="default" state="default" size="lg" value=" " />
					</div>
					<div class="form-group">
						<label>회수 송장번호</label>
						<my:textInput type="default" state="default" size="lg" value=" " />
					</div>
					<div class="form-group">
						<label>발송 송장번호</label>
						<my:textInput type="default" state="default" size="lg" value=" " />
					</div>
				</section>

				<!-- 버튼 -->
				<div class="form-actions">
					<button type="submit" class="btn btn-outline btn-xl">거절</button>
					<button type="submit" class="btn btn-primary btn-xl">승인</button>
				</div>
			</form>
		</div>
	</my:layout>
</body>
</html>
