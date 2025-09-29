<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<%@ attribute name="title" required="true"%>
<%@ attribute name="optList" required="true"%>
<%@ attribute name="init" required="true"%>

<c:set var="optList" value="${optList}" />
<c:set var="init" value="${init}" />

<!-- 문의유형 -->
<div class="filter_box questionType_box">
	<div class="filtering_title">
		<span>${title} :</span>
	</div>
	<my:selectbox size="md" items="${optList}" initial="${init}" />
</div>
