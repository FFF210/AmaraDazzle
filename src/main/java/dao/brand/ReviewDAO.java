package dao.brand;

import java.util.List;
import java.util.Map;

import dto.brand.ReviewList;

public interface ReviewDAO {
	// 고객 리뷰 목록 조회
	List<ReviewList> selectReviewListForBrand(Map<String, Object> params) throws Exception;

	// 고객 리뷰 목록 개수
	Integer selectReviewCountForBrand(Map<String, Object> params) throws Exception;

	// 고객 리뷰 상세 조회
	ReviewList selectReviewDetailForBrand(Long reviewId) throws Exception;

	// 고객 리뷰 답변 작성
	void updateReviewAnswer(Map<String, Object> params) throws Exception;

}
