<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<%@ attribute name="title" required="true"%>

<!-- 답변상태 -->
<div class="filter_box answer_box">
	<div class="filtering_title">
		<span>${title} :</span>
	</div>
	<div class="answer_body">
		<div class="choice ch">
			<input type="button" value="전체" />
		</div>
		<div class="choice ch">
			<input type="button" value="미답변" />
		</div>
		<div class="choice">
			<input type="button" value="답변" />
		</div>
	</div>
</div>
