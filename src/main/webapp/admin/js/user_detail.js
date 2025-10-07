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





//상세보기 페이지 탭전환 ajax 
function selectTabOpen(prt){
	
	fetch("./product_md_list.do?parent="+prt, {
		method: "GET",

	}).then(function(data) {
		return data.text();

	}).then(function(result) {
		document.getElementById("modalContainer").innerHTML = result;
		
		var modal= new bootstrap.Modal(document.getElementById("product_list"));
		modal.show();
		
	}).catch(function(error) {
		
		console.log("통신오류발생" + error);
	});
}

//완제품 모달 페이징
function pd_modal_pg (page){
	var parent = "product";
	var keyword = "";
	var pageno = "1";
	var post_ea = 5;
	var type = '';
	
	// 페이지 버튼에서 호출된 경우 버튼 클릭 시 페이징 처리
	if (page instanceof HTMLElement) {
		keyword = page.getAttribute('data-keyword') || '';
		parent = page.getAttribute('data-parent') || 'product';
		pageno = page.getAttribute('data-pageno') || 1;
		post_ea = page.getAttribute('data-pea') || 5;
		type = page.getAttribute('data-type') || '';
	} 
	// 검색창에서 직접 호출된 경우
	else {
		keyword = document.getElementById("keyword")?.value || '';
		parent = document.querySelector('[data-parenttype]')?.getAttribute('data-parenttype') || 'product';
		pageno = 1;
	}
	
	var params = {  
			parent: parent,  
		    type: type,
		    pageno: pageno,
		    post_ea: post_ea,
		};
		
		if (keyword) {  //키워드가 있으면
		    params["keyword"] = keyword;
		}
		var pString = new URLSearchParams(params).toString();
		
	fetch("./product_md_list.do?"+pString+"&mode=modal2", {
		method: "GET",

	}).then(function(data) {
		return data.text();

	}).then(function(result) {
		document.querySelector('#product_list .modal-body').innerHTML = result;
		
	}).catch(function(error) {
		
		console.log("통신오류발생" + error);
	});
}

