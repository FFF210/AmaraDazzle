// 상품 상세 페이지 JavaScript
// 전역 변수
let selectedOptions = [];
let totalPrice = 0;

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

    // ✅ 커스텀 셀렉트박스 이벤트 처리 추가
    initCustomSelectbox();
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

// ✅ 커스텀 셀렉트박스 이벤트 처리
function initCustomSelectbox() {
    // 셀렉트 헤더 클릭 시 리스트 토글
    document.addEventListener('click', function(e) {
        if (e.target.closest('.select-header')) {
            const customSelect = e.target.closest('.custom-select');
            const selectList = customSelect.querySelector('.select-list');

            // 다른 열린 셀렉트박스들 닫기
            document.querySelectorAll('.custom-select .select-list').forEach(list => {
                if (list !== selectList) {
                    list.style.display = 'none';
                }
            });

            // 현재 셀렉트박스 토글
            selectList.style.display = selectList.style.display === 'block' ? 'none' : 'block';
        }

        // 셀렉트 아이템 클릭 시
        if (e.target.classList.contains('select-item')) {
            const customSelect = e.target.closest('.custom-select');
            const selectLabel = customSelect.querySelector('.select-label');
            const selectList = customSelect.querySelector('.select-list');

            // 선택된 값 업데이트
            selectLabel.textContent = e.target.textContent;
            selectList.style.display = 'none';

            // 활성 상태 업데이트
            customSelect.querySelectorAll('.select-item').forEach(item => {
                item.classList.remove('active');
            });
            e.target.classList.add('active');

            // ✅ 옵션 선택 처리
            handleOptionSelection(e.target.dataset.value, e.target.textContent);
        }

        // 외부 클릭 시 셀렉트박스 닫기
        if (!e.target.closest('.custom-select')) {
            document.querySelectorAll('.custom-select .select-list').forEach(list => {
                list.style.display = 'none';
            });
        }
    });
}

// 옵션 선택 처리
function handleOptionSelection(value, text) {
    console.log('선택된 옵션:', value, text);

    // "상품을 선택해주세요" 같은 기본값은 무시
    if (text.includes('선택해주세요') || text.includes('단일 상품')) {
        return;
    }

    // 옵션이 있는 상품인지 확인
    if (typeof productOptionsData !== 'undefined') {
        // 가격 정보에서 옵션 찾기 (예: "옵션명 (10000원)" -> 옵션명과 가격)
        const priceMatch = text.match(/\((\d+)원\)/);
        if (priceMatch) {
            const price = parseInt(priceMatch[1]);
            const optionName = text.replace(/\s*\(\d+원\)/, '').trim();

            // productOptionsData에서 해당 옵션 찾기
            const optionData = productOptionsData.find(opt =>
                opt.price === price && opt.value === optionName
            );

            if (optionData) {
                addSelectedOptionData(optionData);
            } else {
                console.log('옵션 데이터를 찾을 수 없습니다:', optionName, price);
            }
        }
    } else {
        // 단일 상품 처리
        console.log('단일 상품 선택됨');
    }
}

// 옵션 데이터로 선택 추가
function addSelectedOptionData(optionData) {
    // 중복 체크
    const existingOption = selectedOptions.find(opt => opt.id === optionData.id);
    if (existingOption) {
        alert('이미 선택된 옵션입니다.');
        return;
    }

    // selectedOptions 배열에 추가
    selectedOptions.push({
        id: optionData.id,
        value: optionData.value,
        price: optionData.price,
        stock: optionData.stock,
        quantity: 1
    });

    // UI에 추가
    const selectedOptionsContainer = document.getElementById('selectedOptions');
    const optionDiv = document.createElement('div');
    optionDiv.className = 'selected-option-item';
    optionDiv.setAttribute('data-option-id', optionData.id);
    optionDiv.innerHTML = `
        <p>선택된 옵션: ${optionData.value}</p>
        <p>가격: ${optionData.price.toLocaleString()}원</p>
        <p>수량: 
            <button onclick="changeQuantityById(${optionData.id}, -1)">-</button> 
            <span id="qty-${optionData.id}">1</span> 
            <button onclick="changeQuantityById(${optionData.id}, 1)">+</button>
        </p>
        <button onclick="removeOptionById(${optionData.id})">삭제</button>
    `;
    selectedOptionsContainer.appendChild(optionDiv);

    // 총 가격 업데이트
    updateTotalPrice();
}

// ID로 수량 변경 (새로운 방식용)
function changeQuantityById(optionId, change) {
    const option = selectedOptions.find(opt => opt.id === optionId);
    if (option) {
        const newQuantity = option.quantity + change;
        if (newQuantity > 0 && newQuantity <= option.stock) {
            option.quantity = newQuantity;
            document.getElementById(`qty-${optionId}`).textContent = newQuantity;
            updateTotalPrice();
        } else if (newQuantity > option.stock) {
            alert(`재고가 부족합니다. (재고: ${option.stock}개)`);
        }
    }
}

// ID로 옵션 제거 (새로운 방식용)
function removeOptionById(optionId) {
    // 배열에서 제거
    selectedOptions = selectedOptions.filter(opt => opt.id !== optionId);

    // UI에서 제거
    const optionElement = document.querySelector(`[data-option-id="${optionId}"]`);
    if (optionElement) {
        optionElement.remove();
    }

    updateTotalPrice();
}

// 수량 변경 (기존 방식용)
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

// 옵션 제거 (기존 방식용)
function removeOption(button) {
    const optionItem = button.closest('.selected-option-item');
    const optionId = parseInt(optionItem.getAttribute('data-option-id'));

    // selectedOptions 배열에서도 제거
    if (optionId) {
        selectedOptions = selectedOptions.filter(opt => opt.id !== optionId);
    }

    optionItem.remove();
    // 총 가격 업데이트
    updateTotalPrice();
}

// 총 가격 업데이트
function updateTotalPrice() {
    if (selectedOptions.length === 0) {
        // 선택된 옵션이 없을 때
        const totalAmountElement = document.getElementById('totalAmount');
        if (typeof productOptionsData !== 'undefined') {
            // 옵션이 있는 상품
            totalAmountElement.textContent = '옵션을 선택해주세요';
        } else {
            // 단일 상품 - 기본 가격 유지
        }
        return;
    }

    totalPrice = selectedOptions.reduce((total, option) => {
        return total + (option.price * option.quantity);
    }, 0);

    const totalAmountElement = document.getElementById('totalAmount');
    if (totalAmountElement) {
        totalAmountElement.textContent = totalPrice.toLocaleString() + '원';
    }
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
    // 옵션이 있는 상품인지 확인
    if (typeof productOptionsData !== 'undefined') {
        // 옵션 상품 - 선택된 옵션이 있는지 확인
        if (selectedOptions.length === 0) {
            alert('옵션을 선택해주세요.');
            return;
        }

        // 각 선택된 옵션별로 장바구니 추가
        selectedOptions.forEach(option => {
            addToCartRequest(option.id, option.quantity);
        });
    } else {
        // 단일 상품 - 수량 확인 (기본 1개)
        const quantity = 1; // 또는 수량 입력창에서 가져오기
        addToCartRequest(null, quantity);
    }
}

function addToCartRequest(optionId, quantity) {
    const form = document.createElement('form');
    form.method = 'POST';
    form.action = '/cart/add';

    // 상품 정보 추가
    form.appendChild(createHiddenInput('brandId', productBrandId));
    form.appendChild(createHiddenInput('productId', productId));
    form.appendChild(createHiddenInput('quantity', quantity));

    if (optionId) {
        form.appendChild(createHiddenInput('optionId', optionId));
    }

    document.body.appendChild(form);
    form.submit();
}

function createHiddenInput(name, value) {
    const input = document.createElement('input');
    input.type = 'hidden';
    input.name = name;
    input.value = value;
    return input;
}

// 바로 구매
function buyNow() {
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

// 리뷰 정렬 기능
document.addEventListener("sortSelected", (e) => {
    console.log("선택한 정렬:", e.detail.sort);

    const sortType = e.detail.sort;
    const reviewWrapper = document.querySelector('.review-card-wrapper');

    if (!reviewWrapper) return;

    // data-rating 속성이 있는 div들을 선택 (실제 리뷰 카드 컨테이너)
    const reviewCards = Array.from(reviewWrapper.querySelectorAll('div[data-rating]'));

    if (reviewCards.length === 0) {
        console.log("정렬할 리뷰 카드가 없습니다.");
        return;
    }

    console.log(`${reviewCards.length}개의 리뷰 카드를 정렬합니다.`);

    // 정렬 로직
    let sortedCards;

    switch (sortType) {
        case "별점 높은순":
            sortedCards = sortReviewsByRating(reviewCards, 'desc');
            break;
        case "별점 낮은순":
            sortedCards = sortReviewsByRating(reviewCards, 'asc');
            break;
        case "최신순":
            sortedCards = sortReviewsByDate(reviewCards, 'desc');
            break;
        default:
            console.log("알 수 없는 정렬 타입:", sortType);
            return;
    }

    // DOM 재정렬
    reviewWrapper.innerHTML = '';
    sortedCards.forEach(card => reviewWrapper.appendChild(card));

    console.log("리뷰 정렬 완료");
});

function sortReviewsByRating(cards, order) {
    return cards.sort((a, b) => {
        const ratingA = parseInt(a.getAttribute('data-rating') || '0');
        const ratingB = parseInt(b.getAttribute('data-rating') || '0');

        if (order === 'desc') {
            return ratingB - ratingA;
        } else {
            return ratingA - ratingB;
        }
    });
}

function sortReviewsByDate(cards, order) {
    return cards.sort((a, b) => {
        const dateA = new Date(a.getAttribute('data-date') || '0');
        const dateB = new Date(b.getAttribute('data-date') || '0');

        if (order === 'desc') {
            return dateB - dateA;
        } else {
            return dateA - dateB;
        }
    });
}