//탭 전환 함수
function showTab(tabId) {
    document.querySelectorAll(".tab").forEach((tab) => tab.classList.remove("active"));
    document.querySelectorAll(".tab_content").forEach((content) => (content.style.display = "none"));

    document.querySelector(".tab[onclick=\"showTab('" + tabId + "')\"]").classList.add("active");
    document.getElementById(tabId).style.display = "block";
}


//브랜드 상세보기 페이지 이동 
function goSellerDetail(num){
	location.href = "sellerDetail?num=" + num
}