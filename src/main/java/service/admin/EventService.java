package service.admin;

import java.util.List;
import java.util.Map;

import dto.Event;

public interface EventService {
	
	Integer eventCount(Map<String, String> searchContent); // event 게시글 총 개수
	List<Event> allEventList(int p_no); // event 리스트 보기
	List<Event> searchEventList(Map<String, String> searchContent, int p_no); // 검색된 event 리스트 
	int adminEventWrite(Event event); //event 등록

}
