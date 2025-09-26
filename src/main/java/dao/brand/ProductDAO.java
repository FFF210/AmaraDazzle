package dao.brand;

import java.util.List;
import java.util.Map;

import dto.brand.ProductList;

public interface ProductDAO {
	// 상품 목록 조회
	List<ProductList> selectProductListForBrand(Map<String, Object> params) throws Exception;
	
	// 상품 개수 조회
	Integer selectProductCountForBrand(Map<String, Object> params) throws Exception;
}
