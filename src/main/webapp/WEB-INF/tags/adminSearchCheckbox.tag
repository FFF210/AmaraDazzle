<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<%@ attribute name="title" required="true"%>

<!-- 체크박스 -->
<div class="filter_box check_box">
	<div class="filtering_title">
		<span>${title} :</span>
	</div>
	<div>
		<c:forEach var="i" begin="1" end="6">
			<label><input type="checkbox" value="v${i}" /> 문항${i}</label>
		</c:forEach>
	</div>
</div>
