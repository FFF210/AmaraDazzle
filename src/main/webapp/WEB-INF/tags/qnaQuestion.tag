<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="scriptless"%>

<%-- ================================
 QnaQuestion 커스텀 태그
 속성(Props)
 • content : 질문 내용
================================ --%>

<%@ attribute name="content" required="true" %>

<div class="qna-detail qna-question">
	<span class="label">Q</span>
	<div class="text"><p>${content}</p></div>
</div>
