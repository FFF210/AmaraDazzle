<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="scriptless"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- ================================
    Alert 커스텀 태그

    속성(Props)
    • type    : error | warning | success | info
    • title   : 메시지 타이틀 (선택)
    • message : 메시지 내용
    
    사용법 예시
    <%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
    <my:alert type="warning" message="메시지 내용 최대 1줄" />
	<my:alert type="success" title="성공!" message="요청이 정상 처리되었습니다." />
================================ --%>

<%@ attribute name="type" required="true"%>
<%@ attribute name="title" required="false"%>
<%@ attribute name="message" required="true"%>

<div class="alert alert--${type}">
  <div class="alert-icon">
    <c:choose>
      <c:when test="${type eq 'error'}"><i class="bi bi-x-circle-fill"></i></c:when>
      <c:when test="${type eq 'warning'}"><i class="bi bi-exclamation-triangle-fill"></i></c:when>
      <c:when test="${type eq 'success'}"><i class="bi bi-check-circle-fill"></i></c:when>
      <c:when test="${type eq 'info'}"><i class="bi bi-info-circle-fill"></i></c:when>
    </c:choose>
  </div>
  <div class="alert-content">
    <c:if test="${not empty title}">
      <div class="alert-title">${title}</div>
    </c:if>
    <div class="alert-message">${message}</div>
  </div>
</div>
