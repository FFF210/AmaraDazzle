<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="dto.Member"%>
<%@ page import="java.util.Map"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
<link rel="stylesheet" href="<c:url value='/tagcss/selectbox.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/header.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/pageHeader.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/textInput.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/table.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/button.css'/>">
<link rel="stylesheet"
	href="<c:url value='/consumer/css/checkout.css'/>">

<!-- 토스 sdk 버전1 -->
<script src="https://js.tosspayments.com/v1"></script>
</head>

<body>
	<!-- 헤더 include -->
	<%@ include file="/consumer/header.jsp"%>

	<!-- 페이지헤더 -->
	<div class="pageHeader-wrapper">
		<my:pageHeader hasButton="false" title="주문/결제" />
	</div>

	디버깅: checkoutData 확인
	<div
		style="background: #f0f0f0; padding: 10px; margin: 10px; border: 2px solid red;">
		<h3>🔍 디버깅 정보</h3>
		<p>checkoutData가 null인가? ${checkoutData == null ? 'YES - 문제있음!' : 'NO - 데이터 있음'}</p>
		<!-- 장바구니 여부 확인 -->
		<c:choose>
			<c:when test="${checkoutData.isFromCart}">
				<p>
					<strong>주문 방식:</strong> 🛒 장바구니에서 주문
				</p>
				<p>
					<strong>상품 개수:</strong> ${checkoutData.items.size()}개
				</p>
			</c:when>
			<c:otherwise>
				<p>
					<strong>주문 방식:</strong> 📦 상품 직접 구매
				</p>
				<p>
					<strong>Brand:</strong> ${checkoutData.brand.brandName}
				</p>
				<p>
					<strong>Product:</strong> ${checkoutData.product.name}
				</p>
			</c:otherwise>
		</c:choose>

		<hr>
		<h4>Items 목록:</h4>
		<c:forEach var="item" items="${checkoutData.items}" varStatus="status">
			<p>Item ${status.index}: ${item.brandName} - ${item.productName}</p>
		</c:forEach>
	</div>

	<div class="main-content">

		<form method="post" action="checkout">
			<!-- 배송지 정보 -->
			<div class="shipping-info-section">
				<h2 class="section-title">배송지 정보</h2>

				<div class="delivery-form">
					<div class="form-row receiver-row">
						<div class="label">
							받는분 <span class="required">*</span>
						</div>
						<div class="input-area">
							<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
							<my:textInput id="shipRecipient" name="shipRecipient"
								value="${checkoutData.member.name}" type="default" size="sm"
								state="default" />
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
								<p class="dash">-</p>
								<my:textInput id="shipPhone2" name="shipPhone2" value="<%=p2%>"
									type="default" size="sm" state="default" />
								<p class="dash">-</p>
								<my:textInput id="shipPhone3" name="shipPhone3" value="<%=p3%>"
									type="default" size="sm" state="default" />
							</div>
						</div>
					</div>

					<div class="form-row address-row" style="height: 140px;">
						<div class="label">
							주소 <span class="required">*</span>
						</div>
						<div class="input-area address-row">
							<div class="address-input-group">
								<my:textInput id="shipPostcode" name="shipPostcode"
									value="${checkoutData.member.postcode}" type="default"
									size="sm" state="default" />
								<button type="button" id="findPostcodeBtn"
									class="btn btn-primary btn-sm" style="width: 150px;">우편번호
									찾기</button>
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
			</div>

			<!-- 배송 요청사항 -->
			<div class="delivery-request">
				<h2 class="section-title">배송 요청사항</h2>
				<div class="delivery-form">
					<div class="form-row delivery-message">
						<div class="label">배송메시지</div>
						<div class="input-area">
							<my:textInput id="note" name="note" placeholder="요청사항을 입력해주세요"
								type="default" size="sm" state="default" />
						</div>
					</div>
				</div>
			</div>

			<!-- 주문 배송상품 -->
			<div class="order-products">
				<h2 class="section-title">주문 배송상품</h2>
				<div class="table-wrapper">
					<table class="table">
						<thead>
							<tr>
								<th style="padding: 0;">상품</th>
								<th style="width: 120px; padding: 0;">판매가</th>
								<th style="width: 50px; padding: 0;">수량</th>
								<th style="width: 120px; padding: 0;">주문금액</th>
							</tr>
						</thead>
						<tbody>
							<!-- 주문별 외부 루프 -->
							<c:forEach var="item" items="${checkoutData.items}">
								<tr>
									<!-- 상품 정보 -->
									<td style="padding: 0;"
										onclick="location.href='${pageContext.request.contextPath}/store/productDetail?productId=${item.productId}'">
										<div
											style="display: flex; align-items: center; gap: 12px; padding: 20px 0;">
											<img
												src="${pageContext.request.contextPath}/image?fileId=${item.thumbnailFileId}"
												alt="${item.productName}"
												style="width: 80px; height: 80px; object-fit: cover;">

											<div class="product-info"
												style="text-align: left; display: flex; flex-direction: column; width: 100%; height: fit-content; gap: 6px;">
												<p class="product-brand"
													style="color: #333; font-weight: 700; font-size: 13px;">${item.brandName}</p>
												<p class="product-name">${item.productName}</p>
												<c:if test="${not empty item.optionValue}">
													<P style="color: #888; font-weight: 400; font-size: 13px;">옵션
														| ${item.optionValue}</P>
												</c:if>
											</div>
										</div>
									</td>
									<td style="padding: 0; color: #111; font-size: 13px;"><fmt:formatNumber
											value="${item.unitPrice}" pattern="#,###" />원</td>
									<td style="padding: 0; color: #111; font-size: 13px;">${item.quantity}</td>
									<td
										style="padding: 0; color: #111; font-size: 13px; font-weight: 500;">
										<span id="brandId-${item.brandId}" data-totalprice="${item.itemTotal}" data-productid="${item.productId}" class="totalPrice">
											<fmt:formatNumber value="${item.itemTotal}" pattern="#,###" /></span>원</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>

			<div class="content-layout">
				<div class="left-content">
					<!-- 쿠폰할인정보 -->
					<section class="coupon-section">
						<h3 class="section-title">쿠폰할인정보</h3>
						<div class="coupon-form">
							<div class="form-row">
								<div class="label">쿠폰</div>
								<div class="input-area">
									<select name="usingCoupon" class="coupon-select"
										onchange="setCouponAmount(this)">
										<option value="">사용 가능한 쿠폰 목록</option>
										<c:forEach var="coupon" items="${availableCoupons}">
											<option value="${coupon.memberCouponId}"
												data-amount="${coupon.amount}" data-brandid="${coupon.writerId}">${coupon.cname}(
												<fmt:formatNumber value="${coupon.amount}" pattern="#,###" />원
												할인)
											</option>
										</c:forEach>
									</select> <input type="hidden" name="couponAmount" id="couponAmount"
										value="">
								</div>
							</div>

							<div class="form-row">
								<div class="label">포인트</div>
								<div class="input-area">
									<input type="number" name="usingPoint" value="0"
										class="point-input" style="height: 36px;"> <span
										class="point-unit">사용가능 포인트:
										${checkoutData.member.pointBalance} P</span>
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
								<span class="price-label">총 배송비</span> <span class="price-value">${checkoutData.shippingFee}
									원</span>
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
							<!-- 장바구니가 아닐 때만 productId/brandId 전송 -->
							<c:if test="${not checkoutData.isFromCart}">
								<input type="hidden" name="productId"
									value="${checkoutData.product.productId}">
								<input type="hidden" name="brandId"
									value="${checkoutData.brand.brandId}">
							</c:if>

							<%-- 여러 옵션 정보 전달 --%>
							<c:forEach var="item" items="${checkoutData.items}"
								varStatus="status">
								<input type="hidden" name="items[${status.index}].brandId"
									value="${item.brandId}">
								<input type="hidden" name="items[${status.index}].productId"
									value="${item.productId}">
								<input type="hidden" name="items[${status.index}].optionId"
									value="${item.optionId}">
								<input type="hidden" name="items[${status.index}].quantity"
									value="${item.quantity}">
								<input type="hidden" name="items[${status.index}].unitPrice"
									value="${item.unitPrice}">
								<input type="hidden" name="items[${status.index}].itemTotal"
									value="${item.itemTotal}" id="h-${item.productId}">
								<input type="hidden" name="items[${status.index}].memberCouponId" id="c-${item.productId}">
							</c:forEach>

							<!-- 금액 정보 -->
							<input type="hidden" name="subtotalAmount" id="subtotalAmount">
							<input type="hidden" name="discountAmount" id="discountAmount">
							<input type="hidden" name="shippingAmount" id="shippingAmount"
								value="${checkoutData.shippingFee}"> <input
								type="hidden" name="totalAmount" id="totalAmount">

							<button type="button" id="paymentBtn"
								class="btn btn-primary btn-lg" style="width: 130px">결제하기</button>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	<script src="<c:url value='/js/selectbox.js'/>"></script>
	<script>
		function setCouponAmount(select) {
			resetProductTotalPrice();
			const selectedOption = select.options[select.selectedIndex];
			const amount = selectedOption.dataset.amount || "";
			document.getElementById("couponAmount").value = amount;
			const brandid = selectedOption.dataset.brandid || "";
			const itemTotPriceSpan = document.getElementById("brandId-"+brandid);
			if(itemTotPriceSpan!=null) {
				console.log(itemTotPriceSpan.dataset.totalprice)
				const salePrice = +itemTotPriceSpan.dataset.totalprice - +amount;
				itemTotPriceSpan.innerText = salePrice.toLocaleString();
				const hiddenItemTotal = document.getElementById("h-"+itemTotPriceSpan.dataset.productid);
				hiddenItemTotal.value = salePrice;
				const memberCoupon = document.getElementById("c-"+itemTotPriceSpan.dataset.productid);
				memberCoupon.value = selectedOption.value;
			}
		}
		
		function resetProductTotalPrice() {
			const elements = document.querySelectorAll('.totalPrice');
			elements.forEach((el, index) => {
			  el.innerText = (Math.floor(+el.dataset.totalprice)).toLocaleString();  
			  document.getElementById("h-"+el.dataset.productid).value = Math.floor(+el.dataset.totalprice);
			  document.getElementById("c-"+el.dataset.productid).value=""
			});
		}

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