package controller.brand2;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.brand2.EventService;
import service.brand2.EventServiceImpl;

/**
 * Servlet implementation class EventList
 */
@WebServlet("/brand2/eventList")
public class EventList extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private EventService eventService;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public EventList() {
		super();
		// TODO Auto-generated constructor stub
	}

	// 서비스 객체 초기화
	@Override
	public void init() throws ServletException {
		eventService = new EventServiceImpl();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		try {
			Long brandId = 1L;

			Map<String, Object> params = new HashMap<>();

			// 페이지네이션
			int page = Integer.parseInt(request.getParameter("page") == null ? "1" : request.getParameter("page"));
			int limit = 10; // 한 페이지당 개수
			int offset = (page - 1) * limit;

			// 이벤트 진행 상황
			params.put("status", request.getParameter("status"));

			// 검색 키워드
			params.put("searchType", request.getParameter("searchType"));
			params.put("searchKeyword", request.getParameter("searchKeyword"));

			// 날짜
			params.put("startDate", request.getParameter("startDate")); // 시작일
			params.put("endDate", request.getParameter("endDate")); // 종료일

			params.put("limit", limit);
			params.put("offset", offset);

			// 서비스 호출
			Map<String, Object> result = eventService.getEventList(params);

			// JSP로 전달
			request.setAttribute("eventList", result.get("eventList")); // 주문 목록
			request.setAttribute("totalCount", result.get("totalCount")); // 총 개수
			request.setAttribute("totalPages", result.get("totalPages")); // 총 페이지 수
			request.setAttribute("currentPage", page); // 현재 페이지

			request.getRequestDispatcher("/brand2/eventList.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "이벤트 목록 조회 오류");
			request.getRequestDispatcher("error.jsp").forward(request, response);
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
