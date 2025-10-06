document.addEventListener("DOMContentLoaded", function() {
	const input = document.getElementById("productInput");
	const addBtn = document.getElementById("addProduct");
	const chipsBox = document.getElementById("productChips");
	const hiddenBox = document.getElementById("productHiddenInputs");

	addBtn.addEventListener("click", () => {
		const val = input.value.trim();
		if (!val) return;

		// chip UI 생성
		const chip = document.createElement("div");
		chip.className = "chip";
		chip.textContent = val;
		const closeBtn = document.createElement("span");
		closeBtn.textContent = "×";
		closeBtn.className = "chip-close";
		closeBtn.onclick = () => {
			chipsBox.removeChild(chip);
			hiddenBox.removeChild(hiddenInput);
		};
		chip.appendChild(closeBtn);
		chipsBox.appendChild(chip);

		// hidden input 생성
		const hiddenInput = document.createElement("input");
		hiddenInput.type = "hidden";
		hiddenInput.name = "productIds";   // ✅ 배열 파라미터
		hiddenInput.value = val;
		hiddenBox.appendChild(hiddenInput);

		input.value = "";
	});
});
// ========== 이벤트 종류 선택 시 이벤트명 목록 불러오기 ==========
document.querySelectorAll("#eventTypeSelect .select-item").forEach(item => {
	item.addEventListener("click", function() {
		const type = this.dataset.value;

		// 선택한 라벨 표시
		document.querySelector("#eventTypeSelect .select-label").textContent = this.textContent;
		document.getElementById("eventTypeInput").value = type;

		// Ajax 요청
		fetch(`/brand2/eventNames?type=${encodeURIComponent(type)}`)
			.then(res => res.json())
			.then(list => {
				const ul = document.getElementById("eventNameList");
				ul.innerHTML = ""; // 기존 항목 삭제
				list.forEach(ev => {
					const li = document.createElement("li");
					li.className = "select-item";
					li.dataset.value = ev.eventId;
					li.textContent = ev.eventName;

					// 클릭 이벤트 (이벤트명 선택 시 input 값 세팅)
					li.addEventListener("click", function() {
						document.querySelector("#eventNameSelect .select-label").textContent = this.textContent;
						document.getElementById("eventIdInput").value = this.dataset.value;
					});

					ul.appendChild(li);
				});
				// 이벤트명 selectbox 라벨 초기화
				document.querySelector("#eventNameSelect .select-label").textContent = "이벤트명 선택";
				document.getElementById("eventIdInput").value = "";
			})
			.catch(err => {
				console.error("이벤트명 불러오기 실패:", err);
			});
	});
});
