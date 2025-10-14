package dao.consumer;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.ProductOption;
import util.MybatisSqlSessionFactory;

public class ProductOptionDAOImpl implements ProductOptionDAO {
	@Override
	public List<ProductOption> selectProductOptionsByProductId(Long productId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.productOption.selectProductOptionsByProductId", productId);
		}
	}

	@Override
	public ProductOption selectProductOptionByOptionId(Long optionId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.productOption.selectProductOptionByOptionId", optionId);
		}
	}

	// 교환 신청용: 상품의 전체 옵션 목록 조회
	@Override
	public List<Map<String, Object>> getProductOptions(Long productId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.productOption.getProductOptions", productId);
		}
	}

}
