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

	@Override
	public List<Review> selectReviewsByProductId(Long productId) throws Exception {
		return sqlSession.selectList("mapper.review.selectReviewsByProductId", productId);
	}

	@Override
	public Map<String, Object> getReviewSummaryByProductId(Long productId) throws Exception {
		return sqlSession.selectOne("mapper.review.getReviewSummaryByProductId", productId);
	}

}
