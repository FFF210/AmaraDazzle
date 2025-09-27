package dao.consumer;

import java.util.List;

import dto.ProductOption;

public interface ProductOptionDAO {
	 List<ProductOption> selectProductOptionsByProductId(Long productId) throws Exception;
}
