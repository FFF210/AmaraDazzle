package dao.consumer;

import java.util.List;

import dto.ProductOption;

public class ProductOptionServiceImpl implements ProductOptionService {
	
	 private ProductOptionDAO productOptionDAO;
	    
	    public ProductOptionServiceImpl() {
	        this.productOptionDAO = new ProductOptionDAOImpl();
	    }

	@Override
	public List<ProductOption> getProductOptionsByProductId(Long productId) throws Exception {
		if (productId == null || productId <= 0) {
            throw new IllegalArgumentException("유효하지 않은 상품 ID입니다.");
        }
        
        List<ProductOption> options = productOptionDAO.selectProductOptionsByProductId(productId);
        
        return options; // 빈 리스트라도 반환
	}

}
