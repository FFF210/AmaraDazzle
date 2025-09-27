package service.brand;

import java.util.List;

import dto.ProductOption;

public interface ProductOptionService {
	// 옵션 등록
	void addOption(ProductOption option) throws Exception;

	// 특정 상품 옵션 목록
	List<ProductOption> getOptions(String productId) throws Exception;

	// 특정 상품 옵션 삭제
	void deleteOption(Long productId) throws Exception;
}
