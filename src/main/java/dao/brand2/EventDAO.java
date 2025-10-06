package dao.brand2;

import java.util.List;
import java.util.Map;

import dto.Coupon;
import dto.Event;
import dto.EventApplication;
import dto.brand2.EventList;

public interface EventDAO {
	// 이벤트 목록 조회
	List<EventList> selectEventList(Map<String, Object> params);

    // 1. 이벤트 신청 저장
    int insertEventApplication(EventApplication application);

    // 2. 이벤트 상품 여러 개 저장
    int insertEventProducts(Map<String, Object> params);

    // 3. 쿠폰 저장
    int insertCoupon(Coupon coupon);
    
    // 이벤트 종류
    List<String> selectEventTypes();
    
    // 이벤트명
    List<Event> selectEventNamesByType(String type);
	// 이벤트 개수 조회
	public Integer selectEventCount(Map<String, Object> params);
}
