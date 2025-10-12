<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="scriptless"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- ================================
    Alert 커스텀 태그

    속성(Props)
    • message : 메시지 내용
    
    사용법 예시
    <%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
	<my:submitDialog title="모든 입력 내용을 확인하였습니까?" msg="등록 후 수정 불가" />
================================ --%>
<%@ attribute name="title" required="true"%>
<%@ attribute name="msg" required="false"%>
<%@ attribute name="msg2" required="false"%>

<!-- 폼 전송 전 확인 모달 -->
<div id="submitCkDialog" class="modal">
	<div class="modal-overlay"></div>
	<div class="modal-content">
		<h3 class="modal-title">${title}</h3>
		<p class="modal-subTitle">
			${msg}
			<br>${msg2}
		</p>
		<div class="modal-body">
		</div>
		<div class="modal-footer">
			<button type="button" class="btn second_btn" data-action="취소">취소</button>
			<button type="button" class="btn first_btn" data-action="전송">확인</button>
		</div>
	</div>
</div>

