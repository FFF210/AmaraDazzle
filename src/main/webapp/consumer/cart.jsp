<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="<c:url value='/tagcss/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/modalRecent.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/productCard.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/tag.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/pagination.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/heartBtn.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/price.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/button.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/table.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/pageHeader.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/header.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/cart.css'/>">
</head>
<body>
	<!-- 상단 헤더 -->
	<%@ include file="/consumer/header.jsp"%>

	<!-- 페이지 헤더 -->
	<div class="page-header-wrapper">
		<my:pageHeader hasButton="false" title="장바구니" />
	</div>

	<main class="main-content">

		<!-- 장바구니에 담은 상품 정보 테이블 -->
		<div class="table-wrapper">
			<table class="table">
				<thead>
					<tr style="height: 60px;">
						<th style="width: 50px;"><label class="custom-checkbox-label">
								<input type="checkbox" class="select-all-btn" /> <span
								class="custom-checkbox-box"></span>
						</label></th>
						<th style="max-width: 450px;">상품정보</th>
						<th style="width: 100px;">수량</th>
						<th style="width: 110px;">상품주문금액</th>
						<th style="width: 100px;">적립금</th>
						<th style="width: 150px;">선택</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty cartItems}">
							<tr>
								<td colspan="7" style="text-align: center; padding: 50px;">
									장바구니가 비어있습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="item" items="${cartItems}" varStatus="status">
								<tr data-cart-item-id="${item.cartItemId}">
									<!-- 체크박스 -->
									<td><label class="custom-checkbox-label"> <input
											type="checkbox" class="item-checkbox"
											value="${item.cartItemId}" /> <span
											class="custom-checkbox-box"></span>
									</label></td>

									<!-- 상품정보 -->
									<td
										style="width: 490px; display: flex; flex-direction: row; padding: 20px; gap: 20px; align-items: center;"
										onclick="location.href='${pageContext.request.contextPath}/store/productDetail?productId=${item.productId}'">
										<img
										src="${pageContext.request.contextPath}/image?fileId=${item.thumbnailFileId}"
										alt="${item.productName}"
										style="width: 85px; height: 85px; object-fit: cover;">
										<div class="product-info-wrapper">
											<p class="brand">${item.brandName}</p>
											<p class="product">${item.productName}</p>
											<c:if test="${not empty item.optionName}">
												<p class="option">옵션 | ${item.optionName}</p>
											</c:if>
										</div>
									</td>

									<!-- 수량 -->
									<td style="width: 100px; padding: 20px;"><input
										type="number" value="${item.quantity}" min="1" max="100"
										class="quantity-input" data-cart-item-id="${item.cartItemId}"
										data-original-quantity="${item.quantity}"></td>

									<!-- 구매가격 -->
									<td style="width: 110px; padding: 20px;"><c:if
											test="${item.finalPrice < item.productPrice}">
											<p style="text-decoration: line-through; color: #b5b5b5;">
												<fmt:formatNumber
													value="${item.productPrice * item.quantity}" type="number" />
												원
											</p>
										</c:if>

										<p style="font-weight: 600; color: #111;">
											<fmt:formatNumber value="${item.finalPrice * item.quantity}"
												type="number" />
											원
										</p></td>

									<!-- 적립금 -->
									<td
										style="width: 100px; color: #333; font-size: 13px; padding: 20px;"><fmt:formatNumber
											value="${(item.finalPrice * item.quantity) * 0.01}"
											pattern="#,###" /> P</td>

									<!-- 액션 버튼 -->
									<td style="width: 150px; padding: 20px;">
										<div class="action-buttons">
											<button class="btn btn-primary btn-sm buy-now-btn"
												style="width: 130px; padding: 0;"
												data-product-id="${item.productId}"
												data-brand-id="${item.brandId}"
												data-option-id="${item.optionId}"
												data-quantity="${item.quantity}">바로구매</button>
											<div style="display: flex; gap: 8px;">
												<div class="wishlist-btn"
													data-product-id="${item.productId}">
													<my:heartBtn state="${heartState}" onlyIcon="true"
														hasCount="false" />
												</div>
												<button class="delete-btn"
													data-cart-item-id="${item.cartItemId}">
													<i class="bi bi-trash3"></i>
												</button>
											</div>
										</div>
									</td>

								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>

		<!-- 선택/삭제 버튼 -->
		<div class="select-all-container">
			<button type="button" class="btn btn-outline btn-sm select-all-btn"
				style="border-color: #ddd; color: #333;">전체선택</button>
			<button type="button"
				class="btn btn-outline btn-sm delete-selected-btn"
				style="border-color: #ddd; color: #333;">선택상품 삭제</button>
		</div>

		<!-- 총 결제 예상 정보 -->
		<div class="cart-summary">
			<p class="total-amount">
				총 결제예상금액
				<fmt:formatNumber value="${totalAmount}" type="number" />
				원
				<c:if test="${itemCount > 0}">
            (${itemCount}개 상품)
        </c:if>
			</p>
		</div>

		<!-- 버튼 -->
		<div class="button-container">
			<button class="btn btn-outline btn-xl order-selected-btn">선택
				주문</button>
			<button class="btn btn-primary btn-xl order-all-btn">전체 주문</button>
		</div>
	</main>

	<!-- 하단 푸터 -->
	<%@ include file="/consumer/footer.jsp"%>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="<c:url value='/consumer/js/cart.js'/>"></script>

	<script>
document.addEventListener("DOMContentLoaded", () => {

  document.body.addEventListener("click", (e) => {
    const btn = e.target.closest(".wishlist-btn .heart-btn");
    if (!btn) return; // heart-btn이 아니면 무시

    const wishlistDiv = btn.closest(".wishlist-btn");
    const productId = wishlistDiv?.dataset.productId;
    if (!productId) return;

    const icon = btn.querySelector("i");

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
        alert(data.message || "처리 중 오류가 발생했습니다.");
      }
    })
    .catch(err => console.error(err));
  });

});
</script>


</body>
</html>