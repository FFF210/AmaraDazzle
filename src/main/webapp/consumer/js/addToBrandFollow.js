// addToBrandFollow.js - 브랜드 팔로우 토글
(function() {
'use strict';

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

function toggleBrandFollow(brandId, icon, countElement) {
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
            // 하트 아이콘 상태 변경
            if (data.isFollowing) {
                icon.classList.remove('bi-heart');
                icon.classList.add('bi-heart-fill', 'active');
            } else {
                icon.classList.remove('bi-heart-fill', 'active');
                icon.classList.add('bi-heart');
                
                // 좋아요 페이지에서는 카드 제거
                if (window.location.pathname.includes('/like')) {
                    const card = icon.closest('.brand-card, .brand-nav-card');
                    if (card) {
                        card.style.opacity = '0';
                        card.style.transition = 'opacity 0.3s';
                        setTimeout(function() { 
                            card.remove();
                            
                            // 카드가 하나도 없으면 빈 메시지 표시
                            const grid = document.querySelector('.brand-grid');
                            if (grid && grid.querySelectorAll('.brand-card, .brand-nav-card').length === 0) {
                                grid.innerHTML = '<p class="empty-message">좋아요 브랜드가 없습니다.</p>';
                            }
                        }, 300);
                    }
                }
            }
            
            // 팔로워 수 업데이트 (있으면)
            if (countElement) {
                let currentCount = parseInt(countElement.textContent) || 0;
                countElement.textContent = data.isFollowing ? currentCount + 1 : Math.max(0, currentCount - 1);
            }
            
            // Toast 메시지 표시
            showToast(data.isFollowing);
        } else {
            alert(data.message || '오류가 발생했습니다.');
        }
    })
    .catch(function(err) {
        console.error('Error:', err);
        alert('서버 오류가 발생했습니다.');
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
                toggleBrandFollow(brandId, icon, null);
            }
        });
    });

    // 2. 브랜드 상세 페이지용
    const brandFavorite = document.querySelector('.brand-favorite');
    if (brandFavorite) {
        const heartBtn = brandFavorite.querySelector('.heart-btn');
        const countElement = brandFavorite.querySelector('.count');
        const brandId = brandFavorite.dataset.brandid;

        if (heartBtn && brandId) {
            heartBtn.addEventListener('click', function(e) {
                e.preventDefault();
                e.stopPropagation();

                const icon = heartBtn.querySelector('i');
                toggleBrandFollow(brandId, icon, countElement);
            });
        }
    }
});
})();