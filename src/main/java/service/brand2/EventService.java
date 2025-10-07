package service.brand2;

import java.util.Map;

import dto.Event;
import dto.brand2.EventApplicationForm;

public interface EventService {

	/* eventList */
	// 이벤트 목록 조회
	Map<String, Object> getEventList(Map<String, Object> params);

	/* eventForm */
	// 이벤트 신청
	void applyEvent(EventApplicationForm form);

	// 신청하기 버튼 (단일 이벤트 조회)
	Event getEventById(Long eventId);
}
