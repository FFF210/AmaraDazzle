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
    • presets : 프리셋 버튼 목록 (쉼표 구분, type=preset일 때 필수)

    사용법 예시
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
	<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
    <my:dateInput type="input" name="startDate" value="2025-09-02" />
    <my:dateInput type="preset" presets="오늘,어제,최근 7일,최근 30일" />
================================ --%>

<%@ attribute name="type" required="true"%>
<%@ attribute name="name" required="false"%>
<%@ attribute name="value" required="false"%>
<%@ attribute name="id" required="false"%>
<%@ attribute name="presets" required="false"%>

<c:set var="value" value="${empty value ? '' : value}" />
<c:set var="presetList"
	value="${empty presets ? '' : fn:split(presets, ',')}" />
<c:set var="id" value="${empty id ? '' : id}" />

<div class="date-input">
	<!-- Input 타입 -->
	<c:if test="${type eq 'input'}">
		<div class="input-wrapper">
			<input type="text" name="${name}" id="${id}" value="${value}" class="date-text"
				placeholder="YYYY-MM-DD" readonly />
			<button type="button" class="calendar-icon-wrapper">
				<i class="bi bi-calendar4 calendar-icon"></i>
			</button>
		</div>
	</c:if>

	<!-- Preset 버튼 타입 -->
	<c:if test="${type eq 'preset'}">
		<div class="preset-buttons">
			<c:forEach var="preset" items="${presetList}" varStatus="st">
				<button type="button" class="preset-btn ${st.first ? 'active' : ''}">
					${preset}</button>
			</c:forEach>
		</div>
	</c:if>
</div>

<script>
  document.addEventListener("DOMContentLoaded", () => {
    document.querySelectorAll(".date-input .input-wrapper").forEach(wrapper => {
      const input = wrapper.querySelector(".date-text");
      const iconBtn = wrapper.querySelector(".calendar-icon-wrapper");

      if(input){
        // flatpickr 달력 연결
        const fp = flatpickr(input, {
          dateFormat: "Y-m-d",
          allowInput: false
        });

        // 아이콘 클릭 시 달력 열기
        if(iconBtn){
          iconBtn.addEventListener("click", () => fp.open());
        }
      }
    });

    // 프리셋 버튼 클릭 이벤트
    document.querySelectorAll(".date-input .preset-btn").forEach(btn => {
      btn.addEventListener("click", () => {
        const parent = btn.closest(".date-input");
        const input = document.querySelector(".date-input .date-text"); // 첫 번째 input 기준 (필요 시 조정)

        parent.querySelectorAll(".preset-btn").forEach(b => b.classList.remove("active"));
        btn.classList.add("active");

        // 오늘 날짜 기준으로 값 계산
        const today = new Date();
        let targetDate = new Date(today);

        switch(btn.textContent.trim()){
          case "오늘":
            break;
          case "어제":
            targetDate.setDate(today.getDate() - 1);
            break;
          case "최근 7일":
            targetDate.setDate(today.getDate() - 7);
            break;
          case "최근 30일":
            targetDate.setDate(today.getDate() - 30);
            break;
        }

        // YYYY-MM-DD 포맷
        const y = targetDate.getFullYear();
        const m = String(targetDate.getMonth() + 1).padStart(2, "0");
        const d = String(targetDate.getDate()).padStart(2, "0");
        const formatted = `${y}-${m}-${d}`;

        if(input){
          input.value = formatted;
        }

        // 부모 페이지로 이벤트 전달
        const event = new CustomEvent("datePresetSelected", {
          detail: { value: btn.textContent.trim(), date: formatted }
        });
        document.dispatchEvent(event);
      });
    });
  });
</script>
