<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>광고배너 신청</title>

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
			items="배너광고 관리:/brand2/adbannerList.jsp, 배너광고 신청:/brand2/adbannerForm.jsp" />
		<my:brand2formLayout title="배너광고 신청" formId="eventForm">

			<div class="grid">
				<div class="label req">배너 광고명</div>
				<div>
					<my:textInput id="ownerName" name="ownerName"
						placeholder="광고명을 입력하세요." type="default" size="sm" state="default" />
				</div>
				<div class="label req">광고 담당자</div>
				<div>
					<my:textInput id="ownerName" name="ownerName"
						placeholder="담당자 성함을 입력하세요." type="default" size="sm"
						state="default" />
				</div>

				<div class="label req">담당 연락처</div>
				<div>
					<my:textInput id="ownerTel" name="ownerTel"
						placeholder="담당연락처를 입력하세요." type="default" size="sm"
						state="default" />
				</div>

				<div class="label req">배너 등록 기간</div>
				<div class="inline date-row">
					<input id="couponFrom" class="date-start" type="date"> <span>~</span>
					<input id="couponTo" class="date-end" type="date">
				</div>

				<div class="label">관리자 전달사항</div>
				<div>
					<my:textArea id="note" name="desc" placeholder="관리자에게 문의&참고할 사항 전달" />
				</div>
				<div class="label">파일 업로드</div>
				<div class="upload">
					<my:uploader size="lg" id="fileInput1" label="Click to upload"
						desc="또는 파일을 이 영역으로 드래그하세요" />
				</div>
			</div>

			<div class="footer">
				<div class="pay-box">
					<div class="summary">
						<span>총 <strong id="dayCount">0</strong>일
						</span> <span>1일 ₩140,000</span> <span>예상 결제 금액 <strong
							id="totalPrice" class="highlight">₩0</strong></span>
					</div>
					<button class="pay-button" id="payBtn" disabled>
						<img src="./images/TossPay_Logo_Primary.png" width="280px"
							alt="토스페이">
					</button>
				</div>
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