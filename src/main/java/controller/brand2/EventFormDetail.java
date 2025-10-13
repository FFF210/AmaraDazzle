package controller.brand2;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Brand;
import dto.brand2.EventDetail;
import service.brand2.EventService;
import service.brand2.EventServiceImpl;

@WebServlet("/brand2/eventFormDetail")
public class EventFormDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final EventService service = new EventServiceImpl();

	public EventFormDetail() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action"); // 상세 or 취소 버튼
		String eventIdParam = request.getParameter("eventId"); // 이벤트 id 받기

		try {

			if ("cancel".equals(action)) {

				// 취소 후 목록으로 이동 (page 유지)
	            String page = request.getParameter("page");
	            if (page == null || page.isEmpty()) {
	                page = "1";
	            }

	            // 쿼리스트링에서 불필요한 cancel 파라미터 제거
	            String queryString = request.getQueryString();
	            if (queryString != null) {
	                queryString = queryString.replaceAll("(&)?action=cancel", "")
	                                         .replaceAll("(&)?eventApplicationId=\\d+", "")
	                                         .replaceAll("(&)?eventId=\\d+", "");
	                if (queryString.startsWith("&")) {
	                    queryString = queryString.substring(1);
	                }
	            }

	            response.sendRedirect(request.getContextPath() + "/brand2/eventList"
	                    + (queryString != null && !queryString.isEmpty() ? "?" + queryString : "?page=" + page));
	            return;
			}

			// ============= 상세보기 버튼 =============
	        if (eventIdParam != null && !eventIdParam.isEmpty()) {
	            Long eventId = Long.parseLong(eventIdParam);
	            
	            HttpSession session = request.getSession(false);
	    		
	    		// 세션 없거나 브랜드 정보 없음 → 로그인 페이지로 리다이렉트
	    		if (session == null || session.getAttribute("brand") == null) {
	    			response.sendRedirect(request.getContextPath() + "/brand/login");
	    			return;
	    		}

	    		Brand brand = (Brand) session.getAttribute("brand");
	    		Long brandId = brand.getBrandId();
	    		
	    		 // 파라미터 맵 구성
                Map<String, Object> params = new HashMap<>();
                params.put("eventId", eventId);
                params.put("brandId", brandId);
	            
	            EventDetail detail = service.getEventDetailById(params);
	            request.setAttribute("event", detail);
	            request.getRequestDispatcher("/brand2/eventFormDetail.jsp").forward(request, response);
	        } else {
	            response.sendRedirect(request.getContextPath() + "/brand2/eventList");
	        }
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/error.jsp");
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
