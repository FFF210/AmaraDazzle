<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>주문 상세</title>
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
				<my:breadcrumb items="주문관리:/order,주문상세:" />
			</div>

			<!-- 페이지 헤더 -->
			<div class="page-header">
				<h2>주문 상세</h2>
			</div>

			<!-- 주문 상세 폼 -->
			<form class="product-form">

				<section class="form-section">
					<h3>주문 정보</h3>
					<div class="form-group">
						<label>주문번호</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="20250827001" />
					</div>
					<div class="form-group">
						<label>주문일</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="2025-08-27" />
					</div>
					<div class="form-group tag">
						<label>주문상태</label>
						<my:tag color="green" size="lg" text="결제완료" />
					</div>
					<div class="form-group">
						<label>결제 수단</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="토스페이" />
					</div>
					<div class="form-group">
						<label>할인 금액</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="202,000" />
					</div>
					<div class="form-group">
						<label>쿠폰/포인트 금액</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="202,000" />
					</div>
					<div class="form-group chip-wrapper">
						<label>쿠폰 내역</label>
						<div class="chip">3만원 이상 구매 시 2천원 할인</div>
					</div>
					<div class="form-group">
						<label>총 결제 금액</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="200,000" />
					</div>
				</section>

				<section class="form-section">
					<h3>주문자 정보</h3>
					<div class="form-group">
						<label>주문인</label>
						<my:textInput type="readOnly" state="default" size="lg" value="김철수" />
					</div>
					<div class="form-group">
						<label>연락처</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="010-0000-1234" />
					</div>
					<div class="form-group">
						<label>이메일</label>
						<my:textInput type="readOnly" state="default" size="lg"
							value="kosta@email.com" />
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
				</section>

				<section class="form-section">
					<h3>주문 상품</h3>
					<div class="table-wrapper">
						<table class="table">
							<thead>
								<tr>
									<th>번호</th>
									<th>상품명</th>
									<th>옵션</th>
									<th>수량</th>
									<th class="sortable">결제금액 <i class="bi bi-dash-lg sort-icon"></i></th>
									<th>상태</th>
									<th>관리 액션</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>1</td>
									<td>[스테디셀러특가] 어노브 트리트먼트 320ml</td>
									<td>더블기획</td>
									<td>2</td>
									<td>50,100</td>
									<td><my:tag color="green" size="sm" text="결제완료" /></td>
									<td><button class="btn btn-outline btn-sm">취소 신청</button></td>
								</tr>
								<tr>
									<td>2</td>
									<td>[스테디셀러특가] 어노브 트리트먼트 320ml</td>
									<td>더블기획</td>
									<td>2</td>
									<td>50,100</td>
									<td><my:tag color="red" size="sm" text="취소요청" /></td>
									<td><button class="btn btn-outline btn-sm">취소 확인</button></td>
								</tr>
								<tr>
									<td>3</td>
									<td>[스테디셀러특가] 어노브 트리트먼트 320ml</td>
									<td>더블기획</td>
									<td>2</td>
									<td>50,100</td>
									<td><my:tag color="purple" size="sm" text="교환신청" /></td>
									<td><button class="btn btn-outline btn-sm">교환 확인</button></td>
								</tr>
								<tr>
									<td>4</td>
									<td>[스테디셀러특가] 어노브 트리트먼트 320ml</td>
									<td>더블기획</td>
									<td>2</td>
									<td>50,100</td>
									<td><my:tag color="orange" size="sm" text="반품신청" /></td>
									<td><button class="btn btn-outline btn-sm">반품 확인</button></td>
								</tr>
							</tbody>
						</table>
					</div>
				</section>
				
				<section class="form-section">
					<h3>배송 정보</h3>
					<div class="form-group">
						<label>송장번호</label>
						<my:textInput type="default" state="default" size="lg" value="0019288172" />
					</div>
					<div class="form-group tag">
						<label>배송상태</label>
						<my:tag color="green" size="lg" text="결제완료" />
					</div>
					<div class="form-group">
						<label>발송일자</label>
						<my:textInput type="default" state="default" size="lg"
							value="2025-09-10" />
					</div>
				</section>
			</form>
		</div>
	</my:layout>
</body>
</html>
