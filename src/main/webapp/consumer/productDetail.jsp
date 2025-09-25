<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<%
double avg = 4.89;
int floor = (int) Math.floor(avg);
request.setAttribute("avg", avg);
request.setAttribute("floor", floor);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세 - AD</title>
<link rel="stylesheet" href="./tagcss/reset.css" />
<link rel="stylesheet" href="./consumer/css/header.css" />
<link rel="stylesheet" href="./tagcss/button.css" />
<link rel="stylesheet" href="./tagcss/heartBtn.css" />
<link rel="stylesheet" href="./tagcss/tag.css" />
<link rel="stylesheet" href="./consumer/css/tab.css" />
<link rel="stylesheet" href="./tagcss/price.css" />
<link rel="stylesheet" href="./tagcss/sortList.css" />
<link rel="stylesheet" href="./tagcss/rating.css" />
<link rel="stylesheet" href="./tagcss/selectbox.css" />
<link rel="stylesheet" href="./tagcss/pagination.css" />
<link rel="stylesheet" href="./consumer/css/productDetail.css" />
<link rel="stylesheet" href="./tagcss/reviewSummary.css" />
<link rel="stylesheet" href="./tagcss/reviewCard.css" />
<link rel="stylesheet" href="./tagcss/qna.css" />
<link rel="stylesheet" href="./tagcss/selectedOptionItem.css" />
<link rel="stylesheet" href="./tagcss/footer.css" />
</head>
<body>
	<!-- 헤더 include -->
	<%@ include file="/consumer/header.jsp"%>

	<main class="product-detail-container">
		<div class="product-detail-content">
			<!-- 상품 이미지 -->
			<div class="product-image-section">
				<div class="main-image">
					<img src="<c:url value='/images/product-placeholder.jpg'/>"
						alt="상품 이미지" id="mainProductImage">
				</div>
				<div class="thumbnail-images">
					<img src="<c:url value='/images/product-thumb1.jpg'/>"
						alt="상품 이미지 1" class="thumbnail active"> <img
						src="<c:url value='/images/product-thumb2.jpg'/>" alt="상품 이미지 2"
						class="thumbnail"> <img
						src="<c:url value='/images/product-thumb3.jpg'/>" alt="상품 이미지 3"
						class="thumbnail">
				</div>
			</div>

			<!-- 상품 정보 -->
			<div class="product-info-section">
				<div class="product-info-wrapper">
					<!-- 브랜드 -->
					<div class="brand-name">브랜드명</div>

					<!-- 상품명 -->
					<h1 class="product-title">홀리몰리 무지개 파레트 12색 / 무지개다리 건너는 대신
						무지개색깔을 발라보세요</h1>

					<!-- 가격 표시 -->
					<div class="price-section">
						<my:price isSale="true" hasOption="true" size="sm"
							originPrice="14,000" saleRate="25" finalPrice="10,000" />
					</div>
				</div>

				<!-- 배송 정보 -->
				<div class="delivery-info">
					<div class="info-row">
						<p>포인트</p>
						최대&nbsp;<span class="value">2,100</span>원 적립
					</div>
					<div class="info-row">
						<p>배송일</p>
						<div class="set">
							<span class="value">3,000 원</span><br>50,000원 이상 구매 시 무료배송<br>제주/도서산간
							3,000원 추가
						</div>
					</div>
				</div>

				<!-- 옵션 선택 -->
				<div class="option-section">
					<my:selectbox size="lg" items="추천순,인기순,최신순,낮은가격순,높은가격순"
						initial="상품을 선택해주세요" />
				</div>

				<!-- 선택된 옵션 리스트 -->
				<div class="selected-options" id="selectedOptions">
					<my:selectedOptionItem name="상품이름" price="10000" count="0" />
					<my:selectedOptionItem name="상품이름" price="10000" count="0" />
				</div>

				<!-- 총 가격 -->
				<div class="total-price-section">
					<p class="total-label">총 상품 금액</p>
					<p class="total-amount">20,000원</p>
				</div>

				<!-- 구매 버튼들 -->
				<div class="purchase-buttons">
					<button type="button" class="btn btn-outline btn-xl"
						onclick="addToCart()">장바구니 담기</button>
					<button type="button" class="btn btn-primary btn-xl"
						onclick="buyNow()">바로 구매</button>
					<my:heartBtn state="active" onlyIcon="false" hasCount="false" />
				</div>
			</div>
		</div>

		<!-- 상품 상세 정보 탭 -->
		<div class="product-tabs-section">
			<c:import url="/tab.jsp">
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
							<p>정제수, 다이프로필렌글라이콜, 페닐트라이메티콘, 세틸에틸헥사노에이트, 글리세린, 1,2-헥산다이올,
								다이메티콘/비닐다이메티콘, 트라이메틸실록시실리케이트, 비닐디메티콘/메틸실세스퀴옥산크로스폴리머,
								트라이메틸펜타페닐트라이실록세인, 폴리메틸실세스퀴옥산, 다이메티콘크로스폴리머, 실리카, 소듐클로라이드,
								하이드로제네이티드폴리데센, 트라이에톡시카프릴릴실레인, 폴리글리세릴-10라우레이트, 판테놀, 알루미늄하이드록사이드,
								스테아릭애씨드, 트라이에톡시카프릴릴실레인, 카프릴릴글라이콜, 에틸헥실글리세린, 아데노신, 향료, 토코페롤,
								적색산화철, 흑색산화철, 티타늄디옥사이드, 황색산화철, 틴옥사이드, 마이카, 다이아이소스테아릴말레이트,
								폴리글리세릴-2트라이아이소스테아레이트, 실리카다이메틸실릴레이트, 프로판다이올, 정제수, 부틸렌글라이콜, 알지닌,
								카보머, 글리세릴아크릴레이트/아크릴릭애씨드코폴리머, 알란토인, 카프릴릴글라이콜, 펜틸렌글라이콜, 판테닐에틸에터,
								알로에베라잎즙, 마카다미아씨오일, 하이드롤라이즈드콜라겐, 알지닌/라이신폴리펩타이드</p>
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
								본 제품에 이상이 있을 경우 공정거래위원회 고시 ‘소비자 분쟁 해결 기준’에 의해 보상해 드립니다.<br>
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
								total="120" dist5="100" dist4="15" dist3="3" dist2="1" dist1="1" />
						</div>
						<!-- 정렬 -->
						<my:sortList hasSelect="true" />
						<!-- 리뷰 내용 -->
						<div class="review-card-wrapper">
							<my:reviewCard nickname="닉네임" skinType="지성/민감성/여드름" rating="5"
								date="2025.09.04" option="옵션에 대한 이름" content="리뷰 본문 내용입니다."
								images="/img/review1.png,/img/review2.png,/img/review3.png" />
							<my:reviewCard nickname="닉네임" skinType="지성/민감성/여드름" rating="5"
								date="2025.09.04" option="옵션에 대한 이름" content="리뷰 본문 내용입니다."
								images="/img/review1.png,/img/review2.png,/img/review3.png" />
							<my:reviewCard nickname="닉네임" skinType="지성/민감성/여드름" rating="5"
								date="2025.09.04" option="옵션에 대한 이름" content="리뷰 본문 내용입니다."
								images="/img/review1.png,/img/review2.png,/img/review3.png" />
						</div>
						<div class="pagination-wrapper">
							<my:pagination currentPage="1" totalPages="10"
								baseUrl="/products?page=" />
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
							<!-- Q&A 리스트 -->
							<my:qnaItem status="waiting" title="네모패드 휴대용케이스 설명보면..."
								nickname="닉네임" date="2025.08.04" />
							<!-- Q&A 리스트 -->
							<my:qnaItem status="waiting" title="네모패드 휴대용케이스 설명보면..."
								nickname="닉네임" date="2025.08.04" />

							<!-- 상세 펼침 -->
							<my:qnaQuestion
								content="네모페드 휴대용케이스 설명보면 패드넣고 재사용 가능한 커버로 패드위에 덮으라고 써있는데, 재사용가능한 커버는 뭘까요? 그런커버 안들어있던대.." />
							<my:qnaAnswer
								content="안녕하세요. 메디힐 담당자입니다. 저희 메디힐 제품에 관심 가져주시고 문의 남겨주셔서 감사합니다.  문의주신 사항 관련, 정확한 사전 확인은 어렵지만 고객님의 소중한 의견은 관련 부서에도 전달 드리도록 하겠으며, 고객님들의 의견을 수렴하여 더욱 발전하는 메디힐이 되도록 노력하겠습니다.  감사합니다." />
						</div>

						<div class="pagination-wrapper">
							<my:pagination currentPage="1" totalPages="10"
								baseUrl="/products?page=" />
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>

	<!-- 푸터 include -->
	<%@ include file="/consumer/footer.jsp"%>

	<script src="<c:url value='/js/tab.js'/>"></script>
	<script src="<c:url value='/js/productDetail.js'/>"></script>
</body>
</html>