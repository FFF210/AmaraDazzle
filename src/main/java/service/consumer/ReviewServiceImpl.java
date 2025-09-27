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

	@Override
	public List<Review> getReviewsByProductId(Long productId) throws Exception {
		if (productId == null || productId <= 0) {
			throw new IllegalArgumentException("유효하지 않은 상품 ID입니다.");
		}
		List<Review> reviews = reviewDAO.selectReviewsByProductId(productId);
		return reviews; // 빈 리스트라도 반환
	}

	@Override
	public Map<String, Object> getReviewSummary(Long productId) throws Exception {
		if (productId == null || productId <= 0) {
			throw new IllegalArgumentException("유효하지 않은 상품 ID입니다.");
		}

		return reviewDAO.getReviewSummaryByProductId(productId);
	}

}
