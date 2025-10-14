//공지작성 페이지로 이동
function goWriteNoticeSeller() {
	location.href = "noticeSellerWrite"
}

//공지 내용 상세보기 페이지로 이동
function goNoticeDetail(num, target) {
	if (target == 5) {
		location.href = "noticeSellerDetail?num=" + num
	} else if (target == 4) {
		location.href = "noticePlatformDetail?num=" + num
	}
}

function exposeState(num){
	fetch(`/admin/exposeChange?num=${num}`, {
		method: "GET"
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

//공지 삭제 
document.addEventListener("DOMContentLoaded", function() {
	const deleteBtn = document.getElementById("deleteNotice");
	
	document.addEventListener("dialogAction", function(e) {
		const { id, action } = e.detail;

		if (id === "submitCkDialog" && action === "전송") {
			const checked = Array.from(document.querySelectorAll("input[name='n_ch']:checked"))
				.map(ch => ch.value);

			const params = new URLSearchParams();
			checked.forEach(v => params.append("n_ch", v));

			fetch("/admin/noticeSellerDelete", {
				method: "POST",
				headers: { "Content-Type": "application/x-www-form-urlencoded" },
				body: params
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
						location.href = "noticeSellerList"; // 리스트로 이동
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
	});
	
	//공지 삭제 처리 
	deleteBtn.addEventListener("click", () => {
		var count = 0;
		for (var n = 0; n < ea; n++) {
			if (ob[n].checked == true) {
				count++;
			}
		}
		
		//하나도 선택되지 않았을경우
		if (count <= 0) {
			showAlert("error", " ", "삭제할 공지를 선택하세요.");
		}
		else {
			openDialog("submitCkDialog");
		};
	});
});





