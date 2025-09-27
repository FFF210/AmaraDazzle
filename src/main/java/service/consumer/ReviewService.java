package service.consumer;

import java.util.List;
import java.util.Map;

import dto.Review;

public interface ReviewService {
	//상품아이디로 리뷰 리스트 조회
	 List<Review> getReviewsByProductId(Long productId) throws Exception;
	 //리뷰 요약 가져오기
	 Map<String, Object> getReviewSummary(Long productId) throws Exception;
}
