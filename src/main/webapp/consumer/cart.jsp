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
					<tr>
						<th style="width: 50px;">선택</th>
						<th style="width: 80px;">상품정보</th>
						<th style="width: 300px;">상품명</th>
						<th style="width: 120px;">수량</th>
						<th style="width: 120px;">구매가격</th>
						<th style="width: 80px;">적립금</th>
						<th style="width: 100px;">관리</th>
					</tr>
				</thead>
				<tbody>
					<!-- <tr>
                    <td>
                        <input type="checkbox" class="form-check" />
                    </td>
                    <td>
                        <img src="/images/product-placeholder.jpg" alt="상품이미지" style="width: 50px; height: 50px; object-fit: cover; border-radius: 4px;">
                    </td>
                    <td class="product-name">
                        토니모리 이러다죽겠네 무지개다리건너 12색 팔레트
                    </td>
                    <td>
                        <input type="number" value="1" min="1" class="quantity-input">
                    </td>
                    <td>
                        <div class="price">19,000원</div>
                    </td>
   
                    <td>
                        <div class="action-buttons">
                            <button class="btn btn-outline btn-sm">바로구매</button>
                            <button class="btn btn-outline btn-sm">찜 등록</button>
                            <button class="btn btn-danger btn-sm">삭제</button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="checkbox" class="form-check" />
                    </td>
                    <td>
                        <img src="/images/product-placeholder.jpg" alt="상품이미지" style="width: 50px; height: 50px; object-fit: cover; border-radius: 4px;">
                    </td>
                    <td class="product-name">
                         토니모리 이러다죽겠네 무지개다리건너 12색 팔레트
                    </td>
                    <td>
                        <input type="number" value="1" min="1" class="quantity-input">
                    </td>
                    <td>
                        <div class="price">19,000원</div>
                    </td>

                    <td>
                        <div class="action-buttons">
                            <button class="btn btn-outline btn-sm">바로구매</button>
                            <button class="btn btn-outline btn-sm">찜 등록</button>
                            <button class="btn btn-danger btn-sm">삭제</button>
                        </div>
                    </td>
                </tr> -->
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
									<td><input type="checkbox"
										class="form-check item-checkbox" value="${item.cartItemId}" /></td>
									<td><img src="/images/product-placeholder.jpg"
										alt="${item.productName}"
										style="width: 50px; height: 50px; object-fit: cover; border-radius: 4px;">
									</td>
									<td class="product-name"><a
										href="${pageContext.request.contextPath}/store/productDetail?productId=${item.productId}">
											${item.productName} </a> <c:if
											test="${not empty item.optionName}">
											<br>
											<small>옵션: ${item.optionName}</small>
										</c:if> <br> <small>브랜드: ${item.brandName}</small></td>
									<td><input type="number" value="${item.quantity}" min="1"
										max="100" class="quantity-input"
										data-cart-item-id="${item.cartItemId}"
										data-original-quantity="${item.quantity}"></td>
									<td>
										<div class="price">
											<fmt:formatNumber value="${item.finalPrice * item.quantity}"
												type="number" />
											원
										</div> <c:if test="${item.finalPrice < item.productPrice}">
											<small style="text-decoration: line-through; color: #999;">
												<fmt:formatNumber
													value="${item.productPrice * item.quantity}" type="number" />원
											</small>
										</c:if>
									</td>
									<td><fmt:formatNumber
											value="${(item.finalPrice * item.quantity) * 0.01}"
											pattern="#" />P</td>
									<td>
										<div class="action-buttons">
											<button class="btn btn-outline btn-sm buy-now-btn"
												data-product-id="${item.productId}"
												data-brand-id="${item.brandId}"
												data-option-id="${item.optionId}"
												data-quantity="${item.quantity}">바로구매</button>
											<button class="btn btn-outline btn-sm">찜 등록</button>
											<button class="btn btn-danger btn-sm delete-btn"
												data-cart-item-id="${item.cartItemId}">삭제</button>
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
			<button type="button" class="btn btn-outline btn-sm select-all-btn">전체선택</button>
			<button type="button"
				class="btn btn-outline btn-sm delete-selected-btn">선택상품 삭제</button>
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
</body>
</html>