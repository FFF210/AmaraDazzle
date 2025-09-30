const todate = new Date();
const timezone = todate.getTimezoneOffset() * 60000; // 로컬 타임존 보정
const localtime = new Date(todate.getTime() - timezone);

function settingToday() {
	let startDate = document.querySelectorAll(".start_date");
	for(let i = 0; i < startDate.length; i++){
		startDate[i].value = localtime.toISOString().split("T")[0]; //첫 접속시 기간설정 startdate 오늘로 세팅
	}
}

document.addEventListener("DOMContentLoaded", () => {
//	settingToday();
	
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


