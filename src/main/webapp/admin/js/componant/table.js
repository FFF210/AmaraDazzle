/* ******************************************
	일대일 답변탭 > 상세보기 클릭시 액션     
******************************************* */
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


/* ******************************************
  * 테이블 정렬
******************************************* */
document.querySelectorAll("th.sortable").forEach(th => {
	th.addEventListener("click", () => {
		// 모든 헤더 초기화
		document.querySelectorAll("th.sortable").forEach(other => {
			if (other !== th) {
				other.classList.remove("asc", "desc");
				other.querySelector(".sort-icon").className = "bi bi-dash-lg sort-icon";
			}
		});

		const icon = th.querySelector(".sort-icon");

		if (th.classList.contains("asc")) {
			th.classList.remove("asc");
			th.classList.add("desc");
			icon.className = "bi bi-caret-down-fill sort-icon";

		} else if (th.classList.contains("desc")) {
			th.classList.remove("desc");
			icon.className = "bi bi-dash-lg sort-icon"; // 기본 상태

		} else {
			th.classList.add("asc");
			icon.className = "bi bi-caret-up-fill sort-icon";
		}
	});
});


/* ******************************************
  * 체크박스
******************************************* */
var ob = document.querySelectorAll(".n_ch"); 
var ea = ob.length;  

//최상단 박스 체크시 모든 체크박스 선택
function ck_all(v){
	for(var f=0; f<ea; f++){  
		ob[f].checked = v ;  
	}
}

//체크박스 하나라도 해제되었을 경우 최상단박스의 체크를 해제 
function choice_ck(){
	var all = document.getElementById("all_ck");
	var count=0;
	
	for(var f=0; f<ea; f++){
		if(ob[f].checked == true){
			count++;
		}
	}
	if(ea==count){  //
		all.checked = true;
		
	}else{
		all.checked = false;
	}
}

/* ******************************************
  상태변경 
******************************************* */
function changeState() {
	alert("sss");
}
