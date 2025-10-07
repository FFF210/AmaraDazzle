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
		try {
            // 파라미터에서 eventId 가져오기
            String eventIdParam = request.getParameter("eventId");
            if (eventIdParam == null || eventIdParam.isBlank()) {
                response.sendRedirect(request.getContextPath() + "/brand2/eventList");
                return;
            }

            Long eventId = Long.parseLong(eventIdParam);

            // 단일 이벤트 정보 조회 (eventService → EventDAO.selectEventNamesByType)
            // 모든 이벤트명 중에서 해당 eventId 찾음
            Event selectedEvent = eventService.getEventById(eventId);

            if (selectedEvent == null) {
                response.sendRedirect(request.getContextPath() + "/brand2/eventList");
                return;
            }

            request.setAttribute("event", selectedEvent);

            // 신청 폼 페이지로 forward
            RequestDispatcher dispatcher = request.getRequestDispatcher("/brand2/eventForm.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/brand2/eventList?error=1");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            request.setCharacterEncoding("UTF-8");

            // 1. 폼 데이터 수집
            EventApplicationForm form = new EventApplicationForm();

            form.setEventId(Long.parseLong(request.getParameter("eventId")));
            form.setBrandId(1L); // ★ 세션 연동 필요시 교체

            form.setManagerName(request.getParameter("managerName"));
            form.setManagerTel(request.getParameter("managerTel"));
            form.setNote(request.getParameter("note"));

            // 상품코드 여러개
            String[] productArr = request.getParameterValues("productIds");
            if (productArr != null) {
                List<Long> productIds = new java.util.ArrayList<>();
                for (String pid : productArr) {
                    if (pid != null && !pid.isBlank()) {
                        productIds.add(Long.parseLong(pid));
                    }
                }
                form.setProductIds(productIds);
            }

            // 쿠폰 입력값
            form.setCname(request.getParameter("couponName"));

            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            if (startDateStr != null && !startDateStr.isBlank()
                    && endDateStr != null && !endDateStr.isBlank()) {

                LocalDate startLocal = LocalDate.parse(startDateStr);
                LocalDate endLocal = LocalDate.parse(endDateStr);

                form.setStartDateCoupon(Timestamp.valueOf(startLocal.atStartOfDay()));
                form.setEndDateCoupon(Timestamp.valueOf(endLocal.atTime(23, 59, 59)));
            }

            // 숫자값 처리
            String amount = request.getParameter("amount");
            if (amount != null && !amount.isBlank()) {
                form.setAmount(Integer.parseInt(amount));
            }

            String amountCondition = request.getParameter("amountCondition");
            if (amountCondition != null && !amountCondition.isBlank()) {
                form.setAmountCondition(amountCondition);
            }

            form.setProvision("개별지급"); 
            form.setWriterType("BRAND_ADMIN");
            form.setWriterId(form.getBrandId());

            // 2. 서비스 호출
            EventService eventService = new EventServiceImpl();
            eventService.applyEvent(form);

            // 3. 완료 페이지
            request.getRequestDispatcher("/brand2/eventComplete.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/brand2/eventList?error=1");
        }
    }
}
