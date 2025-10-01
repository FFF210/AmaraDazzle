package dao.consumer;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.Review;
import util.MybatisSqlSessionFactory;

public class ReviewDAOImpl implements ReviewDAO {

	private SqlSession sqlSession;

	public ReviewDAOImpl() {
		sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	}

	// 리뷰 목록 조회 (productDetail 용도)
	@Override
	public List<Review> selectReviewsByProductId(Long productId) throws Exception {
		return sqlSession.selectList("mapper.review.selectReviewsByProductId", productId);
	}

	// 리뷰 요약 조회(productDetail)
	@Override
	public Map<String, Object> getReviewSummaryByProductId(Long productId) throws Exception {
		return sqlSession.selectOne("mapper.review.getReviewSummaryByProductId", productId);
	}

	// 리뷰 작성 가능한 상품 목록 조회 (배송완료 + 리뷰 미작성)
	@Override
	public List<Map<String, Object>> getReviewableItems(Long memberId) throws Exception {
		return sqlSession.selectList("mapper.review.selectReviewableItems", memberId);
	}

	// 내가 작성한 리뷰 목록 조회
	@Override
	public List<Map<String, Object>> getMyReviews(Long memberId) throws Exception {
		return sqlSession.selectList("mapper.review.selectMyReviews", memberId);
	}

	// 리뷰 작성
	@Override
	public void insertReview(Review review) throws Exception {
		sqlSession.insert("mapper.review.insertReview", review);
		sqlSession.commit();
	}

}
