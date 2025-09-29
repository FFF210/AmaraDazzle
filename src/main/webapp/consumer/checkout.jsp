<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>주문결제</title>
<link rel="stylesheet" href="<c:url value='/tagcss/reset.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/header.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/pageHeader.css'/>">
<link rel="stylesheet"
	href="<c:url value='/consumer/css/checkout.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/textInput.css'/>">
<link rel="stylesheet" href="<c:url value='/tagcss/button.css'/>">


<!-- 토스페이 SDK -->
<script src="https://js.tosspayments.com/v1/payment"></script>
</head>
<body>
	<!-- 헤더 include -->
	<%@ include file="/consumer/header.jsp"%>

	<!-- 페이지헤더 -->
	<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
	<my:pageHeader hasButton="false" title="주문/결제" />

	<main class="checkout-container">
		<div class="checkout-content">

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
									<my:textInput id="shipPhone" name="shipPhone" placeholder="010"
										type="default" size="sm" state="default" />
									<span class="dash">-</span>
									<my:textInput id="shipPhone" name="shipPhone"
										placeholder="1234" type="default" size="sm" state="default" />
									<span class="dash">-</span>
									<my:textInput id="shipPhone" name="shipPhone"
										placeholder="5678" type="default" size="sm" state="default" />
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
									<button type="button" class="btn btn-outline btn-md">우편번호
										찾기</button>
								</div>
								<div class=detail-address>
									<my:textInput id="shipLine1" name="shipLine1"
									value="${checkoutData.member.line1}"
										type="default" size="sm" state="default" />
									<my:textInput id="shipLine2" name="shipLine2"
									value="${checkoutData.member.line2}" type="default" size="sm" state="default" />
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
						<div class="table-row">
							<div class="col-product">
								<div class="product-info">
									<img src="https://via.placeholder.com/80x80" alt="에뛰드"
										class="product-image">
									<div class="product-details">
										<div class="brand">${checkoutData.productData.productInfo.brandName}</div>
										<div class="product-name">${checkoutData.productData.productInfo.productName}
									    </div>
										<div class="product-option">
											<c:if test="${checkoutData.productData.optionInfo != null}">
                                             ${checkoutData.productData.optionInfo.optionValue}
                                          </c:if>
										</div>
										<div class="product-tags"></div>
									</div>
								</div>
							</div>
							<div class="col-price">${checkoutData.productData.priceInfo.originalPrice}원</div>
							<div class="col-quantity">${quantity}</div>
							<div class="col-total">
								<div class="original-price">${checkoutData.productData.priceInfo.originalPrice}원</div>
								<div class="sale-price">${checkoutData.productData.priceInfo.salePrice}원</div>
							</div>
						</div>
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
								<input type="checkbox" class="payment-checkbox">
								<button class="toss-btn">
									<span>toss</span><span class="light">pay</span>
								</button>
							</div>
						</div>
					</div>
					<!-- 최종 결제 정보 -->
					<div class="right-content">
						<div class="payment-summary">
							<h3 class="payment-title">최종 결제 정보</h3>

							<div class="price-breakdown">
								<div class="price-item">
									<span class="price-label">총 상품 금액</span>
									<span class="price-value" id="displaySubtotal">0 원</span>
								</div>
								<div class="price-item">
									<span class="price-label">쿠폰 할인 금액</span>
									<span class="price-value discount" id="couponDiscount">0 원</span>
								</div>
								<div class="price-item">
									<span class="price-label">포인트 사용 금액</span>
									<span class="price-value" id="pointUsage">0 원</span>
									
								</div>
							</div>

							<div class="shipping-fee">
								<div class="price-item">
									<span class="price-label">총 배송비</span> <span
										class="price-value">2,500 원</span>
								</div>
							</div>

							<div class="final-total">
								<div class="price-item total">
									<span class="price-label">최종결제금액</span>
									<span class="price-value final" id="displayTotal">0 원</span>
								</div>
							</div>

							<div class="point-earn">
								<div class="price-item">
									<span class="price-label">포인트 적립 혜택</span> <span
										class="price-value">0 원</span>
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
								<input type="hidden" name="productId" value="${productId}">
								<input type="hidden" name="quantity" value="${quantity}">
								<input type="hidden" name="optionId" value="${optionId}">
								<input type="hidden" name="brandId"
									value="${checkoutData.productData.productInfo.brandId}">

								<!-- 금액 정보 (JavaScript로 동적 계산 후 설정) -->
								<input type="hidden" name="unitPrice" id="unitPrice"> <input
									type="hidden" name="subtotalAmount" id="subtotalAmount">
								<input type="hidden" name="discountAmount" id="discountAmount">
								<input type="hidden" name="shippingAmount" value="2500">
								<input type="hidden" name="totalAmount" id="totalAmount">

								<button type="submit" class="btn btn-primary btn-lg">결제하기</button>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</main>
	<!-- <script src="js/checkout.js"></script> -->
	
	<script>
// 페이지 로드 시 금액 계산
window.onload = function() {
    calculateTotalAmount();
};

function calculateTotalAmount() {
	// 실제 상품 가격 가져오기
    const originalPrice = parseFloat('${checkoutData.productData.priceInfo.originalPrice}') || 0;
    const quantity = parseInt('${quantity}') || 1;
    const subtotal = originalPrice * quantity;
    
    // 화면에 표시
    document.getElementById('displaySubtotal').textContent = subtotal + ' 원';
    
    // hidden 필드에 설정
    document.getElementById('unitPrice').value = originalPrice;
    document.getElementById('subtotalAmount').value = subtotal;
    
    // 초기 총 금액 계산
    calculateTotal();
}

//포인트 입력 시 실시간 업데이트
document.querySelector('input[name="usingPoint"]').addEventListener('input', function() {
    const pointValue = parseInt(this.value) || 0;
    document.getElementById('pointUsage').textContent = pointValue + ' 원';
    calculateTotal(); // 총 금액 재계산
});

// 쿠폰 선택 시 실시간 업데이트
document.querySelector('select[name="usingCoupon"]').addEventListener('change', function() {
    let discountAmount = 0;
    
    // 쿠폰별 할인 금액 (하드코딩 - 나중에 서버에서 받아와야 함)
    if (this.value === 'coupon1') {
        discountAmount = 10000;
    } else if (this.value === 'coupon2') {
        discountAmount = 5000;
    }
    
    document.getElementById('couponDiscount').textContent = '-' + discountAmount + ' 원';
    calculateTotal(); // 총 금액 재계산
});

// 총 금액 계산
function calculateTotal() {
    // 상품 금액
    const subtotal = parseFloat(document.getElementById('subtotalAmount').value) || 0;
    
    // 할인 금액들
    const couponDiscount = getCouponDiscountValue();
    const pointDiscount = parseInt(document.querySelector('input[name="usingPoint"]').value) || 0;
    
    // 배송비
    const shipping = 2500;
    
    // 최종 금액
    const total = subtotal - couponDiscount - pointDiscount + shipping;
    
    // 화면에 표시
    document.getElementById('displayTotal').textContent = total + ' 원';
    
    // hidden 필드에도 설정 (서버 전송용)
    document.getElementById('totalAmount').value = total;
    document.getElementById('discountAmount').value = couponDiscount + pointDiscount;
}

// 쿠폰 할인 금액 가져오기
function getCouponDiscountValue() {
    const selectedCoupon = document.querySelector('select[name="usingCoupon"]').value;
    if (selectedCoupon === 'coupon1') return 10000;
    if (selectedCoupon === 'coupon2') return 5000;
    return 0;
}
</script>


	<!-- 푸터 include -->
	<%@ include file="/consumer/footer.jsp"%>

	<!-- 카카오 우편번호 서비스 -->
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</body>
</html>