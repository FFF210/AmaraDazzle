<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

<!-- 토스페이먼츠 결제위젯 SDK -->
<script src="https://js.tosspayments.com/v2/standard"></script>
</head>
<body>
	<my:layout>

		<my:breadcrumb
			items="배너광고 관리:/brand2/adbannerList.jsp, 배너광고 신청:/brand2/adbannerForm.jsp" />
		<my:brand2formLayout title="배너광고 신청" formId="eventForm">

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
					<input id="startDate" class="startDate" type="date"> <span>~</span>
					<input id="endDate" class="endDate" type="date">
				</div>

				<div class="label">관리자 전달사항</div>
				<div>
					<my:textArea id="bannerMessage" name="bannerMessage"
						placeholder="관리자에게 문의&참고할 사항 전달" />
				</div>
				<div class="label">파일 업로드</div>
				<div class="upload">
					<my:uploader size="lg" id="uploadFileId" label="Click to upload" multiple="false"
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
					<%-- <button class="pay-button" id="payBtn" disabled>
						<img src="${pageContext.request.contextPath}/brand2/images/TossPay_Logo_Primary.png" width="280px"
							alt="토스페이결제하기">
					</button> --%>

					<!-- 결제 UI -->
					<div id="payment-method"></div>
					<!-- 이용약관 UI -->
					<div id="agreement"></div>
					<!-- 결제하기 버튼 -->
					<button class="button" id="payment-button" style="margin-top: 30px">결제하기</button>

				</div>
			</div>
		</my:brand2formLayout>
	</my:layout>


	<!-- Toast -->
	<div id="toast" class="toast" role="status" aria-live="polite"></div>

	<script>
	main();
	async function main() {
        const button = document.getElementById("payment-button");
        const coupon = document.getElementById("coupon-box");
        // ------  결제위젯 초기화 ------
        const clientKey = "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm";
        const tossPayments = TossPayments(clientKey);
        // 회원 결제
        const customerKey = "RgyFwnE6adH-nqMZLcsyN";
        const widgets = tossPayments.widgets({
          customerKey,
        });
     // ------ 주문의 결제 금액 설정 ------
        await widgets.setAmount({
          currency: "KRW",
          value: 50000,
        });

        await Promise.all([
          // ------  결제 UI 렌더링 ------
          widgets.renderPaymentMethods({
            selector: "#payment-method",
            variantKey: "DEFAULT",
          }),
          // ------  이용약관 UI 렌더링 ------
          widgets.renderAgreement({ selector: "#agreement", variantKey: "AGREEMENT" }),
        ]);

        // ------  주문서의 결제 금액이 변경되었을 경우 결제 금액 업데이트 ------
        coupon.addEventListener("change", async function () {
          if (coupon.checked) {
            await widgets.setAmount({
              currency: "KRW",
              value: 50000 - 5000,
            });

            return;
          }

          await widgets.setAmount({
            currency: "KRW",
            value: 50000,
          });
        });

        // ------ '결제하기' 버튼 누르면 결제창 띄우기 ------
        button.addEventListener("click", async function () {
        	event.preventDefault(); // 기본 submit 막기
        	const form = decument.getElementById();
        	
          await widgets.requestPayment({
            orderId: "f1y9Agw17SQJE-civPqXp",
            orderName: "토스 티셔츠 외 2건",
            successUrl: window.location.origin + "/success.html",
            failUrl: window.location.origin + "/fail.html",
            customerEmail: "customer123@gmail.com",
            customerName: "김토스",
            customerMobilePhone: "01012341234",
          });
        });
      }
    </script>
</body>
</html>