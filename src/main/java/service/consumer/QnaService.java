package service.consumer;

import java.util.List;
import java.util.Map;

import dto.Qna;

public interface QnaService {
	// 상품별 문의 목록 조회
	List<Qna> getQnasByProductId(Long productId) throws Exception;
	// 페이지네이션용 문의 조회
	List<Map<String, Object>> getQnasByProductIdWithPaging(Long productId, int page, int pageSize) throws Exception;		
	// 상품별 문의 개수 조회
    Integer getQnaCount(Long productId) throws Exception;
    // 상품 문의 등록 (void 반환)
    void createQna(Qna qna)throws Exception;
}
