package dao.consumer;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.Product;
import dto.consumer.ProductPlan;
import util.MybatisSqlSessionFactory;

public class ProductDAOImpl implements ProductDAO {

	@Override
	public Product selectProductByProductId(Long productId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.product.selectProductByProductId", productId);
		}
	}

	// [소비자] 기획상품 목록 조회
	@Override
	public List<ProductPlan> selectPlannedProducts(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.product.selectPlannedProducts", params);
		}
	}

	// [소비자] 기획상품 목록 개수
	@Override
	public Integer selectPlannedProductsCount(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.product.selectPlannedProductsCount", params);
		}
	}

}
