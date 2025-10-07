package dao.consumer;

import java.util.List;
import java.util.Map;

import dto.Returns;

public interface ReturnDAO {
	// ================[소비자] 반품 신청 등록 ===================
    void insertReturns(Returns returns);
    
    // ================[소비자] 반품 목록 조회 (회원별) ===================
    List<Map<String, Object>> selectReturnsListByMemberId(Long memberId);
    
    // ================[소비자] 반품 상세 조회 ===================
    Map<String, Object> selectReturnsById(Long returnsId);
    
    // ================[소비자] 주문 상품 상태 변경 ===================
    void updateOrderItemStatus(Map<String, Object> params);
    
    // ================[소비자] 특정 주문 상품의 반품 정보 조회 (중복 신청 체크) ===================
    Returns selectReturnsByOrderItemId(Long orderItemId);
}
