package dao.brand;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.Product;
import util.MybatisSqlSessionFactory;

public class ProductDAOImpl implements ProductDAO {
	
	SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

	// 상품 목록 조회
	@Override
	public List<Product> selectProductListForBrand(Map<String, Object> params) throws Exception {
		return sqlSession.selectList("mapper.product.selectProductListForBrand", params);
	}

	// 상품 개수 조회
	@Override
	public Integer selectProductCountForBrand(Map<String, Object> params) throws Exception {
		return sqlSession.selectOne("mapper.product.selectProductCountForBrand", params);
	}
}
