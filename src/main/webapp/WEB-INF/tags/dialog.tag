<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag body-content="scriptless"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%-- ================================
    Dialog(모달) 커스텀 태그

    속성(Props)
    • id        : 모달 ID (필수)
    • title     : 다이얼로그 제목
    • message   : 본문 메시지 (html 가능)
    • type      : alert | confirm | form
    • buttons   : "확인,취소" (쉼표로 구분)
    • visible   : true | false (기본: false)
    
    사용법 예시
    <%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
    <button type="button" class="btn btn-primary btn-md"
		id="openDialog">다이얼로그 오픈</button>
    <my:dialog id="pwDialog" title="비밀번호 변경" message="새로운 비밀번호를 입력하세요." 
    	type="form" buttons="취소,저장" />
                   
    <script>
	  // 버튼 클릭 → 다이얼로그 열기
	  document.getElementById("openDialog").addEventListener("click", () => {
	    document.getElementById("pwDialog").classList.add("show");
	  });
	</script>
================================ --%>

<%@ attribute name="id" required="true"%>
<%@ attribute name="title" required="false"%>
<%@ attribute name="message" required="false"%>
<%@ attribute name="type" required="false"%>
<%@ attribute name="buttons" required="false"%>
<%@ attribute name="visible" required="false"%>

<c:set var="visible" value="${empty visible ? 'false' : visible}" />
<c:set var="type" value="${empty type ? 'alert' : type}" />
<c:set var="buttons" value="${empty buttons ? '확인' : buttons}" />
<c:set var="btnList" value="${fn:split(buttons, ',')}" />

<div id="${id}" class="modal ${visible eq 'true' ? 'show' : ''}">
	<div class="modal-overlay"></div>
	<div class="modal-content">
		<h3 class="modal-title">${title}</h3>
		<div class="modal-body">
			<c:if test="${not empty message}">
				<div class="modal-message">${message}</div>
			</c:if>

			<c:if test="${type eq 'form'}">
				<jsp:doBody />
				<%-- 폼 요소는 body-content 영역에서 작성 가능 --%>
			</c:if>
		</div>
		<div class="modal-footer">
			<c:forEach var="btn" items="${btnList}" varStatus="i">
				<button type="button"
					class="btn btn-md ${i.last ? 'btn-primary' : 'btn-outline'}"
					data-action="${btn}">${btn}</button>
			</c:forEach>
		</div>
	</div>
</div>

<script>
document.addEventListener("DOMContentLoaded", () => {
  const modal = document.getElementById("${id}");
  const overlay = modal.querySelector(".modal-overlay");

  // 닫기 처리
  overlay.addEventListener("click", () => {
    modal.classList.remove("show");
  });

  // 버튼 이벤트
  modal.querySelectorAll("button[data-action]").forEach(btn => {
    btn.addEventListener("click", () => {
      const event = new CustomEvent("dialogAction", {
        detail: { id: "${id}", action: btn.dataset.action }
      });
      document.dispatchEvent(event);
      modal.classList.remove("show");
    });
  });
});
</script>
