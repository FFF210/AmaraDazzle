/* *********************************** */
/* 일대일 답변탭 > 상세보기 클릭시 액션     */
/* *********************************** */
document.querySelectorAll("tr[data-main] .reply_view i").forEach((icon) => {
    icon.addEventListener("click", () => {
        console.log("아이콘 클릭됨");
        const mainRow = icon.closest("tr[data-main]");
        const groupId = mainRow.dataset.group;

        // 같은 그룹이면서 메인이 아닌 모든 tr 선택
        const detailRows = document.querySelectorAll(`tr[data-group="${groupId}"]:not([data-main])`);

        // 토글 동작
        let isOpen = false;
        detailRows.forEach((row) => {
            const show = row.style.display === "table-row";
            row.style.display = show ? "none" : "table-row";
            if (!show) isOpen = true; // 하나라도 열렸으면 true
        });

        // 아이콘 방향 토글
        if (isOpen) {
            icon.classList.replace("bi-chevron-compact-down", "bi-chevron-compact-up");
        } else {
            icon.classList.replace("bi-chevron-compact-up", "bi-chevron-compact-down");
        }
    });
});
