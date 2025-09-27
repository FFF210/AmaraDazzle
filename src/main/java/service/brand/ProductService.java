package service.brand;

import java.util.Map;

import dto.brand.ProductDetail;

public interface ProductService {
	// 브랜드 상품 목록 조회
	Map<String, Object> productListByPage(Map<String, Object> params) throws Exception;

	// 상품 재고 변경
	void updateStock(Map<String, Object> params) throws Exception;

	// 상품 공개 여부 토글
	void toggleVisibility(long productId) throws Exception;

	// 세일 등록
	void registerSale(Map<String, Object> params) throws Exception;

	// 단일 상품 단일 조회
	ProductDetail productDetail(long productId) throws Exception;
}
