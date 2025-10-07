package dao.brand2;

import java.util.List;
import java.util.Map;

import dto.Coupon;
import dto.Event;
import dto.EventApplication;
import dto.brand2.EventDetail;
import dto.brand2.EventList;

public interface EventDAO {

	/* eventList */

	// 이벤트 목록 조회
	List<EventList> selectEventList(Map<String, Object> params) throws Exception;

	// 이벤트 개수 조회
	public Integer selectEventCount(Map<String, Object> params) throws Exception;

	/* eventForm */

	// 1. 이벤트 신청 저장
	void insertEventApplication(EventApplication application) throws Exception;

	// 2-1. 이벤트 상품 여러 개 저장
	// params: eventId, brandId, productIds(List<Long>)
	void insertEventProducts(Map<String, Object> params) throws Exception;

	// 2-2. product.event_id 세팅
	void updateProductsEvent(Map<String, Object> params) throws Exception;

	// 3. 쿠폰 저장
	int insertCoupon(Coupon coupon) throws Exception;

	// 신청하기 버튼 (단일 이벤트 조회)
	Event selectEventById(Long eventId) throws Exception;
	
	// 이벤트 종료 시 product.event_id 해제
	void resetProductsForEvent(Long eventId) throws Exception;
	
	// 상세보기 버튼
	EventDetail selectEventDetailById(Long eventId) throws Exception;


}
