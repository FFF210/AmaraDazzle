package controller.brand;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Brand;
import service.brand.OrdersService;
import service.brand.OrdersServiceImpl;

/**
 * Servlet implementation class OrderDetail
 */
@WebServlet("/brand/orderDetail")
public class OrderDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final OrdersService service = new OrdersServiceImpl();

	public OrderDetail() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);

		// 세션 없거나 브랜드 정보 없음 → 로그인 페이지로 리다이렉트
		if (session == null || session.getAttribute("brand") == null) {
			response.sendRedirect(request.getContextPath() + "/brand/login");
			return;
		}

		Brand brand = (Brand) session.getAttribute("brand");
		Long brandId = brand.getBrandId();

		// 파라미터에서 주문 ID 가져오기
		String orderIdParam = request.getParameter("orderId");
		Long orderId = Long.parseLong(orderIdParam);

		try {
			// 주문 상세 데이터(Map 구조: summary, items, coupons)
			Map<String, Object> orderDetail = service.ordersDetail(brandId, orderId);

			// JSP에 전달
			request.setAttribute("orderDetail", orderDetail);
			request.getRequestDispatcher("/brand/orderDetail.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
