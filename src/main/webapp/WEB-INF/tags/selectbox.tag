<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="scriptless" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- ================================
    Selectbox 커스텀 태그

    속성(Props)
    • size  : sm | md | lg (기본값 md)
    • items : 쉼표(,)로 구분된 항목 목록 (예: "item1,item2,item3")

    사용법 예시
    <%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
    <my:selectbox 
      size="lg" 
      items="추천순,인기순,최신순,낮은가격순,높은가격순" />

    <script>
      document.addEventListener("selectChanged", (e) => {
        console.log("선택된 값:", e.detail.value); // 실제 값
        console.log("선택된 텍스트:", e.detail.text); // 표시되는 텍스트
      });
    </script>
================================ --%>

<%@ attribute name="size" required="false" %>
<%@ attribute name="items" required="false" %>

<%-- 기본값 처리 --%>
<c:set var="size" value="${empty size ? 'md' : size}" />
<c:set var="items" value="${empty items ? 'item1,item2,item3' : items}" />
<c:set var="itemList" value="${fn:split(items, ',')}" />

<div class="custom-select ${size}" tabindex="0">
  <div class="select-header">
    <span class="select-label">${itemList[0]}</span> <%-- 기본값: 첫번째 항목 --%>
    <i class="bi bi-chevron-down"></i>
  </div>
  <ul class="select-list">
    <c:forEach var="it" items="${itemList}">
      <li class="select-item" data-value="${it}">${it}</li>
    </c:forEach>
  </ul>
</div>

<script>
  document.addEventListener("DOMContentLoaded", () => {
    document.querySelectorAll(".custom-select").forEach(select => {
      const header = select.querySelector(".select-header");
      const label = select.querySelector(".select-label");
      const list = select.querySelector(".select-list");

      // 드롭다운 열기/닫기
      header.addEventListener("click", () => {
        select.classList.toggle("open");
      });

      // 아이템 선택
      list.querySelectorAll(".select-item").forEach(item => {
        item.addEventListener("click", () => {
          const value = item.dataset.value;
          const text = item.textContent;

          // 라벨 변경
          label.textContent = text;
          select.classList.remove("open");

          // 부모로 이벤트 전달
          const event = new CustomEvent("selectChanged", {
            detail: { value: value, text: text }
          });
          document.dispatchEvent(event);
        });
      });

      // 포커스 아웃 시 닫기
      select.addEventListener("blur", () => {
        select.classList.remove("open");
      });
    });
  });
</script>
