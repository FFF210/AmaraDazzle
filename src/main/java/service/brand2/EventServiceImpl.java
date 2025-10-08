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
import dto.brand2.EventDetail;
import dto.brand2.EventList;

public class EventServiceImpl implements EventService {

	private EventDAO eventDAO;

	public EventServiceImpl() {
		this.eventDAO = new EventDAOImpl();
	}

	/* ===== eventList ===== */
	@Override
	public Map<String, Object> getEventList(Map<String, Object> params) throws Exception {
		// 1. 이벤트 목록 조회
		List<EventList> eventList = eventDAO.selectEventList(params);

		// 2. 총 개수
		int totalCount = eventDAO.selectEventCount(params);

		// 3. 총 페이지 수 계산
		int limit = (int) params.getOrDefault("limit", 10);
		int totalPages = (int) Math.ceil((double) totalCount / limit);

		// 4. 결과 맵 구성
		Map<String, Object> result = new HashMap<>();
		result.put("eventList", eventList);
		result.put("totalCount", totalCount);
		result.put("totalPages", totalPages);
		return result;
	}

	/* ===== eventForm ===== */
	@Override
	public void applyEvent(EventApplicationForm form) throws Exception {
		// 1. 이벤트 신청 저장
		EventApplication application = new EventApplication();
		application.setEventId(form.getEventId());
		application.setBrandId(form.getBrandId());
		application.setManagerName(form.getManagerName());
		application.setManagerTel(form.getManagerTel());
		application.setNote(form.getNote());
		eventDAO.insertEventApplication(application);

		// 2. 이벤트 상품 등록
		if (form.getProductIds() != null && !form.getProductIds().isEmpty()) {
			Map<String, Object> map = new HashMap<>();
			map.put("eventId", form.getEventId());
			map.put("brandId", form.getBrandId());
			map.put("productIds", form.getProductIds());
			//eventDAO.insertEventProducts(map); // event_product: brand_id, product_id
			eventDAO.updateProductsEvent(map); // product.event_id = eventId
		}

		// 3. 쿠폰 발급
		if (form.getCname() != null && !form.getCname().isEmpty()) {
			Coupon coupon = new Coupon();
			coupon.setCname(form.getCname());
			coupon.setStartDate(form.getStartDateCoupon());
			coupon.setEndDate(form.getEndDateCoupon());
			coupon.setAmount(form.getAmount());
			coupon.setAmountCondition(form.getAmountCondition());

			coupon.setProvision(form.getProvision() != null ? form.getProvision() : "");
			coupon.setWriterType(form.getWriterType() != null ? form.getWriterType() : "BRAND");
			coupon.setWriterId(form.getWriterId() != null ? form.getWriterId() : form.getBrandId());

			coupon.setReason("event_application:" + application.getEventApplicationId());
			eventDAO.insertCoupon(coupon);
		}
	}

	// 신청하기 버튼 (단일 이벤트 조회)
	@Override
	public Event getEventById(Long eventId) throws Exception {
		return eventDAO.selectEventById(eventId);
	}
	
	@Override
	public void resetProductsForEvent(Long eventId) throws Exception {
	    eventDAO.resetProductsForEvent(eventId);
	}

	// 상세보기 버튼
	@Override
	public EventDetail getEventDetailById(Long eventId) throws Exception {
	    return eventDAO.selectEventDetailById(eventId);
	}


}
