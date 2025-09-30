<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="scriptless"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%-- ================================
    Selectbox 커스텀 태그

    속성(Props)
    • id     : DOM 식별용 id (JS 제어에 필요)
    • size  : sm | md | lg (기본값 md)
    • items : 쉼표(,)로 구분된 항목 목록 (예: "item1,item2,item3")
    • initial : 초기에 보여줄 값 (선택 안하면 itemList[0])

    사용법 예시
    <%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
    <my:selectbox 
      size="lg" 
      items="추천순,인기순,최신순,낮은가격순,높은가격순"
      initial="정렬" />

    <script>
      document.addEventListener("selectChanged", (e) => {
        console.log("선택된 값:", e.detail.value); // 실제 값
        console.log("선택된 텍스트:", e.detail.text); // 표시되는 텍스트
      });
    </script>
================================ --%>
<%@ attribute name="id" required="false"%>
<%@ attribute name="size" required="false"%>
<%@ attribute name="items" required="false"%>
<%@ attribute name="initial" required="false"%>
<%@ attribute name="name" required="false"%>

<%-- 기본값 처리 --%>
<c:set var="size" value="${empty size ? 'md' : size}" />
<c:set var="items" value="${empty items ? '' : items}" />
<c:set var="itemList" value="${fn:split(items, ',')}" />
<c:set var="selectedValue" value="${empty initial ? itemList[0] : initial}" />
<c:set var="name" value="${name}" />

<%-- id 속성이 있으면 그대로 쓰고, 없으면 자동 생성 --%>
<c:choose>
	<c:when test="${not empty id}">
		<c:set var="selectId" value="${id}" />
	</c:when>
	<c:otherwise>
		<%-- 자동 고유 ID 생성 --%>
		<c:if test="${empty applicationScope.selectboxSeq}">
			<c:set var="selectboxSeq" value="0" scope="application" />
		</c:if>
		<c:set var="selectboxSeq" value="${applicationScope.selectboxSeq + 1}"
			scope="application" />
		<c:set var="selectId" value="custom-select-${selectboxSeq}" />
	</c:otherwise>
</c:choose>


<div class="custom-select ${size}"
	<c:if test="${not empty id}">id="${id}"</c:if> tabindex="0">
	<div class="select-header" name="${name}">
		<span class="select-label">${selectedValue}</span> 
		<i class="bi bi-chevron-down"></i>
	</div>
	<ul class="select-list">
		<c:forEach var="it" items="${itemList}">
			<li class="select-item ${it eq selectedValue ? 'active' : ''}"
				data-value="${it}" value="${it}">${it}</li>
		</c:forEach>
	</ul>
</div>