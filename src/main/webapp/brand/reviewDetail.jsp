<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>리뷰 상세</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="../tagcss/reset.css" />
<link rel="stylesheet" href="../tagcss/button.css" />
<link rel="stylesheet" href="../tagcss/form-controls.css" />
<link rel="stylesheet" href="../tagcss/layout.css" />
<link rel="stylesheet" href="../tagcss/sidebar.css" />
<link rel="stylesheet" href="../tagcss/brandHeader.css" />
<link rel="stylesheet" href="../tagcss/rating.css" />
<link rel="stylesheet" href="../tagcss/textArea.css" />
<link rel="stylesheet" href="../tagcss/textInput.css" />
<link rel="stylesheet" href="../tagcss/breadcrumb.css" />
<link rel="stylesheet" href="./css/alert.css" />
<link rel="stylesheet" href="./css/contentDetail.css" />
</head>
<body>
	<!-- Toast 알림 컨테이너 -->
	<div id="toast-container"></div>

	<my:layout>
		<!-- breadcrumb -->
		<div class="page-breadcrumb">
			<my:breadcrumb items="리뷰조회:/brand/reviewList,리뷰상세:" />
		</div>

		<div class="content-detail-container">

			<!-- 좌측: 소비자 리뷰 정보 -->
			<div class="content-left">

				<!-- 이름 -->
				<div class="content-row">
					<label class="content-label">이름</label>
					<my:textInput id="writer" name="writer"
						value="${review.memberName}" type="readOnly" size="lg"
						state="default" />
				</div>

				<!-- 작성일 -->
				<div class="content-row">
					<label class="content-label">작성일</label>
					<my:textInput id="writeDate" name="writeDate"
						value="${review.questionedAt}" type="readOnly" size="lg"
						state="default" />
				</div>

				<!-- 별점 -->
				<div class="content-row rating">
					<label class="content-label">별점</label>
					<my:rating rating="${review.rating}" readonly="true" />
				</div>

				<!-- 첨부파일 (하나라도 있을 때만 출력) -->
				<c:if
					test="${not empty review.image1FileId or not empty review.image2FileId or not empty review.image3FileId}">
					<div class="content-row">
						<label class="content-label">첨부</label>
						<c:forEach var="i" begin="1" end="3">
							<div class="content-images">
								<img
									src="<c:out value='${not empty review["image" += i += "FileId"] ? ("image?fileId=" += review["image" += i += "FileId"]) : (contextPath += "/image/plus.png")}'/>"
									id="preview-image${i}" alt="추가 이미지${i}" width="100px"
									onclick="document.getElementById('image${i}').click();" /> <input
									type="file" id="image${i}" name="image${i}" accept="image/*"
									style="display: none"
									onchange="readURL(this,'preview-image${i}');" />
							</div>
						</c:forEach>
					</div>
				</c:if>

				<!-- 리뷰 본문 -->
				<div class="content-row textArea-wrapper">
					<label class="content-label">내용</label>
					<my:textArea name="readonlyDesc" value="${review.content}"
						readonly="true" />
				</div>

				<!-- 신고 버튼 -->
				<div class="content-report">
					<a href="#">부적절한 리뷰 신고</a>
				</div>
			</div>

			<!-- 우측: 상품 정보 + 판매자 답변 -->
			<div class="content-right">

				<!-- 상품 정보 -->
				<div class="product-card">
					<img
						src="<c:out value='${not empty review.thumbnailFileId ? ("image?fileId=" += review.thumbnailFileId) : (contextPath += "/img/plus.png")}'/>"
						id="preview-thumbnail" alt="대표 이미지" width="100px"
						onclick="document.getElementById('thumbnail').click();" /> <input
						type="file" id="thumbnail" name="thumbnail" accept="image/*"
						style="display: none"
						onchange="readURL(this,'preview-thumbnail');" />
					<div class="product-info">
						<div class="product-name">${review.productName}</div>
						<c:if test="${not empty review.optionName}">
							<div class="chip">${review.optionName}</div>
						</c:if>
					</div>
				</div>

				<!-- 판매자 답변 -->
				<div class="content-reply">
					<div class="reply-title">판매자 답변</div>

					<form id="replyForm" method="post" action="/brand/reviewReply">
						<input type="hidden" name="reviewId" value="${review.reviewId}" />
						<input type="hidden" name="answer" />
					</form>

					<!-- 기존 답변이 있는 경우 -->
					<c:if test="${not empty review.answer}">
						<my:textArea name="readonlyReply" value="${review.answer}" />
						<div class="form-actions">
							<button type="button" class="btn btn-primary btn-xl"
								onclick="submitReply(${review.reviewId})">수정</button>
						</div>
					</c:if>

					<!-- 신규 답변 입력 (미답변 상태일 때만) -->
					<c:if test="${review.answerStatus eq 'PENDING'}">
						<my:textArea name="newReply" placeholder="답변을 입력하세요"
							maxLength="500" showCount="true" />
						<div class="form-actions">
							<button type="button" class="btn btn-primary btn-xl"
								onclick="submitReply(${review.reviewId})">등록</button>
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
 function submitReply(reviewId) {
	  const answerField = document.querySelector("textarea[name='newReply'], textarea[name='readonlyReply']");
	  const answer = answerField ? answerField.value.trim() : "";

	  if (!answer) {
	    showToast("error","답변 내용을 입력해주세요.");
	    return;
	  }

	  // 숨은 폼에 값 채우기
	  const form = document.getElementById("replyForm");
	  form.querySelector("input[name='reviewId']").value = reviewId;
	  form.querySelector("input[name='answer']").value = answer;

	  // 폼 제출 → 서버에서 redirect 처리
	  form.submit();
	}
</script>
</html>
