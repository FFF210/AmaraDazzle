<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="scriptless"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<link rel="stylesheet" href="./css/selectbox.css" />

<%-- ================================
     SortList 커스텀 태그

     속성(Props)
     • hasSelect : true | false → 우측에 select 박스 출력 여부

     사용법 예시
     <%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
     <my:sortList hasSelect="false" />

     <script>
       document.addEventListener("sortSelected", (e) => {
         alert("선택한 정렬: " + e.detail.sort);
       });
     </script>
================================ --%>

<%@ attribute name="hasSelect" required="false"%>
<c:set var="hasSelect" value="${empty hasSelect ? 'false' : hasSelect}" />

<div class="sort-list">
	<c:if test="${hasSelect ne 'true'}">
		<div class="sort-options">
			<button class="sort-item">인기순</button>
			<button class="sort-item">최근 등록순</button>
			<button class="sort-item">판매 수량순</button>
			<button class="sort-item">낮은 가격순</button>
			<button class="sort-item last">높은 가격순</button>
		</div>
	</c:if>

	<c:if test="${hasSelect eq 'true'}">
		<div class="sort-options">
			<button class="sort-item">별점 높은순</button>
			<button class="sort-item">별점 낮은순</button>
			<button class="sort-item last">최신순</button>
		</div>
		<my:selectbox size="sm" items="전체상품옵션" />
	</c:if>
</div>

<script>
  document.addEventListener("DOMContentLoaded", () => {
    const sortButtons = document.querySelectorAll(".sort-item");

    // 버튼 클릭 이벤트 처리
    sortButtons.forEach(btn => {
      btn.addEventListener("click", () => {
        sortButtons.forEach(b => b.classList.remove("selected"));
        btn.classList.add("selected");

        const event = new CustomEvent("sortSelected", {
          detail: { sort: btn.textContent.trim() }
        });
        document.dispatchEvent(event);
      });
    });
  });
</script>
