package service.consumer;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.consumer.ProductDAO;
import dao.consumer.ProductDAOImpl;
import dto.Product;
import dto.consumer.ProductPlan;

public class ProductServiceImpl implements ProductService {

	private ProductDAO productDAO;

	public ProductServiceImpl() {
		this.productDAO = new ProductDAOImpl();
	}

	// 상품 상세 페이지
	@Override
	public Product getProductDetail(Long productId) throws Exception {
		// 기본적인 비즈니스 로직
		if (productId == null || productId <= 0) {
			throw new IllegalArgumentException("유효하지 않은 상품 ID입니다.");
		}

		Product product = productDAO.selectProductByProductId(productId);

		if (product == null) {
			throw new Exception("상품을 찾을 수 없습니다.");
		}

		return product;

	}

	// [소비자] 기획상품 목록 조회
	@Override
	public Map<String, Object> productPlanListByPage(Map<String, Object> params) throws Exception {
		// 기획상품 목록 조회
		List<ProductPlan> productPlanList = productDAO.selectPlannedProducts(params);

		// 총 상품 개수 조회
		int totalCount = productDAO.selectPlannedProductsCount(params);

		// 총 페이지 수 계산
		int limit = (int) params.getOrDefault("limit", 16);
		int totalPages = (int) Math.ceil((double) totalCount / limit);

		Map<String, Object> result = new HashMap<>();
		result.put("productPlanList", productPlanList);
		result.put("totalCount", totalCount);
		result.put("totalPages", totalPages);

		return result;
	}

}
