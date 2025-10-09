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
        const tabName = tab.dataset.tab;
        activateTab(tabName);
        sessionStorage.setItem(STORAGE_KEY, tabName); // 클릭한 탭 저장
    });
});

function activateTab(tabName) {
    // 탭 버튼 클릭시 active 효과 
    tabs.forEach((t) => {
        t.classList.toggle("active", t.dataset.tab === tabName);
    });
    // 탭 내용 노출 
    contents.forEach((c) => {
        c.style.display = c.id === tabName ? "block" : "none";
    });
}







