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
 * Servlet implementation class ReturnShip
 */
@WebServlet("/brand/returnShip")
public class ReturnShip extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final OrdersService service = new OrdersServiceImpl();

	public ReturnShip() {
		super();
	}

	/**
	 * 반품 배송(회수) 처리
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");

		Long returnId = Long.valueOf(request.getParameter("returnId"));

		try {
			service.shipReturn(returnId);
			response.getWriter().write("{\"success\": true}");
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().write("{\"success\": false}");
		}
	}

}
