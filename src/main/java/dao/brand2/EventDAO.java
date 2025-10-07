package dao.brand2;

import java.util.List;
import java.util.Map;

import dto.Coupon;
import dto.Event;
import dto.EventApplication;
import dto.brand2.EventList;

public interface EventDAO {

	/* eventList */

	// 이벤트 목록 조회
	List<EventList> selectEventList(Map<String, Object> params);

	// 이벤트 개수 조회
	public Integer selectEventCount(Map<String, Object> params);

	/* eventForm */

	// 1. 이벤트 신청 저장
	int insertEventApplication(EventApplication application);

	// 2-1. 이벤트 상품 여러 개 저장
	// params: eventId, brandId, productIds(List<Long>)
	int insertEventProducts(Map<String, Object> params);

	// 2-2. product.event_id 세팅
	int updateProductsEvent(Map<String, Object> params);

	// 3. 쿠폰 저장
	int insertCoupon(Coupon coupon);

	// 신청하기 버튼 (단일 이벤트 조회)
	Event selectEventById(Long eventId);

}
