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
							href="<c:url value='/store/brandDetail?brandId=${brand.brandId}'/>">${brand.brandName}</a>
					</div>

					<!-- 상품명 -->
					<h1 class="product-title">${product.name}</h1>

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
					<%-- 세일가 있을때 originPrice는 따로 화면에 안 나오는 거 맞나요??? --%>
					<div class="price-section">
						<my:price isSale="${isSale}" hasOption="${product.hasOption == 1}"
							size="md" originPrice="${productPrice}"
							saleRate="${saleRate.intValue()}"
							finalPrice="${formattedFinalPrice}" />
					</div>
				</div>

				<!-- 배송 정보 -->
				<div class="delivery-info">
					<div class="info-row">
						<p>포인트</p>
						최대&nbsp;<span class="value">10</span> % 적립
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
						<c:choose>
							<c:when test="${product.hasOption == 1}">
                0원
            </c:when>
							<c:otherwise>
								<fmt:formatNumber value="${finalPrice}" type="number"
									maxFractionDigits="0" groupingUsed="true" />원
            </c:otherwise>
						</c:choose>
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
						<!-- 상품 상세 이미지들 -->
						<div class="detail-images-container">

							<c:choose>
								<c:when test="${not empty product.detail1FileId}">
									<img
										src="${pageContext.request.contextPath}/image?fileId=${product.detail1FileId}"
										alt="상품 상세 이미지 1" width="960px" />
									<c:if test="${not empty product.detail2FileId}">
										<img
											src="${pageContext.request.contextPath}/image?fileId=${product.detail2FileId}"
											alt="상품 상세 이미지 2" width="960px" />
									</c:if>
									<c:if test="${not empty product.detail3FileId}">
										<img
											src="${pageContext.request.contextPath}/image?fileId=${product.detail3FileId}"
											alt="상품 상세 이미지 3" width="960px" />
									</c:if>

									<c:if test="${not empty product.detail4FileId}">
										<div class="more-images" id="moreImages"
											style="display: none;">
											<img
												src="${pageContext.request.contextPath}/image?fileId=${product.detail4FileId}"
												alt="상품 상세 이미지 4" width="960px" />

											<c:if test="${not empty product.detail5FileId}">
												<img
													src="${pageContext.request.contextPath}/image?fileId=${product.detail5FileId}"
													alt="상품 상세 이미지 5" width="960px" />
											</c:if>
											<c:if test="${not empty product.detail6FileId}">
												<img
													src="${pageContext.request.contextPath}/image?fileId=${product.detail6FileId}"
													alt="상품 상세 이미지 6" width="960px" />
											</c:if>
											<c:if test="${not empty product.detail7FileId}">
												<img
													src="${pageContext.request.contextPath}/image?fileId=${product.detail7FileId}"
													alt="상품 상세 이미지 7" width="960px" />
											</c:if>
										</div>

										<!-- 더보기 버튼 (detail4FileId 있을 때만 표시) -->
										<button type="button" class="btn btn-outline btn-lg"
											id="detailToggleBtn" onclick="toggleDetailImages()"
											style="width: 150px;">상품 설명 더보기</button>
									</c:if>
								</c:when>

								<c:otherwise>
									<p
										style="padding: 50px 0; display: flex; justify-content: center; font-size: 15px;">
										상세 이미지를 준비중입니다.</p>
								</c:otherwise>
							</c:choose>
						</div>
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
							<fmt:formatNumber value="${avg}" pattern="#.#" var="formattedAvg" />

							<my:reviewSummary average="${formattedAvg}" floorAvg="${floor}"
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
										<fmt:formatDate value="${review.questionedAt}"
											pattern="yyyy-MM-dd" var="formattedDate" />

										<!--  리뷰 카드 -->
										<div class="review-card" data-rating="${review.rating}"
											data-date="${review.questionedAt}">
											<!-- 왼쪽 : 작성자 정보 -->
											<div class="review-author">
												<p class="nickname">닉네임</p>
												<p class="skin-type">피부타입정보들</p>
											</div>
											<!-- 오른쪽 : 리뷰 내용 -->
											<div class="review-body">
												<div class="review-header">
													<!-- 별점 -->
													<span class="rating-container"
														data-rating="${review.rating}"> <c:forEach var="i"
															begin="1" end="5">
															<i
																class="bi ${i <= review.rating ? 'bi-star-fill' : 'bi-star'} star"
																data-value="${i}"></i>
														</c:forEach>
													</span> <span class="review-date">${formattedDate}</span>
												</div>

												<c:if test="${not empty option}">
													<div class="review-option">옵션 | 구매옵션정보</div>
												</c:if>

												<div class="review-content">${review.content}</div>

												<c:if test="${not empty imageList}">
													<div class="review-images">
														<c:forEach var="img" items="${imageList}">
															<img src="${img}" alt="리뷰 이미지" />
														</c:forEach>
													</div>
												</c:if>
											</div>
										</div>
									</c:forEach>
									<div class="pagination-wrapper">
										<my:pagination currentPage="1" totalPages="1"
											baseUrl="/store/productDetail?productId=${product.productId}&page=" />
									</div>
								</c:when>
								<c:otherwise>
									<p
										style="padding: 50px 0; display: flex; justify-content: center; font-size: 15px;">아직
										작성된 리뷰가 없습니다.</p>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
				<div class="tab-panel" data-tab="3">
					<div class="qna-section">
						<!-- 상품 문의 -->
						<div class="qna-header">
							<p>상품 문의사항이 아닌 반품/교환관련 문의는 고객센터 1:1 문의를 이용해주세요.</p>
							<button type="button" class="btn btn-primary btn-sm"
								onclick="openQnaModal()" style="width: 100px; height: 35px;">
								상품 문의</button>
						</div>

						<!-- 상품 문의 리스트 -->
						<div class="qna-list-wrapper">
							<c:choose>
								<c:when test="${not empty qnas}">
									<c:forEach var="qna" items="${qnas}" varStatus="status">
										<fmt:formatDate value="${qna.questionedAt}"
											pattern="yyyy-MM-dd" var="formattedDate" />

										<!-- QnA 아이템 (클릭 가능) -->
										<div class="qna-item-wrapper" data-qna-id="${status.index}">
											<my:qnaItem
												status="${qna.status == 'ANSWERED' ? 'answered' : 'waiting'}"
												title="${qna.question}" nickname="User${qna.memberId}"
												date="${formattedDate}" />

											<!-- 답변 영역 (기본 숨김) -->
											<div class="qna-detail-wrapper"
												id="qnaDetail-${status.index}" style="display: none;">
												<my:qnaQuestion content="${qna.question}" />
												<c:if
													test="${qna.status == 'ANSWERED' and not empty qna.answer}">
													<my:qnaAnswer content="${qna.answer}" />
												</c:if>
											</div>
										</div>
									</c:forEach>

									<div class="pagination-wrapper">
										<my:pagination currentPage="1" totalPages="1"
											baseUrl="/store/productDetail?productId=${product.productId}&page=" />
									</div>
								</c:when>

								<c:otherwise>
									<p
										style="padding: 50px 0; display: flex; justify-content: center; font-size: 15px;">
										아직 등록된 문의가 없습니다.</p>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>

	<!-- 상품 문의 모달 -->
	<div id="qnaModal" class="modal-overlay" style="display: none;">
		<div class="modal-container">
			<div class="modal-header">
				<h2>상품 문의 작성</h2>
				<button type="button" class="modal-close" onclick="closeQnaModal()">
					<i class="bi bi-x"></i>
				</button>
			</div>

			<div class="modal-content">
				<form id="qnaForm" onsubmit="submitQna(event)">
					<div class="form-group">
						<!-- 상품명 표시 -->
						<label class="form-label" id="qnaProductName">
							${product.name} </label>
						<p class="form-description">
							상품 Q&A에서는 고객님의 주문 정보를 확인할 수 없습니다.<br> 배송 문의는 1:1 문의 게시판을
							이용해주세요.
						</p>
						<textarea name="qnaContent" class="form-textarea"
							placeholder="문의 내용" maxlength="250" required></textarea>
						<div class="char-count">
							<span id="currentLength">0</span>/250자
						</div>
					</div>

					<div class="form-notice">
						<h4>이용안내</h4>
						<p>
							상품 Q&A의 취지와 맞지 않는 글(재판매 목적, 상업성 홍보, 부적절한 내용 등)은<br>사전 고지
							없이삭제될 수 있습니다.
						</p>
					</div>

					<div class="modal-actions">
						<button type="button" class="btn btn-outline btn-lg"
							onclick="closeQnaModal()">취소</button>
						<button type="submit" class="btn btn-primary btn-lg">등록</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- 푸터 include -->
	<%@ include file="/consumer/footer.jsp"%>

	<script>
window.productId = ${product.productId};
window.productBrandId = '${brand.brandId}';
window.productPrice = ${finalPrice.intValue()};
window.originalPrice = ${product.price.intValue()};
window.isSale = ${isSale ? 'true' : 'false'};
window.isLoggedIn = ${not empty sessionScope.memberId ? 'true' : 'false'};

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
  const params = new URLSearchParams(window.location.search);
  const productId = params.get("productId");
  if (!productId) return;

  const KEY = "recentProductIds";
  let ids = [];

  try {
    ids = JSON.parse(localStorage.getItem(KEY)) || [];
  } catch {
    ids = [];
  }

  ids = ids.filter(id => id !== productId); // 중복 제거
  ids.unshift(productId); // 최신 상품 맨 앞에
  if (ids.length > 20) ids = ids.slice(0, 20); // 20개 제한

  localStorage.setItem(KEY, JSON.stringify(ids));

  /*****************************************************************
   * Q&A 아코디언 기능
   *****************************************************************/
  document.querySelectorAll(".qna-item-wrapper").forEach(wrapper => {
	    const item = wrapper.querySelector(".qna-item");
	    const detail = wrapper.querySelector(":scope > .qna-detail-wrapper"); 

	    item.addEventListener("click", () => {
	      const isVisible = window.getComputedStyle(detail).display !== "none";

	      // 모든 1차 qna-detail 닫기
	      document.querySelectorAll(".qna-item-wrapper > .qna-detail-wrapper")
	        .forEach(d => d.style.display = "none");

	      // 클릭한 항목만 토글
	      if (!isVisible) {
	        detail.style.display = "block";
	      }
	    });
	  });
});
</script>

	<script src="<c:url value='/consumer/js/tab.js'/>"></script>
	<script src="<c:url value='/consumer/js/productDetail.js'/>"></script>
	<script src="<c:url value='/consumer/js/addToWishlist.js'/>"></script>
</body>
</html>