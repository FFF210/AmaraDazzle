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

	// ✅ 커스텀 셀렉트박스 이벤트 처리
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
	if (typeof window.productOptionsData !== 'undefined') {
		// 가격 정보에서 옵션 찾기 (예: "옵션명 (10000원)" -> 옵션명과 가격)
		const priceMatch = text.match(/\((\d+)원\)/);
		if (priceMatch) {
			const price = parseInt(priceMatch[1]);
			const optionName = text.replace(/\s*\(\d+원\)/, '').trim();

			console.log('추출된 price:', price);
			console.log('추출된 optionName:', optionName);
			console.log('전체 productOptionsData:', window.productOptionsData);

			// productOptionsData에서 해당 옵션 찾기
			const optionData = window.productOptionsData.find(opt => {
				console.log('비교중:', opt.price, '===', price, '그리고', opt.value, '===', optionName);
				return opt.price == price && opt.value === optionName;  // == 사용 (타입 변환)
			});

			console.log('찾은 optionData:', optionData);

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

	// UI에 추가 - tag와 유사한 구조로 생성됨
	const selectedOptionsContainer = document.getElementById('selectedOptions');
	const optionDiv = document.createElement('div');
	optionDiv.className = 'product-item';
	optionDiv.setAttribute('data-option-id', optionData.id);

	optionDiv.innerHTML = `
        <div class="product-name">${optionData.value}</div>
        <div class="item-info">
            <div class="quantity-control">
                <button type="button" class="btn-decrease" data-id="${optionData.id}">
                    <i class="bi bi-dash"></i>
                </button>
                <input type="text" class="quantity-input" value="1" readonly data-id="${optionData.id}" />
                <button type="button" class="btn-increase" data-id="${optionData.id}">
                    <i class="bi bi-plus"></i>
                </button>
            </div>
            <div class="product-price">
                <span class="price-value" data-id="${optionData.id}">${optionData.price.toLocaleString()}원</span>
                <button type="button" class="btn-remove" data-id="${optionData.id}">
                    <i class="bi bi-x"></i>
                </button>
            </div>
        </div>
    `;

	selectedOptionsContainer.appendChild(optionDiv);

	// 이벤트 리스너 추가 (새로 생성된 요소에만)
	attachOptionItemEvents(optionDiv, optionData.id);

	// 총 가격 업데이트
	updateTotalPrice();
}

// 옵션 아이템에 이벤트 연결
function attachOptionItemEvents(itemElement, optionId) {
	// 수량 증가
	const increaseBtn = itemElement.querySelector('.btn-increase');
	increaseBtn.addEventListener('click', function() {
		changeQuantityById(optionId, 1);
	});

	// 수량 감소
	const decreaseBtn = itemElement.querySelector('.btn-decrease');
	decreaseBtn.addEventListener('click', function() {
		changeQuantityById(optionId, -1);
	});

	// 삭제
	const removeBtn = itemElement.querySelector('.btn-remove');
	removeBtn.addEventListener('click', function() {
		removeOptionById(optionId);
	});
}

// ID로 수량 변경
function changeQuantityById(optionId, change) {
	const option = selectedOptions.find(opt => opt.id === optionId);
	if (option) {
		const newQuantity = option.quantity + change;
		if (newQuantity > 0 && newQuantity <= option.stock) {
			option.quantity = newQuantity;

			// 수량 표시 업데이트
			const quantityInput = document.querySelector(`input.quantity-input[data-id="${optionId}"]`);
			if (quantityInput) {
				quantityInput.value = newQuantity;
			}

			// 개별 가격 표시 업데이트
			const priceDisplay = document.querySelector(`.price-value[data-id="${optionId}"]`);
			if (priceDisplay) {
				const itemTotal = option.price * newQuantity;
				priceDisplay.textContent = itemTotal.toLocaleString() + '원';
			}

			updateTotalPrice();
		} else if (newQuantity > option.stock) {
			alert(`재고가 부족합니다. (재고: ${option.stock}개)`);
		} else if (newQuantity <= 0) {
			alert('수량은 1개 이상이어야 합니다.');
		}
	}
}

// ID로 옵션 제거
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

function updateTotalPrice() {
	console.log('updateTotalPrice 호출됨');
	console.log('selectedOptions:', selectedOptions);

	if (selectedOptions.length === 0) {
		const totalAmountElement = document.getElementById('totalAmount');
		console.log('totalAmountElement 찾음:', totalAmountElement);
		if (typeof window.productOptionsData !== 'undefined') {
			totalAmountElement.textContent = '옵션을 선택해주세요';
		}
		return;
	}

	totalPrice = selectedOptions.reduce((total, option) => {
		return total + (option.price * option.quantity);
	}, 0);

	console.log('계산된 totalPrice:', totalPrice);

	const totalAmountElement = document.getElementById('totalAmount');
	console.log('totalAmountElement 찾음:', totalAmountElement);
	if (totalAmountElement) {
		totalAmountElement.textContent = totalPrice.toLocaleString() + '원';
		console.log('가격 업데이트 완료:', totalAmountElement.textContent);
	} else {
		console.log('totalAmountElement를 찾을 수 없습니다!');
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
	if (typeof window.productOptionsData !== 'undefined') {
		// 옵션 상품 - 선택된 옵션이 있는지 확인
		if (selectedOptions.length === 0) {
			alert('옵션을 선택해주세요.');
			return;
		}

		// 각 선택된 옵션별로 장바구니 추가
		let completedRequests = 0;
		const totalRequests = selectedOptions.length;

		selectedOptions.forEach(option => {
			addToCartRequest(option.id, option.quantity, () => {
				completedRequests++;
				if (completedRequests === totalRequests) {
					// 모든 요청 완료 시 확인 팝업
					if (confirm('장바구니에 담았습니다. 장바구니로 이동하시겠습니까?')) {
						location.href = '/store/mypage/cart';
					}
				}
			});
		});
	} else {
		// 단일 상품
		const quantity = 1;
		addToCartRequest(null, quantity, () => {
			if (confirm('장바구니에 담았습니다. 장바구니로 이동하시겠습니까?')) {
				location.href = '/store/mypage/cart';
			}
		});
	}
}

function addToCartRequest(optionId, quantity, callback) {
	const params = new URLSearchParams();
	params.append('brandId', window.productBrandId);
	params.append('productId', window.productId);
	params.append('quantity', quantity);
	if (optionId) {
		params.append('optionId', optionId);
	}

	fetch('/store/addToCart', {
		method: 'POST',
		headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
		body: params.toString()
	})

		.then(response => response.json())// JSON 파싱 먼저!
		.then(data => {
			console.log('서버 응답:', data);  // 디버깅용

			if (data.success) {
				// 진짜 성공했을 때
				callback();
			} else {
				// 실패했을 때
				if (data.needLogin) {
					alert(data.message);
					location.href = '/store/login';
				} else {
					alert(data.message || '장바구니 담기에 실패했습니다.');
				}
			}
		})
		.catch(error => {
			console.error('Error:', error);
			alert('오류가 발생했습니다.');
		});
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
	// ✅ 디버깅
	console.log('productOptionsData:', typeof window.productOptionsData !== 'undefined' ? productOptionsData : 'undefined');
	console.log('selectedOptions:', selectedOptions);
	console.log('productId:', window.productId);
	console.log('productBrandId:', window.productBrandId);

	// 옵션이 있는 상품인지 확인
	if (typeof window.productOptionsData !== 'undefined') {
		if (selectedOptions.length === 0) {
			alert('옵션을 선택해주세요.');
			return;
		}
	}
	// GET 방식으로 URL 파라미터 생성
	const params = new URLSearchParams();
	params.append('productId', window.productId);
	params.append('brandId', window.productBrandId);

	if (typeof window.productOptionsData !== 'undefined' && selectedOptions.length > 0) {
		// 여러 옵션 모두 URL 파라미터로 추가
		selectedOptions.forEach((option, index) => {
			params.append(`items[${index}].optionId`, option.id);
			params.append(`items[${index}].quantity`, option.quantity);
		});
	} else {
		// 단일 상품
		params.append('quantity', 1);
	}

	// GET 요청으로 이동
	location.href = '/store/checkout?' + params.toString();
}

// 상품 상세설명 더보기/접기=========================================
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

// 리뷰 정렬 기능========================================
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
