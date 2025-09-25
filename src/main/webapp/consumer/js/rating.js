// Rating 컴포넌트 JavaScript

// 페이지 로드 시 모든 rating 컴포넌트 초기화
document.addEventListener('DOMContentLoaded', function() {
	initAllRatings();
});

// 모든 rating 컴포넌트 초기화
function initAllRatings() {
	const ratings = document.querySelectorAll('.rating.interactive');
	ratings.forEach(rating => {
		initRating(rating);
	});
}

// 개별 rating 컴포넌트 초기화
function initRating(ratingElement) {
	const stars = ratingElement.querySelectorAll('.star');
	const currentRating = parseFloat(ratingElement.dataset.rating) || 0;

	stars.forEach((star, index) => {
		const starValue = index + 1;


		// 클릭 이벤트
		star.addEventListener('click', function() {
			setRating(ratingElement, starValue);
		});
	});




	// 평점 설정
	function setRating(ratingElement, newRating) {
		const oldRating = parseFloat(ratingElement.dataset.rating) || 0;

		// 데이터 속성 업데이트
		ratingElement.dataset.rating = newRating;

		// 별 표시 업데이트
		updateStarDisplay(ratingElement, newRating);

		// 점수 표시 업데이트 (있는 경우)
		const scoreElement = ratingElement.querySelector('.rating-score');
		if (scoreElement) {
			scoreElement.textContent = newRating.toFixed(1);
		}


		// 커스텀 이벤트 발생 (평점 변경 알림)
		const ratingChangeEvent = new CustomEvent('ratingChanged', {
			detail: {
				ratingId: ratingElement.dataset.ratingId,
				oldRating: oldRating,
				newRating: newRating,
				ratingElement: ratingElement
			}
		});
		document.dispatchEvent(ratingChangeEvent);
	}

	// 별 표시 업데이트 (소수점 지원)
	function updateStarDisplay(ratingElement, rating) {
		const stars = ratingElement.querySelectorAll('.star');
		const fullStars = Math.floor(rating);
		const hasHalfStar = (rating % 1) >= 0.5;

		stars.forEach((star, index) => {
			const starValue = index + 1;
			star.classList.remove('filled', 'empty', 'half-filled');

			if (starValue <= fullStars) {
				star.classList.add('filled');
			} else if (starValue === fullStars + 1 && hasHalfStar) {
				star.classList.add('half-filled');
			} else {
				star.classList.add('empty');
			}
		});
	}

	// 평점 값 가져오기 (외부에서 사용)
	function getRatingValue(ratingId) {
		const ratingElement = document.querySelector(`[data-rating-id="${ratingId}"]`);
		if (ratingElement) {
			return parseFloat(ratingElement.dataset.rating) || 0;
		}
		return 0;
	}

	// 평점 값 설정 (외부에서 사용)
	function setRatingValue(ratingId, newRating) {
		const ratingElement = document.querySelector(`[data-rating-id="${ratingId}"]`);
		if (ratingElement) {
			setRating(ratingElement, newRating);
		}
	}

	// 평점 변경 이벤트 리스너 (사용 예시)
	document.addEventListener('ratingChanged', function(e) {
		console.log('Rating changed:', {
			id: e.detail.ratingId,
			from: e.detail.oldRating,
			to: e.detail.newRating
		});

		// 실제 사용 시 서버로 데이터 전송
		// sendRatingToServer(e.detail.ratingId, e.detail.newRating);
	});

	// 서버로 평점 데이터 전송 (예시)
	function sendRatingToServer(ratingId, rating) {
		// fetch API를 사용한 서버 전송 예시
		/*
		fetch('/api/rating', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json',
			},
			body: JSON.stringify({
				ratingId: ratingId,
				rating: rating
			})
		})
		.then(response => response.json())
		.then(data => {
			console.log('Rating saved:', data);
		})
		.catch(error => {
			console.error('Error saving rating:', error);
		});
		*/
	}

	// 평점 초기화 (외부에서 사용)
	function resetRating(ratingId) {
		setRatingValue(ratingId, 0);
	}

	// 평점 비활성화/활성화
	function setRatingDisabled(ratingId, disabled) {
		const ratingElement = document.querySelector(`[data-rating-id="${ratingId}"]`);
		if (ratingElement) {
			if (disabled) {
				ratingElement.classList.add('readonly');
				ratingElement.classList.remove('interactive');
			} else {
				ratingElement.classList.remove('readonly');
				ratingElement.classList.add('interactive');
				initRating(ratingElement); // 다시 초기화
			}
		}
	}
}