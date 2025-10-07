package service.consumer;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.consumer.ExchangeDAO;
import dao.consumer.ExchangeDAOImpl;
import dto.Exchange;

public class ExchangeServiceImpl implements ExchangeService {
	
	private ExchangeDAO exchangeDAO = new ExchangeDAOImpl();

	// ================[소비자] 교환 신청 ===================
	@Override
	public void applyExchange(Exchange exchange) throws Exception {
		// 1. 중복 신청 체크
        if (!canApplyExchange(exchange.getOrderItemId())) {
            throw new Exception("이미 교환 신청된 상품입니다.");
        }
        
        // 2. 교환 신청 등록
        exchangeDAO.insertExchange(exchange);
        
        // 3. 주문 상품 상태를 EXCHANGE_REQUESTED로 변경
        Map<String, Object> params = new HashMap<>();
        params.put("orderItemId", exchange.getOrderItemId());
        params.put("status", "EXCHANGE_REQUESTED");
        exchangeDAO.updateOrderItemStatus(params);		
	}

	// ================[소비자] 교환 목록 조회 ===================
	@Override
	public List<Map<String, Object>> getExchangeListByMemberId(Long memberId) throws Exception {
		 return exchangeDAO.selectExchangeListByMemberId(memberId);
	}

	// ================[소비자] 교환 상세 조회 ===================
	@Override
	public Exchange getExchangeById(Long exchangeId) throws Exception {
		Exchange exchange = exchangeDAO.selectExchangeById(exchangeId);
        if (exchange == null) {
            throw new Exception("교환 정보를 찾을 수 없습니다.");
        }
        return exchange;
	}

	// ================[소비자] 교환 신청 가능 여부 확인 (중복 체크) ===================
	@Override
	public boolean canApplyExchange(Long orderItemId) throws Exception {
		Exchange existingExchange = exchangeDAO.selectExchangeByOrderItemId(orderItemId);
        // 기존 교환 신청이 없으면 true (신청 가능)
        return existingExchange == null;
	}

}
