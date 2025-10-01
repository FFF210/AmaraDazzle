<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%-- ================================
    Breadcrumb 커스텀 태그 (순수 JSP/Servlet용)

    속성(Props)
    • items : "라벨1:/url1,라벨2:/url2,라벨3:" (쉼표 구분, url이 없으면 마지막 항목처럼 빈칸)

    사용법 예시
    <%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
    <my:breadcrumb items="상품 관리:/product,상품 목록 조회:" />
================================ --%>

<%@ attribute name="items" required="true"%>

<c:set var="crumbList" value="${fn:split(items, ',')}" />

<nav class="breadcrumb">
	<ul>
		<!-- 홈 고정 -->
		<li class="home"><a href="/"> 홈</a><i
			class="bi bi-chevron-right breadcrumb-separator"></i></li>

		<c:forEach var="it" items="${crumbList}" varStatus="status">
			<c:set var="parts" value="${fn:split(it, ':')}" />
			<li><c:choose>
					<c:when test="${fn:length(parts) gt 1 and not empty parts[1]}">
						<a href="${parts[1]}">${parts[0]}</a>
					</c:when>
					<c:otherwise>
						<span>${parts[0]}</span>
					</c:otherwise>
				</c:choose> <!-- 마지막 li가 아니면 화살표 아이콘 추가 --> <c:if test="${not status.last}">
					<i class="bi bi-chevron-right breadcrumb-separator"></i>
				</c:if></li>
		</c:forEach>
	</ul>
</nav>
