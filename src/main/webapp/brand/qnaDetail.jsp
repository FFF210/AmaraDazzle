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
<link rel="stylesheet" href="./css/reset.css" />
<link rel="stylesheet" href="./css/button.css" />
<link rel="stylesheet" href="./css/form-controls.css" />
<link rel="stylesheet" href="./css/layout.css" />
<link rel="stylesheet" href="./css/sidebar.css" />
<link rel="stylesheet" href="./css/header.css" />
<link rel="stylesheet" href="./css/tag.css" />
<link rel="stylesheet" href="./css/textArea.css" />
<link rel="stylesheet" href="./css/textInput.css" />
<link rel="stylesheet" href="./css/imageBtn.css" />
<link rel="stylesheet" href="./css/breadcrumb.css" />
<link rel="stylesheet" href="./css/contentDetail.css" />
</head>
<body>
	<my:layout>
		<!-- breadcrumb -->
		<div class="page-breadcrumb">
			<my:breadcrumb items="문의조회:/order,문의상세:" />
		</div>

		<div class="content-detail-container">

			<!-- 좌측: 소비자 문의 정보 -->
			<div class="content-left">

				<!-- 이름 -->
				<div class="content-row">
					<label class="content-label">이름</label>
					<my:textInput id="writer" name="writer" value="김철수" type="readOnly"
						size="lg" state="default" />
				</div>

				<!-- 작성일 -->
				<div class="content-row">
					<label class="content-label">작성일</label>
					<my:textInput id="writeDate" name="writeDate" value="2025-08-10"
						type="readOnly" size="lg" state="default" />
				</div>

				<!-- 문의 유형 -->
				<div class="content-row tag">
					<label class="content-label">문의 유형</label>
					<my:tag color="yellow" size="lg" text="결제완료" />
				</div>

				<!-- 첨부파일 -->
				<div class="content-row">
					<label class="content-label">첨부</label>
					<div class="content-images">
						<my:imageBtn name="upload1" />
						<my:imageBtn name="upload2" />
						<my:imageBtn name="upload3" />
					</div>
				</div>

				<!-- 리뷰 본문 -->
				<div class="content-row textArea-wrapper">
					<label class="content-label">내용</label>
					<my:textArea name="readonlyDesc"
						value="향도 너무 좋고 머리 감은 후에 바로 머릿결이 부드러워진 걸 느낄 수 있어요.
미용실 클리닉 다 필요없었습니다..
무엇보다 바르고 따로 기다리는 시간 필요없이 바로 헹궈주면 된다는 점이 너무 좋았어요!!
반곱슬인데도 불구하고 머리를 말린 이후에도 엄청 차분해진 머릿결을 볼 수 있습니다👍
같은 라인의 에센스랑 사용했을 때 효과가 두배입니다!"
						readonly="true" />
				</div>
			</div>

			<!-- 우측: 상품 정보 + 판매자 답변 -->
			<div class="content-right">

				<!-- 상품 정보 -->
				<div class="product-card">
					<my:imageBtn name="upload1" />
					<div class="product-info">
						<div class="product-name">더블기획 텐더볼륨 향</div>
						<div class="chip">옵션 정보</div>
					</div>
				</div>

				<!-- 판매자 답변 -->
				<div class="content-reply">
					<div class="reply-title">판매자 답변</div>

					<!-- 기존 답변이 있는 경우 readOnly -->
					<c:if test="${not empty previousReplies}">
						<c:forEach var="reply" items="${previousReplies}">
							<my:textArea name="readonlyReply" value="${reply}"
								readonly="true" />
						</c:forEach>
					</c:if>

					<!-- 신규 답변 입력 -->
					<my:textArea name="newReply" placeholder="답변을 입력하세요"
						maxLength="500" showCount="true" />
					<div class="form-actions">
						<button type="button" class="btn btn-primary btn-xl">등록</button>
					</div>
				</div>
			</div>

		</div>
	</my:layout>
</body>
</html>
