<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="scriptless"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<%-- ================================
     EventCard 커스텀 태그
     
     속성(Props)
     • thumbnailFileId   : 이벤트 배너 이미지 
     • title      : 이벤트 제목
     • startDate  : 이벤트 시작일 (yyyy-mm-dd)
     • endDate    : 이벤트 종료일 (yyyy-mm-dd)
     • status     : 이벤트 상태 (RECRUIT, ONGOING, FINISHED)
     • href       : 클릭 시 이동할 링크 (예: /store/productDetail?productId=...)

     사용법 예시
     <%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
     <my:eventCard 
       thumbnailFileId="https://placehold.co/320x160"
       title="올영 뷰티 구매인증 리뷰 이벤트"
       startDate="2025-09-01"
       endDate="2025-09-31" />
================================ --%>

<%@ attribute name="thumbnailFileId" required="false"%>
<%@ attribute name="title" required="false"%>
<%@ attribute name="startDate" required="false"%>
<%@ attribute name="endDate" required="false"%>
<%@ attribute name="status" required="false"%>
<%@ attribute name="href" required="false"%>

<c:set var="title" value="${empty title ? '이벤트 제목' : title}" />
<c:set var="startDate" value="${empty startDate ? '' : startDate}" />
<c:set var="endDate" value="${empty endDate ? '' : endDate}" />

<a class="event-card" data-productid="${productId}"
	<c:if test="${not empty href}"> href="${href}" </c:if>>

	<div class="event-image">
		<img
			src="${pageContext.request.contextPath}/upload_file/${thumbnailFileId}"
			alt="대표 이미지" width="324px"
			class="<c:if test='${status eq "FINISHED"}'>finished</c:if>"
			style="width: 324px; height: 170px; object-fit: cover;" />

		<!-- 진행 상태별 태그 표시 -->
		<c:choose>
			<c:when test="${status eq 'ONGOING'}">
				<div class="event-tag">
					<my:tag color="green" size="md" text="진행중" />
				</div>
			</c:when>
			<c:when test="${status eq 'FINISHED'}">
				<div class="event-tag">
					<my:tag color="gray" size="md" text="종료" />
				</div>
			</c:when>
		</c:choose>
	</div>

	<div class="event-info">
		<p class="event-title">${title}</p>
		<p class="event-date">${startDate}&nbsp;&nbsp;~&nbsp;&nbsp;${endDate}</p>
	</div>
</a>
