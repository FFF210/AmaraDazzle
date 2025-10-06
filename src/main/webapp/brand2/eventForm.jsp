<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 신청</title>

<link rel="stylesheet" href="./css/formLayout.css" />

<link rel="stylesheet" href="../tagcss/selectbox.css" />
<link rel="stylesheet" href="../tagcss/textArea.css" />
<link rel="stylesheet" href="../tagcss/uploader.css" />
<link rel="stylesheet" href="../tagcss/tag.css" />
<link rel="stylesheet" href="../tagcss/breadcrumb.css" />
<link rel="stylesheet" href="../tagcss/dateInput.css" />
<link rel="stylesheet" href="../tagcss/form-controls.css" />
<link rel="stylesheet" href="../tagcss/brandHeader.css" />
<link rel="stylesheet" href="../tagcss/layout.css" />
<link rel="stylesheet" href="../tagcss/reset.css" />
<link rel="stylesheet" href="../tagcss/sidebar.css" />
<link rel="stylesheet" href="../tagcss/tableFilter.css" />
<link rel="stylesheet" href="../tagcss/pagination.css" />
<link rel="stylesheet" href="../tagcss/table.css" />
<link rel="stylesheet" href="../tagcss/button.css" />
<link rel="stylesheet" href="../tagcss/textInput.css" />


<!-- 달력 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">

<style>
.pagination {
	display: flex;
	justify-content: center; /* 수평 가운데 정렬 */
	margin: 20px 0; /* 위아래 여백 */
}

.breadcrumb {
	margin-top: 8px;
	margin-left: 24px;
}
</style>

<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="../tagjs/selectbox.js"></script>

</head>
<body>
	<my:layout>

		<my:breadcrumb items="이벤트 관리:/brand2/eventList.jsp" />
		<my:brand2formLayout title="이벤트 신청" formId="eventForm">

			<div class="grid">
				<!-- 이벤트 ID (숨김) -->
				<input type="hidden" id="eventId" name="eventId"
					value="${param.eventId}" />

				<!-- selectbox.tag -->
				<div class="label req">이벤트 종류</div>
				<div class="custom-select lg" id="eventTypeSelect">
					<div class="select-header">
						<span class="select-label">이벤트 선택 </span> <i
							class="bi bi-chevron-down"></i>
					</div>
					<ul class="select-list">
						<c:forEach var="t" items="${eventTypes}">
							<li class="select-item" data-value="${t}">${t}</li>
						</c:forEach>
					</ul>
					<!-- 서버로 넘길 값 -->
					<input type="hidden" name="eventId"
						value="${selectedEvent.eventId}" />
				</div>
				<!-- selectbox.tag -->
				<!-- 이벤트명 -->
				<div class="label req">이벤트명</div>
				<div class="custom-select lg" id="eventNameSelect">
					<div class="select-header">
						<span class="select-label">이벤트명 선택</span> <i
							class="bi bi-chevron-down"></i>
					</div>
					<ul class="select-list" id="eventNameList">
						<!-- Ajax 결과로 채워짐 -->
					</ul>
					<input type="hidden" name="eventId" id="eventIdInput" />
				</div>

				<div class="label req">광고담당자</div>
				<div>
					<my:textInput id="managerName" name="managerName"
						placeholder="담당자 성함을 입력하세요." type="default" size="sm"
						state="default" />
				</div>

				<div class="label req">담당연락처</div>
				<div>
					<my:textInput id="managerTel" name="managerTel"
						placeholder="담당연락처를 입력하세요." type="default" size="sm"
						state="default" />
				</div>

				<div class="label req">상품코드</div>
				<div>
					<div class="product-row">
						<my:textInput id="productInput" name="productIds"
							placeholder="상품코드를 입력하세요." type="default" size="sm"
							state="default" />
						<button type="button" class="btn icon" id="addProduct"
							aria-label="상품코드 추가">＋</button>
					</div>
					<div class="chips" id="productChips" aria-live="polite"></div>
					<p class="help">여러 개 추가 가능 • 잘못 넣었으면 ×로 삭제</p>
				</div>

				<div class="label">쿠폰 설정</div>
				<div>
					<div class="coupon-box" id="couponBox">

						<!-- grid -->
						<div class="grid"
							style="grid-template-columns: 140px 1fr; gap: 10px 12px">
							<div class="label req">쿠폰명</div>
							<div>
								<my:textInput id="couponName" name="cname"
									placeholder="쿠폰명을 입력하세요." type="default" size="sm"
									state="default" />
							</div>

							<div class="label req">기간</div>
							<div class="inline date-row">
								<input id="couponFrom" name="startDate" type="date">
								<span>~</span> <input id="couponTo" name="endDate"
									type="date">
							</div>


							<div class="label req">최소주문</div>
							<div class="inline">
								<div class="text-input-wrapper size--sm state--default">
									<div class="text-input-inner default">
										<input id="couponMin" name="amountCondition" type="number" min="0" step="100"
											placeholder="0" class="text-input"> <span
											class="muted">원 이상 구매 시</span>
									</div>
								</div>
							</div>


							<div class="label req">할인</div>
							<div class="inline">
								<div class="text-input-wrapper size--sm state--default">
									<div class="text-input-inner default">
										<input id="couponAmount" name="amount" type="number" min="0"
											step="100" placeholder="0" class="text-input"> <span
											class="muted">원 할인</span>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="label">관리자 전달사항</div>
				<div>
					<my:textArea id="note" name="note" placeholder="관리자에게 문의&참고할 사항 전달" />
				</div>
			</div>

			<div class="footer">
				<button type="button" class="btn btn-outline btn-sm" id="btnClose"
					onclick="location.href='/brand2/eventList'">닫기</button>
				<button type="submit" class="btn btn-outline btn-sm" id="btnSubmit">신청하기</button>
			</div>

		</my:brand2formLayout>
	</my:layout>


	<!-- Toast -->
	<div id="toast" class="toast" role="status" aria-live="polite"></div>

	<script src="./js/eventForm.js"></script>
	<script>
      document.addEventListener("selectChanged", (e) => {
        console.log("선택된 값:", e.detail.value); // 실제 값
        console.log("선택된 텍스트:", e.detail.text); // 표시되는 텍스트
      });
    </script>
</body>
</html>