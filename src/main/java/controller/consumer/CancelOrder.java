package controller.consumer;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Member;
import service.consumer.OrderService;
import service.consumer.OrderServiceImpl;

/**
 * Servlet implementation class CancelOrder
 */
@WebServlet("/store/cancelOrder")
public class CancelOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CancelOrder() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		try {
			// 세션 체크
			HttpSession session = request.getSession();
			Member loginUser = (Member) session.getAttribute("loginUser");

			if (loginUser == null) {
				response.sendRedirect(request.getContextPath() + "/store/login");
				return;
			}

			// 파라미터 받기
			Long orderItemId = Long.parseLong(request.getParameter("orderItemId"));

			// 취소 처리
			OrderService service = new OrderServiceImpl();
			service.cancelOrderItem(orderItemId);

			// 성공
			response.sendRedirect(request.getContextPath() + "/store/mypage/orderList?cancelSuccess=true");

		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/store/mypage/orderList?cancelFail=true");
		}
	}

}
