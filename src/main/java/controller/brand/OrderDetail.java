package controller.brand;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		try {
			// 파라미터에서 주문 ID 가져오기
			String orderIdParam = request.getParameter("orderId");
			if (orderIdParam == null || orderIdParam.isEmpty()) {
				response.sendError(HttpServletResponse.SC_BAD_REQUEST, "주문 ID가 필요합니다.");
				return;
			}
			Long orderId = Long.parseLong(orderIdParam);

			// 브랜드 ID (세션에서 가져옴)
//			Long brandId = (Long) request.getSession().getAttribute("brandId");
			Long brandId = 1L;

			// 주문 상세 데이터(Map 구조: summary, items, coupons)
			Map<String, Object> orderDetail = service.getOrderDetailForBrand(brandId, orderId);

			// JSP에 전달
			request.setAttribute("orderDetail", orderDetail);
			request.getRequestDispatcher("/brand/orderDetail.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
