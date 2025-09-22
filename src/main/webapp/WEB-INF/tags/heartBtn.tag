<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="scriptless" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- ================================
     HeartBtn 커스텀 태그
     
     속성(Props)
     • state    : default | active  → 아이콘 상태 (빈하트 / 빨간하트)
     • onlyIcon : true | false      → 아이콘만 표시 (테두리 없는 스타일)
     • hasCount : true | false      → 좋아요 숫자 표시 여부
     • count    : 숫자 (기본값 0)

     사용법 예시
     <%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
     <my:heartBtn 
       state="active" 
       onlyIcon="false" 
       hasCount="true" 
       count="500" />
================================ --%>

<%@ attribute name="state" required="false" %>
<%@ attribute name="onlyIcon" required="false" %>
<%@ attribute name="hasCount" required="false" %>
<%@ attribute name="count" required="false" %>

<c:set var="state" value="${empty state ? 'default' : state}" />
<c:set var="onlyIcon" value="${empty onlyIcon ? 'false' : onlyIcon}" />
<c:set var="hasCount" value="${empty hasCount ? 'false' : hasCount}" />
<c:set var="count" value="${empty count ? '0' : count}" />

<button class="heart-btn 
               ${onlyIcon eq 'true' ? 'icon-only' : 'with-border'} 
               ${hasCount eq 'true' ? 'with-count' : ''}">

  <i class="bi ${state eq 'active' ? 'bi-heart-fill active' : 'bi-heart'}"></i>

  <c:if test="${hasCount eq 'true'}">
    <span class="count">${count}</span>
  </c:if>
</button>

<script>
  document.addEventListener("DOMContentLoaded", () => {
    document.querySelectorAll(".heart-btn").forEach(btn => {
      btn.addEventListener("click", () => {
        const icon = btn.querySelector("i");

        // 아이콘 상태 토글
        if (icon.classList.contains("active")) {
          icon.classList.remove("active", "bi-heart-fill");
          icon.classList.add("bi-heart");
        } else {
          icon.classList.remove("bi-heart");
          icon.classList.add("bi-heart-fill", "active");
        }

        // 카운트도 같이 변경 (옵션)
        const countEl = btn.querySelector(".count");
        if (countEl) {
          let count = parseInt(countEl.textContent, 10);
          if (icon.classList.contains("active")) {
            count++;
          } else {
            count--;
          }
          countEl.textContent = count;
        }

        // 부모 페이지로 이벤트 전달
        const event = new CustomEvent("heartToggled", {
          detail: { active: icon.classList.contains("active") }
        });
        document.dispatchEvent(event);
      });
    });
  });
</script>
