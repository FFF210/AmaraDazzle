package service.brand;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.brand.ReviewDAO;
import dao.brand.ReviewDAOImpl;
import dto.brand.ReviewList;

public class ReviewServiceImpl implements ReviewService {

	private ReviewDAO reviewDAO;

	public ReviewServiceImpl() {
		reviewDAO = new ReviewDAOImpl();
	}

	// 리뷰 목록 조회
	@Override
	public Map<String, Object> reviewListByPage(Map<String, Object> params) throws Exception {
		// 상품 목록 조회
		List<ReviewList> reviewList = reviewDAO.selectReviewListForBrand(params);

		// 총 상품 개수 조회
		int totalCount = reviewDAO.selectReviewCountForBrand(params);

		// 총 페이지 수 계산
		int limit = (int) params.getOrDefault("limit", 10);
		int totalPages = (int) Math.ceil((double) totalCount / limit);

		Map<String, Object> result = new HashMap<>();
		result.put("reviewList", reviewList);
		result.put("totalCount", totalCount);
		result.put("totalPages", totalPages);

		return result;
	}

	// 리뷰 상세 조회
	@Override
	public ReviewList reviewDetail(Long reviewId) throws Exception {
		return reviewDAO.selectReviewDetailForBrand(reviewId);
	}

	// 리뷰 답변 등록/수정
	@Override
	public void updateReviewAnswer(Long reviewId, String answer) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("reviewId", reviewId);
		param.put("answer", answer);

		reviewDAO.updateReviewAnswer(param);
	}
}
