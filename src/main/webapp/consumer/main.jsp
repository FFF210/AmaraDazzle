<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%-- 오늘 날짜를 JSTL 변수에 저장 --%>
<jsp:useBean id="now" class="java.util.Date" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>AmaraDazzle</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

<link rel="stylesheet" href="<c:url value='/tagcss/reset.css'/>" />
<link rel="stylesheet"
	href="<c:url value='/consumer/css/productCard.css'/>" />
<link rel="stylesheet"
	href="<c:url value='/tagcss/recommendationSectionTitle.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/tag.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/modalRecent.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/heartBtn.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/eventCard.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/price.css'/>" />
<link rel="stylesheet" href="<c:url value='/consumer/css/header.css'/>" />
<link rel="stylesheet"
	href="<c:url value='/consumer/css/mainBanner.css'/>" />
<link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>" />
<link rel="stylesheet" href="<c:url value='/consumer/css/main.css'/>" />
</head>
<body>
	<!-- 상단 헤더 -->
	<%@ include file="./header.jsp"%>

	<!-- 메인 배너 -->
	<div class="banner">
		<!-- 슬라이드 묶음 -->
		<div class="slides">
			<c:forEach var="banner" items="${bannerList}" varStatus="status">
				<div class="slide ${status.first ? 'active' : ''}">
					<a href="/store/brandDetail?brandId=${banner.brandId}"
						target="_blank"> <img
						src="/image?fileId=${banner.uploadFileId}"
						alt="${banner.bannerName}" />
					</a>
				</div>
			</c:forEach>
		</div>

		<!-- 좌우 네비게이션 버튼 -->
		<button class="prev">&#10094;</button>
		<button class="next">&#10095;</button>

		<!-- 인디케이터(슬라이드 개수만큼 dot 표시) -->
		<div class="dots">
			<c:forEach var="banner" items="${bannerList}" varStatus="status">
				<span class="dot ${status.first ? 'active' : ''}"></span>
			</c:forEach>
		</div>
	</div>

	<!-- 컨텐츠 영역 -->
	<div class="main-container">

		<c:if test="${not empty sessionScope.memberId}">
			<c:if test="${not empty filterIds}">
				<c:url var="filterUrl" value="/store/searchResult">
					<c:forEach var="id" items="${filterIds}">
						<c:param name="filterIds" value="${id}" />
					</c:forEach>
				</c:url>

				<!-- 나에게 딱 맞는 상품 -->
				<my:recommendationSectionTitle
					title="오늘 ${empty sessionScope.memberName ? '' : sessionScope.memberName}님께 어울리는 뷰티 Pick"
					linkUrl="${filterUrl}" />
			</c:if>
			<div class="product-grid">
				<c:forEach var="p" items="${productMyFitList}">
					<%-- 할인율(saleRate) 계산 --%>
					<c:choose>
						<c:when test="${p.discountType eq 'RATE'}">
							<c:set var="saleRateRaw" value="${p.discountValue}" />
						</c:when>
						<c:when test="${p.discountType eq 'AMOUNT'}">
							<c:set var="saleRateRaw"
								value="${(p.discountValue / p.price) * 100}" />
						</c:when>
						<c:otherwise>
							<c:set var="saleRateRaw" value="0" />
						</c:otherwise>
					</c:choose>

					<%-- 숫자 포맷팅 --%>
					<fmt:formatNumber value="${p.finalPrice}" type="number"
						maxFractionDigits="0" groupingUsed="true" var="finalPrice" />
					<fmt:formatNumber value="${saleRateRaw}" type="number"
						maxFractionDigits="0" groupingUsed="true" var="saleRate" />

					<c:url value="/store/productDetail" var="detailUrl">
						<c:param name="productId" value="${p.productId}" />
					</c:url>

					<%-- 상품 카드 렌더링 --%>
					<my:productCard brand="${p.brandName}" productId="${p.productId}"
						title="${p.name}" isWished="${p.isWished}"
						isSale="${p.discountType ne null and p.discountValue ne null 
                              and p.startDate ne null 
                              and p.endDate ne null 
                              and p.startDate.time <= now.time 
                              and now.time <= p.endDate.time}"
						hasOption="${p.hasOption eq 1}" originPrice="${p.price}"
						saleRate="${saleRate}" finalPrice="${finalPrice}"
						href="${detailUrl}" thumbnailFileId="${p.thumbnailFileId}">

						<c:if
							test="${p.discountType ne null 
                              and p.discountValue ne null 
                              and p.startDate ne null 
                              and p.endDate ne null 
                              and p.startDate.time <= now.time 
                              and now.time <= p.endDate.time}">
							<my:tag color="red" size="sm" text="세일" />
						</c:if>
						<c:if test="${p.isExclusive ne 0}">
							<my:tag color="green" size="sm" text="단독" />
						</c:if>
						<c:if test="${p.isPlanned ne 0}">
							<my:tag color="yellow" size="sm" text="기획" />
						</c:if>
					</my:productCard>
				</c:forEach>
			</div>
		</c:if>


		<!-- 인기 상품 -->
		<my:recommendationSectionTitle title="모두가 사랑하는 베스트 픽"
			linkUrl="/store/ranking" />

		<div class="product-grid">
			<c:forEach var="p" items="${productPopularList}">
				<%-- 할인율(saleRate) 계산 --%>
				<c:choose>
					<c:when test="${p.discountType eq 'RATE'}">
						<c:set var="saleRateRaw" value="${p.discountValue}" />
					</c:when>
					<c:when test="${p.discountType eq 'AMOUNT'}">
						<c:set var="saleRateRaw"
							value="${(p.discountValue / p.price) * 100}" />
					</c:when>
					<c:otherwise>
						<c:set var="saleRateRaw" value="0" />
					</c:otherwise>
				</c:choose>

				<%-- 숫자 포맷팅 (소수점 제거, 3자리마다 콤마) --%>
				<fmt:formatNumber value="${p.finalPrice}" type="number"
					maxFractionDigits="0" groupingUsed="true" var="finalPrice" />

				<fmt:formatNumber value="${saleRateRaw}" type="number"
					maxFractionDigits="0" groupingUsed="true" var="saleRate" />

				<c:url value="/store/productDetail" var="detailUrl">
					<c:param name="productId" value="${p.productId}" />
				</c:url>

				<%-- 상품 카드 렌더링 --%>
				<my:productCard brand="${p.brandName}" productId="${p.productId}"
					title="${p.name}" isWished="${p.isWished}"
					isSale="${p.discountType ne null and p.discountValue ne null 
          and p.startDate ne null 
          and p.endDate ne null 
          and p.startDate.time <= now.time 
          and now.time <= p.endDate.time}"
					hasOption="${p.hasOption eq 1}" originPrice="${p.price}"
					saleRate="${saleRate}" finalPrice="${finalPrice}"
					href="${detailUrl}" thumbnailFileId="${p.thumbnailFileId}">

					<c:if
						test="${p.discountType ne null 
          and p.discountValue ne null 
          and p.startDate ne null 
          and p.endDate ne null 
          and p.startDate.time <= now.time 
          and now.time <= p.endDate.time}">
						<my:tag color="red" size="sm" text="세일" />
					</c:if>
					<c:if test="${p.isExclusive ne 0}">
						<my:tag color="green" size="sm" text="단독" />
					</c:if>
					<c:if test="${p.isPlanned ne 0}">
						<my:tag color="yellow" size="sm" text="기획" />
					</c:if>
				</my:productCard>
			</c:forEach>
		</div>

		<div class="brand-recommendation-wrapper">
			<!-- 브랜드 -->
			<div class="recommendation-section-title">
				<h2 class="title recommendation">AmaraDazzle's Pick</h2>
			</div>

			<div class="brand-grid">
				<c:forEach var="brand" items="${brandList}">
					<a href="/store/brandDetail?brandId=${brand.brandId}"
						class="brand-card">
						<div class="brand-hero">
							<img src="/image?fileId=${brand.heroFileId}"
								alt="${brand.brandName}" width="230px">
						</div>
						<div class="brand-info">
							<h3 class="brand-name">${brand.brandName}</h3>
							<p class="brand-intro">${brand.intro}</p>
						</div>
					</a>
				</c:forEach>
			</div>
		</div>

		<!-- 단독 상품 -->
		<div class="recommendation-section-title">
			<h2 class="title">오직 여기서만, 단독 뷰티</h2>
		</div>

		<div class="product-grid">
			<c:forEach var="p" items="${productExclusiveList}">
				<%-- 할인율(saleRate) 계산 --%>
				<c:choose>
					<c:when test="${p.discountType eq 'RATE'}">
						<c:set var="saleRateRaw" value="${p.discountValue}" />
					</c:when>
					<c:when test="${p.discountType eq 'AMOUNT'}">
						<c:set var="saleRateRaw"
							value="${(p.discountValue / p.price) * 100}" />
					</c:when>
					<c:otherwise>
						<c:set var="saleRateRaw" value="0" />
					</c:otherwise>
				</c:choose>

				<%-- 숫자 포맷팅 (소수점 제거, 3자리마다 콤마) --%>
				<fmt:formatNumber value="${p.finalPrice}" type="number"
					maxFractionDigits="0" groupingUsed="true" var="finalPrice" />

				<fmt:formatNumber value="${saleRateRaw}" type="number"
					maxFractionDigits="0" groupingUsed="true" var="saleRate" />

				<c:url value="/store/productDetail" var="detailUrl">
					<c:param name="productId" value="${p.productId}" />
				</c:url>

				<%-- 상품 카드 렌더링 --%>
				<my:productCard brand="${p.brandName}" productId="${p.productId}"
					title="${p.name}" isWished="${p.isWished}"
					isSale="${p.discountType ne null and p.discountValue ne null 
          and p.startDate ne null 
          and p.endDate ne null 
          and p.startDate.time <= now.time 
          and now.time <= p.endDate.time}"
					hasOption="${p.hasOption eq 1}" originPrice="${p.price}"
					saleRate="${saleRate}" finalPrice="${finalPrice}"
					href="${detailUrl}" thumbnailFileId="${p.thumbnailFileId}">

					<c:if
						test="${p.discountType ne null 
          and p.discountValue ne null 
          and p.startDate ne null 
          and p.endDate ne null 
          and p.startDate.time <= now.time 
          and now.time <= p.endDate.time}">
						<my:tag color="red" size="sm" text="세일" />
					</c:if>
					<c:if test="${p.isExclusive ne 0}">
						<my:tag color="green" size="sm" text="단독" />
					</c:if>
					<c:if test="${p.isPlanned ne 0}">
						<my:tag color="yellow" size="sm" text="기획" />
					</c:if>
				</my:productCard>
			</c:forEach>
		</div>


		<!-- 이벤트 -->
		<my:recommendationSectionTitle title="놓치면 아쉬운 뷰티 프로모션"
			linkUrl="/store/eventList" />

		<div class="event-grid">
			<c:forEach var="e" items="${eventList}">
				<c:url value="/store/eventDetail" var="detailUrl">
					<c:param name="eventId" value="${e.eventId}" />
				</c:url>

				<!-- 날짜 포맷 적용 -->
				<fmt:formatDate value="${e.startDate}" pattern="yyyy-MM-dd"
					var="startFmt" />
				<fmt:formatDate value="${e.endDate}" pattern="yyyy-MM-dd"
					var="endFmt" />

				<my:eventCard thumbnailFileId="${e.thumbnailFileId}"
					title="${e.eventName}" startDate="${startFmt}" endDate="${endFmt}"
					href="${detailUrl}" status="${e.status}" />
			</c:forEach>
		</div>



		<!-- 세일 상품 -->
		<my:recommendationSectionTitle title="지금 꼭 잡아야 할 뷰티 딜"
			linkUrl="/store/searchResult?isSale=1" />

		<div class="product-grid">
			<c:forEach var="p" items="${productSaleList}">
				<%-- 할인율(saleRate) 계산 --%>
				<c:choose>
					<c:when test="${p.discountType eq 'RATE'}">
						<c:set var="saleRateRaw" value="${p.discountValue}" />
					</c:when>
					<c:when test="${p.discountType eq 'AMOUNT'}">
						<c:set var="saleRateRaw"
							value="${(p.discountValue / p.price) * 100}" />
					</c:when>
					<c:otherwise>
						<c:set var="saleRateRaw" value="0" />
					</c:otherwise>
				</c:choose>

				<%-- 숫자 포맷팅 (소수점 제거, 3자리마다 콤마) --%>
				<fmt:formatNumber value="${p.finalPrice}" type="number"
					maxFractionDigits="0" groupingUsed="true" var="finalPrice" />

				<fmt:formatNumber value="${saleRateRaw}" type="number"
					maxFractionDigits="0" groupingUsed="true" var="saleRate" />

				<c:url value="/store/productDetail" var="detailUrl">
					<c:param name="productId" value="${p.productId}" />
				</c:url>

				<%-- 상품 카드 렌더링 --%>
				<my:productCard brand="${p.brandName}" productId="${p.productId}"
					title="${p.name}" isWished="${p.isWished}"
					isSale="${p.discountType ne null and p.discountValue ne null 
          and p.startDate ne null 
          and p.endDate ne null 
          and p.startDate.time <= now.time 
          and now.time <= p.endDate.time}"
					hasOption="${p.hasOption eq 1}" originPrice="${p.price}"
					saleRate="${saleRate}" finalPrice="${finalPrice}"
					href="${detailUrl}" thumbnailFileId="${p.thumbnailFileId}">

					<c:if
						test="${p.discountType ne null 
          and p.discountValue ne null 
          and p.startDate ne null 
          and p.endDate ne null 
          and p.startDate.time <= now.time 
          and now.time <= p.endDate.time}">
						<my:tag color="red" size="sm" text="세일" />
					</c:if>
					<c:if test="${p.isExclusive ne 0}">
						<my:tag color="green" size="sm" text="단독" />
					</c:if>
					<c:if test="${p.isPlanned ne 0}">
						<my:tag color="yellow" size="sm" text="기획" />
					</c:if>
				</my:productCard>
			</c:forEach>
		</div>
	</div>

	<!-- 하단 푸터 -->
	<%@ include file="./footer.jsp"%>
</body>
<script>
	 document.addEventListener("DOMContentLoaded", () => {
		 /*********************************************************************************************************
		  * 배너 이벤트 
		  *********************************************************************************************************/
			  const slides = document.querySelectorAll(".slide");
			  const dots = document.querySelectorAll(".dot");
			  
			  console.log("slides:", slides.length);

			  if (slides.length === 0) return; // 배너 없음

			  let currentIndex = 0;

			  function showSlide(index) {
			    console.log("showSlide index:", index);
			    slides.forEach((s, i) => {
			      s.classList.toggle("active", i === index);
			      dots[i].classList.toggle("active", i === index);
			    });
			    currentIndex = index;
			  }

			  function nextSlide() {
			    showSlide((currentIndex + 1) % slides.length);
			  }

			  function prevSlide() {
			    showSlide((currentIndex - 1 + slides.length) % slides.length);
			  }

			  // 초기 실행
			  showSlide(currentIndex);

			  // 자동 전환
			  let slideInterval = setInterval(nextSlide, 5000);

			  // 버튼 이벤트
			  const nextBtn = document.querySelector(".next");
			  const prevBtn = document.querySelector(".prev");
			  if (nextBtn) nextBtn.addEventListener("click", () => { nextSlide(); resetInterval(); });
			  if (prevBtn) prevBtn.addEventListener("click", () => { prevSlide(); resetInterval(); });

			  // dot 이벤트
			  dots.forEach((dot, i) => {
			    dot.addEventListener("click", () => {
			      showSlide(i);
			      resetInterval();
			    });
			  });

			  function resetInterval() {
			    clearInterval(slideInterval);
			    slideInterval = setInterval(nextSlide, 5000);
			  }
		 
	 /*********************************************************************************************************
	  * 찜 버튼 클릭 이벤트
	  *********************************************************************************************************/
			  document.querySelectorAll(".wishlist-btn .heart-btn").forEach(btn => {
				    btn.addEventListener("click", (e) => {
				      e.stopPropagation();
				      e.preventDefault();

				      const icon = btn.querySelector("i");
				      const productId = btn.closest(".product-card").dataset.productid;

				      fetch("/store/wishlistToggle", {
				        method: "POST",
				        headers: { "Content-Type": "application/x-www-form-urlencoded" },
				        body: "productId=" + encodeURIComponent(productId)
				      })
				      .then(res => res.json())
				      .then(data => {
				    	  if (!data.success && data.requireLogin) {
				    		    window.location.href = "/store/login"; // 로그인 페이지로 이동
				    		  }
				    	  else if (data.success) {
					          if (data.isWished) {
					            icon.classList.remove("bi-heart");
					            icon.classList.add("bi-heart-fill", "active");
					          } else {
					            icon.classList.remove("bi-heart-fill", "active");
					            icon.classList.add("bi-heart");
					          }
				        } else {
				          alert(data.message);
				        }
				      })
				      .catch(err => console.error(err));
				    });
				  });
	 
	/*********************************************************************************************************
	 * 상품 카드 스크롤 진입 시 애니메이션
	 *********************************************************************************************************/
			// 공용 함수
			  function animateOnScroll(selector) {
			    const elements = document.querySelectorAll(selector);
			    const observer = new IntersectionObserver((entries) => {
			      entries.forEach(entry => {
			        if (entry.isIntersecting) {
			          entry.target.classList.add("visible");
			        } else {
			          entry.target.classList.remove("visible");
			        }
			      });
			    }, { threshold: 0.2 });

			    elements.forEach((el, i) => {
			      // 순차적으로 등장하도록 지연 효과
			      el.style.transitionDelay = (i * 0.05) + "s";
			      observer.observe(el);
			    });
			  }

			  // 상품 카드 애니메이션
			  animateOnScroll(".product-card");

			  // 브랜드 카드 애니메이션
			  animateOnScroll(".brand-card");

	 			});
	</script>
</html>
