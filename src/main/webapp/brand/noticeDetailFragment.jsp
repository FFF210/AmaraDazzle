<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>

<c:choose>
  <c:when test="${not empty notice}">
    <div class="notice-detail-header">
      <my:tag 
        color="${notice.typeName eq '시스템' ? 'green' : (notice.typeName eq '이벤트' ? 'blue' : 'gray')}" 
        size="sm" text="${notice.typeName}" />
      <span class="notice-title">${notice.title}</span>
      <span class="notice-date">
        <fmt:formatDate value="${notice.createdAt}" pattern="yyyy-MM-dd" />
      </span>
    </div>

    <div class="notice-detail-body">${notice.content}</div>

    <c:if test="${not empty notice.docFileId}">
      <div class="notice-attachments">
        <a href="/upload/${notice.docFileId}" download>첨부파일 다운로드</a>
      </div>
    </c:if>
  </c:when>

  <c:otherwise>
    <p>공지사항을 불러올 수 없습니다.</p>
  </c:otherwise>
</c:choose>
