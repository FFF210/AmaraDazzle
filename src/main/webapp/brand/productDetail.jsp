<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title><c:choose>
		<c:when test="${not empty product}">상품 수정</c:when>
		<c:otherwise>상품 등록</c:otherwise>
	</c:choose></title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="../tagcss/reset.css" />
<link rel="stylesheet" href="../tagcss/button.css" />
<link rel="stylesheet" href="../tagcss/form-controls.css" />
<link rel="stylesheet" href="../tagcss/layout.css" />
<link rel="stylesheet" href="../tagcss/sidebar.css" />
<link rel="stylesheet" href="../tagcss/brandHeader.css" />
<link rel="stylesheet" href="../tagcss/selectbox.css" />
<link rel="stylesheet" href="../tagcss/imageBtn.css" />
<link rel="stylesheet" href="../tagcss/dialog.css" />
<link rel="stylesheet" href="../tagcss/textInput.css" />
<link rel="stylesheet" href="../tagcss/textArea.css" />
<link rel="stylesheet" href="../tagcss/breadcrumb.css" />
<link rel="stylesheet" href="../tagcss/uploader.css" />
<link rel="stylesheet" href="./css/alert.css" />
<link rel="stylesheet" href="./css/detailForm.css" />

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
</head>

<body class="<c:if test='${not empty product}'>edit-mode</c:if>">
	<!-- Toast 알림 컨테이너 -->
	<div id="toast-container"></div>

	<!-- 옵션 모달 -->
	<div id="optionDialog" class="modal">
		<div class="modal-overlay"></div>
		<div class="modal-content">
			<h3 class="modal-title">상품 옵션 추가</h3>
			<p class="modal-subTitle">상품에 다양한 옵션을 등록할 수 있습니다.</p>
			<div class="modal-body">
				<!-- 폼 내용 -->
				<div class="form-row">
					<label class="form-row-label">옵션명</label>
					<my:textInput type="default" name="optionName"
						placeholder="예: 100ml / 레드" size="sm" />
				</div>
				<div class="form-row">
					<label class="form-row-label">판매가</label>
					<my:textInput type="default" name="optionPrice" placeholder="20000"
						size="sm" />
				</div>
				<div class="form-row">
					<label class="form-row-label">재고 수량</label>
					<my:textInput type="default" name="optionStock" placeholder="100"
						size="sm" />
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-outline btn-md"
					data-action="취소">취소</button>
				<button type="button" class="btn btn-primary btn-md"
					data-action="추가">추가</button>
			</div>
		</div>
	</div>
	<my:layout>
		<div class="page-container">

			<!-- breadcrumb -->
			<div class="page-breadcrumb">
				<my:breadcrumb
					items="상품목록:/brand/productList,${not empty product ? '상품수정' : '상품등록'}:" />
			</div>

			<!-- 페이지 헤더 -->
			<div class="page-header">
				<h2>
					<c:choose>
						<c:when test="${not empty product}">상품 수정</c:when>
						<c:otherwise>상품 등록</c:otherwise>
					</c:choose>
				</h2>
			</div>

			<!-- 상품 등록/수정 폼 -->
			<form
				action="<c:out value='${not empty product ? "/brand/productDetail/update" : "/brand/productDetail/register"}'/>"
				method="post" enctype="multipart/form-data" class="product-form"
				data-product-id="${product.productId}">

				<section class="form-section">
					<h3>상품 기본 정보</h3>

					<!-- 상품 ID -->
					<c:if test="${not empty product}">
						<div class="form-group">
							<label>상품코드</label>
							<my:textInput type="readOnly" state="default" size="lg"
								name="productId"
								value="${not empty product ? product.productId : ''}" />
						</div>
					</c:if>

					<!-- 상품 등록일 -->
					<c:if test="${not empty product}">
						<div class="form-group">
							<label>등록일</label>
							<my:textInput type="readOnly" state="default" size="lg"
								value="${not empty product ? product.createdAt : ''}" />
						</div>
					</c:if>

					<!-- 상품 최근 수정일 -->
					<c:if test="${not empty product}">
						<div class="form-group">
							<label>최근 수정일</label>
							<my:textInput type="readOnly" state="default" size="lg"
								value="${not empty product ? product.updatedAt : ''}" />
						</div>
					</c:if>

					<!-- 상품명 -->
					<div class="form-group">
						<label>상품명 <span class="required">*</span></label>
						<my:textInput type="default" state="default" size="lg" name="name"
							value="${not empty product ? product.name : ''}" />
					</div>

					<!-- 단독 판매 여부 -->
					<div class="form-group radio">
						<label>단독 판매 여부 <span class="required">*</span></label> <label>
							<input type="radio" name="exclusive" value="Y" class="form-radio"
							<c:if test="${product.isExclusive eq '1'}">checked</c:if> /> 단독
						</label> <label> <input type="radio" name="exclusive" value="N"
							class="form-radio"
							<c:if test="${product.isExclusive eq '0'}">checked</c:if> /> 비단독
						</label>
					</div>

					<!-- 상품 공개 여부 -->
					<div class="form-group radio">
						<label>상품 공개 여부 <span class="required">*</span></label> <label>
							<input type="radio" name="visible" value="Y" class="form-radio"
							<c:if test="${product.isVisible eq '1'}">checked</c:if> /> 공개
						</label> <label> <input type="radio" name="visible" value="N"
							class="form-radio"
							<c:if test="${product.isVisible eq '0'}">checked</c:if> /> 비공개
						</label>
					</div>

					<!-- 상품 정보 -->
					<div class="form-group radio">
						<label>상품 정보 <span class="required">*</span></label> <label>
							<input type="radio" name="productType" value="normal"
							class="form-radio"
							<c:if test="${product.isPlanned eq '0'}">checked</c:if> /> 일반상품
						</label> <label> <input type="radio" name="productType"
							value="plan" class="form-radio"
							<c:if test="${product.isPlanned eq '1'}">checked</c:if> /> 기획상품
						</label>
					</div>

					<!-- 카테고리 -->
					<div class="form-group">
						<label>카테고리 <span class="required">*</span></label>
						<my:selectbox size="lg" items="대분류" initial="대분류" id="largeSelect" />
						<input type="hidden" name="category1Id" id="category1Id" />

						<my:selectbox size="lg" items="중분류" initial="중분류"
							id="middleSelect" />
						<input type="hidden" name="category2Id" id="category2Id" />

						<my:selectbox size="lg" items="소분류" initial="소분류" id="smallSelect" />
						<input type="hidden" name="category3Id" id="category3Id" />
					</div>

					<!-- 대표 이미지 -->
					<div class="form-group image">
						<label>대표 이미지 <span class="required">*</span></label>
						<div class="image-slot">
							<img
								src="${not empty product.thumbnailFileId 
              ? pageContext.request.contextPath.concat('/image?fileId=').concat(product.thumbnailFileId)
              : pageContext.request.contextPath.concat('/image/plus.png')}"
								id="preview-thumbnail" alt="대표 이미지" width="100px"
								onclick="document.getElementById('thumbnail').click();" /> <input
								type="file" id="thumbnail" name="thumbnail" accept="image/*"
								style="display: none"
								onchange="readURL(this,'preview-thumbnail');" />
						</div>
					</div>


					<!-- 추가 이미지 -->
					<div class="form-group image">
						<label>추가 이미지<br>(최대 5개)
						</label>

						<c:forEach var="i" begin="1" end="5">
							<c:set var="fileId">
								<c:choose>
									<c:when test="${i == 1}">${product.image1FileId}</c:when>
									<c:when test="${i == 2}">${product.image2FileId}</c:when>
									<c:when test="${i == 3}">${product.image3FileId}</c:when>
									<c:when test="${i == 4}">${product.image4FileId}</c:when>
									<c:when test="${i == 5}">${product.image5FileId}</c:when>
								</c:choose>
							</c:set>

							<div class="image-slot">
								<img
									src="${not empty fileId 
                ? pageContext.request.contextPath.concat('/image?fileId=').concat(fileId) 
                : pageContext.request.contextPath.concat('/image/plus.png')}"
									id="preview-image${i}" alt="추가 이미지${i}" width="100px"
									onclick="document.getElementById('image${i}').click();" /> <input
									type="file" id="image${i}" name="image${i}" accept="image/*"
									style="display: none"
									onchange="readURL(this,'preview-image${i}');" />
							</div>
						</c:forEach>
					</div>


				</section>

				<section class="form-section">
					<h3>상품 상세 정보</h3>

					<!-- 옵션 등록 영역 -->
					<div class="form-group">
						<label>옵션 등록</label>
						<button type="button" id="openOptionDialog"
							class="btn btn-primary btn-xl">추가</button>

						<!-- 커스텀 selectbox -->
						<my:selectbox size="lg" items=" " initial="옵션"
							id="optionSelectBox" />

						<!-- hidden input (서버 전송용) -->
						<input type="hidden" id="optionHidden" name="optionValues" />
					</div>

					<!-- 맞춤 필터링 -->
					<div class="form-filter">
						<div class="form-group">
							<label>맞춤 필터링</label>
							<p>
								고객의 피부타입·퍼스널컬러·피부고민에 따라 상품을 자동 추천합니다.<br /> 해당 태그를 선택하면 이 상품이
								개인화 추천 영역에 노출될 확률이 높아집니다.<br /> <span>상품과 무관한 태그 선택 시 추천
									품질이 저하될 수 있습니다.</span>
							</p>
						</div>

						<%-- 피부고민 그룹 --%>
						<c:set var="skinIssueCodes"
							value="${not empty product.skinIssues ? fn:split(product.skinIssues, ',') : null}" />
						<div class="filter-group" data-group="skinIssues">
							<div class="filter-label">주요기능</div>
							<div class="filter-options">
								<c:forEach var="opt"
									items="1:아토피,2:진정,3:여드름,4:미백/잡티,5:피지/블랙헤드,6:각질,7:다크서클,8:모공,9:홍조,10:슬로우에이징,11:피부보습/속건조,12:자외선차단,13:해당없음"
									varStatus="st">
									<c:set var="id" value="${fn:split(opt,':')[0]}" />
									<c:set var="label" value="${fn:split(opt,':')[1]}" />
									<button
										class="filter-option ${skinIssueCodes ne null and fn:contains(product.skinIssues, id) ? 'active' : ''}"
										data-value="${id}">${label}</button>
								</c:forEach>
							</div>
						</div>

						<%-- 피부타입 그룹 --%>
						<c:set var="skinTypeCodes"
							value="${not empty product.skinTypes ? fn:split(product.skinTypes, ',') : null}" />
						<div class="filter-group" data-group="skinTypes">
							<div class="filter-label">피부타입</div>
							<div class="filter-options">
								<c:forEach var="opt"
									items="14:건성,15:지성,16:중성,17:민감성,18:복합성,19:수부지" varStatus="st">
									<c:set var="id" value="${fn:split(opt,':')[0]}" />
									<c:set var="label" value="${fn:split(opt,':')[1]}" />
									<button
										class="filter-option ${skinTypeCodes ne null and fn:contains(product.skinTypes, id) ? 'active' : ''}"
										data-value="${id}">${label}</button>
								</c:forEach>
							</div>
						</div>


						<%-- 퍼스널컬러 그룹 --%>
						<c:set var="personalColorCodes"
							value="${not empty product.personalColors ? fn:split(product.personalColors, ',') : null}" />
						<div class="filter-group" data-group="personalColors">
							<div class="filter-label">퍼스널컬러</div>
							<div class="filter-options">
								<c:forEach var="opt"
									items="20:봄웜톤,21:여름쿨톤,22:가을웜톤,23:겨울쿨톤,24:잘 모르겠어요"
									varStatus="st">
									<c:set var="id" value="${fn:split(opt,':')[0]}" />
									<c:set var="label" value="${fn:split(opt,':')[1]}" />
									<button
										class="filter-option ${personalColorCodes ne null and fn:contains(product.personalColors, id) ? 'active' : ''}"
										data-value="${id}">${label}</button>
								</c:forEach>
							</div>
						</div>

					</div>
					<!-- 필터 hidden input -->
					<input type="hidden" name="skinIssues" id="skinIssues" /> <input
						type="hidden" name="skinTypes" id="skinTypes" /> <input
						type="hidden" name="personalColors" id="personalColors" />

					<!-- 상세 설명 -->
					<%-- <div class="form-group image">
						<label>상세 설명 <span class="required">*</span></label>
						<my:uploader size="lg" id="fileInput1" label="Click to upload"
							desc="또는 파일을 이 영역으로 드래그하세요" />
					</div> --%>

					<!-- 성분 -->
					<div class="form-group">
						<label>성분 <span class="required">*</span></label>
						<my:textArea name="ingredients" placeholder="입력" maxLength="200"
							showCount="true"
							value="${not empty product ? product.ingredients : ''}" />
					</div>
				</section>

				<section class="form-section">
					<h3>가격 정보</h3>

					<!-- 판매가 -->
					<div class="form-group">
						<label>판매가 <span class="required">*</span></label>
						<fmt:formatNumber value="${product.price}" type="number"
							maxFractionDigits="0" groupingUsed="true" var="formattedPrice" />
						<my:textInput type="default" state="default" size="lg"
							name="price" value="${not empty product ? formattedPrice : ''}" />
					</div>


					<!-- 할인가 (상품 수정시에만 표시) -->
					<c:if test="${not empty product}">
						<div class="form-group">
							<label>할인가</label>
							<fmt:formatNumber value="${product.price}" type="number"
								maxFractionDigits="0" groupingUsed="true"
								var="formattedSalePrice" />
							<my:textInput type="readOnly" state="default" size="lg"
								name="salePrice"
								value="${not empty product ? formattedSalePrice : ''}" />
						</div>
					</c:if>

					<!-- 주문수량제한 -->
					<div class="form-group">
						<label>주문수량제한</label>
						<my:textInput type="default" state="default" size="lg"
							name="orderLimit"
							value="${not empty product ? product.orderLimit : ''}" />
					</div>
				</section>

				<section class="form-section">
					<h3>재고 관리</h3>
					<div class="form-group">
						<label>재고 수량 <span class="required">*</span></label>
						<my:textInput size="lg" name="stockQty"
							value="${not empty product ? product.stockQty : ''}" />
					</div>
				</section>

				<section class="form-section">
					<h3>배송 관리</h3>
					<div class="form-group radio">
						<label>배송 방법 <span class="required">*</span></label> <label>
							<input type="radio" name="shipping" value="DEFAULT"
							class="form-radio"
							<c:if test="${product.shippingMethod eq 'DEFAULT'}">checked</c:if> />
							기본 배송
						</label> <label> <input type="radio" name="shipping" value="FREE"
							class="form-radio"
							<c:if test="${product.shippingMethod eq 'FREE'}">checked</c:if> />
							무료 배송
						</label>
					</div>
				</section>

				<!-- 버튼 -->
				<div class="form-actions">
					<c:if test="${not empty product}">
						<button type="button" class="btn btn-outline btn-xl"
							onclick="history.back()">취소</button>
					</c:if>
					<button type="submit" class="btn btn-primary btn-xl">
						<c:choose>
							<c:when test="${not empty product}">수정</c:when>
							<c:otherwise>등록</c:otherwise>
						</c:choose>
					</button>
				</div>
			</form>
		</div>
	</my:layout>
	<script src="./js/dialog.js"></script>
	<script src="./js/toast.js"></script>
	<script src="./js/selectbox.js"></script>
	<script>
  /*********************************************************************************************************
   * 카테고리 selectbox
   *********************************************************************************************************/
   document.addEventListener("DOMContentLoaded", () => {
     const largeSelect = document.getElementById("largeSelect");
     const middleSelect = document.getElementById("middleSelect");
     const smallSelect  = document.getElementById("smallSelect");

     // selectbox 내부를 갱신하는 함수 (li 생성)
     function updateSelectbox(selectElem, items, placeholder) {
       const list = selectElem.querySelector(".select-list");
       const label = selectElem.querySelector(".select-label");

       // 초기화
       list.innerHTML = "";
       label.textContent = placeholder;

       // 항목 추가
       items.forEach(c => {
         const li = document.createElement("li");
         li.className = "select-item";
         li.dataset.value = c.categoryId;
         li.textContent = c.name;
         list.appendChild(li);

         li.addEventListener("click", () => {
           label.textContent = c.name;
           list.querySelectorAll(".select-item").forEach(i => i.classList.remove("active"));
           li.classList.add("active");

           const event = new CustomEvent("selectChanged", {
             detail: { value: c.categoryId, text: c.name }
           });
           selectElem.dispatchEvent(event);
         });
       });
     }

     // 대분류 불러오기
     fetch("/category?type=large")
       .then(res => res.json())
       .then(data => {
         updateSelectbox(largeSelect, data, "대분류");
       });

     // 대분류 선택 → 중분류 불러오기
     largeSelect.addEventListener("selectChanged", e => {
    	 document.getElementById("category1Id").value = e.detail.value;
       const parentId = e.detail.value;
       if (!parentId) return;

       fetch(`/category?type=middle&parentId=\${parentId}`)
         .then(res => res.json())
         .then(data => {
           updateSelectbox(middleSelect, data, "중분류");
           updateSelectbox(smallSelect, [], "소분류"); // 초기화
         });
     });

     // 중분류 선택 → 소분류 불러오기
     middleSelect.addEventListener("selectChanged", e => {
    	 document.getElementById("category2Id").value = e.detail.value;
       const parentId = e.detail.value;
       if (!parentId) return;

       fetch(`/category?type=small&parentId=\${parentId}`)
         .then(res => res.json())
         .then(data => {
           updateSelectbox(smallSelect, data, "소분류");
         });
     });
     
  	// 소분류 선택 → hidden 업데이트
     smallSelect.addEventListener("selectChanged", e => {
       document.getElementById("category3Id").value = e.detail.value;
     });
   });
  
  /*********************************************************************************************************
   * 이미지 버튼
   *********************************************************************************************************/
   function readURL(input, previewId) {
	    if (input.files && input.files[0]) {
	      const reader = new FileReader();
	      reader.onload = function(e) {
	        document.getElementById(previewId).src = e.target.result;
	      }
	      reader.readAsDataURL(input.files[0]);
	    }
	  }

 /*********************************************************************************************************
  * 옵션 등록 모달 오픈
  *********************************************************************************************************/
  function resetOptionDialog() {
	  const dialog = document.getElementById("optionDialog");
	  dialog.querySelectorAll("input").forEach(input => {
	    input.value = "";
	  });
	}
 
 //공통 이벤트 연결
 document.addEventListener("dialogAction", (e) => {
  const { id, action } = e.detail;
  dialogHandlers[id]?.[action]?.();
});
 
 // 버튼 이벤트: 모달 열기
 // 옵션 등록 버튼
document.getElementById("openOptionDialog")?.addEventListener("click", () => {
	resetOptionDialog(); 
  	openDialog("optionDialog");
});
 
/*********************************************************************************************************
 * 옵션 임시 저장 (메모리)
 *********************************************************************************************************/
let optionList = []; // 모달에서 입력된 옵션들을 보관

// 커스텀 selectbox 업데이트 함수 재활용
function updateSelectbox(selectElem, items, placeholder) {
  const list = selectElem.querySelector(".select-list");
  const label = selectElem.querySelector(".select-label");

  // 초기화
  list.innerHTML = "";
  label.textContent = placeholder;

  // 항목 추가
  items.forEach(str => {
    const li = document.createElement("li");
    li.className = "select-item";
    li.dataset.value = str;
    li.textContent = str;
    list.appendChild(li);

    li.addEventListener("click", () => {
      label.textContent = str;
      list.querySelectorAll(".select-item").forEach(i => i.classList.remove("active"));
      li.classList.add("active");

      const event = new CustomEvent("selectChanged", {
        detail: { value: str, text: str }
      });
      selectElem.dispatchEvent(event);
    });
  });
}

const dialogHandlers = {
  optionDialog: {
    추가: () => {
      const dialog = document.getElementById("optionDialog");

      // 값 읽기
      const optionName = dialog.querySelector("input[name='optionName']").value.trim();
      const optionPrice = dialog.querySelector("input[name='optionPrice']").value.trim();
      const optionStock = dialog.querySelector("input[name='optionStock']").value.trim();

      if (!optionName || !optionPrice || !optionStock) {
        showToast("warning", "모든 항목을 입력해주세요.");
        return;
      }

      // 옵션을 메모리에 추가
      optionList.push({
        name: optionName,
        price: optionPrice,
        stock: optionStock
      });

      // 표시용 문자열 (예: "100ml/20000/100")
      const optionStrList = optionList.map(
        o => `\${o.name}/\${o.price}/\${o.stock}`
      );

      // 커스텀 selectbox 다시 렌더링
      const optionSelect = document.getElementById("optionSelectBox");
      if (optionSelect) {
        updateSelectbox(optionSelect, optionStrList, "옵션 선택");
      }

      // hidden input에도 옵션리스트 저장 (폼 전송용)
      document.getElementById("optionHidden").value = optionStrList.join(",");

      // 모달 닫기 + 알림
      closeDialog("optionDialog");
      showToast("success", "옵션이 추가되었습니다.");
    }
  }
};

/*********************************************************************************************************
 * 필터 버튼 선택 → hidden input 업데이트
 *********************************************************************************************************/
document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll(".filter-group").forEach(group => {
    const hiddenId = group.dataset.group;
    const hidden = document.getElementById(hiddenId);
    const buttons = group.querySelectorAll(".filter-option");

    buttons.forEach(btn => {
      btn.addEventListener("click", e => {
        e.preventDefault();
        btn.classList.toggle("active");

        const values = Array.from(buttons)
          .filter(b => b.classList.contains("active"))
          .map(b => b.dataset.value);

        hidden.value = values.join(",");
        console.log(hiddenId + " => " + hidden.value);
      });
    });
  });
});
</script>
</body>
</html>

