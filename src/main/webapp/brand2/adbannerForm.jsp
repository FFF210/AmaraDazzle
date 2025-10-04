<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>광고배너 신청</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/brand2/css/formLayout.css" />

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

.pay-box {
	display: flex;
	flex-direction: column;
	align-items: center; /* 가운데 정렬 */
	gap: 10px;
	margin-top: 20px;
}

.summary {
	display: flex;
	flex-direction: column;
	align-items: center;
	gap: 4px;
	font-size: 14px;
	line-height: 1.4;
	color: #555;
}

.summary span {
	display: block;
}

.summary strong {
	font-weight: 600;
	color: #111;
}

.summary .highlight {
	font-size: 15px;
	font-weight: 700;
	color: #1976d2; /* 결제 금액만 포인트 */
}

.toss-logo {
	height: 136px;
	/* 원하는 높이 지정 */
	width: auto;
	/* 비율 유지 */
	border-radius: 16px;
	border: 1.5px solid #DADADA;
	background: #FFF;
}
</style>

<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
</head>
<body>
	<my:layout>

		<my:breadcrumb
			items="배너광고 관리:/brand2/adbannerList, 배너광고 신청:/brand2/adbannerForm" />
		<my:brand2formLayout title="배너광고 신청" formId="eventForm"
			action="/brand2/adbanner" method="post" enctype="multipart/form-data">

			<div class="grid">
				<div class="label req">배너 광고명</div>
				<div>
					<my:textInput id="bannerName" name="bannerName"
						placeholder="광고명을 입력하세요." type="default" size="sm" state="default" />
				</div>
				<div class="label req">광고 담당자</div>
				<div>
					<my:textInput id="managerName" name="managerName"
						placeholder="담당자 성함을 입력하세요." type="default" size="sm"
						state="default" />
				</div>

				<div class="label req">담당 연락처</div>
				<div>
					<my:textInput id="managerTel" name="managerTel"
						placeholder="담당연락처를 입력하세요." type="default" size="sm"
						state="default" />
				</div>

				<div class="label req">배너 등록 기간</div>
				<div class="inline date-row">
					<input id="startDate" class="startDate" name="startDate"
						type="date"> <span>~</span> <input id="endDate"
						class="endDate" name="endDate" type="date">
				</div>

				<div class="label">관리자 전달사항</div>
				<div>
					<my:textArea id="bannerMessage" name="bannerMessage"
						placeholder="관리자에게 문의&참고할 사항 전달" />
				</div>
				<div class="label">파일 업로드</div>
				<div class="upload">

					<my:uploader size="lg" id="uploadFileName" name="uploadFileName"
						label="Click to upload" desc="또는 파일을 이 영역으로 드래그하세요"
						multiple="false" />
				</div>
			</div>

			<div class="footer">
				<div class="pay-box">
					<div class="summary">
						<span>총 <strong id="dayCount">0</strong>일
						</span> <span>1일 ₩140,000</span> <span>예상 결제 금액 <strong
							id="totalPrice" class="highlight">₩0</strong></span>
					</div>
					<div class="actions">
						<button type="button" class="btn btn-outline btn-sm" id="btnClose"
							onclick="location.href='/brand2/adbannerList.jsp'">닫기</button>
						<button type="submit" class="btn btn-outline btn-sm" id="payBtn">신청하기</button>
					</div>
				</div>
			</div>
		</my:brand2formLayout>
	</my:layout>

	<script>
		
	<%-- 예상 금액 --%>
		document.addEventListener("DOMContentLoaded",
				function() {
					const startInput = document.getElementById("startDate");
					const endInput = document.getElementById("endDate");
					const dayCountEl = document.getElementById("dayCount");
					const totalPriceEl = document.getElementById("totalPrice");

					let currentDayCount = 0;
					let currentTotalPrice = 0;

					function updateDayCount() {
						const startDate = new Date(startInput.value);
						const endDate = new Date(endInput.value);

						if (startInput.value && endInput.value
								&& endDate >= startDate) {
							const diffTime = endDate - startDate;
							const diffDays = Math.floor(diffTime
									/ (1000 * 60 * 60 * 24)) + 1;
							currentDayCount = diffDays;
							currentTotalPrice = diffDays * 140000;

							dayCountEl.innerText = diffDays;
							totalPriceEl.innerText = "₩"
									+ currentTotalPrice.toLocaleString();
						} else {
							currentDayCount = 0;
							currentTotalPrice = 0;
							dayCountEl.innerText = 0;
							totalPriceEl.innerText = "₩0";
						}
					}

					startInput.addEventListener("change", updateDayCount);
					endInput.addEventListener("change", updateDayCount);

				});
	<%-- 예상 금액 --%>
		
	<%-- toss js --%>
		
	<%--
//------ 클라이언트 키로 객체 초기화 ------
var clientKey = "test_ck_XZYkKL4Mrj9eGzWBRNORV0zJwlEW";
var tossPayments = TossPayments(clientKey);

//------ 결제창 띄우기 ------
//------ 버튼 클릭 시 결제창 띄우기 ------
document.addEventListener("DOMContentLoaded", function() {
	var button = document.getElementById("payBtn");

	button.addEventListener("click", function() {
		tossPayments
			.requestPayment("카드", {
				// 결제수단 파라미터 (카드, 계좌이체, 가상계좌, 휴대폰 등)
				// 결제 정보 파라미터
				// 더 많은 결제 정보 파라미터는 결제창 Javascript SDK에서 확인하세요.
				// https://docs.tosspayments.com/sdk/payment-js
				amount: 1, // 결제 금액
				orderId: "ORDER-" + new Date().getTime(), // 주문번호(주문번호는 상점에서 직접 만들어주세요.)
				orderName: "테스트 결제", // 구매상품 (생수 외 1건) 같은 형식
				customerName: "김토스", // 구매자 이름
				successUrl: "http://localhost:8080/tossSuccess", // 결제 성공 시 이동할 페이지(이 주소는 예시입니다. 상점에서 직접 만들어주세요.)
				failUrl: "http://localhost:8080/tossFail", // 결제 실패 시 이동할 페이지(이 주소는 예시입니다. 상점에서 직접 만들어주세요.)
			})
		// ------결제창을 띄울 수 없는 에러 처리 ------
		// 메서드 실행에 실패해서 reject 된 에러를 처리하는 블록입니다.
		// 결제창에서 발생할 수 있는 에러를 확인하세요.
		// https://docs.tosspayments.com/reference/error-codes#결제창공통-sdk-에러
		.catch(function(error) {
			if (error.code === "USER_CANCEL") {
				// 구매자가 결제창을 닫았을 때 에러 처리
				alert("결제 처리가 취소되었습니다")
			} else if (error.code === "INVALID_CARD_COMPANY") {
				// 유효하지 않은 카드 코드에 대한 에러 처리
				alert("결제 처리 중 오류가 발생했습니다")
			}
		});
	});
});
--%>
		
	<%-- toss js --%>
		
	</script>

</body>

</html>