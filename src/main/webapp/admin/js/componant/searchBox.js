
document.addEventListener("DOMContentLoaded", () => {
	/* ************* 답변상태 버튼 클릭 ************* */
	const middleBox = document.querySelector(".filter_box.answer_box");
	if (middleBox) { //해당 div가 있을떄만 실행 
	
		const middleBtns = document.querySelectorAll(".answer_body .filter-btn");

		// 처음엔 '전체' 버튼 활성화
		middleBtns[0].classList.add("active");

		middleBtns.forEach((btn) => {
			btn.addEventListener("click", () => {
				answerBtns.forEach((b) => b.classList.remove("active")); // 모두 제거
				btn.classList.add("active"); // 클릭한 것만 적용
			});
		});
	}
});




