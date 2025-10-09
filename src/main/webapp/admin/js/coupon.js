//쿠폰 발행 버튼 클릭시 발행 페이지로 이동 
function cpPublBtn() {
	location.href = "/admin/pCouponWrite";
};

//쿠폰 상세보기 버튼 클릭시 발행 페이지로 이동 
function goPcpDetail(num) {
	console.log("ssss")
	location.href = "/admin/publCouponDetail?num="+num;
};
