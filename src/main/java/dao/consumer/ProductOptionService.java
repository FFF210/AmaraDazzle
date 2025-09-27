package dao.consumer;

import java.util.List;

import dto.ProductOption;

public interface ProductOptionService {
	List<ProductOption> getProductOptionsByProductId(Long productId) throws Exception;
}
