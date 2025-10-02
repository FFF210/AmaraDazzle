package dao.consumer;

import java.util.List;
import java.util.Map;

import dto.Product;
import dto.consumer.ProductPlan;
import dto.consumer.ProductRank;

public interface ProductDAO {
	Product selectProductByProductId(Long productId) throws Exception;

	// [소비자] 기획상품 목록 조회
	List<ProductPlan> selectPlannedProducts(Map<String, Object> params) throws Exception;

	// [소비자] 기획상품 목록 개수
	Integer selectPlannedProductsCount(Map<String, Object> params) throws Exception;

	// [소비자] 랭킹상품 목록 조회
	List<ProductRank> selectRankingProducts(Map<String, Object> params) throws Exception;

	// [소비자] 랭킹상품 목록 개수
	Integer selectRankingProductsCount(Map<String, Object> params) throws Exception;
}