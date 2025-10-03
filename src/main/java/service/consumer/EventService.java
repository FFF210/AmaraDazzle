package service.consumer;

import java.util.List;
import java.util.Map;

import dto.consumer.EventDetail;
import dto.consumer.EventDetailProduct;

public interface EventService {
	// 이벤트 목록 조회
	Map<String, Object> eventListByPage(Map<String, Object> params) throws Exception;

	// 이벤트 상세 조회
	EventDetail getEventDetail(Long eventId) throws Exception;

	// 이벤트 참여 상품 조회
	List<EventDetailProduct> getEventProducts(Long eventId) throws Exception;
}
