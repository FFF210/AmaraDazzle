<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="scriptless"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<%-- ================================
    TableFilter 커스텀 태그

    속성(Props)
    • filters : 
      예) "결제 상태:결제 대기|결제 완료|결제 실패|취소 요청|결제 취소,
           배송 상태:배송 준비중|배송중|배송 완료|반품 요청|반품 완료"
      (쉼표로 줄 구분, label:옵션1|옵션2|옵션3)
    • hasSearch   : true | false (기본 true)
    • searchItems : "상품코드,상품명,카테고리"
    
    사용법 예시
    <%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
    <my:tableFilter
			filters="결제 상태:결제 대기|결제 완료|결제 실패|취소 요청|결제 취소,
           			 배송 상태:배송 준비중|배송중|배송 완료|반품 요청|반품 완료"
			searchItems="상품코드,상품명,카테고리" />
================================ --%>

<%@ attribute name="filters" required="false"%>
<%@ attribute name="hasSearch" required="false"%>
<%@ attribute name="searchItems" required="false"%>

<c:set var="hasSearch" value="${empty hasSearch ? 'true' : hasSearch}" />
<c:set var="searchItems"
	value="${empty searchItems ? '상품코드,상품명' : searchItems}" />

<div class="table-filter">

	<!-- 날짜 필터 -->
	<div class="filter-row date-row">
		<label>기간:</label>
		<my:dateInput type="input" name="startDate" value="2025-09-02" />
		<span>~</span>
		<my:dateInput type="input" name="endDate" value="2025-09-02" />
		<div class="margin"></div>
		<my:dateInput type="preset" presets="오늘,어제,최근 7일,최근 30일" />
	</div>

	<!-- 중간 필터 -->
	<c:if test="${not empty filters}">
		<c:set var="filterLines" value="${fn:split(filters, ',')}" />
		<c:forEach var="line" items="${filterLines}">
			<c:set var="parts" value="${fn:split(line, ':')}" />
			<c:set var="label" value="${parts[0]}" />
			<c:set var="options" value="${fn:split(parts[1], '|')}" />

			<div class="filter-row">
				<label>${label}:</label>
				<div class="filter-btn-group">
					<c:forEach var="opt" items="${options}">
						<button type="button" class="filter-btn" data-filter="${label}"
							data-value="${opt}">${opt}</button>
					</c:forEach>
				</div>
			</div>
		</c:forEach>
	</c:if>

	<!-- 검색 영역 -->
	<c:if test="${hasSearch eq 'true'}">
		<div class="filter-row search-row">
			<my:selectbox size="md" items="${searchItems}" />
			<my:textInput type="search" name="keyword" placeholder="검색어 입력"
				size="sm" />
		</div>
	</c:if>

	<!-- 버튼 (button.css 파일 import 필수) -->
	<div class="filter-actions">
		<button type="button" class="btn btn-primary btn-md tableFilter">검색</button>
		<button type="button" class="btn btn-outline btn-md tableFilter">설정
			초기화</button>
	</div>
</div>

<script>
document.addEventListener("DOMContentLoaded", () => {
  const container = document.currentScript.closest(".table-filter");

  const state = {
    dateStart: "",
    dateEnd: "",
    quickRange: "",
    filters: {},  // {결제 상태: "결제 대기", 배송 상태: "배송중"}
    searchField: "",
    searchKeyword: ""
  };

  // 날짜 빠른 선택
  container.querySelectorAll(".date-quick").forEach(btn => {
    btn.addEventListener("click", () => {
      const range = btn.dataset.range;
      const today = new Date();
      let start = new Date(), end = new Date();

      if(range === "today") {
        // 오늘
      } else if(range === "yesterday") {
        start.setDate(today.getDate()-1);
        end.setDate(today.getDate()-1);
      } else {
        start.setDate(today.getDate() - parseInt(range));
      }

      state.dateStart = start.toISOString().slice(0,10);
      state.dateEnd = end.toISOString().slice(0,10);

      container.querySelector(".date-start").value = state.dateStart;
      container.querySelector(".date-end").value = state.dateEnd;

      state.quickRange = range;
      dispatch();
    });
  });

  // 필터 버튼 (toggle)
  container.querySelectorAll(".filter-btn").forEach(btn => {
    btn.addEventListener("click", () => {
      const key = btn.dataset.filter;
      const value = btn.dataset.value;

      container.querySelectorAll(`[data-filter='${key}']`)
               .forEach(b => b.classList.remove("active"));

      btn.classList.add("active");
      state.filters[key] = value;
      dispatch();
    });
  });

  // 검색 input
  const searchInput = container.querySelector(".search-input");
  if(searchInput){
    searchInput.addEventListener("input", () => {
      state.searchKeyword = searchInput.value;
    });
  }

  // selectbox 이벤트 수신
  document.addEventListener("selectChanged", (e) => {
    state.searchField = e.detail.value;
  });

  // 검색 버튼
  container.querySelector(".filter-submit").addEventListener("click", () => {
    dispatch(true); // submit 이벤트
  });

  // 초기화 버튼
  container.querySelector(".filter-reset").addEventListener("click", () => {
    container.querySelectorAll("input, .active").forEach(el => {
      if(el.tagName === "INPUT") el.value = "";
      el.classList.remove("active");
    });
    state.dateStart = "";
    state.dateEnd = "";
    state.quickRange = "";
    state.filters = {};
    state.searchField = "";
    state.searchKeyword = "";
    dispatch();
  });

  // 부모로 이벤트 전달
  function dispatch(submit=false){
    const event = new CustomEvent("filterChanged", {
      detail: {...state, submit}
    });
    document.dispatchEvent(event);
  }
});
</script>
