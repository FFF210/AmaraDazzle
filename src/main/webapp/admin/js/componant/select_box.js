const today = new Date();
const offset = today.getTimezoneOffset() * 60000; // 로컬 타임존 보정
const local = new Date(today.getTime() - offset);

function settingToday() {
    document.querySelector(".period_body .start_date").value = local.toISOString().split("T")[0]; //첫 접속시 기간설정 startdate 오늘로 세팅
    // document.querySelector("#dueDate").value = new Date().toISOString().split("T")[0]; //order_insert
    // document.querySelector("#stock_start_date").value = new Date().toISOString().split("T")[0]; //product_plan_insert
    // document.querySelector("#out_date").value = new Date().toISOString().split("T")[0]; //outbound_insert
}

document.addEventListener("DOMContentLoaded", () => {
    settingToday();
});

document.addEventListener("DOMContentLoaded", () => {
    /* ************* 기간 선택 버튼 클릭 ************* */
    const periodBtns = document.querySelectorAll(".period_body .p_choice input[type='button']");

    let startDate = document.querySelector(".period_body .start_date");
    let endDate = document.querySelector(".period_body .end_date");

    periodBtns.forEach((btn) => {
        btn.addEventListener("click", () => {
            periodBtns.forEach((b) => b.classList.remove("active")); // 모두 제거
            btn.classList.add("active"); // 클릭한 것만 적용

            if (btn.value === "오늘") {
                endDate.value = local.toISOString().split("T")[0];
                startDate.value = local.toISOString().split("T")[0];
            } else if (btn.value === "어제") {
                const yesterday = new Date(local.getTime() - 1 * 24 * 60 * 60 * 1000);
                endDate.value = yesterday.toISOString().split("T")[0];
                startDate.value = yesterday.toISOString().split("T")[0];
            } else if (btn.value === "최근7일") {
                const lastWeek = new Date(local.getTime() - 7 * 24 * 60 * 60 * 1000);
                endDate.value = local.toISOString().split("T")[0];
                startDate.value = lastWeek.toISOString().split("T")[0];
            } else if (btn.value === "최근30일") {
                const lastMonth = new Date(local.getTime() - 30 * 24 * 60 * 60 * 1000);
                endDate.value = local.toISOString().split("T")[0];
                startDate.value = lastMonth.toISOString().split("T")[0];
            }
        });
    });

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
