package dao.admin;

import java.util.List;
import java.util.Map;

import dto.Settlement;
import dto.admin.SearchConditionDTO;

public interface SettlementDAO {
	
	List<Settlement> getPendingSettlements(); // 미정산 판매자 리스트 조회
	int autoSettle(Map<String, String> map);
	
	Integer settlementCnt(SearchConditionDTO sc_DTO);	//정산할 건수 
	List<Settlement> settlementAllList(Map<String, Object> listMap);	//정산 리스트 
	List<Settlement> settlementSearchList(SearchConditionDTO sc_DTO);	//정산리스트(검색)
	int monthlyInsertSettle(Map<String, String> map);	//매월 1일 전월 정산리스트 자동 인서트 
}
