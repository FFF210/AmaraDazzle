package dao.consumer;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.Product;
import dto.consumer.ProductCategory;
import dto.consumer.ProductPlan;
import dto.consumer.ProductRank;
import dto.consumer.ProductSale;
import dto.consumer.ProductSaleExclusive;
import dto.consumer.ProductSearch;
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

	// [소비자] 랭킹상품 목록 조회
	@Override
	public List<ProductRank> selectRankingProducts(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.product.selectRankingProducts", params);
		}
	}

	// [소비자] 랭킹상품 목록 개수
	@Override
	public Integer selectRankingProductsCount(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.product.selectRankingProductsCount", params);
		}
	}

	// [소비자] 세일상품 목록 조회
	@Override
	public List<ProductSale> selectSaleProducts(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.product.selectSaleProducts", params);
		}
	}

	// [소비자] 세일상품 목록 개수
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

	// [소비자] 카테고리상품 목록 조회
	@Override
	public List<ProductCategory> selectCategoryProducts(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.product.selectCategoryProducts", params);
		}
	}

	// [소비자] 카테고리상품 목록 개수
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

	// [소비자] 검색상품 목록 조회
	@Override
	public List<ProductSearch> selectSearchProducts(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.product.selectSearchProducts", params);
		}
	}

	// [소비자] 검색상품 목록 개수
	@Override
	public Integer selectSearchProductsCount(Map<String, Object> params) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.product.selectSearchProductsCount", params);
		}
	}

}
