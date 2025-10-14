package dao.consumer;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.Review;
import util.MybatisSqlSessionFactory;

public class ReviewDAOImpl implements ReviewDAO {
	// 리뷰 목록 조회 (productDetail 용도)
	@Override
	public List<Review> selectReviewsByProductId(Long productId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.review.selectReviewsByProductId", productId);
		}
	}

	// 페이지네이션용 리뷰 목록 조회
	@Override
	public List<Map<String, Object>> selectReviewsByProductIdWithPaging(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.review.selectReviewsByProductId", params);
		}
	}

	// 리뷰 총 개수 조회
	@Override
	public int getReviewCountByProductId(Long productId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			Integer count = sqlSession.selectOne("mapper.review.getReviewCountByProductId", productId);
			return count != null ? count : 0;
		}
	}

	// 리뷰 요약 조회(productDetail)
	@Override
	public Map<String, Object> getReviewSummaryByProductId(Long productId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.review.getReviewSummaryByProductId", productId);
		}
	}

	// 리뷰 작성 가능한 상품 목록 조회 (배송완료 + 리뷰 미작성)
	@Override
	public List<Map<String, Object>> getReviewableItems(Long memberId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			System.out.println("=== DAO 디버깅 시작 ===");
			System.out.println("DAO - memberId: " + memberId);
			System.out.println("DAO - sqlSession: " + (sqlSession != null ? "OK" : "NULL"));

			try {
				System.out.println("DAO - 쿼리 호출 시작: mapper.review.selectReviewableItems");
				List<Map<String, Object>> result = sqlSession.selectList("mapper.review.selectReviewableItems",
						memberId);
				System.out.println("DAO - 쿼리 호출 완료");
				System.out.println("DAO - 결과 개수: " + result.size());

				if (result.size() > 0) {
					System.out.println("DAO - 첫 번째 결과: " + result.get(0));
				} else {
					System.out.println("DAO - 결과가 비어있음");
				}

				return result;
			} catch (Exception e) {
				System.out.println("DAO - 예외 발생: " + e.getClass().getSimpleName() + " - " + e.getMessage());
				e.printStackTrace();
				throw e;
			} finally {
				System.out.println("=== DAO 디버깅 끝 ===");
			}
		}
	}

	// 내가 작성한 리뷰 목록 조회
	@Override
	public List<Map<String, Object>> getMyReviews(Long memberId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.review.selectMyReviews", memberId);
		}
	}

	// 리뷰 작성
	@Override
	public void insertReview(Review review) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			sqlSession.insert("mapper.review.insertReview", review);
			sqlSession.commit();
		}
	}

	@Override
	public List<Map<String, Object>> testQuery(Long memberId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			System.out.println("=== 테스트 쿼리 시작 ===");
			List<Map<String, Object>> testResult = sqlSession.selectList("mapper.review.testQuery", memberId);
			System.out.println("테스트 쿼리 결과: " + testResult.size());
			if (testResult.size() > 0) {
				System.out.println("첫 번째 결과: " + testResult.get(0));
			}
			System.out.println("=== 테스트 쿼리 끝 ===");
			return testResult;
		}
	}

}
