<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- ================================
     TextArea 커스텀 태그

     속성(Props)
     • state     : default | error
     • name      : textarea name 속성
     • value     : 초기 값
     • placeholder : placeholder 텍스트
     • errorText : 에러 메시지
     • id        : textarea id (label 연결용)
     • readonly  : true | false
     • maxLength : 최대 글자 수 (숫자, 선택)
     • showCount : true | false (기본 false, 글자수 카운트 표시 여부)
     
     사용법 예시
     <!-- 일반 -->
	 <my:textArea name="desc" placeholder="내용을 입력하세요" />

	 <!-- 에러 상태 -->
	 <my:textArea state="error" errorText="내용을 입력해주세요." />

	 <!-- 읽기 전용 -->
	 <my:textArea name="readonlyDesc" value="수정할 수 없는 내용" readonly="true" />

	 <!-- 글자수 카운트 -->
	 <my:textArea name="comment" placeholder="댓글 입력" maxLength="200" showCount="true" />
================================ --%>

<%@ attribute name="state" required="false"%>
<%@ attribute name="name" required="false"%>
<%@ attribute name="value" required="false"%>
<%@ attribute name="placeholder" required="false"%>
<%@ attribute name="errorText" required="false"%>
<%@ attribute name="id" required="false"%>
<%@ attribute name="readonly" required="false"%>
<%@ attribute name="maxLength" required="false"%>
<%@ attribute name="showCount" required="false"%>

<c:set var="state" value="${empty state ? 'default' : state}" />
<c:set var="id" value="${empty id ? name : id}" />
<c:set var="showCount" value="${empty showCount ? 'false' : showCount}" />

<div class="text-area-wrapper state--${state}">
	<textarea 
		id="${id}" 
		name="${name}" 
		class="text-area"
		placeholder="${placeholder}"
		<c:if test="${not empty readonly and readonly eq 'true'}">readonly</c:if>
		<c:if test="${not empty maxLength}">maxlength="${maxLength}"</c:if>
	>${value}</textarea>

	<c:if test="${state eq 'error' and not empty errorText}">
		<span class="text-area-error">${errorText}</span>
	</c:if>

	<c:if test="${showCount eq 'true' and not empty maxLength}">
		<span class="text-area-counter" data-for="${id}">0 / ${maxLength}</span>
	</c:if>
</div>

<script>
  document.addEventListener("DOMContentLoaded", () => {
    document.querySelectorAll(".text-area-counter").forEach(counter => {
      const id = counter.dataset.for;
      const textarea = document.getElementById(id);
      if (!textarea) return;

      const updateCount = () => {
        counter.textContent = textarea.value.length + " / " + textarea.maxLength;
      };
      textarea.addEventListener("input", updateCount);
      updateCount(); // 초기값 반영
    });
  });
</script>
