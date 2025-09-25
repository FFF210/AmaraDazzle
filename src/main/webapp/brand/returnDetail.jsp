<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>반품 상세</title>
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
<link rel="stylesheet" href="./css/textInput.css" />
<link rel="stylesheet" href="./css/imageBtn.css" />
<link rel="stylesheet" href="./css/selectbox.css" />
<link rel="stylesheet" href="./css/table.css" />
<link rel="stylesheet" href="./css/detailForm.css" />
</head>

<body>
	<my:layout>
		<div class="page-container">

			<!-- breadcrumb -->
			<div class="page-breadcrumb">
				<my:breadcrumb items="반품관리:/order,반품상세:" />
			</div>

			<!-- 페이지 헤더 -->
			<div class="page-header">
				<h2>반품 상세</h2>
			</div>

			<!-- 취소 상세 폼 -->
			<form class="product-form">

				<section class="form-section">
					<h3>기본 정보</h3>
					<div class="form-group">
						<label>주문번호</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="20250827001" />
					</div>
					<div class="form-group">
						<label>반품번호</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="20250827001" />
					</div>
					<div class="form-group">
						<label>요청일</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="2025-08-27" />
					</div>
					<div class="form-group tag">
						<label>반품상태</label>
						<my:tag color="green" size="lg" text="취소완료" />
					</div>
				</section>

				<section class="form-section">
					<h3>반품 상품</h3>
					<div class="table-wrapper">
						<table class="table">
							<thead>
								<tr>
									<th>번호</th>
									<th>상품명</th>
									<th>옵션</th>
									<th>수량</th>
									<th class="sortable">환불금액 <i class="bi bi-dash-lg sort-icon"></i></th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>1</td>
									<td>[스테디셀러특가] 어노브 트리트먼트 320ml</td>
									<td>더블기획</td>
									<td>2</td>
									<td>50,100</td>
								</tr>
								<tr>
									<td>2</td>
									<td>[스테디셀러특가] 어노브 트리트먼트 320ml</td>
									<td>더블기획</td>
									<td>2</td>
									<td>50,100</td>
								</tr>
								<tr>
									<td>3</td>
									<td>[스테디셀러특가] 어노브 트리트먼트 320ml</td>
									<td>더블기획</td>
									<td>2</td>
									<td>50,100</td>
								</tr>
								<tr>
									<td>4</td>
									<td>[스테디셀러특가] 어노브 트리트먼트 320ml</td>
									<td>더블기획</td>
									<td>2</td>
									<td>50,100</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="form-group-br"></div>
					<div class="form-group">
						<label>반품사유</label>
						<my:textInput type="readOnly" state="default" size="lg" value="단순변심" />
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
					<h3>반품 처리</h3>
					<div class="form-group">
						<label>총 결제 금액</label>
						<my:textInput type="readOnly" state="default" size="lg" value="33,000" />
					</div>
					<div class="form-group">
						<label>쿠폰 할인액</label>
						<my:textInput type="readOnly" state="default" size="lg" value="2,000" />
					</div>
					<div class="form-group chip-wrapper">
						<label>쿠폰 내역</label>
						<div class="chip">3만원 이상 구매 시 2천원 할인</div>
					</div>
					<div class="form-group">
						<label>포인트 사용액</label>
						<my:textInput type="readOnly" state="default" size="lg" value="33,000" />
					</div>
					<div class="form-group">
						<label>실제 환불액</label>
						<my:textInput type="readOnly" state="default" size="lg" value="33,000" />
					</div>
					<div class="form-group">
						<label>반품비 부담 주체 <span class="required">*</span></label>
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
