package service.brand;

import java.util.Map;

public interface SettlementService {
	// 브랜드 정산 목록 조회
	public Map<String, Object> settlementListByPage(Map<String, Object> params) throws Exception;
}
