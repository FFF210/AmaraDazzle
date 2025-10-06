package service.consumer;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.consumer.EventDAO;
import dao.consumer.EventDAOImpl;
import dto.Event;
import dto.consumer.EventDetail;
import dto.consumer.EventDetailProduct;

public class EventServiceImpl implements EventService {

	private EventDAO eventDAO;

	public EventServiceImpl() {
		eventDAO = new EventDAOImpl();
	}

	// 이벤트 목록 조회
	@Override
	public Map<String, Object> eventListByPage(Map<String, Object> params) throws Exception {
		List<Event> eventList = eventDAO.selectEventListForConsumer(params);

		// 총 상품 개수 조회
		int totalCount = eventDAO.selectEventCountForConsumer(params);

		// 총 페이지 수 계산
		int limit = (int) params.getOrDefault("limit", 9);
		int totalPages = (int) Math.ceil((double) totalCount / limit);

		Map<String, Object> result = new HashMap<>();
		result.put("eventList", eventList);
		result.put("totalCount", totalCount);
		result.put("totalPages", totalPages);

		return result;
	}

	// 이벤트 상세 조회
	@Override
	public EventDetail getEventDetail(Long eventId) throws Exception {
		return eventDAO.selectEventDetail(eventId);
	}

	// 이벤트 참여 상품 조회
	@Override
	public List<EventDetailProduct> getEventProducts(Long eventId) throws Exception {
		return eventDAO.selectEventDetailProducts(eventId);
	}

}
