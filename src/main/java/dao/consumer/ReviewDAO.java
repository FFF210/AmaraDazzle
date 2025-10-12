package dao.consumer;

import java.util.List;
import java.util.Map;

import dto.Review;

public interface ReviewDAO {
	// 리뷰 목록(productDetail 용)
	List<Review> selectReviewsByProductId(Long productId) throws Exception;
	
	// 페이지네이션용 리뷰 목록 조회
	List<Map<String, Object>> selectReviewsByProductIdWithPaging(Map<String, Object> params) throws Exception;
		
	//  리뷰 총 개수 조회
	int getReviewCountByProductId(Long productId) throws Exception;

	// 리뷰 요약(productDetail 용)
	Map<String, Object> getReviewSummaryByProductId(Long productId) throws Exception;

// ================= 마이페이지용 =======================  
	// 리뷰 작성 가능한 상품 목록 조회 (배송완료 + 리뷰 미작성)
	List<Map<String, Object>> getReviewableItems(Long memberId) throws Exception;

	// 내가 작성한 리뷰 목록 조회
	List<Map<String, Object>> getMyReviews(Long memberId) throws Exception;

	// 리뷰 작성
	void insertReview(Review review) throws Exception;
	
	// 테스트용 메서드
	List<Map<String, Object>> testQuery(Long memberId) throws Exception;
}
