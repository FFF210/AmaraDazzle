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
<title>카테고리 목록</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
	
<link rel="stylesheet" href="<c:url value='/tagcss/modalRecent.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/pageHeader.css'/>" />
<link rel="stylesheet"
	href="<c:url value='/tagcss/categoryFilter.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/sortList.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/productCard.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/tag.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/modalRecent.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/pagination.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/heartBtn.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/price.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/breadcrumb.css'/>" />
<link rel="stylesheet" href="<c:url value='/consumer/css/header.css'/>" />
<link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>" />
<link rel="stylesheet"
	href="<c:url value='/consumer/css/categoryList.css'/>" />
</head>
<body>
	<!-- 상단 헤더 -->
	<%@ include file="./header.jsp"%>

	<!-- 페이지 헤더 -->
	<div class="page-header-wrapper">
		<my:pageHeader title="${selectedCategory}" onlyText="true" />
	</div>

	<!-- 컨텐츠 영역 -->
	<div class="category-container">

		<!-- 카테고리 필터 영역 -->
		<div id="category-filters">
			<div class="category-filter" id="large-category"></div>
			<div class="category-filter" id="middle-category"></div>
			<div class="category-filter" id="small-category"></div>
		</div>

		<script>
		document.addEventListener("DOMContentLoaded", () => {
		  // DOM 요소 가져오기
		  const largeContainer = document.getElementById("large-category");
		  const middleContainer = document.getElementById("middle-category");
		  const smallContainer = document.getElementById("small-category");
		
		  // 현재 URL의 파라미터 읽기 (선택된 카테고리 값 유지용)
		  let selectedCategory1 = new URLSearchParams(location.search).get("category1Id");
		  let selectedCategory2 = new URLSearchParams(location.search).get("category2Id");
		  let selectedCategory3 = new URLSearchParams(location.search).get("category3Id");
		
		  // 버튼들을 컨테이너에 렌더링하는 함수
		  function renderButtons(container, categories, type, parentId) {
		    container.innerHTML = "";
		    if (!categories) return;
		
		    // 항상 "전체" 버튼 추가
		    const allBtn = document.createElement("button");
		    allBtn.className = "category-item";
		    allBtn.textContent = "전체";
		   
		   // "전체" 버튼 클릭 시 동작 (대분류, 중분류, 소분류 상황에 따라 URL 달라짐)
		    allBtn.onclick = () => {
		      if (type === "large") {
		        location.href = `/store/categoryList?page=1`;
		      } else if (type === "middle") {
		        location.href = `/store/categoryList?page=1&category1Id=\${selectedCategory1}`;
		      } else if (type === "small") {
		        location.href = `/store/categoryList?page=1&category1Id=\${selectedCategory1}&category2Id=\${selectedCategory2}`;
		      }
		    };
		
		   // 현재 선택 상태와 비교해서 "전체" 버튼 강조
		    if ((type === "large" && !selectedCategory1) ||
		        (type === "middle" && selectedCategory2 == null) ||
		        (type === "small" && selectedCategory3 == null)) {
		      allBtn.classList.add("selected");
		    }
		    
		    container.appendChild(allBtn); // "전체" 버튼 먼저 추가
		
		   // 실제 카테고리 버튼 추가
		    categories.forEach(c => {
		      const btn = document.createElement("button");
		      btn.className = "category-item";
		      btn.textContent = c.name;
		
		     // 현재 URL에 선택된 값과 일치하면 "selected" 강조
		      if ((type === "large" && selectedCategory1 == c.categoryId) ||
		          (type === "middle" && selectedCategory2 == c.categoryId) ||
		          (type === "small" && selectedCategory3 == c.categoryId)) {
		        btn.classList.add("selected");
		      }
		
		     // 버튼 클릭 시 동작
		      btn.onclick = () => {
		        if (type === "large") {
		          selectedCategory1 = c.categoryId;
		          selectedCategory2 = null;
		          selectedCategory3 = null;
		          location.href = `/store/categoryList?page=1&category1Id=\${selectedCategory1}`;
		
		        } else if (type === "middle") {
		          selectedCategory2 = c.categoryId;
		          selectedCategory3 = null;
		
		          // 소분류 존재 여부 확인
		          fetch(`/category?type=small&parentId=\${selectedCategory2}`)
		            .then(res => res.json())
		            .then(data => {
		              if (data && data.length > 0) {
		                // 소분류 있으면 → 중+소 목록 로드
		                location.href = `/store/categoryList?page=1&category1Id=\${selectedCategory1}&category2Id=\${selectedCategory2}&hasSmall=1`;
		              } else {
		                // 소분류 없으면 → 중분류까지만
		                location.href = `/store/categoryList?page=1&category1Id=\${selectedCategory1}&category2Id=\${selectedCategory2}&hasSmall=0`;
		              }
		            })
		            .catch(err => console.error(err));
		
		        } else if (type === "small") {
			      	selectedCategory3 = c.categoryId;
			        location.href = `/store/categoryList?page=1&category1Id=\${selectedCategory1}&category2Id=\${selectedCategory2}&category3Id=\${selectedCategory3}&hasSmall=1`;
		         } 
		      };
		
		      container.appendChild(btn); // 버튼 추가
		    });
		    
		    // UI를 10개 또는 15개로 맞추기 (빈칸 추가)
		    let count = container.querySelectorAll(".category-item").length;
		    let target = count > 10 ? 15 : 10;
		
		    while (count < target) {
		      const empty = document.createElement("div");
		      empty.className = "category-item empty";
		      container.appendChild(empty);
		      count++;
		    }
		  }
		
		  // Ajax로 카테고리 목록 불러오기
		  function loadCategories(type, parentId = null) {
		    let url = `/category?type=\${type}`;
		    if (parentId) url += `&parentId=\${parentId}`;
		
		    return fetch(url)
		      .then(res => res.json())
		      .then(data => {
		        if (type === "large") renderButtons(largeContainer, data, "large");
		        else if (type === "middle") renderButtons(middleContainer, data, "middle", parentId);
		        else if (type === "small" && new URLSearchParams(location.search).get("hasSmall") === "1") renderButtons(smallContainer, data, "small", parentId);
		      });
		  }
		  
		  const hasSmall = new URLSearchParams(location.search).get("hasSmall");
			
		   if (selectedCategory2 && hasSmall === "1") {
		    // 소분류 있음 → 소분류만 표시
		    largeContainer.classList.add("none");
		    middleContainer.classList.add("none");
		    smallContainer.classList.remove("none");

		    loadCategories("small", selectedCategory2);

		  } else if (selectedCategory2 && hasSmall === "0") {
		    // 소분류 없음 → 중분류만 표시 유지
		    largeContainer.classList.add("none");
		    middleContainer.classList.remove("none");
		    smallContainer.classList.add("none");

		    loadCategories("middle", selectedCategory1);

		  } else if (selectedCategory1) {
		    // 대분류 선택됨 → 중분류 표시
		    largeContainer.classList.add("none");
		    middleContainer.classList.remove("none");
		    smallContainer.classList.add("none");

		    loadCategories("middle", selectedCategory1);

		  } else {
		    // 아무것도 선택 안됨 → 대분류 표시
		    largeContainer.classList.remove("none");
		    middleContainer.classList.add("none");
		    smallContainer.classList.add("none");

		    loadCategories("large");
		  }
		});
		</script>

		<!-- 정렬 옵션 -->
		<my:sortList hasSelect="false" />

		<!-- 상품 카드 실제 데이터 -->
		<div class="product-grid">
			<c:forEach var="p" items="${productCategoryList}">
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
			<c:if test="${not empty param.category1Id}">category1Id=${param.category1Id}&</c:if>
				page=
			</c:set>

		<!-- 페이징 -->
		<div class="page-pagination">
			<my:pagination currentPage="${currentPage}"
				totalPages="${totalPages}"
				baseUrl="/store/categoryList?${queryString}" />
		</div>
	</div>

	<!-- 하단 푸터 -->
	<%@ include file="./footer.jsp"%>

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

			    // 현재 sort 강조
			    if (mapped === currentSort) {
			      btn.classList.add("selected");
			    }

			    // 클릭 시 URL 갱신
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
	 			});
	</script>

</body>
</html>
