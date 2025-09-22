<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="scriptless" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- ================================
     EventCard 커스텀 태그
     
     속성(Props)
     • imageUrl   : 이벤트 배너 이미지 URL
     • title      : 이벤트 제목
     • startDate  : 이벤트 시작일 (yyyy-mm-dd)
     • endDate    : 이벤트 종료일 (yyyy-mm-dd)

     사용법 예시
     <%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
     <my:eventCard 
       imageUrl="https://placehold.co/320x160"
       title="올영 뷰티 구매인증 리뷰 이벤트"
       startDate="2025-09-01"
       endDate="2025-09-31" />
================================ --%>

<%@ attribute name="imageUrl" required="false" %>
<%@ attribute name="title" required="false" %>
<%@ attribute name="startDate" required="false" %>
<%@ attribute name="endDate" required="false" %>

<c:set var="imageUrl" value="${empty imageUrl ? 'https://placehold.co/320x160' : imageUrl}" />
<c:set var="title" value="${empty title ? '이벤트 제목' : title}" />
<c:set var="startDate" value="${empty startDate ? '' : startDate}" />
<c:set var="endDate" value="${empty endDate ? '' : endDate}" />

<div class="event-card">
  <div class="event-image">
    <img src="${imageUrl}" alt="${title}" />
  </div>
  <div class="event-info">
    <p class="event-title">${title}</p>
    <p class="event-date">${startDate} - ${endDate}</p>
  </div>
</div>
