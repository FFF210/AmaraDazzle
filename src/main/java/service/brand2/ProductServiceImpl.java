package service.brand2;

import java.util.List;
import java.util.Map;

import dao.brand2.ProductDAO;
import dao.brand2.ProductDAOImpl;
import dto.Product;

public class ProductServiceImpl implements ProductService {
	private final ProductDAO productDAO = new ProductDAOImpl();

	@Override
	public List<Product> getAvailableProducts(Map<String, Object> params) throws Exception {
		System.out.println("[DEBUG] ├─ brandId : " + params.get("brandId"));
		System.out.println("[DEBUG] ├─ eventId : " + params.get("eventId"));

		List<Product> products = productDAO.selectAvailableProducts(params);

		// 조회 결과 확인
		if (products == null || products.isEmpty()) {
			System.out.println("[DEBUG] 조회된 상품이 없습니다.");
		} else {
			System.out.println("[DEBUG] 조회된 상품 개수 : " + products.size());
			for (Product p : products) {
				System.out.printf("[DEBUG]   - 상품ID: %d | 상품명: %s | eventId: %s%n", p.getProductId(),
						p.getName() != null ? p.getName() : "(null)", p.getEventId() != null ? p.getEventId() : "null");
			}
		}

		return products;
	}
}
