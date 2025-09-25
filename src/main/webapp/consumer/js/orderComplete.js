// 주문완료 페이지 JavaScript

// 페이지 로드 시 실행
document.addEventListener('DOMContentLoaded', function() {
    initOrderComplete();
    
    // 주문번호 복사 기능 추가
    addOrderNumberCopyFeature();
    
    // 브라우저 뒤로가기 방지 (주문 완료 후)
    preventBackNavigation();
    
    // 주문 완료 알림 (선택사항)
    showCompletionNotification();
});

// 주문완료 페이지 초기화
function initOrderComplete() {
    // URL에서 주문번호 파라미터 확인
    const urlParams = new URLSearchParams(window.location.search);
    const orderNumber = urlParams.get('orderNumber');
    
    if (orderNumber) {
        // URL에서 받은 주문번호로 업데이트
        const orderNumberElement = document.querySelector('.order-number');
        if (orderNumberElement) {
            orderNumberElement.textContent = orderNumber;
        }
    }
    
    // 주문 정보를 로컬스토리지에서 제거 (보안상)
    localStorage.removeItem('orderData');
    localStorage.removeItem('cartItems');
    
    console.log('Order completion page initialized');
}

// 주문번호 복사 기능 추가
function addOrderNumberCopyFeature() {
    const orderNumberElement = document.querySelector('.order-number');
    
    if (orderNumberElement) {
        // 클릭 이벤트 추가
        orderNumberElement.addEventListener('click', function() {
            copyOrderNumber(this.textContent);
        });
        
        // 복사 가능함을 나타내는 스타일 추가
        orderNumberElement.style.cursor = 'pointer';
        orderNumberElement.title = '클릭하여 주문번호 복사';
    }
}

// 주문번호 복사
function copyOrderNumber(orderNumber) {
    if (navigator.clipboard && window.isSecureContext) {
        // Clipboard API 사용 (HTTPS 환경)
        navigator.clipboard.writeText(orderNumber).then(function() {
            showCopyNotification('주문번호가 복사되었습니다.');
        }).catch(function(err) {
            console.error('복사 실패:', err);
            fallbackCopyMethod(orderNumber);
        });
    } else {
        // 폴백 방법 (HTTP 환경)
        fallbackCopyMethod(orderNumber);
    }
}

// 폴백 복사 방법
function fallbackCopyMethod(text) {
    const textArea = document.createElement('textarea');
    textArea.value = text;
    textArea.style.position = 'fixed';
    textArea.style.left = '-999999px';
    textArea.style.top = '-999999px';
    document.body.appendChild(textArea);
    textArea.focus();
    textArea.select();
    
    try {
        document.execCommand('copy');
        showCopyNotification('주문번호가 복사되었습니다.');
    } catch (err) {
        console.error('복사 실패:', err);
        showCopyNotification('복사에 실패했습니다. 주문번호를 직접 선택해주세요.');
    }
    
    document.body.removeChild(textArea);
}

// 복사 완료 알림
function showCopyNotification(message) {
    // 기존 알림이 있으면 제거
    const existingNotification = document.querySelector('.copy-notification');
    if (existingNotification) {
        existingNotification.remove();
    }
    
    // 새 알림 생성
    const notification = document.createElement('div');
    notification.className = 'copy-notification';
    notification.textContent = message;
    notification.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        background-color: #333;
        color: white;
        padding: 12px 20px;
        border-radius: 4px;
        font-size: 14px;
        z-index: 9999;
        opacity: 0;
        transition: opacity 0.3s ease;
    `;
    
    document.body.appendChild(notification);
    
    // 애니메이션으로 표시
    setTimeout(() => {
        notification.style.opacity = '1';
    }, 100);
    
    // 3초 후 제거
    setTimeout(() => {
        notification.style.opacity = '0';
        setTimeout(() => {
            if (notification.parentNode) {
                notification.parentNode.removeChild(notification);
            }
        }, 300);
    }, 3000);
}

// 브라우저 뒤로가기 방지
function preventBackNavigation() {
    // 히스토리에 현재 페이지를 추가하여 뒤로가기 방지
    history.pushState(null, null, location.href);
    
    window.addEventListener('popstate', function(event) {
        // 뒤로가기 시 확인 메시지
        const confirmed = confirm('주문이 완료되었습니다. 정말 이 페이지를 나가시겠습니까?');
        if (!confirmed) {
            history.pushState(null, null, location.href);
        }
    });
}

// 주문 완료 알림 (선택사항)
function showCompletionNotification() {
    // 페이지 로드 후 약간의 딜레이를 두고 알림 표시
    setTimeout(() => {
        // 브라우저 알림 권한 확인
        if ('Notification' in window && Notification.permission === 'granted') {
            new Notification('AD 쇼핑몰', {
                body: '주문이 성공적으로 완료되었습니다!',
                icon: '/resources/images/favicon.ico' // 실제 아이콘 경로로 변경
            });
        } else if ('Notification' in window && Notification.permission !== 'denied') {
            // 알림 권한 요청
            Notification.requestPermission().then(function(permission) {
                if (permission === 'granted') {
                    new Notification('AD 쇼핑몰', {
                        body: '주문이 성공적으로 완료되었습니다!',
                        icon: '/resources/images/favicon.ico'
                    });
                }
            });
        }
    }, 1000);
}

// 주문내역 확인 버튼 클릭 추적 (분석용)
function trackOrderHistoryClick() {
    // 구글 애널리틱스나 기타 분석 도구 연동
    if (typeof gtag !== 'undefined') {
        gtag('event', 'click', {
            event_category: 'Order Complete',
            event_label: 'View Order History'
        });
    }
    
    console.log('Order history button clicked');
}

// 쇼핑 계속하기 버튼 클릭 추적 (분석용)
function trackContinueShoppingClick() {
    // 구글 애널리틱스나 기타 분석 도구 연동
    if (typeof gtag !== 'undefined') {
        gtag('event', 'click', {
            event_category: 'Order Complete',
            event_label: 'Continue Shopping'
        });
    }
    
    console.log('Continue shopping button clicked');
}

// 버튼 클릭 이벤트 추가
document.addEventListener('DOMContentLoaded', function() {
    const orderHistoryBtn = document.querySelector('.btn-secondary');
    const continueShoppingBtn = document.querySelector('.btn-primary');
    
    if (orderHistoryBtn) {
        orderHistoryBtn.addEventListener('click', trackOrderHistoryClick);
    }
    
    if (continueShoppingBtn) {
        continueShoppingBtn.addEventListener('click', trackContinueShoppingClick);
    }
});

// 페이지 이탈 시 정리 작업
window.addEventListener('beforeunload', function() {
    // 필요한 정리 작업 수행
    console.log('Order complete page unloading');
});