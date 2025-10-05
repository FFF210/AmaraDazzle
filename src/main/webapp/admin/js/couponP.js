//쿠폰 발행 버튼 클릭시 발행 페이지로 이동 
function cpPublBtn() {
	location.href = "/admin/pCouponWrite";
};

document.addEventListener("DOMContentLoaded", function() {
	/* ************* 입력시 3자리마다 콤마 추가 ************* */ 
	const priceInputs = document.querySelectorAll(".price_input");
	const numReg = /^[0-9,]+$/;

	priceInputs.forEach(pi => {
		pi.addEventListener("input", (e) => {
			let value = e.target.value.replace(/,/g, "");
			
			//숫자와 ,외 다른 문자 입력시 에러알럿 
			if(!numReg.test(value) && value !== ""){
				e.target.classList.add("state_error");
				showAlert("error", " ", "숫자만 입력해주세요.");
				return;
			}
			
			if (!isNaN(value) && value !== "" && numReg.test(value)) {
				e.target.classList.remove("state_error");
				e.target.value = Number(value).toLocaleString();
			}
		});
	});

	
	/* ************* 등급 버튼 클릭 ************* */
	const middleBox = document.querySelector(".answer_body.filter-btn-group");
	if (middleBox) {
		const middleBtns = document.querySelectorAll(".filter-btn");
		const hiddenMiddle = document.querySelector("#cpTarget");
		
		// 처음엔 '전체' 버튼 활성화
		middleBtns[0].classList.add("active");
		hiddenMiddle.value = middleBtns[0].value;
		
		middleBtns.forEach((btn) => {
			btn.addEventListener("click", () => {
				middleBtns.forEach((b) => b.classList.remove("active")); // 모두 제거
				btn.classList.add("active"); // 클릭한 것만 적용
				hiddenMiddle.value = btn.value;
			});
		});
	}

	/* ************* 폼전손 + 유효성검사 ************* */
	const frm = document.getElementById("pCouponForm");
	const submitBtn = document.getElementById("pCouponBtn");
	const couponCondition = document.getElementById("couponCondition");
	const couponQuantity = document.getElementById("couponQuantity");
	const pch_noRestr = document.getElementById("pch_noRestr");
	const qnt_noRestr = document.getElementById("qnt_noRestr");
	
	// 제한없음 클릭 시 입력칸 비활성화 (사용조건)
	pch_noRestr.addEventListener("change", () => {
		if (pch_noRestr.checked) {
			couponCondition.disabled = true;
			couponCondition.value = "";
			couponCondition.classList.remove("state_error");
		} else {
			couponCondition.disabled = false;
		}
	});
	// 제한없음 클릭 시 입력칸 비활성화 (발급수량)
	qnt_noRestr.addEventListener("change", () => {
		if (qnt_noRestr.checked) {
			couponQuantity.disabled = true;
			couponQuantity.value = "";
			couponQuantity.classList.remove("state_error");
		} else {
			couponQuantity.disabled = false;
		}
	});

	//공란 채울 경우 빨강테두리 지움
	document.querySelectorAll("#pCouponForm input").forEach(input => {
		input.addEventListener("input", function() {
			if (this.value.trim() != "") {
				this.classList.remove("state_error");
			}
		});
	});
	
	// ======== 확인 모달에서 "확인" 클릭 시 폼 전송 ========
	document.addEventListener("dialogAction", function(e) {
		const { id, action } = e.detail;
		

		// 폼 전송 모달일 때만 처리
		if (id === "submitCkDialog" && action === "전송") {

			//submit 직전에 모든 .price_input의 콤마 제거
			priceInputs.forEach(pi => {
				pi.value = pi.value.replace(/,/g, "");
			});
			
//			frm.method="POST"
//			frm.submit();.
//			const frm = document.getElementById("pCouponForm");
			const formData = new FormData(frm);
			
			fetch("/admin/pCouponWrite", {
			  method: "POST",
			  body: formData
			})
			.then(res => res.json()) 
			.then(data => {
			  console.log(data);
			})
			.catch(err => console.error(err));
			
		}
	});
	
	submitBtn.addEventListener("click", () => {
		//쿠폰명
		if (frm.couponName.value.trim() == "") {
			showAlert("error", " ", "쿠폰명을 입력하세요.");
			frm.couponName.classList.add("state_error"); 	//테두리 빨강으로 변경
			frm.couponName.focus();
			return;
		}

		//쿠폰금액
		if (frm.couponAmount.value.trim() == "") {
			showAlert("error", " ", "쿠폰 금액을 입력하세요.");
			frm.couponAmount.classList.add("state_error");
			frm.couponAmount.focus();
			return;
		}
		//숫자와 ,외 다른 문자 입력시 에러알럿 
		if(!numReg.test(frm.couponAmount.value.trim()) && frm.couponAmount.value.trim() !== ""){
			frm.couponAmount.classList.add("state_error");
			showAlert("error", " ", "숫자만 입력해주세요.");
			return;
		}
		
		//유효기간
		if (frm.startDate.value.trim() === "") {
			showAlert("error", " ", "쿠폰의 유효기간을 입력하세요.");
			frm.startDate.classList.add("state_error");
			frm.startDate.classList.add("state_error");
			frm.startDate.focus();
			return;
		}
		if (frm.endDate.value.trim() === "") {
			showAlert("error", " ", "쿠폰의 유효기간을 입력하세요.");
			frm.endDate.classList.add("state_error");
			frm.endDate.focus();
			return;
		}
		

		//사용조건
		//입력값이 없고, 제한없음도 안 눌렀을 때
		if (couponCondition.value.trim() === "" && !pch_noRestr.checked) {
			showAlert("error", " ", "쿠폰의 사용조건을 입력하세요.");
			couponCondition.classList.add("state_error");
			couponCondition.focus();
			return;
		}
		if(!numReg.test(couponQuantity.value.trim()) && couponQuantity.value.trim() !== ""){
			showAlert("error", " ", "숫자만 입력해주세요.");
			couponQuantity.classList.add("state_error");
			return;
		}
				
		//발행사유
		if (frm.couponReason.value.trim() == "") {
			showAlert("error", " ", "쿠폰의 지급사유를 입력하세요.");
			frm.couponReason.classList.add("state_error");
			frm.couponReason.focus();
			return;
		}
		
		//발급수량
		if (couponQuantity.value.trim() === "" && !qnt_noRestr.checked) {
			showAlert("error", " ", "쿠폰의 발급수량을 입력하세요.");
			couponQuantity.classList.add("state_error");
			couponQuantity.focus();
			return;
		}
		if(!numReg.test(couponQuantity.value.trim()) && couponQuantity.value.trim() !== ""){
			showAlert("error", " ", "숫자만 입력해주세요.");
			couponQuantity.classList.add("state_error");
			return;
		}
		
		// 유효성 통과 → 모달 열기
		openDialog("submitCkDialog");
		
		
	});
});


