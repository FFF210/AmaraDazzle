<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
// 서블릿에서 전달받은 리뷰 요약 데이터 사용
Object reviewSummaryObj = request.getAttribute("reviewSummary");
double avg = 0.0;
if (reviewSummaryObj != null) {
	java.util.Map reviewSummary = (java.util.Map) reviewSummaryObj;
	Object avgValue = reviewSummary.get("averageRating");
	if (avgValue != null) {
		avg = Double.parseDouble(avgValue.toString());
	}
}
int floor = (int) Math.floor(avg);
request.setAttribute("avg", avg);
request.setAttribute("floor", floor);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${product.name}</title>
<link rel="stylesheet" href="<c:url value='/tagcss/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/modalRecent.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/productCard.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/tag.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/pagination.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/heartBtn.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/price.css'/>" />
<link rel="stylesheet" href="<c:url value='/consumer/css/header.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/toast.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/button.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/tab.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/sortList.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/rating.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/selectbox.css'/>">
<link rel="stylesheet"
	href="<c:url value='/consumer/css/productDetail.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/reviewSummary.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/reviewCard.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/qna.css'/>">
<link rel="stylesheet"
	href="<c:url value='/tagcss/selectedOptionItem.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" />
</head>
<body>
	<!-- 헤더 include -->
	<%@ include file="/consumer/header.jsp"%>

	<main class="product-detail-container">

		<div class="product-detail-content">
			<!-- 상품 이미지 -->
			<div class="product-image-section">
				<div class="main-image">
					<img
						src="${pageContext.request.contextPath}/image?fileId=${product.thumbnailFileId}"
						alt="상품 대표 이미지" id="mainProductImage" width="500px" />
				</div>
				<div class="thumbnail-images">
					<c:if test="${not empty product.image1FileId}">
						<img
							src="${pageContext.request.contextPath}/image?fileId=${product.image1FileId}"
							alt="상품 이미지 1" class="thumbnail active" width="80px" />
					</c:if>
					<c:if test="${not empty product.image2FileId}">
						<img
							src="${pageContext.request.contextPath}/image?fileId=${product.image2FileId}"
							alt="상품 이미지 2" class="thumbnail" width="80px" />
					</c:if>
					<c:if test="${not empty product.image3FileId}">
						<img
							src="${pageContext.request.contextPath}/image?fileId=${product.image3FileId}"
							alt="상품 이미지 3" class="thumbnail" width="80px" />
					</c:if>
					<c:if test="${not empty product.image4FileId}">
						<img
							src="${pageContext.request.contextPath}/image?fileId=${product.image4FileId}"
							alt="상품 이미지 4" class="thumbnail" width="80px" />
					</c:if>
					<c:if test="${not empty product.image5FileId}">
						<img
							src="${pageContext.request.contextPath}/image?fileId=${product.image5FileId}"
							alt="상품 이미지 5" class="thumbnail" width="80px" />
					</c:if>
				</div>
			</div>

			<!-- 상품 정보 -->
			<div class="product-info-section">
				<div class="product-info-wrapper">
					<!-- 브랜드 -->
					<div class="brand-name">
						<a
							href="<c:url value='/store/brandDetail?brandId=${brand.brandId}'/>">${brand.brandName}></a>
					</div>

					<!-- 상품명 -->
					<h1 class="product-title">${product.name}</h1>

					<!--  태그 표시를 여기다 하나...? 실험을 위해 넣어본 거니 자유롭게 수정해주세요 -->
					<div class="product-tags">
						<c:if test="${isExclusive}">
							<my:tag color="red" size="md" text="단독" />
						</c:if>
						<c:if test="${isPlanned}">
							<my:tag color="green" size="md" text="기획" />
						</c:if>
						<c:if test="${isSale}">
							<my:tag color="yellow" size="md" text="세일" />
						</c:if>
					</div>

					<!-- 가격 포멧팅 -->
					<fmt:formatNumber value="${product.price}" type="number"
						maxFractionDigits="0" groupingUsed="true" var="productPrice" />

					<!-- 최종가 포멧팅 (세일가) -->
					<fmt:formatNumber value="${finalPrice}" type="number"
						maxFractionDigits="0" groupingUsed="true"
						var="formattedFinalPrice" />

					<!-- 가격 표시 -->
					<div class="price-section">
						<my:price isSale="${isSale}" hasOption="${product.hasOption == 1}"
							size="sm" originPrice="${productPrice}"
							saleRate="${saleRate.intValue()}"
							finalPrice="${formattedFinalPrice}" />
					</div>
				</div>

				<!-- 배송 정보 -->
				<div class="delivery-info">
					<div class="info-row">
						<p>포인트</p>
						최대&nbsp;<span class="value">10</span>% 적립
					</div>
					<div class="info-row">
						<p>배송일</p>
						<div class="set">
							<span class="value">2,500 원</span><br>50,000원 이상 구매 시 무료배송<br>제주/도서산간
							1,000원 추가
						</div>
					</div>
				</div>

				<!-- 옵션 선택 (옵션이 있는 상품만 표시) -->
				<c:if test="${product.hasOption == 1 and not empty productOptions}">
					<div class="option-section">
						<%-- 옵션이 있는 상품: 실제 옵션들을 문자열로 변환 --%>
						<c:set var="optionItems" value="상품을 선택해주세요" />
						<c:forEach var="option" items="${productOptions}">
							<c:set var="optionItems"
								value="${optionItems},${option.optionValue} (${option.price.intValue()}원)" />
						</c:forEach>

						<my:selectbox size="lg" items="${optionItems}"
							initial="상품을 선택해주세요" />
					</div>
				</c:if>

				<!-- 선택된 옵션 리스트 -->
				<div class="selected-options" id="selectedOptions">
					<!-- JavaScript로 동적 생성됨 -->
				</div>

				<!-- 총 가격 -->
				<div class="total-price-section">
					<p class="total-label">총 상품 금액</p>
					<p class="total-amount" id="totalAmount">
						<fmt:formatNumber value="${product.price}" type="number"
							maxFractionDigits="0" groupingUsed="true" />
						원
					</p>
				</div>

				<!-- 구매 버튼들 -->
				<div class="purchase-buttons">
					<div class="action-button">
						<button type="button" class="btn btn-outline btn-xl"
							onclick="addToCart()">장바구니 담기</button>
						<button type="button" class="btn btn-primary btn-xl"
							onclick="buyNow()">바로 구매</button>
						<my:heartBtn state="${isWished ? 'active' : 'default'}"
							onlyIcon="false" hasCount="false" />
					</div>
				</div>
			</div>
		</div>

		<!-- 상품 상세 정보 탭 -->
		<div class="product-tabs-section">
			<c:import url="/consumer/tab.jsp">
				<c:param name="tabs" value="상품설명,구매정보,리뷰,상품문의" />
				<c:param name="activeTab" value="0" />
				<c:param name="tabId" value="productTabs" />
			</c:import>

			<!-- 탭 내용 -->
			<div class="tab-content">
				<div class="tab-panel active" data-tab="0">
					<div class="product-detail-images" id="productDetailImages">
						<!-- 상품 상세 이미지들 (일부만 표시) -->
						<div class="detail-images-container">
							<img src="<c:url value='/resources/images/product-detail1.jpg'/>"
								alt="상품 상세 이미지 1"> <img
								src="<c:url value='/resources/images/product-detail2.jpg'/>"
								alt="상품 상세 이미지 2"> <img
								src="<c:url value='/resources/images/product-detail3.jpg'/>"
								alt="상품 상세 이미지 3">

							<!-- 더보기 영역 (기본적으로 숨김) -->
							<div class="more-images" id="moreImages">
								<img
									src="<c:url value='/resources/images/product-detail4.jpg'/>"
									alt="상품 상세 이미지 4"> <img
									src="<c:url value='/resources/images/product-detail5.jpg'/>"
									alt="상품 상세 이미지 5"> <img
									src="<c:url value='/resources/images/product-detail6.jpg'/>"
									alt="상품 상세 이미지 6"> <img
									src="<c:url value='/resources/images/product-detail7.jpg'/>"
									alt="상품 상세 이미지 7">
							</div>
						</div>

						<!-- 더보기/접기 버튼 -->
						<button type="button" class="btn btn-outline btn-lg"
							id="detailToggleBtn" onclick="toggleDetailImages()">상품
							설명 더보기</button>

					</div>
				</div>
				<div class="tab-panel" data-tab="1">
					<div class="product-detail-info">
						<!-- 상품정보 제공고시 -->
						<div class="detail-section">
							<h3 class="detail-title">상품정보 제공고시</h3>
							<p>${product.ingredients}</p>
							<ul>
								<li>사용 시의 주의사항: 본 제품 사용 시 피부에 이상이 있을 경우 사용을 중지하세요.</li>
								<li>1. 화장품 사용 중 붉은 반점, 부어오름, 가려움증, 자극 등의 이상이 있을 경우 사용을 중지할
									것</li>
								<li>2. 상처가 있는 부위, 습진 및 피부염 등의 이상이 있는 부위에는 사용을 자제할 것</li>
								<li>3. 보관 및 취급 시의 주의사항
									<ul>
										<li>가. 사용 후에는 반드시 마개를 닫아둘 것</li>
										<li>나. 유아·소아의 손이 닿지 않는 곳에 보관할 것</li>
										<li>다. 고온 또는 저온의 장소 및 직사광선이 닿는 곳에는 보관하지 말 것</li>
									</ul>
								</li>
							</ul>
							<p>
								본 제품에 이상이 있을 경우 공정거래위원회 고시 '소비자 분쟁 해결 기준'에 의해 보상해 드립니다.<br>
								<span style="color: red;">고객센터(소비자 상담 부정판매): 080-080-8440</span>
							</p>
						</div>

						<!-- 배송 안내 -->
						<div class="detail-section">
							<h3 class="detail-title">배송 안내</h3>
							<p>[판매 특성]</p>
							<ul>
								<li>배송지역: 전국</li>
								<li>배송비: 2,500원</li>
								<li>배송기간: 결제일로부터 평균 2~3일 이내 배송 (단, 도서/산간 지역은 배송이 지연될 수
									있습니다.)</li>
								<li>50,000원 이상 구매 시 무료배송</li>
							</ul>
							<p>※ 천재지변 등 불가항력적인 사유 발생 시 배송 기간이 지연될 수 있습니다.</p>
						</div>

						<!-- 교환/반품/품질 안내 -->
						<div class="detail-section">
							<h3 class="detail-title">교환/반품/품질 안내</h3>
							<p>반품 배송비: 고객 단순 변심 시 왕복 택배비 5,000원 부담 (상품 불량 및 오배송 시 판매자 부담)</p>
							<ul>
								<li>교환/반품 신청은 배송 완료 후 7일 이내 가능합니다.</li>
								<li>제품 개봉 시 교환/반품이 불가능합니다.</li>
								<li>상품 훼손, 사용 흔적이 있는 경우 교환/반품이 불가합니다.</li>
							</ul>
							<p>
								<span style="color: red;">고객센터: 080-080-8440</span>
							</p>
						</div>
					</div>
				</div>
				<div class="tab-panel" data-tab="2">
					<div class="review-section">
						<div class="review-summary-section">
							<!-- 리뷰 요약 -->
							<my:reviewSummary average="${avg}" floorAvg="${floor}"
								total="${reviewSummary.totalCount != null ? reviewSummary.totalCount : 0}"
								dist5="${reviewSummary.rating5Count != null ? reviewSummary.rating5Count : 0}"
								dist4="${reviewSummary.rating4Count != null ? reviewSummary.rating4Count : 0}"
								dist3="${reviewSummary.rating3Count != null ? reviewSummary.rating3Count : 0}"
								dist2="${reviewSummary.rating2Count != null ? reviewSummary.rating2Count : 0}"
								dist1="${reviewSummary.rating1Count != null ? reviewSummary.rating1Count : 0}" />
						</div>
						<!-- 정렬 -->
						<my:sortList hasSelect="true" />
						<!-- 리뷰 내용 -->
						<div class="review-card-wrapper">
							<c:choose>
								<c:when test="${not empty reviews}">
									<c:forEach var="review" items="${reviews}">
										<div data-rating="${review.rating}"
											data-date="${review.questionedAt}">
											<my:reviewCard nickname="User${review.memberId}"
												skinType="All skin types" rating="${review.rating}"
												date="${review.questionedAt}" option="Product Option"
												content="${review.content}" images="" />
										</div>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<p>아직 작성된 리뷰가 없습니다.</p>
								</c:otherwise>
							</c:choose>
						</div>
						<div class="pagination-wrapper">
							<my:pagination currentPage="1" totalPages="1"
								baseUrl="/store/productDetail?productId=${product.productId}&page=" />
						</div>
					</div>
				</div>
				<div class="tab-panel" data-tab="3">
					<div class="qna-section">
						<!-- 상품 문의 -->
						<div class="qna-header">
							<p>상품 문의사항이 아닌 반품/교환관련 문의는 고객센터 1:1 문의를 이용해주세요.</p>
							<button type="button" class="btn btn-primary btn-sm">상품
								문의</button>
						</div>

						<!-- 상품 문의 리스트 -->
						<div class="qna-list-wrapper">
							<c:choose>
								<c:when test="${not empty qnas}">
									<c:forEach var="qna" items="${qnas}">
										<my:qnaItem
											status="${qna.status == 'ANSWERED' ? 'answered' : 'waiting'}"
											title="${qna.question}" nickname="User${qna.memberId}"
											date="${qna.questionedAt}" />

										<!-- 답변이 있는 경우 -->
										<c:if
											test="${qna.status == 'ANSWERED' and not empty qna.answer}">
											<my:qnaQuestion content="${qna.question}" />
											<my:qnaAnswer content="${qna.answer}" />
										</c:if>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<p>아직 등록된 문의가 없습니다.</p>
								</c:otherwise>
							</c:choose>
						</div>

						<div class="pagination-wrapper">
							<my:pagination currentPage="1" totalPages="1"
								baseUrl="/store/productDetail?productId=${product.productId}&page=" />
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>

	<!-- 푸터 include -->
	<%@ include file="/consumer/footer.jsp"%>

	<script>
window.productId = ${product.productId};
window.productBrandId = '${brand.brandId}';
window.productPrice = ${product.price.intValue()};

<c:if test="${product.hasOption == 1}">
window.productOptionsData = [
    <c:forEach var="option" items="${productOptions}" varStatus="status">
        {
            id: ${option.productOptionId},
            value: '${option.optionValue}',
            price: ${option.price.intValue()},
            stock: ${option.stockQty}
        }<c:if test="${!status.last}">,</c:if>
    </c:forEach>
];
</c:if>

/*****************************************************************
 * 상품 상세 페이지 진입 시 로컬 스토리지에 저장 - 최근 본 상품
 *****************************************************************/
document.addEventListener("DOMContentLoaded", () => {
	  // 현재 상품 ID 가져오기 (URL 파라미터 기준)
	  const params = new URLSearchParams(window.location.search);
	  const productId = params.get("productId");
	  if (!productId) return;

	  // 로컬스토리지 키 설정
	  const KEY = "recentProductIds";

	  // 기존 리스트 가져오기
	  let ids = [];
	  try {
	    ids = JSON.parse(localStorage.getItem(KEY)) || [];
	  } catch {
	    ids = [];
	  }

	  // 이미 존재하면 중복 제거
	  ids = ids.filter(id => id !== productId);

	  // 맨 앞(최근 본 상품이 가장 앞으로)
	  ids.unshift(productId);

	  // 최대 20개까지만 유지
	  if (ids.length > 20) ids = ids.slice(0, 20);

	  // 다시 저장
	  localStorage.setItem(KEY, JSON.stringify(ids));
	});
</script>
	<script src="<c:url value='/consumer/js/tab.js'/>"></script>
	<script src="<c:url value='/consumer/js/productDetail.js'/>"></script>
	<script src="<c:url value='/consumer/js/addToWishlist.js'/>"></script>
</body>
</html>