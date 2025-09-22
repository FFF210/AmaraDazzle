<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- ================================
    Pagination 커스텀 태그

    속성(Props)
    • currentPage : 현재 페이지 (1부터 시작)
    • totalPages  : 전체 페이지 수
    • maxVisible  : 표시할 최대 버튼 개수 (기본 5)
    • baseUrl     : 페이지 링크 prefix
    
    사용법 예시
    <%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
	<my:pagination currentPage="1" totalPages="10" baseUrl="/products?page=" />
================================ --%>

<%@ attribute name="currentPage" required="true"%>
<%@ attribute name="totalPages" required="true"%>
<%@ attribute name="maxVisible" required="false"%>
<%@ attribute name="baseUrl" required="true"%>

<c:set var="currentPage" value="${currentPage}" />
<c:set var="totalPages" value="${totalPages}" />
<c:set var="maxVisible" value="${empty maxVisible ? 5 : maxVisible}" />

<c:set var="startPage" value="${currentPage - (maxVisible div 2)}" />
<c:set var="endPage" value="${currentPage + (maxVisible div 2)}" />

<c:if test="${startPage lt 1}">
	<c:set var="endPage" value="${endPage + (1 - startPage)}" />
	<c:set var="startPage" value="1" />
</c:if>

<c:if test="${endPage gt totalPages}">
	<c:set var="startPage" value="${startPage - (endPage - totalPages)}" />
	<c:set var="endPage" value="${totalPages}" />
</c:if>

<c:if test="${startPage lt 1}">
	<c:set var="startPage" value="1" />
</c:if>

<div class="pagination">
	<!-- 이전 버튼 -->
	<c:choose>
		<c:when test="${currentPage gt 1}">
			<a href="${baseUrl}${currentPage-1}" class="page-btn prev"> <i
				class="bi bi-chevron-left"></i> 이전
			</a>
		</c:when>
		<c:otherwise>
			<span class="page-btn prev disabled"> <i
				class="bi bi-chevron-left"></i> 이전
			</span>
		</c:otherwise>
	</c:choose>


	<!-- 페이지 번호 -->
	<c:if test="${startPage gt 1}">
		<a href="${baseUrl}1" class="page-btn">1</a>
		<span class="dots">...</span>
	</c:if>

	<c:forEach var="i" begin="${startPage}" end="${endPage}">
		<c:choose>
			<c:when test="${i eq currentPage}">
				<span class="page-btn active">${i}</span>
			</c:when>
			<c:otherwise>
				<a href="${baseUrl}${i}" class="page-btn">${i}</a>
			</c:otherwise>
		</c:choose>
	</c:forEach>

	<c:if test="${endPage lt totalPages}">
		<span class="dots">...</span>
		<a href="${baseUrl}${totalPages}" class="page-btn">${totalPages}</a>
	</c:if>

	<!-- 다음 버튼 -->
	<c:choose>
		<c:when test="${currentPage lt totalPages}">
			<a href="${baseUrl}${currentPage+1}" class="page-btn next"> 다음 <i
				class="bi bi-chevron-right"></i>
			</a>
		</c:when>
		<c:otherwise>
			<span class="page-btn next disabled"> 다음 <i
				class="bi bi-chevron-right"></i>
			</span>
		</c:otherwise>
	</c:choose>
</div>
