<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="scriptless" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- ================================
     RecommendationSectionTitle 커스텀 태그
     
     속성(Props)
     • title   : 섹션 제목 (필수)
     • linkUrl : "더보기" 버튼의 이동 경로 (기본값 "#")

     특징
     • 기본값으로 제목은 "제목", linkUrl은 "#" 사용
     • 섹션 타이틀과 "더보기" 링크를 한 줄로 구성

     사용법 예시
     <%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
     <my:recommendationSectionTitle 
       title="RecommendationSection" 
       linkUrl="/recommendations" />
================================ --%>

<%@ attribute name="title" required="false" %>
<%@ attribute name="linkUrl" required="false" %>

<c:set var="title" value="${empty title ? '제목' : title}" />
<c:set var="linkUrl" value="${empty linkUrl ? '#' : linkUrl}" />

<div class="recommendation-section-title">
  <h2 class="title">${title}</h2>
  <a href="${linkUrl}" class="more">더보기 <span>&gt;</span></a>
</div>
