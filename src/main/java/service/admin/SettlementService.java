package service.admin;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import dto.Settlement;

public interface SettlementService {

	Integer settlementCnt(Map<String, String> searchContent);	//정산할 건수 
	List<Settlement> settlementAllList(Integer p_no);	//정산 리스트 
	List<Settlement> settlementSearchList(Map<String, String> searchContent, Integer p_no);	//정산리스트(검색)
	int monthlyInsertSettle(LocalDate startDate, LocalDate endDate);	//매월 1일 전월 정산리스트 자동 인서트 
	int autoSettle(LocalDate startDate, LocalDate endDate);

}
