//고정된 사이드바 새로고침시 그대로 유지하기
(function () {
    // 사이드바 상태
    const isPinned = localStorage.getItem("sidebarPinned") === "true";

    // MutationObserver : HTML 파싱 중에도 실행되도록 DOMContentLoaded 전에 처리
    const sidebar = document.documentElement; // 일단 <html> 기준으로
    const observer = new MutationObserver(() => {
        const sb = document.querySelector("#sidebar");
        if (!sb) return; // 아직 없으면 대기
        if (isPinned) {
            sb.classList.remove("collapsed");
            sb.classList.add("sidebarPinned");
        } else {
            sb.classList.add("collapsed");
            // sb.classList.remove("sidebarPinned");
        }
        observer.disconnect(); // 적용 후 관찰 중단
    });
    observer.observe(sidebar, { childList: true, subtree: true });

    // 탭 상태
    const STORAGE_KEY = "currentTab";
    const curTab = sessionStorage.getItem(STORAGE_KEY);

    if (!curTab) return; // 저장된 값 없으면 기본 상태 사용

    // DOM이 아직 없을 수 있으므로 MutationObserver 사용
    const tabObserver = new MutationObserver(() => {
        const tabs = document.querySelectorAll(".tab");
        const contents = document.querySelectorAll(".tab_content");
        if (!tabs.length || !contents.length) return;

        // 탭 버튼 활성화
        tabs.forEach((t) => {
            t.classList.toggle("active", t.dataset.tab === curTab);
        });
        // 탭 내용 표시
        contents.forEach((c) => {
            c.style.display = c.id === curTab ? "block" : "none";
        });

        tabObserver.disconnect(); // 적용 후 관찰 종료
    });
    tabObserver.observe(document.documentElement, { childList: true, subtree: true });
})();
//즉시실행함수

//사이드바 메뉴 열림 상태
window.addEventListener("DOMContentLoaded", () => {
    const openedMenuId = sessionStorage.getItem("openedMenu");
    const openedSubId = sessionStorage.getItem("openedSubMenu");

    // if (!openedMenuId) return;

    const menuEl = document.querySelector(`.menu-item[data-menu="${openedMenuId}"]`);
    if (!menuEl) return;

    let subEl = null;
    if (openedSubId) {
        subEl = menuEl.querySelector(`.submenu > div[data-submenu="${openedSubId}"] a`);
    }

    // class 복원
    menuEl.classList.add("active", "open");
    if (subEl) subEl.classList.add("active");

    // JS 변수 갱신
    lastClickedMenu = menuEl;
    lastClickedSubItem = subEl;
});
