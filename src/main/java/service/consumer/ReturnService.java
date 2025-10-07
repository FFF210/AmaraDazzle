package service.consumer;

import java.util.List;
import java.util.Map;

import dto.Returns;

public interface ReturnService {
	// ================[소비자] 반품 신청 ===================
    // 반품 테이블 INSERT + order_item 상태를 RETURN_REQUESTED로 변경
    void applyReturns(Returns returns) throws Exception;
    
    // ================[소비자] 반품 목록 조회 ===================
    List<Map<String, Object>> getReturnsListByMemberId(Long memberId) throws Exception;
    
    // ================[소비자] 반품 상세 조회 ===================
    Returns getReturnsById(Long returnsId) throws Exception;
    
    // ================[소비자] 반품 신청 가능 여부 확인 (중복 체크) ===================
    boolean canApplyReturns(Long orderItemId) throws Exception;

}
