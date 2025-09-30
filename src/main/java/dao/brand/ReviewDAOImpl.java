package dao.brand;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.brand.ReviewList;
import util.MybatisSqlSessionFactory;

public class ReviewDAOImpl implements ReviewDAO {

	// 고객 리뷰 목록 조회
	@Override
	public List<ReviewList> selectReviewListForBrand(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.review.selectReviewListForBrand", params);
		}
	}

	// 고객 리뷰 목록 개수
	@Override
	public Integer selectReviewCountForBrand(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.review.selectReviewCountForBrand", params);
		}
	}

	// 고객 리뷰 답변 작성
	@Override
	public void updateReviewAnswer(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			sqlSession.selectList("mapper.review.updateReviewAnswer", params);
			sqlSession.commit();
		}
	}
}
