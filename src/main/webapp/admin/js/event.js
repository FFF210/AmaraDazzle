//이벤트 등록 페이지로 이동
function goWriteEvet() {
	location.href = "promoEventWrite"
}

//이벤트 상세 페이지로 이동
function goEventDetail(num) {
	console.log(num)
	location.href = "promoEventDetail?num=" + num
}

function exposeState(num, type){
	fetch(`/admin/exposeChange?num=${num}&type=${type}`, {
		method: "POST"
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
				location.reload(); //현재 페이지 새로고침
			}, 3000);


		} else if (data.status == "partial") {
			showAlert("error", data.title, data.message); // 2초간 토스트
		}
	})
	.catch(err => {
		console.error(err);
		showAlert("error", "삭제 실패", "서버 통신 중 오류가 발생했습니다.");
	});
}

document.addEventListener("DOMContentLoaded", function() {
	const thumbInput = document.getElementById("eventThumbImg");
	const mainImgInput = document.getElementById("fileInput");
	const previewBtn = document.getElementById("eventPreviewBtn");	
	const imgBtn = document.querySelector("#wrapper-eventThumbImg");//이미지 담는 div
	const uploader = document.querySelector("#fileDropper");	//이미지 담는 div
	
	previewBtn.addEventListener("click", () => {
		console.log("미리보기 버튼 클릭!!")
		
	  	const thumbFile = thumbInput.files[0];
	  	const mainFile = mainImgInput.files[0];
		const eventTypeInput = document.querySelector("#eventType .select-item.active");
		const titleInput = document.getElementById("eventName").value.trim();
		const startInput = document.querySelector(".input-wrapper .start_date").value.trim();
		const endInput = document.querySelector(".input-wrapper .end_date").value.trim();
		const cateInput1 = document.querySelector("#largeSelect .select-item.active").dataset.value.trim();
		const cateInput2 = document.querySelector("#middleSelect .select-item.active").dataset.value.trim();
		const cateInput3 = document.querySelector("#smallSelect .select-item.active").dataset.value.trim();
		const eventTypeValue = eventTypeInput?.dataset.value?.trim() || "";
		const cate1Value = cateInput1?.dataset.value?.trim() || "";
		const cate2Value = cateInput2?.dataset.value?.trim() || "";
		const cate3Value = cateInput3?.dataset.value?.trim() || "";
		
		if (!thumbFile && !mainFile) {
			showAlert("error", " ", "미리보기시 이미지는 필수로 첨부해야 합니다.");
			imgBtn.classList.add("state_error");
			uploader.classList.add("state_error");
			return;
		}

	  const thumbUrl = URL.createObjectURL(thumbFile);
	  const mainUrl = URL.createObjectURL(mainFile);
	  const previewWindow = window.open("", "_blank");
	  previewWindow.document.write(`
	    <html>
	      <head>
	        <title>이벤트 화면 미리보기</title>
			<link rel="stylesheet" href="./css/boards_detailview.css">
			<link rel="stylesheet" href="./css/event.css">
			<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" />
	        <style>
	          
	        </style>
	      </head>
	      <body>
		  	<section class="board_detailview">
			  	<div class="titlePart">
					<div class="thumbImgPart">
						<img src="${thumbUrl}" class="eventThumbImg">
					</div>
					<div class="contentPart">
						<h1 class="preview-title">${titleInput}</h1>
						<p><i class="bi bi-dot"></i>카테고리 : ${eventTypeValue}</p>
						<p><i class="bi bi-dot"></i>진행기간 : ${startInput} ~ ${endInput}</p>
					</div>
				</div>
				<hr />
				<div class="mainContentPart">
					<div class="mainImgPart">
						<img src="${mainUrl}" class="eventMainImg">
					</div>
				</div>
			</section>
	        
	      </body>
	    </html>
	  `);
	});
	
	
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
						location.href = "/admin/promoEventList"; // 리스트로 이동
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
		const thumbFile = thumbInput.files[0];
	  	const mainFile = mainImgInput.files[0];

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
		if (!thumbFile && !mainFile) {
			showAlert("error", " ", "미리보기시 이미지는 필수로 첨부해야 합니다.");
			imgBtn.classList.add("state_error");
			uploader.classList.add("state_error");
			return;
		}

		//내용
//		if (editor.getMarkdown() == "") {
//			showAlert("error", " ", "내용을 입력해주세요.");
//			editor.focus();
//			return;
//		}
//		if (editor.getMarkdown().length < 10) {
//			showAlert("error", " ", "내용은 10자 이상 입력해야 합니다.");
//			editor.focus();
//			return;
//		}

		// 유효성 통과 -> 모달 열기
		openDialog("submitCkDialog");
	});




});