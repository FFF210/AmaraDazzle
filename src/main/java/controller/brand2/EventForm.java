package controller.brand2;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import dto.Event;
import dto.brand2.EventApplicationForm;
import service.brand2.EventService;
import service.brand2.EventServiceImpl;


/**
 * Servlet implementation class Event
 */
@WebServlet("/brand2/event")
public class EventForm extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public EventForm() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		EventService eventService = new EventServiceImpl();

		// Ajax: 이벤트명 목록 조회
		String action = request.getParameter("action");
		if ("names".equals(action)) {
			String type = request.getParameter("type");
			List<Event> eventNames = eventService.getEventNamesByType(type);

			response.setContentType("application/json; charset=UTF-8");
			JSONArray arr = new JSONArray();
			for (Event ev : eventNames) {
				JSONObject obj = new JSONObject();
				obj.put("eventId", ev.getEventId());
				obj.put("eventName", ev.getEventName());
				arr.add(obj);
			}
			response.getWriter().print(arr.toJSONString());
			return;
		}

		// DB에서 이벤트 종류 조회
		List<String> eventTypes = eventService.getEventTypes();

		request.setAttribute("eventTypes", eventTypes);

		// 이벤트 신청 페이지 이동
		RequestDispatcher dispatcher = request.getRequestDispatcher("/brand2/eventForm.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {

			// 1. 폼 데이터 수집
			EventApplicationForm form = new EventApplicationForm();

			// event_application
			form.setEventId(Long.parseLong(request.getParameter("eventId")));

			// 세션에서 brandId 꺼내기
//			HttpSession session = request.getSession();
//			Brand brand = (Brand) session.getAttribute("brand");
//			if (brand != null) {
//				form.setBrandId(brand.getBrandId());
//			} 
			form.setBrandId(1L);

			form.setManagerName(request.getParameter("managerName"));
			form.setManagerTel(request.getParameter("managerTel"));
			form.setNote(request.getParameter("note"));

			// productIds (상품코드 여러 개)
			String[] productArr = request.getParameterValues("productIds");
			if (productArr != null) {
				List<Long> productIds = new java.util.ArrayList<>();
				for (String pid : productArr) {
					productIds.add(Long.parseLong(pid));
				}
				form.setProductIds(productIds);
			}

			
			form.setCname(request.getParameter("couponName"));
			
			
			// 쿠폰 기간 (HTML input[type=date] → Timestamp 변환)
			String startDateStr = request.getParameter("startDate"); // "2025-09-26"
			String endDateStr = request.getParameter("endDate");

			if (startDateStr == null || endDateStr == null || startDateStr.isBlank() || endDateStr.isBlank()) {
				throw new IllegalArgumentException("쿠폰 기간 값이 비어 있습니다.");
			}

			LocalDate startLocal = LocalDate.parse(startDateStr);
			LocalDate endLocal = LocalDate.parse(endDateStr);

			form.setStartDateCoupon(Timestamp.valueOf(startLocal.atStartOfDay()));
			form.setEndDateCoupon(Timestamp.valueOf(endLocal.atTime(23, 59, 59)));
			// 끝나는 날은 보통 하루 끝(23:59:59)까지 포함시키는 경우가 많음

			form.setAmount(Integer.parseInt(request.getParameter("amount")));
			form.setAmountCondition(request.getParameter("amountCondition"));
			form.setProvision("개별지급"); // 기본값
			form.setWriterType("BRAND_ADMIN");
			form.setWriterId(form.getBrandId());

			// 2. 서비스 호출
			EventService eventService = new EventServiceImpl();
			eventService.applyEvent(form);

			// 3. 신청 완료 후 목록으로 리다이렉트
			request.getRequestDispatcher("/brand2/eventComplete.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/brand2/eventList.jsp?error=1");
		}

	}

}
