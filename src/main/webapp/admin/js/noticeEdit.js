//공지 수정 버튼 클릭
document.addEventListener("DOMContentLoaded", function() {
	
	//toast editor 설정 
	const editor = new toastui.Editor({
		el: document.querySelector('#editContent'),
		height: '500px',
		initialEditType: 'wysiwyg',
	});
	
	/* ************* 폼전송 + 유효성검사 ************* */
	const frm = document.getElementById("noticeEditForm");
	const editBtn = document.getElementById("noticeEditBtn");
	
	//공란 채울 경우 빨강테두리 지움
	document.querySelectorAll("#noticeEditForm input").forEach(input => {
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
			formData.append("content", editor.getHTML());		

			fetch("/admin/noticeSellerEdit", {
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
						location.href="noticeSellerDetail?num="+data.id; // 상세보기로 이동
					}, 3000);


				} else if (data.status == "fail") {
					showAlert("error", data.title, data.message); // 2초간 토스트
				}
			})
			.catch(err => console.log(err));
		}
	});
	
	//필수입력 유효성 검사 
	editBtn.addEventListener("click", () => {
		const noticeImg = document.querySelector('input[name="noticeFile"]');
		const uploader = document.querySelector("#fileDropper");
		
		//카테고리
		if (frm.noticeCate.value.trim() === "") {
			showAlert("error", " ", "공지 카테고리를 선택하세요.");
			document.querySelector("#noticeCate").classList.add("state_error");
			document.querySelector("#noticeCate").focus();
			return;
		}
		
		//제목
		if (frm.noticeTitle.value == "") {
			showAlert("error", " ", "공지 제목을 입력하세요.");
			frm.noticeTitle.classList.add("state_error");
			frm.noticeTitle.focus();
			return;
		}
		if (frm.noticeTitle.value.length > 150) {
			showAlert("error", " ", "제목은 150자까지만 쓸 수 있습니다.");
			frm.noticeTitle.classList.add("state_error");
			frm.noticeTitle.focus();
			return;
		}
	
		//내용
		if (editor.getMarkdown() == "") {
			showAlert("error", " ", "내용을 입력해주세요.");
			editor.focus();
			return;
		}
		
		//파일첨부
		if (noticeImg && noticeImg.files.length > 0) {
			const maxSize = 10 * 1024 * 1024; // 10MB 제한
			let overSize = false;

			//첨부된 파일 순회하며 사이즈 확인 
			for (const file of noticeImg.files) {
				if (file.size > maxSize) {
					overSize = true;
					break;
				}
			}

			if (overSize) { //파일 1개라도 10MB를 넘을경우 
				showAlert("error", "", "파일첨부 용량은 10MB 이하만 가능합니다.");
				uploader.classList.add("error");
				noticeImg.value = ""; // 파일 선택 초기화
				return;
			}
			// 모든 파일 크기 OK
			uploader.classList.remove("error");
		}
			
		// 유효성 통과 → 모달 열기
		openDialog("submitCkDialog");
	});
});
