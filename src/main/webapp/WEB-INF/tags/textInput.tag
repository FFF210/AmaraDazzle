<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="empty" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- ================================
     TextInput 커스텀 태그

     속성(Props)
     • type      : default | password | preview | readOnly | search
     • state     : default | error
     • size      : sm | lg  
     • name      : input name 속성
     • value     : 초기 값
     • placeholder : placeholder 텍스트
     • errorText : 에러 메시지
     • id        : input id (label 연결용)
     
     사용법 예시
     <%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
     <my:textInput id="loginId" name="loginId" placeholder="아이디를 입력하세요" type="default" size="lg" state="default" />
     <my:textInput type="search" name="keyword" placeholder="검색어 입력" size="sm" />
================================ --%>

<%@ attribute name="type"        required="false" %>
<%@ attribute name="state"       required="false" %>
<%@ attribute name="size"        required="false" %>
<%@ attribute name="name"        required="false" %>
<%@ attribute name="value"       required="false" %>
<%@ attribute name="placeholder" required="false" %>
<%@ attribute name="errorText"   required="false" %>
<%@ attribute name="id"          required="false" %>

<c:set var="type" value="${empty type ? 'default' : type}" />
<c:set var="state" value="${empty state ? 'default' : state}" />
<c:set var="size" value="${empty size ? 'lg' : size}" />
<c:set var="id" value="${empty id ? name : id}" />

<div class="text-input-wrapper size--${size} state--${state}">
  <div class="text-input-inner ${type}">
    <input 
      type="${type eq 'password' ? 'password' : 'text'}"
      id="${id}"
      name="${name}"
      class="text-input ${type}"
      placeholder="${placeholder}"
      value="${value}"
      ${type eq 'readOnly' ? 'readonly' : ''} />

    <!-- 비밀번호 / preview 토글 -->
    <c:if test="${type eq 'password' or type eq 'preview'}">
      <button type="button" class="toggle-visibility">
        <i class="bi bi-eye"></i>
      </button>
    </c:if>

    <!-- 검색 -->
    <c:if test="${type eq 'search'}">
      <i class="bi bi-search search-icon"></i>
    </c:if>
  </div>

  <c:if test="${state eq 'error' and not empty errorText}">
    <span class="text-input-error">${errorText}</span>
  </c:if>
</div>

<script>
  document.addEventListener("DOMContentLoaded", () => {
    // 비밀번호 보이기 토글
    document.querySelectorAll(".text-input-wrapper .toggle-visibility")
      .forEach(btn => {
        btn.addEventListener("click", () => {
          const input = btn.closest(".text-input-inner").querySelector("input");
          const icon = btn.querySelector("i");
          if (input.type === "password") {
            input.type = "text";
            icon.classList.replace("bi-eye", "bi-eye-slash");
          } else {
            input.type = "password";
            icon.classList.replace("bi-eye-slash", "bi-eye");
          }
        });
      });
  });
</script>
