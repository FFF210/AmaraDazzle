//쿠폰 발행 함수 
document.addEventListener("DOMContentLoaded", function() {
	/* ************* 입력시 3자리마다 콤마 추가 ************* */
	const priceInputs = document.querySelectorAll(".price_input");
	const numReg = /^[0-9,]+$/;

	priceInputs.forEach(pi => {
		pi.addEventListener("input", (e) => {
			let value = e.target.value.replace(/,/g, "");

			//숫자와 ,외 다른 문자 입력시 에러알럿 
			if (!numReg.test(value) && value !== "") {
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

				if (btn.textContent.trim() === "개별회원") {  //개별회원 버튼을 클릭했을 때 즉시지급 버튼 숨김 
					document.querySelector("#immedBtn").style.display = "none";
				} else {
					document.querySelector("#immedBtn").style.display = "block";
				}
			});
		});
	}

	/* ************* 폼전송 + 유효성검사 ************* */
	const frm = document.getElementById("pCouponForm");
	const submitBtn = document.getElementById("pCouponBtn");
	const couponCondition = document.getElementById("couponCondition");
	const couponExp = document.querySelectorAll(".date-input");
	const largeSelect = document.getElementById("largeSelect");
	const middleSelect = document.getElementById("middleSelect");
	const smallSelect = document.getElementById("smallSelect");
	const pch_noRestr = document.getElementById("pch_noRestr");
	const exp_noRestr = document.getElementById("exp_noRestr");
	const cate_noRestr = document.getElementById("cate_noRestr");
	const birth_coupon = document.getElementById("birth_coupon");
	
	// 범위로 설정 클릭 시 입력칸 비활성화, 아래 입력칸 노출 (유효기간)
	exp_noRestr.addEventListener("change", () => {
		const isChecked = exp_noRestr.checked;

		couponExp.forEach((exp) => {
			exp.classList.toggle("disabled", isChecked);

			// 범위로 설정 체크 시
			if (isChecked) {
				//날짜표시칸 내용 지움 
				exp.querySelectorAll(".date-text").forEach(dt => {
					dt.value = "";
				});

				// 활성화된 항목 표시(active) 제거 
				exp.querySelectorAll(".preset-btn.active").forEach(item => {
					item.classList.remove("active");
				});
			}
		});

		//아래 입력칸 노출
		document.querySelector(".part_content.couponExp2").classList.toggle("visible", isChecked);
	});
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
	// 제한없음 클릭 시 입력칸 비활성화 (카테고리)
	const categorySelects = [largeSelect, middleSelect, smallSelect];
	const categoryInputs = [
		document.getElementById("category1Id"),
		document.getElementById("category2Id"),
		document.getElementById("category3Id")
	];
	const categoryInitials = ["대분류", "중분류", "소분류"];

	cate_noRestr.addEventListener("change", () => {
		const isChecked = cate_noRestr.checked;

		categorySelects.forEach((select, i) => {
			select.classList.toggle("disabled", isChecked);
			select.classList.remove("state_error");

			// 제한없음 체크 시
			if (isChecked) {
				categoryInputs[i].value = "";
				// 화면 표시 텍스트를 초기값으로 복원
				const label = select.querySelector(".select-label");
				if (label) label.textContent = categoryInitials[i];

				// 활성화된 항목 표시 제거 (active 클래스 초기화)
				select.querySelectorAll(".select-item.active").forEach(item => {
					item.classList.remove("active");
				});
			}
		});
	});


	//생일쿠폰 체크시 지급사유 자동 세팅
	birth_coupon.addEventListener("change", () => {
		const isChecked = birth_coupon.checked;
		// 생일쿠폰 체크 시
		if (isChecked) {
			frm.couponReason.value = birth_coupon.value+" 발행";
			frm.couponReason.readOnly = true;

		} else {
			frm.couponReason.value = "";
			frm.couponReason.readOnly = false;
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
	document.querySelector("#pCouponForm").addEventListener("click", function(e) {
		const selectItem = e.target.closest(".select-item");
		if (!selectItem) return; // 리스트 항목(.select-item)이 아니면 종료

		const customSelect = selectItem.closest(".custom-select");
		const hiddenInput = customSelect.nextElementSibling;

		// hidden input이 존재하고 값이 비어 있지 않다면 에러 클래스 제거
		if (hiddenInput && hiddenInput.value.trim() !== "") {
			customSelect.classList.remove("state_error");
		}
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
			const formData = new FormData(frm);

			fetch("/admin/couponPublWrite", {
				method: "POST",
				body: formData
			})
				.then(res => res.json())
				.then(data => {
					console.log(data);
					if (data.status == "ok") {
						// 오버레이 표시
						document.getElementById("overlay").classList.add("active");

						//로그인 성공 알럿 표시
						showAlert("success", data.title, data.message); // 2초간 토스트

						setTimeout(() => {
							location.href = "/admin/couponPublList"; // 리스트로 이동
						}, 3000);


					} else if (data.status == "fail") {
						showAlert("error", data.title, data.message); // 2초간 토스트
					}
				})
				.catch(err => console.log(err));

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
		if (!numReg.test(frm.couponAmount.value.trim()) && frm.couponAmount.value.trim() !== "") {
			frm.couponAmount.classList.add("state_error");
			showAlert("error", " ", "숫자만 입력해주세요.");
			return;
		}

		//유효기간
		if (frm.startDate.value.trim() === "" && !exp_noRestr.checked) {
			showAlert("error", " ", "쿠폰의 유효기간을 입력하세요.");
			//			frm.startDate.classList.add("state_error");
			frm.startDate.focus();
			return;
		}
		if (frm.endDate.value.trim() === "" && !exp_noRestr.checked) {
			showAlert("error", " ", "쿠폰의 유효기간을 입력하세요.");
			//			frm.endDate.classList.add("state_error");
			frm.endDate.focus();
			return;
		}

		//카테고리
		//입력값이 없고, 제한없음을 안 눌렀을 때
		if (document.getElementById("category1Id").value.trim() === "" && !cate_noRestr.checked) {
			showAlert("error", " ", "쿠폰을 적용할 카테고리의 대분류를 선택하세요.");
			largeSelect.classList.add("state_error");
			largeSelect.focus();
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
		if (!numReg.test(couponCondition.value.trim()) && couponCondition.value.trim() !== "") {
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

		// 유효성 통과 → 모달 열기
		openDialog("submitCkDialog");


	});
});


