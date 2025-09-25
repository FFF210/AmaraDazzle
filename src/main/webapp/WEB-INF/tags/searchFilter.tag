<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="empty" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- ================================
     SearchFilter 커스텀 태그

     사용법 예시
     <%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
     <my:searchFilter />

     <script>
       document.addEventListener("filterChanged", (e) => {
         console.log("필터 그룹:", e.detail.group);
         console.log("선택된 값:", e.detail.selected);
       });
     </script>
================================ --%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/filter.css" />

<div class="search-filter">
  <%-- 혜택 그룹 --%>
  <div class="filter-group">
    <div class="filter-label">혜택</div>
    <div class="filter-options">
      <button class="filter-option" data-value="SALE">세일상품</button>
      <button class="filter-option" data-value="EVENT">기획상품</button>
    </div>
  </div>

  <%-- 주요기능 그룹 --%>
  <div class="filter-group">
    <div class="filter-label">주요기능</div>
    <div class="filter-options">
      <button class="filter-option" data-value="ATOPIC">아토피</button>
      <button class="filter-option" data-value="CALM">진정</button>
      <button class="filter-option" data-value="MINERAL_UV">무기자차</button>
      <button class="filter-option" data-value="ACNE">여드름</button>
      <button class="filter-option" data-value="WHITENING">미백/잡티</button>
      <button class="filter-option" data-value="SEBUM">피지/블랙헤드</button>
      <button class="filter-option" data-value="DEADSKIN">각질</button>
      <button class="filter-option" data-value="DARKCIRCLE">다크서클</button>
      <button class="filter-option" data-value="PORE">모공</button>
      <button class="filter-option" data-value="REDNESS">홍조</button>
      <button class="filter-option" data-value="ANTIAGING">슬로우에이징</button>
      <button class="filter-option" data-value="HYDRATION">피부보습/속건조</button>
      <button class="filter-option" data-value="SUNBLOCK">자외선차단</button>
      <button class="filter-option" data-value="NONE">해당없음</button>
    </div>
  </div>

  <%-- 피부타입 그룹 --%>
  <div class="filter-group">
    <div class="filter-label">피부타입</div>
    <div class="filter-options">
      <button class="filter-option" data-value="DRY">건성</button>
      <button class="filter-option" data-value="OILY">지성</button>
      <button class="filter-option" data-value="NORMAL">중성</button>
      <button class="filter-option" data-value="SENSITIVE">민감성</button>
      <button class="filter-option" data-value="COMBINATION">복합성</button>
      <button class="filter-option" data-value="DEHYDRATED_OILY">수부지</button>
    </div>
  </div>

  <%-- 퍼스널컬러 그룹 --%>
  <div class="filter-group">
    <div class="filter-label">퍼스널컬러</div>
    <div class="filter-options">
      <button class="filter-option" data-value="SPRING_WARM">봄웜톤</button>
      <button class="filter-option" data-value="SUMMER_COOL">여름쿨톤</button>
      <button class="filter-option" data-value="AUTUMN_WARM">가을웜톤</button>
      <button class="filter-option" data-value="WINTER_COOL">겨울쿨톤</button>
      <button class="filter-option" data-value="UNKNOWN">잘 모르겠어요</button>
    </div>
  </div>
</div>

<script>
  document.addEventListener("DOMContentLoaded", () => {
    document.querySelectorAll(".filter-option").forEach(btn => {
      btn.addEventListener("click", () => {
        const groupEl = btn.closest(".filter-group");
        const group = groupEl.querySelector(".filter-label").textContent.trim();

        if (group === "혜택") {
          // 단일 선택 (재클릭 시 해제)
          if (btn.classList.contains("active")) {
            btn.classList.remove("active");
          } else {
            groupEl.querySelectorAll(".filter-option").forEach(el => el.classList.remove("active"));
            btn.classList.add("active");
          }
        } else {
          // 나머지 그룹은 다중 선택 가능
          btn.classList.toggle("active");
        }

        // 선택된 ENUM 값 배열
        const selected = Array.from(
          groupEl.querySelectorAll(".filter-option.active")
        ).map(el => el.dataset.value);

        // 부모로 이벤트 전달
        const event = new CustomEvent("filterChanged", {
          detail: {
            group: group,       // 예: "혜택"
            selected: selected  // 예: [] 또는 ["SALE"]
          }
        });
        document.dispatchEvent(event);
      });
    });
  });
</script>
