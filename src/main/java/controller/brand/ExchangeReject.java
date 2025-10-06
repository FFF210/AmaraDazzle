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
 * Servlet implementation class ExchangeReject
 */
@WebServlet("/brand/exchangeReject")
public class ExchangeReject extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final OrdersService service = new OrdersServiceImpl();

	public ExchangeReject() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");

		Long exchangeId = Long.valueOf(request.getParameter("exchangeId"));
		String reason = request.getParameter("reason");

		try {
			service.rejectExchange(exchangeId, reason);
		} catch (Exception e) {
			e.printStackTrace();
		}

		response.getWriter().write("{\"success\": true}");

	}

}
