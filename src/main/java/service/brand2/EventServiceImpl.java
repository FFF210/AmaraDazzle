package service.brand2;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.brand2.EventDAO;
import dao.brand2.EventDAOImpl;
import dto.Coupon;
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

		// insert 후 eventApplicationId가 DTO에 세팅돼야 함 (eventApplication.xml에
		// useGeneratedKeys)
		eventDAO.insertEventApplication(application);
		Long applicationId = application.getEventApplicationId();

		// 2. 이벤트 상품 등록
		if (form.getProductIds() != null && !form.getProductIds().isEmpty()) {
			for (int i = 0; i < form.getProductIds().size(); i++) {
				Map<String, Object> map = new HashMap<>();
				map.put("eventId", form.getEventId());
				map.put("productId", form.getProductIds().get(i));

				// 할인 이벤트라면 discount 정보도 추가
				if ("DISCOUNT".equals(form.getEventType())) {
					map.put("discountType", form.getDiscountTypes().get(i));
					map.put("discountValue", form.getDiscountValues().get(i));
				} else {
					map.put("discountType", null);
					map.put("discountValue", null);
				}

				// 상품별 업데이트
				eventDAO.updateProductForEvent(map); // product.event_id = eventId
			}
		}
	}

	// 신청하기 버튼 (단일 이벤트 조회)
	@Override
	public EventDetail getEventById(Long eventId) throws Exception {
		return eventDAO.selectEventById(eventId);
	}

	// 신청 시 coupon
	@Override
	public List<Coupon> getCouponsForEvent(Long eventId, Long brandId) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("eventId", eventId);
		params.put("brandId", brandId);
		return eventDAO.selectCouponsForEvent(params);
	}

	// 이벤트 종료 시 상품과 이벤트 관계 해제
	@Override
	public void resetProductsForEvent(Long eventId) throws Exception {
		eventDAO.resetProductsForEvent(eventId);
	}

	// 상세보기 버튼 (신청 정보+쿠폰/상품 JOIN 결과)
	@Override
	public EventDetail getEventDetailById(Map<String, Object> params) throws Exception {
		EventDetail detail = eventDAO.selectEventDetailById(params);
		List<Coupon> coupons = eventDAO.selectCouponsForEvent(params);
		detail.setCoupons(coupons); // EventDetail에 coupons 필드 필요
		return detail;
	}

	// 이벤트 취소 버튼 (취소 시, event_application row 삭제)
	@Override
	public void deleteEventApplication(Long eventApplicationId) throws Exception {
		eventDAO.deleteEventApplication(eventApplicationId);
	}

}
