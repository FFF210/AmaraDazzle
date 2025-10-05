(function() {

	document.addEventListener("DOMContentLoaded", () => {

		// flatpickr가 로드되지 않은 경우 안내
		if (typeof flatpickr === "undefined") {
			console.warn("flatpickr 라이브러리가 로드되지 않았습니다. CDN 추가가 필요합니다.");
			return;
		}

		// 모든 table-filter 컨테이너
		const filters = document.querySelectorAll(".table-filter");
		if (!filters.length) {
			console.warn("table-filter 컨테이너를 찾을 수 없음");
			return;
		}

		filters.forEach(container => {

			// ===============================
			// 상태 객체
			// ===============================
			const state = {
				dateStart: "",
				dateEnd: "",
				quickRange: "",
				filters: {},
				searchField: "",
				searchKeyword: ""
			};

			// ===============================
			// 검색 조건 매핑
			// ===============================
			const searchMap = {
				"상품명": "NAME",
				"카테고리": "CATEGORY",
				"주문자": "MEMBER",
				"주문상품명": "PRODUCT",
				"작성자": "SENDER",
				"수령인": "RECIPIENT",
				"송장번호": "TRACKINGNO",
				"광고명": "BANNERNAME",
				"광고 담당자": "MANAGERNAME",
				"주문번호": "ORDER",
				"회수운송장번호": "TRACKINGNO"
			};

			// ===============================
			// flatpickr 달력 초기화 (한국어 + 동기화)
			// ===============================
			const startInput = container.querySelector(".date-start");
			const endInput = container.querySelector(".date-end");
			let startPicker, endPicker;

			if (startInput && endInput) {
				startPicker = flatpickr(startInput, {
					locale: "ko",
					dateFormat: "Y-m-d",
					allowInput: true,
					onChange: (selectedDates, dateStr) => {
						state.dateStart = dateStr;
						if (endPicker) endPicker.set("minDate", dateStr);
					}
				});

				endPicker = flatpickr(endInput, {
					locale: "ko",
					dateFormat: "Y-m-d",
					allowInput: true,
					onChange: (selectedDates, dateStr) => {
						state.dateEnd = dateStr;
						if (startPicker) startPicker.set("maxDate", dateStr);
					}
				});
			}

			// ===============================
			// URL 파라미터 → 초기 상태 복원
			// ===============================
			const params = new URLSearchParams(window.location.search);

			params.forEach((value, key) => {

				// 필터 버튼
				const btn = container.querySelector(`.filter-btn[data-filter='${key}'][data-value='${value}']`);
				if (btn) {
					btn.classList.add("active");
					state.filters[key] = value;
				}

				// 검색어
				if (key === "searchKeyword") {
					const input = container.querySelector(".search-input");
					if (input) input.value = value;
					state.searchKeyword = value;
				}

				// 검색조건
				if (key === "searchType") {
					const select = container.querySelector("#searchSelectBox");
					if (select) {
						const label = select.querySelector(".select-label");
						const items = select.querySelectorAll(".select-item");
						items.forEach(item => {
							if (item.dataset.value === value) {
								item.classList.add("active");
								if (label) label.textContent = item.textContent;
							}
						});
					}
					state.searchField = value;
				}

				// 날짜 필터
				if (key === "startDate" && startPicker) {
					startPicker.setDate(value, true);
					state.dateStart = value;
				}
				if (key === "endDate" && endPicker) {
					endPicker.setDate(value, true);
					state.dateEnd = value;
				}
			});

			// ===============================
			// 날짜 프리셋 버튼 (오늘/어제/최근7일/30일)
			// ===============================
			const presetButtons = container.querySelectorAll(".date-quick");

			presetButtons.forEach((btn, index) => {
				btn.addEventListener("click", () => {
					const range = btn.dataset.range; // today, yesterday, 7, 30
					const today = new Date();
					let start = new Date(), end = new Date();

					if (range === "yesterday") {
						start.setDate(today.getDate() - 1);
						end.setDate(today.getDate() - 1);
					} else if (range === "7") {
						start.setDate(today.getDate() - 7);
					} else if (range === "30") {
						start.setDate(today.getDate() - 30);
					} // today는 그대로

					const startStr = start.toISOString().slice(0, 10);
					const endStr = end.toISOString().slice(0, 10);

					// flatpickr UI 갱신
					if (startPicker && endPicker) {
						startPicker.setDate(startStr);
						endPicker.setDate(endStr);
					}

					// 상태 반영
					state.dateStart = startStr;
					state.dateEnd = endStr;
					state.quickRange = range;

					// 모든 preset 버튼 초기화 후 현재 버튼만 active
					presetButtons.forEach(b => b.classList.remove("active"));
					btn.classList.add("active");

					// URL 파라미터 갱신
					const url = new URL(window.location.href);
					const params = url.searchParams;

					params.set("startDate", startStr);
					params.set("endDate", endStr);
					params.set("preset", range); 

					window.location.href = url.pathname + "?" + params.toString();
				});
			});

			// ===============================
			// 프리셋 상태 복원 (URL에서 preset 파라미터 읽기)
			// ===============================
			const presetParam = params.get("preset");
			if (presetParam) {
				const matchedBtn = container.querySelector(`.date-quick[data-range='${presetParam}']`);
				if (matchedBtn) {
					matchedBtn.classList.add("active");
				}
			}

			// ===============================
			// 필터 버튼
			// ===============================
			container.querySelectorAll(".filter-btn").forEach(btn => {
				btn.addEventListener("click", () => {
					const key = btn.dataset.filter.trim();
					const value = btn.dataset.value;

					container.querySelectorAll(`.filter-btn[data-filter='${key}']`)
						.forEach(b => b.classList.remove("active"));

					btn.classList.add("active");
					state.filters[key] = value;
					dispatch(container);
				});
			});

			// ===============================
			// 검색 input
			// ===============================
			const searchInput = container.querySelector(".search-input");
			if (searchInput) {
				searchInput.addEventListener("input", () => {
					state.searchKeyword = searchInput.value;
				});
			}

			// ===============================
			// 검색조건 selectbox
			// ===============================
			const searchSelect = container.querySelector("#searchSelectBox");
			searchSelect?.addEventListener("selectChanged", e => {
				const label = e.detail.value;
				state.searchField = searchMap[label] || label;
			});

			// ===============================
			// 검색 버튼
			// ===============================
			const searchBtn = container.querySelector(".filter-submit");
			if (searchBtn) {
				searchBtn.addEventListener("click", () => {
					console.log("검색 버튼 클릭됨");
					dispatch(container, true);
				});
			}

			// ===============================
			// 초기화 버튼
			// ===============================
			const resetBtn = container.querySelector(".filter-reset");
			if (resetBtn) {
				resetBtn.addEventListener("click", () => {
					window.location.href = window.location.pathname;
				});
			}

			// ===============================
			// 상태 전송 (CustomEvent)
			// ===============================
			function dispatch(container, submit = false) {
				const event = new CustomEvent("filterChanged", {
					detail: { ...state, submit }
				});
				document.dispatchEvent(event);
			}
		});
	});

})();
