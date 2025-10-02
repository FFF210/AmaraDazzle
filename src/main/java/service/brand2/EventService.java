package service.brand2;

import java.util.List;
import java.util.Map;

import dto.brand2.EventList;

public interface EventService {
	// 이벤트 목록 조회
    List<EventList> getEventList(Map<String, Object> params);

}
