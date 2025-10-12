<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- 오늘 날짜를 JSTL 변수에 저장 --%>
<jsp:useBean id="now" class="java.util.Date" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>좋아요</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="<c:url value='/tagcss/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/modalRecent.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/productCard.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/tag.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/pagination.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/heartBtn.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/price.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/brandNavCard.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/pagination.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/table.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/like.css'/>">
<link rel="stylesheet"
	href="<c:url value='/consumer/css/userInfo.css'/>">
<link rel="stylesheet"
	href="<c:url value='/consumer/css/mypageMenu.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/header.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/tab.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>">
</head>

<body>
	<!-- 상단 헤더 -->
	<%@ include file="/consumer/header.jsp"%>

	<div class="container">

		<!-- 마이페이지 메뉴 -->
		<%@ include file="/consumer/mypageMenu.jsp"%>

		<!-- Main Content -->
		<main class="main-content">

			<!-- ============================ 1. 사용자 정보 요약 ============================ -->
			<div class="user-info">

				<div class="user-info__top">
					<p class="greeting">
						<span class="name">${sessionScope.memberName}</span> 님 반갑습니다.
					</p>
				</div>

				<!-- 하단 통계 영역 -->
				<div class="user-info__bottom">
					<div class="stat">
						<span class="label">등급</span> <span class="value"><span
							class="em"><c:choose>
									<c:when test="${sessionScope.memberGrade eq 'VIP'}">VIP</c:when>
									<c:when test="${sessionScope.memberGrade eq 'GOLD'}">GOLD</c:when>
									<c:when test="${sessionScope.memberGrade eq 'SILVER'}">SILVER</c:when>
									<c:otherwise>일반</c:otherwise>
								</c:choose></span></span>
					</div>
					<div class="stat">
						<span class="label">포인트</span> <span class="value"><span
							class="em"><fmt:formatNumber value="${sessionScope.memberPoints}" pattern="#,###" /></span> p</span>
					</div>
					<div class="stat">
						<span class="label">쿠폰</span> <span class="value"><span
							class="em">${sessionScope.memberCoupons}</span> 개</span>
					</div>
				</div>
			</div>

			<!-- ============================ 2. 관심 상품/브랜드 섹션 ============================ -->
			<div class="like-container">
				<h3>좋아요</h3>

				<!-- 관심 상품/관심 브랜드 탭 -->
				<div class="product-tabs-section">
					<c:import url="/consumer/tab.jsp">
						<c:param name="tabs" value="상품, 브랜드" />
						<c:param name="activeTab" value="0" />
						<c:param name="tabId" value="likeTabs" />
						<c:param name="size" value="md" />
					</c:import>

					<!-- 탭 내용 -->
					<div class="tab-content">
						<!-- ============================ 2-1. 관심 상품 탭 ============================ -->
						<div class="tab-panel active" data-tab="0">
							<div class="wishlist">
								<p class="count">
									전체 <span class="bold">${wishlistCount}</span>개
								</p>


								<div class="product-grid">
									<c:choose>
										<c:when test="${not empty wishlist}">
											<c:forEach var="p" items="${wishlist}">
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

												<fmt:formatNumber value="${p.finalPrice}" type="number"
													maxFractionDigits="0" groupingUsed="true" var="finalPrice" />

												<fmt:formatNumber value="${saleRateRaw}" type="number"
													maxFractionDigits="0" groupingUsed="true" var="saleRate" />

												<c:url value="/store/productDetail" var="detailUrl">
													<c:param name="productId" value="${p.productId}" />
												</c:url>

												<c:set var="__hasOptionInt" value="${p.hasOption ? 1 : 0}" />
												<c:set var="__isExclusiveInt"
													value="${p.isExclusive ? 1 : 0}" />
												<c:set var="__isPlannedInt" value="${p.isPlanned ? 1 : 0}" />


												<my:productCard brand="${p.brandName}"
													productId="${p.productId}" title="${p.name}" isWished="1"
													isSale="${p.discountType ne null and p.discountValue ne null 
          and p.startDate ne null 
          and p.endDate ne null 
          and p.startDate.time <= now.time 
          and now.time <= p.endDate.time}"
													hasOption="${__hasOptionInt eq 1}" originPrice="${p.price}"
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
													<c:if test="${__isExclusiveInt ne 0}">
														<my:tag color="green" size="sm" text="단독" />
													</c:if>
													<c:if test="${__isPlannedInt ne 0}">
														<my:tag color="yellow" size="sm" text="기획" />
													</c:if>
												</my:productCard>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<p class="empty-message">좋아요 상품이 없습니다.</p>
										</c:otherwise>
									</c:choose>
								</div>

								<!-- 페이징 -->
								<div class="page-pagination-like">
									<my:pagination currentPage="${currentPage}"
										totalPages="${totalPages}"
										baseUrl="/store/like?${queryString}" />
								</div>
							</div>
						</div>

						<!-- ============================ 2-2. 관심 브랜드 탭 ============================ -->
						<div class="tab-panel" data-tab="1">
							<div class="follow-brand-list">
								<p class="count">
									전체 <span class="bold">${brandFollowCount}</span>개
								</p>

								<div class="brand-grid">
									<c:choose>
										<c:when test="${not empty brandFollowList}">
											<c:forEach var="brand" items="${brandFollowList}">
												<my:brandNavCard brandName="${brand.brandName}"
													brandId="${brand.brandId}" logoFileId="${brand.logoFileId}"
													isWished="1"
													href="/store/brandDetail?brandId=${brand.brandId}" />
											</c:forEach>
										</c:when>
										<c:otherwise>
											<p class="empty-message">좋아요 브랜드가 없습니다.</p>
										</c:otherwise>
									</c:choose>
								</div>

								<!-- 페이징 -->
								<div class="page-pagination-like">
									<my:pagination currentPage="${currentPage}"
										totalPages="${totalPages}"
										baseUrl="/store/mypage/like?${queryString}" />
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</main>
	</div>

	<!-- 푸터 include -->
	<%@ include file="/consumer/footer.jsp"%>

	<script src="<c:url value='/consumer/js/tab.js'/>"></script>
	<script src="<c:url value='/consumer/js/addTowishlist.js'/>"></script>
	<script>
document.addEventListener('DOMContentLoaded', function() {
    const tabItems = document.querySelectorAll('.tab-item');
    const tabPanels = document.querySelectorAll('.tab-panel');
    
    console.log('탭 패널 정보:');
    tabPanels.forEach((panel, idx) => {
        console.log(`패널 ${idx}: data-tab="${panel.dataset.tab}", getAttribute="${panel.getAttribute('data-tab')}"`);
    });
    
    // 직접 이벤트 추가
    tabItems.forEach((item, index) => {
        item.addEventListener('click', function(e) {
            e.preventDefault();
            e.stopPropagation();
            
            console.log(`탭 ${index} 클릭 - 찾는 선택자: [data-tab="${index}"]`);
            
            // 모든 패널 숨기기
            tabPanels.forEach(p => {
                p.classList.remove('active');
                p.style.display = 'none';
            });
            
            // 인덱스로 직접 접근
            if (tabPanels[index]) {
                tabPanels[index].classList.add('active');
                tabPanels[index].style.display = 'block';
                console.log('패널 표시 성공:', index);
            } else {
                console.error('패널 없음:', index);
            }
        });
    });
    
    // 초기 상태
    setTimeout(function() {
        if (tabPanels[0]) {
            tabPanels[0].style.display = 'block';
        }
    }, 100);
});

//좋아요 토글
function toggleWishlist(productId, buttonElement) {
    // AJAX 요청
    fetch('/store/wishlistToggle', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: 'productId=' + productId
    })
    .then(response => response.json())
    .then(data => {
        if (data.requireLogin) {
            // 로그인 필요
            alert('로그인이 필요합니다.');
            location.href = '/login';
            return;
        }
        
        if (data.success) {
            // UI 업데이트
            const icon = buttonElement.querySelector('i');
            if (data.isWished) {
                // 찜 추가됨
                icon.classList.remove('bi-heart');
                icon.classList.add('bi-heart-fill');
                buttonElement.classList.add('active');
            } else {
                // 찜 취소됨
                icon.classList.remove('bi-heart-fill');
                icon.classList.add('bi-heart');
                buttonElement.classList.remove('active');
            }
        } else {
            alert('오류가 발생했습니다.');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('서버 오류가 발생했습니다.');
    });
}
</script>
	<script src="<c:url value='/consumer/js/addToWishlist.js'/>"></script>
</body>
</html>