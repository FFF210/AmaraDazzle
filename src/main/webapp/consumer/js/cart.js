// 장바구니 페이지 JavaScript

$(document).ready(function() {
	// 페이지 로드 시 초기 계산
    updateTotalAmount();
	
    // 수량 변경 이벤트
    $('.quantity-input').on('change', function() {
        const cartItemId = $(this).data('cart-item-id');
        const newQuantity = $(this).val();
        const originalQuantity = $(this).data('original-quantity');

        if (newQuantity != originalQuantity) {
            updateQuantity(cartItemId, newQuantity);
        }
    });

    // 삭제 버튼 이벤트
    $('.delete-btn').on('click', function() {
        const cartItemId = $(this).data('cart-item-id');
        if (confirm('정말 삭제하시겠습니까?')) {
            removeFromCart(cartItemId);
        }
    });

    // 바로구매 버튼 이벤트
    $('.buy-now-btn').on('click', function() {
        buyNow(this);
    });

    // 선택 주문 버튼
    $('.order-selected-btn').on('click', function() {
        const selectedItems = $('.item-checkbox:checked').map(function() {
            return $(this).val();
        }).get();

        if (selectedItems.length === 0) {
            alert('주문할 상품을 선택해주세요.');
            return;
        }

        // 선택상품 주문
        const form = $('<form method="get" action="/store/checkout"></form>');
        selectedItems.forEach(function(id) {
            form.append('<input type="hidden" name="cartItemIds" value="' + id + '">');
        });
        $('body').append(form);
        form.submit();
    });
    
    // 전체 주문 버튼
    $('.order-all-btn').on('click', function() {
        const allItems = $('.item-checkbox').map(function() {
            return $(this).val();
        }).get();

        if (allItems.length === 0) {
            alert('장바구니가 비어있습니다.');
            return;
        }

        // 전체상품 주문
        const form = $('<form method="get" action="/store/checkout"></form>');
        allItems.forEach(function(id) {
            form.append('<input type="hidden" name="cartItemIds" value="' + id + '">');
        });
        $('body').append(form);
        form.submit();
    });

    // 전체선택/해제 버튼
    $('.select-all-btn').on('click', function() {
        const allChecked = $('.item-checkbox:checked').length === $('.item-checkbox').length;
        $('.item-checkbox').prop('checked', !allChecked);
        $(this).text(allChecked ? '전체선택' : '전체선택 해제');
        
        // 금액 업데이트!
        updateTotalAmount();
    });

    // 선택상품 삭제 버튼
     $('.delete-selected-btn').on('click', function() {
        const selectedItems = $('.item-checkbox:checked').map(function() {
            return $(this).val();
        }).get();

        if (selectedItems.length === 0) {
            alert('삭제할 상품을 선택해주세요.');
            return;
        }

        if (confirm('선택한 상품을 삭제하시겠습니까?')) {
            deleteSelectedItems(selectedItems);
        }
    });
    
     // 개별 체크박스 클릭 시 금액 업데이트
    $('.item-checkbox').on('change', function() {
        updateTotalAmount();
    });
});

 //  선택된 상품들의 총 금액 계산 함수
function updateTotalAmount() {
    let total = 0;
    let count = 0;
    
    $('.item-checkbox:checked').each(function() {
        const row = $(this).closest('tr');
        
        // 해당 row의 최종 가격 가져오기
        const priceText = row.find('td').eq(3).find('p').last().text(); // "10,000 원"
        const price = parseInt(priceText.replace(/[^0-9]/g, '')); // 숫자만 추출
        
        if (!isNaN(price)) {
            total += price;
            count++;
        }
    });
    
    // 총 결제예상금액 업데이트
    $('.total-amount').html('총 결제예상금액 ' + total.toLocaleString() + ' 원' + 
        (count > 0 ? ' (' + count + '개 상품)' : ' (0개 상품)'));
}

// 수량 변경
function updateQuantity(cartItemId, quantity) {
    $.post('/store/cart/updateQuantity', {
        cartItemId: cartItemId,
        quantity: quantity
    }, function(data) {
        if (data.success) {
            location.reload();
        } else {
            alert(data.message);
        }
    });
}

// 장바구니에서 제거
function removeFromCart(cartItemId) {
    $.post('/store/cart/remove', {
        cartItemId: cartItemId
    }, function(data) {
        if (data.success) {
            location.reload();
        } else {
            alert(data.message);
        }
    });
}

// 선택 상품 삭제
function deleteSelectedItems(cartItemIds) {
    $.ajax({
        url: '/store/cart/removeMultiple',
        method: 'POST',
        data: { cartItemIds: cartItemIds },
        traditional: true,
        success: function(data) {
            if (data.success) {
                location.reload();
            } else {
                alert(data.message);
            }
        }
    });
}

// 바로구매 - 상품 상세 페이지와 동일한 로직
function buyNow(button) {
    const productId = button.getAttribute('data-product-id');
    const brandId = button.getAttribute('data-brand-id');
    const optionId = button.getAttribute('data-option-id');
    const quantity = button.getAttribute('data-quantity');

    // GET 방식으로 URL 파라미터 생성
    const params = new URLSearchParams();
    params.append('productId', productId);
    params.append('brandId', brandId);

    // 옵션이 있는 경우
    if (optionId && optionId !== 'null' && optionId !== '') {
        params.append('items[0].optionId', optionId);
        params.append('items[0].quantity', quantity);
    } else {
        // 단일 상품
        params.append('quantity', quantity);
    }

    // GET 요청으로 이동
    window.location.href = '/store/checkout?' + params.toString();
}