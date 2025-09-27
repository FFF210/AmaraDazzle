package dao.consumer;

import java.util.List;
import java.util.Map;

import dto.Review;

public interface ReviewDAO {
	 List<Review> selectReviewsByProductId(Long productId) throws Exception;
	    Map<String, Object> getReviewSummaryByProductId(Long productId) throws Exception;
}
