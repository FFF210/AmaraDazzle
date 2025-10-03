package controller.consumer;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.consumer.EventService;
import service.consumer.EventServiceImpl;

/**
 * Servlet implementation class EventListService
 */
@WebServlet("/store/eventList")
public class EventListController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final EventService service = new EventServiceImpl();

	public EventListController() {
		super();
	}

	/**
	 * 이벤트 목록 조회 (GET)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		// 파라미터 수집
		int page = Integer.parseInt(request.getParameter("page") == null ? "1" : request.getParameter("page"));
		int limit = 9; // 한 페이지당 개수
		int offset = (page - 1) * limit;

		Map<String, Object> params = new HashMap<>();
		params.put("limit", limit);
		params.put("offset", offset);

		try {
			// 서비스 호출
			Map<String, Object> result = service.eventListByPage(params);

			// JSP로 전달
			request.setAttribute("eventList", result.get("eventList")); // 이벤트 목록
			request.setAttribute("totalCount", result.get("totalCount")); // 총 개수
			request.setAttribute("totalPages", result.get("totalPages")); // 총 페이지 수
			request.setAttribute("currentPage", page); // 현재 페이지

			request.getRequestDispatcher("/consumer/eventList.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
