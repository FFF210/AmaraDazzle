package controller.consumer;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Ticket;
import service.consumer.TicketService;
import service.consumer.TicketServiceImpl;

/**
 * Servlet implementation class TicketDetail
 */
@WebServlet("/store/mypage/ticketDetail")
public class TicketDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public TicketDetail() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		HttpSession session = request.getSession();
		Long userId = (Long) session.getAttribute("memberId");

		if (userId == null) {
			response.sendRedirect(request.getContextPath() + "store/login");
			return;
		}

		try {
			Long ticketId = Long.parseLong(request.getParameter("ticketId"));

			// 서비스 호출
			TicketService service = new TicketServiceImpl();
			Ticket ticket = service.getTicketDetail(ticketId);

			// JSP로 데이터 전달
			request.setAttribute("ticket", ticket);
			request.getRequestDispatcher("/consume/ticketDetail.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "문의 조회 오류");
			request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
		}
	}

}
