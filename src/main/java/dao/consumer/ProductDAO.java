package dao.consumer;

import dto.Product;

public interface ProductDAO {
	Product selectProductByProductId(Long productId) throws Exception;
}
