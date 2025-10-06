package dao.admin;

import java.util.List;
import java.util.Map;

import dto.Event;
import dto.admin.SearchConditionDTO;

public interface EventDAO {
	
	Integer eventCount(SearchConditionDTO sc_DTO); // event 게시글 총 개수 
	List<Event> allEventList(Map<String, Object> listMap); // event 리스트 보기
	List<Event> searchEventList(SearchConditionDTO sc_DTO); // 검색된 event 리스트
	void eventViewCount(int num);
	int adminEventWrite(Event event); //이벤트 등록 
	
	

}
