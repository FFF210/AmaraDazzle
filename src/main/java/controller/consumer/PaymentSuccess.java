package controller.consumer;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.consumer.OrderService;
import service.consumer.OrderServiceImpl;

/**
 * Servlet implementation class PaymentSuccess
 */
@WebServlet("/consumer/paymentSuccess")
public class PaymentSuccess extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PaymentSuccess() {
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
			// 1. 토스페이먼츠에서 전달한 파라미터 받기
			String paymentKey = request.getParameter("paymentKey");
			String orderId = request.getParameter("orderId");
			String amount = request.getParameter("amount");

			// 2. 세션에서 회원 정보 확인
			HttpSession session = request.getSession();
			Long memberId = (Long) session.getAttribute("memberId");

			if (memberId == null) {
				response.sendRedirect(request.getContextPath() + "/consumer/login");
				return;
			}

			// 3. OrderService 생성
			OrderService orderService = new OrderServiceImpl();

			// 4. 토스페이먼츠 서버에 결제 승인 요청 (나중에 구현)
			// boolean success = confirmPaymentToToss(paymentKey, orderId, amount);

			// 임시로 성공 처리
			boolean success = true;

			if (success) {
				// 5. 주문 완료 페이지로 리다이렉트
				response.sendRedirect(request.getContextPath() + "/consumer/orderComplete?orderId=" + orderId);
			} else {
				request.setAttribute("err", "결제 승인에 실패했습니다.");
				request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
			}

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "결제 처리 중 오류가 발생했습니다.");
			request.getRequestDispatcher("/consumer/error.jsp").forward(request, response);
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
