<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
				<!-- ====== 상품 카테고리 (readonly input) ====== -->
				<c:if
					test="${not empty event.category1Id 
          or not empty event.category2Id 
          or not empty event.category3Id}">
					<div class="label">상품 카테고리</div>
					<div class="part_content select_cate">

						<!-- 대분류 -->
						<c:if test="${not empty event.category1Id}">
							<my:textInput id="largeCategoryName" name="largeCategoryName"
								type="readOnly" size="sm" state="default"
								value="${event.largeCategoryName}" />
							<input type="hidden" name="category1Id"
								value="${event.category1Id}" />
						</c:if>

						<!-- 중분류 -->
						<c:if test="${not empty event.category2Id}">
							<my:textInput id="middleCategoryName" name="middleCategoryName"
								type="readOnly" size="sm" state="default"
								value="${event.middleCategoryName}" />
							<input type="hidden" name="category2Id"
								value="${event.category2Id}" />
						</c:if>

						<!-- 소분류 -->
						<c:if test="${not empty event.category3Id}">
							<my:textInput id="smallCategoryName" name="smallCategoryName"
								type="readOnly" size="sm" state="default"
								value="${event.smallCategoryName}" />
							<input type="hidden" name="category3Id"
								value="${event.category3Id}" />
						</c:if>

					</div>
				</c:if>

				<div class="label">썸네일</div>
				<div class="upload">
					<div id="imgPreviewWrapper" class="preview-wrapper">
						<div id="imgPreviewArea" class="preview-area" aria-live="polite">
							<%-- <img src="/upload/${event.detailFileId}" /> --%>
							<img src="${pageContext.request.contextPath}/image?fileId=${event.thumbnailFileId}" alt="대표 이미지" />
						</div>
					</div>
				</div>

				<div class="label">메인 이미지</div>
				<div class="upload">
					<div id="imgPreviewWrapper" class="preview-wrapper">
						<div id="imgPreviewArea" class="preview-area" aria-live="polite">
							<%-- <img src="/upload/${event.detailFileId}" /> --%>
							<img src="${pageContext.request.contextPath}/image?fileId=${event.detailFileId}" alt="대표 이미지" width="588px"/>
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
						<div class="label">쿠폰 목록</div>
						<div class="part_content">
							<c:forEach var="c" items="${eventCoupons}">
								<div class="field">
									<div class="text-input-wrapper size--sm state--default">
										<div class="text-input-inner default">
											<input type="text" class="text-input default"
												value="${c.cname}" readonly />
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</c:when>

					<c:when test="${event.eventType eq 'DISCOUNT'}">
						<div class="label req">상품별 할인 등록</div>
						<div class="part_content" id="productList"
							style="display: flex; flex-direction: column; gap: 10px;">
							<div class="product-row discount-row"
								style="gap: 4px; flex-direction: column;">

								<!-- 상품 선택 -->
								<div class="field">
									<div class="custom-select md" style="width: 100%;">
										<div class="select-header">
											<span>상품 선택</span> <i class="bi bi-chevron-down"></i>
										</div>
										<ul class="select-list">
											<li class="select-item" data-value="">상품 선택</li>
											<c:forEach var="p" items="${products}">
												<li class="select-item" data-value="${p.productId}"
													<c:if test="${not empty p.eventId and p.eventId eq event.eventId}">
													class="selected"
														</c:if>>
													${p.name}</li>
											</c:forEach>
										</ul>
										<!-- 선택된 상품 ID 저장 -->
										<input type="hidden" name="productId[]" value="" />
									</div>
								</div>


								<div style="display: flex; gap: 4px;">
									<!-- 할인 값 -->
									<div class="field">
										<div class="text-input-wrapper size--sm state--default">
											<div class="text-input-inner default">
												<input type="number" name="discountValue[]"
													class="text-input default" min="0" placeholder="할인율/금액 입력"
													value="" />
											</div>
										</div>
									</div>

									<!-- 할인 타입 -->
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
										aria-label="상품 삭제" style="height: 40px; width: 40px;">×</button>
								</div>
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
								<input type="hidden" name="productId[]" value="" />
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
								<input type="hidden" name="productId[]" value="" />
							</div>
						</div>
					</c:when>
					<c:otherwise>
					</c:otherwise>
				</c:choose>

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
document.addEventListener("DOMContentLoaded", function () {

	// ===== 커스텀 셀렉트 (이벤트 위임 기반) =====
    document.addEventListener("click", function (e) {
        const header = e.target.closest(".select-header");
        const selectBox = e.target.closest(".custom-select");

        // 1️⃣ 헤더 클릭 → 열기/닫기
        if (header && selectBox) {
            e.stopPropagation();

            // 다른 셀렉트 닫기
            document.querySelectorAll(".custom-select.open").forEach(s => {
                if (s !== selectBox) s.classList.remove("open");
            });

            selectBox.classList.toggle("open");
            return;
        }

        // 2️⃣ 옵션 클릭 → 선택 처리
        const item = e.target.closest(".select-item");
        if (item && selectBox) {
            const headerText = selectBox.querySelector(".select-header span");
            const hiddenInput = selectBox.querySelector("input[type=hidden]");
            const items = selectBox.querySelectorAll(".select-item");

            const value = item.dataset.value;
            const text = item.textContent.trim();

            if (hiddenInput) hiddenInput.value = value;
            if (headerText) headerText.textContent = text;

            items.forEach(li => li.classList.remove("active", "selected"));
            item.classList.add("active");

            selectBox.classList.remove("open");
            return;
        }

        // 3️⃣ 외부 클릭 시 모든 드롭다운 닫기
        document.querySelectorAll(".custom-select.open").forEach(s => s.classList.remove("open"));
    });

    // ===== 상품 행 추가 =====
    const addBtn = document.getElementById("addProductRow");
    const productList = document.getElementById("productList");

    if (addBtn && productList) {
        addBtn.addEventListener("click", function () {
            const firstRow = productList.querySelector(".product-row");
            if (!firstRow) return;

            const newRow = firstRow.cloneNode(true);

            // 초기화
            newRow.querySelectorAll("input, select").forEach(el => {
                if (el.type === "hidden" || el.type === "number") el.value = "";
                if (el.tagName === "SELECT") el.value = "RATE";
            });

            const headerText = newRow.querySelector(".select-header span");
            if (headerText) headerText.textContent = "상품 선택";

            newRow.querySelectorAll(".select-item").forEach(li => li.classList.remove("active", "selected"));

            productList.appendChild(newRow);
        });
    }

    // ===== 상품 행 삭제 =====
    if (productList) {
        productList.addEventListener("click", function (e) {
            if (e.target.classList.contains("removeProduct")) {
                const rows = productList.querySelectorAll(".product-row");
                if (rows.length > 1) {
                    e.target.closest(".product-row").remove();
                } else {
                    alert("최소 1개의 상품은 유지해야 합니다.");
                }
            }
        });
    }
});
</script>





</body>
</html>