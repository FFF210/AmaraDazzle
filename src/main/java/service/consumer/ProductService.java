package service.consumer;

import java.util.List;
import java.util.Map;

import dto.Product;
import dto.consumer.ModalProduct;

public interface ProductService {
	// 상품 상세
	Product getProductDetail(Long productId) throws Exception;
	
	// [brandDetail용] 브랜드 상품 가져오기 (mapper는 product에)
	List<Map<String, Object>> getProductsByBrandId(Map<String, Object> params) throws Exception;
	
	// [brandDetail용] 개수 조회
    int countProductsByBrand(Map<String, Object> params) throws Exception;

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

	// [소비자] 최근 본 상품 조회
	List<ModalProduct> getModalProducts(List<Long> productIds, Long memberId) throws Exception;
	
	// [소비자] 교환 신청용: 상품의 전체 옵션 목록 조회 (mapper는 productOption)
	List<Map<String, Object>> getProductOptions(Long productId) throws Exception;
}
