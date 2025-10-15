<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


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
							<img
								src="${pageContext.request.contextPath}/image?fileId=${event.thumbnailFileId}"
								alt="대표 이미지" />
						</div>
					</div>
				</div>

				<div class="label">메인 이미지</div>
				<div class="upload">
					<div id="imgPreviewWrapper" class="preview-wrapper">
						<div id="imgPreviewArea" class="preview-area" aria-live="polite">
							<img
								src="${pageContext.request.contextPath}/image?fileId=${event.detailFileId}"
								alt="대표 이미지" width="588px" />
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


					<%-- ============================================== 상품별 할인 등록 ============================================== --%>
					<c:when test="${event.eventType eq 'DISCOUNT'}">
						<div class="label req">상품별 할인 등록</div>

						<div>
							<div class="field product-checkbox-list"
								style="display: grid; grid-template-columns: repeat(auto-fill, minmax(220px, 1fr)); gap: 10px;">
								<c:forEach var="p" items="${products}">
									<label class="product-item"
										style="display: flex; align-items: center; gap: 8px; padding: 6px 10px; border: 1px solid var(--line, #ddd); border-radius: 8px; cursor: pointer;">
										<input type="checkbox" class="product-check"
										data-id="${p.productId}" data-name="${fn:escapeXml(p.name)}"
										data-img="${pageContext.request.contextPath}/image?fileId=${p.thumbnailFileId}"
										value="${p.productId}" /> <img
										src="${pageContext.request.contextPath}/image?fileId=${p.thumbnailFileId}"
										alt="대표 이미지" width="50px" height="50px"
										style="object-fit: cover; border-radius: 4px;" /> <span
										style="flex: 1; font-size: 0.9rem;">${p.name}</span>
									</label>
								</c:forEach>
							</div>

							<div id="selectedProducts"
								style="display: flex; flex-direction: column; gap: 10px; margin-top: 10px;"></div>
						</div>
					</c:when>
					<%-- ============================================== 상품별 할인 등록 ============================================== --%>


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
											${p.name}</li>
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
											${p.name}</li>
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
		
		
					<script>
document.addEventListener("DOMContentLoaded", () => {
  console.log("DEBUG - DOMContentLoaded 실행됨");

  const productChecks = document.querySelectorAll(".product-check");
  const selectedContainer = document.getElementById("selectedProducts");

  console.log("DEBUG - 체크박스 개수:", productChecks.length);

  productChecks.forEach(chk => {
    chk.addEventListener("change", (e) => {
      const pid = e.target.dataset.id;
      const pname = e.target.dataset.name;
      const img = e.target.dataset.img;

      console.log("DEBUG - 클릭됨:", { pid, pname, img, checked: e.target.checked });

      if (e.target.checked) {
        // 선택된 상품 행 추가
        const row = document.createElement("div");
        row.classList.add("selected-row");
        row.setAttribute("data-id", pid);
        row.style.display = "flex";
        row.style.alignItems = "center";
        row.style.gap = "10px";
        row.style.border = "1px solid #ddd";
        row.style.padding = "8px 12px";
        row.style.borderRadius = "8px";

        row.innerHTML = `
          <input type="hidden" name="productId[]" value="${pid}">

          <!-- 상품 썸네일 -->
          <img src="${img}" width="50" height="50" 
               style="object-fit:cover; border-radius:4px;"/>

          <!-- 상품명 -->
          <span style="flex:1; min-width:150px;">${pname}</span>

          <!-- 할인 값 -->
          <div class="field" style="flex:0 0 120px;">
            <div class="text-input-wrapper size--sm state--default">
              <div class="text-input-inner default">
                <input type="number" name="discountValue[]" 
                       class="text-input default" min="0"
                       placeholder="할인율/금액 입력" value="" />
              </div>
            </div>
          </div>

          <!-- 할인 타입 -->
          <div class="field" style="flex:0 0 110px;">
            <div class="text-input-wrapper size--sm state--default">
              <div class="text-input-inner default">
                <select name="discountType[]" class="text-input default">
                  <option value="RATE">율 (%)</option>
                  <option value="AMOUNT">금액 (원)</option>
                </select>
              </div>
            </div>
          </div>

          <!-- 삭제 버튼 -->
          <button type="button" class="removeRow" 
                  style="margin-left:8px; height:32px; width:32px;">×</button>
        `;

        selectedContainer.appendChild(row);

        // 삭제 버튼
        row.querySelector(".removeRow").addEventListener("click", () => {
          console.log("DEBUG - 삭제:", pid, pname);
          e.target.checked = false;
          row.remove();
        });
      } else {
        // 체크 해제 시 삭제
        const row = selectedContainer.querySelector(`[data-id="${pid}"]`);
        if (row) {
          console.log("DEBUG - 체크 해제 → 삭제:", pid, pname);
          row.remove();
        }
      }
    });
  });
});
</script>
		
		
	</my:layout>

</body>

</html>