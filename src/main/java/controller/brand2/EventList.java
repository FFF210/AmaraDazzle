package controller.brand2;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
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

			params.put("status", request.getParameter("status")); // 진행 상황
			// 검색 키워드
			// 검색/필터 파라미터

			// 서비스 호출
			List<dto.brand2.EventList> eventList = eventService.getEventList(params);
			
			// JSP 전달
			request.setAttribute("eventList", eventList);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/brand2/eventList.jsp");
			dispatcher.forward(request, response);
			
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
