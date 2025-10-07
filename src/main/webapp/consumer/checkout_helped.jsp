<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>  
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
<link rel="stylesheet" href="<c:url value='/consumer/css/tab.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/checkout.css'/>">
<link rel="stylesheet" href="<c:url value='/consumer/css/footer.css'/>">
<!-- 토스페이 SDK -->
<script src="https://js.tosspayments.com/v1/payment"></script>
</head>
<body>
	<!-- 헤더 include -->
	<%@ include file="/consumer/header.jsp"%>
	<!-- 헤더 include end  -->


	<main class="checkout-container">
		<div class="checkout-content">

			<!-- 왼쪽 영역: 배송지 정보 및 주문상품 -->
			<div class="checkout-left">
				<h1 class="page-title">주문결제</h1>

				<!-- 배송지 정보 -->
				<section class="shipping-info-section">
					<h2 class="section-title">배송지 정보</h2>
					<div class="form-group">
						<label for="recipientName">배송지 선택</label> <select
							id="shippingType" name="shippingType" class="form-select">
							<option value="home">집</option>
							<option value="company">회사</option>
							<option value="new">새로운 배송지</option>
						</select>
					</div>

					<div class="form-group">
						<label for="recipientName">배송지명</label> <input type="text"
							id="recipientName" name="recipientName" class="form-input"
							value="집">
					</div>

					<div class="form-group">
						<label for="phoneNumber">연락처1</label>
						<div class="phone-group">
							<input type="text" maxlength="4" class="phone-input"> <span
								class="phone-dash">-</span> <input type="text" maxlength="4"
								class="phone-input"> <span class="phone-dash">-</span> <input
								type="text" maxlength="4" class="phone-input">
						</div>
					</div>

					<div class="form-group">
						<label for="phoneNumber2">연락처2</label>
						<div class="phone-group">
							<select class="phone-select">
								<option value="010">010</option>
								<option value="011">011</option>
								<option value="016">016</option>
								<option value="017">017</option>
								<option value="018">018</option>
								<option value="019">019</option>
							</select> <span class="phone-dash">-</span> <input type="text"
								maxlength="4" class="phone-input"> <span
								class="phone-dash">-</span> <input type="text" maxlength="4"
								class="phone-input">
						</div>
					</div>

					<div class="form-group">
						<label>주소</label>
						<div class="address-group">
							<div class="address-row">
								<input type="text" id="postcode" name="postcode"
									placeholder="우편번호" readonly class="form-input">
								<button type="button" class="address-search-btn"
									onclick="findPostcode()">우편번호 찾기</button>
							</div>
							<input type="text" id="address" name="address" placeholder="주소"
								readonly class="form-input"> <input type="text"
								id="detailAddress" name="detailAddress" placeholder="상세주소"
								class="form-input">
							<textarea id="deliveryMemo" name="deliveryMemo"
								placeholder="배송 메모" class="form-textarea" style="resize: none"></textarea>
						</div>
					</div>
				</section>

				<!-- 배송 요청사항 -->
				<section class="delivery-request-section">
					<h2 class="section-title">배송 요청사항</h2>
					<div class="form-group">
						<label for="deliveryRequest">배송 메시지</label> <input type="text"
							id="deliveryRequest" name="deliveryRequest" class="form-input"
							placeholder="text">
					</div>

					<div class="form-group">
						<label for="expectedDelivery">기타 상세 내용</label> <input type="text"
							id="expectedDelivery" name="expectedDelivery" class="form-input"
							placeholder="text">
					</div>
				</section>

				<!-- 주문상품 -->
				<section class="order-items-section">
					<h2 class="section-title">배송상품</h2>
					<div class="order-item">
						<div class="item-image">
							<img src="<c:url value='/images/product-thumb.jpg'/>"
								alt="상품 이미지">
						</div>
						<div class="item-info">
							<div class="brand-name">브랜드</div>
							<div class="product-name">명성 닥터리얼 단백질용액이 어쩌고 저쩌고 456g 역시 1</div>
							<div class="item-price">
								<span class="original-price">39,000원</span> <span
									class="final-price">39,000원</span>
							</div>
						</div>
					</div>
				</section>

				<!-- 쿠폰 및 포인트 -->
				<section class="coupon-point-section">
					<h2 class="section-title">쿠폰할인정보</h2>
					<div class="form-group">
						<label for="coupon">쿠폰</label> <select id="coupon" name="coupon"
							class="form-select">
							<option value="">사용 가능한 쿠폰을 선택하세요</option>
							<option value="coupon1">10% 할인 쿠폰</option>
							<option value="coupon2">5,000원 할인 쿠폰</option>
						</select>
					</div>

					<div class="form-group">
						<label for="point">포인트</label>
						<div class="point-group">
							<span class="point-info">보유 포인트: 200 P</span>
							<div class="point-input-group">
								<input type="number" id="point" name="point" class="form-input"
									placeholder="0" min="0" max="200"> <span
									class="point-unit">P</span>
							</div>
						</div>
					</div>
				</section>

				<!-- 결제수단 선택 -->
				<section class="payment-method-section">
					<h2 class="section-title">결제수단 선택</h2>
					<div class="payment_box">
						<label class="payment-method-label">
							<div class="payment-method-check">
								<input type="radio" name="paymentMethod" value="toss"
									class="payment-radio" checked>
							</div>
							<div class="payment-method-option">
								<div class="payment-content">
									<div class="toss-pay-button">
										<img
											src="<c:url value='/resources/images/toss-pay-logo.png'/>"
											alt="토스페이" class="toss-logo">
									</div>
									<p class="payment-description">토스페이로 간편하고 안전하게 결제하세요</p>
								</div>
							</div>
						</label>


					</div>
				</section>
			</div>

			<!-- 왼쪽 영역: 배송지 정보 및 주문상품 end -->

			<!-- 오른쪽 영역: 최종결제정보 (sticky) -->
			<div class="checkout-right">
				<div class="payment-summary" id="paymentSummary">
					<div class="payment_info">
						<h2 class="summary-title">최종 결제 정보</h2>

						<div class="summary-row">
							<span class="summary-label">총 상품 금액</span> <span
								class="summary-value">20,200원</span>
						</div>

						<div class="summary-row">
							<span class="summary-label">쿠폰 할인 금액</span> <span
								class="summary-value discount">-2,000원</span>
						</div>

						<div class="summary-row">
							<span class="summary-label">포인트 사용 금액</span> <span
								class="summary-value discount">0원</span>
						</div>

						<div class="summary-divider"></div>

						<div class="summary-row">
							<span class="summary-label">총 배송비</span> <span
								class="summary-value">2,500원</span>
						</div>

						<div class="summary-divider"></div>

						<div class="summary-row total">
							<span class="summary-label">최종결제금액</span> <span
								class="summary-value final-amount">20,700원</span>
						</div>

						<div class="summary-row points">
							<span class="summary-label">포인트 적립 혜택</span> <span
								class="summary-value">200원</span>
						</div>

						<div class="agreement-section">
							<label class="checkbox-label"> <input type="checkbox"
								id="agreeAll" name="agreeAll"> <span>주문 내용을
									확인했으며, 아래 내용에 모두 동의합니다.</span>
							</label>
							<ul class="agreement-list">
								<li>개인정보 수집/이용 동의</li>
								<li>개인정보 제3자 제공 동의</li>
								<li>결제대행 서비스 이용약관</li>
							</ul>
						</div>
					</div>

					<div class="payment_btn">
						<button type="button" class="final-payment-btn"
							onclick="processPayment()">결제하기</button>

					</div>

				</div>
			</div>
			<!-- 오른쪽 영역: 최종결제정보 (sticky) end -->
		</div>
	</main>

	<!-- 푸터 include -->
	<%@ include file="/consumer/footer.jsp"%>

	<!-- 카카오 우편번호 서비스 -->
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="<c:url value='/js/checkout.js'/>"></script>
</body>
</html>