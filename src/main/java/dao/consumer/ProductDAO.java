package dao.consumer;

import java.util.List;
import java.util.Map;

import dto.Product;
import dto.consumer.CommonProduct;
import dto.consumer.ModalProduct;
import dto.consumer.ProductCategory;
import dto.consumer.ProductPlan;
import dto.consumer.ProductRank;
import dto.consumer.ProductSale;
import dto.consumer.ProductSaleExclusive;
import dto.consumer.ProductSearch;

public interface ProductDAO {
	// 상품 상세 조회
	Product selectProductByProductId(Long productId) throws Exception;
	
	// ============ [주문관련] (orderService에 추가) ============
	// 상품 재고 감소 (옵션 없는 상품)
	int updateStock(Long productId, int quantity) throws Exception;

	// 옵션 재고 감소 (옵션 있는 상품)
	int updateOptionStock(Long optionId, int quantity) throws Exception;
	
	// [brandDetail 용도] 브랜드 상품들 조회
	 List<Map<String, Object>> selectProductsByBrandId(Map<String, Object> params) throws Exception;

	 // [brandDetail 용도] 브랜드 상품들 개수 조회
	 int countProductsByBrand(Map<String, Object> params) throws Exception;

	//================== [목록 조회용] ============================
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

	// [소비자] 최근 본 상품 조회
	List<ModalProduct> getProductsByIds(List<Long> productIds, Long memberId) throws Exception;
}