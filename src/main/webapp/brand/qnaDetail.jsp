<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>문의 상세</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="../tagcss/reset.css" />
<link rel="stylesheet" href="../tagcss/button.css" />
<link rel="stylesheet" href="../tagcss/form-controls.css" />
<link rel="stylesheet" href="../tagcss/layout.css" />
<link rel="stylesheet" href="../tagcss/sidebar.css" />
<link rel="stylesheet" href="../tagcss/brandHeader.css" />
<link rel="stylesheet" href="../tagcss/tag.css" />
<link rel="stylesheet" href="../tagcss/textArea.css" />
<link rel="stylesheet" href="../tagcss/textInput.css" />
<link rel="stylesheet" href="../tagcss/imageBtn.css" />
<link rel="stylesheet" href="../tagcss/breadcrumb.css" />
<link rel="stylesheet" href="../tagcss/alert.css" />
<link rel="stylesheet" href="./css/contentDetail.css" />
</head>
<body>
	<!-- Toast 알림 컨테이너 -->
	<div id="toast-container"></div>

	<my:layout>
		<!-- breadcrumb -->
		<div class="page-breadcrumb">
			<my:breadcrumb items="고객문의조회:/brand/qnaList,문의상세:" />
		</div>

		<div class="content-detail-container">

			<!-- 좌측: 소비자 문의 정보 -->
			<div class="content-left">

				<!-- 이름 -->
				<div class="content-row">
					<label class="content-label">이름</label>
					<my:textInput id="writer" name="writer" value="${qna.senderName}"
						type="readOnly" size="lg" state="default" />
				</div>

				<!-- 작성일 -->
				<div class="content-row">
					<label class="content-label">작성일</label>
					<my:textInput id="writeDate" name="writeDate"
						value="${qna.questionedAt}" type="readOnly" size="lg"
						state="default" />
				</div>

				<!-- 문의 유형 -->
				<div class="content-row tag">
					<label class="content-label">문의 유형</label>
					<c:choose>
						<c:when test="${qna.category eq 'PRODUCT'}">
							<my:tag color="green" size="lg" text="상품" />
						</c:when>
						<c:when test="${qna.category eq 'ORDER'}">
							<my:tag color="yellow" size="lg" text="주문" />
						</c:when>
						<c:when test="${qna.category eq 'CANCEL'}">
							<my:tag color="yellow" size="lg" text="취소" />
						</c:when>
						<c:when test="${qna.category eq 'REFUND'}">
							<my:tag color="yellow" size="lg" text="환불" />
						</c:when>
						<c:when test="${qna.category eq 'EXCHANGE'}">
							<my:tag color="yellow" size="lg" text="교환" />
						</c:when>
						<c:when test="${qna.category eq 'DELIVERY'}">
							<my:tag color="yellow" size="lg" text="배송" />
						</c:when>
						<c:otherwise>
							<my:tag color="gray" size="lg" text="기타" />
						</c:otherwise>
					</c:choose>
				</div>

				<!-- 첨부파일 (티켓 문의만, 하나라도 있을 때만 출력) -->
				<c:if
					test="${not empty qna.image1FileId or not empty qna.image2FileId or not empty qna.image3FileId}">
					<div class="content-row">
						<label class="content-label">첨부</label>
						<div class="content-images">
							<c:if test="${not empty qna.image1FileId}">
								<my:imageBtn name="upload1" id="${qna.image1FileId}" />
							</c:if>
							<c:if test="${not empty qna.image2FileId}">
								<my:imageBtn name="upload2" id="${qna.image2FileId}" />
							</c:if>
							<c:if test="${not empty qna.image3FileId}">
								<my:imageBtn name="upload3" id="${qna.image3FileId}" />
							</c:if>
						</div>
					</div>
				</c:if>

				<!-- 리뷰 본문 -->
				<div class="content-row textArea-wrapper">
					<label class="content-label">내용</label>
					<my:textArea name="readonlyDesc" value="${qna.question}"
						readonly="true" />
				</div>
			</div>

			<!-- 우측: 상품 정보 + 판매자 답변 -->
			<div class="content-right">

				<!-- 상품 정보 (상품문의일 경우만 노출) -->
				<c:if test="${qna.category eq 'PRODUCT'}">
					<div class="product-card">
						<my:imageBtn name="productThumbnail" id="${qna.productThumbnail}" />
						<div class="product-info">
							<div class="product-name">${qna.productName}</div>
							<!-- <div class="chip">옵션 정보</div> -->
						</div>
					</div>
				</c:if>

				<!-- 판매자 답변 -->
				<div class="content-reply">
					<div class="reply-title">판매자 답변</div>

					<form id="replyForm" method="post" action="/brand/memberQnaReply">
						<input type="hidden" name="qnaId" value="${qna.memberQnaId}" /> <input
							type="hidden" name="type" value="${qna.type}" /> <input
							type="hidden" name="answer" />
					</form>


					<!-- 기존 답변이 있는 경우 (수정 가능) -->
					<c:if test="${not empty qna.answer}">
						<my:textArea name="readonlyReply" value="${qna.answer}" />
						<div class="form-actions">
							<button type="button" class="btn btn-primary btn-xl"
								onclick="submitReply(${qna.memberQnaId}, '${qna.type}')">수정</button>
						</div>
					</c:if>
					<!-- 신규 답변 입력 (미답변 상태일 때만) -->
					<c:if test="${qna.status eq 'PENDING'}">
						<my:textArea name="newReply" placeholder="답변을 입력하세요"
							maxLength="500" showCount="true" />
						<div class="form-actions">
							<button type="button" class="btn btn-primary btn-xl"
								onclick="submitReply(${qna.memberQnaId}, '${qna.type}')">등록</button>
						</div>
					</c:if>
				</div>
			</div>

		</div>
	</my:layout>
</body>
<script src="./js/toast.js"></script>
<script>
/*********************************************************************************************************
 * 답변 등록/수정 이벤트
 *********************************************************************************************************/
function submitReply(qnaId, type) {
  const answerField = document.querySelector("textarea[name='newReply'], textarea[name='readonlyReply']");
  const answer = answerField ? answerField.value.trim() : "";

  if (!answer) {
    showToast("error","답변 내용을 입력해주세요.");
    return;
  }

  // 숨은 폼에 값 채우기
  const form = document.getElementById("replyForm");
  form.querySelector("input[name='qnaId']").value = qnaId;
  form.querySelector("input[name='type']").value = type;
  form.querySelector("input[name='answer']").value = answer;

  // 폼 제출 → 서버에서 redirect 처리
  form.submit();
}

</script>
</html>
