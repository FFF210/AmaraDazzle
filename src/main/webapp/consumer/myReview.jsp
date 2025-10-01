<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이 리뷰</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="<c:url value='/tagcss/reset.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/header.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/productCard.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>">
<link rel="stylesheet"
	href="<c:url value='/consumer/css/mypageMenu.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/tab.css'/>">
<link rel="stylesheet"
	href="<c:url value='/consumer/css/myReview.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/table.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/rating.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/button.css'/>">
<link rel="stylesheet"
	href="<c:url value='/consumer/css/userInfo.css'/>">



</head>
<body>
	<!-- 상단 헤더 -->
	<%@ include file="/consumer/header.jsp"%>

	<div class="container">
		<!-- Sidebar -->
		<aside class="sidebar">
			<!-- 마이페이지 메뉴 -->
			<%@ include file="/consumer/mypageMenu.jsp"%>
		</aside>

		<!-- Main Content -->
		<main class="main-content">

			<!-- user info -->
			<div class="user-wrapper">
				<my:userInfo userName="${memberInfo.name}"
					points="${memberInfo.pointBalance}" coupons="${couponCount}"
					notifications="${sessionScope.memberNotifications}" />
			</div>

			<!-- 리뷰 섹션 -->
			<section class="review-section">
				<h2>리뷰</h2>
				<div class="review-tabs-section">
					<c:import url="/consumer/tab.jsp">
						<c:param name="tabs" value="리뷰작성, 마이리뷰" />
						<c:param name="activeTab" value="0" />
						<c:param name="tabId" value="reviewTabs" />
						<c:param name="size" value="md" />
					</c:import>

					<!-- 탭 내용 -->
					<div class="tab-content">
						<!-- 리뷰작성 탭 -->
						<div class="tab-panel active" data-tab="0">
							<div class="review-available-item">
								<!-- 구매한 내역 테이블 -->
								<div class="table-wrapper">
									<c:choose>
										<c:when test="${not empty reviewableItems}">
											<table class="table">
												<thead>
													<tr>
														<th style="width: 380px;">상품</th>
														<th style="width: 140px;">주문일자</th>
														<th style="width: 240px;">리뷰작성</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach var="item" items="${reviewableItems}">
														<tr>
															<td>
																<div class="product-info">
																	<img src="/images/thumbnail/${item.thumbnail_file_id}"
																		alt="${item.product_name}" class="product-thumb">
																	<div class="product-details">
																		<span class="product-name">${item.product_name}</span>
																		<c:if test="${not empty item.option_name}">
																			<span class="option-name">${item.option_name}</span>
																		</c:if>
																		<span class="price"> <fmt:formatNumber
																				value="${item.unit_price}" pattern="#,##0" />원
																			(${item.quantity}개)
																		</span>
																	</div>
																</div>
															</td>
															<td><fmt:formatDate value="${item.order_date}"
																	pattern="yyyy-MM-dd" /></td>
															<td>
																<button class="btn btn-outline btn-md"
																	onclick="openReviewForm(${item.order_item_id}, ${item.product_id}, '${item.product_option_id}', '${item.product_name}')">
																	리뷰작성</button>
															</td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</c:when>
										<c:otherwise>
											<div class="empty-state">
												<p>리뷰 작성 가능한 상품이 없습니다.</p>
											</div>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>
						<div class="tab-panel" data-tab="1">
							<div class="my-review">
								<!-- 내가 쓴 리뷰 테이블 -->
								<div class="table-wrapper">
									<c:choose>
										<c:when test="${not empty myReviews}">
											<table class="table" id="my-review-table">
												<thead>
													<tr>
														<th style="width: 380px;">상품</th>
														<th style="width: 140px;">주문일자</th>
														<th style="width: 240px;">마이리뷰</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach var="review" items="${myReviews}">
														<tr>
															<td>
																<div class="product-info">
																	<img
																		src="/images/thumbnail/${review.thumbnail_file_id}"
																		alt="${review.product_name}" class="product-thumb">
																	<div class="product-details">
																		<span class="product-name">${review.product_name}</span>
																		<c:if test="${not empty review.option_name}">
																			<span class="option-name">${review.option_name}</span>
																		</c:if>
																		<span class="price"> <fmt:formatNumber
																				value="${review.unit_price}" pattern="#,##0" />원
																			(${review.quantity}개)
																		</span>
																	</div>
																</div>
															</td>
															<td><fmt:formatDate value="${review.order_date}"
																	pattern="yyyy-MM-dd" /></td>
															<td>
																<div class="review-content">
																	<my:rating rating="${review.rating}" readonly="true"
																		noBackground="true" />
																	<div class="review-text">
																		<span class="review-date"> <fmt:formatDate
																				value="${review.review_date}" pattern="yyyy.MM.dd" />
																		</span> <br> <span class="content-text">${review.content}</span>
																	</div>
																</div>
															</td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</c:when>
										<c:otherwise>
											<div class="empty-state">
												<p>작성한 리뷰가 없습니다.</p>
											</div>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		</main>
	</div>
	<!-- 모달 만들면 그걸로 교체 -->
	<!-- 리뷰 작성 모달 -->
	<div id="reviewModal" class="modal" style="display: none;">
		<div class="modal-content">
			<div class="modal-header">
				<h3>리뷰 작성</h3>
				<span class="close">&times;</span>
			</div>
			<div class="modal-body">
				<form id="reviewForm" method="post"
					action="${pageContext.request.contextPath}/mypage/myReview">
					<input type="hidden" id="orderItemId" name="orderItemId"> <input
						type="hidden" id="productId" name="productId"> <input
						type="hidden" id="productOptionId" name="productOptionId">

					<div class="form-group">
						<label>상품명</label> <span id="productNameDisplay"></span>
					</div>

					<div class="form-group">
						<label>별점</label>
						<div class="rating-input">
							<input type="radio" name="rating" value="5" id="star5"> <label
								for="star5">★</label> <input type="radio" name="rating"
								value="4" id="star4"> <label for="star4">★</label> <input
								type="radio" name="rating" value="3" id="star3"> <label
								for="star3">★</label> <input type="radio" name="rating"
								value="2" id="star2"> <label for="star2">★</label> <input
								type="radio" name="rating" value="1" id="star1"> <label
								for="star1">★</label>
						</div>
					</div>

					<div class="form-group">
						<label for="content">리뷰 내용</label>
						<textarea id="content" name="content" rows="5"
							placeholder="리뷰를 작성해주세요." required></textarea>
					</div>

					<div class="form-actions">
						<button type="button" class="btn btn-outline"
							onclick="closeReviewModal()">취소</button>
						<button type="submit" class="btn btn-primary">리뷰 등록</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<%-- 푸터 --%>
	<%@ include file="/consumer/footer.jsp"%>
	<script src="<c:url value='/consumer/js/tab.js'/>"></script>
	<script src="<c:url value='/consumer/js/tab.js'/>"></script>
	<script>
		// 리뷰 작성 모달 열기
		function openReviewForm(orderItemId, productId, productOptionId, productName) {
			document.getElementById('orderItemId').value = orderItemId;
			document.getElementById('productId').value = productId;
			document.getElementById('productOptionId').value = productOptionId || '';
			document.getElementById('productNameDisplay').textContent = productName;
			
			// 폼 초기화
			document.getElementById('reviewForm').reset();
			document.getElementById('orderItemId').value = orderItemId;
			document.getElementById('productId').value = productId;
			document.getElementById('productOptionId').value = productOptionId || '';
			
			document.getElementById('reviewModal').style.display = 'block';
		}
		
		// 리뷰 작성 모달 닫기
		function closeReviewModal() {
			document.getElementById('reviewModal').style.display = 'none';
		}
		
		// 모달 외부 클릭시 닫기
		window.onclick = function(event) {
			const modal = document.getElementById('reviewModal');
			if (event.target == modal) {
				modal.style.display = 'none';
			}
		}
		
		// 닫기 버튼 클릭시 닫기
		document.addEventListener('DOMContentLoaded', function() {
    const closeBtn = document.querySelector('.close');
    if (closeBtn) {
        closeBtn.onclick = function() {
            closeReviewModal();
        }
    }
});
		</script>
	
</body>
</html>