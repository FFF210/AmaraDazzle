const logInfoBtn = document.querySelector(".header_icon > .bi-person-circle");
const loginInfo = document.querySelector(".modal.loginInfo");

// 마우스 올리면 펼치기
// logInfoBtn.addEventListener("click", () => {
//     if (loginInfo.style.display === "flex") {
//         loginInfo.style.display = "none";
//         return;
//     }
//     loginInfo.style.display = "flex";
//     loginInfo.style.position = "fixed";
// });

// 팝업 열기/닫기 토글
logInfoBtn.addEventListener("click", (e) => {
    e.stopPropagation(); // **버튼을 눌러도 문서 클릭으로 닫히지 않게**
    loginInfo.classList.toggle("hidden");
});

// 팝업 내부는 닫힘 방지
loginInfo.addEventListener("click", (e) => e.stopPropagation());

// 문서 아무 곳이나 클릭 → 팝업 닫기
document.addEventListener("click", () => {
    if (!loginInfo.classList.contains("hidden")) {
        loginInfo.classList.add("hidden");
    }
});
