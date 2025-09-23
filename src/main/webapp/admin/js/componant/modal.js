const cName_searchBtn = document.querySelector("#cName_searchBtn");
const searchUserBox = document.querySelector(".modal.modal_search_box");
const modal_selectBtn = document.getElementById("modal_selectBtn");

// 팝업 열기/닫기 토글
cName_searchBtn.addEventListener("click", (e) => {
    e.stopPropagation(); // **버튼을 눌러도 문서 클릭으로 닫히지 않게**
    searchUserBox.classList.toggle("hidden");
});

// 팝업 내부는 닫힘 방지
searchUserBox.addEventListener("click", (e) => e.stopPropagation());

// 문서 아무 곳이나 클릭 → 팝업 닫기
document.addEventListener("click", () => {
    if (!searchUserBox.classList.contains("hidden")) {
        searchUserBox.classList.add("hidden");
    }
});

// 테스트: 팝업 내부 버튼
// modal_selectBtn.addEventListener("click", () => {
//     alert("팝업 내부 버튼 동작");
// });

// 테스트: 메뉴 버튼
// document.getElementById("homeBtn").addEventListener("click", () => {
//     alert("메뉴 버튼 동작");
// });
