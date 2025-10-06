package service.consumer;

import java.util.List;
import java.util.Map;

import dto.Product;

public interface ProductService {
	// 상품 상세
	Product getProductDetail(Long productId) throws Exception;

	// [소비자] 기획 상품 목록 조회
	Map<String, Object> productPlanListByPage(Map<String, Object> params) throws Exception;

	// [소비자] 랭킹 상품 목록 조회
	Map<String, Object> productRankListByPage(Map<String, Object> params) throws Exception;

	// [소비자] 세일 상품 목록 조회
	Map<String, Object> productSaleListByPage(Map<String, Object> params) throws Exception;

	// [소비자] 카테고리 상품 목록 조회
	Map<String, Object> productCategoryListByPage(Map<String, Object> params) throws Exception;

	// [소비자] 검색 상품 목록 조회
	Map<String, Object> productSearchListByPage(Map<String, Object> params) throws Exception;

	// [소비자] 메인 상품 조회
	Map<String, Object> productMainList(Map<String, Object> params) throws Exception;

	// [productDetail용] 브랜드 상품 가져오기 (mapper는 product에)
	List<Map<String, Object>> getProductsByBrandId(Long brandId) throws Exception;
}
