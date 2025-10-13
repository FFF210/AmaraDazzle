package service.admin;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.admin.SettlementDAO;
import dao.admin.SettlementDAOImpl;
import dto.Settlement;
import dto.admin.SearchConditionDTO;
import util.Paging;
import util.SearchUtil;

public class SettlementServiceImpl implements SettlementService{
	private SettlementDAO settle_dao;

	public SettlementServiceImpl() {
		settle_dao = new SettlementDAOImpl();
	}

	private Paging m_pg = new Paging();
	private SearchUtil search = new SearchUtil();

	//정산할 건수 
	@Override
	public Integer settlementCnt(Map<String, String> cntMap) {
		SearchConditionDTO sc_DTO = search.buildSearchDTO(cntMap);
	    return settle_dao.settlementCnt(sc_DTO);
	}
	
	//정산 리스트 
	@Override
	public List<Settlement> settlementAllList(Integer p_no) {
		Map<String, Object> listMap = m_pg.paging(p_no);

		List<Settlement> settlementAllList = settle_dao.settlementAllList(listMap);
		return settlementAllList;
	}
	
	//정산리스트(검색)
	@Override
	public List<Settlement> settlementSearchList(Map<String, String> searchContent, Integer p_no) {
		Map<String, Object> searchlistMap = m_pg.paging(p_no);
	    SearchConditionDTO sc_DTO = search.buildSearchDTO(searchContent);

	    // 페이징 추가 정보 세팅
	    sc_DTO.setStart_p((Integer) searchlistMap.get("start_p"));
	    sc_DTO.setPost_ea((Integer) searchlistMap.get("post_ea"));

	    return settle_dao.settlementSearchList(sc_DTO);
	}
	
	//매달 1일에 전월 정산자료 인서트 
	@Override
	public int monthlyInsertSettle(LocalDate startDate, LocalDate endDate) {
		Map<String, String> map = new HashMap<>();
		map.put("startDate", startDate + "00:00:00");
		map.put("endDate", endDate + "23:59:59");
		
		int result = settle_dao.monthlyInsertSettle(map);
		return result;
		
	}
	
	
	// 자동정산 (로그 출력용)
	public int autoSettle(LocalDate startDate, LocalDate endDate) {
		Map<String, String> map = new HashMap<>();
		map.put("startDate", startDate + "00:00:00");
		map.put("endDate", endDate + "23:59:59");
		
		int result = settle_dao.autoSettle(map);
		return result;
	}
	

}
