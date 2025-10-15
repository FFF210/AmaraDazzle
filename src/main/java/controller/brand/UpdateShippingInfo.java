package controller.brand;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import service.brand.OrdersService;
import service.brand.OrdersServiceImpl;

/**
 * Servlet implementation class UpdateShippingInfo
 */
@WebServlet("/brand/updateShippingInfo")
public class UpdateShippingInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final OrdersService service = new OrdersServiceImpl();

	public UpdateShippingInfo() {
		super();

	}

	/**
	 * 상품 배송(POST)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json; charset=UTF-8");

		Map<String, Object> params = new HashMap<>();

		long orderId = Long.parseLong(request.getParameter("orderId"));
		String trackingNo = request.getParameter("trackingNo");
		String carrierName = request.getParameter("carrierName");

		params.put("orderId", orderId);
		params.put("trackingNo", trackingNo);
		params.put("carrierName", carrierName);

		JSONObject json = new JSONObject();

		try {
			service.updateShipping(params);

			json.put("success", true);
			json.put("message", "배송 정보가 업데이트되었습니다.");

		} catch (Exception e) {
			e.printStackTrace();
		}

		response.getWriter().write(json.toString());
	}

}
