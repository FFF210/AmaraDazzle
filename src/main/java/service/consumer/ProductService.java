package service.consumer;

import java.util.Map;

import dto.Product;

public interface ProductService {
	// 상품 상세
	Product getProductDetail(Long productId) throws Exception;

	// [소비자] 기획상품 목록 조회
	Map<String, Object> productPlanListByPage(Map<String, Object> params) throws Exception;

	// [소비자] 랭킹상품 목록 조회
	Map<String, Object> productRankListByPage(Map<String, Object> params) throws Exception;

	// [소비자] 세일상품 목록 조회
	Map<String, Object> productSaleListByPage(Map<String, Object> params) throws Exception;

	// [소비자] 카테고리상품 목록 조회
	Map<String, Object> productCategoryListByPage(Map<String, Object> params) throws Exception;
}
