function removeFromCart(cartItemId) {
    const form = $('<form method="post" action="/store/cart/remove"></form>');
    form.append('<input type="hidden" name="cartItemId" value="' + cartItemId + '">');
    $('body').append(form);
    form.submit();  // 페이지 새로고침됨
}