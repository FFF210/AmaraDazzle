// 토스페이먼츠 클라이언트 키
window.onload = function() {
	console.log('checkout.js 로드됨');

	fillPhoneNumber();
	calculateTotalAmount();
	initEventListeners();

	// 결제 실패 확인
	const urlParams = new URLSearchParams(window.location.search);
	if (urlParams.get('paymentFailed')) {
		const message = urlParams.get('message') || '결제에 실패했습니다.';
		alert(message);
	}
};

// 이벤트 리스너 초기화
function initEventListeners() {
	console.log('이벤트 리스너 초기화');

	const pointInput = document.querySelector('input[name="usingPoint"]');
	const maxPoint = window.checkoutData.availablePoint || 0;

	pointInput.addEventListener('input', function() {
		let value = parseInt(this.value) || 0;
		if (value > maxPoint) this.value = maxPoint;
		if (value < 0) this.value = 0;

		document.getElementById('pointUsage').textContent = this.value + ' 원';
		calculateTotal();
	});

	document.querySelector('select[name="usingCoupon"]').addEventListener('change', function() {
		let discountAmount = 0;

		if (this.value) {
			const selectedOption = this.options[this.selectedIndex];
			discountAmount = parseInt(selectedOption.getAttribute('data-amount')) || 0;
		}

		document.getElementById('couponDiscount').textContent = '-' + discountAmount.toLocaleString() + ' 원';
		calculateTotal();
	});

	// 우편번호 찾기
	const findPostcodeBtn = document.getElementById('findPostcodeBtn');
	if (findPostcodeBtn) {
		findPostcodeBtn.addEventListener('click', findPostcode);
	}

	// 결제하기 버튼
	const paymentButton = document.getElementById('paymentBtn');
	if (paymentButton) {
		paymentButton.addEventListener('click', function(e) {
			console.log('결제하기 버튼 클릭!');
			e.preventDefault();

			if (!validateForm()) {
				return;
			}

			saveOrderDataToSession();
		});
	}
}  // ✅ 여기가 빠져있었어요!

// 전화번호 자동 입력 함수
function fillPhoneNumber() {
	const phone = window.checkoutData.memberPhone;
	if (phone) {
		const parts = phone.split('-');
		if (parts.length === 3) {
			const phoneInputs = document.querySelectorAll('#shipPhone1, #shipPhone2, #shipPhone3');
			if (phoneInputs.length >= 3) {
				phoneInputs[0].value = parts[0];
				phoneInputs[1].value = parts[1];
				phoneInputs[2].value = parts[2];
			}
		}
	}
}

// 폼 유효성 검사
function validateForm() {
	const recipient = document.getElementById('shipRecipient').value.trim();
	const phone1 = document.getElementById('shipPhone1').value.trim();
	const phone2 = document.getElementById('shipPhone2').value.trim();
	const phone3 = document.getElementById('shipPhone3').value.trim();
	const postcode = document.getElementById('shipPostcode').value.trim();
	const line1 = document.getElementById('shipLine1').value.trim();
	const checkbox = document.querySelector('.agreement-section input[type="checkbox"]');

	if (!recipient) {
		alert('받는 분 이름을 입력해주세요.');
		document.getElementById('shipRecipient').focus();
		return false;
	}

	if (!phone1 || !phone2 || !phone3) {
		alert('연락처를 입력해주세요.');
		return false;
	}

	if (!postcode || !line1) {
		alert('주소를 입력해주세요.');
		return false;
	}

	if (!checkbox.checked) {
		alert('주문 내용 및 약관에 동의해주세요.');
		return false;
	}

	return true;
}

// 우편번호 찾기
function findPostcode() {
	new daum.Postcode({
		oncomplete: function(data) {
			document.getElementById('shipPostcode').value = data.zonecode;
			document.getElementById('shipLine1').value = data.address;
			document.getElementById('shipLine2').focus();
		}
	}).open();
}

// 초기 금액 계산
function calculateTotalAmount() {
	const subtotal = window.checkoutData.subtotal || 0;
	const shipping = window.checkoutData.shipping || 0;

	document.getElementById('displaySubtotal').textContent = subtotal.toLocaleString() + ' 원';
	document.getElementById('subtotalAmount').value = subtotal;
	document.getElementById('shippingAmount').value = shipping;
	calculateTotal();
}

// 총 금액 계산
function calculateTotal() {
	const subtotal = parseFloat(document.getElementById('subtotalAmount').value) || 0;
	const couponDiscount = getCouponDiscountValue();
	const pointDiscount = parseInt(document.querySelector('input[name="usingPoint"]').value) || 0;
	const shipping = parseFloat(document.getElementById('shippingAmount').value) || 0;
	const total = subtotal - couponDiscount - pointDiscount + shipping;

	document.getElementById('displayTotal').textContent = total.toLocaleString() + ' 원';
	document.getElementById('totalAmount').value = total;
	document.getElementById('discountAmount').value = couponDiscount + pointDiscount;

	const earnPoint = Math.floor(total * 0.01);
	document.getElementById('pointEarn').textContent = earnPoint.toLocaleString() + ' 원';
}

// 쿠폰 할인 금액
function getCouponDiscountValue() {
	const couponSelect = document.querySelector('select[name="usingCoupon"]');

	if (!couponSelect.value) {
		return 0;
	}

	const selectedOption = couponSelect.options[couponSelect.selectedIndex];
	return parseInt(selectedOption.getAttribute('data-amount')) || 0;
}

// 주문 데이터를 서버 세션에 저장
function saveOrderDataToSession() {
	console.log('주문 데이터를 세션에 저장 시작');

	const phone1 = document.getElementById('shipPhone1').value.trim();
	const phone2 = document.getElementById('shipPhone2').value.trim();
	const phone3 = document.getElementById('shipPhone3').value.trim();
	const fullPhone = phone1 + '-' + phone2 + '-' + phone3;

	const params = new URLSearchParams();

	params.append('shipRecipient', document.getElementById('shipRecipient').value.trim());
	params.append('shipPhone', fullPhone);
	params.append('shipPostcode', document.getElementById('shipPostcode').value.trim());
	params.append('shipLine1', document.getElementById('shipLine1').value.trim());
	params.append('shipLine2', document.getElementById('shipLine2').value.trim());
	params.append('note', document.getElementById('note').value.trim());

	const productIdInput = document.querySelector('input[name="productId"]');
	const brandIdInput = document.querySelector('input[name="brandId"]');

	params.append('productId', productIdInput.value);
	params.append('brandId', brandIdInput.value);

	const optionIdInputs = document.querySelectorAll('input[name^="items["][name$="].optionId"]');
	const quantityInputs = document.querySelectorAll('input[name^="items["][name$="].quantity"]');
	const unitPriceInputs = document.querySelectorAll('input[name^="items["][name$="].unitPrice"]');

	for (let i = 0; i < optionIdInputs.length; i++) {
		params.append('items[' + i + '].optionId', optionIdInputs[i].value);
		params.append('items[' + i + '].quantity', quantityInputs[i].value);
		params.append('items[' + i + '].unitPrice', unitPriceInputs[i].value);
	}

	params.append('subtotalAmount', document.getElementById('subtotalAmount').value);
	params.append('discountAmount', document.getElementById('discountAmount').value);
	params.append('shippingAmount', document.getElementById('shippingAmount').value);
	params.append('totalAmount', document.getElementById('totalAmount').value);

	params.append('usingCoupon', document.querySelector('select[name="usingCoupon"]').value);
	params.append('usingPoint', document.querySelector('input[name="usingPoint"]').value);

	fetch('/store/checkout', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/x-www-form-urlencoded'
		},
		body: params
	})
		.then(function(response) {
			return response.text();
		})
		.then(function(data) {
			console.log('서버 응답:', data);
			if (data.startsWith('SUCCESS:')) {
				const orderId = data.split(':')[1];
				processPayment(orderId);
			} else {
				alert('주문 정보 저장에 실패했습니다: ' + data);
			}
		})
		.catch(function(error) {
			console.error('에러 발생:', error);
			alert('주문 처리 중 오류가 발생했습니다.');
		});
}

// 결제 처리 (v1 방식)
function processPayment(temporaryOrderId) {
	console.log('토스 결제 시작, orderId:', temporaryOrderId);

	const clientKey = 'test_ck_Poxy1XQL8RYP2bdMOjGXr7nO5Wml';
	const tossPayments = TossPayments(clientKey);

	const orderId = temporaryOrderId || ('ORDER_' + new Date().getTime());
	const totalAmount = parseInt(document.getElementById('totalAmount').value);

	const productNameElement = document.querySelector('.product-name');
	const productName = productNameElement ? productNameElement.textContent.trim() : '상품';

	const customerName = document.getElementById('shipRecipient').value.trim();

	console.log('결제 정보:', {
		orderId: orderId,
		amount: totalAmount,
		productName: productName,
		customerName: customerName
	});

	// v1 방식으로 결제 요청
	tossPayments.requestPayment('카드', {
		amount: totalAmount,
		orderId: orderId,
		orderName: productName,
		customerName: customerName,
		successUrl: window.location.origin + '/store/tossSuccess',
		failUrl: window.location.href + (window.location.href.includes('?') ? '&' : '?') + 'paymentFailed=true'
	}).catch(function(error) {
		console.error('토스 결제 오류:', error);
		if (error.code === 'USER_CANCEL') {
			alert('결제가 취소되었습니다.');
		} else {
			alert('결제 처리 중 오류가 발생했습니다: ' + (error.message || ''));
		}
	});
}