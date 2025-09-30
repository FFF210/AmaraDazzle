<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<%@ attribute name="large" required="true"%>
<%@ attribute name="middle" required="false"%>
<%@ attribute name="small" required="false"%>

<%-- <c:set var="large" value="${fn:split(large, ',')}" /> --%>
<%-- <c:set var="middle" value="${not empty middle ? fn:split(middle, ',') : '-'}" /> --%>
<%-- <c:set var="small" value="${not empty small ? fn:split(small, ',') : '-'}" /> --%>


<!-- 카테고리 -->
<div class="filter_box category_box">
	<div class="filtering_title">
		<label>카테고리 :</label>
	</div>
	<div class="filtering_content">
		<my:selectbox size="md" items="${large}" initial="대분류" name="largeCate" />
		<my:selectbox size="md" items="${middle}" initial="중분류" name="middleCate"/>
		<my:selectbox size="md" items="${small}" initial="소분류" name="smallCate"/>
	</div>
</div>