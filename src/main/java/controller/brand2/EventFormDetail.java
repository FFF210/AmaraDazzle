package controller.brand2;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.brand2.EventDetail;
import service.brand2.EventService;
import service.brand2.EventServiceImpl;

/**
 * Servlet implementation class EventFormDetaill
 */
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
		Long eventId = Long.parseLong(request.getParameter("eventId")); // 이벤트 id 받기

		try {

			if ("cancel".equals(action)) {

				// ============= 취소 버튼 (아직 미구현) =============

//				Map<String, Object> params = new HashMap<>();
//				params.put("bannerId", Long.parseLong(request.getParameter("bannerId")));
//				params.put("status", "CANCELED");
//
//				service.cancelBanner(params);
//				response.sendRedirect(request.getContextPath() + "/brand2/adbannerList");
//				return;

				// ============= 취소 버튼 =============
				return;
			}

			// ============= 상세보기 버튼 =============

			EventDetail detail = service.getEventDetailById(eventId);
			request.setAttribute("event", detail);
			request.getRequestDispatcher("/brand2/eventFormDetail.jsp").forward(request, response);

			// ============= 상세보기 버튼 =============
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
