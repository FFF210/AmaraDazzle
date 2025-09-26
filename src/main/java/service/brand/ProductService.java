package service.brand;

import java.util.Map;

public interface ProductService {
	// 브랜드 상품 목록 조회
	Map<String, Object> productListByPage(Map<String, Object> params) throws Exception;
}
