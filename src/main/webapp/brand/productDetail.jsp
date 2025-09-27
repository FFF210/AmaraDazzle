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
<link rel="stylesheet" href="./css/detailForm.css" />
</head>

<body class="<c:if test='${not empty product}'>edit-mode</c:if>">
	<my:layout>
		<div class="page-container">

			<!-- breadcrumb -->
			<div class="page-breadcrumb">
				<my:breadcrumb
					items="상품관리:/brand/productList,${not empty product ? '상품수정' : '상품등록'}:" />
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
				action="<c:out value='${not empty product ? "/productDetail/update" : "/productDetail/register"}'/>"
				method="post" enctype="multipart/form-data" class="product-form">

				<section class="form-section">
					<h3>상품 기본 정보</h3>

					<!-- 상품 ID -->
					<c:if test="${not empty product}">
						<div class="form-group">
							<label>상품코드</label>
							<my:textInput type="readOnly" state="default" size="lg"
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
						<my:textInput type="default" state="default" size="lg"
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
							value="special" class="form-radio"
							<c:if test="${product.isPlanned eq '1'}">checked</c:if> /> 기획상품
						</label>
					</div>

					<!-- 카테고리 -->
					<div class="form-group">
						<label>카테고리 <span class="required">*</span></label>
						<my:selectbox size="lg" items="추천순,인기순,최신순,낮은가격순,높은가격순"
							initial="대분류" />
						<my:selectbox size="lg" items="추천순,인기순,최신순,낮은가격순,높은가격순"
							initial="중분류" />
						<my:selectbox size="lg" items="추천순,인기순,최신순,낮은가격순,높은가격순"
							initial="소분류" />
					</div>

					<!-- 대표 이미지 -->
					<div class="form-group image">
						<label>대표 이미지 <span class="required">*</span></label>
						<my:imageBtn name="upload1" />
					</div>

					<!-- 추가 이미지 -->
					<div class="form-group image">
						<label>추가 이미지<br>(최대 5개)
						</label>

						<c:set var="imgCount" value="0" />

						<!-- 등록된 이미지 렌더링 -->
						<c:if test="${not empty product.image1File}">
							<my:imageBtn name="image1"
								value="${product.image1Path}/${product.image1File}" />
							<c:set var="imgCount" value="${imgCount + 1}" />
						</c:if>
						<c:if test="${not empty product.image2File}">
							<my:imageBtn name="image2"
								value="${product.image2Path}/${product.image2File}" />
							<c:set var="imgCount" value="${imgCount + 1}" />
						</c:if>
						<c:if test="${not empty product.image3File}">
							<my:imageBtn name="image3"
								value="${product.image3Path}/${product.image3File}" />
							<c:set var="imgCount" value="${imgCount + 1}" />
						</c:if>
						<c:if test="${not empty product.image4File}">
							<my:imageBtn name="image4"
								value="${product.image4Path}/${product.image4File}" />
							<c:set var="imgCount" value="${imgCount + 1}" />
						</c:if>
						<c:if test="${not empty product.image5File}">
							<my:imageBtn name="image5"
								value="${product.image5Path}/${product.image5File}" />
							<c:set var="imgCount" value="${imgCount + 1}" />
						</c:if>

						<!-- 이미지 개수에 따라 나머지 슬롯 채우기 -->
						<c:choose>
							<c:when test="${imgCount == 0}">
								<my:imageBtn name="image1" />
							</c:when>
							<c:otherwise>
								<c:forEach var="i" begin="${imgCount + 1}" end="5">
									<my:imageBtn name="image${i}" />
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</div>
				</section>

				<section class="form-section">
					<h3>상품 상세 정보</h3>

					<!-- 옵션 등록 -->
					<div class="form-group">
						<label>옵션 등록</label>
						<button type="submit" class="btn btn-primary btn-xl">추가</button>
						<my:selectbox size="lg" items="추천순,인기순,최신순,낮은가격순,높은가격순"
							initial="옵션" />
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

						<%-- 주요기능(피부 고민) 그룹 --%>
						<c:set var="skinIssueCodes"
							value="${not empty product.skinIssues ? fn:split(product.skinIssues, ',') : null}" />
						<div class="filter-group">
							<div class="filter-label">주요기능</div>
							<div class="filter-options">
								<c:forEach var="opt"
									items="ATOPIC:아토피,CALM:진정,MINERAL_UV:무기자차,ACNE:여드름,WHITENING:미백/잡티,SEBUM:피지/블랙헤드,DEADSKIN:각질,DARKCIRCLE:다크서클,PORE:모공,REDNESS:홍조,ANTIAGING:슬로우에이징,HYDRATION:피부보습/속건조,SUNBLOCK:자외선차단,NONE:해당없음"
									varStatus="st">
									<c:set var="code" value="${fn:split(opt,':')[0]}" />
									<c:set var="label" value="${fn:split(opt,':')[1]}" />
									<button
										class="filter-option ${skinIssueCodes ne null and fn:contains(product.skinIssues, code) ? 'active' : ''}"
										data-value="${code}">${label}</button>
								</c:forEach>
							</div>
						</div>

						<%-- 피부타입 그룹 --%>
						<c:set var="skinTypeCodes"
							value="${not empty product.skinTypes ? fn:split(product.skinTypes, ',') : null}" />
						<div class="filter-group">
							<div class="filter-label">피부타입</div>
							<div class="filter-options">
								<c:forEach var="opt"
									items="DRY:건성,OILY:지성,NORMAL:중성,SENSITIVE:민감성,COMBINATION:복합성,DEHYDRATED_OILY:수부지"
									varStatus="st">
									<c:set var="code" value="${fn:split(opt,':')[0]}" />
									<c:set var="label" value="${fn:split(opt,':')[1]}" />
									<button
										class="filter-option ${skinTypeCodes ne null and fn:contains(product.skinTypes, code) ? 'active' : ''}"
										data-value="${code}">${label}</button>
								</c:forEach>
							</div>
						</div>

						<%-- 퍼스널컬러 그룹 --%>
						<c:set var="personalColorCodes"
							value="${not empty product.personalColors ? fn:split(product.personalColors, ',') : null}" />
						<div class="filter-group">
							<div class="filter-label">퍼스널컬러</div>
							<div class="filter-options">
								<c:forEach var="opt"
									items="SPRING_WARM:봄웜톤,SUMMER_COOL:여름쿨톤,AUTUMN_WARM:가을웜톤,WINTER_COOL:겨울쿨톤,UNKNOWN:잘 모르겠어요"
									varStatus="st">
									<c:set var="code" value="${fn:split(opt,':')[0]}" />
									<c:set var="label" value="${fn:split(opt,':')[1]}" />
									<button
										class="filter-option ${personalColorCodes ne null and fn:contains(product.personalColors, code) ? 'active' : ''}"
										data-value="${code}">${label}</button>
								</c:forEach>
							</div>
						</div>
					</div>

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
							value="${not empty product ? formattedPrice : ''}" />
					</div>


					<!-- 할인가 (상품 수정시에만 표시) -->
					<c:if test="${not empty product}">
						<div class="form-group">
							<label>할인가</label>
							<fmt:formatNumber value="${product.price}" type="number"
								maxFractionDigits="0" groupingUsed="true"
								var="formattedSalePrice" />
							<my:textInput type="default" state="default" size="lg"
								value="${not empty product ? formattedSalePrice : ''}" />
						</div>
					</c:if>

					<!-- 주문수량제한 -->
					<div class="form-group">
						<label>주문수량제한</label>
						<my:textInput type="default" state="default" size="lg"
							value="${not empty product ? product.orderLimit : ''}" />
					</div>
				</section>

				<section class="form-section">
					<h3>재고 관리</h3>
					<div class="form-group">
						<label>재고 수량 <span class="required">*</span></label>
						<my:textInput size="lg"
							value="${not empty product ? product.stockQty : ''}" />
					</div>
				</section>

				<section class="form-section">
					<h3>배송 관리</h3>
					<div class="form-group radio">
						<label>배송 방법 <span class="required">*</span></label> <label>
							<input type="radio" name="shipping" value="basic"
							class="form-radio"
							<c:if test="${product.shippingMethod eq 'DEFAULT'}">checked</c:if> />
							기본 배송
						</label> <label> <input type="radio" name="shipping" value="free"
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
</body>

<script>
  document.addEventListener("DOMContentLoaded", () => {
    document.querySelectorAll(".filter-option").forEach(btn => {
      btn.addEventListener("click", (e) => {
        e.preventDefault();  // 폼 제출 막기
        btn.classList.toggle("active"); // 선택 토글 같은 동작 추가 가능
      });
    });
  });
  
  document.addEventListener("DOMContentLoaded", () => {
	  const container = document.querySelector(".form-group.image"); // 이미지 그룹 전체

	  // 동적으로 imageBtn 추가하는 함수
	  function addImageSlot(index) {
	    const wrapper = document.createElement("div");
	    wrapper.className = "image-button";
	    wrapper.innerHTML = `
	      <input type="file" id="image-${index}" name="image${index}" accept="image/*" hidden />
	      <label for="image-${index}" class="image-placeholder">
	        <span class="plus">＋</span>
	      </label>
	    `;
	    container.appendChild(wrapper);

	    const input = wrapper.querySelector("input[type='file']");
	    input.addEventListener("change", () => handleFileSelect(input, wrapper));
	  }

	  // 파일 선택 시 미리보기 & 삭제 버튼
	  function handleFileSelect(input, wrapper) {
	    if (input.files && input.files[0]) {
	      const reader = new FileReader();
	      reader.onload = e => {
	        wrapper.innerHTML = `
	          <div class="image-preview">
	            <img src="${e.target.result}" alt="preview" />
	            <button type="button" class="remove-btn">&times;</button>
	          </div>
	        `;
	        // 삭제 버튼 이벤트
	        wrapper.querySelector(".remove-btn").addEventListener("click", () => {
	          wrapper.remove();
	          ensureEmptySlot(); // 최소 1개 빈 슬롯 유지
	        });
	      };
	      reader.readAsDataURL(input.files[0]);

	      // 업로드한 후 → 빈 슬롯 추가 (최대 5개까지만)
	      ensureEmptySlot();
	    }
	  }

	  // 빈 슬롯 유지 (항상 마지막에 하나)
	  function ensureEmptySlot() {
	    const slots = container.querySelectorAll(".image-button input[type='file']");
	    const previews = container.querySelectorAll(".image-preview");
	    const total = slots.length + previews.length;

	    if (total < 5) {
	      // 이미 빈 슬롯 없으면 추가
	      if (!container.querySelector(".image-button input[type='file']")) {
	        addImageSlot(total + 1);
	      }
	    }
	  }

	  // 초기 상태: 최소 1개는 보이도록
	  ensureEmptySlot();
	});


</script>
</html>

