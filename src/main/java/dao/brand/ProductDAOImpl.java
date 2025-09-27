package dao.brand;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.brand.ProductDetail;
import dto.brand.ProductList;
import util.MybatisSqlSessionFactory;

public class ProductDAOImpl implements ProductDAO {

	SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

	// 상품 목록 조회
	@Override
	public List<ProductList> selectProductListForBrand(Map<String, Object> params) throws Exception {
		return sqlSession.selectList("mapper.product.selectProductListForBrand", params);
	}

	// 상품 개수 조회
	@Override
	public Integer selectProductCountForBrand(Map<String, Object> params) throws Exception {
		return sqlSession.selectOne("mapper.product.selectProductCountForBrand", params);
	}

	// 상품 재고 변경
	@Override
	public void updateStockForBrand(Map<String, Object> params) throws Exception {
		sqlSession.update("mapper.product.updateStockForBrand", params);
		sqlSession.commit();
	}

	// 상품 공개 여부 토글
	@Override
	public void toggleVisibilityForBrand(long productId) throws Exception {
		sqlSession.update("mapper.product.toggleVisibilityForBrand", productId);
		sqlSession.commit();
	}

	// 세일 등록
	@Override
	public void registerSaleForBrand(Map<String, Object> params) throws Exception {
		sqlSession.update("mapper.product.registerSaleForBrand", params);
		sqlSession.commit();
	}

	// 단일 상품 단일 조회
	@Override
	public ProductDetail selectProductForBrand(long productId) throws Exception {
		return sqlSession.selectOne("mapper.product.selectProductForBrand", productId);
	}
}
