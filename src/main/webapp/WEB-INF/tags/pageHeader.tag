<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="scriptless"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- ================================
     PageHeader 커스텀 태그

     속성(Props)
     • hasButton   : true | false   → 버튼 표시 여부
     • isSearch    : true | false   → 검색 결과 형태 여부
     • onlyText    : true | false   → 제목만 표시 여부
     • title       : 문자열 (페이지 제목)
     • description : 문자열 (페이지 설명)

     사용법 예시
     <%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
     <my:pageHeader 
       hasButton="true"
       title="페이지명"
       description="해당 페이지 설명" />
================================ --%>

<%@ attribute name="hasButton" required="false"%>
<%@ attribute name="isSearch" required="false"%>
<%@ attribute name="onlyText" required="false"%>
<%@ attribute name="title" required="false"%>
<%@ attribute name="description" required="false"%>

<c:set var="hasButton" value="${empty hasButton ? 'false' : hasButton}" />
<c:set var="isSearch" value="${empty isSearch ? 'false' : isSearch}" />
<c:set var="onlyText" value="${empty onlyText ? 'false' : onlyText}" />
<c:set var="title" value="${empty title ? ' ' : title}" />
<c:set var="description" value="${empty description ? '' : description}" />

<div
	class="page-header 
            ${isSearch eq 'true' ? 'search-mode' : ''} 
            ${onlyText eq 'true' ? 'text-only' : ''}">

	<!-- 검색 결과 모드 -->
	<c:if test="${isSearch eq 'true'}">
		<h2>
			<span class="highlight">${title}</span>에 대한 검색 결과
		</h2>
	</c:if>

	<!-- 텍스트만 모드 -->
	<c:if test="${onlyText eq 'true'}">
		<h2>${title}</h2>
	</c:if>

	<!-- 기본 모드 (버튼/설명 포함) -->
	<c:if test="${isSearch ne 'true' and onlyText ne 'true'}">
		<div class="header-content">
			<div class="title-group">
				<h2>${title}</h2>
				<c:if test="${not empty description}">
					<p class="description">${description}</p>
				</c:if>
			</div>
			<c:if test="${hasButton eq 'true'}">
				<button class="header-btn">당첨자 발표 보기</button>
			</c:if>
		</div>
	</c:if>
</div>
