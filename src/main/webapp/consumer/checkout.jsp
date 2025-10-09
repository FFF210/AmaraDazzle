<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="dto.Member"%>
<%@ page import="java.util.Map"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>주문결제</title>
<link rel="stylesheet" href="<c:url value='/tagcss/reset.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/modalRecent.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/productCard.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/tag.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/pagination.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/heartBtn.css'/>" />
<link rel="stylesheet" href="<c:url value='/tagcss/price.css'/>" />
<link rel="stylesheet" href="<c:url value='/consumer/css/header.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/pageHeader.css'/>">
<link rel="stylesheet"
	href="<c:url value='/consumer/css/checkout.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/textInput.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/button.css'/>">

<!-- 토스 sdk 버전2 -->
<script src="https://js.tosspayments.com/v2/standard"></script>
</head>
<body>
	<!-- 헤더 include -->
	<%@ include file="/consumer/header.jsp"%>

	<!-- 페이지헤더 -->
	<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
	<my:pageHeader hasButton="false" title="주문/결제" />

	<%-- 디버깅: checkoutData 확인 --%>
	<div
		style="background: #f0f0f0; padding: 10px; margin: 10px; border: 2px solid red;">
		<h3>🔍 디버깅 정보</h3>
		<p>checkoutData가 null인가? ${checkoutData == null ? 'YES - 문제있음!' : 'NO - 데이터 있음'}</p>
		<p>brand가 null인가? ${checkoutData.brand == null ? 'YES' : 'NO'}</p>
		<p>product가 null인가? ${checkoutData.product == null ? 'YES' : 'NO'}</p>
		<p>items 개수: ${checkoutData.items != null ? checkoutData.items.size() : 'null'}</p>

		<hr>

		<c:if test="${not empty checkoutData}">
			<p>
				<strong>Brand Name:</strong> ${checkoutData.brand.brandName}
			</p>
			<p>
				<strong>Product Name:</strong> ${checkoutData.product.name}
			</p>
			<p>
				<strong>Product ID:</strong> ${checkoutData.product.productId}
			</p>
		</c:if>

		<c:if test="${not empty checkoutData.items}">
			<h4>Items 정보:</h4>
			<c:forEach var="item" items="${checkoutData.items}"
				varStatus="status">
				<p>Item ${status.index}: optionId=${item.optionId},
					optionValue=${item.optionValue}, quantity=${item.quantity},
					unitPrice=${item.unitPrice}</p>
			</c:forEach>
		</c:if>
	</div>

	<main class="main-container">
		<div class="main-content">

			<form method="post" action="checkout">

				<!-- 배송지 정보 -->
				<section class="shipping-info-section">
					<h2 class="section-title">배송지 정보</h2>
					<div class="delivery-form">
						<div class="form-row receiver-row">
							<div class="label">
								받는분 <span class="required">*</span>
							</div>
							<div class="input-area">
								<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
								<my:textInput id="shipRecipient" name="shipRecipient"
									value="${checkoutData.member.name}" type="default" size="lg"
									state="default" />
								<!-- <label class="checkbox-option"> <input type="checkbox">
								주문자정보와 동일
							</label> -->
							</div>
						</div>

						<div class="form-row phone-row">
							<div class="label">
								연락처 <span class="required">*</span>
							</div>
							<div class="input-area">
								<div class="phone-group">

									<%
									// checkoutData에서 member 꺼내기
									Map<String, Object> data = (Map<String, Object>) request.getAttribute("checkoutData");
									Member member = (Member) data.get("member");

									// 전화번호 가져오기
									String phoneNumber = (member != null && member.getPhone() != null) ? member.getPhone() : "";

									// 디버깅 출력
									System.out.println("전화번호: " + phoneNumber);

									// 3개로 나누기
									String p1 = "", p2 = "", p3 = "";
									if (!phoneNumber.isEmpty() && phoneNumber.contains("-")) {
										String[] parts = phoneNumber.split("-");
										if (parts.length == 3) {
											p1 = parts[0];
											p2 = parts[1];
											p3 = parts[2];
										}
									}
									%>
									<my:textInput id="shipPhone1" name="shipPhone1" value="<%=p1%>"
										type="default" size="sm" state="default" />
									<span class="dash">-</span>
									<my:textInput id="shipPhone2" name="shipPhone2" value="<%=p2%>"
										type="default" size="sm" state="default" />
									<span class="dash">-</span>
									<my:textInput id="shipPhone3" name="shipPhone3" value="<%=p3%>"
										type="default" size="sm" state="default" />
								</div>
							</div>
						</div>
						<div class="form-row address-row">
							<div class="label">
								주소 <span class="required">*</span>
							</div>
							<div class="input-area address-row">
								<div class="address-input-group">
									<my:textInput id="shipPostcode" name="shipPostcode"
										value="${checkoutData.member.postcode}" type="default"
										size="sm" state="default" />
									<button type="button" class="btn btn-outline btn-md"
										style="width: auto; min-width: auto;">우편번호 찾기</button>
								</div>
								<div class=detail-address>
									<my:textInput id="shipLine1" name="shipLine1"
										value="${checkoutData.member.line1}" type="default" size="sm"
										state="default" />
									<my:textInput id="shipLine2" name="shipLine2"
										value="${checkoutData.member.line2}" type="default" size="sm"
										state="default" />
								</div>
							</div>
						</div>
					</div>
				</section>

				<!-- 배송 요청사항 -->
				<section class="delivery-request">
					<h2 class="section-title">배송 요청사항</h2>
					<div class="delivery-form">
						<div class="form-row delivery-message">
							<div class="label">배송메시지</div>
							<div class="input-area">
								<my:textInput id="note" name="note" placeholder="요청사항을 입력해주세요"
									type="default" size="md" state="default" />
							</div>
						</div>
					</div>
				</section>

				<!-- 주문 배송상품 -->
				<section class="order-products">
					<h2 class="section-title">주문 배송상품</h2>
					<div class="product-table">
						<div class="table-header">
							<div class="col-product">상품정보</div>
							<div class="col-price">판매가</div>
							<div class="col-quantity">수량</div>
							<div class="col-total">구매가</div>
						</div>
						<%-- items 배열을 forEach로 반복 --%>
						<c:forEach var="item" items="${checkoutData.items}">
							<div class="table-row">
								<div class="col-product">
									<div class="product-info">
										<img src="https://via.placeholder.com/80x80" alt="상품"
											class="product-image">
										<div class="product-details">
											<%--  checkoutData.brand, product 사용 --%>
											<div class="brand">${checkoutData.brand.brandName}</div>
											<div class="product-name">${checkoutData.product.name}</div>
											<div class="product-option">${item.optionValue}</div>
										</div>
									</div>
								</div>
								<%-- item의 데이터 사용 --%>
								<div class="col-price">${item.unitPrice}원</div>
								<div class="col-quantity">${item.quantity}</div>
								<div class="col-total">${item.itemTotal}원</div>
							</div>
						</c:forEach>
					</div>
				</section>

				<div class="content-layout">
					<div class="left-content">
						<!-- 쿠폰할인정보 -->
						<section class="coupon-section">
							<h3 class="section-title">쿠폰할인정보</h3>
							<div class="coupon-form">
								<div class="form-row">
									<div class="label">쿠폰</div>
									<div class="input-area">
										<select name="usingCoupon" class="coupon-select">
											<option value="">사용 가능한 쿠폰 목록</option>
											<option value="coupon1">10,000원 할인 쿠폰</option>
											<option value="coupon2">5,000원 할인 쿠폰</option>
										</select>
									</div>
								</div>

								<div class="form-row">
									<div class="label">포인트</div>
									<div class="input-area">
										<input type="number" name="usingPoint" value="0"
											class="point-input"> <span class="point-unit">원
											/ 사용가능 포인트: ${checkoutData.member.pointBalance} P</span>
									</div>
								</div>
							</div>
						</section>

						<!-- 결제수단 선택: (토스페이만!) -->
						<div class="payment-section">
							<h3 class="section-title">결제수단 선택</h3>
							<div class="payment-option">
								<label class="toss-payment-label"> <input type="radio"
									name="paymentMethod" value="toss" checked> <span
									class="sr-only">토스페이먼츠로 결제</span> <img
									src="<c:url value='/image/logo-toss-pay.svg'/>" alt="토스페이"
									class="toss-payment-img">
								</label>
							</div>
						</div>
					</div>
					<!-- 최종 결제 정보 -->
					<div class="right-content">
						<div class="payment-summary">
							<h3 class="payment-title">최종 결제 정보</h3>

							<div class="price-breakdown">
								<div class="price-item">
									<span class="price-label">총 상품 금액</span> <span
										class="price-value" id="displaySubtotal">0 원</span>
								</div>
								<div class="price-item">
									<span class="price-label">쿠폰 할인 금액</span> <span
										class="price-value discount" id="couponDiscount">0 원</span>
								</div>
								<div class="price-item">
									<span class="price-label">포인트 사용 금액</span> <span
										class="price-value" id="pointUsage">0 원</span>

								</div>
							</div>

							<div class="shipping-fee">
								<div class="price-item">
									<span class="price-label">총 배송비</span> <span
										class="price-value">${checkoutData.shippingFee} 원</span>
								</div>
							</div>

							<div class="final-total">
								<div class="price-item total">
									<span class="price-label">최종결제금액</span> <span
										class="price-value final" id="displayTotal">0 원</span>
								</div>
							</div>

							<div class="point-earn">
								<div class="price-item">
									<span class="price-label">포인트 적립 혜택</span> <span
										class="price-value" id="pointEarn">0 원</span>
								</div>
							</div>

							<div class="agreement-section">
								<label class="checkbox-option"> <input type="checkbox"
									required> 주문 내용을 확인했으며, 아래 내용에 모두 동의합니다.
								</label>
								<div class="agreement-links">
									<div>개인정보 수집/이용 동의</div>
									<div>개인정보 제3자 제공 동의</div>
									<div>결제대행 서비스 이용약관</div>
								</div>
							</div>
							<div class=button-wrapper>
								<!--  hidden field -->
								<input type="hidden" name="productId"
									value="${checkoutData.product.productId}"> <input
									type="hidden" name="brandId"
									value="${checkoutData.brand.brandId}">

								<%-- 여러 옵션 정보 전달 --%>
								<c:forEach var="item" items="${checkoutData.items}"
									varStatus="status">
									<input type="hidden" name="items[${status.index}].optionId"
										value="${item.optionId}">
									<input type="hidden" name="items[${status.index}].quantity"
										value="${item.quantity}">
								</c:forEach>

								<!-- 금액 정보 -->
								<input type="hidden" name="subtotalAmount" id="subtotalAmount">
								<input type="hidden" name="discountAmount" id="discountAmount">
								<input type="hidden" name="shippingAmount" id="shippingAmount"
									value="${checkoutData.shippingFee}"> <input
									type="hidden" name="totalAmount" id="totalAmount">

								<button type="button" class="btn btn-primary btn-lg">결제하기</button>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</main>

	<script>
		window.checkoutData = {
			// 금액 정보
			subtotal : parseFloat('${checkoutData.subtotalAmount}') || 0,
			shipping : parseFloat('${checkoutData.shippingFee}') || 0,
			availablePoint : parseInt('${checkoutData.member.pointBalance}') || 0,

			// 회원 정보
			memberPhone : '${checkoutData.member.phone}',

			// 상품 정보
			productId : '${checkoutData.product.productId}',
			productName : '${checkoutData.product.name}',
			brandId : '${checkoutData.brand.brandId}'
		};
		console.log('checkoutData:', window.checkoutData);
	</script>
	<!-- 카카오 우편번호 서비스 -->
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="/consumer/js/checkout.js"></script>
	<!-- 푸터 include -->
	<%@ include file="/consumer/footer.jsp"%>
</body>
</html>