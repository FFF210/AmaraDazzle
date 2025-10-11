<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="scriptless"%>

<%-- ================================
 QnaAnswer 커스텀 태그
 속성(Props)
 • content : 답변 내용
================================ --%>

<%@ attribute name="content" required="true" %>

<div class="qna-detail qna-answer">
	<span class="label">A</span>
	<div class="text"><p>${content}</p></div>
</div>
