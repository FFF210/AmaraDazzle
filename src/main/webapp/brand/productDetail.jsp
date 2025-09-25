<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ page import="java.util.*"%>

<%-- <%
// === 테스트용 product 데이터 ===
Map<String, Object> dummyProduct = new HashMap<>();
dummyProduct.put("id", 123);
dummyProduct.put("name", "테스트 상품");
dummyProduct.put("exclusive", "Y");
dummyProduct.put("visible", "Y");
dummyProduct.put("productType", "normal");
dummyProduct.put("categoryLarge", "화장품");
dummyProduct.put("mainImage", "sample.jpg");
dummyProduct.put("stock", 100);
dummyProduct.put("description", "이건 테스트 상품 설명입니다.");
dummyProduct.put("ingredients", "정제수, 글리세린");

request.setAttribute("product", dummyProduct);
%> --%>

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
<link rel="stylesheet" href="./css/reset.css" />
<link rel="stylesheet" href="./css/button.css" />
<link rel="stylesheet" href="./css/form-controls.css" />
<link rel="stylesheet" href="./css/layout.css" />
<link rel="stylesheet" href="./css/sidebar.css" />
<link rel="stylesheet" href="./css/header.css" />
<link rel="stylesheet" href="./css/selectbox.css" />
<link rel="stylesheet" href="./css/imageBtn.css" />
<link rel="stylesheet" href="./css/dialog.css" />
<link rel="stylesheet" href="./css/textInput.css" />
<link rel="stylesheet" href="./css/textArea.css" />
<link rel="stylesheet" href="./css/breadcrumb.css" />
<link rel="stylesheet" href="./css/uploader.css" />
<link rel="stylesheet" href="./css/detailForm.css" />
</head>

<body class="<c:if test='${not empty product}'>edit-mode</c:if>">
	<my:layout>
		<div class="page-container">

			<!-- breadcrumb -->
			<div class="page-breadcrumb">
				<my:breadcrumb
					items="상품관리:/product,${not empty product ? '상품수정' : '상품등록'}:" />
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
				action="<c:out value='${not empty product ? "/product/update" : "/product/register"}'/>"
				method="post" enctype="multipart/form-data" class="product-form">

				<section class="form-section">
					<h3>상품 기본 정보</h3>

					<!-- 상품 ID -->
					<c:if test="${not empty product}">
						<div class="form-group">
							<label>상품코드</label>
							<my:textInput type="default" state="default" size="lg"
								value="${not empty product ? product.id : ''}" />
						</div>
					</c:if>

					<!-- 상품 등록일 -->
					<c:if test="${not empty product}">
						<div class="form-group">
							<label>등록일</label>
							<my:textInput type="default" state="default" size="lg"
								value="${not empty product ? product.createdAt : ''}" />
						</div>
					</c:if>

					<!-- 상품 최근 수정일 -->
					<c:if test="${not empty product}">
						<div class="form-group">
							<label>최근 수정일</label>
							<my:textInput type="default" state="default" size="lg"
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
							<c:if test="${product.exclusive eq 'Y'}">checked</c:if> /> 단독
						</label> <label> <input type="radio" name="exclusive" value="N"
							class="form-radio"
							<c:if test="${product.exclusive eq 'N'}">checked</c:if> /> 비단독
						</label>
					</div>

					<!-- 상품 공개 여부 -->
					<div class="form-group radio">
						<label>상품 공개 여부 <span class="required">*</span></label> <label>
							<input type="radio" name="visible" value="Y" class="form-radio"
							<c:if test="${product.visible eq 'Y'}">checked</c:if> /> 공개
						</label> <label> <input type="radio" name="visible" value="N"
							class="form-radio"
							<c:if test="${product.visible eq 'N'}">checked</c:if> /> 비공개
						</label>
					</div>

					<!-- 상품 정보 -->
					<div class="form-group radio">
						<label>상품 정보 <span class="required">*</span></label> <label>
							<input type="radio" name="productType" value="normal"
							class="form-radio"
							<c:if test="${product.productType eq 'normal'}">checked</c:if> />
							일반상품
						</label> <label> <input type="radio" name="productType"
							value="special" class="form-radio"
							<c:if test="${product.productType eq 'special'}">checked</c:if> />
							기획상품
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
						<label>추가 이미지</label>
						<my:imageBtn name="upload1" />
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

						<%-- 주요기능 그룹 --%>
						<div class="filter-group">
							<div class="filter-label">주요기능</div>
							<div class="filter-options">
								<button class="filter-option" data-value="ATOPIC">아토피</button>
								<button class="filter-option" data-value="CALM">진정</button>
								<button class="filter-option" data-value="MINERAL_UV">무기자차</button>
								<button class="filter-option" data-value="ACNE">여드름</button>
								<button class="filter-option" data-value="WHITENING">미백/잡티</button>
								<button class="filter-option" data-value="SEBUM">피지/블랙헤드</button>
								<button class="filter-option" data-value="DEADSKIN">각질</button>
								<button class="filter-option" data-value="DARKCIRCLE">다크서클</button>
								<button class="filter-option" data-value="PORE">모공</button>
								<button class="filter-option" data-value="REDNESS">홍조</button>
								<button class="filter-option" data-value="ANTIAGING">슬로우에이징</button>
								<button class="filter-option" data-value="HYDRATION">피부보습/속건조</button>
								<button class="filter-option" data-value="SUNBLOCK">자외선차단</button>
								<button class="filter-option" data-value="NONE">해당없음</button>
							</div>
						</div>

						<%-- 피부타입 그룹 --%>
						<div class="filter-group">
							<div class="filter-label">피부타입</div>
							<div class="filter-options">
								<button class="filter-option" data-value="DRY">건성</button>
								<button class="filter-option" data-value="OILY">지성</button>
								<button class="filter-option" data-value="NORMAL">중성</button>
								<button class="filter-option" data-value="SENSITIVE">민감성</button>
								<button class="filter-option" data-value="COMBINATION">복합성</button>
								<button class="filter-option" data-value="DEHYDRATED_OILY">수부지</button>
							</div>
						</div>

						<%-- 퍼스널컬러 그룹 --%>
						<div class="filter-group">
							<div class="filter-label">퍼스널컬러</div>
							<div class="filter-options">
								<button class="filter-option" data-value="SPRING_WARM">봄웜톤</button>
								<button class="filter-option" data-value="SUMMER_COOL">여름쿨톤</button>
								<button class="filter-option" data-value="AUTUMN_WARM">가을웜톤</button>
								<button class="filter-option" data-value="WINTER_COOL">겨울쿨톤</button>
								<button class="filter-option" data-value="UNKNOWN">잘
									모르겠어요</button>
							</div>
						</div>
					</div>

					<!-- 상세 설명 -->
					<div class="form-group image">
						<label>상세 설명 <span class="required">*</span></label>
						<my:uploader size="lg" id="fileInput1" label="Click to upload"
							desc="또는 파일을 이 영역으로 드래그하세요" />
					</div>

					<!-- 성분 -->
					<div class="form-group">
						<label>성분 <span class="required">*</span></label>
						<my:textArea name="ingredients" placeholder="입력" maxLength="200"
							showCount="true" />
					</div>
				</section>

				<section class="form-section">
					<h3>가격 정보</h3>

					<!-- 판매가 -->
					<div class="form-group">
						<label>판매가 <span class="required">*</span></label>
						<my:textInput type="default" state="default" size="lg"
							value="${not empty product ? product.price : ''}" />
					</div>

					<!-- 할인가 (상품 수정시에만 표시) -->
					<c:if test="${not empty product}">
						<div class="form-group">
							<label>할인가</label>
							<my:textInput type="default" state="default" size="lg"
								value="${not empty product ? product.discountPrice : ''}" />
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
							value="${not empty product ? product.stock : ''}" />
					</div>
				</section>

				<section class="form-section">
					<h3>배송 관리</h3>
					<div class="form-group radio">
						<label>배송 방법 <span class="required">*</span></label> <label>
							<input type="radio" name="shipping" value="basic"
							class="form-radio"
							<c:if test="${product.shipping eq 'basic'}">checked</c:if> /> 기본
							배송
						</label> <label> <input type="radio" name="shipping" value="free"
							class="form-radio"
							<c:if test="${product.shipping eq 'free'}">checked</c:if> /> 무료
							배송
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
</script>
</html>

