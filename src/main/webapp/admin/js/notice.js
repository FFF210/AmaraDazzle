//공지작성 페이지로 이동
function goWriteNoticeSeller(){
	location.href="noticeSellerWrite"
}


//공지 내용 상세보기 페이지로 이동
function goNoticeDetail(num, target){
	if(target == 5) {
		location.href="noticeSellerDetail?num="+num
	} else if(target == 4) {
		location.href="noticePlatformDetail?num="+num
	}
}


//toast editor 설정 
const editor = new toastui.Editor({
	el: document.querySelector('#editContent'),
	height: '500px',
	initialEditType: 'wysiwyg',
});

// editor.getHtml()을 사용해서 에디터 내용 받아오기
//console.log(editor.getHTML());
//console.log(editor.getMarkdown());

const target = document.getElementById("noticeTargetType");
const category = document.getElementById("noticeCate");
const title = document.getElementById("noticeTitle");
const content = editor.getHTML();
const writer = document.getElementById("noticeWriter");
const writeBtn = document.getElementById("writeBtn");

//필수입력 유효성 검사 
writeBtn.addEventListener("click", () => {
	const fileAttach = document.getElementsByName("noticeFile");
	if (category.value == "") {
		alert("공지 카테고리를 선택하세요.");
		category.focus();
		return;
	}

	if (title.value == "") {
		alert("공지 제목을 입력하세요.");
		title.focus();
		return;
	}

	if (title.value.length > 150) {
		alert("제목은 150자까지만 쓸 수 있습니다.");
		title.focus();
		return;
	}

	if (editor.getMarkdown() == "") {
		alert("내용을 입력해주세요.");
		editor.focus();
		return;
	}

	if (editor.getMarkdown().length < 10) {
		alert("내용은 10자 이상 입력해야 합니다.");
		editor.focus();
		return;
	}

	if(fileAttach){   //파일첨부 함경우 
		const imgSize = fileAttach.size; // 파일 크기
		const maxSize = 10 * 1024 * 1024; // 10MB제한
			
		if(imgSize > maxSize){
			alert("파일첨부 용량은 10MB이하만 가능합니다.");
			return;
		}
	}
		
	//완료시 BE로 전달 	
	if (confirm("모든 작성내용을 확인하였습니까?")) {
		insertSellerNotice();
	}
});

//공지(seller) 글쓰기 ajax
function insertSellerNotice(){
	const fileAttach = document.getElementById("fileInput");

	const formData = new FormData();
	formData.append("type_id", category.value);
	formData.append("title", title.value);
	formData.append("content", editor.getHTML());
	formData.append("writer", writer.value);
	formData.append("target_type_id", target.value);
	
	//파일첨부를 한 경우 
	if(fileAttach.files.length > 0){
		for (let i = 0; i < fileAttach.files.length; i++) {
		   formData.append("noticeFile", fileAttach.files[i]);
		}
	}
    
	fetch("noticeSellerWrite", {
		method: "POST",
		body : formData
		
	}).then(function(data) {
		return data.json();

	}).then(function(result) {
		if(result.status == "ok"){
			alert("공지 등록이 완료되었습니다.");
			
			//상세보기로 이동
			location.href="noticeSellerDetail?num="+result.id;
			
		}else if(result=="fail"){
			alert("시스템문제로 공지 등록에 실패했습니다.\n관리자에게 문의해주세요.");
		}

	}).catch(function(error) {
		console.log("통신오류발생" + error);
	});
}


