document.addEventListener("DOMContentLoaded", () => {
	let hasMembership = false; // 서버에서 주입

	const btnCancel = document.getElementById("btnCancel");
	const alertBox = document.getElementById("alertBox");
	const popupOverlay = document.getElementById("popupOverlay");
	const btnPopupClose = document.getElementById("btnClose");
	const btnConfirmCancel = document.getElementById("btnConfirmCancel");

	btnCancel.addEventListener("click", () => {
		if (!hasMembership) {
			alertBox.style.display = "block";  // alert 열기
			// 3초 후 자동 숨김
			setTimeout(() => {
				alertBox.style.display = "none";
			}, 3000);
		} else {
			popupOverlay.style.display = "flex"; // popup 열기
		}
	});

	btnPopupClose.addEventListener("click", () => {
		popupOverlay.style.display = "none";
	});

	btnConfirmCancel.addEventListener("click", () => {
		alert("정기 결제가 해지되었습니다.");
		popupOverlay.style.display = "none";
	});
});
