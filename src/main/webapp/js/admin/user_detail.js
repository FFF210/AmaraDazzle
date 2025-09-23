/* *********************************** */
/* 새로고침해도 현재 보고있는 탭 내용 유지  */
/* *********************************** */
const tabs = document.querySelectorAll(".tab");
const contents = document.querySelectorAll(".tab_content");
const STORAGE_KEY = "currentTab";
const curTab = sessionStorage.getItem(STORAGE_KEY);
console.log("현재 탭:", curTab);

// 초기 로드 시 저장된 탭 활성화
if (curTab) {
    activateTab(curTab);
} else {
    // 기본 첫 번째 탭 활성화
    const first = tabs[0].dataset.tab;
    activateTab(first);
}

tabs.forEach((tab) => {
    tab.addEventListener("click", () => {
        const name = tab.dataset.tab;
        activateTab(name);
        sessionStorage.setItem(STORAGE_KEY, name); // 클릭한 탭 저장
    });
});

function activateTab(name) {
    // 탭 버튼
    tabs.forEach((t) => {
        t.classList.toggle("active", t.dataset.tab === name);
    });
    // 탭 내용
    contents.forEach((c) => {
        c.style.display = c.id === name ? "block" : "none";
    });
}
