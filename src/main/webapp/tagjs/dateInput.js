const p_today = new Date();
const offset = p_today.getTimezoneOffset() * 60000;
const local = new Date(p_today.getTime() - offset);

//endDate 오늘날짜로 자동 세팅 
function settingToday() {
	let end = document.querySelectorAll(".end_date");
	for (let i = 0; i < end.length; i++) {
		end[i].value = local.toISOString().split("T")[0]; //첫 접속시 기간설정 endtdate 오늘로 세팅
	}
}

document.addEventListener("DOMContentLoaded", () => {
//	settingToday();

	document.querySelectorAll(".date-input .input-wrapper").forEach(wrapper => {
		const input = wrapper.querySelector(".date-text");
		const iconBtn = wrapper.querySelector(".calendar-icon-wrapper");

		if (input) {
			// flatpickr 달력 연결
			const fp = flatpickr(input, {
				dateFormat: "Y-m-d",
				allowInput: false,
				onChange: function(selectedDates, dateStr, instance) {
					if (input.classList.contains("end_date")) {
						const pickedStartDate = selectedDates[0];
						const pickedendtDate = selectedDates[0];
						
						if (pickedStartDate && pickedendtDate) {
							
							pickedStartDate.setHours(0, 0, 0, 0);
							pickedendtDate.setHours(0, 0, 0, 0);

							if (pickedendtDate < pickedStartDate) {
								alert("기간의 마지막은 시작일 이전의 날짜를 선택할 수 없습니다.");
								instance.clear(); 
								// 잘못 선택한 날짜 지우기
							}
						}
					}
				}
			});

			// 아이콘 클릭 시 달력 열기
			if (iconBtn) {
				iconBtn.addEventListener("click", () => fp.open());
			}
		}
	});

	// --- 프리셋 버튼 이벤트 ---
	document.querySelectorAll(".date-input .preset-btn").forEach(btn => {
		btn.addEventListener("click", () => {
			const parent = btn.closest(".date-input");

			parent.querySelectorAll(".preset-btn").forEach(b => b.classList.remove("active"));
			btn.classList.add("active");

			// 오늘 날짜 기준 계산
			const toDateStr = d => d.toISOString().split("T")[0];

			const filterBox = btn.closest(".filter_box");
			if (!filterBox) return;

			const startInput = filterBox.querySelector(".start_date");
			const endInput = filterBox.querySelector(".end_date");
			if (!startInput || !endInput) return;

			switch (btn.textContent.trim()) {
				case "오늘":
					startInput.value = toDateStr(local);
					endInput.value = toDateStr(local);
					break;
				case "어제":
					const yest = new Date(local.getTime() - 1 * 24 * 60 * 60 * 1000);
					startInput.value = toDateStr(yest);
					endInput.value = toDateStr(yest);
					break;
				case "최근 7일":
					const last7 = new Date(local.getTime() - 7 * 24 * 60 * 60 * 1000);
					startInput.value = toDateStr(last7);
					endInput.value = toDateStr(local);
					break;
				case "최근 30일":
					const last30 = new Date(local.getTime() - 30 * 24 * 60 * 60 * 1000);
					startInput.value = toDateStr(last30);
					endInput.value = toDateStr(local);
					break;
			}

			// 부모 페이지로 이벤트 전달
			const event = new CustomEvent("datePresetSelected", {
				detail: { value: btn.textContent.trim(), date: toDateStr(local) }
			});
			document.dispatchEvent(event);
		});
	});
});