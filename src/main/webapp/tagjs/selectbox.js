(function() {
	//tagjs
	// 페이지 로드 후 실행
	document.addEventListener("DOMContentLoaded", () => {
		const selects = document.querySelectorAll(".custom-select");

		selects.forEach(select => {
			const header = select.querySelector(".select-header");
			const label = select.querySelector(".select-label");
			const list = select.querySelector(".select-list");

			// 드롭다운 열기/닫기
			header.addEventListener("click", (e) => {
				e.stopPropagation();

				// 다른 select 닫기
				selects.forEach(s => {
					if (s !== select) s.classList.remove("open");
				});

				// 현재 select 열기/닫기
				select.classList.toggle("open");
				console.log("열린 select:", select.id, select.classList.contains("open"));
			});

			// 아이템 선택
			list.querySelectorAll(".select-item").forEach(item => {
				item.addEventListener("click", (e) => {
					e.stopPropagation();

					const value = item.dataset.value;
					const text = item.textContent;

					// 라벨 변경
					label.textContent = text;
					
					// 선택 표시 갱신
					list.querySelectorAll(".select-item")
						.forEach(i => i.classList.remove("active"));
					item.classList.add("active");

					select.classList.remove("open");

					// selectbox 전용 이벤트 발생
					const event = new CustomEvent("selectChanged", {
						detail: { value, text }
					});
					select.dispatchEvent(event);
				});
			});
		});

		// 외부 클릭 시 모든 드롭다운 닫기
		document.addEventListener("click", () => {
			document.querySelectorAll(".custom-select.open")
				.forEach(s => s.classList.remove("open"));
		});
	});
})();

document.querySelectorAll(".custom-select").forEach(select => {
	const label = select.querySelector(".select-label");
	const items = select.querySelectorAll(".select-item");
	const hidden = select.parentElement.querySelector("input[type='hidden'][name]");

	// 페이지 로드 시 hidden 값 반영
	if (hidden && hidden.value) {
		const matched = Array.from(items).find(li => li.dataset.value === hidden.value);
		if (matched) {
			label.textContent = matched.dataset.value;
			items.forEach(li => li.classList.remove("active"));
			matched.classList.add("active");
		}
	}

	// 클릭 이벤트 시 hidden 갱신
	items.forEach(item => {
		item.addEventListener("click", () => {
			const value = item.dataset.value;
			label.textContent = value;
			items.forEach(li => li.classList.remove("active"));
			item.classList.add("active");
			if (hidden) hidden.value = value;
		});
	});
});
