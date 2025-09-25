<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="empty"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<%-- ================================
 QnaItem 커스텀 태그
 속성(Props)
 • status   : 상태 (waiting | answered)
 • title    : 문의 제목
 • nickname : 작성자 닉네임
 • date     : 작성일 (yyyy.MM.dd)
================================ --%>

<%@ attribute name="status" required="true"%>
<%@ attribute name="title" required="true"%>
<%@ attribute name="nickname" required="true"%>
<%@ attribute name="date" required="true"%>

<div class="qna-item">
	<div class="qna-tag">
		<my:tag color="green" size="md" text="답변완료" />
	</div>
	<div class="qna-title">
		<p>${title}</p>
	</div>
	<div class="qna-nickname">
		<p>${nickname}</p>
	</div>
	<div class="qna-date">
		<p>${date}</p>
	</div>
</div>
