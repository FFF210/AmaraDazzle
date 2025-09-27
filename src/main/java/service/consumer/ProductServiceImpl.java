package service.consumer;

import dao.consumer.ProductDAO;
import dao.consumer.ProductDAOImpl;
import dto.Product;

public class ProductServiceImpl implements ProductService {
	
	 private ProductDAO productDAO;
	 
	 public ProductServiceImpl() {
	        this.productDAO = new ProductDAOImpl();
	    }
	 
	//상품 상세 페이지
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

}
