<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="scriptless"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%-- ================================
     CategoryFilter 커스텀 태그

     속성(Props)
     • categories : 카테고리 목록 (쉼표 구분 문자열)
     • columns    : 한 줄에 표시할 카테고리 개수 (기본값 5)

     사용법 예시
     <%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
     <my:categoryFilter 
       categories="스킨케어,메이크업,헤어,바디,향수,남성"
       columns="6" />

     <script>
       document.addEventListener("categorySelected", (e) => {
         alert("선택한 카테고리: " + e.detail.category);
         // 여기서 AJAX 요청이나 페이지 이동 등 원하는 동작 수행 가능
       });
     </script>
================================ --%>

<%@ attribute name="categories" required="false"%>
<%@ attribute name="columns" required="false"%>
<%@ attribute name="selected" required="false"%>
<%-- 현재 선택된 카테고리 --%>

<%-- 기본값 처리 --%>
<c:set var="categories"
	value="${empty categories ? 'category1,category2,category3,category4,category5,category6,category7' : categories}" />

<%-- 문자열 → 배열 변환 --%>
<c:set var="categoryList" value="${fn:split(categories, ',')}" />

<c:set var="columns" value="${empty columns ? 5 : columns}" />
<c:set var="columns" value="${columns + 0}" />
<%-- 숫자로 변환 --%>
<c:set var="count" value="${fn:length(categoryList)}" />
<c:set var="remain" value="${count % columns}" />
<c:set var="emptyCount" value="${remain == 0 ? 0 : columns - remain}" />

<div class="category-filter">
	<c:forEach var="cat" items="${categoryList}">
		<c:set var="catTrim" value="${fn:trim(cat)}" />
		<button
			class="category-item ${fn:trim(selected) eq catTrim ? 'selected' : ''}"
			data-category="${catTrim}">${catTrim}</button>
	</c:forEach>

	<!-- 빈 칸 채우기 -->
	<c:forEach var="i" begin="1" end="${emptyCount}" step="1">
		<div class="category-item empty"></div>
	</c:forEach>
</div>

<script>
document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll(".category-item").forEach(btn => {
    btn.addEventListener("click", () => {
      if (btn.classList.contains("empty")) return;
      const selected = btn.dataset.category;
      location.href = "categoryList.jsp?category=" + encodeURIComponent(selected);

      // 기존 선택 해제
      document.querySelectorAll(".category-item").forEach(b => b.classList.remove("selected"));
      // 현재 버튼만 선택
      btn.classList.add("selected");

      // 부모 페이지에 이벤트 전달
      const event = new CustomEvent("categorySelected", { detail: { category: selected }});
      document.dispatchEvent(event);
    });
  });
});
</script>
