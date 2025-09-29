<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<%@ attribute name="title" required="true"%>

<!-- 카테고리 -->
<div class="filter_box category_box">
	<div class="filtering_title">
		<span>${title} :</span>
	</div>
	<div class="filtering_content">
		<my:selectbox size="md" items="${id}" initial="대분류" />
		<my:selectbox size="md" items="${id}" initial="중분류" />
		<my:selectbox size="md" items="${id}" initial="소분류" />
	</div>
</div>

