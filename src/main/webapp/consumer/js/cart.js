// 장바구니 페이지 JavaScript

$(document).ready(function() {
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
        const form = $('<form method="post" action="/cart/checkout"></form>');
        selectedItems.forEach(function(id) {
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
});

// 수량 변경
function updateQuantity(cartItemId, quantity) {
    $.post('/cart/updateQuantity', {
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
    $.post('/cart/remove', {
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
        url: '/cart/removeMultiple',
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
    window.location.href = '/consumer/checkout?' + params.toString();
}