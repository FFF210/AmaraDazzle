// 주문결제 페이지 JavaScript

// 토스페이먼츠 초기화
const clientKey = 'YOUR_TOSS_PAYMENTS_CLIENT_KEY'; // 실제 클라이언트 키로 교체
const tossPayments = TossPayments(clientKey);

// 페이지 로드 시 초기화
document.addEventListener('DOMContentLoaded', function() {
    initCheckout();
    initStickyPaymentSummary();
});

// 체크아웃 기능 초기화
function initCheckout() {
    // 배송지 선택 변경 이벤트
    const shippingType = document.getElementById('shippingType');
    shippingType.addEventListener('change', handleShippingTypeChange);
    
    // 쿠폰 선택 변경 이벤트
    const couponSelect = document.getElementById('coupon');
    couponSelect.addEventListener('change', handleCouponChange);
    
    // 포인트 입력 이벤트
    const pointInput = document.getElementById('point');
    pointInput.addEventListener('input', handlePointChange);
    
    // 전체 동의 체크박스
    const agreeAll = document.getElementById('agreeAll');
    agreeAll.addEventListener('change', toggleFinalPaymentButton);
    
    // 전화번호 입력 제한 (숫자만)
    const phoneInputs = document.querySelectorAll('.phone-input');
    phoneInputs.forEach(input => {
        input.addEventListener('input', function(e) {
            e.target.value = e.target.value.replace(/[^0-9]/g, '');
        });
    });
    
    // 포인트 입력 제한
    pointInput.addEventListener('input', function(e) {
        const maxPoint = 200; // 보유 포인트
        if (parseInt(e.target.value) > maxPoint) {
            e.target.value = maxPoint;
        }
        if (parseInt(e.target.value) < 0) {
            e.target.value = 0;
        }
    });
}

// Sticky 결제 요약 박스 초기화 (문제 해결된 버전)
function initStickyPaymentSummary() {
    // CSS sticky를 사용하므로 JavaScript 처리 불필요
    // 원래 JavaScript 코드가 문제를 일으켰을 수 있음
    
    // 스크롤 이벤트는 제거하고 CSS sticky만 사용
    console.log('Sticky payment summary initialized with CSS only');
}

// 배송지 타입 변경 처리
function handleShippingTypeChange(e) {
    const shippingType = e.target.value;
    const recipientName = document.getElementById('recipientName');
    
    switch(shippingType) {
        case 'home':
            recipientName.value = '집';
            loadSavedAddress('home');
            break;
        case 'company':
            recipientName.value = '회사';
            loadSavedAddress('company');
            break;
        case 'new':
            recipientName.value = '';
            clearAddressFields();
            break;
    }
}

// 저장된 주소 불러오기
function loadSavedAddress(type) {
    // 실제로는 서버에서 저장된 주소 정보를 가져와야 함
    const addresses = {
        'home': {
            postcode: '12345',
            address: '서울특별시 강남구 테헤란로 123',
            detailAddress: '4층 401호'
        },
        'company': {
            postcode: '54321',
            address: '서울특별시 서초구 서초대로 456',
            detailAddress: '10층 1001호'
        }
    };
    
    const savedAddress = addresses[type];
    if (savedAddress) {
        document.getElementById('postcode').value = savedAddress.postcode;
        document.getElementById('address').value = savedAddress.address;
        document.getElementById('detailAddress').value = savedAddress.detailAddress;
    }
}

// 주소 필드 초기화
function clearAddressFields() {
    document.getElementById('postcode').value = '';
    document.getElementById('address').value = '';
    document.getElementById('detailAddress').value = '';
}

// 우편번호 찾기 (카카오 우편번호 서비스)
function findPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById('address').value = data.address;
            document.getElementById('detailAddress').focus();
        }
    }).open();
}

// 쿠폰 변경 처리
function handleCouponChange(e) {
    const selectedCoupon = e.target.value;
    let discountAmount = 0;
    
    switch(selectedCoupon) {
        case 'coupon1':
            discountAmount = 2020; // 10% 할인 (20,200원의 10%)
            break;
        case 'coupon2':
            discountAmount = 5000; // 5,000원 할인
            break;
        default:
            discountAmount = 0;
    }
    
    updateDiscountAmount(discountAmount);
    updateFinalAmount();
}

// 포인트 변경 처리
function handlePointChange(e) {
    const pointAmount = parseInt(e.target.value) || 0;
    updatePointAmount(pointAmount);
    updateFinalAmount();
}

// 할인 금액 업데이트
function updateDiscountAmount(amount) {
    const discountElement = document.querySelector('.summary-row:nth-child(2) .summary-value');
    discountElement.textContent = amount > 0 ? `-${amount.toLocaleString()}원` : '0원';
}

// 최종 금액 업데이트
function updateFinalAmount() {
    const originalAmount = 20200; // 원래 상품 금액
    const shippingFee = 2500; // 배송비
    
    // 할인 금액 계산
    const discountText = document.querySelector('.summary-row:nth-child(2) .summary-value').textContent;
    const discountAmount = parseInt(discountText.replace(/[^0-9]/g, '')) || 0;
    
    // 포인트 사용 금액 계산
    const pointText = document.querySelector('.summary-row:nth-child(3) .summary-value').textContent;
    const pointAmount = parseInt(pointText.replace(/[^0-9]/g, '')) || 0;
    
    // 최종 금액 계산
    const finalAmount = originalAmount - discountAmount - pointAmount + shippingFee;
    
    // 화면에 반영
    const finalAmountElement = document.querySelector('.final-amount');
    finalAmountElement.textContent = `${finalAmount.toLocaleString()}원`;
}

// 결제 버튼 활성화/비활성화
function toggleFinalPaymentButton() {
    const agreeAll = document.getElementById('agreeAll');
    const paymentBtn = document.querySelector('.final-payment-btn');
    
    if (agreeAll.checked) {
        paymentBtn.disabled = false;
        paymentBtn.textContent = '결제하기';
    } else {
        paymentBtn.disabled = true;
        paymentBtn.textContent = '약관에 동의해주세요';
    }
}

// 결제 처리
function processPayment() {
    // 필수 입력 사항 검증
    if (!validateRequiredFields()) {
        return;
    }
    
    // 약관 동의 확인
    const agreeAll = document.getElementById('agreeAll');
    if (!agreeAll.checked) {
        alert('약관에 동의해주세요.');
        return;
    }
    
    // 결제 정보 수집
    const paymentData = collectPaymentData();
    
    // 토스페이먼츠 결제 요청
    requestTossPayment(paymentData);
}

// 필수 입력 사항 검증
function validateRequiredFields() {
    const requiredFields = [
        { id: 'recipientName', name: '배송지명' },
        { id: 'postcode', name: '우편번호' },
        { id: 'address', name: '주소' },
        { id: 'detailAddress', name: '상세주소' }
    ];
    
    for (let field of requiredFields) {
        const element = document.getElementById(field.id);
        if (!element.value.trim()) {
            alert(`${field.name}을(를) 입력해주세요.`);
            element.focus();
            return false;
        }
    }
    
    // 전화번호 검증
    const phoneInputs = document.querySelectorAll('.phone-input');
    let hasValidPhone = false;
    
    // 첫 번째 전화번호 그룹 확인
    const firstPhoneGroup = document.querySelectorAll('.phone-group')[0];
    const firstPhoneInputs = firstPhoneGroup.querySelectorAll('.phone-input');
    if (firstPhoneInputs[0].value.trim() && firstPhoneInputs[1].value.trim()) {
        hasValidPhone = true;
    }
    
    if (!hasValidPhone) {
        alert('연락처를 입력해주세요.');
        firstPhoneInputs[0].focus();
        return false;
    }
    
    return true;
}

// 결제 데이터 수집
function collectPaymentData() {
    // 최종 금액 계산
    const finalAmountText = document.querySelector('.final-amount').textContent;
    const amount = parseInt(finalAmountText.replace(/[^0-9]/g, ''));
    
    // 주문 고유 번호 생성
    const orderId = 'ORDER_' + new Date().getTime();
    
    // 배송지 정보
    const shippingInfo = {
        recipientName: document.getElementById('recipientName').value,
        postcode: document.getElementById('postcode').value,
        address: document.getElementById('address').value,
        detailAddress: document.getElementById('detailAddress').value,
        deliveryMemo: document.getElementById('deliveryMemo').value,
        deliveryRequest: document.getElementById('deliveryRequest').value
    };
    
    // 연락처 정보
    const phoneGroups = document.querySelectorAll('.phone-group');
    const phone1 = phoneGroups[0];
    const phone1Select = phone1.querySelector('.phone-select').value;
    const phone1Inputs = phone1.querySelectorAll('.phone-input');
    const phoneNumber1 = `${phone1Select}-${phone1Inputs[0].value}-${phone1Inputs[1].value}`;
    
    let phoneNumber2 = '';
    if (phoneGroups[1]) {
        const phone2 = phoneGroups[1];
        const phone2Select = phone2.querySelector('.phone-select').value;
        const phone2Inputs = phone2.querySelectorAll('.phone-input');
        if (phone2Inputs[0].value && phone2Inputs[1].value) {
            phoneNumber2 = `${phone2Select}-${phone2Inputs[0].value}-${phone2Inputs[1].value}`;
        }
    }
    
    return {
        orderId: orderId,
        amount: amount,
        orderName: '화장품 주문', // 실제로는 상품명들을 조합
        customerName: shippingInfo.recipientName,
        customerEmail: 'customer@example.com', // 실제로는 로그인된 사용자 이메일
        customerMobilePhone: phoneNumber1,
        shippingInfo: shippingInfo,
        phoneNumber2: phoneNumber2
    };
}

// 토스페이먼츠 결제 요청
function requestTossPayment(paymentData) {
    tossPayments.requestPayment('카드', {
        amount: paymentData.amount,
        orderId: paymentData.orderId,
        orderName: paymentData.orderName,
        customerName: paymentData.customerName,
        customerEmail: paymentData.customerEmail,
        customerMobilePhone: paymentData.customerMobilePhone,
        successUrl: window.location.origin + '/payment/success',
        failUrl: window.location.origin + '/payment/fail',
    }).catch(function (error) {
        if (error.code === 'USER_CANCEL') {
            alert('결제가 취소되었습니다.');
        } else if (error.code === 'INVALID_CARD_COMPANY') {
            alert('유효하지 않은 카드 정보입니다.');
        } else {
            alert('결제 중 오류가 발생했습니다: ' + error.message);
        }
    });
}

// 유틸리티 함수들
function formatPhoneNumber(phoneNumber) {
    return phoneNumber.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
}

function formatPrice(price) {
    return price.toLocaleString() + '원';
}

// 페이지 이탈 시 경고
window.addEventListener('beforeunload', function(e) {
    const agreeAll = document.getElementById('agreeAll');
    if (agreeAll && agreeAll.checked) {
        e.preventDefault();
        e.returnValue = '결제 진행 중입니다. 페이지를 나가시겠습니까?';
        return e.returnValue;
    }
});

// 개발용 - 폼 자동 채우기 (실제 서비스에서는 제거)
function fillTestData() {
    document.getElementById('recipientName').value = '홍길동';
    document.getElementById('postcode').value = '12345';
    document.getElementById('address').value = '서울특별시 강남구 테헤란로 123';
    document.getElementById('detailAddress').value = '4층 401호';
    
    const phoneInputs = document.querySelectorAll('.phone-input');
    phoneInputs[0].value = '1234';
    phoneInputs[1].value = '5678';
    
    console.log('테스트 데이터가 입력되었습니다.');
}

// 개발 환경에서만 테스트 버튼 추가
if (window.location.hostname === 'localhost') {
    const testButton = document.createElement('button');
    testButton.textContent = '테스트 데이터 입력';
    testButton.style.position = 'fixed';
    testButton.style.top = '10px';
    testButton.style.right = '10px';
    testButton.style.zIndex = '9999';
    testButton.style.padding = '10px';
    testButton.style.backgroundColor = '#ff6b6b';
    testButton.style.color = 'white';
    testButton.style.border = 'none';
    testButton.style.borderRadius = '4px';
    testButton.style.cursor = 'pointer';
    testButton.onclick = fillTestData;
    document.body.appendChild(testButton);
}