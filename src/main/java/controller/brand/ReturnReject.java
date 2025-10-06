package controller.brand;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.brand.OrdersService;
import service.brand.OrdersServiceImpl;

/**
 * Servlet implementation class ReturnReject
 */
@WebServlet("/brand/returnReject")
public class ReturnReject extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final OrdersService service = new OrdersServiceImpl();

	public ReturnReject() {
		super();
	}

	/**
	 * 반품 거절
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");

		Long returnId = Long.valueOf(request.getParameter("returnId"));
		String reason = request.getParameter("reason");

		try {
			service.rejectReturn(returnId, reason);
			response.getWriter().write("{\"success\": true}");
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().write("{\"success\": false}");
		}
	}

}
