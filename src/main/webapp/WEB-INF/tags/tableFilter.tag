<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="scriptless"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<%-- ================================
    TableFilter 커스텀 태그

    속성(Props)
    • filters : 예) "판매상태:ALL=전체|SALE=판매중|SOLD_OUT=품절|STOP_SALE=판매중지" (쉼표로 줄 구분)
    • hasDate   : true | false (기본 true) 날짜 필터 여부
    • hasSearch   : true | false (기본 true) 검색 영역 여부
    • searchItems : "상품코드,상품명,카테고리"
    
    사용법 예시
    <%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
    <my:tableFilter
			filters="판매상태:ALL=전체|SALE=판매중|SOLD_OUT=품절|STOP_SALE=판매중지"
			searchItems="상품코드,상품명,카테고리" />
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
			<my:dateInput type="input" name="startDate" value="2025-09-02" />
			<span>~</span>
			<my:dateInput type="input" name="endDate" value="2025-09-02" />
			<div class="margin"></div>
			<my:dateInput type="preset" presets="오늘,어제,최근 7일,최근 30일" />
		</div>
	</c:if>

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
						<c:set var="optParts" value="${fn:split(opt, '=')}" />
						<c:set var="optValue" value="${optParts[0]}" />
						<c:set var="optLabel" value="${optParts[1]}" />
						<button type="button" class="filter-btn" data-filter="${label}"
							data-value="${optValue}">${optLabel}</button>
					</c:forEach>
				</div>
			</div>
		</c:forEach>
	</c:if>

	<!-- 검색 영역 -->
	<c:if test="${hasSearch eq 'true'}">
		<div class="filter-row search-row">
			<my:selectbox id="searchSelectBox" size="md" items="${searchItems}" initial="검색조건" />
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

<script>
(function(){
	const container = document.currentScript.previousElementSibling;
	
	if (!container) {
	    console.error("table-filter 컨테이너를 찾을 수 없음");
	    return;
	  }
	
	// URL → 상태 복원
	  window.addEventListener("DOMContentLoaded", () => {
	    const params = new URLSearchParams(window.location.search);

	    params.forEach((value, key) => {
	    	 // 필터 버튼 (status 등)
	        const btn = container.querySelector(`.filter-btn[data-filter='${key}'][data-value='${value}']`);
	        if (btn) {
	          btn.classList.add("active");
	          state.filters[key] = value;
	        }

	      // 검색창
	      if (key === "searchKeyword") {
	        const searchInput = container.querySelector(".search-input");
	        if (searchInput) searchInput.value = value;
	        state.searchKeyword = value;
	      }

	   // 검색조건 (셀렉트박스)
	      if (key === "searchType") {
	        const select = container.querySelector(".custom-select");
	        if (select) {
	          const label = select.querySelector(".select-label");
	          const items = select.querySelectorAll(".select-item");

	          items.forEach(item => {
	            if (item.dataset.value === value) {
	              if (label) label.textContent = item.textContent;
	              items.forEach(i => i.classList.remove("active"));
	              item.classList.add("active");
	            }
	          });
	        }
	        state.searchField = value;
	      }

	      // 날짜
	      if (key === "startDate") {
	        const start = container.querySelector(".date-start");
	        if (start) start.value = value;
	        state.dateStart = value;
	      }
	      if (key === "endDate") {
	        const end = container.querySelector(".date-end");
	        if (end) end.value = value;
	        state.dateEnd = value;
	      }
	    });
	  });

  const state = {
    dateStart: "",
    dateEnd: "",
    quickRange: "",
    filters: {},
    searchField: "",
    searchKeyword: ""
  };
  
  // 검색 매핑 
  const searchMap = {
    "상품명": "NAME",
    "카테고리": "CATEGORY",
    "주문자": "MEMBER",
    "주문상품명": "PRODUCT"
  };

  // 날짜 빠른 선택
  container.querySelectorAll(".date-quick")?.forEach(btn => {
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

      const startInput = container.querySelector(".date-start");
      const endInput = container.querySelector(".date-end");
      if(startInput) startInput.value = state.dateStart;
      if(endInput) endInput.value = state.dateEnd;

      state.quickRange = range;
      dispatch();
    });
  });

//필터 버튼 이벤트
  container.querySelectorAll(".filter-btn").forEach(btn => {
    btn.addEventListener("click", () => {
      // 공백 제거
      const key = btn.dataset.filter.trim();
      const value = btn.dataset.value;

      // 같은 그룹 버튼들 active 제거 (공백 제거해서 비교)
      container.querySelectorAll(".filter-btn").forEach(b => {
        if (b.dataset.filter.trim() === key) {
          b.classList.remove("active");
        }
      });

      // 클릭한 버튼에 active 추가
      btn.classList.add("active");

      // 상태 업데이트
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

  // selectbox 이벤트
  const searchSelect = container.querySelector("#searchSelectBox");
searchSelect?.addEventListener("selectChanged", (e) => {
  const label = e.detail.value;
  state.searchField = searchMap[label] || label;
});


  // 검색 버튼
  container.querySelector(".filter-submit")?.addEventListener("click", () => {
	  console.log("검색 버튼 클릭됨");
    dispatch(true);
  });

//초기화 버튼
  container.querySelector(".filter-reset")?.addEventListener("click", () => {
    // 상태 초기화 대신 URL 파라미터 제거 후 새로고침
    window.location.href = window.location.pathname;
  });

  function dispatch(submit=false){
	    const event = new CustomEvent("filterChanged", {
	      detail: {...state, submit}
	    });
	    document.dispatchEvent(event);
	  }
})();
</script>
