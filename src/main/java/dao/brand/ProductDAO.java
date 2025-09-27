package dao.brand;

import java.util.List;
import java.util.Map;

import dto.brand.ProductDetail;
import dto.brand.ProductList;

public interface ProductDAO {
	// 상품 목록 조회
	List<ProductList> selectProductListForBrand(Map<String, Object> params) throws Exception;

	// 상품 개수 조회
	Integer selectProductCountForBrand(Map<String, Object> params) throws Exception;

	// 상품 재고 변경
	void updateStockForBrand(Map<String, Object> params) throws Exception;

	// 상품 공개 여부 토글
	void toggleVisibilityForBrand(long productId) throws Exception;

	// 세일 등록
	void registerSaleForBrand(Map<String, Object> params) throws Exception;

	// 단일 상품 단일 조회
	ProductDetail selectProductForBrand(long productId) throws Exception;
}
