<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>


<!-- 카테고리 -->
<div class="filter_box category_box">
	<div class="filtering_title">
		<label>카테고리 :</label>
	</div>
	<div class="filtering_content">
		<my:selectbox size="md" items="대분류" initial="대분류" id="largeSelect"/>
		<my:selectbox size="md" items="중분류" initial="중분류" id="middleSelect"/>
		<my:selectbox size="md" items="소분류" initial="소분류" id="smallSelect" />
		<input type="hidden" name="category1Id" id="category1Id" />
		<input type="hidden" name="category2Id" id="category2Id" />
		<input type="hidden" name="category3Id" id="category3Id" />
	</div>
</div>


