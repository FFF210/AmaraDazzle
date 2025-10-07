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
	
	<!-- 버튼 -->
	<div class="filter-actions btn_box ">
		<input type="submit" class="btn first_btn " value="검색" />
		<input type="button" class="btn second_btn filter-reset" value="초기화" />
	</div>
	<!-- 버튼 end -->
</div>


<script>
document.addEventListener("DOMContentLoaded", () => {
	//검색입력하지 않으면 URL에 미표시 
	document.querySelector(".search_form").addEventListener("submit", function(e) {
		this.querySelectorAll("input:not([type='hidden'])").forEach(el => {
		    if (el.value.trim() === "") {
		        el.disabled = true; //disabled처리하면 BE로 안날아감
		    }
		});
		this.querySelectorAll("input[type='hidden']").forEach(el => {
		    if (el.value.trim() === "") {
		    	el.removeAttribute('name');
		    }
		});
		
		
		//검색어 입력시 검색조건과 세트로 채워야 폼전송 
		const totalSearch = this.querySelector("input[name='totalSearch']");
		const keyword = this.querySelector("input[name='keyword']");

		// 통합 검색(totalSearch, keyword) 처리
		const hasTotalSearch = totalSearch.value.trim() !== "";
		const hasKeyword = keyword.value.trim() !== "";

		// 한쪽만 입력된 경우 막기
		if ((hasTotalSearch && !hasKeyword) || (!hasTotalSearch && hasKeyword)) {
			e.preventDefault();
			alert("검색어 입력시 검색 조건과 검색어를 모두 입력해야 합니다.");
			
			keyword.disabled=false;
			totalSearch.disabled=false;
		}
	});
	
	//middleFilter 선택
	document.querySelectorAll(".filter-btn-group").forEach(group => {
		const hidden = group.nextElementSibling;
		const val = hidden.value.trim();
		const matched = group.querySelector(".filter-btn[data-value='" + val + "']");
    	
	    // 검색 후 검색한 btn 유지 
	    if (hidden && hidden.value) {
	        if (matched) {
	            matched.classList.add("active");
	        }
	    } else {
	        // 값 없으면 기본 '전체'버튼 활성화
	        const firstBtn = group.querySelector(".filter-btn");
	        if (firstBtn) {
	            firstBtn.classList.add("active");
	            if (hidden) hidden.value = firstBtn.dataset.value;
	        }
	    }
	
	    // 버튼 클릭 이벤트
	    group.querySelectorAll(".filter-btn").forEach(btn => {
	        btn.addEventListener("click", () => {
	            const value = btn.dataset.value;
	
	            // hidden 값 갱신
	            if (hidden) hidden.value = value;
	
	            // active 표시 갱신
	            group.querySelectorAll(".filter-btn").forEach(b => b.classList.remove("active"));
	            btn.classList.add("active");
	        });
	    });
	});
	
	//검색시 hidden input에 value매핑 + 검색 후 select란 검색값 유지 
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
	
	//검색조건 초기화
	const form = document.querySelector(".search_form");
	const resetBtn = form.querySelector(".filter-reset");

	resetBtn.addEventListener("click", (e) => {
		e.preventDefault(); // 기본 reset 막기 

		// 모든 hidden input 초기화
		form.querySelectorAll("input[type='hidden'][name]").forEach(hidden => {
			hidden.value = "";
		});

		// 모든 custom-select 초기화 (라벨/active 되돌리기)
		form.querySelectorAll(".custom-select").forEach(select => {
			const label = select.querySelector(".select-label");
			const items = select.querySelectorAll(".select-item");

			// "검색조건" 같은 initial 값 가져오기
			const initial = select.getAttribute("data-initial");

			label.textContent = initial;
			items.forEach(li => li.classList.remove("active"));
		});

		// 일반 input(text) 초기화
		form.querySelectorAll("input[type='text']").forEach(input => {
			input.value = "";
		});
	});
});

</script>
