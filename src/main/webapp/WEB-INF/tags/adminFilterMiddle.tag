<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<%@ attribute name="name" required="true"%>
<%@ attribute name="filters" required="true"%>
<c:set var="filters" value="${empty filters ? '답변 상태:ALL=전체|NOT=미답변|YES=답변' : filters}" />

<!-- 중간필터 -->
<c:set var="filterLines" value="${fn:split(filters, ',')}" />
<c:forEach var="line" items="${filterLines}">
	<c:set var="parts" value="${fn:split(line, ':')}" />
	<c:set var="label" value="${parts[0]}" />
	<c:set var="options" value="${fn:split(parts[1], '|')}" />

	<div class="filter_box answer_box filter-row">
		<div class="filtering_title">
			<label>${label}:</label>
		</div>
		<div class="answer_body filter-btn-group">
			<c:forEach var="opt" items="${options}">
				<c:set var="optParts" value="${fn:split(opt, '=')}" />
				<c:set var="optValue" value="${optParts[0]}" />
				<c:set var="optLabel" value="${optParts[1]}" />
				
				<button type="button" class="filter-btn" data-filter="${label}" data-value="${optValue}" >${optLabel}</button>
			</c:forEach>
		</div>
		
		
		<input type="hidden" name="${name}" value="${searchContent[name] }" />
	</div>
</c:forEach>



