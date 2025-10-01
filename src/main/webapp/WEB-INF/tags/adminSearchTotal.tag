<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<%@ attribute name="id" required="false"%>
<%@ attribute name="optList" required="true"%>
<%@ attribute name="init" required="true"%>

<c:set var="optList" value="${optList}" />
<c:set var="init" value="${init}" />

<!-- 통합검색 -->
<div class="filter_box totalSearch_box">
	<my:selectbox size="md" items="${optList}" initial="${init}" name="totalSearch"/>
	<div class="searchKeyword">
		&nbsp;<i class="bi bi-search"></i> 
		<input type="text" placeholder="Search" value="${keyword}" name="keyword" />
	</div>
</div>
