// addToWishlist.js - 범용 위시리스트 토글
(function() {
    'use strict';
    
    function showToast(isWished) {
        const toast = document.createElement('div');
        toast.className = 'toast';
        toast.innerHTML = `
            <i class="bi bi-heart${isWished ? '-fill' : ''}" style="color: ${isWished ? '#ff4757' : '#fff'}"></i>
            <div>${isWished ? '좋아요에 추가되었습니다' : '좋아요에서 삭제되었습니다'}</div>
        `;
        
        document.body.appendChild(toast);
        
        setTimeout(() => toast.classList.add('show'), 10);
        setTimeout(() => {
            toast.classList.remove('show');
            setTimeout(() => toast.remove(), 300);
        }, 1500);
    }
    
    function toggleWishlist(productId, icon) {
        fetch('/store/wishlistToggle', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'productId=' + encodeURIComponent(productId)
        })
        .then(res => res.json())
        .then(data => {
            if (data.requireLogin) {
                alert('로그인이 필요합니다.');
                location.href = '/store/login';
                return;
            }
            
            if (data.success) {
                if (data.isWished) {
                    icon.classList.remove('bi-heart');
                    icon.classList.add('bi-heart-fill', 'active');
                } else {
                    icon.classList.remove('bi-heart-fill', 'active');
                    icon.classList.add('bi-heart');
                    
                    // 좋아요 페이지에서는 카드 제거
                    if (window.location.pathname.includes('like')) {
                        const card = icon.closest('.product-card');
                        if (card) {
                            card.style.opacity = '0';
                            card.style.transition = 'opacity 0.3s';
                            setTimeout(() => card.remove(), 300);
                        }
                    }
                }
                showToast(data.isWished);
            } else {
                alert(data.message || '오류가 발생했습니다.');
            }
        })
        .catch(err => {
            console.error('Error:', err);
            alert('서버 오류가 발생했습니다.');
        });
    }
    
    document.addEventListener('DOMContentLoaded', function() {
        // 1. productCard용 (목록 페이지)
        document.querySelectorAll('.product-card .heart-btn').forEach(btn => {
            btn.addEventListener('click', function(e) {
                e.preventDefault();
                e.stopPropagation();
                
                const icon = btn.querySelector('i');
                const productId = btn.closest('.product-card').dataset.productid;
                
                if (productId) {
                    toggleWishlist(productId, icon);
                }
            });
        });
        
        // 2. wishlist-btn용 (장바구니 등) - 추가
        document.querySelectorAll('.wishlist-btn .heart-btn').forEach(btn => {
            btn.addEventListener('click', function(e) {
                e.preventDefault();
                e.stopPropagation();
                
                const icon = btn.querySelector('i');
                const wishlistDiv = btn.closest('.wishlist-btn');
                const productId = wishlistDiv ? wishlistDiv.dataset.productId : null;
                
                if (productId) {
                    toggleWishlist(productId, icon);
                }
            });
        });
        
        // 3. productDetail용 (상세 페이지)
        const detailHeartBtn = document.querySelector('.purchase-buttons .heart-btn');
        if (detailHeartBtn && window.productId) {
            const newBtn = detailHeartBtn.cloneNode(true);
            detailHeartBtn.parentNode.replaceChild(newBtn, detailHeartBtn);
            
            newBtn.addEventListener('click', function(e) {
                e.preventDefault();
                const icon = newBtn.querySelector('i');
                toggleWishlist(window.productId, icon);
            });
        }
    });
})();