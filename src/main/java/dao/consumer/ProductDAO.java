package dao.consumer;

import java.util.List;
import java.util.Map;

import dto.Product;
import dto.consumer.CommonProduct;
import dto.consumer.ProductCategory;
import dto.consumer.ProductPlan;
import dto.consumer.ProductRank;
import dto.consumer.ProductSale;
import dto.consumer.ProductSaleExclusive;
import dto.consumer.ProductSearch;

public interface ProductDAO {
	Product selectProductByProductId(Long productId) throws Exception;

	// [소비자] 기획 상품 목록 조회
	List<ProductPlan> selectPlannedProducts(Map<String, Object> params) throws Exception;

	// [소비자] 기획 상품 목록 개수
	Integer selectPlannedProductsCount(Map<String, Object> params) throws Exception;

	// [소비자] 랭킹 상품 목록 조회
	List<ProductRank> selectRankingProducts(Map<String, Object> params) throws Exception;

	// [소비자] 랭킹 상품 목록 개수
	Integer selectRankingProductsCount(Map<String, Object> params) throws Exception;

	// [소비자] 세일 상품 목록 조회
	List<ProductSale> selectSaleProducts(Map<String, Object> params) throws Exception;

	// [소비자] 세일 상품 목록 개수
	Integer selectSaleProductsCount(Map<String, Object> params) throws Exception;

	// [소비자] 세일&단독 상품 목록 조회
	List<ProductSaleExclusive> selectSaleExclusiveProducts(Long memberId) throws Exception;

	// [소비자] 카테고리 상품 목록 조회
	List<ProductCategory> selectCategoryProducts(Map<String, Object> params) throws Exception;

	// [소비자] 카테고리 상품 목록 개수
	Integer selectCategoryProductsCount(Map<String, Object> params) throws Exception;

	// [소비자] 검색 상품 목록 조회
	List<ProductSearch> selectSearchProducts(Map<String, Object> params) throws Exception;

	// [소비자] 검색 상품 목록 개수
	Integer selectSearchProductsCount(Map<String, Object> params) throws Exception;

	// [소비자] 나에게 딱 맞는 상품 4개 조회
	List<CommonProduct> selectMyFitProductsForMain(Map<String, Object> params) throws Exception;

	// [소비자] 인기 상품 4개 조회
	List<CommonProduct> selectPopularProductsForMain(Map<String, Object> params) throws Exception;

	// [소비자] 세일 상품 4개 조회
	List<CommonProduct> selectSaleProductsForMain(Map<String, Object> params) throws Exception;

	// [소비자] 단독 상품 4개 조회
	List<CommonProduct> selectExclusiveProductsForMain(Map<String, Object> params) throws Exception;

	// [brandDetail 용도] 브랜드 상품들 조회
	List<Map<String, Object>> selectProductsByBrandId(Long brandId);
}