package service.brand2;

import java.util.List;
import java.util.Map;

import dto.Event;
import dto.brand2.EventApplicationForm;
import dto.brand2.EventList;

public interface EventService {
	// 이벤트 목록 조회
    List<EventList> getEventList(Map<String, Object> params);

    /**
     * 이벤트 신청 + 상품 등록 + 쿠폰 발급까지 처리
     * @param form 이벤트 신청 폼 데이터
     */
    void applyEvent(EventApplicationForm form);
    
    // 이벤트 종류
	List<String> getEventTypes();
	
	// 이벤트 종류별 이벤트명 목록
	List<Event> getEventNamesByType(String type);
}
