//개별지급목록 페이지로 이동 
function goIndiCpList() {
	location.href = "/admin/couponIndiList";
};

//쿠폰 발행 버튼 클릭시 발행 페이지로 이동 
function cpPublBtn() {
	location.href = "/admin/couponPublWrite";
};

//쿠폰 상세보기 버튼 클릭시 
function goPcpDetail(num) {
	location.href = "/admin/couponPublDetail?num=" + num;
};

document.addEventListener("DOMContentLoaded", function() {
	document.querySelectorAll('input[name="pCouponRdo"]').forEach(radio => {
		radio.addEventListener('change', function() {
			const cname = this.dataset.cname;
			const amount = this.dataset.amount;
			const start = this.dataset.start;
			const end = this.dataset.end;
			const provision = this.dataset.provision;

			document.querySelector('#modalCouponName').value = cname;
			document.querySelector('#modalCouponAmount').value = amount;
			document.querySelector('#modalCouponStart').value = start;
			document.querySelector('#modalCouponEnd').value = end;

			// 지급방식에 따라 "지급대상" 영역 표시/숨김
			const individualSection = document.querySelector('#indiCpModal .individual-only');
			if (provision === 'INDIVIDUAL') {
				individualSection.style.display = 'block';
			} else {
				individualSection.style.display = 'none';
			}
		});
	});

});	
