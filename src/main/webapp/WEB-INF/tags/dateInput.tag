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
			<input type="text" name="${name}" id="${id}" value="${value}" class="date-text ${inputDay}_date" placeholder="YYYY-MM-DD" readonly />
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
// tagjs > dateInput.js 파일 따로 연결해서 사용해주세요 
</script>
