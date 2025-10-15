package dao.brand2;

import java.util.List;
import java.util.Map;

import dto.Product;

public interface ProductDAO {
    // 브랜드별 이벤트용 상품 조회
    List<Product> selectAvailableProducts(Map<String, Object> params) throws Exception;
}
