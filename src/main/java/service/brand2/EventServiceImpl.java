package service.brand2;

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
	public List<EventList> getEventList(Map<String, Object> params) {
		return eventDAO.selectEventList(params);
	}

}
