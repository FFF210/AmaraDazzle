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
	 <form class="search_form" id="noticeSellerSearch">
		<my:adminTableFilter >
			<my:adminFilterPeriod title="작성일"/>
			<my:adminFilterMiddle filters=""/>
			<my:adminFilterType optList="상품명,카테고리" initial="" name=""/>
			<my:adminFilterCate large="${ss}" />
			<my:adminFilterTotal searchItems="상품명,카테고리"/>
		</my:adminTableFilter>
	</form>
================================ --%>

<div class="search_container">
	<div class="table-filter filter">
		<jsp:doBody />
	</div>
	<div class="filter-actions btn_box ">
		<input type="submit" class="btn first_btn" id="searchBtn" value="검색" />
		<input type="reset" class="btn second_btn" value="초기화" />
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
