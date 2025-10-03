// addToBrandFollow.js - 브랜드 팔로우 토글
(function() {
    'use strict';
    
    function showToast(isFollowing) {
        const toast = document.createElement('div');
        toast.className = 'toast';
        toast.innerHTML = `
            <i class="bi bi-heart${isFollowing ? '-fill' : ''}" style="color: ${isFollowing ? '#ff4757' : '#fff'}"></i>
            <div>${isFollowing ? '브랜드를 팔로우했습니다' : '팔로우를 취소했습니다'}</div>
        `;
        
        document.body.appendChild(toast);
        
        setTimeout(() => toast.classList.add('show'), 10);
        setTimeout(() => {
            toast.classList.remove('show');
            setTimeout(() => toast.remove(), 300);
        }, 1500);
    }
    
    function toggleBrandFollow(brandId, icon) {
        fetch('/store/brandFollowToggle', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'brandId=' + encodeURIComponent(brandId)
        })
        .then(res => res.json())
        .then(data => {
            if (data.requireLogin) {
                alert('로그인이 필요합니다.');
                location.href = '/store/login';
                return;
            }
            
            if (data.success) {
                if (data.isFollowing) {
                    icon.classList.remove('bi-heart');
                    icon.classList.add('bi-heart-fill', 'active');
                } else {
                    icon.classList.remove('bi-heart-fill', 'active');
                    icon.classList.add('bi-heart');
                }
                showToast(data.isFollowing);
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
        // brandNavCard용
        document.querySelectorAll('.brand-card .heart-btn, .brand-nav-card .heart-btn').forEach(btn => {
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
    });
})();