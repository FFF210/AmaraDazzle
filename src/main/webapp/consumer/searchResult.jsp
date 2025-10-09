<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%-- 오늘 날짜를 JSTL 변수에 저장 --%>
<jsp:useBean id="now" class="java.util.Date" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>${param.keyword}검색</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

<link rel="stylesheet" href="<c:url value='/tagcss/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/pageHeader.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/brandNavCard.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/searchFilter.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/sortList.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/productCard.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/tag.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/modalRecent.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/pagination.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/heartBtn.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/price.css'/>" />
<link rel="stylesheet" href="<c:url value='/consumer/css/header.css'/>" />
<link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>" />
<link rel="stylesheet"
	href="<c:url value='/consumer/css/searchResult.css'/>" />
</head>
<body>

	<!-- 상단 헤더 -->
	<%@ include file="./header.jsp"%>

	<!-- 페이지 헤더 -->
	<c:if test="${not empty fn:trim(param.keyword)}">
		<div class="page-header-wrapper">
			<my:pageHeader title="${param.keyword}" isSearch="true" />
		</div>
	</c:if>

	<!-- 컨텐츠 영역 -->
	<div class="search-container">
		<c:if test="${not empty brands}">
			<div class="brand-match-section">
				<c:forEach var="brand" items="${brands}">
					<my:brandNavCard brandName="${brand.brandName}"
						brandId="${brand.brandId}" logoFileId="${brand.logoFileId}"
						isWished="${brand.isFollowed}"
						href="/store/brandDetail?brandId=${brand.brandId}" />
				</c:forEach>
			</div>
		</c:if>

		<!-- 검색 필터 -->
		<div class="search-filter">
			<!-- 혜택 그룹 -->
			<div class="filter-group">
				<div class="filter-label">혜택</div>
				<div class="filter-options">
					<button class="filter-option" data-value="SALE">세일상품</button>
					<button class="filter-option" data-value="EVENT">기획상품</button>
				</div>
			</div>

			<!-- 주요기능 그룹 -->
			<div class="filter-group">
				<div class="filter-label">주요기능</div>
				<div class="filter-options">
					<button class="filter-option" data-value="1">아토피</button>
					<button class="filter-option" data-value="2">진정</button>
					<button class="filter-option" data-value="3">여드름</button>
					<button class="filter-option" data-value="4">미백/잡티</button>
					<button class="filter-option" data-value="5">피지/블랙헤드</button>
					<button class="filter-option" data-value="6">각질</button>
					<button class="filter-option" data-value="7">다크서클</button>
					<button class="filter-option" data-value="8">모공</button>
					<button class="filter-option" data-value="9">홍조</button>
					<button class="filter-option" data-value="10">슬로우에이징</button>
					<button class="filter-option" data-value="11">피부보습/속건조</button>
					<button class="filter-option" data-value="12">자외선차단</button>
					<button class="filter-option" data-value="13">해당없음</button>
				</div>
			</div>

			<!-- 피부타입 그룹 -->
			<div class="filter-group">
				<div class="filter-label">피부타입</div>
				<div class="filter-options">
					<button class="filter-option" data-value="14">건성</button>
					<button class="filter-option" data-value="15">지성</button>
					<button class="filter-option" data-value="16">중성</button>
					<button class="filter-option" data-value="17">민감성</button>
					<button class="filter-option" data-value="18">복합성</button>
					<button class="filter-option" data-value="19">수부지</button>
				</div>
			</div>

			<!-- 퍼스널컬러 그룹 -->
			<div class="filter-group">
				<div class="filter-label">퍼스널컬러</div>
				<div class="filter-options">
					<button class="filter-option" data-value="20">봄웜톤</button>
					<button class="filter-option" data-value="21">여름쿨톤</button>
					<button class="filter-option" data-value="22">가을웜톤</button>
					<button class="filter-option" data-value="23">겨울쿨톤</button>
					<button class="filter-option" data-value="24">잘 모르겠어요</button>
				</div>
			</div>
		</div>

		<!-- 정렬 옵션 -->
		<my:sortList hasSelect="false" />

		<!-- 상품 카드 실제 데이터 -->
		<div class="product-grid">
			<c:forEach var="p" items="${productSearchList}">
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

		<c:set var="queryString">
			<c:if test="${not empty param.sort}">sort=${param.sort}&</c:if>
			<c:if test="${not empty param.keyword}">keyword=${param.keyword}&</c:if>
			<c:if test="${not empty param.isPlanned}">isPlanned=${param.isPlanned}&</c:if>
			<c:if test="${not empty param.isSale}">isSale=${param.isSale}&</c:if>
			<c:if test="${not empty param.filterIds}">filterIds=${param.filterIds}&</c:if>
				page=
			</c:set>

		<!-- 페이징 -->
		<div class="page-pagination">
			<my:pagination currentPage="${currentPage}"
				totalPages="${totalPages}"
				baseUrl="/store/searchResult?${queryString}" />
		</div>
	</div>

	<!-- 하단 푸터 -->
	<%@ include file="./footer.jsp"%>

</body>
<script>
document.addEventListener("DOMContentLoaded", () => {
  /*********************************************************************************************************
   * 정렬 옵션 클릭 이벤트
   *********************************************************************************************************/
  const sortMap = {
    "인기순": "POPULAR",
    "최근 등록순": "RECENT",
    "판매 수량순": "SALES",
    "낮은 가격순": "PRICELOW",
    "높은 가격순": "PRICEHIGH",
  };

  const currentSort = "${param.sort != null ? param.sort : 'POPULAR'}";

  document.querySelectorAll(".sort-item").forEach(btn => {
    const mapped = sortMap[btn.textContent.trim()];

    if (mapped === currentSort) {
      btn.classList.add("selected");
    }

    btn.addEventListener("click", () => {
      const sortKey = sortMap[btn.textContent.trim()];
      const url = new URL(window.location.href);
      url.searchParams.set("page", 1);
      url.searchParams.set("sort", sortKey);
      location.href = url.toString();
    });
  });

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
          window.location.href = "/store/login";
        } else if (data.success) {
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
  * 필터 버튼 클릭 이벤트 → URL 갱신
  *********************************************************************************************************/
 document.querySelectorAll(".filter-option").forEach(btn => {
   btn.addEventListener("click", () => {
     const groupEl = btn.closest(".filter-group");
     const group = groupEl.querySelector(".filter-label").textContent.trim();

     if (group === "혜택") {
       // 혜택 그룹은 단일 선택
       if (btn.classList.contains("active")) {
         // 이미 선택 → 해제
         btn.classList.remove("active");
       } else {
         groupEl.querySelectorAll(".filter-option").forEach(el => el.classList.remove("active"));
         btn.classList.add("active");
       }
     } else {
       // 나머지 그룹은 다중 선택 (토글)
       btn.classList.toggle("active");
     }

     // URL 객체 생성
     const url = new URL(window.location.href);

     // 혜택 처리
     url.searchParams.delete("isSale");
     url.searchParams.delete("isPlanned");

     const activeBenefit = document.querySelector(".filter-group .filter-option.active[data-value='SALE']");
     const activeEvent   = document.querySelector(".filter-group .filter-option.active[data-value='EVENT']");
     if (activeBenefit) {
       url.searchParams.set("isSale", 1);
     }
     if (activeEvent) {
       url.searchParams.set("isPlanned", 1);
     }

     // 필터 처리 (중복 제거 & 토글 반영)
     url.searchParams.delete("filterIds");
     document.querySelectorAll(".filter-group:not(:first-child) .filter-option.active").forEach(activeBtn => {
       url.searchParams.append("filterIds", activeBtn.dataset.value);
     });

     // 항상 첫 페이지부터
     url.searchParams.set("page", 1);

     // 이동
     location.href = url.toString();
   });
 });
  
 /*********************************************************************************************************
 * 페이지 진입 시 URL 파라미터 → 버튼 active 상태 복원
 *********************************************************************************************************/
 const urlParams = new URLSearchParams(window.location.search);

 // 혜택 그룹 처리
 if (urlParams.get("isSale") === "1") {
   document.querySelector(".filter-option[data-value='SALE']")?.classList.add("active");
 }
 if (urlParams.get("isPlanned") === "1") {
   document.querySelector(".filter-option[data-value='EVENT']")?.classList.add("active");
 }

 // filterIds 처리 (다중 선택 가능)
 const filterIds = urlParams.getAll("filterIds"); // 예: ["1","5","12"]
 filterIds.forEach(fid => {
   document.querySelectorAll(`.filter-option[data-value='\${fid}']`)
     .forEach(btn => btn.classList.add("active"));
 });

});
</script>
</html>
