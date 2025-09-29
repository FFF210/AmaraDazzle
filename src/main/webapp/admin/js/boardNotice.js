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
