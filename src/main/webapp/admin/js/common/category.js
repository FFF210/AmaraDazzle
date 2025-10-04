document.addEventListener("DOMContentLoaded", () => {
	const largeSelect = document.getElementById("largeSelect");
	const middleSelect = document.getElementById("middleSelect");
	const smallSelect = document.getElementById("smallSelect");

	// selectbox 내부를 갱신하는 함수 (li 생성)
	function updateSelectbox(selectElem, items, placeholder) {
		const list = selectElem.querySelector(".select-list");
		const label = selectElem.querySelector(".select-label");

		// 초기화
		list.innerHTML = "";
		label.textContent = placeholder;

		// 항목 추가
		items.forEach(c => {
			const li = document.createElement("li");
			li.className = "select-item";
			li.dataset.value = c.categoryId;
			li.textContent = c.name;
			list.appendChild(li);

			li.addEventListener("click", () => {
				label.textContent = c.name;
				list.querySelectorAll(".select-item").forEach(i => i.classList.remove("active"));
				li.classList.add("active");

				const event = new CustomEvent("selectChanged", {
					detail: { value: c.categoryId, text: c.name }
				});
				selectElem.dispatchEvent(event);
			});
		});
	}

	// 대분류 불러오기
	fetch("/category?type=large")
		.then(res => res.json())
		.then(data => {
			updateSelectbox(largeSelect, data, "대분류");
		});

	// 대분류 선택 → 중분류 불러오기
	largeSelect.addEventListener("selectChanged", e => {
		
		document.getElementById("category1Id").value = e.detail.value;
		console.log("e.detail.value : " + e.detail.value)
		
		const parentId = e.detail.value;
		
		if (!parentId) return;
		console.log("parentId : " + parentId)
		
		fetch(`/category?type=middle&parentId=${parentId}`)
			.then(res => res.json())
			.then(data => {
				updateSelectbox(middleSelect, data, "중분류");
				updateSelectbox(smallSelect, [], "소분류"); // 초기화
			});
	});

	// 중분류 선택 → 소분류 불러오기
	middleSelect.addEventListener("selectChanged", e => {
		document.getElementById("category2Id").value = e.detail.value;
		const parentId = e.detail.value;
		if (!parentId) return;

		fetch(`/category?type=small&parentId=${parentId}`)
			.then(res => res.json())
			.then(data => {
				if(data != null && data.length > 0){
					smallSelect.classList.remove("disabled");
					updateSelectbox(smallSelect, data, "소분류");
				}else {
					smallSelect.classList.add("disabled");
				}
				
			});
	});

	// 소분류 선택 → hidden 업데이트
	smallSelect.addEventListener("selectChanged", e => {
		document.getElementById("category3Id").value = e.detail.value;
	});
});