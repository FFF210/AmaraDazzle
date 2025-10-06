package controller.brand;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.brand.OrdersService;
import service.brand.OrdersServiceImpl;

/**
 * Servlet implementation class ReturnDetail
 */
@WebServlet("/brand/returnDetail")
public class ReturnDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final OrdersService service = new OrdersServiceImpl();

	public ReturnDetail() {
		super();
	}

	/**
	 * 반품 상세 조회 (GET)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);

		// 세션 없거나 브랜드 정보 없음 → 로그인 페이지로 리다이렉트
		if (session == null || session.getAttribute("brand") == null) {
			response.sendRedirect(request.getContextPath() + "/brand/login");
			return;
		}

		// 파라미터에서 주문 ID 가져오기
		String returnIdParam = request.getParameter("returnId");
		Long returnId = Long.parseLong(returnIdParam);

		try {
			// (Map 구조: summary, items)
			Map<String, Object> returnDetail = service.returnDetail(returnId);

			// JSP에 전달
			request.setAttribute("returnDetail", returnDetail);
			request.getRequestDispatcher("/brand/returnDetail.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
