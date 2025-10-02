<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<%@ attribute name="id" required="false"%>
<%@ attribute name="name" required="true"%>
<%@ attribute name="title" required="false"%>
<%@ attribute name="optList" required="true"%>
<%@ attribute name="initial" required="false"%>

<c:set var="id" value="${empty id ? name : id}" />
<c:set var="title" value="${empty title ? '문의 유형' : title}" />
<c:set var="initial" value="${empty initial ? '검색 조건' : initial}" />

<!-- 문의유형 -->
<div class="filter_box questionType_box">
	<div class="filtering_title">
		<label>${title} :</label>
	</div>
	<my:selectbox size="md" name="${name}" id="${id}" items="${optList}" initial="${initial}"/>
	<input type="hidden" name="${name}" value="${searchContent[name]}">
</div>

