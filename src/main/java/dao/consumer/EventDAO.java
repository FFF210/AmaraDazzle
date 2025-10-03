package dao.consumer;

import java.util.List;
import java.util.Map;

import dto.Event;
import dto.consumer.EventDetail;
import dto.consumer.EventDetailProduct;

public interface EventDAO {
	// 이벤트 목록 조회
	List<Event> selectEventListForConsumer(Map<String, Object> params) throws Exception;

	// 이벤트 개수 조회
	Integer selectEventCountForConsumer(Map<String, Object> params) throws Exception;

	// 이벤트 상세 조회
	EventDetail selectEventDetail(Long eventId) throws Exception;

	// 이벤트 참여 상품 조회
	List<EventDetailProduct> selectEventDetailProducts(Long eventId) throws Exception;

}
