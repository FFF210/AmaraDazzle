package service.brand;

public interface ProductFilterMapService {
	// 필터 매핑 등록
	void insertProductFilter(Long productId, Long filterId) throws Exception;

	// 특정 상품의 필터 매핑 삭제
	void deleteProductFilters(Long productId) throws Exception;
}
