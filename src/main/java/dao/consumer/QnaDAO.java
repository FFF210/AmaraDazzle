package dao.consumer;

import java.util.List;
import java.util.Map;

import dto.Qna;

public interface QnaDAO {
	// 상품별 문의 목록 조회
	List<Qna> selectQnasByProductId(Long productId) throws Exception;
	// 페이지네이션용 문의 목록 조회
	List<Qna> selectQnasByProductIdWithPaging(Map<String, Object> params) throws Exception;
	//상품별 문의 개수 조회
    Integer getQnaCountByProductId(Long productId) throws Exception;
 // 상품 문의 등록
    void insertQna(Qna qna) throws Exception;
}
