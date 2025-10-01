<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<%@ attribute name="searchItems" required="true"%>
<%@ attribute name="initial" required="false"%>

<c:set var="initial" value="${empty initial ? '검색 조건' : initial}" />

<!-- 통합검색 -->
<div class="filter_box totalSearch_box">
	<my:selectbox size="md" items="${searchItems}" initial="${initial}" id="totalSearch"/>
	<input type="hidden" name="totalSearch" value="${searchContent.totalSearch}">
	
	<div class="searchKeyword">
		&nbsp;<i class="bi bi-search"></i> 
		<input type="text" placeholder="Search" value="${searchContent.keyword}" name="keyword" class="search-input" />
	</div>
</div>
