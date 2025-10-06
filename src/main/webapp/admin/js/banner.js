//배너 등록 페이지로 이동
function goWriteBanner() {
	location.href = "promoBannerWrite"
}


//배너 상세 페이지로 이동
function goBannerDetail(num) {
	location.href="promoBannerDetail?num="+num
}


document.addEventListener("DOMContentLoaded", function() {

	/* ************* 폼전송 + 유효성검사 ************* */
	const frm = document.getElementById("bannerWriteForm");
	const submitBtn = document.getElementById("bannerWriteBtn");
	const bannerThumb = document.querySelector('input[name="bannerThumb"]');
	const uploader = document.querySelector("#fileDropper");
	
	//공란 채울 경우 빨강테두리 지움
	document.querySelectorAll("#bannerWriteForm input").forEach(input => {
		input.addEventListener("input", function() {
			if (this.value.trim() != "") {
				this.classList.remove("state_error");
			}
		});
	});

	// ======== 확인 모달에서 "확인" 클릭 시 폼 전송되도록 미리 대기 ========
	document.addEventListener("dialogAction", function(e) {
		const { id, action } = e.detail;

		if (id === "submitCkDialog" && action === "전송") {
			const formData = new FormData(frm);
			
			for (const [key, value] of formData.entries()) {
				console.log(key, value);
			}

			fetch("/admin/promoBannerWrite", {
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
		const bannerFile = bannerThumb.files[0];

		//배너명
		if (frm.bannerName.value.trim() == "") {
			showAlert("error", " ", "배너명을 입력하세요.");
			frm.bannerName.classList.add("state_error");
			frm.bannerName.focus();
			return;
		}

		//전시기간
		if (frm.startDate.value.trim() === "") {
			showAlert("error", " ", "배너의 게시기간 시작일을 입력하세요.");
			frm.startDate.classList.add("state_error");
			frm.startDate.focus();
			return;
		}
		if (frm.endDate.value.trim() === "") {
			showAlert("error", " ", "배너의 게시기간 마지막일을 입력하세요.");
			frm.endDate.classList.add("state_error");
			frm.endDate.focus();
			return;
		}

		//배너 이미지
		if (!bannerFile) {
			showAlert("error", " ", "배너 이미지는 반드시 첨부해야 합니다(최대 1개).");
			uploader.classList.add("error");
			return;
		}
		//파일첨부 후
		uploader.classList.remove("error");

		const imgSize = bannerFile.size; // 파일 크기
		const maxSize = 10 * 1024 * 1024; // 10MB제한

		if (imgSize > maxSize) {
			showAlert("error", " ", "파일첨부 용량은 10MB이하만 가능합니다.");
			uploader.classList.add("error");
			return;
		}
		if (!bannerFile.type.startsWith("image/")) {
			showAlert("error", " ", "이미지 파일만 첨부 가능합니다 (jpg, png, gif 등)");
			uploader.classList.add("error");
			return;
		}

		//Link
		if (frm.bannerLink.value.trim() == "") {
			showAlert("error", " ", "배너 클릭시 연결되는 페이지의 url을 입력해주세요.");
			frm.bannerLink.classList.add("state_error");
			frm.bannerLink.focus();
			return;
		}

		// 유효성 통과 → 모달 열기
		openDialog("submitCkDialog");
	});
});
