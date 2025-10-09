package dao.consumer;

import java.util.List;
import java.util.Map;

import dto.ProductOption;

public interface ProductOptionDAO {
	//상품 상세페이지에서 드롭다운 보여주는 용도
	 List<ProductOption> selectProductOptionsByProductId(Long productId) throws Exception;
	 //체크아웃에서 선택된 옵션의 상세정보 
	 ProductOption selectProductOptionByOptionId(Long optionId) throws Exception;
	// 상품의 전체 옵션 목록 조회 (교환 신청용)
	 List<Map<String, Object>> getProductOptions(Long productId) throws Exception;
}
