package service.consumer;

import java.util.List;
import java.util.Map;

import dao.consumer.ReviewDAO;
import dao.consumer.ReviewDAOImpl;
import dto.Review;

public class ReviewServiceImpl implements ReviewService {

	private ReviewDAO reviewDAO;

	public ReviewServiceImpl() {
		this.reviewDAO = new ReviewDAOImpl();
	}

	// 상품아이디로 리뷰 리스트 조회
	@Override
	public List<Review> getReviewsByProductId(Long productId) throws Exception {
		if (productId == null || productId <= 0) {
			throw new IllegalArgumentException("유효하지 않은 상품 ID입니다.");
		}
		List<Review> reviews = reviewDAO.selectReviewsByProductId(productId);
		return reviews; // 빈 리스트라도 반환
	}

	// 리뷰 요약 가져오기
	@Override
	public Map<String, Object> getReviewSummary(Long productId) throws Exception {
		if (productId == null || productId <= 0) {
			throw new IllegalArgumentException("유효하지 않은 상품 ID입니다.");
		}

		return reviewDAO.getReviewSummaryByProductId(productId);
	}

	// ============= 마이페이지용 ===============
	// 리뷰 작성 가능한 상품 목록 조회
	@Override
	public List<Map<String, Object>> getReviewableItems(Long memberId) throws Exception {
		return reviewDAO.getReviewableItems(memberId);
	}

	// 내가 작성한 리뷰 가져오기
	@Override
	public List<Map<String, Object>> getMyReviews(Long memberId) throws Exception {
		return reviewDAO.getMyReviews(memberId);
	}

	// 리뷰 작성
	@Override
	public void createReview(Review review) throws Exception {
		if (review.getContent() == null || review.getContent().trim().isEmpty()) {
			throw new IllegalArgumentException("리뷰 내용을 입력해주세요.");
		}
		reviewDAO.insertReview(review);
	}
}
