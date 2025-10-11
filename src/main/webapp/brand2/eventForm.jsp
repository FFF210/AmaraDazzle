<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 신청</title>

<!-- Pretendard 폰트 (CDN) -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css">

<!-- flatpickr 기본 테마 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/themes/light.css">

<!-- 한글화 & 커스텀 CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/custom-flatpickr.css">
	
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
	
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
.pagination {
	display: flex;
	justify-content: center; /* 수평 가운데 정렬 */
	margin: 20px 0; /* 위아래 여백 */
}

.breadcrumb {
	margin-top: 8px;
	margin-left: 24px;
}

.part_content.select_cate {
	display: flex;
	gap: 8px; /* 간격 줄여도 됨 */
}

.product-row .field:nth-child(2) {
	flex: 0 0 180px;
} /* 할인값 */
.product-row .field:nth-child(3) {
	flex: 0 0 160px;
} /* 할인유형 */
}

/* 삭제 버튼 (×) */
.product-row .removeProduct {
	flex: 0 0 auto;
	background: #F8F9FA;
	border: 1px solid #DDE1EB;
	border-radius: 6px;
	color: #DC3545;
	font-size: 20px;
	line-height: 1;
	width: 32px;
	height: 32px;
	cursor: pointer;
	transition: background 0.2s, color 0.2s;
}

.product-row .removeProduct:hover {
	background: #FFE5E9;
	color: #B71C1C;
}

/* 상품 추가 버튼 + 도움말 */
.product-actions {
	display: flex;
	align-items: center;
	gap: 12px;
	margin-top: 12px;
}

#addProductRow {
	background: #F1F9FF;
	border: 1px solid #0C8CE9;
	border-radius: 6px;
	color: #0C8CE9;
	font-size: 20px;
	width: 32px;
	height: 32px;
	cursor: pointer;
	transition: background 0.2s, color 0.2s;
}

#addProductRow:hover {
	background: #0C8CE9;
	color: #fff;
}

.product-actions .help {
	margin: 0;
	font-size: 13px;
	color: #60656E;
}
</style>

<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="../tagjs/selectbox.js"></script>

</head>
<body>
	<my:layout>

		<my:breadcrumb items="이벤트 관리:/brand2/eventList.jsp" />
		<my:brand2formLayout title="이벤트 신청" formId="eventForm">

			<div class="grid">

				<!-- 이벤트 ID (숨김) -->
				<input type="hidden" id="eventId" name="eventId"
					value="${event.eventId}" />

				<!-- 이벤트 종류 -->
				<div class="label">이벤트 종류</div>
				<div>
					<my:textInput id="eventType" name="eventType" type="readOnly"
						size="sm" state="default" value="${event.eventType}" />
				</div>

				<!-- 이벤트명 -->
				<div class="label">이벤트명</div>
				<div>
					<my:textInput id="eventName" name="eventName" type="readOnly"
						size="sm" state="default" value="${event.eventName}" />
				</div>

				<!-- 이벤트기간 -->
				<div class="label">이벤트기간</div>
				<div>
					<my:textInput id="eventPeriod" name="eventPeriod" type="readOnly"
						size="sm" state="default"
						value="${event.startDate} ~ ${event.endDate}" />
				</div>

				<%-- 썸네일, 메인 이미지, 내용 
promotion_event_write.jsp
<div class="part_section">
				<div class="part_title">썸네일</div>
				<div class="part_content">
					<my:imageBtn name="eventThumbImg" />
				</div>
			</div>
			
			<div class="part_section">
				<div class="part_title">메인 이미지</div>
				<div class="part_content">
					<my:uploader size="sm" name="eventDetailImg"/>
				</div>
			</div>

			<div class="part_section content_part">
				<div class="part_title">내용 <span class="reqired_write">*</span></div>
				<div class="part_content">
					<!-- toast editor 삽입 -->
					<div id="editContent"></div>
				</div>
			</div>
--%>

				<!-- ====== 상품 카테고리 (readonly) ====== -->
				<div class="label">상품 카테고리</div>
				<div class="part_content select_cate">
					<!-- 이미 event에 설정된 categoryId를 기반으로 채워지는 readonly -->
					<div class="custom-select sm" id="largeSelect">
						<div class="select-header">
							<span>${largeCategoryName}</span> <i class="bi bi-chevron-down"></i>
						</div>
						<ul class="select-list">
							<li class="select-item">${largeCategoryName}</li>
						</ul>
						<input type="hidden" name="category1Id"
							value="${largeCategoryName}" />
					</div>

					<div class="custom-select sm" id="middleSelect">
						<div class="select-header">
							<span>${middleCategoryName}</span> <i class="bi bi-chevron-down"></i>
						</div>
						<ul class="select-list">
							<li class="select-item">${middleCategoryName}</li>
						</ul>
						<input type="hidden" name="category2Id"
							value="${middleCategoryName}" />
					</div>

					<div class="custom-select sm" id="smallSelect">
						<div class="select-header">
							<span>${smallCategoryName}</span> <i class="bi bi-chevron-down"></i>
						</div>
						<ul class="select-list">
							<li class="select-item">${smallCategoryName}</li>
						</ul>
						<input type="hidden" name="category3Id"
							value="${smallCategoryName}" />
					</div>
				</div>

				<div class="label">썸네일</div>
				<div class="upload">
					<div id="imgPreviewWrapper" class="preview-wrapper">
						<div id="imgPreviewArea" class="preview-area" aria-live="polite">
							<img
								src="${pageContext.request.contextPath}/brand2/image?uploadFileId=${banner.uploadFileId}"
								width="300px" />
						</div>
					</div>
				</div>

				<div class="label">메인 이미지</div>
				<div class="upload">
					<div id="imgPreviewWrapper" class="preview-wrapper">
						<div id="imgPreviewArea" class="preview-area" aria-live="polite">
							<img
								src="${pageContext.request.contextPath}/brand2/image?uploadFileId=${banner.uploadFileId}"
								width="300px" />
						</div>
					</div>
				</div>

				<div class="label">브랜드 전달내용</div>
				<div>
					<my:textArea id="bannerMessage" name="bannerMessage"
						readonly="true" placeholder="개최합니다."
						value="${banner.bannerMessage}" />
				</div>

				<div class="label req">이벤트 담당자</div>
				<div>
					<my:textInput id="managerName" name="managerName"
						placeholder="담당자 성함을 입력하세요." type="default" size="sm"
						state="default" />
				</div>

				<div class="label req">담당 연락처</div>
				<div>
					<my:textInput id="managerTel" name="managerTel"
						placeholder="담당연락처를 입력하세요." type="default" size="sm"
						state="default" />
				</div>

				<%--
이벤트 종류
COUPON (쿠폰) : coupon.coupon_id (?)
DISCOUNT (할인) : product.product_id, product.discount_type, product.discount_value
EXPERIENCE (체험단) : product.product_id
PICK (AD's PICK) : product.product_id
ETC(기타) : (?)
 --%>

				<!-- ============================================= 여기서부터 브랜드 입력폼 =============================================  -->

				<c:choose>

					<c:when test="${event.eventType eq 'COUPON'}">
						<div class="label req">쿠폰 선택</div>
						<div class="part_content">
							<div class="custom-select sm" id="couponSelect">
								<div class="select-header">
									<span>쿠폰 선택</span> <i class="bi bi-chevron-down"></i>
								</div>
								<ul class="select-list">
									<li class="select-item">쿠폰 선택</li>
									<c:forEach var="c" items="${coupons}">
										<li class="select-item" data-value="${c.couponId}">
											${c.cname}</li>
									</c:forEach>
								</ul>
								<input type="hidden" name="couponId" value="" />
							</div>
						</div>
					</c:when>


					<c:when test="${event.eventType eq 'DISCOUNT'}">
						<div class="label req">상품별 할인 등록</div>
						<div class="part_content" id="productList">
							<div class="product-row discount-row">

								<div class="field">
									<div class="custom-select sm" id="productSelect">
										<div class="select-header">
											<span>상품 선택</span> <i class="bi bi-chevron-down"></i>
										</div>
										<ul class="select-list">
											<li class="select-item">상품 선택</li>
											<c:forEach var="p" items="${products}">
												<li class="select-item" data-value="${p.productId}">
													${p.productName}</li>
											</c:forEach>
										</ul>
										<input type="hidden" name="productId[]" value="" />
									</div>
								</div>


								<div class="field">
									<div class="text-input-wrapper size--sm state--default">
										<div class="text-input-inner default">
											<input type="number" name="discountValue[]"
												class="text-input default" min="0" placeholder="할인율/금액 입력" />
										</div>
									</div>
								</div>

								<div class="field">
									<div class="text-input-wrapper size--sm state--default">
										<div class="text-input-inner default">
											<select name="discountType[]" class="text-input default">
												<option value="RATE">율 (%)</option>
												<option value="AMOUNT">금액 (원)</option>
											</select>
										</div>
									</div>
								</div>

								<button type="button" class="btn icon removeProduct"
									aria-label="상품 삭제">×</button>
							</div>
						</div>
						<div></div>
						<div class="product-actions">
							<button type="button" class="btn icon" id="addProductRow"
								aria-label="상품 추가">＋</button>
							<p class="help">여러 개 상품을 추가하고 각각 할인유형/값을 설정하세요.</p>
						</div>
					</c:when>

					<c:when test="${event.eventType eq 'EXPERIENCE'}">
						<div class="label req">체험 상품 선택</div>
						<div class="part_content">
							<div class="custom-select sm" id="experienceProductSelect">
								<div class="select-header">
									<span>상품 선택</span> <i class="bi bi-chevron-down"></i>
								</div>
								<ul class="select-list">
									<li class="select-item">상품 선택</li>
									<c:forEach var="p" items="${products}">
										<li class="select-item" data-value="${p.productId}">
											${p.productName}</li>
									</c:forEach>
								</ul>
								<input type="hidden" name="productIds[]" value="" />
							</div>
						</div>
					</c:when>

					<c:when test="${event.eventType eq 'PICK'}">
						<div class="label req">추천 상품 선택</div>
						<div class="part_content">
							<div class="custom-select sm" id="pickProductSelect">
								<div class="select-header">
									<span>상품 선택</span> <i class="bi bi-chevron-down"></i>
								</div>
								<ul class="select-list">
									<li class="select-item">상품 선택</li>
									<c:forEach var="p" items="${products}">
										<li class="select-item" data-value="${p.productId}">
											${p.productName}</li>
									</c:forEach>
								</ul>
								<input type="hidden" name="productIds[]" value="" />
							</div>
						</div>
					</c:when>
					<c:otherwise>
					</c:otherwise>
				</c:choose>



				<!-- ================================(구) 쿠폰 설정 쿠폰 발급 jsp 구현 ================================  -->
				<%--

				<div class="label">쿠폰 설정</div>
				<div>
					<div class="coupon-box" id="couponBox">

						<!-- grid -->
						<div class="grid"
							style="grid-template-columns: 140px 1fr; gap: 10px 12px">
							<div class="label req">쿠폰명</div>
							<div>
								<my:textInput id="couponName" name="cname"
									placeholder="쿠폰명을 입력하세요." type="default" size="sm"
									state="default" />
							</div>

							<div class="label req">기간</div>
							<div class="inline date-row">
								<input id="couponFrom" name="startDate" type="date"> <span>~</span>
								<input id="couponTo" name="endDate" type="date">
							</div>


							<div class="label req">최소주문</div>
							<div class="inline">
								<div class="text-input-wrapper size--sm state--default">
									<div class="text-input-inner default">
										<input id="couponMin" name="amountCondition" type="number"
											min="0" step="100" placeholder="0" class="text-input">
										<span class="muted">원 이상 구매 시</span>
									</div>
								</div>
							</div>


							<div class="label req">할인</div>
							<div class="inline">
								<div class="text-input-wrapper size--sm state--default">
									<div class="text-input-inner default">
										<input id="couponAmount" name="amount" type="number" min="0"
											step="100" placeholder="0" class="text-input"> <span
											class="muted">원 할인</span>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
--%>
				<!-- ==================================================================================  -->


				<div class="label">관리자 전달사항</div>
				<div>
					<my:textArea id="note" name="note" placeholder="관리자에게 문의&참고할 사항 전달" />
				</div>
			</div>

			<div class="footer">
				<button type="button" class="btn btn-outline btn-sm" id="btnClose"
					onclick="location.href='/brand2/eventList'">닫기</button>
				<button type="submit" class="btn btn-outline btn-sm" id="btnSubmit">신청하기</button>
			</div>


		</my:brand2formLayout>
	</my:layout>

	<script>
		document
				.getElementById("addProductRow")
				.addEventListener(
						"click",
						function() {
							const productList = document
									.getElementById("productList");
							const newRow = productList.querySelector(
									".product-row").cloneNode(true);
							// 입력값 초기화
							newRow.querySelector("select[name='productIds[]']").value = "";
							newRow
									.querySelector("input[name='discountValues[]']").value = "";
							newRow
									.querySelector("select[name='discountTypes[]']").value = "RATE";
							productList.appendChild(newRow);
						});

		document.addEventListener("click", function(e) {
			if (e.target.classList.contains("removeProduct")) {
				e.target.closest(".product-row").remove();
			}
		});
	</script>
</body>
</html>