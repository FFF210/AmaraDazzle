package service.admin;

import java.util.List;
import java.util.Map;

import dao.admin.EventDAO;
import dao.admin.EventDAOImpl;
import dto.Event;
import dto.admin.SearchConditionDTO;
import util.Paging;
import util.SearchUtil;

public class EventServiceImpl implements EventService {
	private EventDAO e_dao;

	public EventServiceImpl() {
		e_dao = new EventDAOImpl();
	}

	private Paging m_pg = new Paging();
	private SearchUtil search = new SearchUtil();
	
	// event 게시글 총 개수
	@Override
	public Integer eventCount(Map<String, String> cntMap) {
	    SearchConditionDTO sc_DTO = search.buildSearchDTO(cntMap);
	    return e_dao.eventCount(sc_DTO);
	}

	// event 리스트 보기
	@Override
	public List<Event> allEventList(int p_no) {
		Map<String, Object> listMap = m_pg.paging(p_no);

		List<Event> allEventList = e_dao.allEventList(listMap);
		return allEventList;
	}

	// 검색된 event 리스트
	@Override
	public List<Event> searchEventList(Map<String, String> searchContent, int p_no) {
	    Map<String, Object> searchlistMap = m_pg.paging(p_no);
	    SearchConditionDTO sc_DTO = search.buildSearchDTO(searchContent);

	    // 페이징 추가 정보 세팅
	    sc_DTO.setStart_p((Integer) searchlistMap.get("start_p"));
	    sc_DTO.setPost_ea((Integer) searchlistMap.get("post_ea"));

	    return e_dao.searchEventList(sc_DTO);
	}

	//event 등록 
	@Override
	public int adminEventWrite(Event event) {
		String type = event.getEventType().trim();
		if(type == "쿠폰") {
			event.setEventType("COUPON");
		}else if(type == "할인") {
			event.setEventType("DISCOUNT");
		}else if(type == "체험단") {
			event.setEventType("EXPERIENCE");
		}else if(type == "AD's PICK") {
			event.setEventType("PICK");
		} else {
			event.setEventType("ETC");
		}

		return e_dao.adminEventWrite(event);
	}

}
