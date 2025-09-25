<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>배송 상세</title>
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
				<my:breadcrumb items="배송관리:/order,배송상세:" />
			</div>

			<!-- 페이지 헤더 -->
			<div class="page-header">
				<h2>배송 상세</h2>
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
						<label>배송번호</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="20250827001" />
					</div>
					<div class="form-group">
						<label>발송일</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="2025-08-27" />
					</div>
					<div class="form-group tag">
						<label>배송상태</label>
						<my:tag color="green" size="lg" text="취소완료" />
					</div>
				</section>
				
				<section class="form-section">
					<h3>수령인 정보</h3>
					<div class="form-group">
						<label>수령인</label>
						<my:textInput type="readOnly" state="default" size="lg" value="김철수" />
					</div>
					<div class="form-group">
						<label>연락처</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="010-0000-1234" />
					</div>
					<div class="form-group">
						<label>주소</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="인천 연수구 인천타워대로 132번길" />
					</div>
					<div class="form-group">
						<label>배송 요청사항</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="인천 연수구 인천타워대로 132번길" />
					</div>
				</section>

				<section class="form-section">
					<h3>배송 상품</h3>
					<div class="table-wrapper">
						<table class="table">
							<thead>
								<tr>
									<th>번호</th>
									<th>상품명</th>
									<th>옵션</th>
									<th>수량</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>1</td>
									<td>[스테디셀러특가] 어노브 트리트먼트 320ml</td>
									<td>더블기획</td>
									<td>2</td>
								</tr>
								<tr>
									<td>2</td>
									<td>[스테디셀러특가] 어노브 트리트먼트 320ml</td>
									<td>더블기획</td>
									<td>2</td>
								</tr>
								<tr>
									<td>3</td>
									<td>[스테디셀러특가] 어노브 트리트먼트 320ml</td>
									<td>더블기획</td>
									<td>2</td>
								</tr>
								<tr>
									<td>4</td>
									<td>[스테디셀러특가] 어노브 트리트먼트 320ml</td>
									<td>더블기획</td>
									<td>2</td>
								</tr>
							</tbody>
						</table>
					</div>
				</section>
				
				<section class="form-section">
					<h3>배송 처리</h3>
					<div class="form-group">
						<label>운송장 번호 <span class="required">*</span></label>
						<my:textInput type="readOnly" state="default" size="lg" value="33,000" />
					</div>
				</section>
				
				<!-- 버튼 -->
				<div class="form-actions">
					<button type="submit" class="btn btn-primary btn-xl">수정</button>
				</div>
			</form>
		</div>
	</my:layout>
</body>
</html>
