<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://js.tosspayments.com/v1/payment"></script>
</head>
<body>
	<my:layout>
		<my:breadcrumb
			items="멤버십 관리:/brand2/membership.jsp, 멤버십 결제:/brand2/membershipPay.jsp" />
		<div class="membershipPayContainer">
			<div class="notice">멤버십 가입 시 발송한 마케팅 메일과 메인 이벤트의 매출·클릭·구매 성과
				지표를 확인할 수 있으며, 요금제별 월 발송 건수가 지원됩니다.</div>

			<!-- 멤버십 플랜 반복 출력 -->
			<c:forEach var="plan" items="${plans}">
				<label class="plan"> <input type="radio" name="plan"
					value="${plan.amount}">
					<div class="plan-info">
						<div class="plan-title">
							<!-- 플랜명: 기간 기준으로 표시 -->
							<c:choose>
								<c:when test="${plan.membershipPlanId eq 'PLAN_AUTO'}">
								매월(정기결제)
							</c:when>
								<c:otherwise>
								${plan.planPeriod}개월 이용권
							</c:otherwise>
							</c:choose>
						</div>
						<div class="plan-price">
							<fmt:formatNumber value="${plan.amount}" type="number" />
							원 <small>VAT 포함</small>
						</div>
						<div class="plan-desc">${plan.membershipExplain}</div>
					</div>
				</label>
			</c:forEach>

			<!-- 결제 버튼 -->
			<div class="pay-box">
				<button class="pay-button" id="payBtn" disabled>
					<img src="./images/TossPay_Logo_Primary.png" width="280px"
						alt="토스페이">
				</button>
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
		    if (!selected) {
		      alert("플랜을 선택해주세요!");
		      return;
		    }
		    

		 	// 선택된 라디오의 부모 label 안에서 .plan-title 요소 찾기
		    const planTitle = selected.closest("label").querySelector(".plan-title").innerText;
		    
		    // ------ 클라이언트 키로 객체 초기화 ------
		    const clientKey = "test_ck_XZYkKL4Mrj9eGzWBRNORV0zJwlEW"; 
		    const tossPayments = TossPayments(clientKey);

		    // ------ 결제창 띄우기 ------
		    tossPayments
		      .requestPayment("카드", {
		        amount: parseInt(selected.value, 10),  // ✅ 선택된 플랜 금액 반영
		        orderId: "ORDER-" + new Date().getTime(), // ✅ 주문번호 (유니크하게 생성)
		        orderName: planTitle,   // ✅ plan-title 값 반영
		        customerName: "테스트사용자", 
		        successUrl: "http://localhost:8080/tossSuccess", 
		        failUrl: "http://localhost:8080/tossFail"
		      })
		      .catch(function (error) {
		        if (error.code === "USER_CANCEL") {
		          alert("결제가 취소되었습니다.");
		        } else {
		          alert("결제 처리 중 오류가 발생했습니다. (" + error.code + ")");
		        }
		      });
		  });
		});

  
  
</script>

</body>
</html>