<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="scriptless"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%-- ================================
    DateInput 커스텀 태그 (text + icon + 달력 위젯)

    속성(Props)
    • type    : input | preset (필수)
    • name    : input name (type=input일 때 필수)
    • value   : 초기값 (기본값 "")
    • input   : 초기값 (기본값 "start")
    • presets : 프리셋 버튼 목록 (쉼표 구분, type=preset일 때 필수)

    사용법 예시
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
	<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
    <my:dateInput type="input" name="startDate" value="2025-09-02" />
    <my:dateInput type="input" name="endDate" value="2025-09-20" input="end" />
    <my:dateInput type="preset" presets="오늘,어제,최근 7일,최근 30일" />
    
    <!-- <div class="filter_box"> 를 꼭 씌워주세요 --> 
    <div class="filter_box"> 
		<my:dateInput type="input" name="startDate" value="2025-09-02" />
		<span> - </span>
		<my:dateInput type="input" name="endDate" value="2025-09-20" inputDay="end"/>
		<my:dateInput type="preset" presets="오늘,어제,최근 7일,최근 30일" />
	</div>
================================ --%>

<%@ attribute name="type" required="true"%>
<%@ attribute name="name" required="false"%>
<%@ attribute name="value" required="false"%>
<%@ attribute name="presets" required="false"%>
<%@ attribute name="inputDay" required="false"%>
<%@ attribute name="id" required="false"%>

<c:set var="value" value="${empty value ? '' : value}" />
<c:set var="presetList"
	value="${empty presets ? '' : fn:split(presets, ',')}" />
<c:set var="inputDay" value="${empty inputDay ? 'start' : inputDay}" />

<div class="date-input">
	<!-- Input 타입 -->
	<c:if test="${type eq 'input'}">
		<div class="input-wrapper">
			<input type="text" name="${name}" value="${value}" class="date-text ${inputDay}_date" placeholder="YYYY-MM-DD" readonly />
			<button type="button" class="calendar-icon-wrapper">
				<i class="bi bi-calendar4 calendar-icon"></i>
			</button>
		</div>
	</c:if>

	<!-- Preset 버튼 타입 -->
	<c:if test="${type eq 'preset'}">
		<div class="preset-buttons">
			<c:forEach var="preset" items="${presetList}" varStatus="st">
				<button type="button" class="preset-btn ">${preset}</button>
			</c:forEach>
		</div>
	</c:if>
</div>

<script>
	const today = new Date();
	const offset = today.getTimezoneOffset() * 60000;
	const local = new Date(today.getTime() - offset);
	
	//endDate 오늘날짜로 자동 세팅 
	function settingToday() {
		let end = document.querySelectorAll(".end_date");
		for(let i = 0; i < end.length; i++) {
			end[i].value = local.toISOString().split("T")[0]; //첫 접속시 기간설정 endtdate 오늘로 세팅
		}
	}

	document.addEventListener("DOMContentLoaded", () => {
		settingToday();
		
	  	document.querySelectorAll(".date-input .input-wrapper").forEach(wrapper => {
	    const input = wrapper.querySelector(".date-text");
	    const iconBtn = wrapper.querySelector(".calendar-icon-wrapper");

	    if (input) {
	      // flatpickr 달력 연결
	      const fp = flatpickr(input, {
	        dateFormat: "Y-m-d",
	        allowInput: false,
	        onChange: function (selectedDates, dateStr, instance) {
	          if (input.classList.contains("end_date")) {
	            const to_day = new Date();
	            to_day.setHours(0, 0, 0, 0);

	            const pickedDate = selectedDates[0];
	            if (pickedDate) {
	              pickedDate.setHours(0, 0, 0, 0);

	              if (pickedDate > to_day) {
	                alert("기간의 마지막은 오늘 이후의 날짜를 선택할 수 없습니다.");
	                instance.clear(); // 잘못 선택한 날짜 지우기
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

</script>
