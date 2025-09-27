package service.consumer;

import dto.Product;

public interface ProductService {
	//상품 상세 
	Product getProductDetail(Long productId) throws Exception;
}
