<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>취소 상세</title>
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
<link rel="stylesheet" href="./css/table.css" />
<link rel="stylesheet" href="./css/detailForm.css" />
</head>

<body>
	<my:layout>
		<div class="page-container">

			<!-- breadcrumb -->
			<div class="page-breadcrumb">
				<my:breadcrumb items="취소관리:/order,취소상세:" />
			</div>

			<!-- 페이지 헤더 -->
			<div class="page-header">
				<h2>취소 상세</h2>
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
						<label>취소번호</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="20250827001" />
					</div>
					<div class="form-group">
						<label>요청일</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="2025-08-27" />
					</div>
					<div class="form-group tag">
						<label>취소상태</label>
						<my:tag color="green" size="lg" text="취소완료" />
					</div>
				</section>

				<section class="form-section">
					<h3>취소 상품</h3>
					<div class="table-wrapper">
						<table class="table">
							<thead>
								<tr>
									<th>번호</th>
									<th>상품명</th>
									<th>옵션</th>
									<th>수량</th>
									<th class="sortable">취소금액 <i class="bi bi-dash-lg sort-icon"></i></th>
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
					<div class="form-group chip-wrapper">
						<label>취소유형</label>
						<div class="chip">고객요청</div>
					</div>
					<div class="form-group">
						<label>요청사유</label>
						<my:textInput type="readOnly" state="default" size="lg" value="단순변심" />
					</div>
				</section>
				
				<section class="form-section">
					<h3>취소 처리</h3>
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
						<label>실제 취소액</label>
						<my:textInput type="readOnly" state="default" size="lg" value="33,000" />
					</div>
				</section>
			</form>
		</div>
	</my:layout>
</body>
</html>
