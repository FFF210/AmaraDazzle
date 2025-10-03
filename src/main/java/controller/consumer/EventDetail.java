package controller.consumer;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.consumer.EventDetailProduct;
import service.consumer.EventService;
import service.consumer.EventServiceImpl;

/**
 * Servlet implementation class EventDetail
 */
@WebServlet("/store/eventDetail")
public class EventDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private EventService service = new EventServiceImpl();

	public EventDetail() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 파라미터에서 이벤트 ID 가져오기
		String eventIdParam = request.getParameter("eventId");
		Long eventId = Long.parseLong(eventIdParam);

		try {
			dto.consumer.EventDetail eventDetail = service.getEventDetail(eventId);
			List<EventDetailProduct> eventProducts = service.getEventProducts(eventId);

			// JSP에 전달
			request.setAttribute("eventDetail", eventDetail);
			request.setAttribute("eventProducts", eventProducts);

			request.getRequestDispatcher("/consumer/eventDetail.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
