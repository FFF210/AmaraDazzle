<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 신청 상세보기</title>

<link rel="stylesheet" href="./css/formLayout.css" />

<link rel="stylesheet" href="../tagcss/selectbox.css" />
<link rel="stylesheet" href="../tagcss/textArea.css" />
<link rel="stylesheet" href="../tagcss/uploader.css" />
<link rel="stylesheet" href="../tagcss/tag.css" />
<link rel="stylesheet" href="../tagcss/breadcrumb.css" />
<link rel="stylesheet" href="../tagcss/dateInput.css" />
<link rel="stylesheet" href="../tagcss/form-controls.css" />
<link rel="stylesheet" href="../tagcss/brandHeader.css" />
<link rel="stylesheet" href="../tagcss/layout.css" />
<link rel="stylesheet" href="../tagcss/reset.css" />
<link rel="stylesheet" href="../tagcss/sidebar.css" />
<link rel="stylesheet" href="../tagcss/tableFilter.css" />
<link rel="stylesheet" href="../tagcss/pagination.css" />
<link rel="stylesheet" href="../tagcss/table.css" />
<link rel="stylesheet" href="../tagcss/button.css" />
<link rel="stylesheet" href="../tagcss/textInput.css" />

<style>
.breadcrumb {
	margin-top: 8px;
	margin-left: 24px;
}

.chips {
	margin-top: 6px;
}
</style>

</head>
<body>
	<my:layout>

		<my:breadcrumb items="이벤트 관리:/brand2/eventList.jsp" />
		<div class="wrap">
			<section class="card">
				<div class="head">이벤트 신청 상세보기</div>
				<div class="body">
					<main>
						<form id="eventForm" novalidate>
							<div class="grid">

								<!-- 이벤트 ID -->
								<input type="hidden" name="eventId" value="${event.eventId}" />

								<div class="label">이벤트 종류</div>
								<div>
									<my:textInput type="readOnly" size="sm" state="default"
										value="${event.eventType}" />
								</div>

								<div class="label">이벤트명</div>
								<div>
									<my:textInput type="readOnly" size="sm" state="default"
										value="${event.eventName}" />
								</div>

								<div class="label">이벤트기간</div>
								<div>
									<my:textInput type="readOnly" size="sm" state="default"
										value="${event.startDate} ~ ${event.endDate}" />
								</div>

								<c:if
									test="${not empty event.category1Id 
								or not empty event.category2Id 
								or not empty event.category3Id}">
									<div class="label">상품 카테고리</div>
									<div class="part_content select_cate">
										<c:if test="${not empty event.largeCategoryName}">
											<my:textInput type="readOnly" size="sm" state="default"
												value="${event.largeCategoryName}" />
										</c:if>
										<c:if test="${not empty event.middleCategoryName}">
											<my:textInput type="readOnly" size="sm" state="default"
												value="${event.middleCategoryName}" />
										</c:if>
										<c:if test="${not empty event.smallCategoryName}">
											<my:textInput type="readOnly" size="sm" state="default"
												value="${event.smallCategoryName}" />
										</c:if>
									</div>
								</c:if>

								<div class="label">썸네일</div>
								<div class="upload">
									<div id="imgPreviewWrapper" class="preview-wrapper">
										<div id="imgPreviewArea" class="preview-area"
											aria-live="polite">
											<img src="/upload/${event.thumbnailFileId}" />
										</div>
									</div>
								</div>

								<div class="label">메인 이미지</div>
								<div class="upload">
									<div id="imgPreviewWrapper" class="preview-wrapper">
										<div id="imgPreviewArea" class="preview-area"
											aria-live="polite">
											<img src="/upload/${event.detailFileId}" />
										</div>
									</div>
								</div>
								<div class="label">브랜드 전달내용</div>
								<div>
									<my:textArea readonly="true" value="${banner.bannerMessage}" />
								</div>

								<div class="label">이벤트 담당자</div>
								<div>
									<my:textInput type="readOnly" size="sm" state="default"
										value="${event.managerName}" />
								</div>

								<div class="label">담당 연락처</div>
								<div>
									<my:textInput type="readOnly" size="sm" state="default"
										value="${event.managerTel}" />
								</div>

								<!-- 이벤트 유형별 상세 -->
								<c:choose>
									<c:when test="${event.eventType eq 'COUPON'}">
										<div class="label">쿠폰 목록</div>
										<div>
											<c:forEach var="c" items="${event.coupons}">
												<span class="chip">${c.cname}</span>
											</c:forEach>
										</div>
									</c:when>

									<c:when test="${event.eventType eq 'DISCOUNT'}">
										<div class="label">상품별 할인</div>
										<div>
											<c:forEach var="d" items="${discountProducts}">
												<p>
													- ${d.productName} : ${d.discountValue}
													<c:choose>
														<c:when test="${d.discountType eq 'RATE'}">%</c:when>
														<c:otherwise>원</c:otherwise>
													</c:choose>
												</p>
											</c:forEach>
										</div>
									</c:when>

									<c:when test="${event.eventType eq 'EXPERIENCE'}">
										<div class="label">체험 상품</div>
										<div>
											<c:forEach var="p" items="${products}">
												<span class="chip">${p.productName}</span>
											</c:forEach>
										</div>
									</c:when>

									<c:when test="${event.eventType eq 'PICK'}">
										<div class="label">추천 상품</div>
										<div>
											<c:forEach var="p" items="${products}">
												<span class="chip">${p.productName}</span>
											</c:forEach>
										</div>
									</c:when>
								</c:choose>

								<div class="label">관리자 전달사항</div>
								<div>
									<my:textArea readonly="true" value="${event.note}" />
								</div>
							</div>

							<div class="footer">
								<button type="button" class="btn btn-outline btn-sm"
									onclick="location.href='/brand2/eventList'">닫기</button>
							</div>
						</form>
					</main>
				</div>
			</section>
		</div>
	</my:layout>
</body>
</html>
