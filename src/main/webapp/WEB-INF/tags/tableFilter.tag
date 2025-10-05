<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="scriptless"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<%-- ================================
    TableFilter 커스텀 태그

    속성(Props)
    • filters : 예) "answerStatus|답변상태:ALL2=전체|PENDING=미답변|ANSWERED=답변완료" (쉼표로 줄 구분)
    • hasDate   : true | false (기본 true) 날짜 필터 여부
    • hasSearch   : true | false (기본 true) 검색 영역 여부
    • searchItems : "상품코드,상품명,카테고리"
    
    사용법 예시
    <%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
    <my:tableFilter
			filters="category|문의유형:ALL=전체|PRODUCT=상품|ORDER=주문|CANCEL=취소|REFUND=환불|EXCHANGE=교환|DELIVERY=배송, 
					answerStatus|답변상태:ALL2=전체|PENDING=미답변|ANSWERED=답변완료"
					hasDate="true" 
					searchItems="작성자" />
================================ --%>

<%@ attribute name="filters" required="false"%>
<%@ attribute name="hasDate" required="false"%>
<%@ attribute name="hasSearch" required="false"%>
<%@ attribute name="searchItems" required="false"%>

<c:set var="hasSearch" value="${empty hasSearch ? 'true' : hasSearch}" />
<c:set var="searchItems"
	value="${empty searchItems ? '-' : searchItems}" />

<div class="table-filter">

	<!-- 날짜 필터 -->
	<c:if test="${hasDate eq 'true'}">
	
		<div class="filter-row date-row">
			<label>기간:</label>
			<div class="filter_box">
				<!-- dateInput(type=input) 직접 코드 삽입 -->
				<div class="date-input">
					<div class="input-wrapper">
						<input type="text" name="startDate" class="date-text date-start" placeholder="YYYY-MM-DD" readonly />
						<button type="button" class="calendar-icon-wrapper">
							<i class="bi bi-calendar4 calendar-icon"></i>
						</button>
					</div>
				</div>

				<span>~</span>

				<div class="date-input">
					<div class="input-wrapper">
						<input type="text" name="endDate" class="date-text date-end" placeholder="YYYY-MM-DD" readonly />
						<button type="button" class="calendar-icon-wrapper">
							<i class="bi bi-calendar4 calendar-icon"></i>
						</button>
					</div>
				</div>

				<div class="margin"></div>

				<!-- dateInput(type=preset) 직접 코드 삽입 -->
				<div class="date-input">
					<div class="preset-buttons">
						<button type="button" class="preset-btn date-quick" data-range="today">오늘</button>
						<button type="button" class="preset-btn date-quick" data-range="yesterday">어제</button>
						<button type="button" class="preset-btn date-quick" data-range="7">최근 7일</button>
						<button type="button" class="preset-btn date-quick" data-range="30">최근 30일</button>
					</div>
				</div>
			</div>
		</div>
	</c:if>


	<!-- 중간 필터 -->
	<c:if test="${not empty filters}">
		<c:set var="filterLines" value="${fn:split(filters, ',')}" />
		<c:forEach var="line" items="${filterLines}">
			<c:set var="parts" value="${fn:split(line, ':')}" />
			<c:set var="keyAndLabel" value="${fn:split(parts[0], '|')}" />
			<c:set var="filterKey" value="${keyAndLabel[0]}" />
			<!-- 서버 전달용 -->
			<c:set var="label" value="${keyAndLabel[1]}" />
			<!-- 화면 노출용 -->
			<c:set var="options" value="${fn:split(parts[1], '|')}" />

			<div class="filter-row">
				<label>${label}:</label>
				<div class="filter-btn-group">
					<c:forEach var="opt" items="${options}">
						<c:set var="optParts" value="${fn:split(opt, '=')}" />
						<c:set var="optValue" value="${optParts[0]}" />
						<c:set var="optLabel" value="${optParts[1]}" />
						<button type="button" class="filter-btn"
							data-filter="${filterKey}" data-value="${optValue}">${optLabel}
						</button>
					</c:forEach>
				</div>

			</div>
		</c:forEach>
	</c:if>

	<!-- 검색 영역 -->
	<c:if test="${hasSearch eq 'true'}">
		<div class="filter-row search-row">
			<my:selectbox id="searchSelectBox" size="md" items="${searchItems}"
				initial="검색조건" />
			<my:textInput type="search" name="keyword" placeholder="검색어 입력"
				size="sm" />
		</div>
	</c:if>

	<!-- 버튼 (button.css 파일 import 필수) -->
	<div class="filter-actions">
		<button type="button" class="btn btn-primary btn-md filter-submit">검색</button>
		<button type="button" class="btn btn-outline btn-md filter-reset">설정
			초기화</button>
	</div>
</div>
