<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>이벤트 상세</title>
<link rel="stylesheet" href="./css/reset.css" />
<link rel="stylesheet" href="./css/header.css" />
<link rel="stylesheet" href="./css/productCard.css" />
<link rel="stylesheet" href="./css/tag.css" />
<link rel="stylesheet" href="./css/footer.css" />
<link rel="stylesheet" href="./css/eventDetail.css" />
</head>
<body>

	<%-- 임시 mock 데이터 세팅 --%>
	<%
	java.util.List<String> eventImages = new java.util.ArrayList<>();
	eventImages.add("https://placehold.co/630x1000?text=event");
	request.setAttribute("eventImages", eventImages);

	java.util.List<java.util.Map<String, Object>> eventProducts = new java.util.ArrayList<>();
	for (int i = 1; i <= 4; i++) {
		java.util.Map<String, Object> product = new java.util.HashMap<>();
		product.put("brand", "브랜드" + i);
		product.put("title", "이벤트 상품 " + i);
		product.put("isSale", "true");
		product.put("originPrice", "30000");
		product.put("saleRate", "20");
		product.put("finalPrice", "24000");
		product.put("tags", java.util.Arrays.asList("세일"));
		eventProducts.add(product);
	}
	request.setAttribute("eventProducts", eventProducts);
	%>

	<!-- 상단 헤더 -->
	<%@ include file="header.jsp"%>

	<!-- 이벤트 상세 본문 -->
	<div class="event-detail">
		<c:forEach var="img" items="${eventImages}">
			<img src="${img}" alt="이벤트 상세 이미지" />
		</c:forEach>
	</div>

	<!-- 이벤트 관련 상품 -->
	<div class="event-products">
		<div class="product-grid">
			<c:forEach var="p" items="${eventProducts}">
				<my:productCard brand="${p['brand']}" title="${p['title']}"
					isSale="${p['isSale']}" originPrice="${p['originPrice']}"
					saleRate="${p['saleRate']}" finalPrice="${p['finalPrice']}">
					<c:forEach var="t" items="${p['tags']}">
						<my:tag color="red" size="sm" text="${t}" />
					</c:forEach>
				</my:productCard>
			</c:forEach>
		</div>
	</div>

	<!-- 하단 푸터 -->
	<%@ include file="footer.jsp"%>
</body>
</html>
