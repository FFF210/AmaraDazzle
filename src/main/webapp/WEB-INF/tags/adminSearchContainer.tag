<%@ tag description="관리자 검색박스 컴포넌트" language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="scriptless"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

<link rel="stylesheet" href="../tagcss/dateInput.css" />

<%-- ================================
    admin search box 커스텀 태그

    사용법 예시
    <%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
    <!-- 대표 이미지 -->
	<my:adminSearchBox name="searchBox" period="true" answer="true" category="true" />


================================ --%>

<div class="search_container">
	<div class="filter">

		<jsp:doBody />

	</div>
	<div class="btn_box">
		<input type="submit" class="btn first_btn" value="검색" /> <input
			type="reset" class="btn second_btn" value="초기화" />
	</div>
</div>


<script>


</script>
