package service.brand2;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.brand2.EventDAO;
import dao.brand2.EventDAOImpl;
import dto.Coupon;
import dto.Event;
import dto.EventApplication;
import dto.brand2.EventApplicationForm;
import dto.brand2.EventList;

public class EventServiceImpl implements EventService {

	private EventDAO eventDAO;
	
	public EventServiceImpl() {
		this.eventDAO = new EventDAOImpl();
	}
	
	// 이벤트 목록 조회
	@Override
	public List<EventList> getEventList(Map<String, Object> params) {
		return eventDAO.selectEventList(params);
	}

	@Override
	public void applyEvent(EventApplicationForm form) {

        // 1. 이벤트 신청 저장
        EventApplication application = new EventApplication();
        application.setEventId(form.getEventId());
        application.setBrandId(form.getBrandId());
        application.setManagerName(form.getManagerName());
        application.setManagerTel(form.getManagerTel());
        application.setNote(form.getNote());
        eventDAO.insertEventApplication(application);

        // 2. 이벤트 상품 등록 (여러 개)
        if (form.getProductIds() != null && !form.getProductIds().isEmpty()) {
            Map<String,Object> map = new HashMap<>();
            map.put("applicationId", application.getEventApplicationId());
            map.put("productIds", form.getProductIds());
            eventDAO.insertEventProducts(map);
        }

        // 3. 쿠폰 발급 (application_id → reason 칼럼에 기록)
        Coupon coupon = new Coupon();
        coupon.setCname(form.getCname());
        coupon.setStartDate(form.getStartDateCoupon());
        coupon.setEndDate(form.getEndDateCoupon());
        coupon.setAmount(form.getAmount());
        coupon.setAmountCondition(form.getAmountCondition());
        coupon.setProvision(form.getProvision());
        coupon.setWriterType(form.getWriterType());
        coupon.setWriterId(form.getWriterId());
        coupon.setReason("event_application:" + application.getEventApplicationId());
        eventDAO.insertCoupon(coupon);
    }
	
	// 이벤트 종류
	public List<String> getEventTypes() {
	    return eventDAO.selectEventTypes();
	}

	@Override
	public List<Event> getEventNamesByType(String type) {
		return eventDAO.selectEventNamesByType(type);
	}
	
	
	

}
