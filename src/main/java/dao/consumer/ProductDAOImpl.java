package dao.consumer;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.Product;
import dto.consumer.CommonProduct;
import dto.consumer.ModalProduct;
import dto.consumer.ProductCategory;
import dto.consumer.ProductPlan;
import dto.consumer.ProductRank;
import dto.consumer.ProductSale;
import dto.consumer.ProductSaleExclusive;
import dto.consumer.ProductSearch;
import util.MybatisSqlSessionFactory;

public class ProductDAOImpl implements ProductDAO {

	// productDetail 용도
	@Override
	public Product selectProductByProductId(Long productId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.product.selectProductByProductId", productId);
		}
	}

	// (주문 성공시) 상품 재고 감소 (옵션 없는 상품)
	@Override
	public int updateStock(Long productId, int quantity) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			Map<String, Object> params = new HashMap<>();
			params.put("productId", productId);
			params.put("quantity", quantity);

			int result = sqlSession.update("mapper.product.updateStock", params);
			sqlSession.commit();
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	// (주문 성공시) 옵션 재고 감소 (옵션 있는 상품)
	@Override
	public int updateOptionStock(Long optionId, int quantity) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			Map<String, Object> params = new HashMap<>();
			params.put("optionId", optionId);
			params.put("quantity", quantity);

			int result = sqlSession.update("mapper.product.updateOptionStock", params);
			sqlSession.commit();
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	// ========================== [목록 조회 용도] ====================

	// [소비자] 기획 상품 목록 조회
	@Override
	public List<ProductPlan> selectPlannedProducts(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.product.selectPlannedProducts", params);
		}
	}

	// [소비자] 기획 상품 목록 개수
	@Override
	public Integer selectPlannedProductsCount(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.product.selectPlannedProductsCount", params);
		}
	}

	// [소비자] 랭킹 상품 목록 조회
	@Override
	public List<ProductRank> selectRankingProducts(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.product.selectRankingProducts", params);
		}
	}

	// [소비자] 랭킹 상품 목록 개수
	@Override
	public Integer selectRankingProductsCount(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.product.selectRankingProductsCount", params);
		}
	}

	// [소비자] 세일 상품 목록 조회
	@Override
	public List<ProductSale> selectSaleProducts(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.product.selectSaleProducts", params);
		}
	}

	// [소비자] 세일 상품 목록 개수
	@Override
	public Integer selectSaleProductsCount(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.product.selectSaleProductsCount", params);
		}
	}

	// [소비자] 세일&단독 상품 목록 조회
	@Override
	public List<ProductSaleExclusive> selectSaleExclusiveProducts(Long memberId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.product.selectSaleExclusiveProducts", memberId);
		}
	}

	// [소비자] 카테고리 상품 목록 조회
	@Override
	public List<ProductCategory> selectCategoryProducts(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.product.selectCategoryProducts", params);
		}
	}

	// [소비자] 카테고리 상품 목록 개수
	@Override
	public Integer selectCategoryProductsCount(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.product.selectCategoryProductsCount", params);
		}
	}

	// [brandDetail 용도] 브랜드 상품 조회
	@Override
	public List<Map<String, Object>> selectProductsByBrandId(Long brandId) {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.product.selectProductsByBrandId", brandId);
		}
	}

	// [소비자] 검색 상품 목록 조회
	@Override
	public List<ProductSearch> selectSearchProducts(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.product.selectSearchProducts", params);
		}
	}

	// [소비자] 검색 상품 목록 개수
	@Override
	public Integer selectSearchProductsCount(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.product.selectSearchProductsCount", params);
		}
	}

	@Override
	public List<CommonProduct> selectMyFitProductsForMain(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.product.selectMyFitProductsForMain", params);
		}
	}

	@Override
	public List<CommonProduct> selectPopularProductsForMain(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.product.selectPopularProductsForMain", params);
		}
	}

	@Override
	public List<CommonProduct> selectSaleProductsForMain(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.product.selectSaleProductsForMain", params);
		}
	}

	@Override
	public List<CommonProduct> selectExclusiveProductsForMain(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.product.selectExclusiveProductsForMain", params);
		}
	}

	// [소비자] 최근 본 상품 조회
	@Override
	public List<ModalProduct> getProductsByIds(List<Long> productIds, Long memberId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			Map<String, Object> param = new HashMap<>();
			param.put("productIds", productIds);
			param.put("memberId", memberId);

			return sqlSession.selectList("mapper.product.getProductsByIds", param);
		}
	}

}
