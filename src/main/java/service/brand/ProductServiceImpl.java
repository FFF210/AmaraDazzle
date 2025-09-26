package service.brand;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.brand.ProductDAO;
import dao.brand.ProductDAOImpl;
import dto.brand.ProductList;

public class ProductServiceImpl implements ProductService {
	
	private ProductDAO productDAO;
	
	public ProductServiceImpl() {
		productDAO = new ProductDAOImpl();
	}

	// 브랜드 상품 목록 조회
	@Override
	public Map<String, Object> productListByPage(Map<String, Object> params) throws Exception {
		// 상품 목록 조회
		List<ProductList> productList = productDAO.selectProductListForBrand(params); 
		
		// 총 상품 개수 조회
		int totalCount = productDAO.selectProductCountForBrand(params); 

        // 총 페이지 수 계산
        int limit = (int) params.getOrDefault("limit", 10);
        int totalPages = (int) Math.ceil((double) totalCount / limit);
        
        Map<String, Object> result = new HashMap<>();
        result.put("productList", productList);
        result.put("totalCount", totalCount);
        result.put("totalPages", totalPages);

        return result;
	}
}
