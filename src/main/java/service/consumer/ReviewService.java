package service.consumer;

import java.util.List;
import java.util.Map;

import dto.Review;

public interface ReviewService {
	// 상품아이디로 리뷰 리스트 조회
	List<Review> getReviewsByProductId(Long productId) throws Exception;

	// 리뷰 요약 가져오기
	Map<String, Object> getReviewSummary(Long productId) throws Exception;

	// ============= 마이페이지용 =============
	// 리뷰 작성 가능한 상품 목록 조회
	List<Map<String, Object>> getReviewableItems(Long memberId) throws Exception;

	// 내가 작성한 리뷰 목록 조회
	List<Map<String, Object>> getMyReviews(Long memberId) throws Exception;

	// 리뷰 작성
	void createReview(Review review) throws Exception;
	
	// 테스트용 메서드 추가
	List<Map<String, Object>> testQuery(Long memberId) throws Exception;
}
