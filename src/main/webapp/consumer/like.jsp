<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>좋아요</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="<c:url value='/tagcss/reset.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/header.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/productCard.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/tag.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/brandNavCard.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/pagination.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/table.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/like.css'/>">
<link rel="stylesheet"
	href="<c:url value='/consumer/css/userInfo.css'/>">
<link rel="stylesheet"
	href="<c:url value='/consumer/css/mypageMenu.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/tab.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>">
</head>
<body>
	<!-- 상단 헤더 -->
	<%@ include file="/consumer/header.jsp"%>

	<div class="container">
		<!-- 마이페이지 메뉴 -->
		<aside class="sidebar">
			<%@ include file="/consumer/mypageMenu.jsp"%>
		</aside>

		<!-- Main Content -->
		<main class="main-content">
			<!-- user info -->
			<my:userInfo userName="홍길동" points="903" coupons="0"
				notifications="2" />

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
						<!-- 관심 상품 탭 -->
						<div class="tab-panel active" data-tab="0">
							<div class="wishlist">
								<p>전체 ${wishlistCount}개</p>

								<div class="product-grid">
									<c:choose>
										<c:when test="${not empty wishlist}">
											<c:forEach var="item" items="${wishlist}">
												<my:productCard brand="${item.brandName}"
													productId="${item.productId}" title="${item.productName}"
													isSale="${item.discountType != null && item.discountType != 'NONE'}"
													hasOption="false" originPrice="${item.price}"
													saleRate="${item.discountValue != null ? item.discountValue : 0}"
													finalPrice="${item.price}" />
											</c:forEach>
										</c:when>
										<c:otherwise>
											<p class="empty-message">좋아요 상품이 없습니다.</p>
										</c:otherwise>
									</c:choose>
								</div>

								<!-- 페이지네이션 -->
								<c:if test="${wishlistCount > 0}">
									<my:pagination currentPage="1" totalPages="1" baseUrl="" />
								</c:if>
							</div>
						</div>

						<!-- 관심 브랜드 탭 -->
						<div class="tab-panel" data-tab="1">
							<div class="follow-brand-list">
								<p>전체 ${brandFollowCount}개</p>

								<div class="brand-grid">
									<c:choose>
										<c:when test="${not empty brandFollowList}">
											<c:forEach var="brand" items="${brandFollowList}">
												<my:brandNavCard brandName="${brand.brandName}"
													logoUrl="${brand.logoFileId != null ? brand.logoFileId : 'https://placehold.co/64x64'}"
													likes="500" />
											</c:forEach>
										</c:when>
										<c:otherwise>
											<p class="empty-message">좋아요 브랜드가 없습니다.</p>
										</c:otherwise>
									</c:choose>
								</div>

								<!-- 페이지네이션 -->
								<c:if test="${brandFollowCount > 0}">
									<div class="pagination">
										<my:pagination currentPage="1" totalPages="1" baseUrl="" />
									</div>
								</c:if>
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
</body>
</html>