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
<link rel="stylesheet" href="./tagcss/reset.css" />
<link rel="stylesheet" href="./consumer/css/header.css" />
<link rel="stylesheet" href="./tagcss/productCard.css" />
<link rel="stylesheet" href="./tagcss/tag.css" />
<link rel="stylesheet" href="./consumer/css/footer.css" />
<link rel="stylesheet" href="./consumer/css/userInfo.css" />
<link rel="stylesheet" href="./consumer/css/mypageMenu.css" />
<link rel="stylesheet" href="./tagcss/pagination.css" />
<link rel="stylesheet" href="./consumer/css/like.css" />
<link rel="stylesheet" href="./tagcss/brandNavCard.css" />
<link rel="stylesheet" href="./consumer/css/tab.css" />
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
					<c:import url="//tab.jsp">
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
								<p>전체 n개</p>

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
								</div>

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
								</div>

								<!-- 페이지네이션 -->
								<my:pagination currentPage="1" totalPages="3" baseUrl="" />
							</div>
						</div>

						<!-- 관심 브랜드 탭 -->
						<div class="tab-panel" data-tab="1">
							<div class="follow-brand-list">
								<div class="brand-grid">
									<my:brandNavCard 
                                     brandName="바이오던스" 
                                     logoUrl="https://placehold.co/64x64" 
                                     likes="500" />

									<div class="brand-card">
										<div class="brand-image">
											<img src="/images/brand-logo2.jpg" alt="브랜드로고예시2">
										</div>
										<div class="brand-info">
											<h4 class="brand-name">브랜드명예시2가나</h4>
											<button class="follow-btn active">
												<i class="bi bi-heart-fill"></i>
											</button>
										</div>
									</div>

									<div class="brand-card">
										<div class="brand-image">
											<img src="/images/brand-logo3.jpg" alt="브랜드로고예시3">
										</div>
										<div class="brand-info">
											<h4 class="brand-name">브랜드명예시3가나</h4>
											<button class="follow-btn active">
												<i class="bi bi-heart-fill"></i>
											</button>
										</div>
									</div>

									<div class="brand-card">
										<div class="brand-image">
											<img src="/images/brand-logo4.jpg" alt="브랜드로고예시4">
										</div>
										<div class="brand-info">
											<h4 class="brand-name">브랜드명예시4가나</h4>
											<button class="follow-btn active">
												<i class="bi bi-heart-fill"></i>
											</button>
										</div>
									</div>
								</div>

								<!-- 페이지네이션 -->
								<div class="pagination">
									<my:pagination currentPage="1" totalPages="3" baseUrl="" />
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
    <script src="<c:url value='/js/tab.js'/>"></script>

<script>

//탭 내용 초기화
function initTabContent() {
 // 탭 변경 이벤트 리스너
 document.addEventListener('tabChanged', function(e) {
     if (e.detail.tabId === 'productTabs') {
         showTabContent(e.detail.activeTabIndex);
     }
 });
}

//탭 내용 표시
function showTabContent(tabIndex) {
 // 모든 탭 패널 숨기기
 const tabPanels = document.querySelectorAll('.tab-panel');
 tabPanels.forEach(panel => {
     panel.classList.remove('active');
 });
 
 // 선택된 탭 패널 표시
 const activePanel = document.querySelector(`[data-tab="${tabIndex}"]`);
 if (activePanel) {
     activePanel.classList.add('active');
 }
}

</script>

</body>
</html>