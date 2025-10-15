// addToBrandFollow.js - 브랜드 팔로우 토글
(function() {
'use strict';

let isProcessing = false;

function showToast(isFollowing) {
    const toast = document.createElement('div');
    toast.className = 'toast';
    toast.innerHTML = '<i class="bi bi-heart' + (isFollowing ? '-fill' : '') + '" style="color: ' + (isFollowing ? '#ff4757' : '#fff') + '"></i>' +
        '<div>' + (isFollowing ? '좋아요에 추가되었습니다' : '좋아요에서 삭제되었습니다') + '</div>';

    document.body.appendChild(toast);

    setTimeout(function() { toast.classList.add('show'); }, 10);
    setTimeout(function() {
        toast.classList.remove('show');
        setTimeout(function() { toast.remove(); }, 300);
    }, 1500);
}

function toggleBrandFollow(brandId, icon) {
    if (isProcessing) {
        return;
    }
    
    isProcessing = true;
    
    fetch('/store/brandFollowToggle', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: 'brandId=' + encodeURIComponent(brandId)
    })
    .then(function(res) { return res.json(); })
    .then(function(data) {
        if (data.requireLogin) {
            alert('로그인이 필요합니다.');
            location.href = '/store/login';
            return;
        }

        if (data.success) {
            // 좋아요 페이지에서는 카드 제거
            if (!data.isFollowing && window.location.pathname.includes('/like')) {
                const card = icon.closest('.brand-card, .brand-nav-card');
                if (card) {
                    card.style.opacity = '0';
                    card.style.transition = 'opacity 0.3s';
                    setTimeout(function() { 
                        card.remove();
                        
                        const grid = document.querySelector('.brand-grid');
                        if (grid && grid.querySelectorAll('.brand-card, .brand-nav-card').length === 0) {
                            grid.innerHTML = '<p class="empty-message">좋아요 브랜드가 없습니다.</p>';
                        }
                    }, 300);
                }
            }
            
            showToast(data.isFollowing);
        } else {
            alert(data.message || '오류가 발생했습니다.');
        }
    })
    .catch(function(err) {
        console.error('Error:', err);
        alert('서버 오류가 발생했습니다.');
    })
    .finally(function() {
        setTimeout(function() {
            isProcessing = false;
        }, 300);
    });
}

document.addEventListener('DOMContentLoaded', function() {
    // 1. 브랜드 카드용 (목록 페이지)
    document.querySelectorAll('.brand-card .heart-btn, .brand-nav-card .heart-btn').forEach(function(btn) {
        btn.addEventListener('click', function(e) {
            e.preventDefault();
            e.stopPropagation();

            const icon = btn.querySelector('i');
            const brandCard = btn.closest('.brand-card, .brand-nav-card');
            const brandId = brandCard ? brandCard.dataset.brandid : null;

            if (brandId) {
                toggleBrandFollow(brandId, icon);
            }
        });
    });

    // 2. 브랜드 상세 페이지용
    const brandFavorite = document.querySelector('.brand-favorite');
    if (brandFavorite) {
        const heartBtn = brandFavorite.querySelector('.heart-btn');
        const brandId = brandFavorite.dataset.brandid;

        if (heartBtn && brandId) {
            heartBtn.addEventListener('click', function(e) {
                // heartBtn.tag의 기본 동작은 그대로 둠 (숫자 자동 증가/감소)
                // 우리는 API 호출만 추가
                const icon = heartBtn.querySelector('i');
                toggleBrandFollow(brandId, icon);
            });
        }
    }
});
})();