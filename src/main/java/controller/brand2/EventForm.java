package controller.brand2;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.brand2.ProductDAO;
import dao.brand2.ProductDAOImpl;
import dto.Brand;
import dto.Coupon;
import dto.Product;
import dto.brand2.EventDetail;
import service.brand2.EventService;
import service.brand2.EventServiceImpl;
import service.brand2.ProductService;
import service.brand2.ProductServiceImpl;

@WebServlet("/brand2/event")
public class EventForm extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public EventForm() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		EventService eventService = new EventServiceImpl();

		try {

			HttpSession session = request.getSession(false);

			// 세션 없거나 브랜드 정보 없음 → 로그인 페이지로 리다이렉트
			if (session == null || session.getAttribute("brand") == null) {
				response.sendRedirect(request.getContextPath() + "/brand/login");
				return;
			}
			Brand brand = (Brand) session.getAttribute("brand");
			Long brandId = brand.getBrandId();

			// 파라미터에서 eventId 가져오기
			String eventIdParam = request.getParameter("eventId");
			if (eventIdParam == null || eventIdParam.isBlank()) {
				response.sendRedirect(request.getContextPath() + "/brand2/eventList");
				return;
			}

			Long eventId = Long.parseLong(eventIdParam);

			// 1. 단일 이벤트 정보 조회 (eventService → EventDAO.selectEventNamesByType)
			EventDetail selectedEvent = eventService.getEventById(eventId);
			// 모든 이벤트명 중에서 해당 eventId 찾음
			if (selectedEvent == null) {
				response.sendRedirect(request.getContextPath() + "/brand2/eventList");
				return;
			}

			request.setAttribute("event", selectedEvent);

			// 2. 쿠폰 목록 조회 (brand_id + event_id)
			if ("COUPON".equals(selectedEvent.getEventType())) {
				List<Coupon> eventCoupons = eventService.getCouponsForEvent(eventId, brandId);
				request.setAttribute("eventCoupons", eventCoupons);

			}

			// 3. DISCOUNT / EXPERIENCE / PICK → 상품 목록 조회
			if ("DISCOUNT".equals(selectedEvent.getEventType()) || "EXPERIENCE".equals(selectedEvent.getEventType())
					|| "PICK".equals(selectedEvent.getEventType())) {

				ProductDAO productDAO = new ProductDAOImpl();
				// 상품 목록 조회 (내 브랜드 + event_id IS NULL 조건)
				Map<String, Object> param = new HashMap<>();
				param.put("brandId", brandId);
				param.put("eventId", eventId);

				System.out.print("EventForm - 상품 목록 조회 디버깅" + brandId);
				System.out.print("EventForm - 상품 목록 조회 디버깅" + eventId);

				ProductService productService = new ProductServiceImpl();
				List<Product> products = productService.getAvailableProducts(param);

				System.out.print("EventForm - 상품 목록 조회 디버깅" + products);

				request.setAttribute("products", products);

			}

			// 신청 폼 페이지로 forward

			RequestDispatcher dispatcher = request.getRequestDispatcher("/brand2/eventForm.jsp");
			dispatcher.forward(request, response);
			return; // ✅ forward 후 즉시 종료 (이후 코드 실행 방지)
		} catch (Exception e) {
			e.printStackTrace();
			if (!response.isCommitted()) { // ✅ 커밋 전일 때만 redirect
				response.sendRedirect(request.getContextPath() + "/brand2/eventList?error=1");
			} else {
			}
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		 System.out.println("🔥 Controller 진입됨");
		request.setCharacterEncoding("utf-8");
		try {
			
			System.out.println("폼 요청 들어옴");
			
			// 세션에서 브랜드 정보 가져오기
			HttpSession session = request.getSession(false);
			if (session == null || session.getAttribute("brand") == null) {
				response.sendRedirect(request.getContextPath() + "/brand/login");
				return;
			}
			Brand brand = (Brand) session.getAttribute("brand");
			Long brandId = brand.getBrandId();

			// 1. 폼 데이터 수집
			EventDetail form = new EventDetail();

			form.setBrandId(brandId);
			form.setEventId(Long.parseLong(request.getParameter("eventId")));
			form.setEventType(request.getParameter("eventType"));
			form.setManagerName(request.getParameter("managerName"));
			form.setManagerTel(request.getParameter("managerTel"));
			form.setNote(request.getParameter("note"));

			// 상품코드 여러개
			String[] productArr = request.getParameterValues("productId");
			if (productArr != null) {
				List<Long> productIdList = new java.util.ArrayList<>();
				for (String pid : productArr) {
					if (pid != null && !pid.isBlank()) {
						productIdList.add(Long.parseLong(pid));
					}
				}
				form.setProductIdList(productIdList);   // ✅ DTO와 이름 일치
			}

			// 할인 이벤트인 경우 discountType[], discountValue[] 처리가 아니라 일괄처리 ㅎㅎ
			String discountType = request.getParameter("discountType");
			
			// BigDecimal으로 변환하기
			String discountValueParam = request.getParameter("discountValue");
			BigDecimal discountValue = BigDecimal.ZERO; // 기본값 0

			if (discountValueParam != null && !discountValueParam.isBlank()) {
			    try {
			        discountValue = new BigDecimal(discountValueParam);
			    } catch (NumberFormatException e) {
			        // 변환 실패 시 예외 처리 (로그 남기기 등)
			        e.printStackTrace();
			    }
			}
			
			form.setDiscountType(discountType);
			form.setDiscountValue(discountValue);
			
			
			System.out.println("productArr: " + Arrays.toString(request.getParameterValues("productId")));
			System.out.println("discountType: " + request.getParameter("discountType"));
			System.out.println("discountValue: " + request.getParameter("discountValue"));

			
			// 2. 서비스 호출
			EventService eventService = new EventServiceImpl();
			eventService.applyEvent(form);
			System.out.println("service 객체 클래스: " + eventService.getClass());
			System.out.println("✅ Service 호출 완료");

			// 3. 완료 페이지
			request.getRequestDispatcher("/brand2/eventComplete.jsp").forward(request, response);
			return; // ✅
		} catch (Exception e) {
			e.printStackTrace();
			if (!response.isCommitted()) {
				response.sendRedirect(request.getContextPath() + "/brand2/eventList?error=1");
			} else {
				// 로그만
			}
		}
	}
}
