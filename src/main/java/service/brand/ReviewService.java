package service.brand;

import java.util.Map;

public interface ReviewService {
	// 리뷰 목록 조회
	Map<String, Object> reviewListByPage(Map<String, Object> params) throws Exception;

	// 리뷰 답변 등록/수정
	void updateReviewAnswer(Long reviewId, String answer) throws Exception;
}
