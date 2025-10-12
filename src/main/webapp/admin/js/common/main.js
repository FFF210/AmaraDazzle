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