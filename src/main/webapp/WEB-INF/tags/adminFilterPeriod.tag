<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<%@ attribute name="title" required="false"%>
<%@ attribute name="dateCate" required="false"%>
<%@ attribute name="presets" required="false"%>

<c:set var="title" value="${empty title ? '기간' : title}" />
<c:set var="presets" value="${empty presets ? '오늘,어제,최근 7일,최근 30일' : presets}" />

<div class="filter_box period_box filter-row date-row">
	<div class="filtering_title">
		<label>${title} :</label>
	</div>
	<div class="period_body">
		<div class="filtering_content">
			<my:dateInput type="input" id="${dateCate}startDate" name="${dateCate}startDate" value="${searchContent.startDate}"/>
			<span> - </span>
			<my:dateInput type="input" id="${dateCate}endDate" name="${dateCate}endDate" value="${searchContent.endDate}" inputDay="end" />
			
			<div class="p_choice">
				<my:dateInput type="preset" presets="${presets}" />
			</div>
		</div>
	</div>
</div>
