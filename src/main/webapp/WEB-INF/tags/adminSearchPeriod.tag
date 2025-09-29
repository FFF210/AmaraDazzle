<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>


<%@ attribute name="title" required="true"%>

<div class="filter_box period_box">
	<div class="filtering_title">
		<span>${title} :</span>
	</div>
	<div class="period_body">
		<div class="filtering_content">
			<my:dateInput type="input" id="startDate" name="startDate" />
			<span> - </span>
			<my:dateInput type="input" id="endDate" name="endDate" />
		</div>

		<div class="p_choice">
			<my:dateInput type="preset" presets="오늘,어제,최근 7일,최근 30일" />
		</div>
	</div>
</div>
