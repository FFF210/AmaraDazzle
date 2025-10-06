<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- ================================
    ImageButton 커스텀 태그

    동작
    • 기본 상태: + 아이콘
    • 클릭 → 파일 선택 → 이미지 미리보기
    • X 버튼 클릭 → 초기화

    사용법 예시
    <%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
    <my:imageBtn name="upload1" />
    tagjs > imageBtn.js 와 함꼐 사용해주세요.
================================ --%>

<%@ attribute name="name" required="false"%>
<%@ attribute name="id" required="false"%>

<c:set var="id" value="${empty id ? name : id}" />

<div class="image-button" id="wrapper-${id}">
	<input type="file" id="${id}" name="${name}" accept="image/*" style="display: none;" /> 
		<label for="${id}" class="image-placeholder"> 
			<span class="plus">＋</span>
	</label>
</div>