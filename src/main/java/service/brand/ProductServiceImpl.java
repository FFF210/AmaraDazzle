package service.brand;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.brand.ProductDAO;
import dao.brand.ProductDAOImpl;
import dto.brand.ProductDetail;
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

	// 상품 재고 변경
	@Override
	public void updateStock(Map<String, Object> params) throws Exception {
		if (params == null || !params.containsKey("productId") || !params.containsKey("newStock")) {
			throw new IllegalArgumentException("재고 변경을 위한 productId, newStock 값이 필요합니다.");
		}
		productDAO.updateStockForBrand(params);

	}

	// 상품 공개 여부 토글
	@Override
	public void toggleVisibility(long productId) throws Exception {
		if (productId <= 0) {
			throw new IllegalArgumentException("상품 ID가 유효하지 않습니다.");
		}
		productDAO.toggleVisibilityForBrand(productId);
	}

	// 세일 등록
	@Override
	public void registerSale(Map<String, Object> params) throws Exception {
		if (params == null || !params.containsKey("productIds") || !params.containsKey("discountType")
				|| !params.containsKey("discountValue") || !params.containsKey("startDate")
				|| !params.containsKey("endDate")) {
			throw new IllegalArgumentException("세일 등록에 필요한 값이 누락되었습니다.");
		}
		productDAO.registerSaleForBrand(params);
	}

	// 단일 상품 단일 조회
	@Override
	public ProductDetail productDetail(long productId) throws Exception {
		return productDAO.selectProductForBrand(productId);
	}

}
