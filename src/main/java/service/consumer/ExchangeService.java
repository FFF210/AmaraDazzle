package service.consumer;

import java.util.List;
import java.util.Map;

import dto.Exchange;

public interface ExchangeService {
	// ================[소비자] 교환 신청 ===================
    // 교환 테이블 INSERT + order_item 상태를 EXCHANGE_REQUESTED로 변경
    void applyExchange(Exchange exchange) throws Exception;
    
    // ================[소비자] 교환 목록 조회 ===================
    List<Map<String, Object>> getExchangeListByMemberId(Long memberId) throws Exception;
    
    // ================[소비자] 교환 상세 조회 ===================
    Exchange getExchangeById(Long exchangeId) throws Exception;
    
    // ================[소비자] 교환 신청 가능 여부 확인 (중복 체크) ===================
    boolean canApplyExchange(Long orderItemId) throws Exception;
}
