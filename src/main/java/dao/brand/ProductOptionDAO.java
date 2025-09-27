package dao.brand;

import java.util.List;

import dto.ProductOption;

public interface ProductOptionDAO {
	// 옵션 등록
	void insertOption(ProductOption option) throws Exception;

	// 특정 상품 옵션 목록
	List<ProductOption> selectOptionsByProductId(String productId) throws Exception;

	// 특정 상품 옵션 삭제
	void deleteOption(Long productId) throws Exception;
}
