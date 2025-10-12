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

	// ========== event ==========
	EventDetail selectEventById(Long eventId) throws Exception;
    EventDetail selectEventDetailById(Map<String, Object> params) throws Exception; // event_id, brand_id
    void resetProductsForEvent(Long eventId) throws Exception;

    // ========== event_application ==========
    void insertEventApplication(EventApplication application) throws Exception;
    void updateProductsEvent(Map<String, Object> params) throws Exception;
    void deleteEventApplication(Long eventApplicationId) throws Exception;

    // ========== coupon ==========
    int insertCoupon(Coupon coupon) throws Exception;

}
