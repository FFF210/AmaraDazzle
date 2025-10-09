package dao.admin;

import java.util.List;

import dto.Settlement;

public interface SettlementDAO {
	
	List<Settlement> getPendingSettlements(); // 미정산 판매자 리스트 조회
	int settleAll();   // 정산 처리 (정산 완료 상태로 업데이트)
	int autoSettle();
}
