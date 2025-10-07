package dao.consumer;

import java.util.List;
import java.util.Map;

import dto.Exchange;

public interface ExchangeDAO {
	
	// ================[소비자] 교환 신청 등록 ===================
    void insertExchange(Exchange exchange);
    
    // ================[소비자] 교환 목록 조회 (회원별) ===================
    List<Map<String, Object>> selectExchangeListByMemberId(Long memberId);
    
    // ================[소비자] 교환 상세 조회 ===================
    Map<String, Object> selectExchangeById(Long exchangeId);
    
    // ================[소비자] 주문 상품 상태 변경 ===================
    void updateOrderItemStatus(Map<String, Object> params);
    
    // ================[소비자] 특정 주문 상품의 교환 정보 조회 (중복 신청 체크) ===================
    Exchange selectExchangeByOrderItemId(Long orderItemId);
}
