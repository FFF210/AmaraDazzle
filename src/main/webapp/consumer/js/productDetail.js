// 상품 상세 페이지 JavaScript

// 페이지 로드 시 초기화
document.addEventListener('DOMContentLoaded', function() {
    initProductDetail();
    initTabContent();
});

// 상품 상세 기능 초기화
function initProductDetail() {
    // 썸네일 이미지 클릭 이벤트
    const thumbnails = document.querySelectorAll('.thumbnail');
    thumbnails.forEach(thumbnail => {
        thumbnail.addEventListener('click', function() {
            changeMainImage(this);
        });
    });
    
    // 옵션 선택 이벤트
    const optionSelects = document.querySelectorAll('.option-select');
    optionSelects.forEach(select => {
        select.addEventListener('change', function() {
            addSelectedOption(this);
        });
    });
}

// 메인 이미지 변경
function changeMainImage(thumbnail) {
    // 활성화된 썸네일 변경
    document.querySelectorAll('.thumbnail').forEach(thumb => {
        thumb.classList.remove('active');
    });
    thumbnail.classList.add('active');
    
    // 메인 이미지 변경
    const mainImage = document.getElementById('mainProductImage');
    mainImage.src = thumbnail.src;
}

// 옵션 추가
function addSelectedOption(selectElement) {
    const selectedValue = selectElement.value;
    const selectedText = selectElement.options[selectElement.selectedIndex].text;
    
    if (!selectedValue) return;
    
    // 이미 선택된 옵션인지 확인
    const existingOptions = document.querySelectorAll('.selected-option-item .option-name');
    for (let option of existingOptions) {
        if (option.textContent === selectedText) {
            alert('이미 선택된 옵션입니다.');
            selectElement.value = '';
            return;
        }
    }
    
    // 새 옵션 아이템 생성
    const selectedOptionsContainer = document.getElementById('selectedOptions');
    const optionItem = createOptionItem(selectedText, 34000); // 임시 가격
    
    selectedOptionsContainer.appendChild(optionItem);
    
    // 선택 초기화
    selectElement.value = '';
    
    // 총 가격 업데이트
    updateTotalPrice();
}

// 옵션 아이템 HTML 생성
function createOptionItem(optionName, price) {
    const div = document.createElement('div');
    div.className = 'selected-option-item';
    
    div.innerHTML = `
        <span class="option-name">${optionName}</span>
        <div class="quantity-price-group">
            <div class="quantity-control">
                <button type="button" class="qty-btn minus" onclick="changeQuantity(this, -1)">-</button>
                <input type="number" class="qty-input" value="1" min="1" readonly>
                <button type="button" class="qty-btn plus" onclick="changeQuantity(this, 1)">+</button>
            </div>
            <span class="item-price" data-unit-price="${price}">${price.toLocaleString()}원</span>
            <button type="button" class="remove-option" onclick="removeOption(this)">×</button>
        </div>
    `;
    
    return div;
}

// 수량 변경
function changeQuantity(button, change) {
    const quantityInput = button.parentElement.querySelector('.qty-input');
    const currentQuantity = parseInt(quantityInput.value);
    const newQuantity = Math.max(1, currentQuantity + change);
    
    quantityInput.value = newQuantity;
    
    // 해당 아이템 가격 업데이트
    const itemPriceElement = button.parentElement.parentElement.querySelector('.item-price');
    const unitPrice = parseInt(itemPriceElement.dataset.unitPrice);
    const totalItemPrice = unitPrice * newQuantity;
    
    itemPriceElement.textContent = totalItemPrice.toLocaleString() + '원';
    
    // 총 가격 업데이트
    updateTotalPrice();
}

// 옵션 제거
function removeOption(button) {
    const optionItem = button.closest('.selected-option-item');
    optionItem.remove();
    
    // 총 가격 업데이트
    updateTotalPrice();
}

// 총 가격 업데이트
function updateTotalPrice() {
    const itemPrices = document.querySelectorAll('.item-price');
    let totalPrice = 0;
    
    itemPrices.forEach(priceElement => {
        const price = parseInt(priceElement.textContent.replace(/[^0-9]/g, ''));
        totalPrice += price;
    });
    
    const totalAmountElement = document.querySelector('.total-amount');
    totalAmountElement.textContent = totalPrice.toLocaleString() + '원';
}

// 탭 내용 초기화
function initTabContent() {
    // 탭 변경 이벤트 리스너
    document.addEventListener('tabChanged', function(e) {
        if (e.detail.tabId === 'productTabs') {
            showTabContent(e.detail.activeTabIndex);
        }
    });
}

// 탭 내용 표시
function showTabContent(tabIndex) {
    // 모든 탭 패널 숨기기
    const tabPanels = document.querySelectorAll('.tab-panel');
    tabPanels.forEach(panel => {
        panel.classList.remove('active');
    });
    
    // 선택된 탭 패널 표시
    const activePanel = document.querySelector(`[data-tab="${tabIndex}"]`);
    if (activePanel) {
        activePanel.classList.add('active');
    }
}

// 위시리스트 추가
function addToWishlist() {
    // 하트 아이콘 변경
    const heartIcon = document.querySelector('.heart-icon');
    if (heartIcon.textContent === '♡') {
        heartIcon.textContent = '♥';
        heartIcon.style.color = '#f31110';
        alert('위시리스트에 추가되었습니다.');
    } else {
        heartIcon.textContent = '♡';
        heartIcon.style.color = '#666';
        alert('위시리스트에서 제거되었습니다.');
    }
}

// 장바구니 추가
function addToCart() {
    const selectedOptions = document.querySelectorAll('.selected-option-item');
    
    if (selectedOptions.length === 0) {
        alert('옵션을 선택해주세요.');
        return;
    }
    
    // 장바구니 추가 로직
    alert('장바구니에 추가되었습니다.');
    
    // 실제로는 서버에 데이터 전송
    // fetch('/cart/add', { method: 'POST', ... })
}

// 바로 구매
function buyNow() {
    const selectedOptions = document.querySelectorAll('.selected-option-item');
    
    if (selectedOptions.length === 0) {
        alert('옵션을 선택해주세요.');
        return;
    }
    
    // 주문 페이지로 이동
    alert('주문 페이지로 이동합니다.');
    
    // 실제로는 주문 페이지로 이동
    // location.href = '/order';
}

// 상품 상세설명 더보기/접기
function toggleDetailImages() {
    const moreImages = document.getElementById('moreImages');
    const toggleBtn = document.getElementById('detailToggleBtn');
    const toggleText = toggleBtn.querySelector('.toggle-text');
    
    if (moreImages.classList.contains('show')) {
        // 접기
        moreImages.classList.remove('show');
        toggleBtn.classList.remove('expanded');
        toggleText.textContent = '상품 설명 더보기';
        
        // 부드러운 스크롤로 버튼 위치로 이동
        toggleBtn.scrollIntoView({ behavior: 'smooth', block: 'center' });
    } else {
        // 더보기
        moreImages.classList.add('show');
        toggleBtn.classList.add('expanded');
        toggleText.textContent = '상품 설명 접기';
    }
}