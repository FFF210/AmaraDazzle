//이벤트 등록 페이지로 이동
function goWriteEvet() {
	location.href = "promoEventWrite"
}

//배너 상세 페이지로 이동
function goEventDetail(num) {
	location.href = "promoEventDetail?num=" + num
}

document.addEventListener("DOMContentLoaded", function() {
	/* ************* 폼전송 + 유효성검사 ************* */
	const frm = document.getElementById("eventWriteForm");
	const submitBtn = document.getElementById("eventWriteBtn");
	const evtType = document.querySelector("#eventType");
	
	//toast editor 설정 
	const editor = new toastui.Editor({
		el: document.querySelector('#editContent'),
		height: '500px',
		initialEditType: 'wysiwyg',
	});

	//공란 채울 경우 빨강테두리 지움
	document.querySelectorAll("#eventWriteForm input").forEach(input => {
		input.addEventListener("input", function() {
			if (this.value.trim() != "") {
				this.classList.remove("state_error");
			}
		});
	});
	document.querySelectorAll(".select-item").forEach(select => {
		select.addEventListener("click", function(e) {
			const customSelect = e.currentTarget.closest(".custom-select")
			const hiddenSelect = customSelect.nextElementSibling;
			if (hiddenSelect && hiddenSelect.value.trim() !== "") {
				customSelect.classList.remove("state_error");
			}
		});
	});

	// ======== 확인 모달에서 "확인" 클릭 시 폼 전송되도록 미리 대기 ========
	document.addEventListener("dialogAction", function(e) {
		const { id, action } = e.detail;

		if (id === "submitCkDialog" && action === "전송") {
			const formData = new FormData(frm);
			formData.append("evtContent", editor.getHTML());

			fetch("/admin/promoEventWrite", {
				method: "POST",
				body: formData
			})
			.then(res => res.json())
			.then(data => {
				console.log(data);
				if (data.status == "ok") {
					// 오버레이 표시
					document.getElementById("overlay").classList.add("active");

					//등록 성공 알럿 표시
					showAlert("success", data.title, data.message); // 2초간 토스트

					setTimeout(() => {
						location.href = "/admin/promoBannerList"; // 리스트로 이동
					}, 3000);


				} else if (data.status == "fail") {
					showAlert("error", data.title, data.message); // 2초간 토스트
				}
			})
			.catch(err => console.log(err));
		}
	});

	//필수입력 유효성 검사 
	submitBtn.addEventListener("click", () => {
		const eventImg = document.querySelector('input[name="eventImg"]');
//		const uploader = document.querySelector("#fileDropper");

		//이벤트종류
		if (frm.eventType.value.trim() == "") {
			showAlert("error", " ", "이벤트 종류를 선택하세요.");
			evtType.classList.add("state_error");
			evtType.focus();
			return;
		}

		//진행기간
		if (frm.startDate.value.trim() === "") {
			showAlert("error", " ", "이벤트 진행기간 시작일을 입력하세요.");
//			frm.startDate.classList.add("state_error");
			frm.startDate.focus();
			return;
		}
		if (frm.endDate.value.trim() === "") {
			showAlert("error", " ", "이벤트 진행기간 마지막일을 입력하세요.");
//			frm.endDate.classList.add("state_error");
			frm.endDate.focus();
			return;
		}

		//이벤트명
		if (frm.eventName.value.trim() === "") {
			showAlert("error", " ", "이벤트명을 입력하세요.");
			frm.eventName.classList.add("state_error");
			frm.eventName.focus();
			return;
		}
		if (frm.eventName.value.length > 100) {
			showAlert("error", " ", "이벤트명은 100자까지만 쓸 수 있습니다.");
			frm.eventName.classList.add("state_error");
			frm.eventName.focus();
			return;
		}

		//파일첨부 시

		//내용
		if (editor.getMarkdown() == "") {
			showAlert("error", " ", "내용을 입력해주세요.");
			editor.focus();
			return;
		}
		if (editor.getMarkdown().length < 10) {
			showAlert("error", " ", "내용은 10자 이상 입력해야 합니다.");
			editor.focus();
			return;
		}

		// 유효성 통과 -> 모달 열기
		openDialog("submitCkDialog");
	});




});