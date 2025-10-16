package service.brand2;

import java.util.List;
import java.util.Map;

import dto.Coupon;
import dto.brand2.EventApplicationForm;
import dto.brand2.EventDetail;

public interface EventService {

	/* eventList */
	// 이벤트 목록 조회
	Map<String, Object> getEventList(Map<String, Object> params) throws Exception;

	/* eventForm */
	// 이벤트 신청
	void applyEvent(EventDetail form) throws Exception;

	// 신청하기 버튼 (단일 이벤트 조회)
	EventDetail getEventById(Long eventId) throws Exception;
	
	// 신청 시 coupon
	List<Coupon> getCouponsForEvent(Long eventId, Long brandId) throws Exception;

	// 이벤트 종료 시 상품 해제
	void resetProductsForEvent(Long eventId) throws Exception;

	// 이벤트 상세보기 버튼
	EventDetail getEventDetailById(Map<String, Object> params) throws Exception;

	// 이벤트 취소 버튼
	void deleteEventApplication(Long eventApplicationId) throws Exception;
}
