<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>온라인</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="./css/reset.css" />
<link rel="stylesheet" href="./css/header.css" />
<link rel="stylesheet" href="./css/mainBanner.css" />
<link rel="stylesheet" href="./css/recommendationSectionTitle.css" />
<link rel="stylesheet" href="./css/productCard.css" />
<link rel="stylesheet" href="./css/tag.css" />
<link rel="stylesheet" href="./css/eventCard.css" />
<link rel="stylesheet" href="./css/footer.css" />
<link rel="stylesheet" href="./css/main.css" />
</head>
<body>
	<!-- 상단 헤더 -->
	<%@ include file="/consumer/header.jsp"%>

	<!-- 메인 배너 (가로 전체 꽉차게) -->
	<my:mainBanner />

	<!-- 컨텐츠 영역 -->
	<div class="main-container">

		<!-- 나에게 딱 맞는 상품 -->
		<my:recommendationSectionTitle title="나에게 딱 맞는 상품"
			linkUrl="/recommend/match" />

		<div class="product-grid">
			<my:productCard brand="바이오던스" title="상품명1" isSale="true"
				hasOption="false" originPrice="34000" saleRate="25"
				finalPrice="25500">
				<my:tag color="red" size="sm" text="세일" />
				<my:tag color="yellow" size="sm" text="기획" />
			</my:productCard>
			<my:productCard brand="바이오던스" title="상품명2" isSale="true"
				hasOption="false" originPrice="34000" saleRate="25"
				finalPrice="25500" />
			<my:productCard brand="바이오던스" title="상품명3" isSale="true"
				hasOption="false" originPrice="34000" saleRate="25"
				finalPrice="25500" />
			<my:productCard brand="바이오던스" title="상품명4" isSale="true"
				hasOption="false" originPrice="34000" saleRate="25"
				finalPrice="25500" />
		</div>

		<!-- 인기 상품 -->
		<my:recommendationSectionTitle title="인기 상품"
			linkUrl="/recommend/popular" />

		<div class="product-grid">
			<my:productCard brand="바이오던스" title="상품명A" isSale="true"
				hasOption="false" originPrice="34000" saleRate="25"
				finalPrice="25500" />
			<my:productCard brand="바이오던스" title="상품명B" isSale="true"
				hasOption="false" originPrice="34000" saleRate="25"
				finalPrice="25500" />
			<my:productCard brand="바이오던스" title="상품명C" isSale="true"
				hasOption="false" originPrice="34000" saleRate="25"
				finalPrice="25500" />
			<my:productCard brand="바이오던스" title="상품명D" isSale="true"
				hasOption="false" originPrice="34000" saleRate="25"
				finalPrice="25500" />
		</div>

		<!-- 신상품 -->
		<my:recommendationSectionTitle title="신상품" linkUrl="/recommend/new" />

		<div class="product-grid">
			<my:productCard brand="바이오던스" title="신상품1" isSale="true"
				hasOption="false" originPrice="34000" saleRate="25"
				finalPrice="25500" />
			<my:productCard brand="바이오던스" title="신상품2" isSale="true"
				hasOption="false" originPrice="34000" saleRate="25"
				finalPrice="25500" />
			<my:productCard brand="바이오던스" title="신상품3" isSale="true"
				hasOption="false" originPrice="34000" saleRate="25"
				finalPrice="25500" />
			<my:productCard brand="바이오던스" title="신상품4" isSale="true"
				hasOption="false" originPrice="34000" saleRate="25"
				finalPrice="25500" />
		</div>

		<!-- 이벤트 -->
		<my:recommendationSectionTitle title="이벤트" linkUrl="/events" />

		<div class="event-grid">
			<my:eventCard imageUrl="https://placehold.co/320x160"
				title="올영 뷰티 구매인증 리뷰 이벤트" startDate="2025-09-01"
				endDate="2025-09-31" />
			<my:eventCard imageUrl="https://placehold.co/320x160"
				title="가을 맞이 특별 이벤트" startDate="2025-09-10" endDate="2025-09-30" />
			<my:eventCard imageUrl="https://placehold.co/320x160"
				title="신규 회원가입 이벤트" startDate="2025-09-15" endDate="2025-09-25" />
		</div>
	</div>
	
	<!-- 하단 푸터 -->
	<%@ include file="/consumer/footer.jsp"%>
</body>
</html>
