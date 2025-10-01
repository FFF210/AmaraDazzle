<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<%@ attribute name="title" required="true"%>
<%@ attribute name="range" required="true"%>
<%@ attribute name="dateCate" required="false"%>


<c:set var="dateCate" value="${empty dateCate ? '' : dateCate}" />
<c:set var="range" value="${range}" />

<div class="filter_box period_box">
	<div class="filtering_title">
		<span>${title} :</span>
	</div>
	<div class="period_body">
		<div class="filtering_content">
			<my:dateInput type="input" id="${dateCate}startDate" name="${dateCate}startDate" />
			<span> - </span>
			<my:dateInput type="input" id="${dateCate}endDate" name="${dateCate}endDate" inputDay="end"/>
		</div>

		<div class="p_choice">
			<my:dateInput type="preset" presets="${range}" />
		</div>
	</div>
</div>
