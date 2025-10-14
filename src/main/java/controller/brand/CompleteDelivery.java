package controller.brand;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import service.brand.OrdersService;
import service.brand.OrdersServiceImpl;

/**
 * Servlet implementation class CompleteDelivery
 */
@WebServlet("/brand/completeDelivery")
public class CompleteDelivery extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final OrdersService service = new OrdersServiceImpl();

	public CompleteDelivery() {
		super();
	}

	/**
	 * 배송 완료(POST)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json; charset=UTF-8");

		long orderId = Long.parseLong(request.getParameter("orderId"));

		JSONObject json = new JSONObject();

		try {
			service.updateDelivered(orderId);
			json.put("success", true);

		} catch (Exception e) {
			e.printStackTrace();
		}
		response.getWriter().write(json.toString());
	}

}
