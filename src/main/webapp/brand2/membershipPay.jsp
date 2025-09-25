<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멤버십결제</title>
<link rel="stylesheet" href="./css/membershipPay.css" />

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
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
</head>
<body>
<my:layout>
	<my:breadcrumb items="멤버십 관리:/brand2/membership.jsp, 멤버십 결제:/brand2/membershipPay.jsp" />
	<div class="membershipPayContainer">
		<div class="notice">멤버십 가입 시 발송한 마케팅 메일과 메인 이벤트의 매출·클릭·구매 성과 지표를
			확인할 수 있으며, 요금제별 월 발송 건수가 지원됩니다.</div>

		<!-- 멤버십 플랜들 -->
		<label class="plan"> <input type="radio" name="plan"
			value="150000">
			<div class="plan-info">
				<div class="plan-title">10,000건 / 1개월</div>
				<div class="plan-price">
					150,000원 <small>VAT 포함</small>
				</div>
				<div class="plan-desc">스타트업이나 소규모 브랜드에 적합한 단기간 마케팅 메일 발송 가능</div>
			</div>
		</label> <label class="plan"> <input type="radio" name="plan"
			value="420000">
			<div class="plan-info">
				<div class="plan-title">30,000건 / 3개월</div>
				<div class="plan-price">
					420,000원 <small>VAT 포함</small>
				</div>
				<div class="plan-desc">안정적인 분기별 마케팅 운영 가능 주요 시즌 마케팅에 적합</div>
			</div>
		</label> <label class="plan"> <input type="radio" name="plan"
			value="780000">
			<div class="plan-info">
				<div class="plan-title">60,000건 / 6개월</div>
				<div class="plan-price">
					780,000원 <small>VAT 포함</small>
				</div>
				<div class="plan-desc">반년간 꾸준한 고객 관리 가능 장기적인 구독권 관리 전략에 적합</div>
			</div>
		</label> <label class="plan"> <input type="radio" name="plan"
			value="1440000">
			<div class="plan-info">
				<div class="plan-title">120,000건 / 12개월</div>
				<div class="plan-price">
					1,440,000원 <small>VAT 포함</small>
				</div>
				<div class="plan-desc">대기업 또는 대형 리테일 브랜드에 적합 1년 단위 장기 운영에 적합</div>
			</div>
		</label>

		<!-- 결제 버튼 -->
		<div class="pay-box">
			<button class="pay-button" id="payBtn" disabled>
				<img src="./images/TossPay_Logo_Primary.png" width="280px" alt="토스페이">
			</button>
			<br>

		</div>
	</div>

</my:layout>

<script>
window.addEventListener("DOMContentLoaded", () => {
    const payBtn = document.getElementById("payBtn");
    const radios = document.querySelectorAll("input[name='plan']");

    radios.forEach(radio => {
      radio.addEventListener("change", () => {
        payBtn.disabled = false;
      });
    });

    payBtn.addEventListener("click", () => {
      const selected = document.querySelector("input[name='plan']:checked");
      if (selected) {
        alert(`선택한 플랜 가격: ${selected.value}원\n토스페이 결제 진행`);
      } else {
        alert("플랜을 선택해주세요!");
      }
    });
  });
</script>

</body>
</html>