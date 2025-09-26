

// editor.getHtml()을 사용해서 에디터 내용 받아오기
console.log(editor.getHTML());
console.log(editor.getMarkdown());






const category = document.getElementById("noticeCate");
const title = document.getElementById("noticeTitle");
const fileAttach = document.getElementById("fileAttach");
const content = document.getElementById("editContent");
const writer = document.getElementById("noticeWriter");
const writeBtn = document.getElementById("writeBtn");

writeBtn.addEventListener("click", function() {
	if(category.value==""){
		alert("공지 카테고리를 선택하세요.");
		return;
	}
	
	if(title.value==""){
		alert("공지 제목을 입력하세요.");
		return;
	}
	
	if(title.value.length > 150){
		alert("제목은 150자까지만 쓸 수 있습니다.");
		return;
	}
		
//	if(editor.getMarkdown() == "") {
//		alert("제목은 150자까지만 쓸 수 있습니다.");
//		return;
//	}
	
	


});