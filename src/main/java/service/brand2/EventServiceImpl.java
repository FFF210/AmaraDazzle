package service.brand2;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.brand2.EventDAO;
import dao.brand2.EventDAOImpl;
import dto.brand2.EventList;

public class EventServiceImpl implements EventService {

	private EventDAO eventDAO;

	public EventServiceImpl() {
		this.eventDAO = new EventDAOImpl();
	}

	// 이벤트 목록 조회
	@Override
	public Map<String, Object> getEventList(Map<String, Object> params) {
		List<EventList> eventList = eventDAO.selectEventList(params);

		// 총 상품 개수 조회
		int totalCount = eventDAO.selectEventCount(params);

		// 총 페이지 수 계산
		int limit = (int) params.getOrDefault("limit", 10);
		int totalPages = (int) Math.ceil((double) totalCount / limit);

		Map<String, Object> result = new HashMap<>();
		result.put("eventList", eventList);
		result.put("totalCount", totalCount);
		result.put("totalPages", totalPages);

		return result;
	}

}
