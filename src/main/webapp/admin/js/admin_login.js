document.querySelectorAll("#loginForm input").forEach(input => {
	input.addEventListener("input", function() {
		if (this.value.trim() != "") {
			this.closest(".text-input-wrapper").classList.remove("state--error");
			this.closest(".text-input-wrapper").classList.add("state--default");

		} else {
			this.closest(".text-input-wrapper").classList.remove("state--default");
			this.closest(".text-input-wrapper").classList.add("state--error");
		}
	});
});

//유효성검사 + 폼 제출
document.getElementById("loginForm").addEventListener("submit", (e) => {
	e.preventDefault();

	const aid = document.getElementById("aid");
	const apass = document.getElementById("apass");
	const regId = /^[A-Za-z0-9_\-+=]+$/;

	if (aid.value.trim() == "") {
		showAlert("error", " ", "아이디를 입력하세요");
		aid.focus();
		aid.closest(".text-input-wrapper").classList.add("state--error");
		return;
	}

	if (!regId.test(aid.value.trim())) {
		showAlert("error", " ", "허용되지 않는 아이디입니다.\n 다시 확인해주세요.");
		aid.focus();
		aid.closest(".text-input-wrapper").classList.add("state--error");
		return;
	}
	if (apass.value.trim() == "") {
		showAlert("error", " ", "비밀번호를 입력해 주세요.");
		apass.focus();
		apass.closest(".text-input-wrapper").classList.add("state--error");
		return;
	}

	//유효성 검사 끝나면 폼 전송 
	try {
		const params = new URLSearchParams();
		const rememberIdEl = document.getElementById("rememberId");
		
		params.append("aid", aid.value);
		params.append("apass", apass.value);
		params.append("rememberId", (rememberIdEl && rememberIdEl.checked) ? "Y" : "");

		fetch("/admin/login", {
			method: "POST",
			headers: { "Content-Type": "application/x-www-form-urlencoded" },
			body: params

		}).then(function(data) {
			return data.json();

		}).then(function(result) {
			if (result.status == "ok") {
				showAlert("success", result.title, result.message); // 2초간 토스트

				//메인으로 이동
				setTimeout(() => {
					location.href = "home"; // 1초 후 메인으로 이동
				}, 2000);

			} else if (result.status == "fail") {
				showAlert("error", result.title, result.message); // 2초간 토스트
			}

		}).catch(function(error) {
		    console.log("통신오류발생", error);
		    showAlert("error", "서버 오류", "통신 중 오류가 발생했습니다.");
		});

	} catch (err) {
		console.error(err);
		showAlert("error", "로그인 실패", "로그인 중 오류가 발생했습니다.");
	}

});


//알럿띄우기 
function showAlert(type, title, message) {
	const icons = {
		error: '<i class="bi bi-x-circle-fill"></i>',
		warning: '<i class="bi bi-exclamation-triangle-fill"></i>',
		success: '<i class="bi bi-check-circle-fill"></i>',
		info: '<i class="bi bi-info-circle-fill"></i>'
	};
	const toast = document.getElementById("toast");
	toast.innerHTML = `
	    <div class="alert alert--${type}">
	      <div class="alert-icon">${icons[type] || ""}</div>
	      <div class="alert-content">
	        ${title ? `<div class="alert-title">${title}</div>` : ""}
	        <div class="alert-message">${message}</div>
	      </div>
	    </div> `;

	toast.classList.add("show");

	setTimeout(() => {
		toast.classList.remove("show");
	}, 2000);
}



