<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메일발송</title>

<link rel="stylesheet" href="./css/formLayout.css" />

<link rel="stylesheet" href="../tagcss/selectbox.css" />
<link rel="stylesheet" href="../tagcss/textArea.css" />
<link rel="stylesheet" href="../tagcss/uploader.css" />
<link rel="stylesheet" href="../tagcss/tag.css" />
<link rel="stylesheet" href="../tagcss/breadcrumb.css" />
<link rel="stylesheet" href="../tagcss/dateInput.css" />
<link rel="stylesheet" href="../tagcss/form-controls.css" />
<link rel="stylesheet" href="../tagcss/header.css" />
<link rel="stylesheet" href="../tagcss/layout.css" />
<link rel="stylesheet" href="../tagcss/reset.css" />
<link rel="stylesheet" href="../tagcss/selectbox.css" />
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

</head>
<body>
	<my:layout>
		<my:breadcrumb
			items="메일 발송:/brand2/mailForm.jsp, 메일 발송 관리:/brand2/mailList.jsp" />
		<my:brand2formLayout title="마케팅 메일 발송" formId="mailForm">
			<div class="grid">
				<!-- 템플릿 선택 -->
				<div class="label req">메일 유형</div>
				<div class="template-tabs" role="tablist" aria-label="메일 유형 선택">
					<button type="button" class="tab is-active" data-template="coupon"
						role="tab" aria-selected="true">할인쿠폰 안내</button>
					<button type="button" class="tab" data-template="new" role="tab"
						aria-selected="false">신제품 출시 소식</button>
					<button type="button" class="tab" data-template="recommend"
						role="tab" aria-selected="false">상품추천</button>
					<input type="hidden" id="templateType" name="templateType"
						value="coupon" />
				</div>

				<!-- 대상 -->
				<div class="label req">대상</div>
				<div class="inline">
					<!--             <label class="radio"><input type="radio" name="target" value="birthday" required checked/> 생일달</label> -->
					<label class="inline"> <input type="radio" value="birthday"
						name="target" required checked> 생일
					</label>
					<!-- <label class="radio"><input type="radio" name="target" value="new" required/> 신규가입</label> -->
					<label class="inline"> <input type="radio" value="new"
						name="target" required checked> 신규가입
					</label>
				</div>

				<!-- 발송 시간 설정 -->
				<div class="label req">발송 시간 설정</div>
				<div class="inline">
					<!-- <label class="radio"><input type="radio" name="sendType" value="now" checked/> 즉시</label> -->
					<label class="inline"> <input type="radio" value="now"
						name="sendType" required checked>즉시
					</label>
					<!-- <label class="radio"><input type="radio" name="sendType" value="reserve"/> 예약일 지정</label> -->
					<label class="inline"> <input type="radio" value="now"
						name="sendType" required checked>예약일 지정
					</label>

					<div id="reserveBox" class="reserve-box" aria-hidden="true">
						<input id="reserveDate" type="date" /> <input id="reserveTime"
							type="time" />
					</div>
				</div>

				<!-- 쿠폰 발급 여부 -->
				<div id="couponIssueLabel" class="label req" style="display: none">쿠폰
					발급 여부</div>
				<div id="couponIssueField" class="inline" style="display: none">
					<label class="inline"><input type="radio"
						name="couponIssue" value="Y" checked> 발급</label> <label
						class="inline"><input type="radio" name="couponIssue"
						value="N"> 미발급</label>
				</div>

				<!-- 쿠폰 설정 -->
				<div class="label">쿠폰 설정</div>
				<div>
					<div class="coupon-box" id="couponBox">
						<div class="grid"
							style="grid-template-columns: 140px 1fr; gap: 10px 12px">
							<div class="label req">쿠폰명</div>
							<div>
								<my:textInput id="couponName" name="couponName"
									placeholder="쿠폰명을 입력하세요." type="default" size="sm"
									state="default" />
							</div>

							<div class="label req">기간</div>
							<div class="inline date-row">
								<input id="couponFrom" class="date-start" type="date"> <span>~</span>
								<input id="couponTo" class="date-end" type="date">
							</div>

							<div class="label req">최소주문</div>
							<div class="inline">
								<div class="text-input-wrapper size--sm state--default">
									<div class="text-input-inner default">
										<input id="couponMin" type="number" min="0" step="100"
											placeholder="0" class="text-input"> <span
											class="muted">원 이상 구매 시</span>
									</div>
								</div>
							</div>

							<div class="label req">할인</div>
							<div class="inline">
								<div class="text-input-wrapper size--sm state--default">
									<div class="text-input-inner default">
										<input id="couponMin" type="number" min="0" step="100"
											placeholder="0" class="text-input"> <span
											class="muted">원 할인</span>
									</div>
								</div>
							</div>
						</div>
					</div>
					<p class="help">"발급" 선택 시 기재 바랍니다.</p>
				</div>

				<!-- 파일 업로드 -->
				<div class="label">파일 업로드</div>
				<div class="upload">
					<my:uploader size="lg" id="fileInput1" label="Click to upload"
						desc="또는 파일을 이 영역으로 드래그하세요" />
				</div>

				
				<div class="label">메일 발송 잔여량</div>
					<div class="quota">
						<div class="bar">
							<div id="quotaBar" class="fill" style="width: 55%"></div>
						</div>
						<div class="muted">
							<span id="quotaText">5,498 / 10,000</span>
						</div>
						<p class="help">남은 잔여 수 만큼 이메일을 발송할 수 있습니다.</p>
					</div>
			</div>
			<!-- grid end -->


			<div class="footer">
				<button type="button" class="btn btn-outline btn-sm" id="btnClose">닫기</button>
				<button type="button" class="btn btn-outline btn-sm" id="btnEx">example</button>
				<button type="submit" class="btn btn-outline btn-sm" id="btnSubmit">발송</button>
			</div>

		</my:brand2formLayout>
	</my:layout>

	<!-- Toast -->
	<div id="toast" class="toast" role="status" aria-live="polite"></div>

	<script src="./js/eventform.js"></script>
	<script>
      document.addEventListener("selectChanged", (e) => {
        console.log("선택된 값:", e.detail.value); // 실제 값
        console.log("선택된 텍스트:", e.detail.text); // 표시되는 텍스트
      });
    </script>

</body>
</html>