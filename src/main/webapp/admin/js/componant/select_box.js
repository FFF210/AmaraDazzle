
document.addEventListener("DOMContentLoaded", () => {

	
	/* ************* 답변상태 버튼 클릭 ************* */
	const answerBtns = document.querySelectorAll(".answer_body .choice");

	// 처음엔 '전체' 버튼 활성화
	answerBtns[0].classList.add("active");

	answerBtns.forEach((btn) => {
		btn.addEventListener("click", () => {
			answerBtns.forEach((b) => b.classList.remove("active")); // 모두 제거
			btn.classList.add("active"); // 클릭한 것만 적용
		});
	});
});


